#import "../template.typ": fit-page, institute-plate, plate

// `k` is the fit-page scale factor. Every size on this page is multiplied by
// it, so a three line title or a fourth team member shrinks the cover to fit
// instead of spilling the last two lines onto a second page.
#let cover-body(config, k) = [
  #set text(size: 16pt * k, font: config.style.fonts.body)

  #strong("VISVESVARAYA TECHNOLOGICAL UNIVERSITY")
  #linebreak()
  JNANASANGAMA, BELAGAVI - 590018

  #pad(y: -8pt * k, image("../template-images/vtu.png", width: 16% * k))

  #strong[#config.subject.cover-name (#config.subject.code)]
  #linebreak()
  #config.cover-line
  #linebreak()

  #block(
    width: 88%,
    text(
      size: config.style.text-size.title * k,
      weight: "bold",
      fill: config.style.title-color,
      config.title,
    ),
  )

  #set text(size: 14pt * k)
  #pad(text(size: 12pt * k, emph[Submitted in partial fulfilment for the award of degree of]))

  #strong(config.degree)
  #linebreak()
  *in*
  #linebreak()
  #strong(upper(config.department.name))
  #linebreak()

  #set text(size: config.style.text-size.body * k)
  #v(1pt * k)
  Submitted by
  #pad(
    y: -10pt * k,
    table(
      row-gutter: -2pt * k,
      stroke: none,
      columns: 2,
      ..config.authors.map(a => (strong(a.name), strong(a.usn))).flatten(),
    ),
  )
  #if config.options.class-section [
    #numbering("I", config.semester.number) #quote(config.semester.section) Section
    #linebreak()
  ]
  #v(1pt * k)
  Under the Guidance of
  #linebreak()
  #strong(config.guide.name)
  #linebreak()
  #config.guide.designation, Dept. of #config.guide.department.abbreviation
  #linebreak()
  BNMIT, Bengaluru

  #pad(top: -8pt * k, bottom: -4pt * k, image("../template-images/bnmit.png", width: 25% * k))

  #institute-plate(config, k: k)

  #set text(size: 16pt * k, font: config.style.fonts.body)
  #strong[Department of #config.department.name]
  #linebreak()
  #underline(strong(config.year))
]

#let cover(config) = plate(config, fit-page(k => cover-body(config, k)))
