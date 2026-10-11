#import "./front.typ": *

// Short captions
#let in-outline = state("in-outline", false)
#let flex-caption(short, long) = context if in-outline.get() { short } else { long }

// Custom math definitions
#let argmax = math.op([arg#h(1.5pt)max], limits: true)

#let first-line-indent = 1.5em
#let start-par = h(first-line-indent)

#let template(
    meta: (),
    font: "Libertinus Serif",
    two-sided: false,
    acknowledgement: "",
    declaration: "",
    abstract-en: "",
    abstract-cz: "",
    keywords-en: "",
    keywords-cz: "",
    two-page-abstract: false,
    two-page-assignment: false,
    title-first: false,
    ..intro-args,
    body,
) = {
    set document(
        author: meta.author.name,
        title: meta.title,
        date: meta.submission-date,
    )

    // Don't show chapters before the introduction in the thesis contents
    set heading(outlined: false)

    set text(font: font, size: 11pt, lang: "en", fallback: false)

    let footer-display = context {
        let i = counter(page).display()
        if i == [] { return }
        if two-sided {
            let offset = if two-page-assignment { 2 } else { 1 }
            if calc.odd(here().page() + offset) {
                align(right, i)
            } else {
                align(left, i)
            }
        } else {
            align(center, i)
        }
    }

    let a4-width = 210mm
    let text-width = 130mm
    let default-margin = (a4-width - text-width) / 2

    let page-margin = default-margin

    if two-sided {
        let in-margin = 47mm
        let out-margin = 32.5mm

        // single prepended page -> swap left and right pages
        if not two-page-assignment {
            (in-margin, out-margin) = (out-margin, in-margin)
        }

        page-margin = (top: default-margin, bottom: default-margin, inside: in-margin, outside: out-margin)
    }

    set page(
        paper: "a4",
        margin: page-margin,
    )


    if title-first {
        title-page(two-sided, font: font, ..meta)
        imprint-page(two-sided, ..meta)

        if two-sided and not two-page-assignment {
            page[]
        }
    } else {
        // assignment first (default behaviour)
        if two-sided and not two-page-assignment {
            page[]
        }

        title-page(two-sided, font: font, ..meta)
        imprint-page(two-sided, ..meta)
    }

    {
        hide[= Acknowledgements]
        set par(justify: true)
        set text(weight: "extralight", style: "italic")
        v(1fr)
        block(width: 60%, acknowledgement)
        v(2fr)

        pagebreak(weak: true)
    }

    {
        set par(justify: true)

        v(1fr)
        [
            #set align(right)
            = Declaration
        ]
        declaration
        v(1.5em)

        [In Prague on ]
        meta.submission-date.display("[day]. [month]. [year]")
        h(1fr)
        box(width: 1fr, repeat[.])
        pagebreak(weak: true)
    }

    set page(numbering: "i", footer: footer-display)

    {
        set par(justify: true)
        v(28mm)
        [ = Abstract]
        abstract-en
        v(1em)
        [
            #set text(weight: "bold")
            Keywords:
        ]
        h(1em)
        keywords-en

        if two-page-abstract {
            pagebreak()
        }
        v(28mm)

        set text(lang: "cs")
        [ = Abstrakt]
        abstract-cz
        v(1em)
        [
            #set text(weight: "bold")
            Klíčová slova:
        ]
        h(1em)
        keywords-cz
        set text(lang: "en")
        pagebreak(weak: true)
    }


    // alongside flex-caption allows for short and long figure captions
    // must be before any call to `outline`
    show outline: it => {
        in-outline.update(true)
        it
        in-outline.update(false)
    }

    outline(depth: 2, indent: auto)
    pagebreak()
    {
        // only show a list if there is content in it
        show outline: it => if query(it.target) != () { it }
        outline(title: "List of Figures", target: figure.where(kind: image))
        outline(title: "List of Tables", target: figure.where(kind: table))
        outline(title: "List of Code Listings", target: figure.where(kind: raw))
        outline(title: "List of Algorithms", target: figure.where(kind: "algo"))
    }


    set heading(outlined: true)

    set par(justify: true)
    set par(first-line-indent: first-line-indent)

    set line(length: 100%, stroke: 1pt + luma(200))

    show math.equation.where(block: false): box // don't break inline math

    show regex("(?i)(\b(?:a|an|the)\b) "): it => {
        it.text.slice(0, -1) + sym.space.nobreak
    }
    set figure(placement: auto)
    show figure.caption: set text(0.9em)
    show figure.caption: box.with(width: 92%)
    show figure.caption: par.with(justify: false)

    // LaTeX style tables, taken from diatypst src
    show figure.where(kind: table): it => {
        show table: set table(
            stroke: (x, y) => (
                x: none,
                bottom: 0.8pt + black,
                top: if y == 0 { 0.8pt + black } else if y == 1 { 0.4pt + black } else { 0pt },
            ),
        )

        show table.cell.where(y: 0): set text(
            style: "normal",
            weight: "bold",
        ) // for first / header row

        set table.hline(stroke: 0.4pt + black)
        set table.vline(stroke: 0.4pt)
        it
    }

    // Render code blocks with a grey background and external padding.
    show raw.where(block: true): it => {
        set par(justify: false)
        set align(left)
        v(8pt)
        block(
            width: 100%,
            fill: luma(248),
            spacing: 0pt,
            outset: 8pt,
            radius: 4pt,
        )[#it]
        v(8pt)
    }

    import "@preview/outrageous:0.3.0"
    set outline(indent: 1em)
    show outline.entry: outrageous.show-entry.with(
        font: (none, none),
        // very hacky way to format appendices differently
        // there's gotta be a better way, but I don't see it
        body-transform: (lvl, body) => {
            if "children" in body.fields() {
                let (num, ..text) = body.children
                if regex("^[A-Z]$") in num.text {
                    return "Appendix " + num + ": " + text.join()
                }
            }
            body
        },
    )

    set heading(supplement: "Chapter", numbering: "1.1")
    show heading.where(level: 1): it => {
        // Reset the figure counters at each new chapter
        counter(figure.where(kind: image)).update(0)
        counter(figure.where(kind: table)).update(0)
        counter(figure.where(kind: raw)).update(0)
        counter(figure.where(kind: "algo")).update(0)

        if two-sided {
            pagebreak(weak: true, to: if two-page-assignment { "odd" } else { "even" })
        } else {
            pagebreak(weak: true)
        }

        show: block

        let use-supplement = it.outlined and it.numbering != none
        if (use-supplement) {
            text(size: 13pt, fill: rgb(120, 120, 120))[
                #it.supplement #counter(heading).display(it.numbering)
            ]
            linebreak()
            v(-16pt)
        }

        set align(end)
        text(size: 24pt, weight: "bold", font: font)[
            #it.body
        ]

        if (use-supplement) {
            v(22pt)
        } else {
            v(5.5pt)
        }
    }

    show heading.where(level: 2): it => {
        set text(size: 18pt, weight: "bold")
        block(it, below: 18pt, above: 32pt)
    }

    show heading.where(level: 3): it => {
        set text(size: 16pt, weight: "bold")
        block(it, below: 16pt, above: 22pt)
    }

    // Level 4+ headings are not numbered.
    show heading: it => {
        if it.level >= 4 {
            it.body
        } else {
            it
        }
    }

    //   set bibliography(style: "chicago-notes", title: none)
    set bibliography(style: "res/IEEE-modified.csl", title: none)
    show bibliography: it => {
        heading("Bibliography")

        set text(size: 9pt)
        set par(justify: false)
        columns(2, it)
    }

    pagebreak(weak: true)

    // start numbering from the first page of actual text
    set page(numbering: "1", footer: footer-display)
    counter(heading).update(0)
    counter(page).update(1)

    // Make figures inherit the chapter number (e.g., 2.1)
    show figure: set figure(numbering: n => {
        let h-counter = counter(heading).at(here())
        if h-counter.len() > 0 {
            // h-counter.at(0) is the current Chapter (Level 1) number
            numbering("1.1", h-counter.at(0), n)
        } else {
            // Fallback for figures appearing before the first chapter
            numbering("1", n)
        }
    })

    body
}

// call this function after bibliography using an `everything show` rule:
//   #show: start-appendix
#let start-appendix(body) = {
    set heading(supplement: "Appendix", numbering: "A.1")
    counter(heading).update(0)
    body
}

#import "@preview/glossarium:0.5.10": count-refs

// Renders a two-column borderless table of acronyms formatted for glossarium.
// AI generated, hopefully doesn't break
#let acronym-table(
    entries,
    groups,
    user-print-reference: none,
    ..args,
) = {
    set par(first-line-indent: 0pt)

    // Prevent glossarium figures from floating and breaking the table,
    // while keeping them intact so their <labels> survive for cross-referencing.
    show figure.where(kind: "glossarium_entry"): set figure(placement: none)
    show figure.where(kind: "glossarium_entry"): set block(above: 0pt, below: 0pt)

    // Respect glossarium's filtering arguments
    let named = args.named()
    let show-all = named.at("show-all", default: false)
    let min-refs = named.at("minimum-refs", default: 1)

    let visible-entries = entries.filter(e => show-all or count-refs(e.at("key")) >= min-refs)

    // Filter out arguments like `group-heading-level` that `user-print-reference` doesn't accept
    let valid-ref-args = (
        "show-all",
        "disable-back-references",
        "deduplicate-back-references",
        "minimum-refs",
        "description-separator",
        "shorthands",
        "user-print-title",
        "user-print-description",
        "user-print-back-references",
    )
    let ref-args = (:)
    for (k, v) in named {
        if k in valid-ref-args {
            ref-args.insert(k, v)
        }
    }

    table(
        columns: (auto, 1fr),
        stroke: none,
        inset: (x: 8pt, y: 5pt),
        // Sort alphabetically by the "sort" key (or fallback to "key")
        ..for entry in visible-entries.sorted(key: e => e.at("sort", default: e.at("key"))) {
            // Fallbacks in case an entry is missing a short or long form
            let short-form = entry.at("short")
            if short-form == none { short-form = entry.at("key") }

            let meaning = entry.at("long")
            if meaning == none { meaning = entry.at("description") }
            if meaning == none { meaning = [] }

            // Extract glossarium's page-number linking function
            let back-refs = context {
                // Only print them if references are enabled and the term is actually used
                if not named.at("disable-back-references", default: false) and count-refs(entry.at("key")) > 0 {
                    let print-refs = named.at("user-print-back-references")
                    let dedup = named.at("deduplicate-back-references", default: false)

                    // Add some spacing and the references in gray brackets
                    h(0.5em)
                    text(fill: luma(120))[[#print-refs(entry, deduplicate: dedup)]]
                }
            }

            (
                // Column 1: The abbreviation, wrapped in glossarium's reference generator
                user-print-reference(
                    entry,
                    ..ref-args,
                    user-print-gloss: (e, ..opts) => align(right)[#text(weight: "bold")[#short-form]],
                ),
                // Column 2: The meaning + page references
                [#meaning#back-refs],
            )
        }
    )
}
