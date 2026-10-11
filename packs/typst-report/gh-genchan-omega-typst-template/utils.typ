// 画像の定義
#let fig(
  path, // ファイルパス
  caption: "", // 説明
  width: 100%, // 大きさ
  label: "", // ラベル
  stroke: 0pt, // 枠線
  kind: image // 種類
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
