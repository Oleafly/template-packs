// released under the MIT License, © catte_ 2025
#import "@preview/latex-lookalike:0.1.4"


#let cover(fac, dept, spec, mod, prof, title, author, year) = {
  set align(center)
  set par(leading: .9em)
  
  [
    REPUBLIQUE ALGERIENNE DEMOCRATIQUE ET POPULAIRE\
    Ministère de l'enseignement supérieur et de la recherche scientifique\
    *Université d'Alger 1 -- Ben Youcef BenKheda\
    #fac\
    Department #dept*
  ]

  set v(weak: true)
  image("/img/algiers.png", width: 8em) + v(3em)
  if spec != none [*Specialté:* #spec #parbreak() #v(2.5em)]
  if mod != none { text(1.5em)[*Module: #mod* #parbreak() #v(1.75em)] }
  if prof != none [*Professeur:*\ #prof #parbreak() #v(2.75em)]
  if title != none {
    text(2em)[*Theme*] + v(1.75em)
    line(length: 100%)
    block(width: 90%, text(1.5em, title))
    line(length: 100%)
  }

  if author != () {
    show: strong
    show: block.with(width: 90%)
    set align(left)
    set list(marker: [--])
    
    [Auteurs:]
    let halves = author.chunks(calc.ceil(author.len() / 2))
    grid(columns: (1fr, 1fr), ..halves.map(h => list(..h)))
  }

  v(1fr) + [#year]
}

#let heading-styles(doc) = {
  show heading.where(level: 1): it => {
    set text(weight: "regular")
  
    let corner(pos, sign, body) = place(
      pos,
      dx: sign * .4em,
      dy: sign * .33em,
      box(fill: white, outset: .33em, upper(body))
    )
  
    pagebreak(weak: true) + v(6em)
    rect(
      width: 100%, height: 2.5em,
      corner(bottom + right, +1, it.body) + if it.numbering != none {
        set text(font: "New Computer Modern Sans")
        corner(top + left, -1, [Chapitre #counter(heading).display()])
      }
    )
  
    v(5.66em, weak: true)
  }

  show heading.where(level: 2): set block(above: 32.5pt, below: 22.5pt)
  show heading.where(level: 3): set block(above: 25pt, below: 18pt)
 
  set heading(numbering: "1.1")
  show heading.where(body: [General introduction]): set heading(numbering: none)
  show heading.where(level: 2): set text(19pt)

  doc
}

#let project(
  doc,
  faculty: [Faculté de Science],
  dept: [d'Informatique],
  specialty: none,
  module: none,
  professor: none,
  title: none,
  author: (),
  year: datetime.today().year()
) = {
  set document(title: title, author: author)
  set par(spacing: 2em, leading: .8em, first-line-indent: (amount: 1.25em, all: true))
  set text(font: "new computer modern", 12pt, lang: "fr")  
  page(cover(faculty, dept, specialty, module, professor, title, author, year))

  set list(indent: 1.5em)
  show list: set block(spacing: 2.5em)

  set figure(numbering: "1.1", gap: 1.25em)
  set figure.caption(separator: [ -- ])
  show figure.where(kind: raw): set text(.9em)
  
  show: heading-styles
  show: latex-lookalike.style-outline
  outline(title: [Table des matières])
  outline(target: figure, title: [Table des figures])

  bibliography(
    "/bib.bib",
    style: "ieee",
    full: true,
  )
 
  counter(page).update(0)
  set page(
    numbering: "1",
    // header: text(spacing: 0)[bobo]+line(length: 100%)
)
  // set table(
  //
  // )
  doc
}
