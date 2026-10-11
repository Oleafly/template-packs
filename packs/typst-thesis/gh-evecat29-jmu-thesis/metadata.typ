
// 论文元数据
#let thesis_info = (
  type: "本科毕业论文（设计）", // 封面页显示的大标题
  title: "毕业论文（设计）题目，2 号，黑体，长文本测试", // 中文标题
  en_title: "English Title of Graduation Thesis Shown in Bold No.4", // 英文标题
  keywords: ("关键词 1", "关键词 2", "关键词 3", "关键词 4"), // 中文关键词
  en_keywords: ("Keyword 1", "Keyword 2", "Keyword 3", "Keyword 4"), // 英文关键词
  abstract: [题目用3号黑体字居中排版，原则上题目不超过20个字。题目设置段后行距为1行。用4号黑体字打印“[摘要]”。空一格后开始写摘要内容，字体为“小4号宋体”。摘要不分段，摘要里不要出现公式、图标、引文的标注。摘要内容应包括毕业论文（设计）工作的目的、采用的方法或技术、成果和结论等。语言力求精炼。\/\/为了便于文献检索，应在摘要下方另起一行注明3-6个论文的关键词，该行的段前行距为1行。用4号黑体字打印“[关键词]”。关键词之间用“分号”分隔，并空2格，最后一个关键词后面不要加标点。中文关键词为“小4号宋体”。\/\/本页的页眉标注“摘要”二字。\/\/论文的英文题目、英文摘要、英文关键词要另起一页。\/\/英文题目注意首字母大写，但介词不需要首字母大写。\/\/ 英文题目采用“小4号Arial字体”，英文摘要内容、英文关键词均为“5号Arial字体”，英文关键词的分隔符应使用英文输入法下的分号。], // 中文摘要
  en_abstract: [A Start writing the abstract content after one blank space, and the font is "Small No.4 Song font". Don't segment the abstract, and don't mark formulas, icons, and quotations in the abstract. The content should include the purpose, method or technology, results, and conclusions of graduation design. Strive for refinement of language. \/\/For the convenience of literature retrieval, the keywords of 3-6 papers should be indicated in another line after a blank line at the bottom of the abstract. Use semicolons to separate keywords, and leave 2 spaces. Don't add punctuation after the last keyword. The key word is "Song No.4". \/\/The header of this page is marked with the word "Summary". \/\/The English title, English abstract and English key words of the paper should start on a new page. \/\/Pay attention to capital letters in English titles, but prepositions do not need capital letters. \/\/The English title is in "Small No.4 Arial font", and the English abstract content and English keywords are all in "No.5 Arial font".], // 英文摘要
  school: "计算机工程学院", // 所在学院
  major: "智能科学与技术", // 专业
  grade: "2024 级", // 年级
  class: "智能 2413", //班级
  name: "张三", // 学生姓名
  id: "202421336666", // 学号
  supervisor: "李四", // 指导老师姓名
  rank: "职称", // 职称
  date: (year: "2026", month: "4", day: "9"), // 封面页的日期
  custom_pagefront: "集美大学学士学位论文", // 偶数页自定义页眉
  conclusion: [
    本文重点介绍了……。在……的基础上，我们改进了&模型。我们做了如下工作：
    + 做了工作……，效果……。
    + 做了工作……，效果……。
    + 做了工作……，效果……。
    ……正处于蓬勃发展的阶段，下面结合我们的研究成果和尚且存在的问题，以及可能的延伸，对……研究做一些展望：
    + 展望1……
    + 展望2……
  ], // 总结与展望，若填写则会生成对应页面
  acknowledgment: [
    在即将离开母校之际，我感到十分的不舍，同时更多的是感激之情。

    首先，我要特别感谢某某老师。……
  ], // 致谢页，若填写则生成
  bib_path: "refs.yaml"
)
