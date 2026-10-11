#import "../template.typ": fit-page, institute-plate, plate

// "A, B and C" with every name bold and its USN in brackets.
#let print-names(authors) = {
  let formatted = authors.map(a => [*#a.name (#a.usn)*])
  if formatted.len() == 1 {
    formatted.first()
  } else {
    formatted.slice(0, -1).join(", ") + [ and ] + formatted.last()
  }
}

// `k` is the fit-page scale factor; see `fit-page` in template.typ. The
// certificate is the tightest page in the report: the body paragraph grows
// with the title and the author list, and the signature row grows with the
// number of signatories.
#let certificate-body(config, k) = [
  #set text(size: 16pt * k, font: config.style.fonts.body)

  #institute-plate(config, k: k)

  #set text(
    size: config.style.text-size.body * k,
    font: config.style.fonts.body,
  )

  #upper[*Department of #config.department.name*]
  #linebreak()
  #pad(top: -10pt * k, bottom: 0pt, image("../template-images/bnmit.png", width: 22% * k))

  #underline(text([*CERTIFICATE*], size: 14pt * k))

  #set align(left)
  #set par(justify: true, leading: config.style.leading, first-line-indent: 2em)

  Certified that the project work entitled *#quote(config.title)* carried out by
  #print-names(config.authors) bonafide students of
  #numbering("I", config.semester.number) Semester B.E., *B.N.M. Institute of Technology*,
  an Autonomous Institution under Visvesvaraya Technological University, Belagavi
  submitted in partial fulfillment for the #config.degree in
  #upper(config.department.name), during the year #config.year. It is certified that
  all corrections/suggestions indicated for Internal Assessment have been incorporated
  in the report. This report has been approved as it satisfies the academic
  requirements in respect of the project prescribed.

  #set align(center)
  #v(1fr)
  #v(36pt * k)

  // One column per signatory, so two and four both lay out on their own.
  // Justification is switched off here: at four columns each cell is narrow
  // enough that justified text would stretch a wrapped name across it.
  #{
    let compact = config.signatories.len() == 4
    let signatory-size = if compact { 10pt * k } else { config.style.text-size.body * k }
    let signatory-gutter = if compact { 6pt } else { 10pt }
    set text(size: signatory-size)
    set par(justify: false, leading: 0.65em)
    grid(
      columns: config.signatories.map(_ => 1fr),
      column-gutter: signatory-gutter,
      ..config.signatories.map(s => align(
        center,
        stack(spacing: 0.5em, strong(s.name), ..s.lines),
      )),
    )
  }

  #if config.options.external-examiners > 0 [
    #v(1fr)
    #table(
      stroke: none,
      columns: (2fr, 2.5fr, 2fr),
      row-gutter: 12pt * k,
      inset: (x: 0pt, y: 2pt),
      [], [*Name*], [*Signature with Date*],
      ..range(config.options.external-examiners)
        .map(i => ([*Examiner #(i + 1):*], [], []))
        .flatten(),
    )
  ]
]

#let certificate(config) = plate(config, fit-page(k => certificate-body(config, k)))
