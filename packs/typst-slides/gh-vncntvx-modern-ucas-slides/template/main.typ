#import "../lib.typ": *

// ==============================================================================
// modern-ucas-slides: 中国科学院大学学术幻灯片模板
// ==============================================================================
// 配置选项说明：
// 1. style: 视觉风格，可选 "academic" (默认) | "minimal" | "bold"
// 2. aspect-ratio: 屏幕比例，可选 "16-9" (默认) | "4-3"
// 3. new-section-slide: 是否为一级章节自动生成转场页 (默认 false)
// 4. logo: 顶部/扉页校徽 (默认使用内置矢量校徽)
// ==============================================================================

#show: ucas-theme.with(
  style: sys.inputs.at("style", default: "academic"),
  aspect-ratio: sys.inputs.at("aspect-ratio", default: "16-9"),
  new-section-slide: false,
  config-info(
    title: [基于 Typst 的中国科学院大学学术幻灯片],
    short-title: [modern-ucas-slides],
    subtitle: [模板使用说明与排版示例],
    author: [徐文杰],
    short-author: [Wenjie Xu],
    institution: [中国科学院大学 · 计算机科学与技术学院],
    date: datetime.today(),
  ),
)

// --------------------------------- 扉页与目录 --------------------------------- //
#title-slide()

#outline-slide()

// ================================= 第 1 章 ================================= //
= 模板配置与视觉风格

== 全局配置与参数说明

#slide(title: [全局配置与主题初始化])[
  在文档头部通过 `#show: ucas-theme.with(...)` 统一配置模板参数：

  - *style*：视觉风格，可选 `"academic"`（默认）、`"minimal"` 与 `"bold"`。
  - *aspect-ratio*：屏幕比例，可选 `"16-9"`（默认宽屏）与 `"4-3"`（传统投影）。
  - *new-section-slide*：一级章节是否自动插入过渡页，布尔值（默认 `false`）。
  - *config-info*：设定标题、作者、单位及报告日期等元信息。

  #callout(title: [参数调用说明])[
    各参数均支持缺省默认值；亦可通过命令行 `--input style=...` 动态传入。
  ]
]

== 主题风格与适用场景

#slide(title: [内置三款视觉主题风格])[
  模板内置三款学术风格，通过 `style` 参数一键切换：

  - *academic（典雅校风 · 默认）*：
    顶部配置 1.5pt 国科大蓝微装饰线与章节路径导航，底部呈现作者与完整页码。适用于开题汇报、中期检查与学位答辩。
  - *minimal（极简风格）*：
    纯白留白版式，顶部放置小号章节标签（Kicker），底部保留精简页码。适用于国际会议报告与前沿研讨。
  - *bold（科技风格）*：
    顶部配置阅读进度条，底部页码采用圆角胶囊徽章。结合 `new-section-slide: true` 提供全幅深蓝章节转场。适用于前沿讲座与学术公开课。
]

== 比例适配与转场页面

#slide(title: [页面比例与专用页面组件], composer: (1fr, 1.25fr))[
  *屏幕比例选项*：
  - `aspect-ratio: "16-9"`：
    默认现代宽屏比例，适配主流多媒体显示屏与高清投影。
  - `aspect-ratio: "4-3"`：
    传统幻灯片比例，边距与画幅自动缩放，适配旧式投影设备。
][
  *专用页面函数*：
  - `#title-slide()`：生成报告扉页。
  - `#outline-slide()`：生成大纲目录页，按内容自适应单双栏排版。
  - `#new-section-slide()`：生成章节过渡页。
  - `#ending-slide(...)`：生成致谢与联系方式结束页。
]

// ================================= 第 2 章 ================================= //
= 常用排版与组件语法

== 多栏并列与文本排版

#slide(
  title: [多栏并列排版语法],
  subtitle: [使用 composer 参数指定分栏比例],
  composer: (1fr, 1.1fr),
)[
  *分栏排版规则*：
  - 单栏幻灯片直接调用 `#slide(title: [...])[内容]`。
  - 多栏排版通过 `composer` 参数指定各栏相对比例，例如 `composer: (1fr, 1.1fr)`。
  - 多栏内容使用多个内容块 `][` 进行分隔传入。
][
  *当前栏显示示例*：
  - 右侧栏使用 `1.1fr` 宽度，左侧栏使用 `1fr` 宽度。
  - 各栏内部文本与公式独立排版，列间距保持统一。
  - 适合算法对比、图文对照与对照实验结果陈述。
]

== 列表结构与动态展示

#slide(title: [多级列表与动态步进展示])[
  项目符号列表采用全平台兼容的规范符号：

  - 第一级列表项：采用国科大蓝方块符号
    - 第二级列表项：采用石板灰实心小圆点
      - 第三级列表项：采用石板灰短破折线
    - 支持文本局部强调，如使用 #alert[重点标红] 强化关键词

  #pause

  + 有序编号列表：使用 `+` 语法自动递增标号。
  + 动态步进展示：使用 `#pause` 命令使后续内容分步呈现。
]

== 学术卡片组件

#slide(title: [结构化卡片组件体系], composer: (1.1fr, 1fr))[
  #tblock(title: [标准区块 (tblock)])[
    用于陈述核心定义、算法背景或理论假设。卡片采用左侧国科大蓝强调条与浅灰底色。
  ]
][
  #exampleblock(title: [示例区块 (exampleblock)])[
    展示算例、实现示例或具体数据。
  ]

  #alertblock(title: [警示区块 (alertblock)])[
    标明收敛条件、边界约束或注意事项。
  ]
]

== 数学定理与推导证明

#slide(title: [定理环境与推导证明])[
  #theorem(title: [柯西积分定理])[
    设区域 $D$ 为单连通区域，$f(z)$ 在 $D$ 内处处全纯，则对 $D$ 内任意闭曲线 $C$：
    $ integral.cont_C f(z) dif z = 0 $
  ]

  #proof[
    结合格林公式与柯西-黎曼条件 $partial u / partial x = partial v / partial y$、$partial u / partial y = -partial v / partial x$ 直接化简得证。
  ]

  #blfootnote[[1] 复变函数与积分变换基础教材示例。]
]

== 学术三线表格

#slide(title: [规范学术三线表])[
  #align(center)[
    #figure(
      table(
        columns: (1.5fr, 1.2fr, 2fr),
        align: (left, center, left),
        table.header([*姓名*], [*出生年份*], [*母校 (本科)*]),
        [陶哲轩 (Terence Tao)], [1975], [弗林德斯大学],
        [张益唐 (Yitang Zhang)], [1955], [北京大学],
        [丘成桐 (Shing-Tung Yau)], [1949], [香港中文大学],
      ),
      caption: [二十一世纪华人数学家及本科母校示例],
    )
  ]
]

== 学术图像与多图排版

#slide(title: [学术图像与多图排版], composer: (1fr, 1.2fr))[
  *图像排版语法*：
  - *单图与多图*：调用 `#figure` 与 `#grid` 实现单图或多图并列。
  - *图题与编号*：`caption` 参数自动附加图号与中文图题。
  - *尺寸约束*：通过 `height` 或 `width` 参数保持纵横比自适应。
][
  #align(horizon)[
    #grid(
      columns: (1fr, 1.2fr),
      gutter: 12pt,
      figure(
        image("../assets/vi/ucas-emblem.svg", height: 60pt),
        caption: [校徽矢样],
      ),
      figure(
        image("../assets/vi/ucas-logo-H.svg", width: 90%),
        caption: [横版校名组合],
      ),
    )
  ]
]

== 模块综合混合排版

#slide(title: [学术卡片与图文混合排版], composer: (1.15fr, 1fr))[
  #tblock(title: [系统动力学模型])[
    离散时间非线性系统的状态转移方程：
    $ x_(k+1) = f(x_k) + g(x_k) u_k + w_k $
  ]

  #callout(title: [约束条件])[
    状态与输入需满足凸集界限约束：$x_k in cal(X), space u_k in cal(U)$。
  ]
][
  #figure(
    image("../assets/vi/ucas-logo-H-standard.svg", width: 90%),
    caption: [控制系统架构与信息流],
  )

  #alertblock(title: [收敛性与稳定性判据])[
    若李雅普诺夫差分满足 $Delta V(x_k) < 0$，则闭环系统渐近稳定。
  ]
]

// ================================= 第 3 章 ================================= //
= 参考文献与工程编译

== 参考文献引用

#slide(title: [参考文献与正文引用方法])[
  *文献引用语法*：
  - 正文中使用 `@key` 进行学术引用，例如 @graham1989concrete 与 @tantau2004user。
  - 配合 BibTeX 文件（如 `ref.bib`）自动提取条目信息并建立交叉链接。

  *文献列表渲染*：
  - 在单独的幻灯片中调用 `#bibliography("ref.bib", title: none, style: "ieee")`。
  - 可通过 `style` 参数指定引用格式（如 `"ieee"`、`"apa"`、`"gb-7714-2015-numeric"` 等）。
]

== 参考文献列表

#slide(title: [参考文献列表])[
  #set text(size: 0.75em)
  #bibliography("ref.bib", title: none, style: "ieee")
]

== 命令行编译与构建

#slide(title: [命令行编译与 Makefile 使用])[
  *Typst 命令行工具（CLI）*：
  - 单次编译：`typst compile --root . template/main.typ`
  - 实时监视热重载：`typst watch --root . template/main.typ`
  - 动态传参编译：`typst compile --root . --input style=minimal template/main.typ`

  *Makefile 常用命令*：
  - `make compile`：编译主文档并生成 `template/main.pdf`
  - `make watch`：启动保存自动热重载
  - `make format`：使用 `typstyle` 规范化项目内全部 `.typ` 代码
]

// --------------------------------- 结束页 --------------------------------- //
#ending-slide(
  title: [演示结束],
  subtitle: [感谢聆听，敬请批评指正],
  contact: [联系邮箱: wenjie.xu.cn\@outlook.com · 中国科学院大学],
)
