// HTML target. Emits canonical tufte-css markup.
// Reference: https://edwardtufte.github.io/tufte-css/ (1.8.0).

#let _id-counter = counter("dual-tufte-id")

#let _in-frame = state("dual-tufte-in-frame", false)

// A block element inside the note <span> closes the enclosing <p> and drops
// the note into the main column, so blocks become block-level spans.
// Figures, code blocks and block math split the paragraph before any show
// rule runs; they stay unsupported.
#let _note-body(body) = {
    let div(style: "", body) = html.elem("span", attrs: (("style"): "display: block; " + style))[#body]
    show parbreak: div(style: "height: 0.6rem;")[]
    show enum: it => {
        let n = if it.start == auto { 0 } else { it.start - 1 }
        for item in it.children {
            let given = item.at("number", default: auto)
            n = if given == auto { n + 1 } else { given }
            div[#numbering(it.numbering, n) #item.body]
        }
    }
    show list: it => for item in it.children { div[#sym.bullet #item.body] }
    show align: it => div(style: if it.alignment.x == none { "" } else { "text-align: " + repr(it.alignment.x) + ";" })[#it.body]
    body
}

// label, input and note span stay adjacent siblings: tufte-css toggles
// the note with `.margin-toggle:checked + .sidenote`.
#let sidenote(numbered, dy, body) = {
    let (prefix, class, label-class, glyph) = if numbered {
        ("sn-", "sidenote", "margin-toggle sidenote-number", "")
    } else {
        ("mn-", "marginnote", "margin-toggle", "⊕")
    }
    context {
        _id-counter.step()
        let id = prefix + str(_id-counter.get().first())
        html.elem("label", attrs: (("for"): id, ("class"): label-class))[#glyph]
        html.elem("input", attrs: (("type"): "checkbox", ("id"): id, ("class"): "margin-toggle"))[]
    }
    html.elem("span", attrs: (("class"): class))[#_note-body(body)]
}

#let margin-figure(content, caption, dy) = sidenote(false, dy, {
    box[#content]
    if caption != none { html.elem("span", attrs: (("class"): "figure-caption"))[#caption] }
})

#let _blockquote(body, attribution) = html.elem("blockquote")[
    #html.p(body)
    #if attribution != none { html.elem("footer")[#attribution] }
]

#let epigraph(quote, author) = html.elem("div", attrs: (("class"): "epigraph"))[#_blockquote(quote, author)]

// The inner small-caps span keeps small caps without the tufte stylesheet.
#let new-thought(body) = html.elem("span", attrs: (("class"): "newthought"))[
    #html.elem("span", attrs: (("style"): "font-variant-caps: small-caps"))[#body]
]

#let full-width(body) = html.elem("div", attrs: (("class"): "fullwidth"))[#body]

// Fixes on top of tufte-css: captions sit under the figure as in the PDF
// target instead of floating into the margin; h1..h3 get the column width
// so a heading sidenote lands in the margin; h4/h5 rules tufte-css lacks.
#let _tufte-fixes = ```css
figcaption { float: none; clear: both; max-width: 100%; margin: 0.4rem 0 0; }
div.fullwidth > figure { max-width: 100%; }
div.fullwidth > table { width: 100%; }
img { height: auto; }
.figure-caption { display: block; margin-top: 0.4rem; }
.typst-frame use { fill: currentColor; }
p.equation { text-align: center; position: relative; }
p.equation > .equation-number { position: absolute; right: 0; top: 50%; transform: translateY(-50%); }
article h1, article h2, article h3 { max-width: 55%; }
h4, h5 { font-style: italic; font-weight: 400; line-height: 2rem; margin-top: 2rem; margin-bottom: 0; }
h4 { font-size: 1.4rem; }
h5 { font-size: 1.2rem; }
```.text

// tufte-css draws link underlines with a background gradient and a text
// shadow tuned for et-book; replace both with a plain underline.
#let _link-css = ```css
a:link, a:visited { color: var(--link); text-shadow: none; background-image: none; text-decoration: none; text-decoration-skip-ink: auto; text-underline-offset: 0.15em; }
a:hover { text-decoration: underline; }
```.text

#let _overlay-css = ```css
html, body { background-color: var(--bg); }
body { color: var(--fg); }
h1, h2, h3, h4, h5, h6, .subtitle, .newthought { color: var(--heading, var(--fg)); font-style: normal; }
.subtitle { color: var(--meta, var(--heading, var(--fg))); }
.sidenote, .marginnote, .sidenote-number, figcaption { font-style: normal; color: var(--note, var(--fg)); }
article blockquote, article blockquote p { color: var(--quote); }
article blockquote footer { overflow-wrap: anywhere; }
.subtitle + p { margin-top: 2.5em; }
p + h2 { margin-top: 5.5rem; }
article p.subtitle { width: 65%; }
pre { overflow-x: auto; padding: 0.75em 1em; }
pre code, pre code span { font-size: inherit; line-height: inherit; }
@media (max-width: 760px), (orientation: portrait) {
  html, body, article, section { max-width: 100vw !important; min-width: 0 !important; overflow-x: hidden; box-sizing: border-box; }
  html, section { width: 100% !important; }
  body, article { width: auto !important; margin: 0 !important; }
  body { padding: 0 !important; }
  article { padding: 2rem 1.25rem !important; }
  article * { max-width: 100% !important; min-width: 0 !important; box-sizing: border-box; overflow-wrap: anywhere; word-break: normal; }
  article > h1, article p.subtitle, article section > h1, article h2, article h3, article p, article ol, article ul, article blockquote, article pre { width: 100% !important; }
  figcaption { width: 100% !important; margin: 0.75rem 0; }
  article > h1 { margin-top: 2rem !important; }
  article blockquote { margin: 2rem 0 !important; padding: 0 !important; }
  article blockquote p { margin: 0 0 0.7rem 0 !important; }
  article blockquote footer { width: 100% !important; text-align: left !important; }
}
```.text

// Style CSS from `cfg.colors` and `cfg.html`. Colours are CSS variables,
// so `html.extra` can use `var(--accent)`.
#let _style-css(cfg) = {
    let vars = for (k, v) in cfg.colors { if v != none { "--" + k + ": " + v + "; " } }
    let overlay = cfg.html.overlay
    let css = (
        ":root { " + vars + "}\n"
        + if overlay == "full" { _overlay-css } else { "" }
        + if overlay in ("full", "links") { _link-css } else { "" }
        + if overlay != none and cfg.link.underline { "a:link, a:visited { text-decoration: underline; }\n" } else { "" }
    )
    css + cfg.html.extra
}

// Type CSS from a style's `typography.web` record.
// `repr` writes an ASCII minus; `str` writes U+2212, which CSS rejects.
#let _px(v) = repr(v) + "px"
// Size pair (a, b): a at a 375px window, b at 1440px, linear between.
#let _css-size(v) = if type(v) == array {
    let (a, b) = v
    let (lo, hi) = (375, 1440)
    let k = (b - a) / (hi - lo)
    "clamp(" + _px(a) + ", calc(" + _px(calc.round(a - lo * k, digits: 3)) + " + " + repr(calc.round(100 * k, digits: 4)) + "vw), " + _px(b) + ")"
} else { _px(v) }
#let _css-line(v) = if type(v) == float { repr(v) } else { _px(v) }

#let _css-props = (
    font: ("font-family", v => v),
    style: ("font-style", v => v),
    weight: ("font-weight", repr),
    size: ("font-size", _css-size),
    line: ("line-height", _css-line),
    track: ("letter-spacing", v => repr(v) + "em"),
    before: ("margin-top", _px),
    after: ("margin-bottom", _px),
    inline: ("font-size", v => repr(v) + "em"),
)
#let _rule(sel, r) = {
    let decls = for (k, v) in r {
        let (prop, css) = _css-props.at(k)
        prop + ": " + css(v) + "; "
    }
    if decls == none { "" } else { sel + " { " + decls + "} " }
}

// A role's selector, or a map from field to selector with `rest` for the
// other fields.
#let _type-selectors = (
    body: (font: "body", rest: "p, dl, ol, ul, div.fullwidth"),
    code: (
        font: "code, pre, .code, kbd, samp",
        inline: "code, .sidenote > code, .marginnote > code",
        rest: "pre, pre > code",
    ),
    note: ".sidenote, .marginnote, figcaption, .figure-caption",
    quote: "article blockquote, article blockquote p",
    title: "article > h1",
    meta: "article p.subtitle",
    h1: "article section > h1",
    h2: "article h2",
    h3: "article h3",
    newthought: ".newthought",
)

#let _type-css(w) = {
    let css = ""
    for (role, sels) in _type-selectors {
        let r = w.at(role, default: (:))
        if type(sels) == str { sels = (rest: sels) }
        for (field, sel) in sels {
            let part = if field == "rest" { r } else if field in r { ((field): r.remove(field)) } else { (:) }
            css += _rule(sel, part)
        }
    }
    css
}

#let _heading-slug(idx) = "h-" + str(idx + 1)

#let _toc() = context {
    let hs = query(heading)
    if hs.len() == 0 { return }
    html.elem("nav", attrs: (("class"): "toc"))[
        #html.elem("h2")[Contents]
        #html.elem("ul", attrs: (("style"): "list-style: none; padding-left: 0;"))[
            #for (i, h) in hs.enumerate() {
                let indent = str((h.level - 1) * 1.2) + "rem"
                html.elem("li", attrs: (("style"): "margin-left: " + indent))[
                    #html.elem("a", attrs: (("href"): "#" + _heading-slug(i)))[#h.body]
                ]
            }
        ]
    ]
}

#let _title-block(doc) = {
    if doc.title != none { html.elem("h1")[#doc.title] }
    if doc.meta.len() > 0 {
        html.elem("p", attrs: (("class"): "subtitle"))[#doc.meta.join(", ")]
    }
}

#let setup(cfg, doc, body) = {
    let body-section = html.elem("section")[
        #set text(fill: rgb(cfg.colors.fg))
        #set math.equation(numbering: "(1)")
        #set raw(theme: none)
        #show heading: it => context {
            let idx = query(heading).position(h => h.location() == it.location())
            let tag = "h" + str(it.level)
            html.elem(tag, attrs: (("id"): _heading-slug(idx)))[#it.body]
        }
        // typst/typst#5512: no native MathML emit; inline SVG via html.frame.
        // The <p> gives the equation the paragraph type size and centres it
        // as in the PDF target. The frame lays out an unnumbered copy; the
        // original element steps the counter and carries the label.
        #show math.equation: it => context if _in-frame.get() { it } else if it.block {
            html.elem("p", attrs: (("class"): "equation"))[#box(html.frame({
                _in-frame.update(true)
                math.equation(block: true, numbering: none, it.body)
                _in-frame.update(false)
            }))#if it.numbering != none {
                html.elem("span", attrs: (("class"): "equation-number"))[#counter(math.equation).display(it.numbering)]
            }]
        } else { box(html.frame(it)) }

        #show footnote: it => sidenote(true, 0pt, it.body)
        // Typst's `line()` has no HTML form; emit <hr/>.
        #show line: it => html.elem("hr")[]
        #show quote: it => _blockquote(it.body, it.attribution)

        #body
    ]

    html.elem("html", attrs: (("lang"): doc.lang))[
        #html.elem("head")[
            #html.elem("meta", attrs: (("charset"): "utf-8"))[]
            #html.elem("meta", attrs: (("name"): "viewport", ("content"): "width=device-width, initial-scale=1"))[]
            #html.elem("meta", attrs: (("name"): "color-scheme", ("content"): cfg.html.color-scheme))[]
            #html.elem("title")[#if doc.title != none { doc.title } else { "Document" }]
            #for href in cfg.html.css + cfg.html.sheets {
                html.elem("link", attrs: (("rel"): "stylesheet", ("href"): href))[]
            }
            // Type CSS last, so it wins on source order.
            #html.elem("style")[#(_tufte-fixes + _style-css(cfg) + _type-css(cfg.typography.web))]
        ]
        #html.elem("body")[
            #html.elem("article", {
                _title-block(doc)
                if doc.abstract != none { html.elem("p")[#doc.abstract] }
                if doc.toc { _toc() }
                body-section
            })
        ]
    ]
}
