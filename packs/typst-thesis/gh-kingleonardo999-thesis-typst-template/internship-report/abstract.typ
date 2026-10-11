#import "utils.typ" : *
// --- 中文摘要 ---
#header-state.update("摘 要")
#pagebreak()
#set page(header: report-header, footer: report-footer, numbering: "I")
#counter(page).update(1)
#align(center, [
  #text(font: (font-en, font-title), size: 15pt, weight: "bold")[摘 要]
])
#v(10pt)
#par(justify: true, first-line-indent: 2em)[
  在此撰写中文摘要内容。摘要应简明扼要地概括实习课题的背景、主要工作内容和成果。
]

#v(10pt)
#par(
  first-line-indent: 0em,
)[#text(weight: "bold")[关键词：] 关键词1，关键词2，关键词3，关键词4]

// --- 英文摘要 ---
#header-state.update("ABSTRACT")
#pagebreak()
#align(center, [
  #text(font: (font-en, font-title), size: 15pt, weight: "bold")[ABSTRACT]
])
#v(10pt)
#text(font: font-en)[
  #par(justify: true, first-line-indent: 2em)[
    Write the English abstract here. It should briefly summarize the background, main work, and achievements of the internship project.
  ]
]

#v(10pt)
#par(
  first-line-indent: 0em,
)[#text(font: font-en, weight: "bold")[Keywords:] Keyword1, Keyword2, Keyword3, Keyword4]
