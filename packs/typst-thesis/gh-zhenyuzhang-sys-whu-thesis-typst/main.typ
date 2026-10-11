// 武汉大学学位论文 Typst 模板 - 示例文件
// WHU Thesis Typst Template - Demo

#import "whu-thesis.typ": *

// ========== 论文设置 ==========
#show: whu-thesis.with(
  thesis-type: "bachelor",      // bachelor, master, doctor
  degree-class: "academic",     // academic, professional

  title: "基于 Typst 的武汉大学学位论文模板设计与实现",
  title-en: "Design and Implementation of Wuhan University Thesis Template Based on Typst",
  department: "计算机学院",
  department-en: "School of Computer Science",
  author: "张三",
  author-en: "Xxxxxx Xxxxx",
  student-id: "2021202012345",
  supervisor: "李某某",
  supervisor-en: "Xxx Xxxxx",
  academic-title: "教授",
  academic-title-en: "Prof.",
  subject: "计算机科学与技术",
  major: "计算机科学与技术",
  major-en: "Computer Science and Technology",
  research-area: "系统软件",
  research-area-en: "System Software",
  year: 2024,
  month: 4,
  keywords-zh: ("LaTeX", "毕业论文", "模版", "武汉大学"),
  keywords-en: ("LaTeX", "Thesis", "Template", "Wuhan University"),
)

// ========== 中文摘要 ==========
#abstract-zh(keywords: ("LaTeX", "毕业论文", "模版", "武汉大学"))[
  论文的摘要是对论文研究内容和成果的高度概括。摘要应对论文所研究的问题及其研究目的进行描述，对研究方法和过程进行简单介绍，对研究成果和所得结论进行概括。摘要应具有独立性和自明性，其内容应包含与论文全文同等量的主要信息。使读者即使不阅读全文，通过摘要就能了解论文的总体内容和主要成果。

  论文摘要的书写应力求精确、简明。切忌写成对论文书写内容进行提要的形式，尤其要避免"第 1 章……；第 2 章……；……"这种或类似的陈述方式。

  关键词是为了文献标引工作、用以表示全文主要内容信息的单词或术语。关键词不超过 5 个，每个关键词中间用分号分隔。
]

// ========== 英文摘要 ==========
#abstract-en(keywords: ("LaTeX", "Thesis", "Template", "Wuhan University"))[
  An abstract of a dissertation is a summary and extraction of research work and contributions. Included in an abstract should be description of research topic and research objective, brief introduction to methodology and research process, and summary of conclusion and contributions of the research. An abstract should be characterized by independence and clarity and carry identical information with the dissertation. It should be such that the general idea and major contributions of the dissertation are conveyed without reading the dissertation.

  An abstract should be concise and to the point. It is a misunderstanding to make an abstract an outline of the dissertation and words "the first chapter", "the second chapter" and the like should be avoided in the abstract.

  Keywords are terms used in a dissertation for indexing, reflecting core information of the dissertation. An abstract may contain a maximum of 5 keywords, with semi-colons used in between to separate one another.
]

// ========== 目录 ==========
#make-toc()

// ========== 正文开始 ==========
#mainmatter()

#show: mainmatter-style.with(thesis-type: "bachelor", title: "基于 Typst 的武汉大学学位论文模板设计与实现")

// ========== 第一章 ==========
= 测试

== 文字测试

这是武汉大学学位论文模版，欢迎使用。

This is Wuhan University thesis template, welcome to use!

参考文献引用示例：FUSE 的性能问题在 @vangoor_fuse_2017 中有过系统分析；信息论的经典工作见 @shannon_mathematical_1948。Typst 官方文档见 @typst_documentation。

== 公式

=== 算符、希腊字母

$ sum product integral alpha beta gamma xi zeta eta epsilon theta phi psi $

=== 带编号单行公式

使用 `equation` 环境:
$ a^2 + b^2 = c^2 $ <eq:pythagorean>

不带编号:
#math.equation(block: true, numbering: none)[$ a^2 + b^2 = c^2 $]

=== 带编号多行公式

$ S_n &= 1 + 2 + dots.c + n \
     &= 1/2 n(n+1) $

=== 矩阵

$ mat(delim: "(", a_(11), a_(12), a_(13); a_(21), a_(22), a_(23); a_(31), a_(32), a_(33)) quad
  mat(delim: "|", a_(11), a_(12), a_(13); a_(21), a_(22), a_(23); a_(31), a_(32), a_(33)) quad
  mat(delim: "[", a_(11), a_(12), a_(13); a_(21), a_(22), a_(23); a_(31), a_(32), a_(33)) $

== 脚注测试

测试#footnote[眼看他起朱楼，眼看他宴宾客，眼看他楼塌了。这青苔碧瓦堆，俺曾睡风流觉，将五十年兴亡看饱。]

测试#footnote[君不见，左纳言，右纳史，朝承恩，暮赐死。行路难，不在水，不在山，只在人情反覆间！]


== 图表测试

#figure(
  image("logo/whu-logo.png", width: 5cm),
  caption: [武汉大学校徽],
) <fig:whu-logo>

引用@fig:whu-logo

#figure(
  caption: [简单的表格],
  table(
    columns: 2,
    stroke: 0.5pt,
    align: center,
    [a], [b],
    [c], [d],
    [测试], [文本],
  )
) <table:simple>

引用@table:simple

== 数学定理环境

#definition(title: "测度")[
  （参见文献xxx）这是一段文字 $E = m c^2$（中文括号）和 (西文括号)
]

#theorem()[
  这是一段文字 $E = m c^2$
]

#proof()[
  这是一段文字 $E = m c^2$
]

#example()[
  这是一段文字 $E = m c^2$
]

#property()[
  这是一段文字 $E = m c^2$
]

#proposition()[
  这是一段文字 $E = m c^2$
]

#corollary()[
  这是一段文字 $E = m c^2$
]

#lemma()[
  这是一段文字 $E = m c^2$
]

#axiom()[
  这是一段文字 $E = m c^2$
]

#remark()[
  这是一段文字 $E = m c^2$
]

#theorem(title: "Banach-Steinhaus")[
  设 $E$ 是 Banach 空间，$F$ 是赋范空间，$(u_i)_(i in I)$ 是一族从 $E$ 到 $F$ 的有界线性算子，即 $(u_i)_(i in I) subset cal(B)(E,F)$。若对每一点 $x in E$，有
  $sup_(i in I) ||u_i (x)|| < infinity$，则
  $ sup_(i in I) ||u_i|| < infinity $ <eq:banach>
] <thm:banach>

我想引用定理 #ref(<thm:banach>) 和公式 #ref(<eq:banach>)

== 字体测试

字体测试：

宋体 #text(font: "SimHei")[黑体] #text(font: "KaiTi")[楷书] #text(font: "FangSong")[仿宋]

#text(weight: "bold")[粗体] #emph[意大利斜体]

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.


// ========== 第二章 ==========
= BBBB

这是第二章的内容。


// ========== 参考文献 ==========
#make-bibliography("ref/refs.bib")


// ========== 致谢 ==========
#acknowledgements[
  致谢是以简短的文字对课题研究与论文撰写过程中直接给予帮助的人员（例如指导教师、答疑教师及其他人员）表示谢意。致谢是对他人劳动的尊重，也是学术规范。内容限一页。
]
