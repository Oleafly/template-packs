#import "@preview/touying:0.6.3": *
#import "custom-outline.typ": custom-outline

// ============================================================================
// 常量定义 / Constants
// ============================================================================

#let SUPPORTED-ASPECT-RATIOS = ("16-9", "4-3")
#let DEFAULT-ASPECT-RATIO = "16-9"
#let DEFAULT-GRID-GUTTER = 10pt
#let DEFAULT-LOGO-HEIGHT = 2.3cm

// ============================================================================
// 工具函数 / Utility Functions
// ============================================================================

/// 验证宽高比参数 / Validate aspect ratio parameter
///
/// 确保传入的宽高比在支持的列表 `SUPPORTED-ASPECT-RATIOS` 中。
#let validate-aspect-ratio(ratio) = {
  assert(
    ratio in SUPPORTED-ASPECT-RATIOS,
    message: "aspect-ratio must be one of " + SUPPORTED-ASPECT-RATIOS.map(str).join(", ") + ", got: " + str(ratio),
  )
}

/// 配置背景参数 / Configure background parameters
///
/// 生成用于 `config-page` 的背景填充或背景图片配置。
/// 优先使用 `background-color`，其次使用 `fallback-color`。如果提供了 `background-img`，则会覆盖背景色设置。
#let configure-background(background-color: none, background-img: none, fallback-color: none) = {
  let args = (:)

  // 如果没有指定背景色和背景图，使用回退色
  let final-color = if background-img == none and background-color == none {
    fallback-color
  } else {
    background-color
  }

  if final-color != none {
    args.fill = final-color
  }

  if background-img != none {
    args.background = {
      set image(fit: "stretch", width: 100%, height: 100%)
      background-img
    }
  }

  args
}

/// 安全获取字典值 / Safely get dictionary value
///
/// 如果键存在则返回对应值，否则返回默认值。
#let safe-get(dict, key, default: none) = {
  if key in dict { dict.at(key) } else { default }
}

/// 参数 / Parameters:
/// - `place`: 图片放置方式
/// - `path`: 图片路径 / Image path
/// - `width`: 图片宽度 / Image width (default: auto)
/// - `height`: 图片高度 / Image height (default: auto)
/// - `caption`: 图片标题 / Image caption (default: none)
/// - `numbering`: 编号格式 / Numbering format (default: none)
#let img(place: center + horizon, path, width: auto, height: auto, caption: none, numbering: none) = {
  align(place, figure(
    image(path, width: width, height: height),
    caption: caption,
    numbering: numbering,
  ))
}

// ============================================================================
// 颜色配置系统 / Color Configuration System
// ============================================================================

// 基础颜色调色板 / Base Color Palette
#let default-color-palette = (
  // 主色调 / Primary Colors
  primary: rgb("#174994"),
  primary-light: rgb("#1f5db9"),
  primary-dark: rgb("#0d2d5c"),
  // 次要颜色 / Secondary Colors
  secondary: rgb("#1f5db9"),
  secondary-light: rgb("#1b67da"),
  secondary-dark: rgb("#164a8f"),
  // 第三颜色 / Tertiary Colors
  tertiary: rgb("#1b67da"),
  tertiary-light: rgb("#4d8be8"),
  tertiary-dark: rgb("#1252b3"),
  // 中性色 / Neutral Colors
  white: rgb("#ffffff"),
  black: rgb("#000000"),
  gray-light: rgb("#f5f5f5"),
  gray: rgb("#cccccc"),
  gray-dark: rgb("#666666"),
  // 文字颜色 / Text Colors
  text: black.transparentize(20%),
  text-light: black.transparentize(40%),
  text-inverse: white,
  // 功能性颜色 / Functional Colors
  success: rgb("#28a745"),
  warning: rgb("#ffc107"),
  error: rgb("#dc3545"),
  info: rgb("#17a2b8"),
)

// 语义化颜色映射 / Semantic Color Mapping
#let default-colors = (
  // 主题颜色
  primary: default-color-palette.primary,
  secondary: default-color-palette.secondary,
  tertiary: default-color-palette.tertiary,
  // 背景颜色
  background: default-color-palette.white,
  background-alt: default-color-palette.gray-light,
  // 文字颜色
  text: default-color-palette.text,
  text-light: default-color-palette.text-light,
  text-inverse: default-color-palette.text-inverse,
  // 边框和分割线
  border: default-color-palette.gray,
  divider: default-color-palette.gray-light,
  // 强调和高亮
  accent: default-color-palette.primary,
  highlight: default-color-palette.primary,
  // 功能性颜色
  success: default-color-palette.success,
  warning: default-color-palette.warning,
  error: default-color-palette.error,
  info: default-color-palette.info,
)

// ============================================================================
// 默认样式配置 / Default Style Configuration
// ============================================================================

// 字体配置
#let default-fonts = (
  serif: ("Times New Roman", "Source Han Serif SC"),
  sans: "Source Han Sans",
)

// 文字样式配置
#let default-text-styles = (
  default: (
    font: default-fonts.serif,
    weight: "bold",
    lang: "zh",
    region: "cn",
    size: 22pt,
    fill: default-colors.text,
  ),
  heading: (
    font: default-fonts.sans,
    fill: default-colors.primary,
    weight: "bold",
  ),
  caption: (
    size: 15pt,
    font: default-fonts.serif,
    fill: default-colors.text,
  ),
  outline: (
    fill: default-colors.text-inverse,
    size: 30pt,
    weight: "bold",
    font: default-fonts.sans,
  ),
  highlight: (
    font: default-fonts.sans,
    weight: "bold",
    fill: default-colors.highlight,
  ),
)

// 布局配置 / Layout Configuration
#let default-layout-config = (
  heading-numbering: "1.1", // 标题编号格式
  outline-block-above: 1.2em, // 大纲块上方间距
  logo-height: DEFAULT-LOGO-HEIGHT, // Logo 高度
  grid-gutter: DEFAULT-GRID-GUTTER, // 网格间距
  margin: (
    // 页面边距
    top: 2.2em,
    bottom: 1em,
    x: 0.5em,
  ),
  header-ascent: 0em, // 页眉上升
  footer-descent: 0em, // 页脚下降
)

// 保留 _type 变量，用于类型检查
#let _type = type

// ============================================================================
// 幻灯片函数 / Slide Functions
// ============================================================================

/// 演示文稿的默认幻灯片函数 / Default slide function for the presentation
///
/// **智能页眉适配 / Smart Header Adaptation:**
/// 本函数会自动检测当前上下文的标题层级并调整页眉布局：
/// - **标准模式**（当存在二级标题时）：左侧显示当前小节标题（二级），右侧显示章节标题（一级）和 Logo。
/// - **单级模式**（仅有一级标题时）：左侧显示章节标题（一级），右侧仅显示 Logo。适用于参考文献、结语等不需要二级标题的页面。
///
/// 参数说明 / Parameters:
/// - `config`: 幻灯片配置。可使用 `config-xxx` 设置配置，多个配置可用 `utils.merge-dicts` 合并
///
/// - `repeat`: 子幻灯片数量。默认为 `auto`，touying 将自动计算子幻灯片数量
///   当使用 `#slide(repeat: 3, self => [ .. ])` 风格代码时需要此参数
///   回调风格的 `uncover` 和 `only` 无法被 touying 自动检测
///
/// - `setting`: 幻灯片设置。可用于添加 set/show 规则
///
/// - `composer`: 幻灯片布局组合器
///   示例: `#slide(composer: (1fr, 2fr, 1fr))[A][B][C]` 将幻灯片分为三部分
///   第一和最后部分各占 1/4，中间部分占 1/2
///
///   非函数值（如 `(1fr, 2fr, 1fr)`）将作为 `components.side-by-side` 的第一个参数
///   `components.side-by-side` 是 `grid` 函数的简单包装
///   可使用 `grid.cell(colspan: 2, ..)` 使单元格占用 2 列
///
///   示例: `#slide(composer: 2)[A][B][#grid.cell(colspan: 2)[Footer]]`
///   自定义组合器可传入函数: `#slide(composer: grid.with(columns: 2))[A][B]`
///
/// - `..bodies`: 幻灯片内容。语法: `#slide[A][B][C]`
/// 获取当前页面活跃的标题 / Get the active heading of the current page
#let get-current-heading(level: auto) = {
  let target = if level == auto { heading } else { heading.where(level: level) }
  let headings = query(target)
  let current-page = here().page()
  headings.filter(h => h.location() != none and h.location().page() <= current-page).at(-1, default: none)
}

#let slide(
  config: (:),
  repeat: auto,
  setting: body => body,
  composer: auto,
  composer-r: 100%,
  size: auto,
  ..bodies,
) = touying-slide-wrapper(self => {
  let header(self) = {
    set align(top)
    grid(
      rows: (auto, auto),
      row-gutter: 3mm,
      if self.store.progress-bar {
        components.progress-bar(height: 7pt, self.colors.primary, self.colors.tertiary)
      },
      block(
        inset: (left: 0.4em, right: 0.3em),
        components.left-and-right(
          text(
            ..default-text-styles.heading,
            fill: self.colors.primary,
            size: 1.4em,
            context {
              let last-heading = get-current-heading()
              if last-heading != none and last-heading.level > 1 {
                utils.call-or-display(self, self.store.header)
              } else {
                utils.call-or-display(self, utils.display-current-heading(level: 1))
              }
            },
          ),
          text(
            ..default-text-styles.heading,
            fill: self.colors.primary.lighten(60%),
            size: 1.1em,
            context {
              let last-heading = get-current-heading()
              if last-heading != none and last-heading.level > 1 {
                utils.call-or-display(self, self.store.header-right)
              } else {
                utils.call-or-display(
                  self,
                  box(baseline: 15%, width: auto, height: 28pt)[
                    #self.info.logo1
                  ],
                )
              }
            },
          ),
        ),
      ),
    )
  }
  let footer(self) = {
    set align(center + bottom)
    set text(font: default-fonts.sans, size: 0.6em, weight: "bold")
    {
      let cell(..args, it) = components.cell(
        ..args,
        inset: 0mm,
        align(horizon, text(fill: white, it)),
      )
      show: block.with(width: 100%, height: auto)
      grid(
        columns: self.store.footer-columns,
        rows: 2em,
        cell(fill: self.colors.primary, utils.call-or-display(self, self.store.footer-a)),
        cell(fill: self.colors.secondary, utils.call-or-display(self, self.store.footer-b)),
        cell(fill: self.colors.tertiary, utils.call-or-display(self, self.store.footer-c)),
      )
    }
  }
  let self = utils.merge-dicts(
    self,
    config-page(
      header: header,
      footer: footer,
    ),
  )
  let composer = if _type(composer) == array {
    grid.with(columns: composer, rows: composer-r, gutter: DEFAULT-GRID-GUTTER)
  } else {
    composer
  }
  let bodies-pos = bodies.pos()
  if size != auto {
    bodies-pos = bodies-pos.map(body => {
      set text(size: size)
      // 恢复标题的大小基准，即标题不随正文缩放
      show heading: set text(size: self.store.text-styles.default.size)
      body
    })
  }
  touying-slide(
    self: self,
    config: config,
    repeat: repeat,
    setting: setting,
    composer: composer,
    ..bodies.named(),
    ..bodies-pos,
  )
})


/// 演示文稿的标题幻灯片 / Title slide for the presentation
///
/// 用于创建演示文稿的封面页。会自动获取 `config-info` 中的元数据。
/// 你也可以直接向此函数传递参数来覆盖全局配置。
///
/// 示例 / Example:
/// ```typst
/// #show: university-theme.with(
///   config-info(
///     title: [标题],
///     logo: emoji.school,
///   ),
/// )
///
/// #title-slide(subtitle: [副标题])
/// ```
///
/// 参数 / Parameters:
/// - `extra`: 额外传递给 `touying-slide` 的参数
/// - `..args`: 用于覆盖 `info` 的参数，如 `title`, `subtitle`, `authors`, `institution`, `date`, `logo` 等
#let title-slide(
  extra: none,
  ..args,
) = touying-slide-wrapper(self => {
  let info = self.info + args.named()
  info.authors = {
    let authors = if "authors" in info {
      info.authors
    } else {
      info.author
    }
    if _type(authors) == array {
      authors
    } else {
      (authors,)
    }
  }
  set text(font: default-fonts.sans)
  let body = {
    grid(
      rows: (6.5cm, 4cm, 2.5cm, 3cm, auto),
      columns: 100%,
      align: center + horizon,
      fill: (x, y) => if y == 1 { self.colors.primary } else { white },
      // stroke: red.lighten(0%),
      if info.logo != none {
        box(height: 6cm, [#text(fill: self.colors.primary, info.logo)])
      },
      // 标题和副标题区域 - 使用 box(width: auto) 实现相对对齐
      box(
        width: auto,
        // stroke: red.lighten(0%),
      )[

        // 主标题 - 居中对齐
        #align(center, text(weight: "extrabold", size: 2em, fill: self.colors.secondary-lightest, info.title))
        #v(20pt, weak: true)
        // 副标题 - 相对于主标题区域右对齐
        #if info.subtitle != none {
          v(10pt, weak: true) // 调整间隔
          align(right, text(size: 1.3em, fill: self.colors.secondary-lightest, info.subtitle))
        }
      ],
      ..info.authors.map(author => text(size: 1.2em, fill: self.colors.neutral-darkest, author)),
      if info.institution != none {
        parbreak()
        text(font: default-fonts.sans, weight: "bold", size: 1.1em, info.institution)
      },
      if info.date != none {
        parbreak()
        text(font: default-fonts.sans, weight: "bold", size: 1.1em, utils.display-info-date(self))
      },
    )
  }
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(fill: self.colors.neutral-lightest, margin: (top: 0em, bottom: 0.1em, x: 0em)),
  )
  touying-slide(self: self, body)
})

/// 演示文稿的新章节幻灯片 / New section slide for the presentation
///
/// 通常不需要手动调用，Touying 会在遇到一级标题时自动调用此函数。
/// 显示当前章节的大纲视图。
///
/// 可通过 `config-common(new-section-slide-fn: ...)` 自定义或替换。
///
/// 示例 / Example:
/// ```typst
/// config-common(new-section-slide-fn: new-section-slide.with(numbered: false))
/// ```
///
/// 参数 / Parameters:
/// - `level`: 标题级别（通常为 1）
/// - `numbered`: 是否显示章节编号（默认为 true）
/// - `body`: 章节幻灯片的主体内容（通常为空或包含标题）
#let new-section-slide(level: 1, numbered: true, body) = touying-slide-wrapper(self => {
  let slide-body = {
    set align(horizon)
    show: pad.with(left: 15%, right: 15%)

    custom-outline(
      title: none,
      filter: hd => {
        if hd.relation != none and not hd.relation.unrelated {
          hd.level <= 2 // 当前章节及相关内容显示1-2级
        } else {
          hd.level == 1 // 其他章节只显示一级标题
        }
      },
      depth: 2,
      transform: (hd, it) => {
        set text(font: default-fonts.serif)
        set text(size: 1.4em, fill: self.colors.primary, weight: "black") if hd.relation != none and hd.relation.same
        set text(size: 1.2em, fill: self.colors.primary, weight: "bold") if hd.relation != none and hd.relation.child
        set text(fill: text.fill.transparentize(80%), weight: "bold") if hd.relation != none and hd.relation.sibling
        set text(size: 1.1em, fill: text.fill.transparentize(20%)) if hd.relation != none and hd.relation.unrelated

        it
      },
    )

    body
  }
  self = utils.merge-dicts(
    self,
    config-page(fill: self.colors.neutral-lightest),
  )
  touying-slide(self: self, slide-body)
})


/// 聚焦幻灯片 / Focus slide - 突出显示重点内容
///
/// 用于强调关键信息或重要结论，使用全屏背景和大号文字。
///
/// 示例 / Examples:
/// ```typst
/// // 基本用法
/// #focus-slide[重要内容!]
///
/// // 自定义背景色
/// #focus-slide(background-color: rgb("#c41e3a"))[
///   警告信息
/// ]
///
/// // 使用背景图片
/// #focus-slide(background-img: image("bg.jpg"))[
///   #set text(fill: white)
///   图片背景上的文字
/// ]
/// ```
///
/// 参数 / Parameters:
/// - `background-color`: 背景颜色（默认为主色调）
/// - `background-img`: 背景图片（默认为 none）
/// - `body`: 幻灯片内容
#let focus-slide(
  background-color: none,
  background-img: none,
  body,
) = touying-slide-wrapper(self => {
  // 使用工具函数配置背景
  let bg-args = configure-background(
    background-color: background-color,
    background-img: background-img,
    fallback-color: rgb(self.colors.primary),
  )

  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(margin: 1em, ..bg-args),
  )

  set text(fill: self.colors.neutral-lightest, weight: "bold", size: 2em)
  touying-slide(self: self, align(horizon, body))
})

/// 空白幻灯片 / Empty slide - 无页眉页脚的自定义幻灯片
///
/// 适合用于自定义布局的页面，如全图页或特殊排版页。
///
/// 参数 / Parameters:
/// - `background-color`: 背景颜色
/// - `background-img`: 背景图片
/// - `body`: 幻灯片内容
#let empty-slide(background-color: none, background-img: none, body) = touying-slide-wrapper(self => {
  let bg-args = configure-background(
    background-color: background-color,
    background-img: background-img,
    fallback-color: rgb(self.colors.primary),
  )
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(margin: 0.4em, ..bg-args),
  )
  touying-slide(self: self, body)
})

/// 目录幻灯片 / Outline slide - 显示演示文稿大纲
///
/// 创建一个带有logo和目录的幻灯片
///
/// 示例 / Example:
/// ```typst
/// #outline-slide()
/// ```
///
/// 参数 / Parameters:
/// - `title`: 目录标题（默认为 "目录"）
/// - `logo`: logo图片路径（可选，默认为none）
/// - `depth`: 大纲深度（默认为 1）
/// - `columns`: 网格列配置（默认为 (1fr, 1.5fr)）
/// - `text-styles`: 文字样式配置（默认使用 default-text-styles）
/// - `layout-config`: 布局配置（默认使用 default-layout-config）
#let outline-slide(
  title: [目录],
  logo: none,
  depth: 1,
  columns: (1fr, 1.5fr),
  text-styles: default-text-styles,
  layout-config: default-layout-config,
) = {
  empty-slide()[
    #set text(..text-styles.outline)
    #show outline.entry.where(
      level: 1,
    ): set block(above: layout-config.outline-block-above)
    #set align(center + horizon)
    #if logo != none {
      place(
        top + left,
        image(logo, height: layout-config.logo-height),
      )
    }
    #grid(
      columns: columns,
      gutter: layout-config.grid-gutter,
    )[
      #align(center + horizon)[
        #text(size: 60pt)[#title]
      ]
    ][
      #outline(
        depth: depth,
        title: none,
      )
    ]
  ]
}

/// 矩阵幻灯片 / Matrix slide - 以网格形式显示内容块
///
/// 创建一个将内容块以网格形式显示的幻灯片，使用棋盘图案着色
///
/// 网格配置规则 / Grid configuration rules:
/// - `columns` 为整数时：创建对应数量的 `1fr` 宽度列
/// - `columns` 为 `none` 时：根据内容块数量创建等宽列
/// - `columns` 为数组时：直接使用该数组作为列宽
/// - `rows` 为整数时：创建对应数量的 `1fr` 高度行
/// - `rows` 为 `none` 时：根据内容块和列数自动计算行数
/// - `rows` 为数组时：直接使用该数组作为行高
///
/// 示例 / Examples:
/// - `#matrix-slide[...][...]` 水平堆叠
/// - `#matrix-slide(columns: 1)[...][...]` 垂直堆叠
///
/// 参数 / Parameters:
/// - `columns`: 列配置
/// - `rows`: 行配置
/// - `..bodies`: 内容块
#let matrix-slide(columns: none, rows: none, ..bodies) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(margin: 0em),
  )
  touying-slide(self: self, composer: components.checkerboard.with(columns: columns, rows: rows), ..bodies)
})


// ============================================================================
// 主题配置函数 / Theme Configuration Function
// ============================================================================

/// Touying 大学主题 / Touying University Theme
///
/// 适用于中文学术演示的现代化主题
///
/// 使用示例 / Example:
/// ```typst
/// #show: university-theme.with(
///   aspect-ratio: "16-9",
///   config-colors(primary: blue)
/// )
/// ```
///
/// 参数说明 / Parameters:
/// - `aspect-ratio`: 幻灯片宽高比（默认 "16-9"）
/// - `progress-bar`: 是否显示进度条（默认 true）
/// - `header`: 页眉内容（默认显示二级标题）
/// - `header-right`: 页眉右侧内容（默认显示 logo）
/// - `footer-columns`: 页脚列配置（默认 (25%, 1fr, 25%)）
/// - `footer-a`: 页脚左侧内容（默认显示作者）
/// - `footer-b`: 页脚中间内容（默认显示标题）
/// - `footer-c`: 页脚右侧内容（默认显示日期和页码）
/// - `color-palette`: 颜色调色板（默认使用 default-color-palette）
/// - `colors`: 语义化颜色配置（默认使用 default-colors）
/// - `fonts`: 字体配置（默认使用 default-fonts）
/// - `text-styles`: 文字样式配置（默认使用 default-text-styles）
/// - `layout-config`: 布局配置（默认使用 default-layout-config）
///
/// 默认颜色配置 / Default colors:
/// ```typst
/// config-colors(
///   primary: rgb("#174994"),
///   secondary: rgb("#174994"),
///   tertiary: rgb("#174994"),
///   neutral-lightest: rgb("#ffffff"),
///   neutral-darkest: rgb("#000000"),
/// )
/// ```
#let university-theme(
  aspect-ratio: "16-9",
  progress-bar: true,
  header: self => utils.display-current-heading(level: 2),
  header-right: self => [
    #utils.display-current-heading(level: 1)
    #box(baseline: 15%, width: auto, height: 28pt)[
      #self.info.logo1
    ]

  ],
  footer-columns: (25%, 1fr, 25%),
  footer-a: self => self.info.author,
  footer-b: self => if self.info.short-title == auto {
    self.info.title
  } else {
    self.info.short-title
  },
  footer-c: self => {
    h(1fr)
    utils.display-info-date(self)
    h(1fr)
    context utils.slide-counter.display() + " / " + utils.last-slide-number
    h(1fr)
  },
  // 新增样式配置参数
  color-palette: default-color-palette,
  colors: default-colors,
  fonts: default-fonts,
  text-styles: default-text-styles,
  layout-config: default-layout-config,
  ..args,
  body,
) = {
  // 验证宽高比参数
  validate-aspect-ratio(aspect-ratio)

  // 应用默认文字样式
  set text(..text-styles.default)

  show: touying-slides.with(
    config-page(
      paper: "presentation-" + aspect-ratio,
      header-ascent: layout-config.header-ascent,
      footer-descent: layout-config.footer-descent,
      margin: layout-config.margin,
    ),
    config-common(
      slide-fn: slide,
      new-section-slide-fn: new-section-slide,
    ),
    config-methods(
      init: (self: none, body) => {
        // 应用标题样式
        set text(fill: self.colors.neutral-darkest)
        show heading: set text(fill: self.colors.primary, ..text-styles.heading)
        set heading(numbering: layout-config.heading-numbering)

        // 应用图表标题样式
        show figure.caption: set text(..text-styles.caption)

        body
      },
      alert: utils.alert-with-primary-color,
    ),
    config-colors(
      primary: colors.primary,
      secondary: colors.secondary,
      tertiary: colors.tertiary,
      neutral-lightest: colors.background,
      neutral-darkest: colors.text,
    ),
    // 保存变量供后续使用
    config-store(
      progress-bar: progress-bar,
      header: header,
      header-right: header-right,
      footer-columns: footer-columns,
      footer-a: footer-a,
      footer-b: footer-b,
      footer-c: footer-c,
      text-styles: text-styles, // 保存 text-styles 供 slide 使用
    ),
    ..args,
  )

  body
}
