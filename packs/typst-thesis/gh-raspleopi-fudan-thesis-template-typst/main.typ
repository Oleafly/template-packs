#import "lib/style.typ": *
#import "lib/bibliography.typ": print-references

// Fill in thesis metadata here.
#let thesis-info = (
  title: "论文中文题目",
  english-title: "English Thesis Title",
  author: "学生姓名",
  student-id: "XXXXXXXXXXX",
  faculty: "大数据学院",
  major: "专业名称",
  supervisor: "导师姓名",
  supervisor-title: "导师职称",
  supervisor-faculty: "导师所在单位",
  header-title: [复旦大学大数据学院],
  blind-review: false,
)

// Adjust global page margins here.
#let thesis-page-margin = (top: 40mm, bottom: 40mm, left: 30mm, right: 30mm)

// Adjust the indentation of second-level entries in the table of contents.
#let toc-section-indent = 1.2em

#show: body => thesis(body, info: thesis-info, link-fill: black, page-margin: thesis-page-margin)

#make-cover(thesis-info)

#frontmatter[
  #front-chapter[摘要][
    在此填写中文摘要。中文摘要应概括论文的研究背景、研究问题、主要方法、实验或分析结果以及结论。摘要通常写成若干自然段，避免出现图表、公式和过多引用。

    第二段可以进一步说明本文的主要工作和创新点。例如：本文围绕某一具体问题，构建了相应的方法框架，并通过实验或案例分析验证其有效性。

    第三段可以总结主要结论和应用价值。请根据学院或导师要求控制摘要长度。

    #v(6mm)
    #abstract-meta[关键词：][关键词一；关键词二；关键词三；关键词四] \
    #abstract-meta[中图分类号：][请填写中图分类号]
  ]

  #front-chapter[Abstract][
    Write the English abstract here. The abstract should briefly describe the research background, research question, methodology, main results, and conclusions of the thesis.

    The second paragraph may summarize the main contributions and the structure of the proposed method. Keep the wording concise and consistent with the Chinese abstract.

    The final paragraph may present the key findings and implications of the work.

    #v(6mm)
    #abstract-meta[Keywords:][keyword one; keyword two; keyword three; keyword four] \
    #abstract-meta[Chinese Library Classification:][Please fill in the classification number]
  ]

  #pagebreak(to: "odd")
  #outline(
    title: [目录],
    depth: 3,
    indent: level => if level == 0 { 0pt } else if level == 1 { toc-section-indent } else { toc-section-indent + 1.2em },
  )
]

#mainmatter(header-title: thesis-info.header-title)[
  #include "chapters/introduction.typ"
  #include "chapters/related-work.typ"
  #include "chapters/method.typ"
  #include "chapters/experiments.typ"
  #include "chapters/conclusion.typ"
]

#backmatter(header-title: thesis-info.header-title)[
  #print-references()

  #front-chapter[致谢][
    在此填写致谢内容。可以感谢导师、课题组成员、同学、朋友和家人等在论文写作、科研训练和学习生活中给予的帮助与支持。
  ]
]

// Uncomment this block if the final submission requires the AI-use commitment statement.
// #noheadfoot[
//   #ai-use-commitment-statement()
// ]
