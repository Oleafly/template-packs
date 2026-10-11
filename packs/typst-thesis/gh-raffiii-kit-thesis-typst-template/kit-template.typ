// Organized by functions for each section

// numbering
#let numbered(numbering-format,doc) = [
  #pagebreak(to: "odd", weak: true)
  #set page(numbering: numbering-format)
  #counter(page).update(1)
  #counter(heading).update(0)
  #doc
]

// Title page: KIT and institute logos in the upper corners, title, author, institute, examiners and advisors, and creation time
#let make-title-page(opts) = [
  #set text(size: 12pt)
  #set rect(width: 100%,
    height: 100%,
    inset: 4pt,
    radius: (top-right: 0.5cm, bottom-left: 0.5cm),
    stroke: 0.5pt
  )
  #let tablealign(a,b) = {
    let rows = a.zip(b).map(row=>row.map(c => [#c])).flatten()
    table(align: left, stroke: none, columns: 2,..rows)
  }
  #let numbered = ("First", "Second", "Third", "Fourth", "Fifth")
  
  #rect[
    #table(columns: 2,align: (left,right),stroke: none,
    pad(left:1cm,top:1.5cm,image(opts.kit-logo, width: 50%)),
    
    pad(right:1cm,top:1.5cm,image(opts.sdq-logo, width: 50%))
  )
    #set align(center)
    #v(2cm)
    #text(20pt)[*#opts.title*]

    #v(1cm)
    #opts.degree's Thesis of
    #v(1cm)
    #text(17pt)[#opts.author.firstname #opts.author.lastname]
    #v(2.5cm)

    At the KIT Department of #opts.institute.department\
    #opts.institute.institute
    #tablealign(numbered.map(i => [#i Examiner:]),opts.examiners)
    #tablealign(numbered.map(i => [#i Advisor:]),opts.advisors)
    #v(1cm)
    #opts.time.from - #opts.time.to
  ]
]

#let default-postal-address = (
  "Karlsruher Institut für Technologie", 
  "Fakultät für Informatik", 
  "Postfach 6980", 
  "76128 Karlsruhe"
)

#let make-postal-address(address) = [
  #pagebreak(weak: true)
  #for line in address [
    #line\
  ]
]

#let default-authorship-text = "I declare that I have developed and written the enclosed thesis completely by myself. I
have not used any other than the aids that I have mentioned. I have marked all parts of the
thesis that I have included from referenced literature, either in their original wording or
paraphrasing their contents. I have followed the by-laws to implement scientific integrity
at KIT."
#let make-declaration-of-authorship(opts, text: default-authorship-text) = [
  #pagebreak(weak:true)
  #align(bottom)[
    #line(length: 100%)
    _[#opts.title]_
    #text
    *#opts.sign.loc, #opts.sign.date*
    #v(1.5cm)
    #line(length: 50%,stroke: (dash:"dotted"))
    (#opts.author.firstname #opts.author.lastname)
  ]
]


// Abstracts

#let make-abstract(opts) = [
  #pagebreak(to: "odd", weak: true)
  = Abstract
  #opts.abstract.english
]

#let make-zusammenfassung(opts) = [
  #pagebreak(to: "odd", weak: true)
  = Zusammenfassung
  #opts.abstract.german
]

// Outlines

#let make-outline() = [
  #pagebreak(to: "odd", weak: true)
  #outline()
]

#let make-list-of-kind(kind, name) = [
  #context {
    if query(figure.where(kind: kind)).len()>0 { 
      pagebreak(to: "odd")
      outline(
        title: [List of #name],
        target: figure.where(kind: kind),
      )  
    }
  }
]

// Headers

#let make-header(primary, secondary) = [
  #set text(size: 10pt)
  #context {
    if calc.rem(counter(page).at(here()).last(),2)==0 [
      #let count = numbering(secondary.numbering, ..counter(heading).get().slice(0,1)) + " "
      _ #pad(left:2mm, count + primary.body) _
    ] else [
      #let count = numbering(secondary.numbering, ..counter(heading).get().slice(0,2)) + " "
      _ #pad(right:2mm, align(right, count + secondary.body)) _ 
    ]
  }
  //_ #primary #h(1fr) #secondary _
  #line(length: 100%, start: (0pt,-8pt), stroke: 0.5pt)
]

#let get-header() = {
  context {
    let main-heading = query(heading.where(level:1)).filter(head => head.location().page() == here().page())
    
    if main-heading.len() > 0 {
      return []
    }

    let prev-main-heading = query(heading.where(level:1)).filter(head => 
      head.location().page() < here().page()
    ).sorted(key: head => 
      head.location().page()
    )
    let primary = ((heading(""),)+prev-main-heading).last()
    let prev-secondary-heading = query(
      heading.where(level:2)
    ).filter(head => 
      head.location().page() <= here().page() 
      and head.location().page() >= primary.location().page()
    ).sorted(key: head => 
      head.location().page()
    )
    let secondary = ((heading(""),)+prev-secondary-heading).last()
    
    return make-header(primary, secondary)
    
  }
}
#let thesis-content(opts, doc) = [
  #{
    set figure(placement: auto, numbering: "1.1")
    set heading(numbering: "1.1.")
    set page(header: get-header())
    show heading: it => [
      #v(0.5cm) * #text(font: "DejaVu Sans", weight: "extrabold", it) * #v(0.5cm)
    ]
    show heading.where(level: 1): it => [
      #pagebreak(weak: true) #v(2cm) #text(size:20pt,it) #v(1cm)
    ]
    set par(justify: true)
    set math.equation(numbering: "(1.1)")
    doc
  }
]


#let thesis(
  title: none,
  degree: "Master",
  abstract: (german: [], english: []),
  institute: (department:none,institute:none),
  author: (firstname: none, lastname: none),
  examiners: (),
  advisors: (),
  lang: "en",
  time: (from: none, to: none),
  sign: (loc: none, date: none),
  postal-address:default-postal-address,
  kit-logo:"logos/kitlogo_de_cmyk.svg", 
  sdq-logo:"logos/sdqlogo.svg",
  doc
) = {
  let opts = (
    title: title,
    degree:degree,
    abstract:abstract,
    institute: institute,
    author:author,
    examiners: examiners,
    advisors:advisors,
    time: time,
    sign: sign,
    postal-address:postal-address,
    kit-logo:kit-logo, 
    sdq-logo:kit-logo,
  )
  set page(margin: (inside: 3cm, outside: 2.51cm, y: 1.75cm, bottom: 2.5cm, top:3cm))
  
  // Title page
  make-title-page(opts)
  
  // Postal Address of KIT
  make-postal-address(postal-address)

  // authorship
  make-declaration-of-authorship(opts)
  
  // Abstracts
  show: doc => numbered("i", doc)
  make-abstract(opts)
  make-zusammenfassung(opts)

  // Outline
  make-outline()
  make-list-of-kind(image, "Figures")
  make-list-of-kind(table, "Tables")
  
  // Thesis
  show: doc => numbered("1", doc)
  show: doc => thesis-content(opts,doc)

  // doc
  doc
}

#let appendix(doc) = {
  set heading(numbering: "A.1")
  show: doc => numbered("I", doc)
  bibliography("references.bib")
  doc
}