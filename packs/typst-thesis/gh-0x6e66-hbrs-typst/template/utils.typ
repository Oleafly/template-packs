#import "@preview/outrageous:0.4.0"
#import "@preview/acrostiche:0.5.1": *

#import "../ads/meta.typ": *

#let auto_import(file) = {
  include { "../modules_" + language + "/" + file + ".typ" }
}

#let abstract(lang, body) = {
  align(
    left,
    text(
      size: 20pt,
      if lang == "de" {
        [Zusammenfassung]
      } else if lang == "en" {
        [Abstract]
      },
    ),
  )

  body
  pagebreak()
}

#let language_switch(dict) = {
  for (k, v) in dict {
    if k == language {
      return v
      break
    }
  }
  panic("language value not matching any key in the array")
}

#let today = {
  datetime.today().display("[day].[month].[year]")
}

#let table_of_contents = {
  show outline.entry: outrageous.show-entry.with(
    ..outrageous.presets.outrageous-toc,
  )
  outline(
    title: if language == "de" {
      "Inhaltsverzeichnis"
    } else if language == "en" {
      "Table of Contents"
    },
    target: heading,
    indent: auto,
    depth: 3,
  )

  pagebreak()
}

#let table_of_figures = {
  pagebreak()
  heading(
    numbering: none,
    outlined: true,
    bookmarked: true,
    if language == "de" {
      "Abbildungsverzeichnis"
    } else if language == "en" {
      "List of figures"
    },
  )
  outline(
    title: none,
    target: figure.where(kind: "fig"),
  )
}

#let table_of_tables = {
  pagebreak()
  heading(
    numbering: none,
    outlined: true,
    bookmarked: true,
    if language == "de" {
      "Tabellenverzeichnis"
    } else if language == "en" {
      "List of tables"
    },
  )
  outline(
    title: none,
    target: figure.where(kind: "tab"),
  )
}

#let table_of_acronyms = {
  pagebreak()
  heading(
    numbering: none,
    outlined: true,
    bookmarked: true,
    if language == "de" {
      "Abkürzungsverzeichnis"
    } else if language == "en" {
      "List of acronyms"
    },
  )
  print-index(
    level: 1,
    numbering: none,
    outlined: false,
    sorted: "",
    title: "",
    delimiter: "",
    row-gutter: 7pt,
    used-only: true,
  )
}

#let table_of_listings = {
  pagebreak()
  heading(
    numbering: none,
    outlined: true,
    bookmarked: true,
    if language == "de" {
      "Quellcodeverzeichnis"
    } else if language == "en" {
      "List of code-listings"
    },
  )
  outline(
    title: none,
    target: figure.where(kind: "lst"),
  )
}

#let bib = {
  pagebreak()
  bibliography(
    title: {
      if language == "de" {
        "Literaturverzeichnis"
      } else if language == "en" {
        "Bibliography"
      }
    },
    bib_file,
  )
}

