// ifes-ciencia.typ
// Typst implementation for Revista Ifes Ciência.
// Implements: ifes-ciencia-spec v0.1.1
// Version: 0.2.0-rc.2

#let version = "0.2.0-rc.2"
#let spec-version = "0.1.1"

#let _journal-green = rgb("#004240")

#let _font-stack = (
  "Times New Roman",
  "Liberation Serif",
  "Latin Modern Roman",
)

#let author(
  name: none,
  affiliations: (),
  email: none,
  orcid: none,
  corresponding: false,
) = (
  name: name,
  affiliations: affiliations,
  email: email,
  orcid: orcid,
  corresponding: corresponding,
)

#let affiliation(
  id: none,
  institution: none,
  city: none,
  state: none,
) = (
  id: id,
  institution: institution,
  city: city,
  state: state,
)

#let _has-issue-line(
  volume: none,
  issue: none,
  year: none,
  pages: none,
) = (
  volume != none or issue != none or year != none or pages != none
)

#let _masthead-line-count(
  volume: none,
  issue: none,
  year: none,
  pages: none,
  doi: none,
) = (
  1
  + (if _has-issue-line(
      volume: volume,
      issue: issue,
      year: year,
      pages: pages,
    ) { 1 } else { 0 })
  + (if doi != none { 1 } else { 0 })
)

#let _banner-top(
  volume: none,
  issue: none,
  year: none,
  pages: none,
  doi: none,
) = (
  1.50cm
  + 0.53cm * _masthead-line-count(
    volume: volume,
    issue: issue,
    year: year,
    pages: pages,
    doi: doi,
  )
)

#let _running-issue(
  volume: none,
  issue: none,
  year: none,
) = {
  if volume != none {
    text("v." + str(volume))
  }

  if issue != none {
    text("n." + str(issue))
  }

  if year != none {
    text(" " + str(year))
  }
}

#let _page-decoration(
  volume: none,
  issue: none,
  year: none,
  pages: none,
  doi: none,
) = context {
  let page-number = counter(page).get().first()

  if page-number == 1 {
    let masthead-height = 0.53cm * _masthead-line-count(
      volume: volume,
      issue: issue,
      year: year,
      pages: pages,
      doi: doi,
    )

    let banner-top = _banner-top(
      volume: volume,
      issue: issue,
      year: year,
      pages: pages,
      doi: doi,
    )

    place(
      top + left,
      dx: 11cm,
      dy: 1cm,
      rect(
        width: 10cm,
        height: masthead-height,
        inset: (left: 0.12cm, right: 0pt, top: 1pt, bottom: 0pt),
        fill: _journal-green,
        stroke: none,
      )[
        #set text(
          font: _font-stack,
          size: 13pt,
          fill: white,
        )
        #set par(
          justify: false,
          first-line-indent: 0pt,
          leading: 6pt,
        )

        ISSN 2359-4799
        #if _has-issue-line(
          volume: volume,
          issue: issue,
          year: year,
          pages: pages,
        ) {
          linebreak()
          if volume != none {
            text("Volume " + str(volume))
          }
          if issue != none {
            text(" / Número " + str(issue))
          }
          if year != none {
            text(" / Ano " + str(year))
          }
          if pages != none {
            text(" – p. " + str(pages))
          }
        }
        #if doi != none {
          linebreak()
          text("DOI:" + str(doi))
        }
      ],
    )

    place(
      top + left,
      dx: 3cm,
      dy: banner-top,
      image(
        "assets/ifes-ciencia-banner.png",
        width: 18.77cm,
        height: 2.71cm,
        fit: "stretch",
      ),
    )
  } else {
    place(
      top + left,
      dx: 0cm,
      dy: 1.25cm,
      rect(
        width: 3cm,
        height: 0.75cm,
        inset: 0pt,
        fill: _journal-green,
        stroke: none,
      )[
        #align(center + horizon)[
          #text(
            font: _font-stack,
            size: 10pt,
            fill: white,
            weight: "bold",
          )[
            #page-number
          ]
        ]
      ],
    )

    place(
      top + left,
      dx: 3.25cm,
      dy: 1.39cm,
      text(
        font: _font-stack,
        size: 12pt,
        _running-issue(
          volume: volume,
          issue: issue,
          year: year,
        ),
      ),
    )

    place(
      top + left,
      dx: 16cm,
      dy: 1cm,
      image(
        "assets/ifes-ciencia-logo.png",
        width: 3cm,
      ),
    )
  }
}

#let _affiliation-mark(ids) = {
  if ids.len() > 0 {
    super(ids.map(str).join(","))
  } else {
    []
  }
}

// Images are block-level in Typst. Wrapping the ORCID image in `box` makes
// it an inline-level object that can stay in the author paragraph.
#let _orcid-marker(orcid) = box(
  height: 0.9em,
  link(
    "https://orcid.org/" + orcid,
    image("assets/orcid-marker.png", height: 0.9em),
  ),
)

#let _render-author(item) = {
  let affiliation = _affiliation-mark(item.affiliations)
  let orcid = if item.orcid != none {
    h(0.15em) + _orcid-marker(item.orcid)
  } else {
    []
  }
  let corresponding = if item.corresponding {
    super("*")
  } else {
    []
  }

  text(item.name) + affiliation + orcid + corresponding
}

#let _render-authors(authors) = {
  align(left)[
    #set text(size: 12pt)
    #authors.map(_render-author).join([, ])
  ]
}

#let _render-affiliations(affiliations) = {
  align(left)[
    #set text(size: 12pt)
    #set par(leading: 6pt)

    #for item in affiliations {
      if item.id != none {
        super(str(item.id))
      }

      if item.institution != none {
        item.institution
      }

      if item.city != none {
        text(", " + item.city)
      }

      if item.state != none {
        text(" – " + item.state)
      }

      linebreak()
    }
  ]
}

#let _render-corresponding(authors) = {
  align(right)[
    #set text(size: 10pt)

    #for item in authors {
      if item.corresponding and item.email != none {
        text("* " + item.email)
        linebreak()
      }
    }
  ]
}

#let _render-orcid-list(authors) = {
  let with-orcid = authors.filter(item => item.orcid != none)

  if with-orcid.len() > 0 {
    v(8pt)

    align(left)[
      #set text(size: 10pt)
      #set par(leading: 1pt)

      #for item in with-orcid {
        let url = "https://orcid.org/" + item.orcid
        text("ORCID – " + item.name + ": ")
        link(url, text(url))
        linebreak()
      }
    ]
  }
}

#let _editorial-dates(
  submitted: none,
  accepted: none,
  published: none,
) = {
  if submitted != none or accepted != none or published != none {
    align(center)[
      #set text(size: 10pt)

      #if submitted != none {
        text("Artigo submetido em " + str(submitted))

        if accepted != none {
          text(", aceito em " + str(accepted))
        }

        if published != none {
          text(" e publicado em " + str(published))
        }

        text(".")
      } else if accepted != none {
        text("Artigo aceito em " + str(accepted))

        if published != none {
          text(" e publicado em " + str(published))
        }

        text(".")
      } else {
        text("Artigo publicado em " + str(published) + ".")
      }
    ]
  }
}

#let _keyword-line(label, words) = {
  block[
    #strong(label)
    #words.join("; ").
  ]
}

#let _frontpage(
  mode: "submission",
  title-pt: [],
  title-en: [],
  graphical-abstract: none,
  authors: (),
  affiliations: (),
  volume: none,
  issue: none,
  year: none,
  pages: none,
  doi: none,
  submitted: none,
  accepted: none,
  published: none,
) = {
  let banner-bottom = (
    _banner-top(
      volume: volume,
      issue: issue,
      year: year,
      pages: pages,
      doi: doi,
    )
    + 2.71cm
  )

  // The text area starts 3 cm below the physical top edge. Reserve the
  // vertical space occupied by the absolutely positioned banner.
  let banner-reserve = banner-bottom - 3cm

  set par(
    justify: true,
    first-line-indent: 0pt,
    spacing: 4pt,
  )

  block(width: 100%)[
    #v(banner-reserve)
    // Pass-2 calibration: the official DOCX leaves roughly 0.64 cm
    // between the banner and the Graphical Abstract heading.
    #v(18pt)

    #align(center)[
      #text(size: 12pt, weight: "bold")[GRAPHICAL ABSTRACT]
    ]

    #v(6pt)

    #align(center)[
      #if graphical-abstract == none {
        rect(
          width: 68%,
          height: 3.2cm,
          stroke: 0.6pt,
        )[
          #align(center + horizon)[
            #text(size: 10pt, fill: gray)[
              Insira aqui o Graphical Abstract
            ]
          ]
        ]
      } else {
        graphical-abstract
      }
    ]

    #v(10pt)

    #align(center)[
      #text(size: 14pt, weight: "bold")[
        #upper(title-pt)
      ]
    ]

    #v(6pt)

    #align(center)[
      #text(size: 14pt, style: "italic")[
        #upper(title-en)
      ]
    ]

    #if mode == "final" {
      v(6pt)
      _render-authors(authors)

      v(8pt)
      _render-affiliations(affiliations)

      _render-corresponding(authors)

      v(6pt)
      _editorial-dates(
        submitted: submitted,
        accepted: accepted,
        published: published,
      )

      _render-orcid-list(authors)
    }

    #v(12pt)
  ]
}

#let _abstracts(
  abstract-pt: [],
  keywords-pt: (),
  abstract-en: [],
  keywords-en: (),
) = {
  set text(size: 11pt)

  set par(
    justify: true,
    first-line-indent: 0pt,
    spacing: 6pt,
  )

  block(width: 100%)[
    #block[
      #strong[Resumo:]
      #abstract-pt
    ]

    #_keyword-line([Palavras-chave:], keywords-pt)

    #v(6pt)

    #block[
      #strong[Abstract:]
      #abstract-en
    ]

    #_keyword-line([Keywords:], keywords-en)

    #v(12pt)
  ]
}

#let _scientific-caption(it) = {
  let number = context it.counter.display(it.numbering)

  align(center)[
    #block(width: 100%)[
      #set text(size: 12pt, weight: "regular")
      #set par(
        justify: false,
        first-line-indent: 0pt,
        spacing: 0pt,
      )
      #it.supplement #number: #it.body
    ]
  ]
}

#let ifes-ciencia(
  mode: "submission",
  language: "pt",

  title-pt: [],
  title-en: [],

  graphical-abstract: none,

  authors: (),
  affiliations: (),

  abstract-pt: [],
  keywords-pt: (),
  abstract-en: [],
  keywords-en: (),

  volume: none,
  issue: none,
  year: none,
  pages: none,
  doi: none,

  submitted: none,
  accepted: none,
  published: none,

  body,
) = {
  assert(
    mode == "submission" or mode == "final",
    message: "ifes-ciencia: mode must be \"submission\" or \"final\"",
  )
  assert(
    language == "pt" or language == "en",
    message: "ifes-ciencia: language must be \"pt\" or \"en\"",
  )
  assert(
    graphical-abstract != none,
    message: "ifes-ciencia: graphical-abstract is required",
  )
  assert(
    keywords-pt.len() >= 3 and keywords-pt.len() <= 5,
    message: "ifes-ciencia: keywords-pt must contain 3 to 5 items",
  )
  assert(
    keywords-en.len() >= 3 and keywords-en.len() <= 5,
    message: "ifes-ciencia: keywords-en must contain 3 to 5 items",
  )

  if mode == "final" {
    assert(
      authors.len() > 0,
      message: "ifes-ciencia: final mode requires at least one author",
    )
    assert(
      affiliations.len() > 0,
      message: "ifes-ciencia: final mode requires at least one affiliation",
    )
  }

  let lang = language

  set document(
    title: if mode == "final" { title-pt } else { none },
    author: if mode == "final" {
      authors.map(item => item.name)
    } else {
      ()
    },
    keywords: if mode == "final" { keywords-pt } else { () },
    date: none,
  )

  set page(
    paper: "a4",
    margin: (
      top: 3cm,
      bottom: 2cm,
      left: 3cm,
      right: 2cm,
    ),
    columns: 2,
    header: none,
    footer: none,
    foreground: _page-decoration(
      volume: volume,
      issue: issue,
      year: year,
      pages: pages,
      doi: doi,
    ),
  )

  set columns(gutter: 1.25cm)

  set text(
    font: _font-stack,
    size: 12pt,
    lang: lang,
  )

  set par(
    justify: true,
    first-line-indent: (
      amount: 1.25cm,
      all: true,
    ),
    spacing: 6pt,
  )

  set heading(numbering: "1.1.1")
  show heading.where(level: 1): set text(size: 12pt, weight: "bold")
  show heading.where(level: 1): upper
  show heading.where(level: 2): set text(size: 12pt, weight: "regular")
  show heading.where(level: 2): upper
  show heading.where(level: 3): set text(size: 12pt, weight: "bold")

  // Caption styling must stay outside the wrapper functions. A local
  // show rule would make the wrapper return styled content, preventing labels
  // attached after figura/tabela/quadro from referencing the semantic figure.
  show figure.caption: _scientific-caption

  // Footnotes: editorially confirmed as 10 pt, single-spaced.
  // Keep these rules before any page content because footnote.entry
  // properties must be uniform across a page run in Typst.
  show footnote.entry: set text(
    font: _font-stack,
    size: 10pt,
  )
  show footnote.entry: set par(
    leading: 0.65em,
    spacing: 0pt,
    first-line-indent: 0pt,
  )

  // Page 1: masthead/banner in the page foreground, followed by the
  // Graphical Abstract, titles, and (in final mode) author metadata.
  place(
    top + left,
    scope: "parent",
    float: true,
    clearance: 0pt,
    _frontpage(
      mode: mode,
      title-pt: title-pt,
      title-en: title-en,
      graphical-abstract: graphical-abstract,
      authors: authors,
      affiliations: affiliations,
      volume: volume,
      issue: issue,
      year: year,
      pages: pages,
      doi: doi,
      submitted: submitted,
      accepted: accepted,
      published: published,
    ),
  )

  // Match the LaTeX RC structure: the first physical page is reserved for
  // front-page metadata. Resumo/Abstract start on page 2 at full width.
  pagebreak()

  place(
    top + left,
    scope: "parent",
    float: true,
    clearance: 0pt,
    _abstracts(
      abstract-pt: abstract-pt,
      keywords-pt: keywords-pt,
      abstract-en: abstract-en,
      keywords-en: keywords-en,
    ),
  )

  body
}

// Citação de citação (`apud`).
//
// The original, unconsulted source is deliberately supplied as literal
// author/year content instead of as a bibliography key. Only the consulted
// source is passed to `cite`, so only that source is registered in the
// bibliography. This matches the NBR 10520:2023 secondary-citation model.
#let _apud-consulted(consulted, supplement: none) = {
  let supplement-content = if supplement == none {
    []
  } else {
    [, ] + [#supplement]
  }

  (
    cite(consulted, form: "author")
    + [, ]
    + cite(consulted, form: "year")
    + supplement-content
  )
}

#let apud(
  original-author,
  original-year,
  consulted,
  original-supplement: none,
  supplement: none,
  form: "normal",
) = {
  assert(
    form == "normal" or form == "prose",
    message: "apud: form must be \"normal\" or \"prose\"",
  )

  let original-supplement-content = if original-supplement == none {
    []
  } else {
    [, ] + [#original-supplement]
  }

  let inside = (
    [#original-year]
    + original-supplement-content
    + [ ]
    + emph([apud])
    + [ ]
    + _apud-consulted(consulted, supplement: supplement)
  )

  if form == "prose" {
    [#original-author] + [ (] + inside + [)]
  } else {
    [(] + [#original-author] + [, ] + inside + [)]
  }
}

// Bibliography API.
// Ordinary citations intentionally keep Typst's native @key / cite syntax.
#let referencias(sources, full: false) = {
  set par(
    justify: false,
    first-line-indent: 0pt,
  )

  // Typst 0.15.x does not visibly honor CSL `entry-spacing` in the way
  // required by the journal. Bibliography entries are paragraphs, so use
  // paragraph spacing here. With 12 pt body text, 2em yields one visible
  // single-spaced blank line between consecutive references.
  show bibliography: set par(spacing: 2em)

  bibliography(
    sources,
    title: [REFERÊNCIAS],
    full: full,
    style: "csl/ifes-ciencia.csl",
  )
}

// ---------------------------------------------------------------------------
// Appendices
// ---------------------------------------------------------------------------

#let _appendix-counter = counter("ifes-ciencia-appendix")

// In-article appendix.
//
// Appendices are author-produced post-textual material. They are identified by
// consecutive uppercase letters and a title:
//
//   APÊNDICE A – Título
//
// The journal has not defined a separate appendix page/column geometry, so the
// helper deliberately remains in the current article flow and does not force a
// page break or switch away from the journal's two-column layout.
#let apendice(
  title: none,
  body: none,
) = {
  assert(
    title != none,
    message: "apendice: title is required",
  )
  assert(
    body != none,
    message: "apendice: body is required",
  )

  _appendix-counter.step()

  block(
    width: 100%,
    above: 12pt,
    below: 6pt,
    breakable: false,
  )[
    #set text(size: 12pt, weight: "bold")
    #set par(
      justify: false,
      first-line-indent: 0pt,
      spacing: 0pt,
    )
    #align(center)[
      APÊNDICE #context _appendix-counter.display("A") – #title
    ]
  ]

  body
}

// ---------------------------------------------------------------------------
// Equations
// ---------------------------------------------------------------------------

// Journal equation wrapper.
//
// Block equations are centered by Typst's native math-equation layout.
// When numbered, the number is an Arabic numeral in parentheses and is
// aligned at the right edge. The function returns the native equation element
// directly so labels written after the call remain referenceable.
#let equacao(
  body,
  numbered: true,
  alt: none,
) = {
  assert(
    type(numbered) == bool,
    message: "equacao: numbered must be a boolean",
  )

  math.equation(
    body,
    block: true,
    numbering: if numbered { "(1)" } else { none },
    number-align: right + horizon,
    supplement: auto,
    alt: alt,
  )
}

// ---------------------------------------------------------------------------
// Scientific elements: figures, tables, and quadros
// ---------------------------------------------------------------------------

// Exact editorial wording for elements produced by the article authors.
// The wrapper adds `Fonte:` and the required final period.
#let fonte-autores = "Elaborado pelos autores"

#let _normalize-source(source) = {
  if type(source) == str {
    source.trim().trim(".", at: end)
  } else {
    source
  }
}

#let _scientific-source(source) = {
  assert(
    source != none,
    message: "elemento científico: source/Fonte é obrigatória",
  )

  let normalized = _normalize-source(source)

  align(left)[
    #block(width: 100%)[
      #set text(size: 10pt, weight: "regular")
      #set par(
        justify: false,
        first-line-indent: 0pt,
        spacing: 0pt,
      )
      Fonte: #normalized.
    ]
  ]
}

#let _scientific-element(
  body,
  caption: none,
  source: none,
  kind: "figura",
  supplement: [Figura],
  body-size: 12pt,
  wide: false,
  placement: none,
) = {
  assert(
    caption != none,
    message: "elemento científico: caption/título é obrigatório",
  )
  assert(
    source != none,
    message: "elemento científico: source/Fonte é obrigatória",
  )

  let resolved-placement = if wide and placement == none {
    auto
  } else {
    placement
  }

  let resolved-scope = if wide {
    "parent"
  } else {
    "column"
  }

  figure(
    block(width: 100%)[
      #block(width: 100%)[
        #set text(size: body-size)
        #align(center)[#body]
      ]

      #v(4pt)
      #_scientific-source(source)
    ],
    caption: figure.caption(
      position: top,
      [#caption],
    ),
    kind: kind,
    supplement: supplement,
    numbering: "1",
    placement: resolved-placement,
    scope: resolved-scope,
    gap: 4pt,
  )
}

#let figura(
  body,
  caption: none,
  source: none,
  wide: false,
  placement: none,
) = _scientific-element(
  body,
  caption: caption,
  source: source,
  kind: "figura",
  supplement: [Figura],
  body-size: 12pt,
  wide: wide,
  placement: placement,
)

#let _tabular-column-count(columns) = {
  if type(columns) == int {
    columns
  } else if type(columns) == array {
    columns.len()
  } else {
    none
  }
}

#let _tabular-cells(columns, header, rows, helper-name) = {
  assert(
    type(header) == array,
    message: helper-name + ": header must be an array",
  )
  assert(
    type(rows) == array,
    message: helper-name + ": rows must be an array of row arrays",
  )

  let column-count = _tabular-column-count(columns)

  if column-count != none {
    assert(
      header.len() == column-count,
      message: helper-name + ": header width does not match columns",
    )

    for row in rows {
      assert(
        type(row) == array,
        message: helper-name + ": each row must be an array",
      )
      assert(
        row.len() == column-count,
        message: helper-name + ": row width does not match columns",
      )
    }
  } else {
    for row in rows {
      assert(
        type(row) == array,
        message: helper-name + ": each row must be an array",
      )
    }
  }

  rows.flatten()
}

// Default Revista Ifes Ciência quantitative-table body.
//
// Visual policy:
// - no vertical rules;
// - top rule;
// - rule below the header;
// - bottom rule;
// - no horizontal rules between data rows.
//
// The outer `tabela(...)` wrapper remains usable with arbitrary native Typst
// content when an article needs a special table.
#let tabela-corpo(
  columns: none,
  header: none,
  rows: none,
  inset: 4pt,
  align: auto,
  stroke: 0.6pt,
) = {
  assert(
    columns != none,
    message: "tabela-corpo: columns is required",
  )
  assert(
    header != none,
    message: "tabela-corpo: header is required",
  )
  assert(
    rows != none,
    message: "tabela-corpo: rows is required",
  )
  let cells = _tabular-cells(
    columns,
    header,
    rows,
    "tabela-corpo",
  )

  table(
    columns: columns,
    inset: inset,
    align: align,
    stroke: none,
    table.hline(stroke: stroke),
    table.header(
      ..header,
      table.hline(stroke: stroke),
    ),
    ..cells,
    table.hline(stroke: stroke),
  )
}

// Default Revista Ifes Ciência qualitative quadro body.
//
// Quadros use a closed grid with horizontal and vertical rules. The outer
// `quadro(...)` wrapper supplies the journal's 11 pt body typography.
#let quadro-corpo(
  columns: none,
  header: none,
  rows: none,
  inset: 4pt,
  align: auto,
  stroke: 0.5pt,
) = {
  assert(
    columns != none,
    message: "quadro-corpo: columns is required",
  )
  assert(
    header != none,
    message: "quadro-corpo: header is required",
  )
  assert(
    rows != none,
    message: "quadro-corpo: rows is required",
  )
  let cells = _tabular-cells(
    columns,
    header,
    rows,
    "quadro-corpo",
  )

  table(
    columns: columns,
    inset: inset,
    align: align,
    stroke: stroke,
    table.header(..header),
    ..cells,
  )
}

#let tabela(
  body,
  caption: none,
  source: none,
  wide: false,
  placement: none,
) = _scientific-element(
  body,
  caption: caption,
  source: source,
  kind: "tabela",
  supplement: [Tabela],
  body-size: 12pt,
  wide: wide,
  placement: placement,
)

#let quadro(
  body,
  caption: none,
  source: none,
  wide: false,
  placement: none,
) = _scientific-element(
  body,
  caption: caption,
  source: source,
  kind: "quadro",
  supplement: [Quadro],
  body-size: 11pt,
  wide: wide,
  placement: placement,
)
