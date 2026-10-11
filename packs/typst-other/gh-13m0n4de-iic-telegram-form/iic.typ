#import "@preview/curvly:0.1.0": *

#let telegram(
  message: none,
  from: none,
  to: none,
  route: none,
  preamble: none,
  circuit: none,
  clerk-name: none,
  time-received: none,
  text-rotate: 0deg,
  text-dx: none,
  text-dy: none,
  header-image: none,
  form-number: "(Message Form 5/17A-161).",
  printer-mark: "L & P (c).",
  paper-color: rgb("#eee4cd"),
  accent-color: rgb("#BD4238"),
  message-color: rgb("#2E4A8C"),
  handwriting-color: rgb("#1E3A5F"),
  form-font: "Libertinus Serif",
  typewriter-font: ("Liberation Mono", "DejaVu Sans Mono"),
  handwriting-font: "Caveat",
) = {
  set page(
    width: 200mm,
    height: 210mm,
    margin: (top: 1mm, bottom: 1mm, left: 2mm, right: 2mm),
    fill: paper-color,
  )
  set text(font: form-font, lang: "en", size: 9pt)
  set par(spacing: 0pt)

  align(right, text(fill: accent-color, size: 7pt, weight: "bold")[#form-number])
  v(0.5em)
  align(
    center,
    text(
      fill: accent-color,
      size: 15pt,
      weight: "bold",
      tracking: 0.5pt,
    )[IMPERIAL AND INTERNATIONAL COMMUNICATIONS LIMITED],
  )
  v(1em)

  block(
    inset: (x: 10pt),
    block(
      inset: 1.5pt,
      stroke: (paint: black, thickness: 0.5pt),
      block(
        width: 100%,
        height: 60mm,
        stroke: (paint: black, thickness: 0.5pt),
        clip: true,
        image(header-image, width: 100%, height: 100%),
      ),
    ),
  )

  let stamp-dx = 10pt
  let stamp-dy = 103pt
  {
    set text(font: typewriter-font, size: 6pt, weight: "bold", fill: accent-color)
    place(right + top, dx: 0pt, dy: stamp-dy + 47pt, rect(width: 60pt, height: 60pt, fill: paper-color))
    place(
      right + top,
      dx: stamp-dx,
      dy: stamp-dy,
      text-on-circle("OFFICE OF ISSUE.", "FULL ADDRESS ON BACK.", 100pt, 70deg, 100deg),
    )
    place(
      right + top,
      dx: stamp-dx,
      dy: stamp-dy,
      circle(radius: 50pt, fill: paper-color, stroke: 0.5pt, outset: -7pt),
    )
  }

  set text(font: typewriter-font, weight: "bold")

  let label-cell(body) = table.cell(
    stroke: (top: none, bottom: none),
    text(fill: accent-color, size: 6pt, body),
  )
  let writing-cell(body) = table.cell(
    stroke: (top: none),
    text(font: handwriting-font, weight: "regular", size: 16pt, fill: handwriting-color, body),
  )

  table(
    columns: (3em, 8em, 11em, 11em, 1fr),
    rows: (2.5em, 3.5em, 33.5em),
    stroke: (paint: accent-color, thickness: 1pt),
    align: center,

    table.cell(
      rowspan: 3,
      align: left + horizon,
      stroke: (top: none, left: none),
      rotate(
        -90deg,
        reflow: true,
        text(fill: accent-color, size: 6pt)[
          #h(4em)The first line of this Telegram contains the following particulars in the order named:---
          Prefix Letters and Number of Message, Office of Origin, Number of Words, Date, Time handed in
          and Official instructions --- if any.
        ],
      ),
    ),

    label-cell[Circuit.],
    label-cell[Clerk's\ Name.],
    label-cell[Time\ Received.],

    table.cell(
      rowspan: 2,
      align: left + bottom,
      stroke: (top: none, right: none),
      inset: (x: 1em, y: 0pt),
      text(fill: accent-color, size: 60pt, weight: "extrabold")[],
    ),

    writing-cell[#circuit],
    writing-cell[#clerk-name],
    writing-cell[#time-received],

    table.cell(
      colspan: 4,
      align: left + top,
      stroke: (right: none),
      inset: 20pt,
      {
        set text(font: typewriter-font, fill: message-color, size: 13pt, weight: "regular")
        set par(leading: 2em, spacing: 2em)

        let body = [
          #route

          #preamble

          #to

          #message

          #pad(left: 21em)[#from]
        ]

        if text-dx != none or text-dy != none {
          move(
            dx: if text-dx != none { text-dx } else { 0pt },
            dy: if text-dy != none { text-dy } else { 0pt },
            rotate(text-rotate, body),
          )
        } else {
          rotate(text-rotate, body)
        }
      },
    ),
  )

  v(1em)
  set text(fill: accent-color, size: 7pt)
  grid(
    columns: (auto, 1fr),
    pad(left: 1em, text(font: form-font)[#printer-mark]),
    align(
      center,
      [
        NO ENQUIRY RESPECTING THIS TELEGRAM CAN BE ATTENDED TO WITHOUT PRODUCTION OF THIS COPY.\
        REPLIES SHOULD BE HANDED IN AT ONE OF THE COMPANY'S OFFICES.
      ],
    ),
  )
}
