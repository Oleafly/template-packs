// 自作関数の置き場所

#let fig(
  path,
  caption: "",
  width: 100%,
  label: "",
  stroke: 0pt,
  kind: image,
) = [
  #figure(
    caption: caption,
    kind: kind,
  )[
    #box(stroke: stroke)[
      #image(path, width: width)
    ]
  ]
  #if label == auto {
    std.label(path.split(regex("[/\.]")).at(-2))
  } else {
    std.label(label)
  }
]
