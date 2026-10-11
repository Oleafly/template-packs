#let din = (
  address: (x: 20mm, y: 45mm, width: 85mm, inset: 5mm),
  return-zone-height: 5mm,
  annotation-zone-height: 12.7mm,
  recipient-zone-height: 27.3mm,
  info: (x: 125mm, y: 50mm, width: 75mm, height: 40mm),
  body-start: 98.46mm,
  fold-marks: (105mm, 210mm),
  hole-mark: 148.5mm,
  margin: (top: 20mm, right: 20mm, bottom: 20mm, left: 25mm),
)

#let letter(
  sender: none,
  return-address: none,
  annotations: none,
  recipient: none,
  reference: none,
  location: none,
  date: none,
  subject: none,
  font: "Lucida Sans OT",
  debug: false,
  body,
) = {
  let frame = if debug { 0.25pt + red } else { none }
  let display-date = if type(date) == datetime {
    date.display("[day].[month].[year]")
  } else {
    date
  }

  set text(lang: "de", size: 10pt, font: font)
  set par(justify: true, leading: 0.65em, spacing: 1.65em)
  set enum(numbering: "(1)")
  set list(marker: "–")

  let address-zone(height, content) = box(
    width: din.address.width,
    height: height,
    inset: (left: din.address.inset),
    stroke: frame,
    clip: true,
    content,
  )

  set page(
    paper: "a4",
    margin: din.margin,
    background: context if counter(page).get().first() == 1 {
      for y in din.fold-marks {
        place(top + left, dy: y, line(length: 5mm, stroke: 0.5pt + gray))
      }
      place(top + left, dy: din.hole-mark, line(length: 10mm, stroke: 0.5pt + gray))

      place(top + left, dx: din.address.x, dy: din.address.y, stack(
        address-zone(din.return-zone-height, align(bottom, text(6.5pt, bottom-edge: "descender", return-address))),
        address-zone(din.annotation-zone-height, text(8pt, annotations)),
        address-zone(din.recipient-zone-height, recipient),
      ))

      place(top + left, dx: din.info.x, dy: din.info.y, box(
        width: din.info.width,
        height: din.info.height,
        stroke: frame,
        {
          sender
          v(1fr)
          if reference != none {
            [Aktenzeichen: #reference]
            v(1fr)
          }
          if location != none [Ort: #location\ ]
          if date != none [Datum: #display-date]
        },
      ))
    },
    footer: context {
      let last = counter(page).final().first()
      if last > 1 {
        align(right, text(8pt)[Seite #counter(page).display() von #last])
      }
    },
  )

  v(din.body-start - din.margin.top)
  strong(subject)
  v(1em)
  body
}
