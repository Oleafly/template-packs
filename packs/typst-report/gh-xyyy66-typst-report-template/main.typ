#import "template.typ": project

#let abstract_style(body) = {
  align(center, text(weight: "bold",size:13pt)[#smallcaps("Abstract")])
  pad(x: 2em)[
    #set par(justify: true, first-line-indent: 2pt)
    #body
  ]
  v(1em)
}
#let code_block(lang: "cc", body) = {
  v(0.5em)
  block(
    width: 100%,
    fill: rgb("#f8f9fa"),     
    stroke: 0.5pt + rgb("#e0e0e0"), 
    radius: 4pt,             
    inset: 0pt,             
    clip: true,
  )[
    #block(
      width: 100%,
      fill: rgb("#eeeeee"),
      inset: (x: 8pt, y: 4pt),
    )[
      #set text(size: 8pt, fill: gray.darken(30%), font: "Maple Mono NF")
      #upper(lang) 
    ]
    // code main body
    #pad(x: 12pt, y: 2pt)[
      #show raw: set text(
        font: ("JetBrains Mono", "JetBrainsMono NF"), 
        size: 10pt,
        ligatures: true 
      )
      #body
    ]
  ]
  v(0.5em)
}


#show: project.with(
  title: "计算方法实验报告 ",
  authors: (
    (name: "ideal", 
    email: "yxu422325@gmail.com", 
    affiliation: "Beijing Normal University", 
    phone: "166-6666-6666"),
  ),
  abstract: "本文档为计算方法课程的第一次作业的实验报告，主要探讨了计算机浮点数运算中常见的两种舍入误差现象及其对算法数值稳定性的影响。针对问题一，本文分析了当自变量趋于极限情况时，相近数相减引发的“灾难性抵消”与有效数字丢失问题，并推导了等价的解析表达式以重构算法，显著提升了双精度环境下的计算精度。针对问题二，本文在单精度浮点数环境下，通过对比级数在升序与降序两种累加顺序下的结果，验证并剖析了计算机加法对阶机制引发的“大数吃小数”截断现象。实验数据与理论误差分析高度吻合，结果表明，在包含大量数量级差异显著的数值累加操作中，采用绝对值升序求和能有效避免累积误差，从而最大程度逼近机器精度的理论上限。本报告详细记录了实验过程、代码实现以及最终的计算结果."
)
// #v(1fr)
// #abstract_style[#lorem(20)]
// #v(1fr)
#pagebreak()


#set page(numbering: "1", number-align: center, margin: auto)
#counter(page).update(1)
= 问题一

== 问题重述与分析
#v(0.3cm)
在计算机中，实数采用 IEEE 754 标准的双精度浮点数进行存储和计算，其尾数部分只能保留约 15 到 17 位十进制有效数字. 本问题的核心在于相近数相减造成的灾难性抵消.

对于给定的两个函数

$bullet$ $f_1(x) = (1 - sec x) / (tan^(2)x)$

当 $x -> 0$ 时，$sec x -> 1$. 分子 $1 - sec x$ 会出现两个极其接近的数相减. 此时，浮点数表示中前面大部分相同的有效数字会被减掉，只留下末尾几位由于舍入产生的“噪声”数字. 由于分母 $tan^2 x$ 也是一个极小数，这个噪声会被进一步放大，导致最终结果完全失真.

$bullet$ $f_2(x) = (1 - (1 - x)^2) / x$

同理，当 $x -> 0$ 时，$(1 - x)^2 -> 1$.分子部分 $1 - (1 - x)^2$ 同样发生了严重的相近数相减，导致有效数字急剧丢失.

为了保证计算的数值稳定性，必须通过数学变换消除这种相近数直接相减的结构：

对于 $f_1(x)$，通过三角恒等变换进行化简：

$ f_1(x) &= (1 - 1/(cos x)) / ((sin^2 x) / (cos^2 x)) )\
  &= ((cos x - 1) / (cos x)) /( (sin^2 x) / (cos^2 x)) \
  &= (cos x (cos x - 1)) / (sin^2 x) $

由于 $sin^2 x = 1 - cos^2 x = (1 - cos x)(1 + cos x)$，代入上式得：

$ g_1(x) &= -(cos x (cos x - 1)) / ((cos x - 1)(cos x + 1)) \
  &= -(cos x) / (1 + cos x) $

在新表达式 $g_1(x)$ 中，当 $x -> 0$ 时，分母变为 $1 + cos x -> 2$，完全避免了减法带来的抵消问题.

对于 $f_2(x)$，直接将分子展开：

$ g_2(x) &= (1 - (1 - 2x + x^2)) / x \
  &= (2x - x^2) / x \
  &= 2 - x $

同样，新表达式 $g_2(x)$ 避免了 $x -> 0$ 时的相近数相减，数值计算绝对稳定.

== 算法
// #set enum(numbering: "I.1.a)")
#v(0.3cm)
本实验的计算流程如下：

+ *初始化循环控制*：设定循环变量 $i$ 从 1 遍历至 14.

+ *生成自变量*：对于每个 $i$，计算当前测试点 $x = 10^(-i)$.

+ *计算不稳定值*：将 $x$ 代入原公式计算 $f_1(x) = (1 - sec x) / (tan^2 x)$ 与 $f_2(x) = (1 - (1 - x)^2) / x$.

+ *计算真值*：利用化简后的等价公式 $g_1(x) = -(cos x) / (1 + cos x)$ 与 $g_2(x) = 2 - x$ 进行计算，将得到的结果作为后续误差分析的标准参照.

+ *计算有效数字位数*：

  - 设近似值为 $f(x)$，真值为 $g(x)$.

  - 计算绝对误差 $E_a = |f(x) - g(x)|$.

  - 寻找满足 $E_a <= 0.5 times 10^(m-n)$ 的最大整数 $n$（其中 $m$ 是 $g(x)$ 绝对值首位有效数字所在的十进制量级.

直接根据有效数字的定义来求解有效数字的个数不便于编程, 我们对其做等价变形来求解有效数字个数.

对于有效数字位数 $n$ 的计算，首先处理边界条件：若真值 $g(x) = 0$ 则无讨论意义，定义有效位数为 0；若绝对误差 $E_a = 0$，说明无截断与舍入误差，直接赋予双精度浮点数的最大精度 $n = 16$.

在一般情况下，设真值 $g(x)$ 的浮点规范化形式最高位处于第 $m-1$ 个十进制数量级（即 $|g(x)| in [10^(m-1), 10^m)$, $m$ 可通过取对数与向下取整得到：
$ m = floor(log_10 |g(x)|) + 1 $

根据有效数字的严格数学定义，若近似值 $f(x)$ 具有 $n$ 位有效数字，其绝对误差必须满足半个末位单位的限值，即 $E_a <= 1/2 times 10^(m-n)$.为求解最大满足条件的整数 $n$，对该不等式两边同乘 2 并取以 10 为底的对数，可得 $log_10 (2 E_a) <= m - n$.移项并取满足不等式的最大整数解，即可得到 $n$ 的解析公式：
$ n = floor(m - log_10 (2 E_a)) $

最后，考虑到 IEEE 754 双精度浮点数（`double`）的尾数位宽为 52 bit，其对应的十进制有效数字理论上限约为 $16$ 位.为防止数据溢出或异常，最终通过下式将结果严格映射至 $[0, 16]$ 区间：
$ n = max(0, min(n, 16)) $
== 结果
#v(0.3cm)
将数据整理后，整理在以下两个表格中：

#figure(
  table(
    columns: (auto, auto, auto, auto),
    align: (center, center, center, center),
    stroke: none,
    
    table.hline(y: 0),
    table.header(
      [ $x$ ], [ $f_1(x)$ ], [ $g_1(x)$ ], [ $n$ ]
    ),
    table.hline(y: 1, stroke: 0.5pt),
    
    $10^(-1)$,  `-4.9874825310928230e-01`, `-4.9874825310928220e-01`, [13],
    $10^(-2)$,  `-4.9998749984360670e-01`, `-4.9998749984373440e-01`, [11],
    $10^(-3)$,  `-5.0000001099195980e-01`, `-4.9999987499998440e-01`, [10],
    $10^(-4)$,  `-4.9999990425785020e-01`, `-4.9999999875000000e-01`, [7],
    $10^(-5)$,  `-5.0000004077699310e-01`, `-4.9999999998750000e-01`, [7],
    $10^(-6)$,  `-5.0004445029117050e-01`, `-4.9999999999987500e-01`, [4],
    $10^(-7)$,  `-5.1070259132757200e-01`, `-4.9999999999999880e-01`, [1],
    $10^(-8)$,  ` 0.0000000000000000e+00`, `-5.0000000000000000e-01`, [0],
    $10^(-9)$,  ` 0.0000000000000000e+00`, `-5.0000000000000000e-01`, [0],
    $10^(-10)$, ` 0.0000000000000000e+00`, `-5.0000000000000000e-01`, [0],
    $10^(-11)$, ` 0.0000000000000000e+00`, `-5.0000000000000000e-01`, [0],
    $10^(-12)$, ` 0.0000000000000000e+00`, `-5.0000000000000000e-01`, [0],
    $10^(-13)$, ` 0.0000000000000000e+00`, `-5.0000000000000000e-01`, [0],
    $10^(-14)$, ` 0.0000000000000000e+00`, `-5.0000000000000000e-01`, [0],
    
    table.hline()
  ),
  caption: [第一组公式计算结果对比 ($f_1(x)$)]
)

#v(1em)

#figure(
  table(
    columns: (auto, auto, auto, auto),
    align: (center, center, center, center),
    stroke: none,
    
    table.hline(y: 0),
    table.header(
      [ $x$ ], [ $f_2(x)$ ], [ $g_2(x)$ ], [ $n$ ]
    ),
    table.hline(y: 1, stroke: 0.5pt),
    
    $10^(-1)$,  ` 1.9000000000000000e+00`, ` 1.9000000000000000e+00`, [16],
    $10^(-2)$,  ` 1.9900000000000000e+00`, ` 1.9900000000000000e+00`, [15],
    $10^(-3)$,  ` 1.9990000000000000e+00`, ` 1.9990000000000000e+00`, [14],
    $10^(-4)$,  ` 1.9999000000000000e+00`, ` 1.9999000000000000e+00`, [12],
    $10^(-5)$,  ` 1.9999900000001850e+00`, ` 1.9999900000000000e+00`, [11],
    $10^(-6)$,  ` 1.9999989999710770e+00`, ` 1.9999990000000000e+00`, [10],
    $10^(-7)$,  ` 2.0000000000559530e+00`, ` 1.9999999000000000e+00`, [9],
    $10^(-8)$,  ` 1.9999999878450580e+00`, ` 1.9999999900000000e+00`, [8],
    $10^(-9)$,  ` 2.0000000233721950e+00`, ` 1.9999999990000000e+00`, [7],
    $10^(-10)$, ` 2.0000001654807420e+00`, ` 1.9999999999000000e+00`, [7],
    $10^(-11)$, ` 2.0000001654807420e+00`, ` 1.9999999999900000e+00`, [7],
    $10^(-12)$, ` 1.9999557452660520e+00`, ` 1.9999999999990000e+00`, [5],
    $10^(-13)$, ` 2.0006219463428860e+00`, ` 1.9999999999999000e+00`, [3],
    $10^(-14)$, ` 1.9984014443252820e+00`, ` 1.9999999999999900e+00`, [3],
    
    table.hline()
  ),
  caption: [第二组公式计算结果对比 ($f_2(x)$)]
)

== 结果分析与讨论
#v(0.3cm)
以上两表直观地展示了随着 $x$ 趋于 $0$，两种计算方式在数值稳定性上的巨大差异：

+ $f_1(x) = (1 - sec x) / (tan^(2)x)$ 

  - 观察表1可以发现，当 $x >= 10^(-7)$ 时，不稳定公式 $f_1(x)$ 已经开始出现明显的精度丢失.而当 $x = 10^(-8)$ 时，有效数字位数减少为 $0$，计算结果完全失真，输出为 $0$ .\
  
  - 根据泰勒展开，$sec x approx 1 + x^2 / 2$.当 $x = 10^(-8)$ 时，$x^2 / 2 = 0.5 times 10^(-16)$.在 IEEE 754 双精度浮点数标准下，机器精度 $epsilon approx 2.22 times 10^(-16)$.此时 $0.5 times 10^(-16) < epsilon / 2$，导致 $sec(10^(-8))$ 在浮点数加法中被完全舍入为 $1.0$.因此，分子 $1 - sec x$ 变为了 $0$，发生了相似相减抵消.等价变换后的 $g_1(x)$，由于分母变成了加法 $1 + cos x$，从而避开了这一陷阱，实现了高精度计算.

+  $f_2(x) = (1 - (1 - x)^2) / x$

  - 表2中 $f_2(x)$ 的精度丢失呈现出渐进式的特征.当 $x$ 缩小至 $10^(-6)$ 以后，不稳定的计算方法计算出的尾数开始出现明显的“伪随机噪声”（如 $x=10^(-13)$ 时本应接近 $2.0$，却算出了 $2.00062...$）.\
  - 在 $x$ 较小时，分子 $1 - (1-x)^2$ 发生了严重的相近数相减，原本高位的有效数字被完全抵消，留下的极少量有效位被分母 $x$ 除以之后，舍入误差被成倍放大. 化简后的 $g_2(x) = 2 - x$ 仅涉及一次无相近数相减的运算，有效数字位数完全取决于 $x$ 自身的精度，因此计算结果较为精确.


= 问题二

== 问题重述与分析
#v(0.3cm)
本题要求在单精度浮点数环境下，分别编写通用程序以两种不同的累加顺序计算级数和：

- 降序（从大到小)：从 $j=2$ 开始累加至 $N$，即计算 
  $ S_N = 1/(2^2-1) + 1/(3^2-1) + dots + 1/(N^2-1) $
- 升序（从小到大）：从 $j=N$ 开始递减累加至 $2$，即计算 
  $ S_N = 1/(N^2-1) + 1/((N-1)^2-1) + dots + 1/(2^2-1) $

分别计算 $N = 10^2, 10^4, 10^6$ 时的结果，并指出每种累加顺序下的有效位数.

为了计算数值解的有效数字，首先需要求出该级数的精确理论值.对通项进行裂项分解：
$ 1 / (j^2 - 1) = 1 / 2 ( 1 / (j-1) - 1 / (j+1) ) $

将其代入求和公式，利用裂项相消法可得精确和的解析表达式：
$ S_N &= 1 / 2 sum_(j=2)^N ( 1 / (j-1) - 1 / (j+1) ) \
      &= 1 / 2 ( (1 - 1/3) + (1/2 - 1/4) + (1/3 - 1/5) + ... + (1/(N-1) - 1/(N+1)) ) \
      &= 1 / 2 ( 1 + 1/2 - 1/N - 1/(N+1) ) \
      &= 3/4 - (2N+1) / (2N(N+1)) $
利用此解析表达式，可以求出不同 $N$ 值下的精确解，以此作为基准来评估浮点数计算的误差.


== 算法
#v(0.3cm)
本程序的计算任务分为三个阶段：

1. 项值生成与累加：根据设定的循环方向（降序或升序），依次生成通项 $1/(j^2-1)$，并将其累加至单精度浮点数变量中.

2. 基准计算与误差评估：利用解析表达式计算级数的精确值，并将其与单精度累加结果进行比对，利用公式推导计算出近似值的有效数字位数.

3. 格式化输出：遍历 $N in {100, 10000, 1000000}$，将计算结果及有效数字位数按照指定格式导出为 CSV 文件，便于后续的数据分析.

在第一问的解决方案中, 我们已经分析过了求解有效数字个数的方案. 在这里，只需要将第一问中为求解有效数字个数封装的函数中的浮点变量与常量由双精度类型改为单精度类型即可直接复用. 
== 结果
#v(0.3cm)
将数据整理后，整理在以下的表格中：

#figure(
  table(
    columns: (auto, auto, auto, auto, auto, auto),
    align: (center, center, center, center, center, center),
    stroke: none,
    
    table.hline(y: 0),
    table.header(
      [ $N$ ], [ 精确值 ], [ 降序求和 ], [ 有效位数 ], [ 升序求和  ], [ 有效位数 ]
    ),
    table.hline(y: 1, stroke: 0.5pt),
    
    $10^2$, `0.7400495`, `0.7400495`, [7], `0.7400495`, [7],
    $10^4$, `0.7499000`, `0.7498521`, [4], `0.7499000`, [7],
    $10^6$, `0.7499990`, `0.7498521`, [3], `0.7499990`, [7],
    
    table.hline()
  ),
  caption: [不同累加顺序下的级数求和结果与有效位数对比]
)
== 结果分析与讨论
#v(0.3cm)
观察表 3 中的计算结果，我们可以得出以下显著结论：

1. 当 $N=10^2$ 时，由于累加项数较少，且最小项 $1/(100^2-1) approx 10^(-4)$ 与单精度机器精度（$approx 10^(-7)$）相比仍有一定差距，因此无论是降序还是升序计算，均能保持 7 位的有效数字.

2. 随着 $N$ 的增大（$N=10^4$ 与 $N=10^6$, 降序求和的精度急剧下降.在 $N=10^6$ 时，降序结果仅剩下 3 位有效数字，与精确值产生了明显的偏离.

3. 对于升序求和，无论 $N$ 增大到何种规模，其计算结果始终稳定在 7 位有效数字，完美达到了单精度浮点数的理论精度上限.

通过本实验，我深刻理解了计算机底层浮点数加法运算的对阶机制及其引发的舍入误差：

在 IEEE 754 单精度浮点数标准下，尾数仅有 23 位，这意味着其能分辨的相对大小差异约为 $10^(-7)$.在进行两个浮点数的加法运算时，计算机会先进行对阶操作——将阶码较小的数的尾数向右移位，使其阶码与较大的数对齐.

- *降序求和*：累加器首先吸收了 $1/3, 1/8$ 等较大的值，总和迅速接近 $0.75$.当循环进行到末尾时，需要加上如 $1/(10^(12)-1) approx 10^(-12)$ 这样极小的值.由于 $10^(-12)$ 与 $0.75$ 的量级差距远超单精度的分辨极限（$10^(-7)$），在对阶时，极小数的有效位会被全部移出并直接截断. 这就导致了所谓的大数吃小数现象，累加操作实际上变成了无效的 $+0$ 操作，从而产生了巨大的截断误差积累.

- *升序求和*：计算从末端微小项开始.此时两个相加的数极小且量级相近，对阶移位量很小，尾数得以完整保留. 这些微小的数值经过成千上万次的累加，逐渐增长到一个在单精度下不可忽视的量级，然后再与前端的较大项相加. 这种方式充分保护了所有微小项的有效信息.

= 思考与收获
#v(0.3cm)

本次计算方法上机实验, 给我带来的最大冲击是理论正确与实践正确之间的巨大鸿沟. 尽管两个解析表达式可能是等价的，但是在计算机中算出来的结果却可能有很大的差别. 无论是问题一中的相似数相减，还是问题二中的“大数吃小数”，都说明了一个道理：一个好的算法不仅需要理论上的正确，更需要数值上的稳定性.

= 附件
== function.hpp (头文件与核心逻辑)
  #code_block(
    ```cpp
#ifndef FUNCTION
#define FUNCTION
#include <cmath>
#include <algorithm>

inline int calc_sig(double approx, double exact) 
{
    if (exact == 0.0) return 0;
    double error = std::abs(approx - exact);
    if (error == 0.0) return 16; 
    
    // m = std::floor(log_10(\|x|)) + 1
    double m = std::floor(std::log10(std::abs(exact))) + 1.0;
    // n <= m - log10(2 * Ea) 
    int n = std::floor(m - std::log10(2.0 * error));
    
    return std::max(0, std::min(n, 16)); 
}

inline double sec(double x)
{
    return 1 / std::cos(x);
}

inline double func1(double x)
{
    return (1 - sec(x)) / (std::pow(std::tan(x),2));
}


inline double func1_var(double x) 
{
    return -std::cos(x) / (1.0 + std::cos(x));
}

inline double func2(double x)
{
    return (1 - std::pow((1-x),2)) / x;
}

inline double func2_var(double x)
{
    return 2 - x;
}

inline double value(int x)
{
    return std::pow(10.0,-x);
}

#endif
```
  )

== bisection.cpp (测试主程序)
  #code_block(
    ```cpp
#include <fstream>
#include <iostream>
#include <iomanip>
#include "function.h"

int main()
{
    std::ofstream out("data.csv");
    if (!out.is_open())
    {
        std::cerr << "File open fail" << std::endl;
        return 1;
    }

    out << "x," 
        << "f1(Unstable)," << "f1(Stable)," << "f1_Sig_Figs," 
        << "f2(Unstable)," << "f2(Stable)," << "f2_Sig_Figs\n";
    
    for (int i = 1; i <= 14; i++) 
    {
        double x = value(i);
      
      

        double f1 = func1(x);
        double f1_stable = func1_var(x);
        double f1_sig = calc_sig(f1, f1_stable);
        
        double f2 = func2(x);
        double f2_stable = func2_var(x);
        double f2_sig = calc_sig(f2, f2_stable);
        
        out << std::scientific << std::setprecision(0) << x << "," << std::scientific << std::setprecision(16)
            << f1 << "," << f1_stable << ",";
            
        out << std::fixed << std::setprecision(0) << f1_sig << ",";
        
        out << std::scientific << std::setprecision(16);
        out << f2 << "," << f2_stable << ",";
        
        out << std::fixed << std::setprecision(0) << f2_sig << "\n";
    }    
    
    out.close();
    std::cout << "Data successfully written to data.csv" << std::endl;
    
    return 0;      

}


    ```
  )

- 问题2源代码
  - ``` function.h```
   #code_block(
    ```cpp
#ifndef FUNCTION
#define FUNCTION
#include <cmath>
#include <algorithm>

inline int calc_sig(float approx, float exact) 
{
    if (exact == 0.0f) return 0;

    float error = std::abs(approx - exact);

    if (error == 0.0f) return 7; 
    
    // m = std::floor(log_10(\|x|)) + 1
    float m = std::floor(std::log10(std::abs(exact))) + 1.0f;
    

    // n <= m - log10(2 * Ea) 
    int n = std::floor(m - std::log10(2.0f * error));
    
    return std::max(0, std::min(n, 7)); 
}

inline float ComputeTerm(long long j)
{
    const double dj = static_cast<double>(j);
    return static_cast<float>(1.0 / (dj * dj - 1.0));
}

inline float SumDescending(long long N)
{
    float sum = 0.0f;
    for (long long j = 2; j <= N; ++j)
    {
        sum += ComputeTerm(j);
    }
    return sum;
}

inline float SumAscending(long long N)
{
    float sum = 0.0f;
    for (long long j = N; j >= 2; --j) {
        sum += ComputeTerm(j);
    }
    return sum;
}

inline float ExactValue(long long N)
{
    return 0.5f * (1.5f - 1.0f / N - 1.0f / (N + 1));
}


#endif
   


    ```
   )
#pagebreak()
  - ``` main.cpp```
  #code_block(
    ```cpp 
#include <fstream>
#include <vector>
#include <iomanip>
#include "function.h"


int main() 
{
    std::vector<long long> N_values = {100, 10000, 1000000};
    
    std::ofstream outfile("result_Q2.csv",std::ios::in | std::ios::trunc);
    if (!outfile.is_open()) 
    {
        return 1;
    }
    
    outfile << "N,ExactValue,SumDescending,SigDigitsDesc,SumAscending,SigDigitsAsc\n";
    
    for (long long N : N_values) 
    {
        float exact = ExactValue(N);
        float sum_desc = SumDescending(N);
        float sum_asc = SumAscending(N);
        
        int sig_desc = calc_sig(sum_desc, exact);
        int sig_asc  = calc_sig(sum_asc, exact);
        
        outfile << N << ",";
        
        outfile << N << ",";
    
        outfile << std::fixed << std::setprecision(7)
                << exact << "," 
                << sum_desc << ","
                << sig_desc << "," 
                << sum_asc << ","
                << sig_asc << "\n";
        outfile << std::defaultfloat;
    }

    return 0;
}   
     ```
  )