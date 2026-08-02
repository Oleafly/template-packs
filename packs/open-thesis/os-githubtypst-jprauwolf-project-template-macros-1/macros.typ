#import "@preview/zebraw:0.6.1": *
#show: zebraw

// creates the titlepage
#let titlePage(
  fachbereich: none,
  titel: none,
  name: none,
  matikelnummer: none,
  email: none,
  erstprüfer: none,
  zweitprüfer: none,
  betreuer: none,
) = {
  page(
    footer: text(align(center)[#datetime.today().display("[day]. [month repr:long] [year]")], lang: "de`"),
    header: none,
    // margin: 2em,
    paper: "a4",
  )[
    #align(center)[
      #grid(
        gutter: 1fr,
        grid(
          row-gutter: 2em,
          image("assets/uk-logo.pdf", height: 1.5cm),
          text(size: 1.6em)[Universität Kassel],
          text(size: 1.4em)[#fachbereich],
        ),
        grid(
          row-gutter: 1em,
          text(size: 1.4em)[#smallcaps()[Bachelor Arbeit]],
          v(2em),
          title(titel),
          v(2em),
          text(size: 1.4em)[_#name _],
          v(0.2em),
          [Mat.-Nr.: #matikelnummer],
          email,
        ),
        grid(
          row-gutter: 0.6em,
          "betreut von",
          erstprüfer,
          zweitprüfer,
          betreuer,
        ),
      )
    ]
  ]
}

// creates a codeblock
#let codeBlock(code, caption: none, subtext: none) = {
  figure(
    [
      #zebraw(numbering-separator: true, code)
      #if subtext != none {
        block(
          subtext,
          width: 80%,
        )
      }
    ],
    caption: caption,
    kind: "code",
    supplement: "Code Block",
  )
}
