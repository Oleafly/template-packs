#import "@preview/droplet:0.3.1": dropcap

// State and labels
#let vortex-document-lang = state("vortex-document-lang", "pt")
#let vortex-image-counter = counter("vortex-image")
#let vortex-table-counter = counter("vortex-table")

#let vortex-has-content(value) = {
  if value == none {
    false
  } else if type(value) == str {
    value.trim() != ""
  } else {
    value != []
  }
}

#let vortex-labels(lang) = {
  let is-portuguese = lang == "pt" or lang == "pt-br"
  let is-spanish = lang == "es" or lang.starts-with("es-")

  if is-portuguese {
    (
      figure-caption: "FIGURA",
      figure-reference: "Figura",
      table-caption: "TABELA",
      table-reference: "Tabela",
      source: "Fonte",
    )
  } else {
    (
      figure-caption: "FIGURE",
      figure-reference: "Figure",
      table-caption: "TABLE",
      table-reference: "Table",
      source: if is-spanish { "Fuente" } else { "Source" },
    )
  }
}

// Text helpers
#let vortex-dropcap(body) = {
  block(width: 100%)[
    #set par(justify: true, leading: 1.5em, spacing: 0cm, first-line-indent: 0pt)
    #dropcap(height: 3, gap: 0.25em, hanging-indent: 0pt)[#body]
  ]
  v(1.5em)
}

#let vortex-bibliography(
  bib,
  style: "./assets/bibliography/abnt.csl",
) = {
  set par(leading: 1em, spacing: 2em, first-line-indent: 0pt)
  bibliography(bib, style: style, title: "REFERENCES")
}

#let vortex-long-citation(
  body,
  font: "EB Garamond",
) = {
  block(inset: (left: 12em))[
    #set text(font: font, size: 10pt)
    #set par(leading: 0.5em, first-line-indent: 0pt, justify: true)
    #v(2.5em)
    #body
    #v(2.5em)
  ]
}

#let vortex-cite-text(author, key) = [#author (#cite(key, form: "year"))]

// Captioned blocks
#let vortex-captioned-block(
  body,
  kind,
  item-counter,
  caption: [],
  source: [],
  width: 100%,
  ref: none,
  frame: false,
) = context {
  let labels = vortex-labels(vortex-document-lang.get())
  let is-image = kind == "image"
  let number = item-counter.get().first() + 1
  let caption-label = if is-image { labels.figure-caption } else { labels.table-caption }
  let reference-label = if is-image { labels.figure-reference } else { labels.table-reference }
  let caption-reference = caption-label + " " + str(number)
  let inline-reference = reference-label + " " + str(number)

  v(1em)
  block(width: 100%, breakable: false)[
    #set par(first-line-indent: 0pt, justify: false, leading: 0.6em)
    #set text(size: 10pt)

    // Metadata drives custom @references for Vortex figures and tables.
    #if ref != none {
      [#metadata((kind: "vortex-" + kind, reference: inline-reference)) #ref]
    }

    #v(2em)
    #item-counter.step()
    #align(center)[#caption-reference – #caption]
    #v(0.5em)
    #align(center)[
      #box(width: width)[
        #if frame {
          box(width: 100%, stroke: rgb("#c8c8c8"), inset: 0pt)[#body]
        } else {
          body
        }
      ]
    ]
    #v(0.5em)
    #align(center)[#labels.source: #source]
    #v(1em)
  ]
  v(1em)
}

#let vortex-table-body(body) = {
  if body.func() != table {
    body
  } else {
    let strong-rule = 1.2pt + black
    let light-rule = 0.4pt + rgb("#ffffff")
    let fields = body.fields()
    let children = fields.remove("children")
    let columns = fields.at("columns")

    if columns.all(column => column == auto) {
      fields.insert("columns", columns.map(column => 1fr))
    }
    children.push(table.hline(stroke: .5pt + black))

    [
      #set table(
        align: center,
        inset: (x: 4pt, y: 2pt),
        stroke: (x, y) => (
          left: light-rule,
          right: light-rule,
          top: if y == 0 { strong-rule } else { none },
          bottom: if y == 0 { strong-rule } else { light-rule },
        ),
      )
      #table(..fields, ..children)
    ]
  }
}

#let vortex-image(
  body,
  caption: [],
  source: [],
  width: 100%,
  ref: none,
  frame: false,
) = {
  let image-body = if type(body) == str { image(body, width: 100%) } else { body }
  vortex-captioned-block(
    image-body,
    "image",
    vortex-image-counter,
    caption: caption,
    source: source,
    width: width,
    ref: ref,
    frame: frame,
  )
}

#let vortex-table(
  body,
  caption: [],
  source: [],
  width: 100%,
  ref: none,
  frame: false,
) = {
  vortex-captioned-block(
    vortex-table-body(body),
    "table",
    vortex-table-counter,
    caption: caption,
    source: source,
    width: width,
    ref: ref,
    frame: frame,
  )
}

// Main journal template
#let vortex(
  title: [],
  authors: (),
  blind-review: false,
  doi: "00000.0000",
  name: "NAME",
  lastname: "LAST NAME",
  article-type: [ORIGINAL ARTICLE],
  lang: "pt",
  region: "br",
  vortex-number: "#",
  article-first-page-number: "#",
  article-last-page-number: "#",
  received: "00/00/2026",
  accepted: "00/00/2026",
  available-online: "00/00/2026",
  editor: "Dr Fabio Guilherme Poletto. Dr Felipe de Almeida Ribeiro",
  license-url: "https://creativecommons.org/licenses/by/4.0/",
  main-font: "EB Garamond",
  note-font: "Caladea",
  resumo: [],
  palavras-chave: [],
  abstract: [],
  keywords: [],
  resumen: [],
  palabras-clave: [],
  body,
) = {
  let has-portuguese-abstract = vortex-has-content(resumo)
  let has-english-abstract = vortex-has-content(abstract)
  let has-spanish-abstract = vortex-has-content(resumen)
  let abstract-count = (
    if has-portuguese-abstract { 1 } else { 0 }
  ) + (
    if has-english-abstract { 1 } else { 0 }
  ) + (
    if has-spanish-abstract { 1 } else { 0 }
  )

  if abstract-count > 2 {
    panic("Vortex template error: provide at most two abstracts. Use English only, Portuguese + English, or Spanish + English.")
  }
  if not has-english-abstract {
    panic("Vortex template error: an English abstract is required. Portuguese-only or Spanish-only abstracts are not accepted.")
  }
  if has-portuguese-abstract and has-spanish-abstract {
    panic("Vortex template error: choose either Portuguese + English or Spanish + English, not Portuguese + Spanish together.")
  }

  set page(
    paper: "a4",
    margin: (top: 2cm, bottom: 2cm, left: 2.5cm, right: 2.5cm),
  )
  set heading(numbering: "1.")
  set text(lang: lang, region: region, font: main-font, size: 12pt)
  show heading: set text(size: 12pt)
  show heading: it => [
    #v(2em)
    #it
    #v(2em)
  ]

  show ref: it => {
    let el = it.element
    if el != none and el.func() == metadata {
      let value = el.value
      if (
        type(value) == dictionary
          and "kind" in value
          and (value.kind == "vortex-image" or value.kind == "vortex-table")
      ) {
        value.reference
      } else {
        it
      }
    } else {
      it
    }
  }

  set par(
    justify: true,
    leading: 0.75em,
    spacing: 0cm,
    first-line-indent: (amount: 1cm, all: true),
  )
  set footnote.entry(indent: 0pt)

  // Header
  set page(
    header: context {
      if counter(page).get().first() == 1 {
        block(width: 100%)[
          #set text(size: 8pt)
          #set par(justify: true, leading: 0.5em, first-line-indent: 0pt)
          Revista Vórtex | Vórtex Music Journal | ISSN 2317–9937 |
          http://vortex.unespar.edu.br/ \
          #("https://doi.org/" + doi)
        ]
      } else {
        align(right)[
          #set text(size: 8pt)
          #set par(first-line-indent: 0pt)
          #if blind-review {
            [AUTHOR 1. #title]
          } else {
            [#upper(lastname), #name. #title]
          }
        ]
      }
    },
  )

  let first-page-note = [
    *#title.* Received on: #received.
    Accepted on: #accepted.
    Available online: #available-online.
    Editor: #editor.
    Creative Commons CC-BY:
    #underline(link(license-url)[#license-url]).
  ]

  // Footer
  set page(
    footer: context {
      if counter(page).get().first() == 1 {
        block(width: 100%)[
          #set text(size: 8pt, font: note-font)
          #set par(first-line-indent: 0pt, leading: .5em, spacing: .5em, justify: true)
          #first-page-note
        ]
      } else {
        block(width: 100%)[
          #set text(size: 8pt)
          #set par(first-line-indent: 0pt, leading: 0.5em)

          *Rev Vórtex*, Curitiba, #("v." + str(vortex-number)), #("p." + str(article-first-page-number) + "-" + str(article-last-page-number)), e0000, 2026.
          issn 2317–9937. \
          https://creativecommons.org/licenses/by/4.0/ |
          #str("https://doi.org/" + doi)

          #v(0.5em)
          #align(center)[#counter(page).display()]
        ]
      }
    },
  )

  // First page
  text(size: 8pt, fill: rgb("#B71C1C"))[
    \
    \
    #article-type
  ]
  v(0.6em)
  text(size: 18pt)[
    #set par(first-line-indent: 0pt)
    *#title*
  ]
  v(2em)

  for (index, author) in authors.enumerate() {
    let display-name = if blind-review {
      "Author " + str(index + 1)
    } else {
      author.name
    }
    let display-affiliation = if blind-review {
      "Affiliation omitted for blind review"
    } else {
      author.affiliation
    }

    par(first-line-indent: 0pt)[
      #display-name
      #h(0.5em)
      #if not blind-review and "orcid" in author {
        link("https://orcid.org/" + author.orcid)[
          #box(
            height: 0.7em,
            baseline: 0em,
            image("./assets/images/orcid.svg", height: 0.7em),
          )
        ]
      }
      \
      #text(size: 10pt)[#display-affiliation]
    ]
    v(1em)
  }

  let english-abstract-block = [
    #set text(size: 10pt)
    #set par(justify: true, first-line-indent: 0pt)
    *Abstract:* #abstract
    \
    \
    *Keywords:* #keywords
  ]
  let portuguese-abstract-block = [
    #set text(size: 10pt)
    #set par(justify: true, first-line-indent: 0pt)
    *Resumo:* #resumo
    \
    \
    *Palavras-chave:* #palavras-chave
  ]
  let spanish-abstract-block = [
    #set text(size: 10pt)
    #set par(justify: true, first-line-indent: 0pt)
    *Resumen:* #resumen
    \
    \
    *Palabras clave:* #palabras-clave
  ]

  v(1.5em)
  if abstract-count == 1 {
    align(center)[#block(width: 65%)[#english-abstract-block]]
  } else {
    columns(2, gutter: 8mm)[
      #if has-portuguese-abstract {
        portuguese-abstract-block
      } else {
        spanish-abstract-block
      }
      #colbreak()
      #english-abstract-block
    ]
  }

  pagebreak()
  set par(leading: 1.5em)
  vortex-document-lang.update(lang)
  body
}
