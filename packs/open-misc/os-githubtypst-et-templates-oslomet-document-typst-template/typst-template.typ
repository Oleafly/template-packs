
// Page margins are based on one of the official OsloMet templates. For now, the
// template is only optimised for Norwegian and the A4 format, not `us-letter`.

#let article(
  title: "Tittel",
  signature: true,
  show-date: true,
  authors: (),
  date: "",
  dateformat: "",
  abstract: "Dette er et sammendrag",
  abstract-title: none,
  cols: 1,
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
  paper: "a4",
  lang: "nb",
  region: "NO",
  font: "Arial",
  fontsize: 10.5pt,
  singlequotes: ("‘", "’"),
  title-size: 1.5em,
  subtitle-size: 1.25em,
  heading-family: "Arial",
  heading-weight: "bold",
  heading-style: "normal",
  heading-color: black,
  heading-line-height: 0.65em,
  link-color: rgb("#3282B8"),
  text-number-type: "old-style",
  text-number-width: "proportional",
  sectionnumbering: "1.1.1",
  toc: false,
  toc_title: none,
  toc_depth: none,
  toc_indent: 1.5em,
  doc,
) = {
  set page(
    paper: paper,
    margin: margin,  
    header: context {
      if counter(page).get().first() == 1 [
        #place(
          dy: 20mm,
          image(
            "oslomet-logo-header.svg",
            height: 130%,
          )
        )
      ]
    },
    footer: context {
      if counter(page).get().first() == 1 [
        #place(
          dy: 2mm,
          image(
            "oslomet-logo-footer.svg",
            height: 7.5mm,
          ),
        )
      ] else [
        #set text(
          size: 8pt
        )
        \
        OsloMet – side
        #counter(page).display(
          (num, max) => [#num av #max],
          both: true
        )
      ]
    }
  )
  
  set par(justify: true)
  
  set text(lang: lang,
           region: region,
           font: font,
           size: fontsize)
  
  set smartquote(
    quotes: (
      single: singlequotes,
      double: auto
    )
  )
  
  set heading(numbering: sectionnumbering)
  
  let heading_sizes = (fontsize) => {
    if fontsize == 12pt {
      (
        "title": 18pt,
        "h1": 18pt,
        "h2": 13pt,
        "h3": 12pt,
      )
    } else if fontsize == 11pt {
      (
        "title": 18pt,
        "h1": 16pt,
        "h2": 12pt,
        "h3": 11pt,
      )
    } else if fontsize == 10.5pt {
      (
        "title": 18pt,
        "h1": 15pt,
        "h2": 11pt,
        "h3": 10.5pt,
      )
    } else {
      (
        "title": 1.1em,
        "h1": 1.2em,
        "h2": fontsize,
        "h3": fontsize,
      )
    }
  }
  
  let sizes = heading_sizes(fontsize)
  
  show heading.where(level:1): it => block(
    text(
      size: sizes.h1,
      weight: "regular",
      style: "normal",
      it.body
    )
  )
  
  show heading.where(level:2): it => block(
    text(
      size: sizes.h2,
      weight: "bold",
      style: "normal",
      it.body
    )
  )
  
  show heading.where(level:3): it => block(
    text(
      size: sizes.h3,
      weight: "regular",
      style: "italic",
      it.body
    )
  )
    
  show link: set text(number-type: "lining", number-width: "tabular")
  
  show link: it => {
    set text(fill: link-color)
    it
  }
  
  v(14mm + 12pt)
  
  par(
    text(
      weight: "bold",
      size: sizes.title,
      title
    ),
  )
  
  if cols == 1 {
    doc
  } else {
    columns(cols, doc)
  }
  
  if signature == true {
    v(4em, weak: true)
  
    let datestring = if date != "" {
      [#date]
    }
    
    let signaturestring = if date != "" and show-date {
      [OsloMet – storbyuniversitetet, #datestring]
    } else {
      [OsloMet – storbyuniversitetet]
    }
    
    if authors.len() > 0 {
      let count = authors.len()
      let ncols = calc.min(count, 3)
      figure(
        grid(
          columns: (1fr,) * ncols,
          row-gutter: 0.65em,//1.5em,
          //grid.header(repeat: false, signaturestring),
          grid.cell(align: left, colspan: ncols, signaturestring),
          ..authors.map(author =>
              align(left)[
                #author.name #if author.orcid != "" [#box(height: 10pt, baseline: 10%, link("https://orcid.org/" + author.orcid)[#image("ORCID-iD_icon_vector.svg")])] \
                #link("mailto:" + author.email.replace("\\",""))
              ]
          )
        )
      )
    } else {
      [#signaturestring]
    }
  }
}
