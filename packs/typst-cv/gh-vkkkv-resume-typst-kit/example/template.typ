// ============================================================================
// 简历模板 (Template) — 布局与样式, 与内容分离
// 用法: resume.typ 顶部 `#import "template.typ": *` 后
//       `#resume-template[ ...正文... ]` 包裹内容
// 依赖: typst >= 0.13, Noto Sans CJK SC 已安装
//
// 分页预算 (不变量): 全部内容自然流动, 不设强制分页
//                    分页落点随内容变化, 加内容须注意小节完整性
// 日期统一右列灰色; 项目/竞赛/证书内容按实际增减
// ============================================================================

// --- 常量: 模板级 (组件与样式共享) -------------------------------------------

#let cv-color = rgb("#284967")   // 主色: 小节标题、技术栈
#let cv-text  = rgb("#222222")   // 强调文字: 姓名、条目名
#let cv-body  = rgb("#333333")   // 弱化正文: 联系方式
#let cv-dim   = gray             // 次级淡化: 日期
#let cv-size-minor = 0.88em      // 次级字号: 日期、技术栈

// --- 组件: 可在内容中直接调用 (import * 后可见) -----------------------------

// 三列条目: 左(名称) / 中(内容) / 右(日期, 统一灰色右对齐)
#let item(a, b, c) = grid(
  columns: (38%, 1fr, auto), // 日期列 auto: 按内容自适应, box 防折行
  align: (left + top, left + top, right + top),
  text(fill: cv-text, weight: "bold", a),
  text(fill: cv-text, weight: "bold", b),
  box(text(fill: cv-dim, size: cv-size-minor, c)),
)

// 技术能力单行: 粗体类别 + 同色细节(消除 label/details 色差)
// above 0.37em + below 0.45em: 行距对齐正文声学 ~11.3pt(实测 9.5pt 过紧)
#let skill(label, details) = block(
  above: 0.37em,
  below: 0.45em,
  text(fill: cv-text, weight: "bold", label + "：") + text(fill: cv-text, details),
)

// 项目技术栈行: 小号主色; below 0.6em 使 tech→desc 间距对齐正文行距
#let tech(body) = block(
  above: 0.28em,
  below: 0.6em,
  text(fill: cv-color, size: cv-size-minor, weight: "light", body),
)

// 项目条目: 标题行 + 技术栈 + 描述 + bullet 列表
// title 契约: 传字典 (label: 必填; link/short 可选, 缺省安全不报错),
//             或直接传字符串/内容作纯文本标题; 有 link 时显示 short(缺省=label)
#let project(title, period, stack, desc, details, role: "个人项目") = {
  let t = if type(title) == dictionary {
    let label = title.at("label", default: none)
    let url = title.at("link", default: none)
    let short = title.at("short", default: label)
    if url != none {
      text(weight: "bold", label) + h(0.45em) + text(fill: cv-dim, size: cv-size-minor, weight: "regular", link(url)[#short])
    } else {
      text(weight: "bold", label)
    }
  } else {
    text(weight: "bold", title)
  }
  item([#t], [#role], period)
  v(0.25em)
  tech(stack)
  desc
  for detail in details { [- #detail] }
  v(0.45em) // 项目间分隔: 显著大于行距, 小于小节间距
}

// --- 模板: 页面设置 + 标题样式规则 -------------------------------------------

#let resume-template(body) = {
  // 单页时隐藏页码, 多页时才显示 (numbering 函数自动收到 当前页/末页 两个参数)
  let page-numbering(i, last) = if last > 1 { numbering("1", i) }

  set page(margin: (x: 1.35cm, y: 1.4cm), numbering: page-numbering)
  set text(font: "Noto Sans CJK SC", size: 9.2pt)
  // 行列距统一 ~1.25x 字号 (Noto Sans CJK SC 自然行框 ~6.7pt):
  // 正文 leading 0.5em -> 基线距 ~11.3pt; 列表 spacing 0.55em -> ~11.8pt
  set par(justify: false, leading: 0.5em, spacing: 0.85em)
  set list(spacing: 0.55em)

  // 姓名 (level 1); block(above/below) 在页首自动折叠, 无顶死空间
  // below 12pt: 名字(22pt)与下方小字(9pt)视觉分隔, 须明显大于行距
  show heading.where(level: 1): it => block(
    above: 4pt,
    below: 12pt,
    text(fill: cv-text, size: 22pt, weight: "bold", it),
  )

  // 小节标题 (level 2): 加粗 + 蓝色分隔线; 外层间距用 block spacing
  // (显式 v() 落在页首不会折叠, 会产生页顶死空间, 故不用)
  show heading.where(level: 2): it => block(
    breakable: false, // 标题+分隔线整体防拆页, 不孤悬页底
    above: 0.95em,
    below: 0.3em,
    stack(
      text(fill: cv-color, size: 11pt, weight: "bold", it),
      v(0.45em),
      line(stroke: 0.6pt + cv-color, length: 100%),
    ),
  )

  body
}