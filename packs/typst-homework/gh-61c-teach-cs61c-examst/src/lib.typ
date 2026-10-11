#import "coverpage.typ": *
#import "states.typ": *
#import "questions.typ": *

#let todo(body) = [
  #text(size: 36pt, fill: red)[*TODO:* #body]
]

#let blankpage() = context [
  #set page(header: none)
  #let before = query(selector(<titled-question>).before(here()))
  #let after = query(selector(<titled-question>).after(here()))

  #block(height: 100%, width: 100%, breakable: false)[
    #align(horizon + center)[
      This page left intentionally (mostly) blank <blank-page>

      #v(10pt)

      #if after.len() == 0 [
        Please do not tear off any pages from the exam.
      ] else if before.len() == 0 [
        The exam begins on the next page.
      ] else [
        The exam continues on the next page.
      ]
    ]
  ]

]

#let footer-continues() = context {
  let before = query(selector(<titled-question>).before(here()))
  let after = query(selector(<titled-question>).after(here()))

  let blank-before = query(selector(<blank-page>).before(here()))
  let blank-after = query(selector(<blank-page>).after(here()))

  if before.len() == 0 { return }
  let next-q-page = if after.len() == 0 {
    0
  } else {
    after.first().location().page()
  }

  let last-q-page = before.last().location().page()

  if next-q-page != here().page() + 1 and here().page() != counter(page).at(<exam-end>).at(0) [
    (Question #states.question-num.get().at(0) continues...)
  ]
}

#let header-continued() = context {
  let before = query(selector(<titled-question>).before(here()))
  let after = query(selector(<titled-question>).after(here()))

  let blank-before = query(selector(<blank-page>).before(here()))
  let blank-after = query(selector(<blank-page>).after(here()))

  if before.len() == 0 { return }
  let next-q-page = if after.len() == 0 {
    0
  } else {
    after.first().location().page()
  }

  let last-q-page = before.last().location().page()
  if last-q-page != here().page() and next-q-page != here().page() [
    (Question #states.question-num.get().at(0) continued...)
  ]
}

#let exam-header(class, semester, exam) = {
  set text(10pt)
  header-continued()
}

#let exam-footer(
  class,
  semester,
  exam,
) = context {
  let page-num = counter(page).get().at(0)
  let num-pages = counter(page).final().at(0)

  set text(size: 10pt)
  grid(
    columns: (1fr, 0.3fr, 1fr),
    align: (left, center, right),
    [ #if page-num != 1 [ #exam #footer-continues()]],
    [ Page #page-num of #num-pages ],
    [ #if page-num != 1 [ #class --- #semester ]],
  )

  [ #text(size: 8pt, style: "italic")[ This content is protected and may not be shared, uploaded, or distributed. ]]
}

#let exam(
  class: "CS101",
  instructors: "Alan Turing",
  semester: "Fall 2024",
  exam: "Midterm",
  time: "110 minutes",
  print-answers: false,
  answer-letters: false,
  coverpage: none,
  header: exam-header,
  footer: exam-footer,
  last-edited: datetime.today().display("[weekday], [month repr:long] [day padding:none], [year]"),
  text-size: 11pt,
  text-scale: 1,
  body,
) = {
  
  if type(header) == function {
    
    header = header(class, semester, exam)
  }

  if type(footer) == function {
    footer = footer(class, semester, exam)
  }

  set page(
    paper: "us-letter",
    header: header,
    footer: footer,
    numbering: "1",
  )

  set text(size: text-size)
  show text: set text(size: text-scale * 1em)

  set par(justify: true)

  show heading.where(level: 1): it => titled-question(title: it)
  show heading.where(level: 2): it => titled-subquestion(title: it)
  
  show raw: set text(font: "New Computer Modern Mono", size: 1.25em, weight: 700, top-edge: 5pt)
  
  show raw: it => {
    show "~": set text(font: "Atkinson Hyperlegible Mono", weight: 500)
    show "^": set text(font: "Atkinson Hyperlegible Mono", weight: 500)
    it
  }

  show raw.where(block: true, lang: "text"): it => code-block(it, disp-nums: false)
  show raw.where(block: true, lang: "c"): it => code-block(it, disp-nums: true)
  show raw.where(block: true, lang: "py"): it => code-block(it, disp-nums: true, post-pad: 1em)
  show raw.where(block: true, lang: "riscv"): it => code-block(it, disp-nums: true)

  show ref: it => {
    let el = it.element
    if el != none and (el.func() == text or el.func() == raw) {
      // Override question references.
      qref(it.target)
    } else {
      // Other references as usual.
      it
    }
  }

  if coverpage == none {
    states.print-answers.update(it => print-answers)
    frontpage(class, instructors, semester, exam, time, last-edited)
    states.print-answers.update(it => print-answers)
  } else if type(coverpage) == string {
    include coverpage
  } else if type(coverpage) == function {
    coverpage = coverpage(class, instructors, semester, exam, time, print-answers, header, footer, last-edited)
  }

  [
    #states.show-answer-letters.update(it => answer-letters)
    #body

    #metadata("exam-end") <exam-end>
  ]
}

