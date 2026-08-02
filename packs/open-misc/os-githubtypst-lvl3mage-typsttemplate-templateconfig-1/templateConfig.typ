#let template(title: [], author: [],  textFont:"", headingFont:"", background:color.white, textColor:color.black) = (body) =>{
  set document(
    title: title,
    author: author, 
  )
  set page(
    paper: "a4",
    fill: background,
    header: context {
      if here().page() > 1 {
        set text(font: headingFont, style: "italic", size: 10pt, fill: textColor)
        grid(
          columns: (1fr, 1fr),
          align: (left, right),
          [#title], [#author],
        )
        let inset = 0%
        line(start: (inset, 0%), end: (100% - inset, 0%), stroke: (
          paint: textColor.transparentize(50%),
          thickness: 1pt,
          dash: "loosely-dotted",
        ))
      }
    },
    footer: context {
      if here().page() > 1 {
        set text(font: headingFont, style: "italic", size: 10pt, fill: textColor)

        let inset = 0%
        line(start: (inset, 0%), end: (100% - inset, 0%), stroke: (
          paint: textColor.transparentize(50%),
          thickness: 1pt,
          dash: "loosely-dotted",
        ))
        align(center)[Page #counter(page).display("1/1", both: true)]
      }
    },
  )
  set text(
    font: textFont,
    size: 11pt,
    fill: textColor,
    lang: "en",
  )
  set par(
    // first-line-indent: 1em,
    spacing: 1.2em,
    justify: true,
  )

  show link: set text(blue)
  show link: underline
  [#body]

}