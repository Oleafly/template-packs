#import "../lib.typ": heuthesis
#import "../src/pages/appendix.typ": appendix-page

#show: heuthesis.with(
  title: "基于深度学习的目标检测算法研究",
  title-en: "Research on Object Detection Algorithm Based on Deep Learning",
  author: "张三",
  student-id: "2020010101",
  classification: "公开",
  department: "计算机科学与技术学院",
  major: "计算机科学与技术",
  supervisor: "李四 教授",
  supervisor-title: "教授",
  supervisor-dept: "计算机科学与技术学院",
  submit-date: "2024年6月1日",
  defense-date: "2024年6月15日",
  date: datetime(year: 2024, month: 6, day: 1),
  abstract-zh-keywords: ("深度学习", "目标检测", "卷积神经网络", "特征提取"),
  abstract-zh-body: [
    本文研究了基于深度学习的目标检测算法。随着计算机视觉技术的快速发展，目标检测作为其核心任务之一，在自动驾驶、视频监控、医学影像等领域有着广泛的应用。本文首先对目标检测的发展历程进行了系统的梳理，然后重点分析了基于卷积神经网络的目标检测方法，包括两阶段检测器和单阶段检测器的原理与特点。

    在此基础上，本文提出了一种改进的特征提取网络结构，通过引入注意力机制和多尺度特征融合策略，有效提升了小目标的检测精度。实验结果表明，所提方法在PASCAL VOC和MS COCO数据集上均取得了优异的性能，其中在VOC2007测试集上mAP达到了82.3%，相比基线方法提升了3.5个百分点。
  ],
  abstract-en-keywords: ("deep learning", "object detection", "convolutional neural network", "feature extraction"),
  abstract-en-body: [
    This paper studies object detection algorithms based on deep learning. With the rapid development of computer vision technology, object detection, as one of its core tasks, has wide applications in autonomous driving, video surveillance, medical imaging and other fields. This paper first systematically reviews the development of object detection, and then focuses on analyzing object detection methods based on convolutional neural networks, including the principles and characteristics of two-stage detectors and single-stage detectors.

    Based on this, this paper proposes an improved feature extraction network structure, which effectively improves the detection accuracy of small objects by introducing attention mechanisms and multi-scale feature fusion strategies. Experimental results show that the proposed method achieves excellent performance on both PASCAL VOC and MS COCO datasets, with mAP reaching 82.3% on the VOC2007 test set, an improvement of 3.5 percentage points over the baseline method.
  ],
  conclusion: [
    本文对基于深度学习的目标检测算法进行了深入研究，主要工作和结论如下：

    （1）系统梳理了目标检测算法的发展历程，从传统方法到深度学习方法，分析了各类方法的优缺点，为后续研究奠定了理论基础。

    （2）提出了一种改进的特征提取网络，通过引入通道注意力机制增强了网络对关键特征的表达能力，使模型能够自适应地关注目标区域。

    （3）设计了双向多尺度特征融合模块，通过自顶向下和自底向上的融合路径，有效整合了不同层级的语义信息和空间信息，显著提升了小目标的检测精度。

    （4）在PASCAL VOC和MS COCO数据集上进行了充分的实验验证，结果表明所提方法在mAP指标上相比基线方法有明显提升，验证了各模块的有效性。

    本文的研究工作仍存在一些不足之处。首先，所提方法在处理极端遮挡目标时性能仍有待提升；其次，模型的推理速度还有进一步优化的空间。未来的工作将围绕这两个方面展开深入研究。
  ],
  bib-file: "../../example/refs.bib",
  achievements: [
    [1] 张三, 李四. 基于轻量级注意力机制的目标检测算法[J]. 计算机工程与应用, 2024, 60(5): 123-130.

    [2] 张三, 李四, 王五. 双向多尺度特征融合的小目标检测方法[C]\/\/第十二届全国计算机视觉大会论文集. 哈尔滨: 2024: 45-52.

    [3] 张三. 一种基于注意力机制的目标检测系统V1.0[CP]. 登记号: 2024SR0012345.
  ],
  acknowledgement: [
    时光荏苒，四年的本科学习生涯即将画上句号。在论文完成之际，我要向所有给予我帮助和支持的人表达最诚挚的感谢。

    首先，我要衷心感谢我的导师李四教授。从选题到实验设计，从论文撰写到反复修改，李老师都给予了我悉心的指导和耐心的帮助。李老师严谨的治学态度、渊博的学识和对科研的热情深深地影响了我，使我受益匪浅。

    感谢实验室的王五、赵六等同学，在实验过程中给予我的帮助和建议。我们一起讨论问题、分享经验的日子是我大学生活中最宝贵的回忆之一。

    感谢计算机科学与技术学院的各位老师，他们在课堂上传授的知识为我的研究工作打下了坚实的基础。

    最后，感谢我的家人一直以来的理解、支持和鼓励。正是他们无私的爱和默默的付出，让我能够安心学习、专注科研。

    谨以此文献给所有关心和帮助过我的人。
  ],
  appendix: [
    #appendix-page(label: "A", title: "实验补充数据", standard: "GB/T 28001-2011")[
      == 附录A1：各类别检测精度详细数据

      本附录给出了所提方法在PASCAL VOC2007测试集上各类别的检测精度（AP）详细数据。

      #figure(
        table(
          columns: 6,
          table.hline(stroke: 1.5pt),
          [类别], [aero], [bike], [bird], [boat], [bottle],
          table.hline(stroke: 0.5pt),
          [Faster R-CNN], [79.2], [82.1], [71.3], [65.8], [58.2],
          [本文方法], [83.5], [85.7], [75.1], [70.2], [63.8],
          table.hline(stroke: 1.5pt),
        ),
        caption: [PASCAL VOC2007各类别AP对比（部分）],
        kind: table,
      )

      == 附录A2：训练超参数配置

      本文实验中使用的详细超参数配置如下：

      （1）骨干网络：ResNet-50，预训练权重来自ImageNet。

      （2）优化器：SGD，初始学习率0.01，动量0.9，权重衰减0.0001。

      （3）学习率策略：余弦退火，warmup轮数为500次迭代。

      （4）训练轮数：24个epoch，batch size为16。

      （5）输入尺寸：短边800，长边不超过1333。

      （6）数据增强：随机水平翻转（p=0.5）、随机裁剪、颜色抖动、多尺度训练（短边从640到800随机采样）。
    ]

    #appendix-page(label: "B", title: "核心算法伪代码")[
      == 附录B1：LCA模块前向传播

      ```
      Algorithm: LCA Forward Pass
      Input: Feature map F ∈ R^(H×W×C)
      Output: Refined feature map F' ∈ R^(H×W×C)

      1: z = GlobalAvgPool(F)          // z ∈ R^C
      2: s = Sigmoid(Conv1d(z, k=3))   // s ∈ R^C
      3: F' = F ⊙ s                    // channel-wise multiplication
      4: return F'
      ```

      == 附录B2：BMFF模块融合过程

      ```
      Algorithm: BMFF Fusion
      Input: Multi-scale features {C3, C4, C5}
      Output: Fused features {P3, P4, P5}

      // Top-down path
      1: P5_t = Conv1x1(C5)
      2: P4_t = Conv1x1(C4) + Upsample(P5_t)
      3: P3_t = Conv1x1(C3) + Upsample(P4_t)

      // Bottom-up path
      4: P3_b = Conv3x3(P3_t)
      5: P4_b = Conv3x3(P4_t) + Downsample(P3_b)
      6: P5_b = Conv3x3(P5_t) + Downsample(P4_b)

      // Adaptive fusion
      7: for i in {3, 4, 5}:
      8:   P_i = α_i * P_i_t + β_i * P_i_b
      9: return {P3, P4, P5}
      ```
    ]
  ],
)

= 绪论

== 研究背景与意义

目标检测是计算机视觉领域的基础性研究课题，其目的是在图像或视频中定位并识别特定类别的目标。近年来，随着深度学习技术的飞速发展，基于深度神经网络的目标检测方法取得了显著的进展，在自动驾驶、视频监控、医学影像分析、工业检测等众多领域展现出了巨大的应用价值。

在自动驾驶领域，目标检测系统需要实时准确地识别道路上的车辆、行人、交通标志等目标，为车辆的安全行驶提供决策依据。在视频监控领域，智能监控系统通过目标检测技术实现对异常行为的自动识别和预警。在医学影像领域，目标检测技术被广泛应用于病灶区域的自动定位和辅助诊断。

然而，现有的目标检测方法在面对小目标、遮挡目标和密集目标等复杂场景时，检测精度仍有较大的提升空间。因此，研究更加高效准确的目标检测算法具有重要的理论意义和实际应用价值。

== 国内外研究现状

目标检测的研究可以追溯到上世纪90年代，经历了从传统方法到深度学习方法的演变过程。

=== 传统目标检测方法

早期的目标检测方法主要基于手工设计的特征和传统机器学习分类器。Viola和Jones于2001年提出的基于Haar特征和AdaBoost分类器的人脸检测方法是该时期的代表性工作#cite(<viola2001>)。随后，Dalal和Triggs提出的HOG（Histogram of Oriented Gradients）特征结合SVM分类器的行人检测方法取得了较好的效果#cite(<dalal2005>)。Felzenszwalb等人提出的DPM（Deformable Parts Model）模型通过可变形部件的组合来表示目标，在PASCAL VOC竞赛中取得了优异的成绩。

然而，传统方法依赖于人工设计的特征，特征的表达能力有限，难以应对复杂多变的实际场景。

=== 基于深度学习的两阶段检测方法

2014年，Girshick等人提出了R-CNN（Regions with CNN features），首次将深度卷积神经网络引入目标检测领域，开创了基于深度学习的目标检测新范式#cite(<girshick2014>)。R-CNN首先通过选择性搜索算法生成约2000个候选区域，然后对每个候选区域提取CNN特征，最后使用SVM进行分类。

随后，SPPNet、Fast R-CNN和Faster R-CNN相继被提出，逐步解决了R-CNN计算效率低的问题。其中，Faster R-CNN引入了区域建议网络（RPN），实现了端到端的训练，成为两阶段检测方法的经典框架#cite(<ren2015>)。

=== 基于深度学习的单阶段检测方法

单阶段检测方法以YOLO（You Only Look Once）和SSD（Single Shot MultiBox Detector）为代表，直接在特征图上进行密集预测，省去了候选区域生成的步骤，具有更快的检测速度。

YOLO系列从YOLOv1发展到YOLOv8，在检测速度和精度之间取得了越来越好的平衡#cite(<redmon2016>)。SSD通过在多个尺度的特征图上进行预测，有效提升了对不同大小目标的检测能力#cite(<liu2016>)。RetinaNet提出了Focal Loss来解决正负样本不平衡的问题，显著提升了单阶段检测器的精度#cite(<lin2017focal>)。

== 本文主要工作

本文的主要工作包括以下几个方面：

（1）对目标检测算法的发展历程进行了全面的调研和分析，系统总结了各类方法的优缺点。

（2）提出了一种改进的特征提取网络结构，通过引入轻量级通道注意力模块增强特征表达能力。

（3）设计了双向多尺度特征融合模块，有效整合不同层级的语义信息和空间信息。

（4）在PASCAL VOC和MS COCO数据集上进行了充分的实验验证，证明了所提方法的有效性。

= 相关理论基础

== 卷积神经网络

卷积神经网络（Convolutional Neural Network, CNN）是深度学习中最重要的网络结构之一，广泛应用于图像分类、目标检测、语义分割等视觉任务中。CNN通过卷积层、池化层和全连接层的堆叠，能够自动学习图像的层次化特征表示。

=== 卷积层

卷积层是CNN的核心组件，通过卷积核在输入特征图上滑动计算，提取局部特征。设输入特征图为$X in RR^(H times W times C)$，卷积核为$W in RR^(k times k times C times C')$，则卷积操作可表示为：

$ Y_(i,j,c') = sum_(m=0)^(k-1) sum_(n=0)^(k-1) sum_(c=0)^(C-1) W_(m,n,c,c') dot X_(i+m,j+n,c) + b_(c') $

其中$b_(c')$为偏置项，$Y$为输出特征图。

=== 池化层

池化层通过下采样操作减小特征图的空间尺寸，降低计算量并增强特征的平移不变性。常用的池化操作包括最大池化和平均池化。

=== 经典网络结构

自AlexNet在2012年ImageNet竞赛中取得突破性成绩以来，涌现了大量优秀的CNN架构，包括VGGNet、GoogLeNet、ResNet、DenseNet等。其中，ResNet通过引入残差连接解决了深层网络的退化问题，使得训练数百层的网络成为可能#cite(<he2016>)。

== 注意力机制

注意力机制（Attention Mechanism）能够使网络自适应地关注输入中的重要区域，有效提升特征表达能力。在目标检测中，注意力机制被广泛应用于增强目标区域的特征响应。

=== 通道注意力

通道注意力通过学习各通道的重要性权重，对特征图的通道维度进行加权。SENet（Squeeze-and-Excitation Network）是通道注意力的代表性工作，通过全局平均池化和两个全连接层生成通道权重#cite(<hu2018>)。

=== 空间注意力

空间注意力通过学习特征图各空间位置的重要性，对特征图的空间维度进行加权。CBAM（Convolutional Block Attention Module）同时使用了通道注意力和空间注意力，取得了较好的效果#cite(<woo2018>)。

== 特征金字塔网络

特征金字塔网络（Feature Pyramid Network, FPN）通过自顶向下的路径和横向连接，将高层语义信息传递到低层特征图，构建了多尺度的特征金字塔#cite(<lin2017fpn>)。FPN有效解决了目标检测中多尺度问题，成为现代目标检测器的标准组件。

= 改进的目标检测算法

== 整体网络结构

本文提出的改进目标检测网络主要包括三个部分：骨干网络、增强特征金字塔网络和检测头。骨干网络采用ResNet-50作为基础，在其中嵌入轻量级通道注意力模块；增强特征金字塔网络采用双向融合策略；检测头沿用Faster R-CNN的设计。

== 轻量级通道注意力模块

本文设计了一种轻量级的通道注意力模块（Lightweight Channel Attention, LCA），相比SENet减少了约60%的参数量，同时保持了相当的性能。

LCA模块的计算过程如下：首先对输入特征图$F in RR^(H times W times C)$进行全局平均池化得到通道描述符$z in RR^C$：

$ z_c = 1/(H times W) sum_(i=1)^H sum_(j=1)^W F_(i,j,c) $

然后通过一个一维卷积层生成通道权重：

$ s = sigma(text("Conv1d")(z)) $

其中$sigma$为Sigmoid激活函数。最终输出为：

$ F'_(i,j,c) = s_c dot F_(i,j,c) $

== 双向多尺度特征融合

传统FPN仅采用自顶向下的单向融合路径，高层特征向低层传递的过程中信息会逐渐衰减。本文提出的双向多尺度特征融合模块（Bidirectional Multi-scale Feature Fusion, BMFF）同时包含自顶向下和自底向上两条融合路径。

设骨干网络输出的多尺度特征为${C_3, C_4, C_5}$，自顶向下路径生成${P_3^t, P_4^t, P_5^t}$，自底向上路径生成${P_3^b, P_4^b, P_5^b}$，最终融合特征为：

$ P_i = alpha_i dot P_i^t + beta_i dot P_i^b $

其中$alpha_i$和$beta_i$为可学习的融合权重。

== 损失函数

本文采用多任务损失函数进行端到端训练：

$ L = L_"cls" + lambda_1 L_"reg" + lambda_2 L_"att" $

其中$L_"cls"$为分类损失（交叉熵损失），$L_"reg"$为回归损失（Smooth L1损失），$L_"att"$为注意力模块的辅助损失，$lambda_1$和$lambda_2$为平衡系数。

= 实验与分析

== 数据集与评价指标

本文在两个广泛使用的目标检测基准数据集上进行实验：

（1）PASCAL VOC：包含20个目标类别，VOC2007训练集包含5011张图像，测试集包含4952张图像。

（2）MS COCO：包含80个目标类别，训练集包含约118k张图像，验证集包含5k张图像。

评价指标采用平均精度均值（mean Average Precision, mAP），在VOC数据集上使用IoU阈值为0.5的mAP，在COCO数据集上使用标准的mAP（IoU从0.5到0.95，步长0.05）。

== 实验设置

实验在NVIDIA RTX 3090 GPU上进行，使用PyTorch 1.12框架实现。训练时采用SGD优化器，初始学习率为0.01，动量为0.9，权重衰减为0.0001。学习率采用余弦退火策略，总训练轮数为24个epoch。输入图像短边缩放至800像素，长边不超过1333像素。

数据增强策略包括：随机水平翻转（概率0.5）、随机裁剪、颜色抖动和多尺度训练。

== 主要实验结果

=== PASCAL VOC实验结果

在PASCAL VOC2007测试集上，本文方法取得了82.3%的mAP，相比基线Faster R-CNN（78.8%）提升了3.5个百分点。与其他方法的对比结果如表4.1所示。

#figure(
  table(
    columns: 4,
    table.hline(stroke: 1.5pt),
    [方法], [Backbone], [mAP/%], [FPS],
    table.hline(stroke: 0.5pt),
    [Faster R-CNN], [ResNet-50], [78.8], [15],
    [FPN], [ResNet-50], [80.1], [14],
    [本文方法], [ResNet-50], [82.3], [13],
    table.hline(stroke: 1.5pt),
  ),
  caption: [PASCAL VOC2007测试集上各方法性能对比],
  kind: table,
)

=== MS COCO实验结果

在MS COCO验证集上，本文方法取得了41.2%的AP，相比基线方法（38.4%）提升了2.8个百分点。详细结果如表4.2所示。

#figure(
  table(
    columns: 5,
    table.hline(stroke: 1.5pt),
    [方法], [AP], [AP#sub[50]], [AP#sub[75]], [AP#sub[S]],
    table.hline(stroke: 0.5pt),
    [Faster R-CNN], [38.4], [59.1], [41.5], [21.5],
    [FPN], [39.8], [61.3], [43.2], [22.9],
    [RetinaNet], [40.1], [60.5], [43.0], [23.1],
    [本文方法], [41.2], [62.8], [44.7], [24.8],
    table.hline(stroke: 1.5pt),
  ),
  caption: [MS COCO验证集上各方法性能对比（%）],
  kind: table,
)

特别是在小目标检测方面，AP#sub[S]从21.5%提升至24.8%，提升了3.3个百分点，验证了本文方法对小目标检测的改善效果。

== 消融实验

为验证各模块的有效性，本文在PASCAL VOC2007数据集上进行了消融实验。

=== 通道注意力模块的效果

在骨干网络中加入LCA模块后，mAP从78.8%提升至80.5%，提升了1.7个百分点，同时仅增加了约0.3M的参数量和0.5ms的推理时间，证明了LCA模块的轻量高效特性。

=== 双向特征融合的效果

将单向FPN替换为BMFF模块后，mAP从80.5%进一步提升至82.3%，提升了1.8个百分点。这表明双向融合策略能够更充分地利用多尺度特征信息。

== 可视化分析

通过对检测结果的可视化分析，可以观察到本文方法在以下场景中表现出明显的优势：

（1）小目标场景：得益于BMFF模块对低层空间信息的有效利用，小目标的检测召回率显著提升。

（2）遮挡场景：LCA模块能够增强目标可见部分的特征响应，提升了对部分遮挡目标的检测能力。

（3）密集场景：双向特征融合有效缓解了密集目标之间的特征混淆问题。
