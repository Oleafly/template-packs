#import "style/index.typ": presentation-theme
#import "slides/index.typ": (
  agenda-page, cover-page, end-page, references-manual-page, subject-content-page, subject-text-image-page,
  subject-triple-gallery-page, transition-page,
)

#let report-title = [pkusli 模板介绍]
#let report-subtitle = [Typst / Touying 中文演示工作流]
#let report-author = [Ethan]
#let report-institution = [Peking University]
#let report-date = [2026-06-04]
#let demo-image = "figures/background.png"

#let component-card(title, body) = [
  #block(width: 100%, height: 100%)[
    #align(center + horizon)[
      #set align(center)
      #text(size: 1.08em, weight: "bold")[#title]
      #v(0.36em)
      #text(size: 0.68em)[#body]
    ]
  ]
]

#let bottom-grid(left-title, left-body, right-title, right-body) = [
  #v(0.68em)
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 1.05em,
    [
      #set text(size: 0.78em)
      #set par(leading: 0.48em)
      #text(weight: "bold")[#left-title]
      #v(0.12em)
      #left-body
    ],
    [
      #set text(size: 0.78em)
      #set par(leading: 0.48em)
      #text(weight: "bold")[#right-title]
      #v(0.12em)
      #right-body
    ],
  )
]

#show: presentation-theme

#cover-page(
  title: report-title,
  subtitle: report-subtitle,
  author: report-author,
  institution: report-institution,
  date: report-date,
)

#agenda-page(
  left-card-dy: 1.5em,
  right-card-dy: 1.5em,
  sections: (
    [01 / 模板定位],
    [02 / 页面组件],
    [03 / 使用流程],
    [04 / 协作交付],
  ),
)

#transition-page(
  number: [01],
  marker: [PART],
  left-card-dx: 0pt,
  left-card-dy: 1.5em,
  right-card-dx: 0pt,
  right-card-dy: 1.5em,
  title: [模板定位],
  description: [先明确模板服务的对象、解决的问题，以及它适合承载的中文正式汇报类型。],
)

#subject-content-page(
  title: [为什么选择 pkusli],
  header-left-offset: 10em,
  top-content: [一句话结论：pkusli 把中文正式汇报的常见版式预先封装成可复用组件。],
  content-text-size: 0.9em,
  content-text-leading: 0.72em,
  content: [
    `pkusli` 的目标不是替代演讲内容，而是降低从空白页面开始搭版的成本：

    - 结构先行：封面、目录、章节、正文、参考文献和结束页已经形成完整链路。
    - 中文友好：标题、摘要、图注和参考文献页更贴近中文汇报的阅读节奏。
    - Typst 驱动：页面内容以文本形式维护，适合版本管理、审阅和复用。
    - Touying 承载：复用演示框架能力，保留后续动画和页面扩展空间。
    - AI 可协作：任务、配置和页面入口清晰，便于让 Agent 稳定接手修改。

    因此它更适合作为“可持续改造的演示模板”，而不是一次性的视觉示例文件。

    #bottom-grid(
      [典型场景],
      [
        - 课程汇报与读书报告
        - 项目复盘与方案宣讲
      ],
      [维护原则],
      [
        - 内容入口优先改
        - 样式组件按需动
      ],
    )
  ],
)

#subject-text-image-page(
  demo-image,
  title: [仓库入口分工],
  header-left-offset: 10em,
  text-width: 1.2fr,
  image-width: 0.8fr,
  image-max-height: 70%,
  top-content: [一句话结论：日常改稿优先处理内容入口，主题和组件层只在确有需求时再动。],
  image-caption: [图 1. 默认背景图用于版式占位。],
  text-body: [
    第一次接手项目时，可以按职责而不是文件数量理解仓库：

    - `main.typ` 是演示入口，负责标题变量、目录结构和每页调用顺序。
    - `task.md` 描述本轮目标、受众、约束和验收标准，减少反复追问。
    - `config.md` 保存标题、章节、素材、图注和排版偏好，便于复用。
    - `slides/` 暴露页面组件，`style/` 承载视觉实现，默认不直接改。
    - `figures/` 存放封面图、截图和示意图；没有素材时只作为占位预览。
  ],
)

#transition-page(
  number: [02],
  marker: [PART],
  left-card-dy: 1.5em,
  right-card-dy: 1.5em,
  title: [页面组件],
  description: [把页面组件理解成可复用积木，按信息形态选择正文、图文或并列展示。],
)

#subject-triple-gallery-page(
  title: [核心页面组件],
  header-left-offset: 10em,
  body-gap: 0.8em,
  image-height: 9.8em,
  content-row-gap: 1.1em,
  body-text-size: 0.9em,
  image-one: component-card([结构页], [封面、目录、章节过渡；建立听众预期。]),
  image-one-caption: [封面目录与过渡页],
  image-two: component-card([内容页], [正文、图文、三项并列；承载主要信息。]),
  image-two-caption: [正文图文与三图页],
  image-three: component-card([收束页], [参考文献、致谢结束；完成交付闭环。]),
  image-three-caption: [参考文献与结束页],
  text-body: [
    三类组件分工明确：结构页负责叙事节奏，内容页负责观点表达，收束页负责来源和结束。生成演示稿时应让内容页数量明显多于过渡页。
  ],
)

#subject-content-page(
  title: [按内容选择页面],
  header-left-offset: 10em,
  top-content: [一句话结论：先判断信息形态，再选择页面类型，比先挑视觉样式更稳定。],
  content-text-size: 0.9em,
  content-text-leading: 0.72em,
  content: [
    选择页面类型时，可以使用下面的判断顺序：

    - 结论、步骤、原则和检查项：优先使用 `subject-content-page`，保持 4-5 个要点。
    - 一张架构图或截图配解释：使用 `subject-text-image-page`，图片只服务于文字说明。
    - 三个模块、阶段或结果并列：使用 `subject-triple-gallery-page`，三项必须可比较。
    - 章节切换和节奏提示：使用 `transition-page`，不要把它当成正文页。
    - 来源或延伸阅读：少量条目用 `references-manual-page`，正式文献可接 `.bib`。

    如果某页只有一句话或一张占位图，就应该补充例子、约束、下一步，或直接合并到相邻页。

    #bottom-grid(
      [判断示例],
      [
        - 流程或原则用正文页
        - 截图或架构图用图文页
      ],
      [失败信号],
      [
        - 下半页只剩背景
        - 图注承担长解释
      ],
    )
  ],
)

#transition-page(
  number: [03],
  marker: [PART],
  left-card-dy: 1.5em,
  right-card-dy: 1.5em,
  title: [使用流程],
  description: [从需求配置到 Typst 编译，建立一条可重复、可检查的成稿路径。],
)

#subject-content-page(
  title: [从需求到初稿],
  header-left-offset: 10em,
  top-content: [一句话结论：先把任务和配置写清楚，再让页面内容围绕这些约束展开。],
  content-text-size: 0.9em,
  content-text-leading: 0.72em,
  content: [
    推荐把一次生成过程拆成四个可检查步骤：

    - 写 `task.md`：说明主题、场景、目标受众、约束和最终验收标准。
    - 写 `config.md`：固定标题、作者、日期、章节名、素材来源和页面偏好。
    - 改 `main.typ`：按目录顺序调用页面组件，先完成结构，再逐页补正文。
    - 编译 `main.pdf`：运行 `typst compile main.typ`，用输出文件检查实际版面。
    - 复核低密度：如果页面只有少量文字或占位图，应继续补充内容或换页型。

    这条路径的价值是把“口头需求”转成可追踪文件，方便后续继续迭代。

    #bottom-grid(
      [输入文件],
      [
        - `task.md` 锚定任务边界
        - `config.md` 固定内容参数
      ],
      [验证动作],
      [
        - 编译生成 `main.pdf`
        - 抽查正文页密度
      ],
    )
  ],
)

#subject-text-image-page(
  demo-image,
  title: [编译与检查闭环],
  header-left-offset: 10em,
  text-width: 1.25fr,
  image-width: 0.75fr,
  image-max-height: 68%,
  top-content: [一句话结论：编译成功只说明语法正确，渲染抽查才能发现空页和视觉低密度。],
  image-caption: [图 2. 占位图不能替代正文信息。],
  text-body: [
    每轮修改后至少完成这些检查：

    - 运行 `typst compile main.typ`，确认 PDF 能正常生成。
    - 用 `pdfinfo main.pdf` 查看页数，核对是否符合 `config.md`。
    - 抽查内容页截图，确认文字没有只停留在页面左上角。
    - 检查过渡页比例，避免章节页多于实质内容页。
    - 对占位图保持克制：没有信息量的图片应缩小，正文要补足。
  ],
)

#transition-page(
  number: [04],
  marker: [PART],
  left-card-dy: 1.5em,
  right-card-dy: 1.5em,
  title: [协作交付],
  description: [让 AI 修改、人工审阅和 PDF 交付形成闭环，降低模板维护成本。],
)

#subject-content-page(
  title: [AI Skill 协作],
  header-left-offset: 10em,
  top-content: [一句话结论：Skill 应约束 Agent 读文件、选页型、编译验证和报告版面风险。],
  content-text-size: 0.9em,
  content-text-leading: 0.72em,
  content: [
    使用 `pkusli-slides` 时，Agent 的工作边界应当明确：

    - 先读 `README.md`、`task.md`、`config.md`、`main.typ`，再决定是否追问。
    - 生成正文前读布局规则，把页数、图注、文字密度和页面类型一起考虑。
    - 默认只改内容入口，不轻易修改 `slides/`、`style/` 和 `figures/`。
    - 内容不足时主动补充例子、风险、检查项和下一步，而不是留下空白页。
    - 最终报告必须说明编译结果、PDF 路径、视觉假设和剩余版面风险。

    这能让演示稿从“能编译”升级到“可审阅、可交付、可继续维护”。

    #bottom-grid(
      [Agent 边界],
      [
        - 默认不改主题内部
        - 缺信息时集中追问
      ],
      [交付输出],
      [
        - 报告编译与 PDF 路径
        - 说明版面剩余风险
      ],
    )
  ],
)

#subject-content-page(
  title: [交付检查清单],
  header-left-offset: 10em,
  top-content: [一句话结论：最终交付前要同时检查结构完整、内容密度、素材可信和编译结果。],
  content-text-size: 0.9em,
  content-text-leading: 0.72em,
  content: [
    推荐在提交或分享 PDF 前逐项确认：

    - 结构完整：封面、目录、章节过渡、正文、参考文献和结束页均存在。
    - 内容充分：每个正文页都有一个明确观点，并配有例子、约束或行动项。
    - 视觉平衡：主要文字区域没有大片空白，图片区域不只是低信息量占位。
    - 构建可靠：`typst compile main.typ` 成功，`main.pdf` 页数和配置一致。
    - 人工复核：模板可保证版式起点，事实准确性和表达取舍仍需人工确认。

    如果任一项不满足，应先调整内容和页面类型，再考虑是否修改底层样式。

    #bottom-grid(
      [通过标准],
      [
        - PDF 页数与配置一致
        - 内容页下半区有信息
      ],
      [返工触发],
      [
        - 占位图成为主体
        - 一页承载多个主旨
      ],
    )
  ],
)

#references-manual-page(
  entries: (
    [Touying package documentation. Typst Universe. 用于说明本模板所基于的演示框架。],
    [Typst documentation. Typst 官方文档. 用于说明 `typst compile` 构建方式。],
    [项目 `README.md`. 用于说明仓库入口、AI Agent 快速使用方式和示例提示。],
    [项目页面模板说明. 用于说明组件参数、适用场景和常见改动入口。],
  ),
)

#end-page(
  title: [谢谢聆听],
  author: report-author,
  institution: report-institution,
  date: report-date,
)
