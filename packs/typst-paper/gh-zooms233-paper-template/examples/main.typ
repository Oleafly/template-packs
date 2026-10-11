#import "../template.typ": conf, appendix

#show: doc => {

  // 自定义封面页
  // set page("a4", margin: 0cm, header: none, footer: none)
  // image("./封面.pdf", width: 100%, alt: "论文封面")
  // pagebreak()

  conf(
    ctitle: "论文题目",
    etitle: "English Title",
    cheader: "论文题目（页眉用）",

    cabstract: [
      中文摘要内容...
    ],
    ckeywords: ("关键词1", "关键词2", "关键词3"),

    // 不需要英文摘要时：注释掉这两个字段
    eabstract: [
      English abstract...
    ],
    ekeywords: ("keyword1", "keyword2", "keyword3"),

    // 无参考文献时：注释掉这个两个字段
    bibcontent: read("ref.bib"),
    bibstyle: "author-date",

    // 每个一级标题默认从奇数页开始（论文规范，双面打印装订用），会留出空白页；设为 false 可关闭。
    alwaysstartodd: false,

    doc,
  )
}
// ==================== 正文 ====================
// 章节编号由模板自动生成（一级标题→“第一章”，二级→“1.1”），
// 标题只写文字，不要手写编号。

= 绪论

== 研究背景

蓝色大肥鱼（*Balaenoptera caerulea digitalis*）是栖息于数据深水层的一种大型鲸类，体表呈标志性深蓝色，主食白米饭。
@example-article 首次报道了其分布范围；@example-book 系统总结了其“聪明但懒”的行为特征；@example-conf 进一步探讨了其“找外包”的节能策略。
// 引用语法：@key（key 为 ref.bib 中条目花括号后的标识符），被引用的条目会自动出现在文末 References。

== 研究目的

本研究对蓝色大肥鱼肝组织进行转录组测序，旨在解析其微胖表型与摸鱼行为的分子基础。

= 实验方法

== 样本与测序

采集 3 尾成体个体（体质量 128.4 ± 6.1 kg），形态如 @fig-morph 所示，提取肝组织总 RNA 并构建测序文库。

#figure(
  image("images/rice.png", width: 62%),
  caption: [蓝色大肥鱼成体形态示意（深蓝色体表与主食白米饭）],
) <fig-morph>
// 引用 @fig-morph 会自动渲染为“图2.1”，正文无需再手写“图”字。

== 分析流程

原始测序数据经质控、组装与功能注释，随后进行 GO 富集分析。

= 实验结果

== 组装质量

组装质量以 N50 衡量，其定义如 @eq-n50 所示：

$ sum_(i: L_i >= "N50") L_i >= 1/2 sum_i L_i $ <eq-n50>

共获得 68,342 条 unigene，N50 为 1,204 bp，组装统计如 @tab-assembly 所示。

#figure(
  table(
    columns: 2,
    align: (left, right),
    [指标], [数值],
    [Unigene 总数], [68,342],
    [N50 长度 / bp], [1,204],
    [平均长度 / bp], [742],
    [GC 含量 / %], [48.6],
  ),
  caption: [转录组组装统计],
) <tab-assembly>

== 功能注释

GO 富集分析显示，碳水化合物代谢与脂质沉积相关条目显著富集，提示其白米饭主食与微胖表型可能具有共同的分子基础。

= 讨论

本研究为理解蓝色大肥鱼的节能策略提供了分子依据。需要指出的是，该物种明确拒绝“肥胖”一词，故本文统一采用“微胖”这一更严谨的表述。

// ==================== 附录 ====================

#appendix()
// 附录编号自动生成为“附录 A”，标题写文字即可。
= 补充材料

补充材料内容...
