#let Logbook(
  name: none,
  fan: none,
  domain: "flinders.edu.au",
  prac_number: none,
  prac_title: none,
  subject_code: none,
  subject_name: none,
  report_type: "Logbook",
  doc
) = {
  import "@preview/codly:1.3.0": *
  import "@preview/codly-languages:0.1.8": *
  show: codly-init.with()
  import "@preview/wavy:0.1.3"

  let __icon(image-filename) = {
    box(
      image(image-filename, height: 0.9em),
      baseline: 0.05em,
      inset: 0pt,
      outset: 0pt,
    ) + h(0.3em)
  }
   
  codly(
    aliases: ("ino":"cpp"),
    languages: (
      ino: (
        name: [Arduino],
        color: blue.lighten(20%),
        icon: __icon("imgs/Arduino Logo.svg")
      ),
      vhdl: (
        name: [VHDL],
        color: purple.lighten(20%),
      ),
    ) + codly-languages
  )

  show raw.where(lang: "vhdl"): set raw(syntaxes: "syntax-highlighting/VHDL.sublime-syntax")
  
  
  import "@preview/cetz:0.3.2"
  import "@preview/cetz-plot:0.1.1"

  set text(region: "AU")
  show figure: set block(breakable: true)

  show raw.where(lang: "wavy"): it => wavy.render(it.text)
  show link: underline

  show "Flinduino": [_Flinduino_]

  set table(
    stroke: 0.5pt
  )

  show table.cell.where(y: 0): set text(weight: "bold")

  page(
    header: [
      #image("imgs/header art.png", width: 100%)
    ],
    margin: (x: 1cm, y: 5cm),
    footer: none,
  )[
    #align(right+horizon)[
      #text(
        fill: blue,
        weight: "bold",
        size: 30pt,
      )[
        #subject_code \
        #subject_name
      ] \ \
      #text(
        weight: "semibold",
      )[
        Practical #prac_number #report_type - #prac_title
      ]
    ]

    #align(right + bottom)[
      #name - #fan \
      #fan\@#domain
    ]
  ]

  pagebreak()

  counter(page).update(1)

  set page(
    margin: (left: 1cm, right: 1cm, top: 1.5cm, bottom: 1.5cm),
    footer: context [
      #line(length:100%) 
      #subject_name #report_type 
      #h(1fr) 
      #counter(page).display("1 of 1", both: true)
    ]
  )

  set par(
    justify: true,
  )
  doc
}