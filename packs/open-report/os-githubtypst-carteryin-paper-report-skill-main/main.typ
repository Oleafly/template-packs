#import "@preview/typslides:1.3.2": *

#show: typslides.with(
  ratio: "16-9",
  theme: "bluey",
  font: "Fira Sans",
  font-size: 20pt,
  link-style: "color",
  show-progress: true,
)

// ============================================================================
// Front Slide
// ============================================================================
#front-slide(
  title: "TTRV",
  subtitle: [Test-Time Reinforcement Learning for Vision Language Models],
  authors: "Akshit Singh, Shyam Marjit, Wei Lin, Paul Gavrikov, Serena Yeung-Levy et al.",
  info: [#link("https://arxiv.org/abs/2510.06783") — arXiv:2510.06783],
)

#table-of-contents()

// ============================================================================
// Section 1: 研究动机
// ============================================================================
#title-slide[研究动机: TTA 为何在 VLM 上失效]

#slide(title: "三大架构障碍", outlined: true)[
  *障碍 1 — 架构不兼容*
  - TENT、DDU、Norm 等传统 TTA 方法依赖 Batch Normalization 统计量
  - 现代 VLM (LLaVA, InstructBLIP, InternVL, Qwen-VL) 全部使用 LayerNorm 或 RMS Norm
  - BN 的 running mean / variance 在这些架构中不存在 → TENT-style 方法直接失效

  *障碍 2 — 目标函数不匹配*
  - 自回归 VLM 输出 token 级条件分布 $p(y_t | x, y_(<t))$
  - TENT 的熵最小化假设"分类头输出的类别概率向量"
  - 论文 Table 3 证实: TENT-style 熵最小化 (TTRV w/o Freq.) 在部分 VQA 数据集上提升微弱 (AI2D +1.11, Mathverse +0.31)

  *障碍 3 — 双编码器到自回归的鸿沟*
  - TPT、DiffTPT 为 CLIP 类双编码器设计，通过文本 prompt 空间调优
  - 自回归 VLM 的 visual projection 与 LLM 联合机制完全不同

  #stress[核心命题]: 强化学习的本质是"从经验中学习"——为何不直接从与无标签测试数据的交互中获取奖励信号？
]

// ============================================================================
// Section 2: 核心方法
// ============================================================================
#title-slide[核心方法: 无监督 Test-Time RL]

#slide(title: "方法总览: 四步流程", outlined: true)[
  对每个无标签测试样本 $x$，重复以下步骤直到收敛 ($K approx 20$):

  *Step 1 — 采样构建经验分布*
  从当前策略 $pi_theta$ 对同一输入 $x$ 采样 $N=32$ 个独立响应 (temperature = 1.0):
  $ hat(y)_1, hat(y)_2, ..., hat(y)_N ~ pi_theta(dot | x) $

  *Step 2 — 统计频率并分配奖励*
  统计去重后唯一响应 $tilde(y)_1, ..., tilde(y)_M$ ($M <= N$)。
  经验分布: $p(tilde(y)_m | x) = 1/N sum_(j=1)^N bold(1)[hat(y)_j = tilde(y)_m]$
  频率奖励: $r_1(hat(y)_j) = p(hat(y)_j | x)$ ← 核心信号，无标签、无外部监督

  *Step 3 — 低熵正则化防止坍缩*
  香农熵: $H = -sum_(m=1)^M p(tilde(y)_m) log p(tilde(y)_m)$，辅助奖励 $r_2 = -H$
  组合: $R(hat(y)_j) = r_1(hat(y)_j) + alpha dot r_2$，默认 $alpha = 0.75$

  *Step 4 — GRPO 组内相对优势更新*
  组内归一化: $A_j = (R_j - mu_R) / sigma_R$
  策略梯度: $theta <- theta + eta dot 1/N sum_(j=1)^N A_j nabla_theta log pi_theta(hat(y)_j | x)$
]

#slide(title: "奖励设计的核心逻辑", outlined: true)[
  *为什么频率奖励有效？—— 贝叶斯视角*

  频率 $p(hat(y)_j | x)$ 是模型对该响应置信度的蒙特卡洛估计:
  - 高频率 = 模型在多轮采样中一致选择的答案 → 模型"自己相信"它 → 高奖励
  - 低频率 = 模型偶尔采到的答案 → 不确定性高 → 低奖励

  *与多数投票的本质区别*
  - 多数投票: $hat(y)^* = (a r g m a x)_m p(tilde(y)_m)$，硬选择，丢弃不确定信息
  - TTRV: 保留完整分布 $p(tilde(y)_m)$，作为连续奖励信号
  - 论文 Table 3: 多数投票在 Mathverse (-0.94) 和 AI2D (-4.03) 上 *低于基线*

  *为什么需要低熵正则化?*
  - 纯粹最大化频率 → 模型可能坍缩到单一响应
  - Table 3: TTRV (w/o Diversity) 在 CRPE (-0.80) 和 MathVista (-0.41) 退化

  *为什么用 GRPO 组内优势而非绝对奖励?*
  - 组内标准化消除奖励尺度影响，无需价值网络 (vs PPO)
  - GRPO 的 KL 正则化防止偏离参考策略过远，保护预训练知识
]

// ============================================================================
// Section 3: 实验设置
// ============================================================================
#title-slide[实验设置与数据集]

#slide(title: "16 个基准: 目标识别 + VQA", outlined: true)[
  #text(size: 17pt)[
    *8 个目标识别数据集 (Table 1)*
    - ImageNet, ImageNet-V2 — 通用目标识别及分布外变体
    - ImageNet-R (Rendition), ImageNet-S (Sketch), ImageNet-A (Adversarial) — 纹理/素描/对抗偏移
    - Food101 (细粒度食物), DTD (纹理描述) — 细粒度分类
    - Resisc45 — 遥感卫星图像场景分类

    *8 个 VQA 数据集 (Table 2)*
    - Mathverse, MathVista — 数学推理
    - SEED, MME — 通用多模态理解
    - RealWorldQA — 真实世界场景问答
    - Capture — 遮挡物体计数 (空间推理)
    - CRPE — 组合关系推理与幻觉评估
    - AI2D — 图表/流程图理解

    数据集覆盖自然图像、细粒度、遥感、数学推理、常识、组合性和图表理解。
  ]

  #text(size: 14pt)[
    *基座模型:* InternVL3-2B, InternVL2.5-4B, InternVL3-8B
    *对比方法:* GPT-4o, CLIP, MetaCLIP, EVACLIP, SigLIP, LLaMA-3.2-11B, LLaVA-1.5-7B, Phi-3.5-vision
    *训练配置:* AdamW + Cosine LR, 峰值学习率 5×10⁻⁷, N=32, α=0.75, 每数据集 20 个无标签样本
  ]
]

// ============================================================================
// Section 4: 主要结果
// ============================================================================
#title-slide[主要实验结果]

#slide(title: "目标识别 — InternVL + TTRV 全面提升 (Table 1)", outlined: true)[
  #text(size: 11pt)[
    #table(
      columns: (auto, auto, auto, auto, auto, auto, auto, auto, auto, auto),
      inset: 4pt,
      stroke: 0.5pt + gray,
      [*模型*], [*ImageNet*], [*IN-V2*], [*IN-R*], [*IN-S*], [*IN-A*], [*Food101*], [*DTD*], [*Resisc45*], [*均值*],
      [GPT-4o], [98.30], [95.10], [91.70], [91.20], [90.60], [95.60], [92.30], [92.13], [93.37],
      table.hline(),
      [InternVL3-2B], [56.00], [67.43], [66.01], [62.19], [67.92], [67.19], [37.24], [72.28], [62.03],
      [#stress[+ TTRV]], [#stress[98.31]], [#stress[98.25]], [#stress[96.89]], [#stress[94.74]], [#stress[96.31]], [#stress[95.60]], [#stress[89.73]], [#stress[90.06]], [#stress[94.99]],
      [$Delta$], [+42.31], [+30.82], [+30.88], [+32.55], [+28.39], [+28.41], [+52.49], [+17.78], [+32.95],
      table.hline(),
      [InternVL2.5-4B], [93.26], [83.07], [79.53], [65.51], [90.67], [80.92], [47.33], [23.44], [70.47],
      [#stress[+ TTRV]], [#stress[97.11]], [#stress[95.66]], [#stress[88.21]], [#stress[92.01]], [#stress[96.00]], [#stress[94.49]], [#stress[81.98]], [13.30], [#stress[82.34]],
      [$Delta$], [+3.85], [+12.59], [+8.68], [+26.50], [+5.33], [+13.57], [+34.65], [-10.14], [+11.88],
      table.hline(),
      [InternVL3-8B], [79.47], [62.58], [59.32], [54.48], [57.03], [78.32], [59.11], [83.62], [66.74],
      [#stress[+ TTRV]], [#stress[99.31]], [#stress[97.24]], [#stress[96.88]], [#stress[95.03]], [#stress[96.86]], [#stress[97.20]], [#stress[89.37]], [#stress[93.82]], [#stress[95.71]],
      [$Delta$], [+19.84], [+34.66], [+37.56], [+40.55], [+39.83], [+18.88], [+30.26], [+10.20], [+28.97],
    )
  ]

  #text(size: 15pt)[
    - #stress[InternVL3-8B + TTRV 均值 95.71% > GPT-4o 93.37%]，开源 8B 模型超越闭源商用模型
    - InternVL3-2B 平均 +32.95%，DTD 单数据集 +52.49% — 小模型"能力恢复"效应最强
    - Resisc45 上 InternVL2.5-4B 退化 (-10.14%)，论文归因于基座过低 (23.44%)
  ]
]

#slide(title: "VQA — InternVL + TTRV 一致提升 (Table 2)", outlined: true)[
  #text(size: 11pt)[
    #table(
      columns: (auto, auto, auto, auto, auto, auto, auto, auto, auto, auto),
      inset: 4pt,
      stroke: 0.5pt + gray,
      [*模型*], [*Mathverse*], [*MathVista*], [*SEED*], [*MME*], [*RealWorldQA*], [*Capture*], [*CRPE*], [*AI2D*], [*均值*],
      [GPT-4o], [54.40], [63.80], [69.80], [89.75], [75.40], [85.25], [76.60], [84.60], [71.97],
      table.hline(),
      [InternVL3-2B], [44.10], [58.26], [24.99], [17.04], [63.47], [60.27], [71.92], [39.68], [47.47],
      [#stress[+ TTRV]], [#stress[48.51]], [#stress[66.11]], [#stress[48.85]], [11.06], [#stress[64.29]], [#stress[78.64]], [#stress[72.00]], [#stress[67.75]], [#stress[57.15]],
      [$Delta$], [+4.41], [+7.85], [+23.86], [-5.98], [+0.82], [+18.37], [+0.08], [+28.07], [+9.69],
      table.hline(),
      [InternVL2.5-4B], [51.69], [65.49], [57.37], [85.27], [65.25], [80.03], [74.33], [51.55], [66.37],
      [#stress[+ TTRV]], [#stress[53.02]], [#stress[66.94]], [#stress[61.14]], [#stress[85.79]], [#stress[66.00]], [#stress[85.99]], [#stress[75.22]], [#stress[61.09]], [#stress[69.40]],
      [$Delta$], [+1.33], [+1.45], [+3.77], [+0.52], [+0.75], [+5.96], [+0.89], [+9.54], [+3.03],
      table.hline(),
      [InternVL3-8B], [34.56], [38.84], [32.12], [49.02], [19.01], [59.50], [55.81], [30.95], [38.05],
      [#stress[+ TTRV]], [#stress[42.15]], [#stress[50.41]], [#stress[59.16]], [#stress[78.77]], [#stress[26.57]], [#stress[80.68]], [#stress[68.26]], [#stress[53.92]], [#stress[55.56]],
      [$Delta$], [+7.59], [+11.57], [+27.04], [+29.75], [+7.56], [+21.18], [+12.45], [+22.97], [+17.50],
    )
  ]

  #text(size: 15pt)[
    - VQA 上 3 个模型规模一致提升。InternVL3-8B + TTRV 在 MME (+29.75%) 和 SEED (+27.04%) 提升最大
    - 识别任务 (avg +24.6%) > VQA (avg +10.0%): TTRV 主要增强视觉感知能力
    - VQA 上 InternVL3-8B + TTRV (55.56%) 与 GPT-4o (71.97%) 仍有 ~16% 差距
  ]
]

// ============================================================================
// Section 5: 消融实验
// ============================================================================
#title-slide[消融实验]

#slide(title: "奖励设计消融 — 频率 + 多样性组合最优 (Table 3)", outlined: true)[
  *InternVL2.5-4B 在 5 个 VQA 数据集上的奖励组件拆解*

  #text(size: 14pt)[
    #table(
      columns: (auto, auto, auto, auto, auto, auto),
      inset: 5pt,
      stroke: 0.5pt + gray,
      [*配置*], [*MathVista*], [*SEED*], [*AI2D*], [*Mathverse*], [*CRPE*],
      [基线 (无适配)], [65.49], [57.37], [51.55], [51.69], [74.33],
      [多数投票 (TTRL-style)], [65.08], [58.37], [47.52], [50.75], [71.60],
      [$Delta$ vs 基线], [-0.41], [+1.00], [-4.03], [-0.94], [-2.73],
      table.hline(),
      [TTRV w/o Freq. (= TENT)], [66.81], [58.87], [52.66], [52.00], [74.54],
      [$Delta$ vs 基线], [+1.32], [+1.50], [+1.11], [+0.31], [+0.21],
      table.hline(),
      [TTRV w/o Diversity], [65.08], [59.27], [53.06], [51.74], [73.53],
      [$Delta$ vs 基线], [-0.41], [+1.90], [+1.51], [+0.05], [-0.80],
      table.hline(),
      [#stress[TTRV (Freq. + Diversity)]], [#stress[66.94]], [#stress[61.14]], [#stress[61.09]], [#stress[53.02]], [#stress[75.22]],
      [#stress[$Delta$]], [#stress[+1.45]], [#stress[+3.77]], [#stress[+9.54]], [#stress[+1.33]], [#stress[+0.89]],
    )
  ]

  #text(size: 16pt)[
    - 多数投票在 3/5 数据集上 *低于基线* (AI2D -4.03 最严重)，验证硬性伪标签的风险
    - 仅频率 (w/o Diversity) 在 CRPE (-0.80) 和 MathVista (-0.41) 退化
    - 仅低熵 (w/o Freq.) = TENT-style: 提升微弱 (+0.21–1.50%)
    - #stress[频率 + 多样性组合在所有 5 个数据集上一致正向]
  ]
]

#slide(title: "数据采样、随机奖励与单样本适配 (Table 4–6)", outlined: true)[
  *偏置 vs 随机采样 (Table 4, InternVL2.5-4B) — 偏置采样几乎等同随机*

  #text(size: 16pt)[
    #table(
      columns: (auto, auto, auto),
      inset: 6pt,
      stroke: 0.5pt + gray,
      [*采样方式*], [*ImageNet-A*], [*ImageNet-R*],
      [基线], [90.67], [79.53],
      [偏置 (仅 4/200 类)], [95.09 (+4.42)], [88.51 (+8.98)],
      [随机 (全类别)], [96.00 (+5.33)], [88.21 (+8.68)],
    )
  ]

  #v(0.4cm)

  *随机奖励 vs TTRV (Table 5, InternVL2.5-4B)*
  #text(size: 16pt)[
    #table(
      columns: (auto, auto, auto),
      inset: 6pt,
      stroke: 0.5pt + gray,
      [*配置*], [*SEED*], [*ImageNet-R*],
      [基线], [57.37], [79.53],
      [随机奖励], [52.41 (-4.96)], [78.00 (-1.53)],
      [TTRV], [#stress[61.14 (+3.77)]], [#stress[88.21 (+8.68)]],
    )
  ]

  #v(0.4cm)

  *单样本 TTRV (Table 6, InternVL2.5-4B)*
  #text(size: 16pt)[
    #table(
      columns: (auto, auto, auto, auto, auto),
      inset: 5pt,
      stroke: 0.5pt + gray,
      [*配置*], [*MathVista*], [*SEED*], [*ImageNet-A*], [*ImageNet-R*],
      [基线], [65.49], [57.37], [90.67], [79.53],
      [单样本 TTRV], [66.11], [58.87], [95.28], [85.00],
      [$Delta$], [+0.62], [+1.50], [+4.61], [+5.47],
    )
  ]
]

#slide(title: "跨模型与跨数据集泛化 (Table 7, Fig 3)", outlined: true)[
  *跨模型泛化 — Qwen2.5-VL-3B (Table 7)*

  #text(size: 16pt)[
    #table(
      columns: (auto, auto, auto, auto, auto),
      inset: 5pt,
      stroke: 0.5pt + gray,
      [*配置*], [*Mathverse*], [*MathVista*], [*Capture*], [*Resisc45*],
      [Qwen2.5-VL-3B], [45.33], [67.35], [71.33], [90.08],
      [#stress[+ TTRV]], [#stress[48.71]], [#stress[71.48]], [#stress[75.25]], [#stress[92.71]],
      [$Delta$], [+3.38], [+4.13], [+3.92], [+2.63],
    )
  ]

  #v(0.3cm)

  *跨数据集泛化 (Fig 3, InternVL3-2B)* — 在一个数据集上训练，在完全不同的数据集上测试:
  #text(size: 16pt)[
    #table(
      columns: (auto, auto, auto, auto, auto),
      inset: 5pt,
      stroke: 0.5pt + gray,
      [*训练集 → 测试集*], [*Food101 → DTD*], [*DTD → Food101*], [*Resisc45 → DTD*], [*DTD → Resisc45*],
      [$Delta$], [+52.03], [+26.68], [+52.33], [+18.83],
    )
  ]

  #v(0.3cm)
  #text(size: 16pt)[
    - TTRV 在完全不同的模型架构 (QwenVL) 上同样有效 → 方法架构无关
    - 跨数据集泛化提升巨大: 在 Food101 上适配竟能提升 DTD 性能 52% → 强证据支持"能力恢复"假说
  ]
]

// ============================================================================
// Section 6: 关键发现
// ============================================================================
#title-slide[关键发现]

#slide(title: "发现 1: InternVL3-8B 超越 GPT-4o", outlined: true)[
  *目标识别均值: InternVL3-8B + TTRV 95.71% > GPT-4o 93.37% (+2.34%)*

  GPT-4o 在 8 个识别数据集上的表现 vs InternVL3-8B + TTRV:
  #text(size: 15pt)[
    #table(
      columns: (auto, auto, auto, auto, auto, auto, auto, auto, auto),
      inset: 5pt,
      stroke: 0.5pt + gray,
      [*数据集*], [*ImageNet*], [*IN-V2*], [*IN-R*], [*IN-S*], [*IN-A*], [*Food101*], [*DTD*], [*Resisc45*],
      [GPT-4o], [98.30], [95.10], [91.70], [91.20], [90.60], [95.60], [92.30], [92.13],
      [InternVL3-8B + TTRV], [#stress[99.31]], [#stress[97.24]], [#stress[96.88]], [#stress[95.03]], [#stress[96.86]], [#stress[97.20]], [89.37], [#stress[93.82]],
      [$Delta$ vs GPT-4o], [+1.01], [+2.14], [+5.18], [+3.83], [+6.26], [+1.60], [-2.93], [+1.69],
    )
  ]

  - 7/8 数据集超越 GPT-4o (仅 DTD 落后 2.93%)
  - ImageNet-A (+6.26 vs GPT-4o): 对抗性分布外偏移最显著
  - 8B 开源模型通过测试时 RL 适配，不增加参数、不改变架构，即可超越最强闭源模型
]

#slide(title: "发现 2: 能力恢复假说", outlined: true)[
  *核心假说: TTRV 的提升不是来自对测试分布的统计适配，而是恢复预训练中习得、被指令微调削弱的视觉能力*

  *多条实验证据:*
  - 仅用 1 个随机测试样本 → ImageNet-R +5.47%, ImageNet-A +4.61% (Table 6)
  - 偏置采样 (仅 4/200 类) 与随机采样的提升几乎相同 (Table 4)
  - 跨数据集泛化: Food101 → DTD +52.03% (Fig 3)
  - 小模型 (InternVL3-2B: +32.95%) 的提升远大于大模型 (InternVL3-8B: +28.97%)
  - 随机奖励对照组性能 *下降* (Table 5)

  *理论解释 (论文假设):*
  - 预训练 next-token prediction 与 RL 输出空间优化目标形式上一致
  - 指令微调 (SFT) 可能系统性削弱了视觉识别能力
  - TTRV 的 RL 更新将模型移向更接近预训练状态的参数空间区域

  #stress[反思: 指令微调是否牺牲了预训练获得的某些能力？测试时 RL 能否系统性地修复？]
]

#slide(title: "局限性", outlined: true)[
  *1. 计算开销*
  - 20 样本适配: ~4 分钟 vs 正常推理 ~25 秒 — 实时应用不适用
  - 500 样本适配: ~2 小时，实用性有限

  *2. 低基线退化风险*
  - Resisc45 上 InternVL2.5-4B 基线仅 23.44% → TTRV 后降至 13.30% (-10.14%)
  - 基座过低 → 采样质量差 → GRPO 不稳定

  *3. VQA 提升有限*
  - 识别 avg +24.6%，VQA avg +10.0% → 频率奖励对复杂推理任务信噪比低
  - 与 GPT-4o 在 VQA 上仍有 ~16% 差距

  *4. 理论空白*
  - "能力恢复"假说缺乏严格理论证明
  - 未探索与 Chain-of-Thought 的交互、视频/文档等长序列任务
]

// ============================================================================
// Section 7: 总结
// ============================================================================
#title-slide[总结与展望]

#slide(title: "TTRV 的核心贡献", outlined: true)[
  *1. 首个 VLM 测试时强化学习框架*
  - 奖励信号完全来自模型自身的输出一致性，无需任何标签
  - 将 GRPO 从有监督后训练扩展到无监督测试时在线适配

  *2. 频率 + 多样性组合奖励设计*
  - 频率奖励: 模型多次采样一致性作为置信度的蒙特卡洛估计
  - 多样性控制: 熵正则化防止模式坍缩
  - 实证组合显著优于多数投票和纯熵最小化

  *3. 8B 开源模型超越 GPT-4o*
  - InternVL3-8B + TTRV 目标识别均值 95.71% > GPT-4o 93.37%
  - 测试时计算可以有效弥补模型规模差距

  *4. "能力恢复"实证*
  - 单样本、偏置采样、跨数据集实验共同指向: TTRV 提升的是底层视觉能力
  - 对当前"预训练 → SFT → RLHF"范式提出有价值的反思
]

#focus-slide[
  谢谢
  #text(size: 20pt)[Paper: arxiv.org/abs/2510.06783]
]
