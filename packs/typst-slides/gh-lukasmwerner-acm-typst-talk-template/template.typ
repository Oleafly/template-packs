#let conf(
  paper: "presentation-16-9",
  document
) = {
  set page(
    paper: paper,
    background: image(
      "background.png",
      fit: "cover",
      width: 100%,
      height: 100%,
    ),
    foreground: [
      #place(top+right,
        pad(
          rest: 0.5in,
          image("logo.png", width: 1in)
        )
      )
    ]
  )
  set text(
    fill: white,
    font: "Arial",
    size: 40pt,
  )
  document
}
