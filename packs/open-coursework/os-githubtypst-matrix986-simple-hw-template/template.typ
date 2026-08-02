#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#import "@preview/cetz:0.2.2"



// #let implies = $arrow.double.long$

#let porblem_counter = counter("problem")

#let prob = [== #smallcaps(text([Problem], )) #porblem_counter.step() #context {porblem_counter.display()}]
#let author = "李舟洋"
#let title = "Hw"

#set document(author: author, title: title)




#let template(
  title: "Homework",
  author: "李舟洋", 
  date: datetime.today().display(), 
  institute: "Shanghai Jiao Tong University", 
  class: "Calculus A2 SJTU 2023-24 Standard", 
  body
) = {

    set page(
    paper: "a4", 
    margin: 2.5cm,
    footer: [
      #line(length: 100%, stroke:  (thickness:  0.5pt))
      #v(-10pt)
      #align(left)[#context counter(page).display("1 of 1", both: true)]
      //#align(left)[#counter(page).display("1 of 1", both: true)]
      #v(-19pt)
      #align(right)[#author]
      ],

    header: context [
      #if int(counter(page).get().at(0)) > 1 [
        #line(length: 100%, stroke:  (thickness:  0.5pt))
        #v(-24pt)
        #align(left)[#class - #title]
      ]
      ]    
  )
  
  show ref: it => {
    let eq = math.equation
    let el = it.element
    if el != none and el.func() == eq {
      // Override equation references.
      [式#link(el.location(),numbering(
        el.numbering,
        ..counter(eq).at(el.location())
      ))]
    } else {
      // Other references as usual.
      it
    }
  }

  set par(leading: 1.1em, first-line-indent: 0em, justify: true, )
  show table: set align(center)
  show figure.where(kind: "table"): set figure.caption(position: top)

  set text(font: "New Computer Modern")
  
  show raw: set text(font: ("New Computer Modern", "SimSun"))
  
  set par(spacing:  1.1em)
  show heading: set block(above: 1.4em, below: 1em)

  show heading.where(level: 1): set align(center)
  //show raw.where(lang:  "cpp"): it => sourcecode(it)

  show: codly-init.with()

  show institute: it => [
    #set align(center)
    #set text(12pt, weight: "regular")
    #block(smallcaps(it))
  ]

  show author: it => [
    _ #it _
  ]

  show class: it => [
    _ #it _
  ]

  show date: it => [
    _ #it _
  ]

  institute
  v(-4pt)
  line(length: 100%, stroke: (thickness:  0.5pt))
  v(-11pt)
  text(17pt)[#align(center)[#strong(title)]]
  v(-10pt)
  align(center)[Student name: #author]
  v(-4pt)
  line(length: 100%, stroke: (thickness:  0.5pt))
  v(-4pt)
  align(center)[Course: #class]
  v(-4pt)
  align(center)[Date: #date]
  v(20pt)
  
  set align(left + top)


  // show raw.where(lang: "aligned-math"): it => {
  //   set par(
  //     leading: 0.3em
  //   )
  //   let (first, _, second, ..lines) = it.text.split("\n")
  //   let (divisor, dividend) = second.split("/").map(str.trim)

  //   let math-line(down: false) = (
  //     context {
  //       let math-line-lenght = calc.max(
  //         ..lines.map(l => if l.contains("---") {
  //           0pt
  //         } else {
  //           measure(math.equation(l)).width
  //         }),
  //       )
  //       $&$ + line(length: math-line-lenght, stroke: .5pt)
  //       if down {
  //         place(
  //           dx: -math-line-lenght,
  //           path(
  //             stroke: .5pt,
  //             (-.4em, 1.4em),
  //             ((0pt, -0.25pt), (-0.1em, 1em)),
  //           ),
  //         )
  //       }
  //     }
  //   )

  //   let content = {
  //     $&$ + first.trim()
  //     linebreak()

  //     math-line(down: true)
  //     linebreak()

  //     // divisor
  //     move($divisor$, dx: -0.4em, dy: -0.08em)
  //     $&$ +  math.display(dividend)
  //     linebreak()

  //     for l in lines {
  //       if l.contains("---") {
  //         math-line()
  //         linebreak()
  //         continue
  //       }
  //       $&$ + l.trim()
  //       linebreak()
  //     }
  //   }
  //   math.equation(
  //     block: true,
  //     content,
  //   )
  // }

  body 
  
}


