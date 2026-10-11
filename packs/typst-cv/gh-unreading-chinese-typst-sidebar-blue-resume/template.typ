/// ========================================
/// Typst 中文简历模板
/// ========================================

/// ========================================
/// 字体配置
/// ========================================
#let font = (
  main: "Times New Roman", // 英文和数字主字体
  mono: "IBM Plex Mono", // 等宽字体（用于代码、联系方式等）
  cjk: "Microsoft YaHei", // 中文字体（微软雅黑）
)

/// ========================================
/// 图标函数
/// ========================================
/// 从 SVG 文件加载图标并设置颜色
/// 参数:
///   path: SVG 文件路径
///   fill: 图标填充颜色（默认黑色）
/// 返回: 格式化后的图标元素
#let icon(path, fill: rgb("#000000")) = box(
  // baseline: 0.125em,  // 基线调整（可选）
  height: 0.7em, // 图标高度
  width: 1.25em, // 图标宽度
  align(
    center + horizon, // 居中对齐
    image(bytes(read(path).replace("path d", "path fill=\"" + fill.to-hex() + "\" d")), height: 1em),
  ),
)

/// 预定义的右箭头图标（用于列表项）
#let fa-angle-right = icon("icons/fa-angle-right.svg")

/// ========================================
/// 简历主体函数
/// ========================================
/// 参数:
///   size: 基准字体大小（默认 10pt）
///   theme-color: 主题颜色（默认深蓝色）
///   margin: 页面边距
///   photograph: 照片文件路径（空字符串表示无照片）
///   photograph-width: 照片宽度
///   gutter-width: 照片与内容之间的间距
///   header-center: 头部是否居中显示
///   global-sidebar: 全局侧边栏内容（none 表示无侧边栏）
///   global-sidebar-width: 侧边栏宽度（占页面宽度的百分比）
///   header: 头部内容
///   introduction: 自我介绍内容
///   body: 主体内容
#let resume(
  size: 10pt,
  theme-color: rgb("#26267d"),
  margin: (
    top: 1.5cm,
    bottom: 2cm,
    left: 2cm,
    right: 2cm,
  ),
  photograph: "",
  photograph-width: 0em,
  gutter-width: 0em,
  header-center: false,
  // 全局侧边栏参数
  global-sidebar: none,
  global-sidebar-width: 25%,
  header,
  introduction,
  body,
) = {
  /// ========================================
  /// 带侧边栏的布局
  /// ========================================
  if global-sidebar != none {
    /// 设置页面
    set page(
      paper: "a4",
      numbering: "1", // 页码
      margin: (top: 0cm, bottom: 0cm, left: 0cm, right: 0cm), // 零边距，由背景控制布局

      /// 页面背景：左右分栏
      background: {
        /// 左侧深蓝色侧边栏背景
        place(
          left,
          rect(
            width: global-sidebar-width,
            height: 100%,
            fill: rgb("#254665"), // 深蓝色
          ),
        )

        /// 右侧浅灰色正文背景
        place(
          right,
          rect(
            width: 100% - global-sidebar-width,
            height: 100%,
            fill: rgb("#F2F2F2"), // 浅灰色
          ),
        )
      },
    )

    /// 基础字体设定
    set text(font: (font.main, font.cjk), size: size, lang: "zh")

    /// 标题样式设置
    show heading: set text(theme-color, 1.3em)

    /// ========================================
    /// 二级标题样式（大标题）
    /// ========================================
    /// 添加下划线，不悬挂缩进
    show heading.where(level: 2): it => {
      v(1.2em) // 大标题前的额外间距
      pad(left: -1.5em, stack(
        v(0.3em),
        text(size: 1.3em, weight: "bold", fill: theme-color, it.body),
        v(0.4em),
        line(length: 100% + 1.5em, stroke: 0.08em + theme-color), // 下划线
        v(0.2em),
      ))
    }

    /// ========================================
    /// 三级标题样式（小标题）
    /// ========================================
    /// 用于正文的子标题，跟随悬挂缩进
    show heading.where(level: 3): it => {
      v(0.2em)
      text(size: 1.1em, weight: "bold", fill: theme-color, it.body)
      v(0.1em)
    }

    /// ========================================
    /// 列表样式
    /// ========================================
    /// 自定义列表项图标为右箭头
    show list: it => stack(
      spacing: 0.4em,
      ..it.children.map(item => {
        grid(
          columns: (2em, 1fr),
          // 图标列 + 内容列
          gutter: 0em,
          box({
            h(0.75em)
            fa-angle-right // 右箭头图标
          }),
          pad(top: 0.15em, item.body),
        )
      }),
    )

    /// 链接颜色
    show link: set text(fill: theme-color)

    /// 主体段落设置
    set par(justify: true, spacing: 1.8em, leading: 1em)

    /// ========================================
    /// 构建主体内容
    /// ========================================
    let main-content = {
      if header-center {
        /// 头部居中显示
        align(alignment.center, header)
        introduction
      } else {
        /// 头部使用网格布局：内容 + 简介 + 照片
        grid(
          columns: (auto, 1fr, photograph-width),
          gutter: (gutter-width, 0em),
          [#header #introduction],
          if photograph != "" {
            image(photograph, width: photograph-width)
          },
        )
      }
      body /// 主体内容
    }

    /// ========================================
    /// 页面布局：左右分栏
    /// ========================================
    grid(
      columns: (global-sidebar-width, 1fr),
      gutter: 0em,

      /// 左侧栏内容
      pad(x: 1.2em, y: 1em, {
        set text(size: 1.1em, fill: white)

        /// 侧边栏三级标题样式（白色 + 下划线）
        show heading.where(level: 3): it => {
          v(1.2em)
          stack(
            text(size: 1.3em, weight: "bold", fill: white, it.body),
            v(0.4em),
            line(length: 100%, stroke: 0.08em + white), // 白色下划线
          )
          v(0.8em)
        }

        global-sidebar /// 侧边栏内容
      }),

      /// 右侧正文
      pad(
        left: 3em,
        right: 2em,
        y: 1em,
        {
          /// 正文内容相对大标题悬挂缩进
          pad(left: 1.5em, {
            /// 段落间距设置
            set par(leading: 1em, spacing: 1.2em)
            main-content
          })
        },
      ),
    )
  } else {
    /// ========================================
    /// 无侧边栏的传统布局
    /// ========================================
    set page(paper: "a4", numbering: "1", margin: margin)

    /// 基础字体设定
    set text(font: (font.main, font.cjk), size: size, lang: "zh")

    /// 标题及小标题样式
    show heading: set text(theme-color, 1.1em)

    /// ========================================
    /// 二级标题样式
    /// ========================================
    show heading.where(level: 2): it => stack(
      v(0.3em),
      text(size: 1.3em, weight: "bold", fill: theme-color, it.body),
      v(0.4em),
      line(length: 100%, stroke: 0.08em + theme-color), // 下划线
      v(0.2em),
    )

    /// ========================================
    /// 三级标题样式
    /// ========================================
    show heading.where(level: 3): it => {
      v(0.2em)
      text(size: 1.1em, weight: "bold", fill: theme-color, it.body)
      v(0.1em)
    }

    /// ========================================
    /// 列表样式（自定义右箭头图标）
    /// ========================================
    show list: it => stack(
      spacing: 0.4em,
      ..it.children.map(item => {
        grid(
          columns: (2em, 1fr),
          gutter: 0em,
          box({
            h(0.75em)
            fa-angle-right
          }),
          pad(top: 0.15em, item.body),
        )
      }),
    )

    /// 链接颜色
    show link: set text(fill: theme-color)

    /// 主体段落设置
    set par(justify: true, spacing: 1em)

    /// ========================================
    /// 构建主体内容
    /// ========================================
    let main-content = {
      if header-center {
        align(alignment.center, header)
        introduction
      } else {
        grid(
          columns: (auto, 1fr, photograph-width),
          gutter: (gutter-width, 0em),
          [#header #introduction],
          if photograph != "" {
            image(photograph, width: photograph-width)
          },
        )
      }
      body
    }

    main-content
  }
}

/// ========================================
/// 带竖线的侧边栏（辅助函数）
/// ========================================
/// 参数:
///   side: 侧边栏内容
///   content: 主内容
///   with-line: 是否显示分隔竖线（默认 true）
///   side-width: 侧边栏宽度
#let sidebar(side, content, with-line: true, side-width: 12%) = layout(size => {
  let side-size = measure(width: size.width, height: size.height, side)
  let content-size = measure(width: size.width * (100% - side-width), height: size.height, content)
  let height = calc.max(side-size.height, content-size.height) + 0.5em
  grid(
    columns: (side-width, 0%, 1fr),
    gutter: 0.75em,
    {
      set align(right)
      v(0.25em)
      side
      v(0.25em)
    },
    if with-line { line(end: (0em, height), stroke: 0.05em) },
    // 分隔竖线
    {
      v(0.25em)
      content
      v(0.25em)
    },
  )
})

/// ========================================
/// 个人信息函数
/// ========================================
/// 用于展示联系方式等个人信息
/// 参数:
///   color: 文本颜色（默认黑色）
///   ...infos: 信息字典数组，每个包含 icon 和 content
#let info(
  color: black,
  ..infos,
) = {
  set text(font: (font.mono, font.cjk), fill: color)
  set par(justify: false)
  infos
    .pos()
    .map(dir => {
      box({
        if "icon" in dir {
          if type(dir.icon) == str {
            icon(dir.icon)
          } else {
            dir.icon
          }
        }
        h(0.15em)
        if "link" in dir {
          link(dir.link, dir.content) // 如果有链接，创建可点击链接
        } else {
          dir.content
        }
      })
    })
    .join(h(0.5em) + "·" + h(0.5em)) // 用圆点分隔
  v(0.5em)
}

/// ========================================
/// 日期格式化函数
/// ========================================
/// 将日期文本显示为灰色小字
#let date(body) = text(
  fill: rgb(128, 128, 128), // 灰色
  size: 0.9em, // 较小字号
  body,
)

/// ========================================
/// 技术标签函数
/// ========================================
/// 将技术栈显示为细体
#let tech(body) = block({
  set text(weight: "extralight")
  body
})

/// ========================================
/// 项目/经历条目函数
/// ========================================
/// 用于展示项目经历、工作经历等
/// 参数:
///   title: 标题（如项目名称、职位）
///   desc: 描述（如职责、成果）
///   endnote: 尾注（如时间段、地点）
#let item(
  title,
  desc,
  endnote,
) = {
  v(0.25em)
  grid(
    columns: (30%, 1fr, auto),
    // 标题占30%，描述自适应，尾注自动宽度
    gutter: 0em,
    title, desc, endnote,
  )
}
