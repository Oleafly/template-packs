// 北航冯如杯项目论文模板
// 使用方法：typst compile main.typ --font-path fonts

#import "../template.typ": appendix, conf

#show: conf.with(
  year: 2026,
  ctitle: "“冯如杯”竞赛项目论文模板",
  csubtitle: "基于 Typst 的论文模板",
  cabstract: [
    在此处填写中文摘要内容。

    摘要应简明扼要地概述论文的主要内容和研究成果。
  ],
  ckeywords: ("关键词1", "关键词2", "关键词3"),
  eabstract: [
    Write your English abstract here.

    The abstract should briefly summarize the main content and research findings of your dissertation.
  ],
  ekeywords: ("keyword1", "keyword2", "keyword3"),
  preview: false,
  outlinedepth: 3,
  listofimage: true,
  listoftable: true,
  listofcode: true,
  bibcontent: read("ref.bib"),
)

// ========== 正文开始 ==========

= 绪论

== 研究背景

在此处撰写研究背景...

== 研究目的与意义

在此处撰写研究目的与意义...

= 相关工作

== 国内外研究现状

在此处撰写文献综述...

= 研究方法

在此处撰写研究方法...

= 实验与结果

在此处撰写实验和结果...

= 总结与展望

在此处撰写总结和展望...

// ========== 附录 ==========
#appendix()

= 代码展示

在此处添加附录内容...
