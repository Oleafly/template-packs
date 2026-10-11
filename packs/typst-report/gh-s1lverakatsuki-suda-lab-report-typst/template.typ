#let title-content = "苏州大学实验报告"

// 实验名称
#let assignment = "实验一"
// 姓名
#let author = [你的名字]
// 班级（通常为年级 专业的形式）
#let class = [年级 专业]
// 实验日期
#let date = [1970-01-01]
// 同组实验者，若没有则填「无」
#let friends = [无]
// 课程名称
#let lesson = [XXX 课程实践]
// 学院
#let school = [学院]
// 学号
#let student-id = "XXX"
// 教师
#let teacher = "XXX"

// 当前页数
// 由于 Typst 的限制，为了实现内容框，目前页数必须手动指定。
// 如果写的内容塞不下就改大
#let num-pages = 1

// 页面比例
// 如果改了字体，微调这个 83%
// 不调可能会多页或是渲染缺失
#let page-percent = 83%

// 改成你想要的字体
// 默认使用 Windows 内自带字体
// 代码中的中文看起来很奇怪请往 code-font 主字体后面加一个中文字体
#let kaiti = "KaiTi"
#let main-font = ("Times New Roman", "SimSun")
#let code-font = ("Consolas", "Microsoft YaHei")

// 下面是自由字体，
// #let kaiti = "AR PL KaitiM GB"
// #let main-font = ("Noto Serif", "Noto Serif CJK SC")
// #let code-font = ("MapleMono NF")

// ----------------------------------以下是模板不要动----------------------------------

#set text(lang: "zh", region: "cn")
#set page(
  paper: "a4",
  footer: context [
    #table(
      columns: (20%, 60%, 20%),
      inset: 0pt,
      stroke: none,

      [],
      align(center, text(counter(page).display("第 1 页，共 1 页", both: true), fill: rgb("8B8B8B"))),
      align(right, text(font: kaiti, weight: "bold", fill: rgb("8B8B8B"))[教务处制]),
    )
  ],
)
#set text(font: main-font, size: 10.5pt)
#show raw: set text(font: code-font)
#set par(first-line-indent: (amount: 0em, all: true))
#set enum(indent: 0em)
#set list(indent: 0em)
#set heading(numbering: (..nums) => {
  nums = nums.pos()
  if (nums.len() == 1) {
    return numbering("一、", ..nums)
  } else {
    return numbering("1.", ..nums).slice(0, -1)
  }
})

#show title: set align(center)
#show title: set text(font: kaiti, size: 24pt, tracking: 0.5em)
#show heading: set text(size: 10.5pt)
#show raw: set text(size: 10.5pt)

#let idt = { h(2em) }
#let idt-block(body) = block(inset: (x: 2em))[#body]

#title[#underline(title-content, evade: false)]

#block[
  #set text(
    font: kaiti,
    size: 12pt,
  )
  #table(
    stroke: 0.5pt,
    columns: (auto, auto, auto, 1fr, auto, auto, auto, auto),
    align: center,
    inset: 4pt,
    [院、系], school, [年级专业], class, [姓名], author, [学号], student-id,
    [课程名称], table.cell(colspan: 5)[#lesson], [成绩], [],
    [指导教师], teacher, [同组实验者], table.cell(colspan: 2)[#friends], [实验日期], table.cell(colspan: 2)[#date],
  )
]

#show raw.where(block: true): it => {
  block(
    fill: rgb("D9D9D9"),
    width: 100%,
    inset: 0.5em,
    it,
  )
}

#align(center)[
  #grid(
    columns: (auto, auto),
    column-gutter: 0.5em,

    [实 验 名 称],

    stack(
      dir: ttb,
      spacing: 2pt,

      box(assignment + ""),

      line(length: calc.max(calc.min(assignment.len() * 1em, 38em), 10em), stroke: 0.5pt),
    ),
  )
]

#block(
  clip: true,
  stroke: 0.5pt + black,
  inset: 6pt,
  width: 100%,
  height: page-percent + (num-pages - 1) * 100%,
)[
  // ----------------------------------以上是模板不要动--------------------------------
  = 实验目的

  默认是顶格的写法，不然列表层级会有问题。

  - aaa
  - bbb

  + ccc
  + ddd
  + eee

  = 实验内容

  #idt
  使用 `#idt` 首行缩进

  // 你可以不为代码块指定语言，这样就看起来更像是官方的模板
  ```rs
  fn main() {
    println!("代码块展示")
  }
  ```

  #idt-block[
    1. 这样写列表会看的顺眼一些
    2. 用 `#idt-box` 包裹
  ]

  #idt-block[
    ```rs
    assert!("代码块也是一样的");
    ```
  ]


  = 实验步骤和结果

  = 实验总结
]
