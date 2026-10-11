// Die Datei beinhaltet eigene Funktionen, die in anderen Typst-Dateien importiert werden können.

// Package-Importe
// Codly für bessere Codeblöcke
#import "@preview/codly:1.3.0" : *
#import "@preview/codly-languages:0.1.8" : *
#import "@preview/glossarium:0.5.10": make-glossary, register-glossary, print-glossary, gls, glspl
#import "_setup.typ": *

// für codeblöcke diese funktion verwenden -> sonst code nicht in tocfiles/loc.typ
#let codefigure(caption: "Code", codeblock: "") = figure(
  supplement: "C",
  caption: caption,
  kind: "code",
  [#codly(languages: codly-languages)
    #codeblock
  ]
)

// für Bilder
#let imagefigure(caption: "Bild", src: "", height : auto, width : auto) = figure(
  supplement: "F",
  image(height: height, src, width: width),
  caption: caption
)

#let twoimagesfigure(caption1: "Bild 1", caption2: "Bild 2", src1: "", src2: "", height : 100pt, width1: 50%, width2: 50%, gutter: auto) = align(center)[
  #block(width: 100%)[
    #grid(
      columns: (width1, width2),
      gutter: gutter,
      align(left)[
        #imagefigure(
          caption: caption1,
          src: src1,
          width: 100%,
          height: height
        )
      ],
      align(right)[
        #imagefigure(
            caption: caption2,
            src: src2,
            width: 100%,
            height: height
          )
      ]
    )
  ]
]

#let llmUsecase(
  date: none,
  contentref: [Kein Inhalt wurde übernommen.],
  llm: [Mistral LeChat Pro @mistral],
  prompt: none,
  input: none,
  output: none,
  description: none
) = {
  block(
    width: 100%,
    breakable: true,
    stroke: 0.5pt + gray,
    radius: 4pt,
    inset: FontSizeM,
    fill: luma(253),
    [
      #place(top + right)[#text(size: FontSizeS)[#date]]
      #if description != none [
        *Anmerkungen:* #linebreak() #description
        #v(0.2em)
      ]
      *Inhaltsverweis:* #linebreak() #contentref
      #v(0.2em)
      *Anweisung*
      #block(width: 100%, fill: rgb("eef5fd"), inset: FontSizeS, radius: 4pt, prompt)
      *Eingabe* #text(size: FontSizeS)[(eigener Text oder Daten)]
      #block(width: 100%, fill: rgb("f5f5f5"), inset: FontSizeS, radius: 4pt, input)
      *Ausgabe* #text(size: FontSizeS)[(generiert von #llm)]
      #block(width: 100%, fill: rgb("eefdee"), inset: FontSizeS, radius: 4pt, output)
    ]
  )
  v(.3em)
}
