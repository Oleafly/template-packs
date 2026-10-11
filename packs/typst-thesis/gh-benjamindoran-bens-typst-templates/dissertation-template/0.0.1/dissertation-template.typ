#import "@preview/ctheorems:1.1.3": *
#import "@preview/drafting:0.2.2": inline-note, margin-note

#show: thmrules.with(qed-symbol: $square$)
#let theorem = thmbox("theorem", "Theorem", fill: rgb("#eee"))
#let example = thmplain("example", "Example")
#let proof = thmproof("proof", "Proof")
#let abstract_block(body) = pad(left: 2em, right: 2em, {body})
#let today() = datetime.today().display("[month repr:long] [day], [year]")

// https://www.lib.uchicago.edu/research/scholar/phd/dissertation-requirements/format/
#let dissertation-template(
  title: [Your Title Goes Here],
  program: [PRITZKER SCHOOL OF MOLECULAR ENGINEERING],
  degree_name: [DOCTOR OF PHILOSOPHY],
  author: [Your Name],
  graduation_month: [June],
  graduation_year: [2026],
  commitee: (),
  titlepage_spacing: 40pt,
  show_titlepage: true,
  insert_copyright: true,
  abstract: none, 
  dedication: none, 
  acknowledgments: none,
  epigraph: none, 
  insert_toc: true, // table of contents
  insert_figlist: true, // list of figures
  insert_tablist: true, // list of tables
  insert_illlist: true, // list of illustrations
  insert_maplist: true, // list of maps
  bib: none,
  fontsize: 12pt,
  fontchoice: "Times New Roman",
  doc
) = {
  show: thmrules.with(qed-symbol: $square$)

  // helper function
  let to-string(content) = {
    if content.has("text") {
      content.text
    } else if content.has("children") {
      content.children.map(to-string).join("")
    } else if content.has("body") {
      to-string(content.body)
    } else if content == [ ] {
      " "
    }
  }

  // basic global settings
  set page("us-letter", margin: 1in, number-align: center)
  set text(font: (fontchoice, "Times New Roman", "Libertinus Serif"), size: fontsize)

  show heading: it=>[#v(1.5 * fontsize) #it #v(1.5 * fontsize)]
  show heading.where(level: 1): it => {
    counter(math.equation).update(0)
    pagebreak(weak: true)
    it
  }

  // default link listing format 
  // show link: underline
  set enum(numbering: "1.a.i.")

  let frame(stroke) = (x, y) => (
    left: if x != 1 { 0pt } else { stroke },
    top: if y == 1 { stroke } else { 0pt },
    bottom: stroke,
  )
  set table(stroke: frame(black+0.5pt), align: left)
  set table.header(repeat: true)
  show table: set align(center)
  show table: set par(justify: false)
  show table.cell.where(y: 0): set text(weight: "bold", size: 1.2 * fontsize)
  show table.cell.where(x: 0): set text(style: "italic")
  show figure.caption: set align(left)

  // Number equations by first chapter
  // set math.equation(numbering: "(1.1)", supplement: "Eq.",)
  set math.equation(numbering: it => {
      let count = counter(heading.where(level: 1)).at(here()).first()
      if count >0 {
        numbering("(1.1)", count, it)
      } else {
        numbering("(1)", it)
      }
    }, supplement: [Eq.]
  )

  set list(spacing: fontsize/2)
  show list: set par(leading: fontsize/2)
  set enum(spacing: fontsize/2)
  show enum: set par(leading: fontsize/2)
  
  show figure.caption: it => {
    set align(left)
    let body_sentences = to-string(it.body).split(".")
    [
      *#it.supplement #context it.counter.display(it.numbering): *
      *#body_sentences.remove(0).*
      #body_sentences.join(".")
    ]
  }


  show outline.entry: set block(spacing: fontsize/2)
  show figure.caption: set par(leading: fontsize/2)
  show outline.entry: it => link(
    it.element.location(),
    it.indented(it.prefix(), [
      #to-string(it.body()).split(".").first()
      #box(width: 1fr, repeat(".", gap: 0.15em))
      #it.page()
    ])
  )

// -------------------------------------------------------------------------------
// Start Preface formatting 
// -------------------------------------------------------------------------------
  
  // Title page
  if show_titlepage {
    set align(center)
      
    upper("UNIVERSITY OF CHICAGO")
    v(titlepage_spacing, weak: true)
    upper(title)
    v(titlepage_spacing, weak: true)
    upper([A DISSERTATION SUBMITTED TO #linebreak()
      THE FACULTY OF THE #program #linebreak()
      IN CANDIDACY FOR THE DEGREE OF #linebreak()
      #degree_name])
    v(titlepage_spacing, weak: true)
    upper([BY#linebreak() #author])
    v(titlepage_spacing, weak: true)
    
    upper("approved by the commitee of\n")
    linebreak()
    set align(left)
    for (i, member) in commitee.enumerate() [
      #upper(member):
      // #line(start: (0pt, 5pt - (2*fontsize)), end: (450pt, 5pt - (2*fontsize)))
      #line(start: (0pt, -fontsize), end: (450pt, -fontsize))
    ]
    
    set align(center)
    v(titlepage_spacing, weak: true)
    set align(bottom)
    upper([Chicago Illinois #linebreak() #graduation_month #graduation_year])
    pagebreak(weak: true) // end title page

  }
  
  // set alignment for rest of Preface
  set align(top + left)
  set page(numbering: "i") // preface numbering
  set par(leading: 1.25*fontsize, spacing: 1.25*fontsize, justify: true)

  
  if insert_copyright {
    page([© #graduation_year by #author])
  }

  if dedication != none {
    page(pad(align(dedication, center), top: 2in))
  }
  
  if epigraph != none {
    page(pad(align(epigraph, center), top: 2in))
  }

  // table of contents
  if insert_toc {
    heading([Table of Contents], outlined: false)
    outline(title: none,)
  }
  
  // list of figures
  context{
    let num_figs = query(figure.where(kind: image)).len()
    if insert_figlist and num_figs > 0 {
      heading([List of Figures], outlined: true)
      outline(
        target: figure.where(kind: image), 
        title: none)
    }
  }
  
  // list of tables
  context{
    let num_tables = query(figure.where(kind: table)).len()
    if insert_tablist and num_tables > 0 {
      heading([List of Tables], outlined: true)
      outline(
        target: figure.where(kind: table), 
        title: none,
      )
    }
 }

  if acknowledgments != none { 
    heading([Acknowledgments], outlined: true)
    acknowledgments
  }

  if abstract != none {
    heading([Abstract], outlined: true)
    abstract
    pagebreak()
  }

  // -------------------------------------------------------------------------------
  // Start Main body formatting 
  // -------------------------------------------------------------------------------
  
  // Update settings for main body
  set heading(numbering: "1.")
  set page(numbering: "1", number-align: center)
  set par(
    leading: 1.25*fontsize, 
    spacing: 1.25*fontsize, 
    justify: true, 
    first-line-indent: 1.5em
  )
  counter(page).update(1)

  // Show main text
  doc

  // Display bibliography.
  if bib != none {
    pagebreak()
    show bibliography: set text(1em)
    show bibliography: set par(first-line-indent: 0em)
    bibliography(bib, title: [References], style: "vancouver-superscript")
  }
}