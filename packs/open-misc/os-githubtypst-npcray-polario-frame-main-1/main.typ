#import "@preview/polario-frame:1.0.0": render

#let theme1(model: str, exif: str, img: image, size: (105mm, 148mm), size-ratio: 1) = {
  let logo = image("Hasselblad-H.svg", width: 20pt * size-ratio)
  let brand-model = text(size: 8pt * size-ratio, model)
  let exif = text(size: 6pt * size-ratio, fill: gray)[46mm f/1.63 1/500s ISO3200]
  let second = stack(
    spacing: 10%,
    logo,
    brand-model,
    exif,
  )

  let ext-info = (
    "second": second,
    "extend-ratio": 15%,
    "extend-middle-ratio": 100%,
  )
  render(
    (size.at(0) * size-ratio, size.at(1) * size-ratio),
    flipped: false,
    theme: "polaroid-bottom-three",
    img: img,
    ext-info: ext-info,
  )
}
