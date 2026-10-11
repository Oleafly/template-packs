// =============================================
//  学术答辩模板  —  Typst + touying
//  依赖：touying v0.6.1（Typst Universe）
//  用法：
//    1) typst init
//    2) typst watch main.typ
//  备注：中文注释，按需搜索 TODO 修改
// =============================================

#import "@preview/touying:0.6.1": *
//使用university魔改成绿色基调
#import themes.stargazer: *


// （可选）常用动画/绘图生态
// #import "@preview/cetz:0.3.2"
// #import "@preview/fletcher:0.5.4" as fletcher: node, edge

// -------- 全局展示样式 --------
#show: stargazer-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [论文/标题题目TODO],
    subtitle: [副标题(可选)],
    author: [答辩人：姓名],
    date: datetime.today(),
    institution: [单位/学院/课题组],
    //添加北理工校徽
    logo: image("assets/bit-logo.svg"),
  ),
   //添加北理工专属绿色 嘻嘻
  config-colors(
        //标题和footer-c/d的颜色
        primary: rgb("#036234"),
        primary-dark: rgb("#1fab89"),
        secondary: rgb("#ffffff"),
        tertiary: rgb("#359a63"),
        neutral-lightest: rgb("#fcfff5"),
        // footer-a/b的颜色
        neutral-darkest: rgb("#00562E"),
   ),
   //
   config-common(
    
   ),
   config-page()
)

// -------- 目录编号风格（可选）--------
#import "@preview/numbly:0.1.0": numbly

// 设置无衬线字体
#set text(font: ("Noto Sans CJK SC", "Source Han Sans SC", "Microsoft YaHei", "Heiti SC", "Arial", "Liberation Sans"), lang: "zh")
#set heading(numbering: numbly("{1}.", default: "1.1"))

// ====== 开场封面 ======
#set heading(numbering: numbly("{1}.", default: "1.1"))

#title-slide()

#outline-slide()

/* = 目录 <touying:hidden>
#components.adaptive-columns(outline(title: none, indent: 1em)) */

= 使用测试1

== 微分动态规划方法
对于非线性轨迹优化问题，求解的方法分为shooting Method 和 collocation methods即直接法和间接法。

直接法通过将轨迹优化问题转化为标准的大规模非线性优化问题，利用现成的开源/商用的非线性求解器（IPOPT，mosek,yalmip...）。常见的非线性优化策略是采用基于序列二次规划的SQP方法。动力学约束推荐采用Hermite-Simpson 方法,比显示的RK4稳定性强、计算成本低。

== 优化问题基本形式
考虑离散动力学系统，目标是找到控制序列$upright(u)_(1:N-1)$，最小化总代价（通常假设代价函数和约束函数二阶可导）

$
min 
$

== DDP/iLQR的求解
- 反向传播
- 前向更新

= 使用测试2

== 问题形式化
设数据集 $D$ 与模型 $f_theta$，优化目标：

$
  min_(theta)  cal(L) (theta; D) = sum_((x,y)in D) ell (f_theta(x), y )
$

#meanwhile

#box(inset: 12pt, radius: 12pt, stroke: .5pt + gray)[
*符号表（示例）*
- $x$: 输入；$y$: 标签；$theta$: 参数
- $ell$: 损失；$cal(L)$: 经验风险
]

== 关键假设与约束
- 假设1（数据独立同分布）
- 假设2（正则化与光滑性）
- 约束（时间/内存/公平性/安全性 等）

= 方法设计

== 模型结构
#slide(
  // 单页多列排版
  composer: (1fr, 1fr),
)[
- 总体框架图（示意位）
- 流程：输入 → 特征提取 → 训练 → 推理
- 亮点：模块化/鲁棒性/可解释性
][
- 关键模块A：算法/结构要点
- 关键模块B：训练策略/优化器
- 复杂度：时间 $cal{O}(dot)$ / 空间 $cal{O}(dot)$
]

== 逐步动画讲解（示例）
1. 基础思路#pause  → 2. 细化步骤#pause  → 3. 边界情况#pause  → 4. 小结

== 数学推导（动画示例）
$
  a = b
$
#meanwhile
- 先展示目标函数，再揭示正则项作用

= 实验与结果

== 设置与协议
- 数据集：名称/规模/划分
- 评价指标：Acc / F1 / mAP / RMSE / 收敛时间
- 训练细节：GPU/批大小/学习率/epoch

== 主结果
#slide(
  composer: (2fr, 1fr),
)[
- *表格/图像/曲线*（贴图或使用绘图库）
- 与SOTA基线对比，突出相对提升（%）
][
- 观察1：在哪些场景更优
- 观察2：失败案例与误差分析
]


= 工程实现

== 系统与演示
- 架构：前端/后端/数据流
- 部署：容器化/推理服务/监控
- 演示：链接/二维码（TODO）

= 结论与展望

== 结论
- 回答研究问题，量化收益
- 局限性：数据规模/泛化/偏差

== 展望
- 更大模型/更广数据/跨域迁移
- 与工业场景结合/产品化

= 附录

== 备份页（常见问答）
- Q1：……
- Q2：……
- Q3：……

// ====== 讲者备注示例（投影第二屏显示） ======
#speaker-note[
+ 这是讲者备注，只在第二屏显示
+ 可在 config-common 中开启 show-notes-on-second-screen
]

// ====== 自定义小工具（按需启用） ======
// 统一信息卡片
#let info-card(body) = box(inset: 12pt, radius: 14pt, stroke: 0.6pt + gray)[body]

// 两栏要点
#let two-col(left, right) = slide(
  composer: (1fr, 1fr),
)[ left ][ right ]

// 动画短语备忘
// - #pause          // 逐步出现
// - #meanwhile      // 同步出现另一块
// - #only("2-")     // 只在第2子页后显示
// - #uncover("-2")  // 直到第2子页都占位保留

// ====== 封底页 ======
= 致谢

== Thanks!
- 感谢评委与同学聆听
- 联系方式：email\@domain.com / GitHub / 主页
