// macros.typ
// --------------------
// マクロ定義ファイル
// --------------------

// 図表用のマクロ
#let ffigure(ja-caption: "", en-caption: "", table-data: none, image-path: none) = {
  if table == none and image == none {
    error("ffigure: table または image のいずれかを指定してください。")
  } else {
    if image-path != none {
      figure(image(image-path), caption: [
        #ja-caption
        #en-caption
      ])
    } else {
      figure(caption: [
        #ja-caption
        #en-caption
      ], if table != none {
        table-data
      })
    }
  }
}
