#import "template.typ": *

// 主题颜色
#let theme-color = rgb("#000000")
#let icon = icon.with(fill: theme-color)

// 设置图标, 来源: https://fontawesome.com/icons/
#let fa-award = icon("icons/fa-award.svg")
#let fa-building-columns = icon("icons/fa-building-columns.svg")
#let fa-code = icon("icons/fa-code.svg")
#let fa-envelope = icon("icons/fa-envelope.svg")
#let fa-github = icon("icons/fa-github.svg")
#let fa-graduation-cap = icon("icons/fa-graduation-cap.svg")
#let fa-linux = icon("icons/fa-linux.svg")
#let fa-phone = icon("icons/fa-phone.svg")
#let fa-windows = icon("icons/fa-windows.svg")
#let fa-wrench = icon("icons/fa-wrench.svg")
#let fa-work = icon("icons/fa-work.svg")
#let fa-trophy = icon("icons/fa-trophy.svg")
#let fa-weixin = icon("icons/fa-weixin.svg")
#let fa-book = icon("icons/fa-book.svg")
#let fa-cogs = icon("icons/fa-gear.svg")
#let fa-briefcase = icon("icons/fa-briefcase.svg")

#let section_heading(icon, title) = box(inset: 0.5pt)[#icon #h(0.1em)#title]
#let inline_logo(path, h: 1.55em) = box(
  baseline: 100%,
  inset: 0pt,
  image(path, height: h),
)
// 间距参数（直接改这里）
#let line_leading = 0.6em
#let paragraph_spacing = 0.6em
#let bullet_item_spacing = 0.6em
#let bullet_indent = 0.5em
#let page_margin_left = 0.86cm
#let page_margin_right = 0.86cm
#let edu_col_icon = 1.55em
#let edu_col_school = 3.8cm
#let edu_col_major = 1fr
#let edu_col_right = 3.6cm
#let edu_col_gutter = 0.35em
#let edu_row_spacing = 0.08em

#let edu_row(
  icon_path,
  school,
  major,
  degree,
  date,
) = grid(
  columns: (edu_col_icon, edu_col_school, edu_col_major, edu_col_right),
  column-gutter: edu_col_gutter,
  align: (left + bottom, left + bottom, left + bottom, right + bottom),
  [#inline_logo(icon_path)],
  [*#school*],
  [#emph[#major]],
  [#emph[#degree] #h(0.8em) #date],
)
#let bullet_line(body) = pad(
  left: bullet_indent,
  grid(
    columns: (auto, 1fr),
    column-gutter: 0.28em,
    align: (left, left),
    [•],
    [#body],
  ),
)

#set page(footer: none)

// 设置简历选项与头部（保持 resume.typ 的模板结构）
#show: resume.with(
  size: 9pt,
  theme-color: theme-color,
  margin: (
    top: 1cm,
    bottom: 0cm,
    left: page_margin_left,
    right: page_margin_right,
  ),
  photograph: "",
  photograph-width: 0em,
  gutter-width: 0em,
)[
  #set text(font: ("Times New Roman", "Songti SC"), size: 10.8pt)
  #set par(leading: line_leading, spacing: paragraph_spacing)

  #grid(
    columns: (1fr, auto),
    column-gutter: 1cm,
    [
      = 简历模板展示（中文）
      #h(1.2em)
      #stack(
        spacing: 1.1em,
        [#fa-phone 电话：(+1) 617-555-0142],
        [#fa-envelope 邮箱：resume.template\@example.com],
        [#fa-github 主页：#link("https://github.com/resume-template")[#underline[github.com/resume-template]]],
      )
    ],
    [
      #align(right)[#image("IDphoto.png", height: 2.8cm)]
    ],
  )
][
  #set text(font: ("Times New Roman", "Songti SC"), size: 10.8pt)
  #set par(leading: line_leading, spacing: paragraph_spacing)

  == #section_heading(fa-graduation-cap, "教育经历")

  #edu_row("icon/pku.png", [北京大学], [计算机科学与技术], [本科], [2017.9 - 2021.6])
  #v(edu_row_spacing)
  #edu_row("icon/mit.svg.png", [麻省理工学院（MIT）], [计算机科学], [博士], [2021.9 - 2026.6])

  #stack(
    spacing: bullet_item_spacing,
    bullet_line[*研究方向*：大语言模型、推理增强、智能体系统与多模态学习。],
    bullet_line[*代表课程*：机器学习、概率图模型、分布式系统、高级算法、统计推断与优化方法。],
    bullet_line[*学术活动*：担任多个国际顶会审稿人并参与跨校联合研究项目。],
  )

  == #section_heading(fa-book, "论文发表")

  #stack(
    spacing: bullet_item_spacing,
    bullet_line[*Attention Is All You Need*（arXiv:1706.03762，2017）],
    bullet_line[*作者*：Ashish Vaswani, Noam Shazeer, Niki Parmar, Jakob Uszkoreit, Llion Jones, Aidan N. Gomez, Lukasz Kaiser, Illia Polosukhin],
    bullet_line[*核心贡献*：提出仅依赖注意力机制的 Transformer 架构，完全去除 RNN/CNN，显著提升并行训练效率与建模能力。],
    bullet_line[*关键结果*：WMT14 英德翻译 BLEU 28.4（较当时最优提升 2+）；英法翻译 BLEU 41.8，达到单模型 SOTA。],
  )

  == #section_heading(fa-trophy, "荣誉奖项")

  #pad(left: bullet_indent)[
    #grid(
      columns: (auto, 1fr, auto),
      column-gutter: 0.35em,
      row-gutter: bullet_item_spacing,
      align: (left, left, right),
      [•],
      [诺贝尔物理学奖（Nobel Prize in Physics）],
      [*2024*],
      [•],
      [诺贝尔化学奖（Nobel Prize in Chemistry）],
      [*2023*],
      [•],
      [诺贝尔经济学奖（Nobel Memorial Prize in Economic Sciences）],
      [*2022*],
    )
  ]

  == #section_heading(fa-cogs, "专业技能")

  #stack(
    spacing: bullet_item_spacing,
    bullet_line[*编程语言*：Python、C++、Rust、SQL。],
    bullet_line[*模型与系统*：熟悉 PyTorch、JAX、分布式训练、RAG、Agent 工作流与在线推理优化。],
    bullet_line[*工程能力*：能够从研究原型快速落地到可观测、可评测、可灰度发布的生产系统。],
  )

  == #section_heading(fa-briefcase, "实习经历")

  #grid(
    columns: (auto, 5.4cm, 1fr, auto),
    column-gutter: 0.45em,
    align: (left + bottom, left + bottom, left + bottom, right + bottom),
    [#inline_logo("icon/Openai.ico.png")],
    [#link("https://openai.com/")[#underline[*OpenAI*]]],
    [研究工程实习生],
    [2025.6 - 2025.9],
  )
  #stack(
    spacing: bullet_item_spacing,
    bullet_line[*STAR 法则定义*：STAR 是结构化表达经历的方法，*S（Situation）* 指背景场景，*T（Task）* 指目标任务，*A（Action）* 指关键行动，*R（Result）* 指最终结果。],
    bullet_line[*写作原则*：先交代背景与目标，再描述本人采取的核心动作，最后给出量化结果（如准确率、时延、成本、效率提升），避免只罗列“做了什么”。],
  )

  #grid(
    columns: (auto, 5.4cm, 1fr, auto),
    column-gutter: 0.45em,
    align: (left + bottom, left + bottom, left + bottom, right + bottom),
    [#inline_logo("icon/gemini.png")],
    [#link("https://deepmind.google/technologies/gemini/")[#underline[*Google DeepMind (Gemini)*]]],
    [核心研究实习生（Gemini 3.1 Pro）],
    [2025.10 - 2026.2],
  )
  #stack(
    spacing: bullet_item_spacing,
    bullet_line[
      *S（Situation）*：团队需要在固定算力预算内提升 Gemini 3.1 Pro 的综合能力并保证训练稳定性。 \
      *T（Task）*：负责 Gemini 3.1 Pro 模型训练方案的设计、执行与迭代。 \
      *A（Action）*：持续优化数据配比、训练调度与超参数设置，按阶段跟踪收敛曲线和核心评测表现，针对异常批次快速回滚并重训。 \
      *R（Result）*：模型收敛更稳定、训练效率显著提升，在数学推理、代码与长上下文等多项指标达到当期 SOTA。
    ],
  )

  #line(length: 100%)
  #v(0.15em)
  #text(size: 8.1pt)[
    #fa-github #h(0.12em)*Github*：#link("https://github.com/resume-template")[#underline[resume-template]]， #fa-weixin #h(0.12em)*Wechat*：ResumeTemplate
  ]
]
