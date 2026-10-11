#import "template.typ": *

// ---------------- 使用模板 ----------------
#show: project.with(
  title: "基于哈哈哈的哈哈哈系统与哈哈哈", // 你的报告题目
  major: "哈哈哈工程",
  course: "哈哈哈系统",
  student-name: "哈哈哈",
  student-id: "2333333333333",
  advisor: "哈哈哈 啊哈哈",
  date: "哈哈哈哈 年 哈哈 月",
)

// ---------------- 摘要部分 ----------------
#abstract-page(
  [
    本文针对传统图像识别算法准确率低、鲁棒性差的问题，设计并实现了一个基于卷积神经网络（CNN）的图像识别系统。报告首先介绍了深度学习的基本理论，详细阐述了 ResNet 模型的结构特点；其次，设计了系统的总体架构，包括数据预处理模块、模型训练模块和推理服务模块；最后，在 CIFAR-10 数据集上进行了实验验证。

    实验结果表明，该系统在测试集上的准确率达到了 92.5%，相比传统 SVM 算法提升了 15%。该系统具有较好的应用前景。
  ],
  [深度学习；卷积神经网络；图像识别；Python],
  // en-abstract: [
  //   // 如果需要英文摘要，填在这里，不需要则删掉此参数
  //   To address the problems of low accuracy and poor robustness in traditional image recognition algorithms, this paper designs and implements an image recognition system based on Convolutional Neural Networks (CNN)...
  // ],
)

// ---------------- 目录 ----------------

#outline-page()

// ---------------- 正文开始 ----------------

= 实验目的和意义

== 实验目的
本实验旨在通过实际动手设计和编码，让学生：
1. 掌握深度学习框架（如 PyTorch）的基本使用方法。
2. 熟悉软件工程全生命周期的开发流程，包括需求分析、设计、编码和测试。
3. 提高解决实际工程问题的能力。

== 实验意义
随着人工智能技术的飞速发展，图像识别在安防、医疗、自动驾驶等领域有着广泛的应用。通过本实验，不仅能够巩固理论知识，还能锻炼工程实践能力，为未来的科研或工作打下基础。

= 实验设计

== 总体架构
系统采用 B/S 架构，前端使用 React 框架，后端采用 Flask 提供 RESTful API，核心算法模型部署在 GPU 服务器上。

== 核心算法设计
本系统采用 ResNet-50 作为主干网络。

=== 残差模块
残差网络通过引入跳跃连接（Skip Connection），有效解决了深层网络中的梯度消失问题。其数学表达如 @eq-residual 所示：

$ y = F(x, {W_i}) + x $ <eq-residual>

其中，$x$ 为输入，$y$ 为输出，$F(x, {W_i})$ 为需要学习的残差映射。

== 数据库设计
系统使用 MySQL 存储用户信息和识别记录。主要表结构如 @tbl-user 所示：

#figure(
  table(
    columns: (auto, auto, auto),
    inset: 10pt,
    align: center,
    [*字段名*], [*类型*], [*说明*],
    [id], [INT], [主键，自增],
    [username], [VARCHAR], [用户名],
    [password], [VARCHAR], [加密后的密码],
  ),
  caption: [用户表结构设计],
) <tbl-user>

= 实验结果与分析

== 实验环境
实验硬件环境如下：
- CPU: Intel Core i7-12700K
- GPU: NVIDIA GeForce RTX 3080 10GB
- RAM: 32GB DDR4

== 结果分析
训练过程中的损失函数变化曲线如 @fig-loss 所示。可以看出，模型在第 50 轮迭代后收敛。

// 插入图片示例 (请确保目录下有 image.png 或者替换为你自己的图片)
#figure(
  // image("image.png", width: 80%),
  rect(width: 80%, height: 6cm, fill: luma(240))[此处插入实验结果图], // 占位符
  caption: [训练损失函数变化曲线],
) <fig-loss>

#indent 从 @tbl-result 可以看出，本算法在各项指标上均优于对比算法。

#figure(
  table(
    columns: 4,
    align: center,
    [*算法*], [*准确率*], [*召回率*], [*F1-Score*],
    [SVM], [78.5%], [76.2%], [0.77],
    [CNN (Ours)], [92.5%], [91.8%], [0.92],
  ),
  caption: [不同算法性能对比],
) <tbl-result>

= 结论
本实验成功设计并实现了一个基于深度学习的图像识别系统...
(此处省略 500 字) ...
未来将在模型轻量化方面做进一步研究，以便在移动端部署。 

// ---------------- 参考文献 ----------------
#bib-list[
  [1] LeCun Y, Bengio Y, Hinton G. Deep learning[J]. Nature, 2015, 521(7553): 436-444.

  [2] 何恺明. Deep Residual Learning for Image Recognition[C]//CVPR. 2016.
]
// 这里可以使用 BibTeX，为了演示方便直接手写，实际建议用 #bibliography("ref.bib")



// ---------------- 附录 ----------------
#pagebreak()
#heading(level: 1, numbering: none)[附录]

#heading(level: 2, numbering: none)[核心代码]

```python
import torch
import torch.nn as nn

class ResNet(nn.Module):
    def __init__(self, block, layers, num_classes=1000):
        super(ResNet, self).__init__()
        # ... Implementation ...
```

// ----- 教师评语页 ------
#grading-page()