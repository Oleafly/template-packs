#import "@preview/polario-frame:1.0.0": render

#let theme1(model: str, date: str, exif: str, img: image, size: (105mm, 148mm), size-ratio: 1) = {
  let logo = image("apple.svg")
  let model = text(size: 10pt * size-ratio, model)
  let exif = text(size: 6pt * size-ratio, weight: 500, exif)

  let ext-info = (
    "first": model,
    "second": logo,
    "third": exif,
    "background": rgb("#f2f3f8ee"),
  )
  render(
    (size.at(0) * size-ratio, size.at(1) * size-ratio),
    flipped: false,
    theme: "polaroid-bottom-three",
    img: img,
    ext-info: ext-info,
  )
}
