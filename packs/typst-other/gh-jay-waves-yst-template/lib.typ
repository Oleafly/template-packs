/// Shared document theme and typesetting helpers.
///
/// Common imports and usage (adjust the path relative to your document):
/// ```typst
/// #import "../appx/theme.typ": template, sidenote, theorem, lemma, corollary,
///   definition, proof, fletcher, diagram, node, edge,
///   equate-lines, physica
/// #show: template.with(theme: "light", layout: "portrait")
/// #set document(title: "Notes", keywords: ("robotics",))
/// ```
///
/// Feature index:
/// - `template(theme: "light", layout: "portrait", body)`: page layout and styling.
/// - `sidenote(body, aside, side-image: none)`: body with a right-hand sidenote and optional image.
/// - `theorem` / `lemma` / `corollary`: theorem, lemma, and corollary environments.
/// - `definition` / `proof`: definition and proof environments.
/// - `diagram(..args)`: theme-aware Fletcher diagrams with the native API.
/// - `fletcher` / `node` / `edge`: the Fletcher module and native primitives.
/// - `equate-lines(body, ...)`: multiline equations with chapter numbers and lettered subnumbers.
/// - `physica`: physics utilities module; use `physica.xxx`.
///
/// HTML export: `typst compile --features html path/to/note.typ note.html`.
/// The recommended interfaces are listed above; other top-level names remain importable.

#import "@preview/ctheorems:1.1.3": (
    thmbox as _thm_box,
    thmplain as _thm_plain,
    thmproof as _thm_proof,
    thmrules as _thm_rules,
)
#import "@preview/physica:0.9.8" as physica
#import "@preview/fletcher:0.5.8" as fletcher
#import "@preview/equate:0.3.3": equate as _equate
#import "html.typ" as _html

#assert(
    sys.version >= version(0, 15, 0),
    message: "This theme requires Typst 0.15.0 or newer.",
)

#let _code_fonts = (
    "Fira Code",
    "Cascadia Mono",
    // Explicit CJK fallback keeps comments and string literals visually
    // consistent instead of depending on the platform's default fallback.
    "Source Han Sans",
    "Courier New",
)

// Each role owns both script paths; weights are (regular, strong).
#let _typography = (
    body: (
        latin: (font: ("Libertinus Serif", "Source Han Serif"), weights: (400, 700)),
        cjk: (font: ("Source Han Serif"), weights: (500, 800)),
    ),
    heading: (
        latin: (font: ("Noto Sans", "Libertinus Sans", "Source Han Sans"), weights: (600, 800)),
        cjk: (font: ("Source Han Sans"), weights: (600, 800)),
    ),
    code: (
        latin: (font: _code_fonts, weights: (400, 700)),
        cjk: (font: ("Source Han Sans"), weights: (400, 700)),
    ),
    table: (
        latin: (font: ("Libertinus Serif", "Source Han Serif"), weights: (450, 700)),
        cjk: (font: ("Source Han Serif"), weights: (500, 800)),
    ),
)

// Chinese typography, including full-width punctuation. This is deliberately
// not a claim to cover Japanese kana or Korean hangul.
// Single curly quotes also serve as English apostrophes; keep them in the Latin font.
#let _cjk_text = regex("[\\p{Han}、，。！？；：“”《》「」『』（）【】〔〕〈〉…—]")

#let _script_text(profile, bold, body) = text(
    font: profile.font,
    weight: profile.weights.at(int(bold)),
    body,
)

#let _font_size = (
  tiny: 6.5pt,
  code: 6pt,
  body: 8pt,
  // Match the HTML heading scale: 1.4x / 1.2x / 1.1x of body text.
  h1: 11.2pt,
  h2: 9.6pt,
  h3: 8.8pt,
)

#let _palette(theme) = {
    assert(
        theme in ("light", "dark"),
        message: "The theme must be either \"light\" or \"dark\".",
    )
    let dark = theme == "dark"
    (
        fg: if dark { rgb("#c9cdd2") } else { rgb("#26282b") },
        bg: if dark { rgb("#1e1e1e") } else { white },
        muted: if dark { rgb("#a0a5ad") } else { rgb("#62666b") },
        border: if dark { rgb("#50555d") } else { rgb("#cbd0d5") },
        border-muted: if dark { rgb("#50555db3") } else { rgb("#cbd0d5b3") },
        accent: if dark { rgb("#dde0e4") } else { rgb("#202326") },
        accent-2: if dark { rgb("#bfc5cd") } else { rgb("#4b5157") },
        code-fg: if dark { rgb("#c3c9d1") } else { rgb("#33373b") },
        pre-bg: if dark { rgb("#2d3035") } else { rgb("#f6f7f8") },
        code-bg: if dark { rgb("#2d3035cc") } else { rgb("#f6f7f8cc") },
    )
}

// Components are evaluated contextually so one template configuration also
// controls diagrams, sidenotes, and theorem environments.
#let _theme = state("ypst-template.theme", "light")

// Keep opening punctuation with the following Han glyph and closing
// punctuation with the preceding one. Each match remains small enough for
// normal CJK line breaking while avoiding punctuation stranded at line edges.
#let _cjk_emph_chunk = regex(
    "[‘“《「『（【〔〈]*\\p{Han}[、，。！？；：’”）》」』】〕〉…—]*"
)

// Semantic modifiers re-enter the same role, preserving bold + emphasis in
// either nesting order. Only CJK emphasis needs a geometric transformation.
#let _typeset(role, bold: false, italic: false, heading-cjk-size: 0.94em, body) = {
    let profile = _typography.at(role)
    set text(style: ("normal", "italic").at(int(italic)))
    show strong: it => _typeset(role, bold: true, italic: italic, heading-cjk-size: heading-cjk-size, it.body)
    show emph: it => _typeset(role, bold: bold, italic: true, heading-cjk-size: heading-cjk-size, it.body)
    show _cjk_text: set text(
        font: profile.cjk.font,
        weight: profile.cjk.weights.at(int(bold)),
        size: if role == "heading" { heading-cjk-size } else { 1em },
    )
    if italic {
        show _cjk_emph_chunk: chunk => {
            set text(style: "normal")
            box(skew(ax: -12deg, reflow: false,
                _script_text(profile.cjk, bold, chunk)))
        }
        _script_text(profile.latin, bold, body)
    } else {
        _script_text(profile.latin, bold, body)
    }
}

// Re-export Fletcher's node and edge primitives unchanged.
#let node = fletcher.node
#let edge = fletcher.edge

/// Fletcher's native diagram interface with theme-aware defaults.
/// Explicit call-site options override the injected defaults.
#let diagram(..args) = context {
    let palette = _palette(_theme.get())
    align(center, {
        set text(
            font: _typography.body.latin.font,
            size: _font_size.tiny,
            fill: palette.fg,
        )

        fletcher.diagram.with(
            spacing: 3em,
            node-fill: palette.pre-bg,
            node-stroke: 0.5pt + palette.border,
            edge-stroke: 0.55pt + palette.muted,
        )(..args)
    })
}

/// Body with a right-hand sidenote: `#sidenote[Body][Aside]`; `side-image` accepts an image path or content.
#let _sidenote_content(content) = context {
    let equation-position = counter(math.equation).get()
    show math.equation: set math.equation(numbering: none)
    content
    counter(math.equation).update(equation-position)
}

#let sidenote(body, aside, side-image: none) = context {
    let palette = _palette(_theme.get())
    let aside-text = if aside == [] {
        none
    } else {
        block(
            width: 100%,
            text(size: _font_size.tiny, aside),
        )
    }
    let aside-content = if side-image == none {
        aside-text
    } else {
        let pinned-image = if type(side-image) == str {
            image(side-image, width: 100%)
        } else {
            block(width: 100%, {
                show image: set image(width: 100%)
                side-image
            })
        }

        if aside-text == none {
            block(width: 100%, pinned-image)
        } else {
            stack(
                dir: ttb,
                spacing: 0.6em,
                block(width: 100%, pinned-image),
                aside-text,
            )
        }
    }

    let rendered-aside = _sidenote_content(aside-content)
    _html.when-html(
        () => _html.sidenote(body, rendered-aside),
        () => block(
            width: 100%,
            breakable: true,
            grid(
                columns: (3fr, 1fr), // body-ratio : aside-ratio
                column-gutter: 4%,
                align: top + left,
                block(width: 100%, body),
                block(
                    width: 100%,
                    inset: (left: 0.75em),
                    stroke: (left: 0.5pt + palette.border),
                    rendered-aside,
                ),
            ),
        ),
    )
}

/// Theorem environment: `#theorem[Theorem content]`.
#let theorem(..args, body) = context {
    let palette = _palette(_theme.get())
    _thm_box(
        "theorem", "定理", supplement: [Thm.], titlefmt: strong,
        fill: palette.pre-bg, stroke: 0.4pt + palette.border, radius: 3pt,
    )(..args, body)
}

/// Lemma environment: `#lemma[Lemma content]`.
#let lemma(..args, body) = context {
    let palette = _palette(_theme.get())
    _thm_box(
        "lemma", "引理", supplement: [Lemma], titlefmt: strong,
        fill: palette.pre-bg, stroke: 0.4pt + palette.border, radius: 3pt,
    )(..args, body)
}

/// Corollary environment: `#corollary[Corollary content]`.
#let corollary(..args, body) = {
    _thm_plain("corollary", "推论", supplement: [Cor.], titlefmt: strong)(..args, body)
}

/// Definition environment: `#definition[Definition content]`.
#let definition(..args, body) = context {
    let palette = _palette(_theme.get())
    _thm_box(
        "definition", "定义", supplement: [Def.],
        fill: palette.pre-bg, stroke: 0.4pt + palette.border, radius: 3pt,
    )(..args, body)
}

#let _proof_env = _thm_proof(
    "proof", "证明", 
    titlefmt: strong, 
    inset: (top: 0em, left: 0pt, bottom: 0em, right: 0pt)
)

/// Proof environment: `#proof[Proof content]`; automatically adds a QED symbol.
#let proof(..args, body) = {
    _proof_env(..args, body)
    linebreak()
}

// Chapter-prefixed numbering shared by figures, tables, and equations.
#let _chapter_numbering(parenthesized, styled, number, ..sub) = context {
    let palette = _palette(_theme.get())
    let chapter = counter(heading).get().first()
    let suffix = if sub.pos().len() > 0 { numbering("a", sub.pos().first()) } else { "" }
    let value = str(chapter) + "." + str(number) + suffix
    let value = if parenthesized { "(" + value + ")" } else { value }

    if not styled {
        value
    } else {
    // Keep serif letterforms while reserving equal space for each sub-number letter.
        show regex("[a-z]+"): it => {
            it.text.clusters().map(letter => box(width: 0.55em, align(center, letter))).join()
        }
        text(
            // Equation numbers use the math family so their numerals match
            // the symbols beside them; figure and table numbers keep body text.
            font: if parenthesized { "Libertinus Math" } else { _typography.body.latin.font },
            size: _font_size.body,
            fill: palette.muted,
            number-type: "lining",
            number-width: "tabular",
            value,
        )
    }
}

#let _equation_numbering = _chapter_numbering.with(true, true)
#let _figure_numbering = _chapter_numbering.with(false, false)

/// Multiline equations with chapter numbers and lettered subnumbers; disable with `sub-numbering: false`.
/// Label each line with `#<label>` before its line break.
#let equate-lines(
    body,
    numbering: _equation_numbering,
    sub-numbering: true,
    ..options,
) = {
    set math.equation(numbering: if numbering == auto { _equation_numbering } else { numbering })
    _equate(body, sub-numbering: sub-numbering, ..options)
}

// Paged output is the core renderer. HTML-specific compatibility rules and
// package asset injection live in html.typ.
#let _paged_template(theme, layout, body) = context {
    let palette = _palette(theme)
    let landscape = layout == "landscape"
    let page-columns = if landscape { 2 } else { 1 }

    set heading(numbering: (..numbers) => {
        if numbers.pos().len() <= 3 {
            numbering("1.1", ..numbers)
        }
    })
    set footnote(numbering: "[a]")

    set math.equation(numbering: _equation_numbering, supplement: [Eq.])
    set heading(supplement: [Sec.])
    show figure.where(kind: image): set figure(supplement: [Fig.], numbering: _figure_numbering)
    show figure.where(kind: table): set figure(supplement: [Tab.], numbering: _figure_numbering)
    show ref: it => context {
        // Resolve the chapter at the target, including equate's per-line figures.
        let target = it.element
        if it.form == "normal" and target != none and target.has("numbering") and target.numbering == _equation_numbering {
            let chapter = counter(heading).at(target.location()).first()
            // The numbering function also runs inside refs; restore the surrounding text style.
            let ref-size = text.size
            let ref-font = text.font
            let ref-fill = text.fill
            show regex("\\([0-9]+\\.[0-9]+[a-z]*\\)"): match => {
                text(
                    font: ref-font,
                    size: ref-size,
                    fill: ref-fill,
                    str(chapter) + "." + match.text.slice(1, -1).split(".").last(),
                )
            }
            _equate(it)
        } else {
            _equate(it)
        }
    }

    set page(
        paper: "a5",
        flipped: landscape,
        columns: page-columns,
        fill: palette.bg,
        margin: (y: 2.25em, x: 1.8em),
        header: counter(footnote).update(0),
        foreground: if landscape {
            place(
                center + horizon,
                rect(
                    width: 0.55pt,
                    height: 100% - 6em,
                    fill: palette.border-muted,
                ),
            )
        },
    )
    set columns(gutter: 4%)

    show link: set text(fill: palette.accent-2)
    show link: underline

    // Set the body fallback without styling heading contents before their own show rule.
    set text(font: _typography.body.latin.font)

    let paragraph-leading = 0.8em
    // Match theme.css's 1rem block margin more closely at the compact body
    // size used by the paged template.
    let block-spacing = 1.4em
    set par(
        leading: paragraph-leading,
        spacing: block-spacing,
    )
    show heading: it => context {
        if it.level == 1 and it.numbering != none {
            counter(math.equation).update(0)
        }
        let level = calc.min(it.level, 3)
        let size = if it.level >= 4 {
            _font_size.body
        } else { (
            _font_size.h1,
            _font_size.h2,
            _font_size.h3,
        ).at(level - 1) }

        show: _typeset.with("heading", heading-cjk-size: size * 94%)

        set text(
            size: size,
            fill: palette.accent,
        )

        v((24pt, 18pt, 16pt).at(level - 1), weak: true)

        if it.numbering != none and it.level <= 3 {
            counter(heading).display(it.numbering)
            h(7pt, weak: true)
        }

        it.body

        if level <= 2 {
            v(5pt, weak: true)
            line(length: 100%, stroke: 0.35pt + palette.border-muted)
        }

        v(12pt, weak: true)
    }

    set text(
        fill: palette.fg,
        size: _font_size.body,
        number-type: "old-style",
        number-width: "tabular",
    )
    show figure: fig => {
        show figure.caption: caption => context [
            *#caption.supplement~#numbering(
                caption.numbering,
                ..caption.counter.at(fig.location()),
            )#h(1em)*#caption.body
        ]
        block(
            above: block-spacing,
            below: block-spacing,
            fig,
        )
    }
    show figure.caption: set text(size: _font_size.tiny)

    show: _thm_rules.with(qed-symbol: $square$)

    // code block
    show raw.where(block: true): it => {
        show: _typeset.with("code")
        let language = it.lang
        set text(
            size: _font_size.code,
            fill: palette.code-fg,
        )
        // Keep code lines compact; tie outer spacing to the surrounding prose.
        set par(leading: 0.6em, spacing: 0.6em)
        let code-spacing = _font_size.body

        block(
            width: 100%,
            above: code-spacing,
            below: code-spacing,
            inset: (x: 1em, y: 0.9em),
            radius: 2pt,
            fill: palette.code-bg,
            [
                #if language != none {
                    place(
                        top + right,
                        dx: -1em,
                        // Keep the label on the first code-line baseline.
                        dy: 0.05em,
                        text(
                            size: _font_size.code,
                            weight: 500,
                            fill: palette.muted,
                        )[ #language ],
                    )
                }
                // Raw blocks preserve long source lines. Do not wrap, scale,
                // or otherwise reshape them; Typst can report width overflow.
                #it
            ],
        )
    }

    // inline code
    show raw.where(block: false): it => _typeset("code", box(
        inset: (x: 0.42em, y: 0.18em),
        radius: 2.5pt,
        fill: palette.code-bg,
        text(
            fill: palette.code-fg,
            it,
        ),
    ))

    // Keep quotes visually quiet and separate from surrounding paragraphs.
    show quote: it => block(
      width: 100%,
      above: block-spacing,
      below: block-spacing,
      inset: (left: 0.9em, right: 0pt, top: 0.2em, bottom: 0.2em),
      stroke: (left: 1pt + palette.border-muted),
    )[
        #text(fill: palette.muted)[
            #it.body

            #if it.attribution != none [
                #v(0.45em)
                #align(
                    right,
                    text(
                        size: _font_size.tiny,
                        fill: palette.muted,
                    )[
                        — #it.attribution
                    ],
                )
            ]
        ]
    ]

    set table(
        // Match the Markdown table rhythm: generous horizontal padding and
        // horizontal rules only, with no vertical grid lines.
        inset: (x: 1.25em, y: 0.7em),
        fill: (x, y) => if y > 0 and calc.odd(y) {
            palette.pre-bg
        } else {
            palette.bg
        },
        stroke: (x: none, y: 0.35pt + palette.border-muted),
    )

    show table.cell: it => {
        show: _typeset.with("table", bold: it.y == 0)
        set par(spacing: 0.7em)
        // CSS uses the document background for odd rows and the preformatted
        // background for every second row. Keep the same alternating rhythm
        // in paged Typst output, including repeated table headers.
        set text(
            size: 0.875em,
            number-width: "tabular",
            fill: if it.y == 0 { palette.accent } else { palette.fg },
        )
        it
    }

    // Footnotes restart on each page: superscript [a]; entries: [a] content.
    show footnote.entry: it => context {
        let note = it.note
        let number = counter(footnote).at(note.location()).first()
        block[
            #link(note.location(), numbering(note.numbering, number))#h(0.3em)#note.body
        ]
    }

    // Scale prose without applying a second reduction inside headings.
    show _cjk_text: it => context {
        let fonts = if type(text.font) == str { (text.font,) } else { text.font }
        if not fonts.any(font => lower(font) in ("noto sans", "libertinus sans", "source han sans")) and text.size == _font_size.body {
            text(size: 0.94 * _font_size.body, it)
        } else {
            it
        }
    }
    body
}

/// Apply the document template. Use with a show rule, optionally pre-filling
/// configuration: `#show: template.with(theme: "dark", layout: "landscape")`.
#let template(theme: "light", layout: "portrait", body) = context {
    // Validate at the public boundary so all output targets report the same
    // configuration errors.
    let _ = _palette(theme)
    assert(
        layout in ("portrait", "landscape"),
        message: "The layout must be either \"portrait\" or \"landscape\".",
    )

    _theme.update(theme)
    _html.when-html(
        () => _html.template(theme: theme, body),
        () => _paged_template(theme, layout, body),
    )
}
