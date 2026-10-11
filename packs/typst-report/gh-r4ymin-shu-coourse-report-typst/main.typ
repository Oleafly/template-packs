#import "shu-report.typ": shu-report, tbox

#show: body => shu-report(
  title: "机器学习基础课程报告",
  subtitle: "多模态仇恨模因识别实验",
  author: "请填写姓名",
  student-id: "请填写学号",
  department: "上海大学计算机工程与科学学院",
  header-title: "上海大学课程论文",
  date: (2026, 6, 3),
  body,
)

= 模板说明

本模板参考上海大学课程论文 LaTeX 模板的编排方式制作。页面默认使用 A4 纸，页边距为 2.5cm，中文正文使用宋体，英文使用 Times New Roman，字号为 12pt。封面包含上海大学校名标识、课程报告标题、副标题、姓名、学号、学院和日期；目录页之后进入正文。

本 Typst 文件由以下部分组成：

- `main.typ`：主文件，用于填写课程报告信息和正文内容。
- `shu-report.typ`：文档格式控制，包含页边距、页眉、封面、标题、文本框等设置。
- `assets`：放置图片文件，本模板使用 `SHU_logo.pdf` 作为封面 logo。

第一次使用时，只需要修改 `main.typ` 开头的标题、姓名、学号、学院、日期等信息，然后继续编辑正文即可。

= 实验目的

本实验围绕多模态图文分类任务，完成数据预处理、模型训练、融合策略设计、性能评估与错误样本分析。通过实验理解机器学习任务从数据到模型再到评价的完整流程，并比较文本、图像以及图文融合特征在分类任务中的作用。

= 实验环境

#table(
  columns: (3.2cm, 1fr),
  stroke: 0.5pt + luma(180),
  inset: 7pt,
  [操作系统], [Windows],
  [开发工具], [Visual Studio Code],
  [编程语言], [Python 3.12],
  [主要依赖], [PyTorch、torchvision、transformers、scikit-learn、NumPy、tqdm],
  [排版工具], [Typst、Tinymist],
) <env-table>

= 实验原理

多模态分类任务需要同时利用图像信息和文本信息。对于样本 $(x_i, t_i, y_i)$，其中 $x_i$ 表示图像，$t_i$ 表示文本，$y_i$ 表示类别标签。模型分别提取图像特征 $v_i$ 和文本特征 $s_i$，再通过拼接、加权或门控网络得到融合特征：

$ z_i = "fusion"(v_i, s_i) $ <fusion-eq>

分类器根据融合特征输出类别预测，训练目标通常是最小化交叉熵损失，如 @loss-eq 所示：

$ L(theta) = - sum_i log p_theta(y_i | x_i, t_i) $ <loss-eq>

与单模态模型相比，多模态模型能够利用更多上下文信息。例如，单独观察图像可能无法判断其语义倾向，而文本能够提供显式提示；单独观察文本也可能缺少场景背景，而图像能够补充对象、人物和环境信息。

= 一些插入功能

== 插入公式

行内公式示例：$v - epsilon + phi = 2$。

行间公式如 @fusion-eq 和 @loss-eq 所示。Typst 中可以通过标签 `<label>` 标记公式、图片和表格，再通过 `@label` 引用。

== 插入图片

SHU 校徽如 @shu-logo 所示。这里使用的图片文件来自 `assets/SHU_logo.pdf`。

#figure(
  image("assets/SHU_logo.pdf", width: 40%),
  caption: [上海大学],
) <shu-logo>

== 插入文本框

本模板定义了一个圆角灰底文本框，使用 `#tbox[...]` 即可。

#tbox[
  这是一个圆角灰底的文本框。可以用于提示实验设置、关键结论或需要单独强调的内容。
]

== 插入表格

本模板文件组成如 @doc-table 所示。

#figure(
  table(
    columns: (4cm, 8cm),
    stroke: 0.5pt + black,
    inset: 7pt,
    table.header([文件名], [说明]),
    [`main.typ`], [主文件],
    [`shu-report.typ`], [文档格式控制],
    [`assets`], [图片文件夹],
  ),
  caption: [本模板文件组成],
) <doc-table>

= 实验步骤

== 数据准备

首先读取实验数据，并对图像和文本分别进行预处理。图像部分进行尺寸统一、张量转换和归一化处理；文本部分进行清洗、分词或编码。若数据中存在 OCR 文本，可以将其作为额外文本特征参与模型训练。

== 模型训练

实验中可以分别训练文本模型、图像模型和图文融合模型。每一轮训练包括前向传播、损失计算、反向传播和参数更新。训练结束后，在验证集上计算准确率、F1 值等指标，用于选择较优模型。

== 融合与集成

为了提升分类稳定性，可以将多个模型的输出进行融合。例如，对不同模型输出概率进行加权平均，或者使用门控网络根据样本特征动态调整各模型权重。若不同模型在错误样本上具有互补性，集成方法通常能够获得更好的泛化性能。

= 实验结果

请根据实际运行结果填写下表。

#figure(
  table(
    columns: (auto, auto, auto, 1fr),
    stroke: 0.5pt + luma(180),
    inset: 7pt,
    table.header([模型], [准确率], [F1 值], [说明]),
    [文本模型], [请填写], [请填写], [仅使用文本或 OCR 信息],
    [图像模型], [请填写], [请填写], [仅使用图像信息],
    [图文融合模型], [请填写], [请填写], [融合图像和文本特征],
    [集成模型], [请填写], [请填写], [多个专家模型或加权融合],
  ),
  caption: [不同模型实验结果对比],
) <result-table>

= 结果分析

从实验结果可以比较不同模态对分类性能的贡献。如果文本模型表现较好，说明数据中的文本信息对类别判断具有较强提示作用；如果图像模型表现较好，说明视觉场景或对象本身已经包含较明显的类别线索；如果融合模型优于单模态模型，则说明图像与文本之间存在有效互补。

若集成模型优于单一模型，说明不同模型在特征表达和错误分布上存在差异。此时可以进一步分析错误样本，观察模型是否容易受到讽刺语义、遮挡、低质量图片或 OCR 识别错误的影响。

= 实验总结

本实验完成了多模态分类任务的基本流程，包括数据处理、模型训练、融合策略设计和结果分析。实验表明，机器学习模型的最终表现不仅取决于模型结构，也受到数据质量、特征表达、训练策略和评价方式的共同影响。

后续可以从以下方向继续改进：增加更稳定的数据增强策略，引入更强的视觉语言预训练模型，设计样本级动态融合权重，并对困难样本进行针对性分析。

= 参考文献

1. Christopher M. Bishop. Pattern Recognition and Machine Learning. Springer, 2006.
2. PyTorch Contributors. PyTorch Documentation. https://pytorch.org/docs/stable/index.html.
3. Kiela, Douwe, et al. The Hateful Memes Challenge: Detecting Hate Speech in Multimodal Memes. NeurIPS, 2020.
