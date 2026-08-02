#import "@preview/polario-frame:1.0.0": render

#let theme1(model: str, date: str, exif: str, img: image, size: (105mm, 148mm), size-ratio: 1) = {
  let logo = image("Zeiss.svg", width: 20pt * size-ratio)
  let model = text(size: 8pt * size-ratio, model)
  let date = text(size: 6pt * size-ratio, fill: rgb("#8f7f7f"), date)
  let exif = text(size: 8pt * size-ratio, weight: 500, exif)


  let address = text(size: 6pt * size-ratio, fill: rgb("#8f7f7f"))[31°19'7'' N ~~ 120°05'0'' E]
  let line-v = line(stroke: 0.5pt * size-ratio + black, length: 25%, angle: 90deg)
  let info = stack(spacing: 20%, exif, address)

  let first = grid(
    align: left,
    box(width: 90%, stack(dir: ltr, spacing: 2%, model, line-v, logo)),
  )
  let second = grid(
    align: right,
    box(width: 90%, stack(spacing: 10%, exif, date)),
  )

  let ext-info = (
    "first": first,
    "second": second,
    "extend-half-ratio": 50%,
  )
  render(
    (size.at(0) * size-ratio, size.at(1) * size-ratio),
    flipped: true,
    theme: "classic-bottom-two",
    img: img,
    ext-info: ext-info,
  )
}
