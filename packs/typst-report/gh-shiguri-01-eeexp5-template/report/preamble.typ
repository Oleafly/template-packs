#import "@preview/cjk-spacer:0.1.0": cjk-spacer
#import "@preview/zero:0.5.0": format-table, num, set-unit, zi
#import "@preview/subpar:0.2.2"

#let serif = ((name: "STIX Two Text", covers: "latin-in-cjk"), "Yu Mincho")
#let sans = ("Arial", "Noto Sans JP")
#let math-font = ("STIX Two Math", "STIX Two Text", "Yu Mincho")
#let _ja_scale = 0.95em
#let _first_line_indent = 1em

/// 数式ブロックの前後で段落を維持したいときの回避策
///
/// = Example
/// ```typ
/// 二次関数は、
/// #keepp[$ y = a x^2 + b x + c $]
/// と表せる。
///
/// 一次関数は、
/// #keepp[$ y = a x + b $<eq:一次関数>]
/// と表せる。
/// ```
/// - body (content): 数式などのコンテンツ
/// -> content
#let keepp(body) = [
  #body
  #h(-1 * _first_line_indent) // つづく段落の字下げを埋める
]

/// 単位をブラケットに入れる
///
/// 量記号 + 単位を表示する場合に使う。
/// 量記号とブラケットの間にいい感じにスペースが挿入される。
///
/// 数値 + 単位を表示したい場合はブラケットはそもそもブラケット不要。
///
/// - unit (content): 単位
/// -> content
#let bu(unit) = [
  $space.thin [#unit]$
]

#let doc(content) = {
  show: cjk-spacer

  set page(paper: "a4", numbering: "1")

  // フォント
  set text(
    font: serif,
    size: 11pt,
    lang: "ja",
  )
  let japanese-chars = regex(
    "[\p{Han}\p{Hiragana}\p{Katakana}、。，．・ー〜…々「」『』【】（）！？　]+",
  )
  show japanese-chars: it => {
    text(size: _ja_scale, it)
  }

  // 段落
  set par(first-line-indent: (amount: _first_line_indent, all: true), leading: 1em)

  // 見出し
  // `1.`や`1.1`のように表示する
  set heading(numbering: (..nums) => {
    if nums.pos().len() == 1 {
      nums.pos().map(str).join() + "."
    } else {
      nums.pos().map(str).join(".")
    }
  })
  show heading: set text(font: sans, weight: "medium")

  // 数式
  let eq_sup = [式]
  set math.equation(numbering: "(1)", supplement: eq_sup)
  show math.equation: set text(font: math-font)
  show ref: it => {
    let eq = math.equation
    let el = it.element

    // 数式以外の参照はそのまま
    if el == none or el.func() != eq { return it }

    let sup = it.supplement
    let sup_cnt = if sup == none {
      []
    } else if sup == auto {
      eq_sup
    } else if type(sup) == function {
      sup(el)
    } else {
      sup
    }

    link(el.location(), [
      #sup_cnt
      #numbering(
        el.numbering,
        ..counter(eq).at(el.location()),
      )])
  }

  // 表
  show figure.where(
    kind: table,
  ): set figure.caption(position: top)
  set table(
    stroke: none,
  )

  // リスト
  set enum(numbering: "(1)")

  // 句読点
  // showを使うとアキの調節が適切に機能しないため、textlintで対応する
  // show "、": "，"
  // show "。": "．"

  // ページ番号（表紙を追加するので2から始める）
  counter(page).update(2)

  // 参考文献
  set bibliography(
    title: "参考文献",
    style: "ref_style.csl",
  )

  set-unit(fraction: "inline")

  content
}
