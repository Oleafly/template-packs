#let abstract_page(
  abstract,
  title: block,
  keywords: str,
  lang: "pl",
) = {
  set par(first-line-indent: 0em)
  set text(lang: lang)
  align(center, text(size: 14pt, strong(title)))

  let a
  let k
  if lang == "pl" {
    a = "Streszczenie"
    k = "Słowa kluczowe"
  } else {
    a = "Abstract"
    k = "Keywords"
  }
  
  v(0.5cm)
  [*#a*. #abstract]
  v(0.5cm)
  [*#k:* #keywords]
}

#let wut_thesis(
  lang: "pl",
  short_references: false,
  title,
  title_en,
  author: "", 
  supervisor: "",
  institute: "", 
  field: "", 
  album: "133337",
  abstract,
  keywords: "",
  abstract_en,
  keywords_en: "",
  acronyms: (),
  doc
) = {
  set page(
      paper: "a4",
      margin: (
        y: 25mm,
        inside: 30mm,
        outside: 20mm,
      ),
  )
  set text(12pt, lang: lang)
  let line_spacing = 0.8em
  set par(justify: true, first-line-indent: 0.5cm, leading: line_spacing, spacing: line_spacing)
  let list_indent = 0.5cm
  set list(indent: list_indent)
  set enum(indent: list_indent)
  
  image("img/eiti.svg", width: 100%)
  
  v(3em)
  {
    set align(center)
    set text(12pt)
    [Instytut #institute]
    v(4em)
    image("img/mgr.svg")
    v(2em)
    
    [na kierunku #field]
    v(4em)
    text(size: 14pt, title)
    v(4em)
    
    text(size: 21pt, author)
    linebreak()
    [Numer albumu #album]
    v(4em)
    [promotor\ #supervisor]
    v(1fr)
    
    [WARSZAWA #datetime.today().year()]
  }

  pagebreak(to: "odd")
  
  set page(numbering: "1")
  // Align number inner and outer
  set page(footer: context {
    let (n,) = counter(page).get()
    set align(if calc.even(here().page()) { left } else { right })
    counter(page).display(page.numbering)
  })
  
  
  set heading(numbering: "1.")
  // Header chapter display
  set page(header: context {
    let selector = heading.where(level: 1).before(here())
    let headings = query(selector)
  
    let heading_here = query(heading.where(level: 1)).find(it => it.location().page() == here().page())
    if not heading_here == none or headings.len() == 0 {
      return
    }
  
    let hing = headings.last()
    
    counter(selector).display(heading.numbering)
    h(1em)
    hing.body
    v(-0.1em)
    line(length: 100%)
  })

  // Caption above table
  show figure.where(
    kind: table
  ): set figure.caption(position: top)

  // Padding above and below image
  show figure: it => {v(1em); it; v(1em)}
  // Short abriviations
  show figure.where(kind: raw): set figure(supplement: [Listing])
    show ref.where(
      form: "normal"
    ): set ref(supplement: it => {
      if short_references {
          if it.kind == image {
            "Rys."
          } else if it.kind == table {
            "Tab."
          } else {
            it.supplement
          }
      } else {
        it.supplement
      }
    })
  
  abstract_page(
    abstract,
    title: title,
    keywords: keywords,
  )
  pagebreak()
  
  abstract_page(
    abstract_en,
    title: title_en,
    keywords: keywords_en,
    lang: "en",
  )
  pagebreak()
  
  {
    // Include in context to prevent pagebreaks after doc
    show heading.where(level: 1): it => {pagebreak(weak: false); text(14pt)[#it] ; par[]}
    show heading.where(level: 2): it => {v(0.5cm); text(13pt)[#it]; par[]}
    show heading.where(level: 3): it => {text(12pt)[#it]; par[]}
    show outline.entry.where(level: 1): it => [*#it*]
    outline(depth: 3)
  
    doc
    pagebreak()
  }
  
  if acronyms.len() > 0 {
    heading([Wykaz symboli i skrótów], numbering: none)
    acronyms.sorted().map(it => [*#it.at(0)* - #it.at(1)]).join(linebreak())
  }
  context if query(selector(figure.where(kind: image))).len() > 0 {
    outline(target: figure.where(kind: image), title: [Spis rysunków])
  }
  context if query(selector(figure.where(kind: table))).len() > 0 {
    outline(target: figure.where(kind: table), title: [Spis tabel])
  }
  context if query(selector(figure.where(kind: raw))).len() > 0 {
    outline(target: figure.where(kind: raw), title: [Spis listingów])
  }
}

