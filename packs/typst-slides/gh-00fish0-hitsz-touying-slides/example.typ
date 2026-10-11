#import "theme.typ": *
#import "@preview/touying:0.7.4": speaker-note

#show: hitsz-theme

// Optional: pass an authorized school wordmark as content to each slide:
// logo: image("assets/local/wordmark-blue.png", width: 220pt)
// cover logo: image("assets/local/wordmark-white.png", width: 260pt)

#cover-slide(
  [研究题目与核心问题],
  kind: [本科毕业设计开题答辩],
  author: [姓名],
  program: [专业名称],
  advisor: [导师姓名],
  date: [2026 年 10 月],
)
#speaker-note[用一句话介绍课题，说明后续汇报结构。]

#content-slide([为什么研究这个问题])[
  #grid(
    columns: (1fr, 1fr),
    gutter: 34pt,
    [
      #kicker[背景]
      #v(12pt)
      说明研究对象和实际场景。
    ],
    [
      #kicker[瓶颈]
      #v(12pt)
      用一项可验证的现象指出问题。
    ],
  )
  #v(34pt)
  #line(length: 100%, stroke: hairline + 1pt)
  #v(16pt)
  *研究目标：*给出明确的改进对象与衡量方法。
]
#speaker-note[解释背景、瓶颈以及研究目标之间的关系。]

#figure-slide([山地湖泊])[
  #grid(
    columns: (445pt, 1fr),
    gutter: 27pt,
    [
      #image("assets/sample-landscape.png", width: 445pt, height: 255pt, fit: "cover")
      #v(7pt)
      #text(size: 12pt, fill: muted)[示例配图由 AI 生成，不对应真实地点。]
    ],
    [
      #kicker[画面]
      #v(11pt)
      山脊与低云位于远处，树林沿湖岸展开。
      #v(22pt)
      #kicker[细节]
      #v(11pt)
      近岸岩石与水面倒影形成前景。
    ],
  )
]
#speaker-note[这一页演示图片与文字并排的内容页布局。]

#content-slide([进度安排与预期结果])[
  #grid(
    columns: (130pt, 1fr),
    row-gutter: 21pt,
    column-gutter: 18pt,
    [#kicker[第一阶段]], [明确数据、基线和评价指标。],
    [#kicker[第二阶段]], [完成方案实现与正确性验证。],
    [#kicker[第三阶段]], [完成对照实验、分析与论文写作。],
  )
]
#speaker-note[这里应讲计划和待验证目标，不把预期写成已有结果。]
