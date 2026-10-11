// SINTA-1 Spec
#let sinta-1(
  // Set journal specification
  journal-title: [Journal Title: Institution Name],
  print-issn: [1234-5678],
  electronic-issn: [1234-5678],
  vol-num: none,
  issue-num: none,
  publish-date: [January 20xx],
  doi: none,

  // Set paper title.
  indonesian-title: [Indonesian Title], // Note: 12pt Bold Capital

  // Set paper authors.
  /*
    The shape of the author struct would be something like:
    author = (
      name,
      university = (
        uni-name,
        uni-major
      ),
      organization,
      email,
    )
  */
  authors: (),

  // Abstract content and the keywords that follows.
  indonesian-abstract: none,                     // 12pt Bold
  english-abstract: none,                        // 12pt Bold
  abstract-keywords: (), // min 3, max 6 (no guide on sizing)

  paper-size: "a4",
  bibliography: none, // calls BiBLaTex references
  body
) = {

  // Set document title, and author
  set document(
    title: title,
    author: authors.map(author => author.name)
  )

  set paper(
    margin: (
      top: 2.25cm,
      bottom: 2.25cm,
      left: 2.5cm,
      right: 2cm,
    )
  )

  set text(
    font: "Times New Roman", 
    size: 12pt,
    spacing: 1.15em,
  )
}

/* ------------ */

// SINTA-3 Spec
#let sinta3(
  // title
  article-title: [Set your Article Title],

  // Author dict
  // Name
  // Affiliation
  // City
  // Country
  // Email (Optional)
  authors: (),
  
  // abstract
  abstract: none,
  abstract-keywords: (),
  abstract-eng: none,
  abstract-keywords-eng: (),

  // content
  body,

  // BibLaTeX
  bibliography: none,
) = {

  set document(title: article-title, author: authors.map(author => author.name))

  set page(
    paper: "a4"
  )

  set text(
    // font: "Times New Roman",
    size: 11pt,
    spacing: 1.5pt,
    lang: "id",
  )

  show figure.where(kind: table): set figure.caption(position: top)

  set heading(numbering: "A.")
  show heading: it => {
    set text(size: 12pt)
    upper(it)
  }

  show std.bibliography: set text(8pt)
  show std.bibliography: set block(spacing: 0.5em)
  set std.bibliography(style: "apa")

  place(
    top+center,
    float: true,
    scope: "parent",
    clearance: 30pt,
    {
      show std.title: set align(center)
      show std.title: set par(leading: 0.5em)
      show std.title: set text(size: 14pt, weight: "bold")
      std.title()

      linebreak()
      set par(leading: 0.6em, spacing: 0.5em)
      set par(justify: true)
  
      let get-name = authors.map(x => x.name).join(", ")
      let get-affiliation = authors.map(x => x.city).dedup().join(", ")
      let get-city = authors.map(x => x.affiliation).dedup().join(", ")
      let get-country = authors.map(x => x.country).dedup().join(", ")
      let get-email = authors.map(x => link("mailto:" + x.email)).dedup().join(", ")

      align(center)[
        #get-name
      ]
      align(center)[
        #get-affiliation
      ]
      align(center)[
        #get-city
      ]
      align(center)[
        #get-country
      ]
      align(center)[
        #get-email
      ]
    }
  ) 

  if abstract != none {
    set par(spacing: 0.8em, justify: true)
    set text(11pt, spacing: 100%)
    align(center)[#upper(strong("Abstract"))]
    align()[#abstract]

    if abstract-keywords != () {
      align(center)[Kata Kunci : #abstract-keywords.join[; ]]
    }
    v(2pt)
  }

  set par(first-line-indent: (
    amount: 0.5cm,
    all: true
  ))
  body

  bibliography
}

#show figure.caption: it => {
    strong[#it.supplement #context it.counter.display(it.numbering)]
    strong(it.separator)
    it.body
}

#let sinta-3-figure(content, caption: none, source: none) = {
  let caption-position = if type(content) == "content" and content.func() == table {
    top
  } else {
    bottom
  }
  
  figure(
    kind: "sourced",
    supplement: strong([Sumber]),
    numbering: (..) => {h(-measure(sym.space).width)},
    figure(
      content,
      caption: if caption != none {
        figure.caption(
          position: if type(content) == std.content and content.func() == table { top } else { bottom },
          caption,
        )
      }
    ),
    caption: source
  )
}

