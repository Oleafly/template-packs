#import "@preview/ctheorems:1.1.0": *
#import "@preview/physica:0.9.2": *
#let report(title: "", class: "", date: "", author: "", affiliation: "", no-header: false, bibliography-file: "", body) = {
  set text(
    font: (
      "Times New Roman",
      "Yonaga Old Mincho"
    ),
    size: 12pt
  )

  let textMargin(text, above: 8pt, below: 8pt) = {
    block(above: above, below: below, text)
  }

  set page(
    paper: "a4",
    margin: (
      bottom: 1.75cm, top: 2.5cm,
      left: 2cm, right: 2cm
    ),
  )

  set par(leading: 0.8em, first-line-indent: 20pt, justify: true)
  show par: set block(spacing: 1.4em)

  set heading(numbering: none) if no-header == true
  set heading(numbering: "1.1.") if no-header == false

  show heading.where(level: 1): it => {
    block(above: 1.5em, below: 1em)
    if no-header == false {
      counter(math.equation).update(0)
      text(weight: "bold", size: 22pt)[
        #numbering(it.numbering, ..counter(heading).at(it.location()))
      ]
    }
    text(weight: "bold", size: 20pt)[#it.body \ ]
  }

  show heading.where(level: 2): it => {
    block(above: 0.2em, below: 1em)
    if no-header == false {
      text(weight: "bold", size: 15pt)[
        #numbering(it.numbering, ..counter(heading).at(it.location()))
      ]
    }
    text(weight: 700, size: 14pt)[#it.body \ ]
  }

  show figure.where(kind: table): set figure.caption(position: top)

  set math.equation(numbering: num =>
    "(" + str(num) + ")", supplement: "式") if no-header == true
  set math.equation(numbering: num =>
    "(" + ((counter(heading).get().at(0),) + (num,)).map(str).join(".") + ")", supplement: "式") if no-header == false
  

  show: thmrules

  // citation number
  show ref: it => {
    if it.element != none and it.element.func() == figure {
      let el = it.element
      let loc = el.location()
      let chapt = counter(heading).at(loc).at(0)

      link(loc)[#if el.kind == "image" or el.kind == "table" {
          // counting 
          let num = counter(el.kind + "-chapter" + str(chapt)).at(loc).at(0) + 1
          it.element.supplement
          " "
          str(chapt)
          "."
          str(num)
        } else if el.kind == "thmenv" {
          let thms = query(selector(<meta:thmenvcounter>).after(loc), loc)
          let number = thmcounters.at(thms.first().location()).at("latest")
          it.element.supplement
          " "
          numbering(it.element.numbering, ..number)
        } else {
          it
        }
      ]
    } else if it.element != none and it.element.func() == math.equation {
      let el = it.element
      let loc = el.location()
      let chapt = counter(heading).at(loc).at(0)
      let num = counter(math.equation).at(loc).at(0)

      it.element.supplement
      " ("
      str(chapt)
      "."
      str(num)
      ")"
    } else if it.element != none and it.element.func() == heading {
      let el = it.element
      let loc = el.location()
      let num = numbering(el.numbering, ..counter(heading).at(loc))
      if el.level == 1 {
        "第"
        str(num).replace(".", "")
        "章"
      } else if el.level == 2 {
        str(num)
        "節"
      } else if el.level == 3 {
        str(num)
        "項"
      }
    } else {
      it
    }
  }


  set page(numbering: "1 / 1")

  set figure(supplement: "図")

  // date
  align(right, text(12pt)[
    #date.display("[year]年[month]月[day]日")
  ])

  if class != "" {
      align(center, textMargin(
        text(14pt)[#class],
        below: 8pt
      ))
  }

  align(center, text(24pt)[
    *#title*
  ])

  align(center, text(16pt)[
    #author
  ])
  align(center, textMargin(
    text(12pt)[
      #affiliation
    ],
    above: 8pt
  ))

  body

  // Display bibliography.
  if bibliography-file != "" {
    show bibliography: set text(12pt)
    show bibliography: set heading(numbering: "1.")
    bibliography(bibliography-file, title: "参考文献", style: "ieee")
  }
}

#let notag(block: true, body) = {
  math.equation(block: block, numbering: none)[#body]
}

#let theorem = thmbox("theorem", "定理", fill: rgb("#eeeeee"))
#let corollary = thmplain(
  "corollary",
  "系",
  base: "theorem",
  titlefmt: strong
)
#let definition = thmbox("definition", "定義", fill: rgb("#d0f4f5"))
#let lemma = thmplain("lemma", "補題", base: "theorem", titlefmt: strong)

#let example = thmplain("example", "例").with(numbering: none)
#let proof = thmplain(
  "proof",
  "証明",
  base: "theorem",
  bodyfmt: body => [#body #h(1fr) $square$]
).with(numbering: none)

#let remark = thmplain("remark", "Remark").with(numbering: none)