= 排版示例

本章展示了模板支持的各种排版功能，包括图片、表格、数学公式、代码块和参考文献引用等。

== 图片

使用 `figure` 和 `image` 命令插入图片，图片标题位于图片下方。图片编号按章编号，格式为"图 X-Y"。

#figure(
  image("../figures/neural-network.png", width: 80%),
  caption: [神经网络结构示意图],
) <fig:neural-network>

如@fig:neural-network 所示，这是一个插入真实图片的示例。将图片文件放在 `figures/` 目录下，然后使用 `image()` 函数引入即可。`width` 参数控制图片宽度，可以是百分比或绝对长度。在正文中引用图片时，使用 `@fig:label` 语法即可自动生成"图 X-Y"格式的引用。

也可以将多个子图并排显示：

#figure(
  grid(
    columns: 2,
    gutter: 16pt,
    image("../figures/neural-network.png", width: 100%),
    image("../figures/neural-network.png", width: 100%),
  ),
  caption: [并排展示两张图片的示例],
) <fig:side-by-side>

== 表格

表格标题位于表格上方。推荐使用三线表格式，即表格仅有顶线、表头线和底线三条水平线。

#figure(
  table(
    columns: 4,
    stroke: none,
    table.hline(stroke: 1.5pt),
    table.header([*方法*], [*精确率*], [*召回率*], [*F1 值*]),
    table.hline(stroke: 0.75pt),
    [方法 A], [0.856], [0.823], [0.839],
    [方法 B], [0.892], [0.867], [0.879],
    [方法 C], [0.912], [0.891], [0.901],
    table.hline(stroke: 1.5pt),
  ),
  kind: table,
  caption: [不同方法的性能比较],
) <tbl:compare>

@tbl:compare 展示了不同方法的性能对比数据。在正文中引用表格时，使用 `@tbl:label` 语法。

也可以使用模板提供的辅助表格组件，简化排版代码。

== 数学公式

模板支持行内公式和独立公式。行内公式如 $E = m c^2$ 嵌入正文中。独立公式按章编号，格式为"(X-Y)"。

贝叶斯定理：

$ P(A | B) = frac(P(B | A) P(A), P(B)) $ <eq:bayes>

@eq:bayes 是贝叶斯定理的数学表达式。梯度下降更新公式：

$ theta_(t+1) = theta_t - eta nabla_(theta) cal(L)(theta_t) $ <eq:gradient>

多行公式可以使用对齐环境：

$
  cal(L)(theta) &= -1/N sum_(i=1)^N [y_i log hat(y)_i + (1 - y_i) log(1 - hat(y)_i)] \
  &= -1/N sum_(i=1)^N sum_(c=1)^C y_(i,c) log hat(y)_(i,c)
$ <eq:loss>

== 代码块

行内代码使用反引号标记，如 `print("Hello, Typst!")`。代码块支持语法高亮：

```python
import torch
import torch.nn as nn

class TextClassifier(nn.Module):
    def __init__(self, vocab_size, embed_dim, num_classes):
        super().__init__()
        self.embedding = nn.Embedding(vocab_size, embed_dim)
        self.fc = nn.Linear(embed_dim, num_classes)

    def forward(self, x):
        x = self.embedding(x).mean(dim=1)
        return self.fc(x)
```

== 参考文献引用

模板采用 GB/T 7714—2015 标准的参考文献格式。使用 `@label` 语法引用参考文献。

深度学习的快速发展推动了自然语言处理领域的进步@devlin2019bert。Transformer 架构@vaswani2017attention 奠定了预训练语言模型的基础。文本分类是自然语言处理的基础任务之一@kim2014cnn。

== 脚注

在文中可以添加脚注#footnote[这是一个脚注示例，根据规范，硕士学位论文采用篇末注，博士学位论文采用章末注。如有特殊需要，也可使用脚注。]来补充说明。

== 列表

=== 无序列表

- 这是无序列表的第一项
- 这是无序列表的第二项
  - 支持嵌套列表
  - 嵌套的第二项
- 第三项

=== 有序列表

+ 第一步：准备 Typst 环境
+ 第二步：克隆模板仓库
+ 第三步：修改论文信息
+ 第四步：编写正文内容
+ 第五步：编译生成 PDF
