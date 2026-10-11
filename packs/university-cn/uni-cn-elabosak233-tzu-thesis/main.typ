#import "templates/thesis.typ": abstract, abstract-en, acknowledgement, authorization, commitment, thesis
#import "templates/utils.typ": parencite, three-line-table

#show: thesis.with(
  title: "基于 Typst 的台州学院学位论文模板",
  title-en: "A Thesis Template Based on Typst",
  school: "人工智能学院",
  major: "计算机科学与技术（奇安信）",
  class: "23 计算机奇安信班",
  uid: "2362120000",
  student: "张三",
  advisor: "李四",
  second-advisor: "王五",
  bibliography: bibliography.with("ref.bib"),
)

#authorization(
  confidential: false,
  student-signature: place(
    right + bottom,
    dx: -2.5cm,
    dy: 0.3cm,
    image("assets/signatures/ela.png", height: 30pt),
  ),
  advisor-signature: place(
    right + bottom,
    dx: -2.5cm,
    dy: 0.4cm,
    image("assets/signatures/ela.png", height: 30pt),
  ),
)

#abstract(("数据库技术", "人工智能", "数据处理与分析", "语义分析"))[
  一般不超过300个汉字。内容应包括课题设计意义、完成的主要工作、形成的重要结论等。语言力求精炼，突出论文的主要成果及创新性。

  文本文本文本文本文本文本文本文本文本文本文本文本文文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本。
]

#abstract-en((
  "Database Technology",
  "Artificial Intelligence",
  "Data Analysis and Processing",
  "Semantic Analysis",
))[
  The English version should be corresponding to the Chinese version.
]

= 一级标题1

论文的第一部分是论文的引言，*一般命名为“引言”*，综述课题背景、国内外的研究现状、理论依据、实验基础、发展趋势及本课题所具有的理论意义、实用价值及论文所要解决的问题等内容。

引用他人研究成果时，应注明出处，不得将其与本人的工作混淆在一起。*引文标注采用顺序编码制*。引用文献的标示应置于所引内容最后一个字的右上角，所引文献编号用阿拉伯数字置于方括号“[ ]”中，上角标。要求：

（1）引用单篇文献时，如“……，釆用现代化的技术手段，研究实现生猪的智能化猪养殖监测系统对于提高生猪的管理水平，进而提高猪肉的品质是非常有必要的 @cai2021densenet。”。

（2）同一处引用多篇文献时，各篇文献的序号在方括号内全部列出，各序号间用英文逗号“,”，如遇连续序号，可标注起止序号。如“……形成了多种计算模型 @zhao2021multimodal @qi2021citespace @wu2022ai……”

（3）当提及的参考文献是句子中的有效成分时，则用与正文排齐，如“由#parencite(<cai2021densenet>, <zhao2021multimodal>)可知”。

不得将引用文献标示置于各级标题处。


= 一级标题2

再是论文主体，即论文的主要部分，*论文各章之间应该前后关联*，构成一个有机的整体。论文给出的数据必须真实可靠，推理正确，结论明确，无概念性和科学错误。

== 二级标题1

文中的图、表、公式一律采用阿拉伯数字分章连续编号。如：图 2-5，表 3-2，公式（5-1）等。

…………………，它们各自的职责如#ref(<table:mtv>)所示：

#figure(
  three-line-table(
    columns: 2,
    header: ("层次", "职责"),
    [模型（Model），即数据存取层],
    [主要用于处理业务对象和数据库对象之间的关系。],
    [模板(Template)，即表现层],
    [主要负责把页面内容展示给用户，即Html页面的展示],
    [视图（View），即业务逻辑层],
    [主要用于编写业务逻辑，控制和调用模型以及模板],
  ),
  caption: [MTV模式职责表],
) <table:mtv>

=== 三级标题1

文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本。

=== 三级标题2

文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本。

== 二级标题2

文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文，MTV模式具体关系如#ref(<figure:mtv-relationship>)所示：

#figure(
  image("assets/images/mtv.png", width: 90%),
  caption: [MTV模式关系图],
) <figure:mtv-relationship>

= 一级标题3

最后一部分是论文的结论，#highlight[一般命名为“结束语”]。要求作者对毕业设计（论文）工作进行总结的基础上，经过分析、归纳，明确结论：

#highlight[
  ①总结本文所述工作，并对所做工作进行分析、评述；

  ②系统功能、指标等是否实现或达到课题要求（工程技术及软件课题）

  或：②理论结果是否正确、所建模型是否合理（理论课题）

  ③本课题有待进一步解决的问题及方向
]

结论具有相对的独立性，不应是对论文主体中各章小结的简单重复，要与引言相呼应。结论必须明确、精炼、严谨，避免使用“大概”、“或许”、“可能是”等词语；不应有解释性词语，而应直接给出结果。常识性的结果或重复他人的结果不应作为结论。

#acknowledgement[
  对指导老师和给予指导或协助完成毕业论文工作的组织和个人表示感谢。文字要简捷、实事求是，切忌浮夸和庸俗之词。
]

#commitment(
  signature: place(
    right + bottom,
    dx: -0.5cm,
    dy: 0.3cm,
    image("assets/signatures/ela.png", height: 50pt),
  ),
)
