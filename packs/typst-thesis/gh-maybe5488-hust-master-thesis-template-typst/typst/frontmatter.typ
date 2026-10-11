#import "hust-thesis.typ": *
// Positions calibrated against page 3 of the supplied LaTeX PDF. Its
// authorization layout uses fixed-height parboxes rather than ordinary flow.
#let authorization() = {
  set text(weight: "regular", stroke: none)
  set par(first-line-indent: (amount: 2em, all: true), leading: 13.45 * texpt)
  let signature(label) = [#label#v(0.37cm)日期：#h(1em)年#h(1em)月#h(1em)日]
  block(width: 100%, height: 21.5cm)[
    #place(top + center, dy: -0.9pt, text(font: hei, size: 16 * texpt, weight: "bold")[独创性声明])
    #place(top, dy: 54pt, block(width: 100%)[
      #h(2em)本人声明所呈交的学位论文是我个人在导师的指导下进行的研究工作及取得的研究成果。尽我所知，除文中已标明引用的内容外，本论文不包含任何其他人或集体已经发表或撰写过的研究成果。对本文的研究做出贡献的个人和集体，均已在文中以明确方式标明。本人完全意识到本声明的法律结果由本人承担。
    ])
    #place(top + right, dy: 183.6pt)[
      #set par(first-line-indent: 0pt)
      #align(right, signature([学位论文作者签名：#h(2cm)]))
    ]
    #place(top + center, dy: 310.7pt, text(font: hei, size: 16 * texpt, weight: "bold")[学位论文版权使用授权书])
    #place(top, dy: 362.5pt, block(width: 100%)[
      #h(2em)本学位论文作者完全了解学校有关保留、使用学位论文的规定，即：学校有权保留并向国家有关部门或机构送交论文的复印件和电子版，允许论文被查阅和借阅。本人授权华中科技大学可以将本学位论文的全部或部分内容编入有关数据库进行检索，可以采用影印、缩印或扫描等复制手段保存和汇编本学位论文。
    ])
    #place(top, dy: 455.7pt, block(width: 100%)[
      #set par(first-line-indent: 0pt, leading: 15 * texpt)
      #pad(left: 2em, grid(columns: (6em, 1fr), align: (left + horizon, left),
        [本论文属于], [保密 □，在#box(width: 2em)[#place(bottom, line(length: 100%, stroke: 0.4 * texpt))]年解密后适用本授权书。\ 不保密 □。]))
    ])
    #place(top, dy: 525.7pt)[#h(2em)（请在以上方框内打“√”）]
    #place(top, dy: 563.3pt, grid(columns: (1fr, 1fr),
      signature([学位论文作者签名：]), signature([指导教师签名：])))
  ]
}
// Draw the frame and tick in one coordinate system; separate font glyphs
// have different advances and ink bounds even when their boxes are centered.
#let degree-checkbox(checked: false) = {
  let tick = if checked { "<path d='M2.7 5.1 L4.4 7 L7.7 3.1' fill='none' stroke='black' stroke-width='0.8' stroke-linecap='round' stroke-linejoin='round'/>" } else { "" }
  let svg = "<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 10 10'><rect x='1' y='1' width='8' height='8' fill='none' stroke='black' stroke-width='0.55'/>" + tick + "</svg>"
  box(width: 0.605em, height: 0.605em, baseline: 0pt,
    image(bytes(svg), format: "svg", width: 100%, height: 100%))
}
#let frontmatter(info) = {
  // Covers and authorization have no running header or page number.
  // Cover offsets/line gaps are calibrated to the supplied LaTeX PDF,
  // including the vertical offsets introduced by its centered parboxes.
  set page(header: none, footer: none, numbering: none)
  set par(first-line-indent: 0pt)
  set text(weight: "bold")
  block(width: 100%, height: 21.5cm)[
    #place(top + left, dy: 0.8875cm)[
      #set text(size: 12 * texpt)
      #let field(width, value, centered: false) = box(width: width)[
        #place(bottom, dy: 2 * texpt, line(length: 100%, stroke: 1 * texpt))
        #if centered { align(center, value) } else { h(1em); value }
      ]
      #grid(columns: (4em, 5em, 1fr, 2em, 12em), row-gutter: 6 * texpt,
        [分 类 号], field(5em, info.class-number, centered: true), [], [学号], field(7em, info.student-id),
        [学校代码], field(5em, info.school-code, centered: true), [], [密级], field(7em, info.secrecy))
    ]
    #place(top + center, dy: 3.4cm, image("assets/hust-logo.svg", width: 7.5cm))
    #place(top + center, dy: 6.14cm, text(font: "STZhongsong", size: 45 * texpt, tracking: 5pt)[硕士学位论文])
    #place(top + center, dy: 8.176cm, text(size: 15 * texpt)[( 学术型 #degree-checkbox(checked: not info.professional) #h(2em) 专业型 #degree-checkbox(checked: info.professional) )])
    #place(top + center, dy: 10.5cm)[
      // Cover thesis title: stronger local synthetic bold; preserve advances.
      #set text(size: 28 * texpt, weight: "bold")
      #show regex("[\\p{Han}、。，：；！？“”‘’（）《》【】]+"): it => text(
        weight: "regular", stroke: (paint: black, thickness: 0.035 * 28pt), it)
      #set par(leading: 0.42em)
      #align(center, info.title)
    ]
    #place(top + center, dy: 16.33cm)[
      #set text(size: 15 * texpt, weight: "bold")
      #show regex("[\\p{Han}、。，：；！？“”‘’（）《》【】]+"): it => text(
        weight: "regular", stroke: (paint: black, thickness: 0.035 * 15pt), it)
      #grid(columns: (5em, 2em, auto), align: left, row-gutter: 20.23pt,
        [学位申请人], [：], [#info.author],
        [学 科 专 业], [：], [#info.subject],
        [指 导 教 师], [：], [#info.supervisor #h(1em) #info.supervisor-title],
        [答 辩 日 期], [：], [#info.defense-date])
    ]
  ]
  pagebreak()
  block(width: 100%, height: 21.5cm)[
    #place(top + center, dy: -0.029cm)[
      #set text(size: 15 * texpt)
      #set par(leading: 0.77em)
      #align(center)[A Dissertation Submitted in Partial Fulfillment of the Requirements for #info.english-degree]
    ]
    #place(top + center, dy: 7.734cm, block(width: 100%)[

      #set text(size: 22 * texpt)
      #set par(leading: 0.81em)
      #set align(center)
      #info.english-title
    ])
    #place(top + center, dy: 13.404cm)[
      #set text(size: 15 * texpt)
      #grid(columns: (auto, auto, auto), align: left, column-gutter: 0.5em, row-gutter: 26pt,
        [Candidate], [:], [#info.english-author],
        [Major], [:], [#info.english-subject],
        [Supervisor], [:], [#info.english-supervisor])
    ]
    #place(top + center, dy: 19.147cm)[
      #set text(size: 14 * texpt)
      #set par(leading: 1.12em)
      #align(center)[Huazhong University of Science and Technology\ Wuhan 430074, P. R. China\ #info.english-date]
    ]
  ]
  pagebreak()
  authorization()
  pagebreak()
}
#let abstracts(info) = {
  set page(numbering: "I")
  counter(page).update(1)
  hust-unnumbered([摘#h(2em)要])
  info.abstract
  parbreak()
  grid(columns: (4em, 1fr), text(font: hei, weight: "bold")[关键词：], info.keywords)
  hust-unnumbered([Abstract])
  info.english-abstract
  parbreak()
  grid(columns: (5em, 1fr), strong[Keywords:], info.english-keywords)
  pagebreak()
}
