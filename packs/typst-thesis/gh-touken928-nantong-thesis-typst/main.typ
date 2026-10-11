#import "template/ntu-bachelor.typ": ntu-bachelor, fig, tbl, references, acknowledgement, appendix, when-section
#import "figures/pipeline.typ": pipeline
#import "tables/measurements.typ": samples, measurements

// 元信息、摘要和全文集中在此编辑。
#show: ntu-bachelor.with(
  kind: "design", // design：毕业设计；thesis：毕业论文。
  cover-title: none, // none 沿用 kind 的名称，也可填写自定义内容。
  header-title: none,
  sections: (
    declaration: true, // 诚信承诺书及使用授权。
    abstract: true, // 中文摘要及关键词。
    abstract-en: true, // 英文摘要及关键词。
    toc: true, // 目录。
    references: true, // 文献角标及参考文献列表。
    acknowledgement: true, // 致谢。
    appendix: true, // 全部附录。
  ),
  title: "指纹增强算法的设计与实现",
  author: "张三",
  major: "机器人工程",
  advisor: "李四",
  date: (year: 2026, month: 5, day: 30),
  keywords: ("指纹增强", "脊线方向", "Gabor 滤波", "实验评价"),
  keywords-en: ("Fingerprint Enhancement", "Ridge Orientation", "Gabor Filtering", "Experimental Evaluation"),
  abstract: [
    本项目以指纹图像增强为统一写作主题，提供本科毕业论文和毕业设计的结构化示例。针对研究问题、实现过程与实验资料分散存放时容易产生的内容不一致，示例按照引言、方法设计、实验与结果、结论四个部分组织正文，在同一入口文件中填写题目、作者、指导教师及中英文关键词，并将流程图及其图片、表格及其数据和参考文献放入对应目录。方法部分说明处理流程和评价指标，实验部分说明样本记录的组织方式，附录直接读取数据文件生成完整记录表，演示长表分页、表头重复与续表编号。通过稳定的标签引用，图、表和公式在调整章节顺序后仍能自动更新编号，参考文献则按正文首次引用顺序排列。

    本文中的四十五条样本记录为人工构造的排版演示数据，用于检查数据读取、表格展示和分页规则，不构成算法性能的实验依据。正式论文应替换为真实实验资料，说明采集来源、评价方法和运行环境，并结合核实后的文献形成可以由证据支持的结论。示例重点展示一套便于持续写作和维护的论文项目组织方式。
  ],
  abstract-en: [
    This project uses fingerprint image enhancement as a consistent example topic for an undergraduate thesis or graduation design. The document is organized into an introduction, methods, experiments and results, and conclusions. Document information, abstracts, and chapter text are maintained in one entry file. Figures and their data, tables and their data, and bibliography files have dedicated directories.

    The methods chapter introduces a processing pipeline and an evaluation metric. The results chapter explains how to organize sample records stored in a CSV file. The appendix lists all sample records to demonstrate automatic table continuation, repeated headers, and stable numbering. References to figures, tables, and equations use labels rather than manually entered numbers.

    The forty-five sample records are synthetic layout data. They demonstrate the document workflow and do not establish the performance of any fingerprint enhancement algorithm. A submission must replace these records with real experiments and document the data source, evaluation protocol, computing environment, and evidence supporting its conclusions.
  ],
  bib: "/references/refs.bib",
)

= 引言

== 研究背景与问题

指纹增强研究需要将图像处理方法与明确的评价任务联系起来。Hong 等讨论了利用局部方向和频率信息改善脊线清晰度的方法，并结合特征提取与识别任务进行评价@hong1998。正式写作时，应从应用场景出发，说明现有方法的适用条件，再提出本文需要回答的具体问题。

本示例围绕“如何组织一种指纹增强方案及其评价资料”展开，展示从研究问题、方法定义到数据记录和结果分析的写作顺序。流程图、数据表及文献引用均放在首次讨论它们的正文附近，完整记录放入附录。

== 相关研究与本文安排

相关研究应围绕同一个问题比较假设、处理步骤和评价方式，而不能只逐条罗列文献。Chikkerur 等提出基于短时傅里叶变换的指纹增强方法@chikkerur2007，可作为比较处理流程与参数估计方式的另一项参考。

第二章给出方法流程与评价指标，第三章展示数据组织和结果说明，第四章归纳可以由已有证据支持的结论及局限。附录列出全部演示记录，便于核对实验记录。

= 方法设计与实现

== 总体流程

本示例采用@fig-pipeline 表达处理模块之间的关系。正式论文应明确每个模块的输入、输出及关键参数，并解释所采用方案与研究问题之间的关系。这里的流程框用于展示结构，不替代算法细节或真实实现。

#fig(pipeline, caption: [指纹增强处理流程], label: <fig-pipeline>)

局部方向与频率估计是理解相关增强方法的重要环节@hong1998。采用不同估计策略时，应说明参数选择、边界处理和失败条件，并记录与比较方案保持一致的处理步骤。

== 评价指标与实现记录

=== 指标定义

为演示独立公式与交叉引用，使用样本质量分数的算术均值说明指标的表达方式，如@eq-mean。每个分数位于零到一之间；此处只约定演示字段的含义，不将它作为现有标准质量指标。

$ bar(q) = 1 / N sum_(i=1)^N q_i $ <eq-mean>

其中，$N$ 为样本数量，$q_i$ 为第 $i$ 个样本的质量分数。真实研究需要给出质量分数的计算方法、量纲、参考依据及适用范围。

=== 可复现的实现说明

实现部分应记录软件版本、运行设备、数据划分、参数设置和随机种子。比较不同方法时，应采用相同的样本与评价协议，并报告异常样本及其处理方式。具体实现代码和较长参数清单可以放入附录，正文保留理解方法所需的关键内容。

= 实验与结果分析

== 数据来源与实验设置

本示例共有 #samples.len() 条人工构造的样本记录，保存在表格目录的 CSV 文件中。每条记录包含样本标识、三种处理方案的质量分数和自适应方案的耗时。所有数值均用于排版演示，不能据此宣称某种算法在真实数据上具有优势。

正式写作时，此节应说明数据来源、授权条件、样本筛选和实验环境；训练、验证与测试数据需要明确区分。正文应先定义比较任务，再展示用于回答该任务的结果。

== 样本记录的呈现

#when-section("appendix", otherwise: [
  完整记录保存在表格目录中的 CSV 数据文件中，字段包含样本标识、各方案的质量分数和耗时单位。每一行对应一条样本记录，可直接核对原始数据。
])[
  完整记录见@tab-measurements，表头给出样本标识、各方案的质量分数和耗时单位。每一行与 CSV 文件中的一条记录对应，调整记录数量后，附录中的表格会自动更新并按需要续页。
]

记录的呈现应便于逐行核对。正式写作时，需要注明缺失值、异常值和单位换算的处理方式，保留支持正文分析的原始记录及实验条件。

== 结果解释与局限

结果分析应区分观察、解释与结论，说明差异的大小、稳定性及适用条件。仅列出样本记录还不足以判断统计显著性，也不能推断结果在其他采集环境中的表现。本文的演示记录尤其不支持真实算法的性能结论。

#when-section("appendix", otherwise: [完整记录保存在表格目录中的 CSV 数据文件中。])[完整记录见@tab-measurements。]真实研究还应结合误差分析、运行成本及失败样本，说明方法是否解决了引言提出的问题，并如实报告尚未解决的部分。

= 结论与展望

本示例建立了从研究问题、方法流程到数据展示的完整写作结构。图表编号、公式引用及参考文献按模板自动处理，完整记录从 CSV 文件读取并通过附录长表展示。数据和排版内容分别维护，有助于核对引用、表格内容与原始记录。

由于示例没有开展真实指纹增强实验，本文不对任何方案的实际性能作出结论。正式论文应逐项回应研究问题，归纳证据能够支持的结果，明确限制，并提出与这些限制相关的后续工作；结论部分不宜引入正文中尚未讨论的新实验。

#references()

#acknowledgement[
  感谢指导教师在选题、方法讨论与论文修改中给予的指导，感谢提供实验条件和研究帮助的老师与同学。正式写作时应据实填写，明确具体帮助，使用简洁、客观的语言。
]

#appendix("完整样本记录")[
  以下为数据文件中的全部演示记录。样本标识用于逐行核对，质量分数没有量纲，自适应方案耗时的单位为毫秒。正式论文应替换为真实记录，并在正文说明各字段的采集或计算方式。

  #tbl(measurements, caption: [完整样本记录（演示数据）], label: <tab-measurements>)

  长表自动续页，后续页重复表头并沿用表号；调整记录数量后无需手动拆表。
]
