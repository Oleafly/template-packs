#import "@preview/touying:0.7.4": *
#import "@preview/showybox:2.0.4": showybox // Colorful and customizable boxes
#import "@preview/physica:0.9.8": * // Math constructs for science and engineering
#import "@preview/cetz:0.5.2" // Draw figures
#import "@preview/cetz-venn:0.2.0" // Draw venn diagram
#import "@preview/pinit:0.2.2": * // Draw pinit diagram
#import "@preview/cjk-spacer:0.2.1": *

// ========================================
// 参考文献の設定
#import "@preview/enja-bib:0.1.0": *
#import bib-setting-jsme: *

// ========================================

//日付の設定
#let nowdate_jp = {
  [#datetime.today().year()年#datetime.today().month()月#datetime.today().day()日]
}
#let nowdate_slash = {
  [#datetime.today().year()/#datetime.today().month()/#datetime.today().day()]
}

// ========================================

//言語の設定
#let gothic = ("Hiragino Kaku Gothic Pro", "MS PGothic", "IPAexGothic", "Noto Sans CJK JP")
#let mincho = ("Hiragino Mincho Pro", "MS PMincho", "IPAexMincho", "Noto Serif CJK JP")
#let english = ("Times New Roman", "New Computer Modern")


// ========================================

//デフォルトの設定
#let set-init(
  font: gothic,
  body
) = {
  //デフォルトフォントの設定
  set text(font: font)
  //デフォルト言語の設定
  set text(lang: "ja")
  //コードブロックの設定
  show raw.where(block: true): it => {
      set table(stroke: (x, y) => (
        left: if x == 1 { 0.25pt } else { 0pt },
        right: if x == 1 { 0.25pt } else { 0pt },
        top: if y == 0 and x == 1{ 0.25pt } else { 0pt },
        bottom: if x == 1 { 0.25pt } else { 0pt },
      ))
      table(
        columns: (5%, 95%),
        align: (right, left),
        fill: (none, luma(230)),
        inset: 10pt,
        ..for value in it.lines {
          (text(fill: luma(60%),str(value.number)), value)
        }
      )
  }
  show raw.where(block: false): it =>{
    h(0.25em)
    box(fill: luma(220), inset: (x: 0.5em, y: 0pt), outset: (bottom: 0.25em, top: 0.25em), radius: 2pt, align(bottom, it))
    h(0.25em)
  }
  // 和欧文間空白の設定
  show: cjk-spacer

  body
}

// ========================================
// cetz-canvasの設定
#let cetz-canvas = touying-reducer.with(reduce: cetz.canvas, cover: cetz.draw.hide.with(bounds: true))

// ========================================

// tcolorbox equivalent
#let showybox_focus = (
  border-color: white,
  body-color: red.lighten(50%),
)

// ========================================

// Equation annotation with pinit
// https://github.com/OrangeX4/typst-pinit/blob/main/examples/equation-desc.typ
#let pinit-highlight-equation-from(
  height: 0pt, //highlightの高さ
  arrow-length: 20pt, //矢印の長さ
  dx: 0pt, //矢印全体のx座標
  dy: 0pt, //全体のy座標
  dy-line: 0.25pt, // 矢印と枠線の位置調整
  pos: bottom, //矢印の位置（bottom, top, right）
  fill: rgb(0, 0, 0), //矢印の色
  inset: 0.25em, //テキストのinset
  pin1, //highlightの始点
  pin2, //highlightの終点
  body, //テキスト
) = {
  pinit-highlight(
    pin1,
    pin2,
    dy: -dy - 18pt,
    extended-height: height,
    fill: rgb(..fill.components().slice(0, -1), 100),
  ) // 153=255*6/10

  let out-contents = box(stroke: (bottom: fill + 0.12em), inset: (x: inset, y: 5pt), text(fill: fill)[#body])

  if pos == bottom {
    let text-dy = 0.85em
    pinit-place(pin1, out-contents, dx: dx + 20pt, dy: height - dy + arrow-length - 9pt - text-dy - dy-line)
    pinit-arrow(
      pin1,
      pin1,
      fill: fill,
      start-dy: height + arrow-length - dy,
      end-dy: height - dy - 20pt,
      start-dx: dx + 20pt,
      end-dx: dx + 20pt,
    )
  } else if pos == top {
    let text-dy = 0.70em
    pinit-place(pin1, out-contents, dx: dx + 20pt, dy: -dy - 10pt - arrow-length - 15pt - text-dy - dy-line)
    pinit-arrow(
      pin1,
      pin1,
      fill: fill,
      start-dy: -dy + 10pt - arrow-length - 24.8pt,
      end-dy: +34pt - dy - 50pt,
      start-dx: dx + 20pt,
      end-dx: dx + 20pt,
    )
  } else if pos == right {
    let text-dy = 0.76em
    pinit-place(pin2, out-contents, dx: arrow-length + dx, dy: -dy - 25.9pt + height / 2 - text-dy - dy-line)
    pinit-arrow(
      pin2,
      pin2,
      fill: fill,
      start-dx: arrow-length + dx,
      end-dx: 0pt,
      start-dy: -dy - 16pt + height / 2,
      end-dy: -dy - 16pt + height / 2,
    )
  } else if pos == left {
    let text-dy = 0.76em
    pinit-place(pin1, out-contents, dx: -arrow-length + dx, dy: -dy - 25.9pt + height / 2 - text-dy - dy-line)
    pinit-arrow(
      pin1,
      pin1,
      fill: fill,
      start-dx: -arrow-length + dx,
      end-dx: 0pt,
      start-dy: -dy - 16pt + height / 2,
      end-dy: -dy - 16pt + height / 2,
    )
  }
}
