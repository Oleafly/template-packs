// PDF target. Handout style on top of the marginalia package.

#import "@preview/marginalia:0.3.1" as marginalia: note, notefigure, wideblock

#let _type-state = state("dual-tufte-type", none)
#let _type() = _type-state.get()

// Turn a style's `typography.print` record into lengths and fill its fallbacks.
#let _resolve(p) = {
    let B = p.body.size
    let L = p.body.line
    let units = (size: B, left: B, right: B, indent: B, body-indent: B, line: L, before: L, after: L, par: L)
    p.caption = p.note + p.caption
    let out = (:)
    for (k, r) in p {
        for (f, u) in units {
            if type(r.at(f, default: none)) in (int, float) { r.insert(f, r.at(f) * u) }
        }
        if "font" not in r { r.font = p.body.font }
        out.insert(k, r)
    }
    out
}

// Line boxes are one em tall: 0.8em above the baseline, 0.2em below.
#let _top = 0.8
#let _bottom = 0.2

// Block gap that puts baselines `d` apart, from size `a` to size `b`.
#let _gap(d, a, b) = d - _bottom * a - _top * b

#let _leading(r) = r.line - r.size

// Block with baselines `r.before` and `r.after` from the body text.
#let _role-block(t, r, ..args, body) = block(
    above: _gap(r.before, t.body.size, r.size),
    below: _gap(r.after, r.size, t.body.size),
    ..args,
    { set par(leading: _leading(r)); body },
)

#let _text-style(r) = (size: r.size, font: r.font, style: r.style)

// Sidenote number: a body-font superscript, then `sep`.
#let _sn-mark(t, size, sep: 0pt) = (..i) => [#super(
    typographic: false,
    baseline: -0.5em,
    size: size,
    text(font: t.body.font, number-type: "lining", numbering("1", ..i.pos())),
)#h(sep)]

#let sidenote(numbered, dy, body) = context {
    let t = _type()
    let kw = if numbered {
        (numbering: _sn-mark(t, t.marks.margin, sep: t.note.sep), anchor-numbering: _sn-mark(t, t.marks.anchor))
    } else {
        (counter: none,)
    }
    note(
        dy: dy,
        text-style: _text-style(t.note),
        // Note paragraphs sit apart by the same ratio as body paragraphs.
        par-style: (leading: _leading(t.note), spacing: t.body.par / t.body.line * t.note.line - t.note.size),
        ..kw,
    )[#body]
}

#let margin-figure(content, caption, dy) = context {
    let t = _type()
    notefigure(
        content,
        caption: caption,
        dy: dy,
        counter: none,
        text-style: _text-style(t.caption),
        par-style: (leading: _leading(t.caption)),
    )
}

#let _quote(t, body, attribution) = {
    let q = t.quote
    _role-block(t, q, inset: (left: q.left, right: q.right), {
        set text(.._text-style(q))
        body
        if attribution != none {
            linebreak()
            align(right)[#text(style: "normal", size: t.caption.size, [— ] + attribution)]
        }
    })
}

#let epigraph(quote, author) = context _quote(_type(), quote, author)

// Synthetic small-caps. Typst's `smallcaps()` no-ops on fonts without
// smcp glyphs (typst#7009, open). Uppercase the lowercase runs and
// shrink them so original capitals retain body size.
#let new-thought(body) = context {
    let lower = _type().newthought.lower
    show regex("\p{Ll}+"): m => text(size: lower * 1em, upper(m.text))
    body
}

#let full-width(body) = wideblock(side: "outer", body)

#let _running-header(title, cfg, t) = {
    let r = t.header
    set text(size: r.size, weight: r.weight, tracking: r.track, font: r.font)
    // Extend over the margin column to the page right edge.
    let push = -(cfg.margin-col.width + cfg.margin-col.sep)
    pad(right: push, align(right, if r.upper { upper(title) } else { title }))
    v(r.after)
}

#let _title-block(doc, t) = {
    if doc.title == none { return }
    let (ti, m, B) = (t.title, t.meta, t.body.size)
    let gap = if doc.meta.len() > 0 { _gap(ti.after, ti.size, m.size) } else { _gap(m.after, ti.size, B) }
    set par(first-line-indent: 0em, justify: false)
    block(below: gap, {
        set par(leading: _leading(ti))
        text(font: ti.font, weight: ti.weight, size: ti.size)[#h(ti.kern)#doc.title]
    })
    if doc.meta.len() > 0 {
        block(above: gap, below: _gap(m.after, m.size, B),
            text(font: m.font, style: m.style, size: m.size, doc.meta.join([ #h(m.sep)])))
    }
}

#let setup(cfg, doc, body) = {
    let t = _resolve(cfg.typography.print)
    _type-state.update(t)

    let (margin-x, margin-y, paper, ..size) = cfg.page
    let bg = cfg.colors.bg
    set page(
        paper: paper,
        ..size,
        fill: if bg != none { rgb(bg) },
        // A scroll page (height: auto) has no running header.
        header: if doc.title != none and size.at("height", default: none) != auto {
            _running-header(doc.title, cfg, t)
        },
    )

    show: marginalia.setup.with(
        inner: (far: margin-x, width: 0pt, sep: 0pt),
        outer: (far: margin-x, width: cfg.margin-col.width, sep: cfg.margin-col.sep),
        top: margin-y,
        bottom: margin-y,
        book: false,
    )

    // Hyphenation explicit so it survives a custom `lang:`. Typst has no
    // microtype-equivalent (typst#638).
    set text(
        font: t.body.font,
        size: t.body.size,
        top-edge: _top * 1em,
        bottom-edge: -_bottom * 1em,
        fill: rgb(cfg.colors.fg),
        hyphenate: true,
    )
    let par-gap = _gap(t.body.par, t.body.size, t.body.size)
    set par(
        leading: _leading(t.body),
        spacing: par-gap,
        first-line-indent: t.body.indent,
        justify: cfg.text.justify,
    )
    set block(spacing: par-gap)
    set list(indent: t.list.indent, body-indent: t.list.body-indent)
    set enum(indent: t.list.indent, body-indent: t.list.body-indent)
    show selector.or(enum, list): set par(justify: true)
    // Footnotes render as sidenotes; hide the page-bottom listing.
    set footnote.entry(separator: [], clearance: 0pt, gap: 0pt)
    show footnote.entry: hide
    show footnote: it => sidenote(true, 0pt, it.body)

    show link: it => {
        set text(fill: rgb(cfg.colors.link))
        if cfg.link.underline { underline(it) } else { it }
    }

    set math.equation(numbering: "(1)")
    set raw(theme: none)
    // Typst scales raw text by 0.8em; an absolute size replaces the scale.
    let raw-scale = 0.8
    let c = t.code
    show raw.where(block: false): set text(font: c.font, size: c.inline / raw-scale * 1em)
    show raw.where(block: true): it => _role-block(t, c, inset: (left: c.left, right: c.right), {
        set text(font: c.font, size: c.size)
        it
    })

    show quote.where(block: true): it => _quote(t, it.body, it.attribution)

    show figure.caption: it => {
        set align(left)
        set text(.._text-style(t.caption))
        set par(leading: _leading(t.caption))
        it
    }

    show heading: it => {
        let r = t.at("h" + str(it.level), default: none)
        if r == none { return it }
        _role-block(t, r, sticky: true, {
            set par(first-line-indent: 0em, justify: false)
            set text(font: r.font, weight: r.weight, style: r.style, size: r.size)
            h(r.kern)
            it.body
        })
    }

    _title-block(doc, t)
    if doc.abstract != none {
        set par(first-line-indent: 0em)
        text(size: t.caption.size, style: "italic", doc.abstract)
        v(cfg.abstract.v-after)
    }
    if doc.toc {
        outline(title: cfg.toc.title, indent: auto, depth: cfg.toc.depth)
        v(cfg.toc.v-after)
    }
    body
}
