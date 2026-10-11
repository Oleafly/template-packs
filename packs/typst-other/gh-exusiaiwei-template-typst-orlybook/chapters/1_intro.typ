#import "../orly-config.typ": tip, note, warning, important, example-box, definition, theorem, proof-box

= 深度学习基础

本章将介绍深度学习的核心概念#footnote[深度学习是机器学习的一个分支，使用多层神经网络来学习数据的层次化表示。]，包括神经网络的基本原理、常用的激活函数和损失函数。

== 神经网络简介

神经网络是一种受生物神经系统启发的计算模型#footnote[最早的神经网络模型可追溯到1943年 McCulloch 和 Pitts 提出的 M-P 神经元模型。]。一个简单的神经元可以表示为：

$ y = f(sum_(i=1)^n w_i x_i + b) $

其中：
- $x_i$ 是输入特征
- $w_i$ 是权重参数
- $b$ 是偏置项
- $f$ 是激活函数

#tip[
  在实际应用中，神经网络通常包含多个层，每层有多个神经元。层数越多，网络的表达能力越强，但也更容易过拟合。
]

== 激活函数

激活函数为神经网络引入非线性，使其能够学习复杂的模式。

#definition(title: "ReLU 激活函数")[
  *ReLU (Rectified Linear Unit)* 是目前最常用的激活函数，定义为：
  $ "ReLU"(x) = max(0, x) $
  ReLU 的优点是计算简单，且能有效缓解梯度消失问题。
]

常见的激活函数比较（三线表样式）：

#figure(
  table(
    columns: 3,
    [*函数*], [*公式*], [*特点*],
    [Sigmoid], [$sigma(x) = 1/(1+e^(-x))$], [输出范围 $(0,1)$],
    [Tanh], [$tanh(x)$], [输出范围 $(-1,1)$],
    [ReLU], [$max(0, x)$], [计算高效],
    [Softmax], [$e^(x_i) / sum_j e^(x_j)$], [多分类输出],
  ),
  caption: [常见激活函数比较]
)

== 损失函数与优化

=== 交叉熵损失

对于分类问题，常用交叉熵损失函数：

$ L = -sum_(i=1)^C y_i log(hat(y)_i) $

其中 $C$ 是类别数，$y_i$ 是真实标签，$hat(y)_i$ 是预测概率。

#example-box(title: "二分类示例")[
  考虑一个二分类问题，假设真实标签为 $y = 1$，预测概率为 $hat(y) = 0.9$，则：
  $ L = -log(0.9) approx 0.105 $
  预测越准确，损失越小。
]

=== 梯度下降

梯度下降是最基本的优化算法，参数更新规则为：

$ theta_(t+1) = theta_t - eta nabla_theta L $

#theorem(title: "梯度下降收敛性")[
  当学习率 $eta$ 足够小且损失函数 $L$ 是凸函数时，梯度下降保证收敛到全局最优解。
]

#warning[
  学习率选择很重要！太大会导致震荡甚至发散，太小会导致收敛速度过慢。
]

== 代码示例

以下是使用 Python 实现一个简单神经网络层的示例：

```python
import numpy as np

class DenseLayer:
    def __init__(self, input_dim, output_dim):
        self.W = np.random.randn(input_dim, output_dim) * 0.01
        self.b = np.zeros(output_dim)

    def forward(self, x):
        return np.maximum(0, x @ self.W + self.b)  # ReLU
```

#proof-box(title: "反向传播的正确性")[
  根据链式法则，对于复合函数 $L(f(g(x)))$，有：
  $ (partial L) / (partial x) = (partial L) / (partial f) dot (partial f) / (partial g) dot (partial g) / (partial x) $
  这正是反向传播算法的理论基础。
]

#note[
  反向传播算法是深度学习训练的核心，它使得我们能够高效地计算梯度并更新参数。
]
