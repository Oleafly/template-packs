// ============================================================
// 中文简历模板 — 样式与辅助函数
// 由 resume.typ 通过 #import "template.typ": * 使用
// 依赖：@preview/fontawesome:0.6.0
// ============================================================

// Font Awesome
#import "@preview/fontawesome:0.6.0": fa-angle-right

// 字体（按需修改；缺失字体会报错或降级渲染）
#let font = (
  main: "IBM Plex Serif",
  mono: "IBM Plex Mono",
  cjk: "Noto Serif CJK SC",
)

// ==================== 页面骨架 ====================
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
  show-introduction: true,
  body-spacing: 0.45em,
  body-leading: 0.55em,
  footer: [],
  header,
  introduction,
  body,
) = {
  // 页边距与页脚
  set page(
    paper: "a4",
    numbering: "1",
    margin: margin,
    footer: align(left, {
      set text(fill: rgb(128, 128, 128), size: 0.75em)
      footer
    }),
    footer-descent: 0.5cm,
  )

  // 正文字体
  set text(font: (font.main, font.cjk), size: size, lang: "zh")

  // 标题颜色
  show heading: set text(theme-color, 1.1em)

  // 二级标题：左侧文字 + 右侧横线
  show heading.where(level: 2): it => stack(
    v(-0.7em),
    grid(
      columns: (auto, 1fr),
      gutter: 0.3em,
      align: bottom,
      it,
      box(
        width: 100%,
        baseline: 0pt,
        line(length: 100%, stroke: 0.05em + theme-color),
      ),
    ),
    v(0.1em),
  )

  // 无序列表：箭头符号
  show list: it => stack(
    spacing: 0.25em,
    ..it.children.map(item => {
      grid(
        columns: (2em, 1fr),
        gutter: 0em,
        box({
          h(0.75em)
          fa-angle-right()
        }),
        pad(top: 0.15em, item.body),
      )
    }),
  )

  // 链接颜色
  show link: set text(fill: theme-color)

  // 段落
  set par(justify: true, spacing: body-spacing, leading: body-leading)

  let visible-introduction = if show-introduction { introduction } else { [] }

  // 头部：姓名 + 简介（+ 可选头像）
  if header-center {
    assert(photograph == "", message: "can not centerize the name with the photo")
    align(alignment.center, header)
    visible-introduction
  } else {
    grid(
      columns: (1fr, photograph-width),
      gutter: gutter-width,
      align: (left + top, right + top),
      [#header #visible-introduction],
      if photograph != "" {
        align(right + top, image(photograph, width: photograph-width))
      },
    )
  }

  body
}

// ==================== 时间轴侧栏 ====================
// 左侧时间 + 竖线 + 右侧内容
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
    {
      v(0.25em)
      content
      v(0.25em)
    },
  )
})

// ==================== 联系方式行 ====================
// info((icon: ..., content: ..., link: ...), ...)
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
          if type(dir.icon) == function {
            dir.icon(fill: color)
          } else {
            dir.icon
          }
        }
        h(0.15em)
        if "link" in dir {
          link(dir.link, dir.content)
        } else {
          dir.content
        }
      })
    })
    .join(h(0.5em) + "·" + h(0.5em))
  v(0.5em)
}

// ==================== 小工具 ====================
// 灰色小字（日期、说明）
#let date(body) = text(
  fill: rgb(128, 128, 128),
  size: 0.9em,
  body,
)

// 细体文字（技术栈等）
#let tech(body) = block({
  set text(weight: "extralight")
  body
})

// 三栏条目：左标题 / 中说明 / 右时间
#let item(
  title,
  desc,
  endnote,
) = {
  v(0.15em)
  grid(
    columns: (35%, 1fr, auto),
    gutter: 0em,
    title, desc, endnote,
  )
}

// 英文简历用的三栏条目（标题栏更宽）
#let item-en(
  title,
  desc,
  endnote,
) = {
  v(0.15em)
  grid(
    columns: (65%, 1fr, auto),
    gutter: 0em,
    title, desc, endnote,
  )
}
