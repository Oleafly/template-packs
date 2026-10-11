#import "../imports.typ": *
#import "util.typ"
#import "styles.typ"

#let thesis(
  body,
  title: none,
  description: none,
  keywords: none,
  author: none,
  email: none,
  creation-date: datetime.today(),
  university: none,
  fields: (:),
  accent-paint: none,
  coverpage: none
) = {
  // GENERAL PAGE STYLING ----------------------------
  set page(paper: "a4", margin: (x: 2.5cm), binding: left)

  
  // TEXT STYLING ------------------------------------
  
  
  // HEADING STYLING ---------------------------------
  show heading: set block(above: 2em)
  
  // OUTLINE STYLING ---------------------------------
  // Styling is not defined here as else it would break
  // the "List of ..." sections in "content/backmatter/listofthings.typ"
  // 
  // see "content/frontmatter/outline.typ" 

  
  // NUMBERING ---------------------------------------
  set math.equation(numbering: (n, ..) => util.numbering-by-section(n, format: "(1.1)"))

  // FIGURE STYLING ----------------------------------
  show figure: set block(above: 2em, below: 2em)
  set figure(numbering: n => util.numbering-by-section(n, format: "1.1"))
  show figure.caption: it => [#strong[#it.supplement #it.counter.display(it.numbering)]: #it.body]
  
  // TABLE STYLING -----------------------------------
  show figure.where(kind: table): set figure.caption(position: top)
  set table(stroke: 0.5pt)

  
  // RAW STYLING -------------------------------------
  show raw.where(block: true): set block(width: 90%, stroke: 0.5pt + gray, radius: 0.25em, inset: 0.7em)
  show raw.where(block: true): set align(center)
  
  
  // COVERPAGE ---------------------------------------
  if type(coverpage) == function {
    [#metadata("thesis:section:coverpage") <thesis:section:coverpage>]
    coverpage(title, author, email, creation-date, university, fields, accent-paint)
  }

  [#metadata((
    title : title,
    description : description,
    keywords : keywords,
    author : author,
    email : email,
    creation-date : creation-date,
    university : university,
    fields: fields,
    accent-paint : accent-paint,
  )) <thesis:information>]
  
  [#metadata("thesis:section:thesis") <thesis:section:thesis>]
  body
  [#metadata("thesis:section:thesis-end") <thesis:section:thesis-end>]
}

/* Styling Concept 
 * The element styling are defined in styles.typ and are in the format of <element>-<matter>,
 * so a heading style in the main matter is given as `styles.heading-mainmatter`.
 * 
 * This was done to keep the content here as compact as possible!
 */

#let frontmatter(body) = {
  // PAGE STYLING ------------------------------------
  set page(
    footer: context util.footer(if calc.even(here().page()) {h(1fr)} + [#numbering("i",..counter(page).at(here()))])
  )

  // COUNTER UPDATE ----------------------------------
  counter(heading).update(0)
  counter(page).update(1)

  
  // HEADING STYLING ---------------------------------
  set heading(numbering: none, outlined: false)
  show heading: styles.heading-frontmatter

  
  
  // -------------------------------------------------
  [#metadata("thesis:section:frontmatter") <thesis:section:frontmatter>]
  body
}


#let mainmatter(body) = {
  [#metadata("thesis:section:frontmatter-end") <thesis:section:frontmatter-end>]
  
  // PAGE STYLING ------------------------------------
  set page(header: context util.header({
      let h1 = util.get-current-heading()
    
      if calc.odd(here().page()) and (h1.location().page() != here().page()) { // left side
        if h1.numbering != none {numbering(h1.numbering, ..counter(heading).at(h1.location())) + h(0.3em)} + h1.body
        } else { // right side
          //let h2 = util.get-current-heading(level: 2)
          //h(1fr) + if h2.numbering != none {numbering(h2.numbering, ..counter(heading).at(h2.location())) + h(0.3em)} + h2.body
        }
      }
    ),  
    footer: context util.footer(if calc.even(here().page()) {h(1fr)} + [#numbering("1",..counter(page).at(here()))])
  )

  // COUNTER UPDATE ----------------------------------
  counter(heading).update(0)
  counter(page).update(1)

  
  // HEADING STYLING ---------------------------------
  set heading(numbering: "1.1.1", outlined: true)
  show heading: styles.heading-mainmatter

  
    
  
  // -------------------------------------------------
  [#metadata("thesis:section:mainmatter") <thesis:section:mainmatter>]
  body
}


#let backmatter(body) = {
  [#metadata("thesis:section:mainmatter-end") <thesis:section:mainmatter-end>]
  pagebreak()

  // PAGE STYLING ------------------------------------
  set page(
    header: none,
    footer: context util.footer(if calc.even(here().page()) {h(1fr)} + [#numbering("1",..counter(page).at(here()))])
  )
  

  // COUNTER UPDATE ----------------------------------

  
  // HEADING STYLING ---------------------------------
  set heading(numbering: none)
  show heading: styles.heading-backmatter

  
  // -------------------------------------------------
  
  [#metadata("thesis:section:backmatter") <thesis:section:backmatter>]
  body
}



#let appendix(body) = {
  [#metadata("thesis:section:backmatter-end") <thesis:section:backmatter-end>]
  pagebreak()
  // PAGE STYLING ------------------------------------
  set page(header: none)
  

  // COUNTER UPDATE ----------------------------------
  counter(heading).update(1) // sets the main section numbering to 1 and since heading 1 has no numbering, auto increment is disabled for level 1 headings

  
  // HEADING STYLING ---------------------------------
  set heading(numbering: "A.1.1")
  show heading.where(level: 1): set heading(numbering: none)
  show heading: styles.heading-appendix

  
  // -------------------------------------------------
  [
    = Appendix <thesis:sec:appendix>

    #context {
      // since level 1 is not shown (as it is the section "Appendix"), only level 2 has to be changed
      show outline.entry.where(level: 2): set outline.entry(fill: none)
      show outline.entry.where(level: 2): set text(weight: "bold")
      show outline.entry.where(level: 2): block.with(above: 1.2em)
      outline(title: none,
        target: selector(heading).after(here())
      )
    }

    #pagebreak()
  ]
  [#metadata("thesis:section:appendix") <thesis:section:appendix>]
  body
  [#metadata("thesis:section:appendix-end") <thesis:section:appendix-end>]
}