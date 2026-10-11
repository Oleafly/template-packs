#let poster(
  background: none,
  sizeMul: 1,
  content,
) = {
  set page(
    width: sizeMul * 9in,
    height: sizeMul * 12in,
    background: image(background, width: 100%, height: 100%),
    margin: sizeMul * 0.14in,
  )
  set text(size: sizeMul * 0.165in, weight: "medium", font: "Titillium", fill: rgb("36454F"))
  show strong: set text(fill: rgb("bd2033"))
  show heading: set text(font: "lora", weight: "bold", size: sizeMul * 0.19in, fill: rgb("003b81"))
  show heading: set par(leading: 0.5em)
  show math.equation: set text(font: "Fira Math")
  content
}
