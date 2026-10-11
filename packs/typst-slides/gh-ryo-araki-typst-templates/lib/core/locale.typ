#import "tokens.typ": fonts

#let japanese-text-regex = "[\\p{scx:Han}\\p{scx:Hira}\\p{scx:Kana}　！”＃＄％＆’（）*+，−．／：；＜＝＞？＠［＼］＾＿｀｛｜｝〜、。￥・]"

#let jp-spacing(it) = {
  let ghost = text(font: "Adobe Blank", "\u{375}")
  ghost
  it
  ghost
}

#let apply-japanese-text(cjk-font: fonts.at("cjk")) = {
  show regex(japanese-text-regex): set text(font: cjk-font)
}

#let wrap-block-equation() = {
  show math.equation.where(block: true): it => box[#it]
}

#let apply-inline-japanese-math-spacing() = {
  show math.equation.where(block: false): it => jp-spacing(it)
}
