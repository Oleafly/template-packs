
#outline(title: "目录")

#show heading.where(level: 1): set heading(
  numbering: (..args) => {
    let num = args.pos()
    numbering("一、", num.at(0))
  },
)

#show heading.where(level: 2): set heading(
  numbering: (..args) => {
    let num = args.pos()
    numbering("（一）", num.at(1, default: 1))
  },
)
#show heading.where(level: 3): set heading(
  numbering: (..args) => {
    let num = args.pos()
    numbering("1.", num.at(2, default: 1))
  },
)
#show heading.where(level: 4): set heading(
  numbering: (..args) => {
    let num = args.pos()
    numbering("（1）", num.at(3, default: 1))
  },
)
#set par(
  first-line-indent: (
    amount: 2em,
    all: true,
  ),
  justify: true,
)
#show heading.where(level: 1): set text(font: "Adobe Heiti Std", size: 16pt)
#show heading.where(level: 1): a => {
  pad(
    top: 0.5em,
    bottom: 0.5em,
  )[#a]
}
#show heading.where(level: 2): set text(font: "Adobe Kaiti Std R", size: 16pt, weight: "bold")
#show heading.where(level: 2): a => {
  pad(
    top: 0em,
    bottom: 0.5em,
  )[#a]
}
#show heading.where(level: 3): set text(font: "Adobe Fangsong Std R", size: 16pt, weight: "bold")
#show heading.where(level: 3): a => {
  pad(
    top: -0.5em,
    bottom: 0em,
  )[#a]
}
#show heading.where(level: 4): set text(font: "Adobe Fangsong Std R", size: 16pt)

#set page(numbering: "1/1")
#set text(font: "Adobe Fangsong Std R", size: 16pt)

#pagebreak()


#heading(numbering: none, outlined: false)[#text(
  font: "FZXiaoBiaoSong-B05S",
  size: 22pt,
)[#align(center)[曲阜师范大学关于建设低空技术与工程学科与专业的可行性分析报告]]]


