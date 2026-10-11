// ============================================================
// 复旦大学学位论文 Typst 模板 - 工具函数
// ============================================================

#import "config.typ": *

// 阿拉伯数字转中文数字（支持 0~99）
#let chinese-number(num) = {
  let digits = ("零", "一", "二", "三", "四", "五", "六", "七", "八", "九")
  if num == 0 { return "零" }
  if num < 0 { return "负" + chinese-number(-num) }
  if num < 10 { return digits.at(num) }
  if num < 100 {
    let tens = calc.div-euclid(num, 10)
    let ones = calc.rem-euclid(num, 10)
    if tens == 1 {
      if ones == 0 { return "十" }
      return "十" + digits.at(ones)
    }
    if ones == 0 { return digits.at(tens) + "十" }
    return digits.at(tens) + "十" + digits.at(ones)
  }
  str(num)
}

// 年份转中文（如 2026 → "二〇二六"）
#let chinese-year(year) = {
  let digits = ("〇", "一", "二", "三", "四", "五", "六", "七", "八", "九")
  let s = str(year)
  s.clusters().map(c => digits.at(int(c))).join()
}

// 中文章节编号格式：第一章 / 1.1 / 1.1.1
#let chinese-numbering(..nums) = {
  let n = nums.pos()
  if n.len() == 1 {
    "第" + chinese-number(n.at(0)) + "章"
  } else {
    n.map(str).join(".")
  }
}

// 附录编号格式：附录 A / A.1 / A.1.1
#let appendix-numbering(..nums) = {
  let n = nums.pos()
  if n.len() == 1 {
    "附录 " + numbering("A", n.at(0))
  } else {
    numbering("A", n.at(0)) + "." + n.slice(1).map(str).join(".")
  }
}

// 学位名称：bachelor → "本科", master → "硕士", doctor → "博士"
#let degree-name(degree) = {
  if degree == "bachelor" { "本科" }
  else if degree == "master" { "硕士" }
  else if degree == "doctor" { "博士" }
  else { degree }
}

// 学位论文名称（用于页眉等）
#let thesis-name(degree) = {
  if degree == "bachelor" { "本科毕业论文（设计）" }
  else if degree == "master" { "硕士学位论文" }
  else if degree == "doctor" { "博士学位论文" }
  else { "学位论文" }
}

// 封面用论文类别（带字间距）
#let thesis-title-spaced(degree) = {
  if degree == "master" {
    text(tracking: 0.5em)[硕士学位论文]
  } else if degree == "doctor" {
    text(tracking: 0.5em)[博士学位论文]
  } else if degree == "bachelor" {
    text(tracking: 0.3em)[本科毕业论文（设计）]
  } else {
    text(tracking: 0.3em)[学位论文]
  }
}

// 空白下划线（用于封面字段填写）
#let blank-underline(width: 100%, body) = {
  box(width: width, stroke: (bottom: 0.5pt), outset: (bottom: 3pt))[
    #align(center, body)
  ]
}

// 将字符串均匀分布在指定宽度内（用于封面标签对齐）
// count 参数指定目标槽位数，2 字标签设 count:4 可与 4 字标签对齐
#let spread-chars(s, width: 4em, count: none) = {
  let chars = s.clusters()
  let n = if count != none { calc.max(count, chars.len()) } else { chars.len() }

  if n == chars.len() {
    box(width: width)[
      #grid(
        columns: (1fr,) * n,
        ..chars.map(c => align(center, c))
      )
    ]
  } else {
    let cells = ()
    for i in range(n) {
      if i == 0 {
        cells.push(align(center, chars.first()))
      } else if i == n - 1 {
        cells.push(align(center, chars.last()))
      } else {
        cells.push([])
      }
    }
    box(width: width)[
      #grid(
        columns: (1fr,) * n,
        ..cells
      )
    ]
  }
}

// 中文日期格式化：2026年3月19日
#let format-date(date) = {
  str(date.year()) + "年" + str(date.month()) + "月" + str(date.day()) + "日"
}

// 中文日期格式化（封面用，带空格）：2026 年 3 月 19 日
#let format-date-cover(date) = {
  str(date.year()) + " 年 " + str(date.month()) + " 月 " + str(date.day()) + " 日"
}

// 智能分页：双面模式从奇数页开始
#let smart-pagebreak(twoside: false) = {
  if twoside {
    pagebreak(weak: true, to: "odd")
  } else {
    pagebreak(weak: true)
  }
}

// 解析命令行布尔参数
#let parse-bool(val, default) = {
  if val == none { default }
  else if val == "true" or val == "1" { true }
  else if val == "false" or val == "0" { false }
  else { default }
}
