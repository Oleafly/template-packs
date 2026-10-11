// settings.typ — 版式、字体、颜色与组件定义
#import "@preview/fontawesome:0.6.0": fa-icon

// ====================== 主题色设置 ======================
// 哈工大校徽标准色(RGB: 0, 83, 117)
#let hit-blue = rgb(0, 83, 117)

// ====================== 页面元素尺寸 ======================
// header.png / footer.png 均为 2381px 宽,全宽(21cm)放置时的实际高度
#let header-height = 21cm * (171 / 2381)
#let footer-height = 21cm * (99 / 2381)

// ====================== 联系方式(页脚,白色小字) ======================
#let contact(email, phone, github) = text(size: 8pt, fill: white)[
  #fa-icon("envelope", solid: true)#h(0.9em)#link("mailto:" + email)[#email]
  #h(4em)
  #fa-icon("phone", solid: true)#h(0.9em)#phone
  #h(4em)
  #fa-icon("github", font: "Font Awesome 7 Brands")#h(0.9em)#link("https://" + github)[#github]
]

// ====================== 一级标题 ======================
// 蓝色图标 + 加粗标题 + 下方蓝色分隔线
// line-length: 分隔线长度;有浮动证件照的板块用 429pt 避免横穿照片
#let section(icon, title, above: 16pt, below: 11pt, line-length: 100%) = {
  v(above, weak: true)
  text(size: 17pt, weight: "bold")[
    #box(width: 22pt)[#align(center)[#fa-icon(icon, solid: true, fill: hit-blue, size: 15pt)]]#h(17pt)#title
  ]
  v(4pt)
  line(length: line-length, stroke: 0.5pt + hit-blue)
  v(below, weak: true)
}


// ====================== 个人信息标签 ======================
// 固定标签列宽;两字标签用 #h(...) 拉开
#let info-label(body) = box(width: 2.15cm)[#body]

// ====================== 证件照框(双线边框) ======================
#let photo-box(body, height: 3.2cm) = box(width: 62.8pt, stroke: 0.5pt, inset: 2pt)[
  #box(width: 100%, height: height, stroke: 0.5pt)[
    #align(center + horizon)[#body]
  ]
]

// ====================== 页面模板 ======================
// school: 页眉右侧学院名称(白色加粗)
// contact-info: 页脚联系方式,用 #contact(...) 生成
#let resume-page(school: none, contact-info: none, doc) = {
  set page(
    paper: "a4",
    margin: (left: 1.2cm, right: 1.2cm, top: 74.7pt, bottom: 1.4cm),
    background: [
      // 页眉底图
      #place(top + center)[#image("images/header.png", width: 100%)]
      // 校徽与校名
      #place(top + left, dx: 0.2cm, dy: (header-height - 32.7pt) / 2)[
        #image("images/hitsz_logo_name.png", width: 0.34 * (21cm - 2.4cm))
      ]
      // 学院名称
      #place(top + right, dx: -0.6cm, dy: (header-height - 12pt) / 2)[
        #text(size: 10pt, weight: "bold", fill: white)[#school]
      ]
      // 校徽水印(5% 透明度,已预先混合)
      #place(center + horizon)[#image("images/hitsz_logo_watermark.png", width: 14.7cm)]
    ],
    foreground: [
      // 页脚底图
      #place(bottom + center)[#image("images/footer.png", width: 100%)]
      // 联系方式
      #place(bottom + center, dy: -(footer-height - 10pt) / 2)[#contact-info]
    ],
  )

  // 字体:狮尾四季春(加糖)简体版,按 --font-path fonts 从仓库 fonts/ 目录加载,无需安装到系统
  set text(font: "Swei Spring Sugar CJK SC", size: 11pt, lang: "zh", cjk-latin-spacing: none)

  // 行距 1.2(对应 LaTeX \linespread{1.2}),取消段落缩进
  set par(leading: 4.85pt, spacing: 8.3pt, first-line-indent: 0pt, justify: false)

  // 列表格式:小圆点、无额外段前距
  set list(marker: [‧], indent: 0pt, body-indent: 5.5pt, spacing: 15.6pt, tight: true)

  doc
}
