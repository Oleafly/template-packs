// MISC. Commands

#let va(a) = math.bold(math.accent(a,math.harpoon))

#let c_theorem = counter("theorem")
#let theorem(name,it) = block(fill: luma(230),inset: 8pt,radius: 4pt,[
  #set math.equation(numbering: "(1)")
  #c_theorem.step()
  *Theorem #context c_theorem.display(): #name*
  #line(length: 100%, stroke: 0.2pt)

  #it
]
)

#let c_example = counter("example")
#let example(name,it) = block(fill: luma(230),inset: 8pt,radius: 4pt,[
  #c_example.step()
  *Example #context c_example.display(): #name*
  #line(length: 100%, stroke: 0.2pt)


  #it
]
)

#let c_definition = counter("definition")
#let definintion(name,it) = block(fill: luma(230),inset: 8pt,radius: 4pt,[
  #c_definition.step()
  *Definition #context c_definition.display(): #name*
  #line(length: 100%, stroke: 0.2pt)


  #it
]
)


#let proof(it) = block[
  #emph[Proof: #it]
]

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% MAIN
#let conf(
  title: "Placeholder",
  subtitle: none,
  authors: (),

  numbering: none,
  kurs: none,
  kurskod: none,
  toc: false,
  indent: false,
  lang: "sv",
  ncols: 1,
  doc
) = {

set document(title: title, author: authors.map(author => author.name), date: none)


set page(
  paper: "a4",
  margin: (top:19mm,left: 13mm,right: 13mm,bottom: 47mm),
  // margin: (top:19mm, bottom: 47mm, outside: 13mm, inside: 19mm),
  header: [
    #text(size: 10pt)[
    #title
    #h(1fr)
    #kurs, #kurskod
    #line(length: 100%, stroke: 0.2pt)]
  ],
  numbering: if lang == "sv" {"1 (1)"} else {"1 of 1"},
  columns: ncols
)

set columns(gutter: 16pt)

set table(stroke: 0.3pt)


set par(
  justify: true,
  first-line-indent: if indent {1.5em} else {0em},
  spacing: if indent { 0.65em } else { 1.2em }
)

set heading(numbering: numbering)

show figure.where(kind: table): set figure.caption(position: top)

set ref(supplement: none)


set text(
  font: "New Computer Modern",
  size: 12pt,
  lang: lang,
  hyphenate: true
)



// Titlepage
// code from ieee
place(
    top,
    float: true,
    scope: "parent",
    clearance: 30pt,
    {
      v(3pt, weak: true)
      align(center, par(leading: 0.5em, text(size: 24pt, title)))
      align(center,par(leading: 0.5em,text(size: 16pt,kurs)))
      v(8.35mm, weak: true)

      // Display the authors list.
      set par(leading: 0.6em)
      for i in range(calc.ceil(authors.len() / 3)) {
        let end = calc.min((i + 1) * 3, authors.len())
        let is-last = authors.len() == end
        let slice = authors.slice(i * 3, end)
        grid(
          columns: slice.len() * (1fr,),
          gutter: 12pt,
          ..slice.map(author => align(center, {
            text(size: 11pt, author.name)
            if "department" in author [
              \ #emph(author.department)
            ]
            if "organization" in author [
              \ #emph(author.organization)
            ]
            if "location" in author [
              \ #author.location
            ]
            if "email" in author {
              if type(author.email) == str [
                \ #link("mailto:" + author.email)
              ] else [
                \ #author.email
              ]
            }
          }))
        )

        if not is-last {
          v(16pt, weak: true)
        }
      }
    }
  )

show outline.entry.where(level: 1): it => strong(delta: 400, it)
set footnote(numbering: "*")

if toc {
align(center)[
    #box(width: 80%)[
      #outline(indent: auto,depth: 1)
    ]
]
}

set math.equation(numbering: none)

doc
}