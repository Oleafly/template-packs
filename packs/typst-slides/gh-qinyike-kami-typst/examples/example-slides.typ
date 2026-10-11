// Example: AI Agent Overview Slide Deck
// Compile: typst compile example-slides.typ

#import "../lib.typ": *
#import "../templates/slides.typ": cover, slide, eyebrow, slide-title, section-heading, slide-lead, body-text, module-title, callout, page-footer, ms-label, sm-text

// ═══════════════════════════════════════════
// Cover
// ═══════════════════════════════════════════
#cover(
  "AI Agent 技术概述",
  "从指令执行到自主决策，AI Agent 正在重新定义人机协作的边界",
  "Kami Demo · 2026 年 6 月",
)

// ═══════════════════════════════════════════
// Slide 01 — 什么是 AI Agent
// ═══════════════════════════════════════════
#slide[
  #eyebrow("01 · 定义")
  #v(2pt)
  #slide-title[什么是 AI Agent]
  #v(8pt)
  #slide-lead[AI Agent 是能够感知环境、制定计划、调用工具、自主执行任务的智能体系统。]
  #v(12pt)

  #grid(
    columns: (1fr, 1fr),
    gutter: 22pt,
    [
      #section-heading[传统 AI 助手]
      #v(4pt)
      #body-text[一问一答的被动模式。用户给出指令，模型返回单次响应。没有工具调用能力。]
    ],
    [
      #section-heading[AI Agent]
      #v(4pt)
      #body-text[自主感知环境，动态规划路径，组合调用工具。分解复杂目标为多步计划并执行。]
    ],
  )
  #v(10pt)
  #body-text[核心差异：从「输入 → 输出」到「目标 → 感知 → 规划 → 行动 → 反馈」的闭环系统。]
  #page-footer("01", "AI Agent 技术概述")
]

// ═══════════════════════════════════════════
// Slide 02 — 四大核心模块
// ═══════════════════════════════════════════
#slide[
  #eyebrow("02 · 架构")
  #v(2pt)
  #slide-title[Agent 四大核心模块]
  #v(12pt)

  #grid(
    columns: (1fr, 1fr),
    rows: (auto, auto),
    gutter: 14pt,
    column-gutter: 22pt,
    [
      #module-title("P", "感知 Perceive")
      #v(4pt)
      #body-text[从环境、输入、工具输出中提取结构化信息，构建任务所需的世界模型。]
    ],
    [
      #module-title("R", "推理 Reason")
      #v(4pt)
      #body-text[将复杂目标分解为可执行子任务序列，选择最优路径，处理异常和分支。]
    ],
    [
      #module-title("M", "记忆 Memory")
      #v(4pt)
      #body-text[短期承载任务上下文，长期跨会话持久化偏好和经验。从工具走向伙伴的关键。]
    ],
    [
      #module-title("T", "工具 Tools")
      #v(4pt)
      #body-text[Shell 执行、文件读写、浏览器、API——每增加一个工具，能力域扩展一个维度。]
    ],
  )
  #page-footer("02", "AI Agent 技术概述")
]

// ═══════════════════════════════════════════
// Slide 03 — 关键突破
// ═══════════════════════════════════════════
#slide[
  #eyebrow("03 · 突破")
  #v(2pt)
  #slide-title[让 Agent 真正可用的关键技术]
  #v(8pt)
  #body-text[2024-2026 年，Agent 从实验走向生产，三项技术突破是核心驱动：]
  #v(12pt)

  #ms-label[上下文窗口]
  #v(4pt)
  #body-text[从 128K 到 2M token，Agent 可加载完整代码库和数千条历史消息，消除多步任务中的「失忆」瓶颈。]
  #v(10pt)

  #ms-label[工具调用标准化]
  #v(4pt)
  #body-text[Function Calling → MCP → A2A，多层标准化体系形成。模型层统一工具描述，传输层定义交互规范。]
  #v(10pt)

  #ms-label[多 Agent 协作]
  #v(4pt)
  #body-text[委派模式将任务拆解给多个子 Agent 并行执行，各自独立上下文和工具集。MoA 架构提升复杂决策准确率。]

  #callout[关键判断：工具标准化的成熟度已超过模型能力的增长。重心从「更强模型」转向「更好的工具编排」。]
  #page-footer("03", "AI Agent 技术概述")
]

// ═══════════════════════════════════════════
// Slide 04 — 框架对比
// ═══════════════════════════════════════════
#slide[
  #eyebrow("04 · 框架")
  #v(2pt)
  #slide-title[主流 Agent 框架对比]
  #v(14pt)

  #set table(
    columns: (auto, 1fr, 1fr),
    inset: 8pt,
    stroke: (x, y) => (bottom: 0.3pt + border),
  )
  #table(
    columns: 3,
    table.header([*框架*], [*核心特点*], [*适用场景*]),
    [Claude Code], [深度代码理解，原生工具调用，子 Agent 委派], [复杂软件工程、大型重构],
    [Hermes Agent], [开源、跨平台网关，技能系统，多模型切换], [通用任务、自动化、消息平台],
    [OpenAI Codex], [云端沙箱执行，GitHub 深度集成], [云原生开发、CI/CD],
    [CrewAI / AutoGen], [多 Agent 角色编排，预设工作流], [研究分析、内容生产流水线],
    [LangGraph], [有状态图工作流，精确控制执行路径], [确定性流程的企业应用],
  )
  #v(8pt)
  #line(stroke: 0.3pt + border)
  #v(6pt)
  #sm-text[数据截至 2026 年 6 月。没有万能框架，只有最匹配场景的架构。]
  #page-footer("04", "AI Agent 技术概述")
]
