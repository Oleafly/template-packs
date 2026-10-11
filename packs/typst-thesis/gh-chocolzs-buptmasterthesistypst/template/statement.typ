#import "common.typ": *

#let signature-row(label-left, label-right, fonts) = {
  grid(
    columns: (26mm, 42mm, 1fr, 18mm, 48mm),
    align: left + horizon,
    text(font: fonts.body, size: 12pt)[#label-left],
    line(length: 100%, stroke: 0.6pt),
    [],
    text(font: fonts.body, size: 12pt)[#label-right],
    line(length: 100%, stroke: 0.6pt),
  )
}

#let statement-page(info, fonts: default-fonts) = {
  set page(
    paper: "a4",
    margin: (top: 25.4mm, bottom: 25.4mm, left: 31.7mm, right: 31.7mm),
    header: none,
    footer: none,
    numbering: none,
  )
  let leading = fixed-leading(12pt, 20pt)
  set text(
    font: fonts.body,
    size: 12pt,
    top-edge: 0.8em,
    bottom-edge: -0.2em,
  )
  set par(
    justify: true,
    first-line-indent: paragraph-indent,
    leading: leading,
    spacing: leading,
  )

  v(9.3pt)
  align(center)[#text(font: fonts.heading, size: 16pt)[独创性（或创新性）声明]]
  v(5.7pt)
  [本人声明所呈交的论文是本人在导师指导下进行的研究工作及取得的研究成果。尽我所知，除了文中特别加以标注和致谢中所罗列的内容以外，论文中不包含其他人已经发表或撰写过的研究成果，也不包含为获得北京邮电大学或其他教育机构的学位或证书而使用过的材料。与我一同工作的同志对本研究所做的任何贡献均已在论文中作了明确的说明并表示了谢意。]

  parbreak()
  [申请学位论文与资料若有不实之处，本人承担一切相关责任。]
  v(0pt)
  set par(first-line-indent: 0pt)
  signature-row([本人签名：], [日期：], fonts)

  v(15.1mm)
  align(center)[#text(font: fonts.heading, size: 16pt)[关于论文使用授权的说明]]
  v(5.8pt)
  set par(first-line-indent: paragraph-indent)
  [本人完全了解并同意北京邮电大学有关保留、使用学位论文的规定，即：北京邮电大学拥有以下关于学位论文的无偿使用权，具体包括：学校有权保留并向国家有关部门或机构送交学位论文，有权允许学位论文被查阅和借阅；学校可以公布学位论文的全部或部分内容，有权允许采用影印、缩印或其它复制手段保存、汇编学位论文，将学位论文的全部或部分内容编入有关数据库进行检索。（保密的学位论文在解密后遵守此规定）]
  v(0pt)
  set par(first-line-indent: 0pt)
  signature-row([本人签名：], [日期：], fonts)
  v(0pt)
  signature-row([导师签名：], [日期：], fonts)
}
