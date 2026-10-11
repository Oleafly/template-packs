// Chinese font-size utilities for Typst.
// Values follow the common DTP convention used by Word and Chinese publishing.

#let 初号 = 42pt
#let 小初 = 36pt
#let 一号 = 26pt
#let 小一 = 24pt
#let 二号 = 22pt
#let 小二 = 18pt
#let 三号 = 16pt
#let 小三 = 15pt
#let 四号 = 14pt
#let 小四 = 12pt
#let 五号 = 10.5pt
#let 小五 = 9pt
#let 六号 = 7.5pt
#let 小六 = 6.5pt
#let 七号 = 5.5pt
#let 八号 = 5pt

#let chinese-font-sizes = (
  "初号": 初号,
  "小初": 小初,
  "一号": 一号,
  "小一": 小一,
  "二号": 二号,
  "小二": 小二,
  "三号": 三号,
  "小三": 小三,
  "四号": 四号,
  "小四": 小四,
  "五号": 五号,
  "小五": 小五,
  "六号": 六号,
  "小六": 小六,
  "七号": 七号,
  "八号": 八号,
)

/// Look up a Chinese font size by name.
/// - name (str): Chinese size name such as "小四" or "五号".
/// -> length
#let get-chinese-font-size(name) = {
  assert(
    type(name) == str,
    message: "font size name must be a string, found " + repr(type(name)),
  )
  assert(
    name in chinese-font-sizes,
    message: "undefined Chinese font size: " + name,
  )
  chinese-font-sizes.at(name)
}
