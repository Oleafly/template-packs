#import "lib.typ": *
#cover-page(
    image-path: image("求.png"),
    image-height: 30%,
    title: "模板介绍",
    subtitle: "研究与实现",
    author: "imicola",
    student-id: "2020123456",
    department: "计算机学院",
    major: "软件工程",
    advisor: "有这号人吗",
    date: auto,
    institution: "哈尔滨埋土大学",
    institution-logo: image("image.png"),
    title-color: black,
    accent-color: rgb("#4d62a6"),
)
#show: project.with(
    title: "Easy-paper Pro 模板",
    subtitle: "基本功能展示",
    author: "imicola",
    date: auto,
    // toc: false,
    abstract: [
        本文档展示了 EasyPaper Pro 模板的主要功能，包括题目框、解答框、三线表格、数学公式等学术组件。
    ],
    keywords: ("Typst", "模板", "学术写作"),
)
#show table: three-line-table


#chapter-page(title: "Capture 1", subtitle: "基础使用")
// 这里开始章节内容……


= 基本功能

Easy-paper Pro是基于EasyPaper@EasyPaper 改进的模板,在保留单文件设计的同时,添加了简单封面页,章节分割页,和自动目录以及一些新增功能框的实现。

== 文本格式

支持 *粗体*、_斜体_ 和 `inline code`。列表功能：
- 无序列表项
    - 嵌套项目
        - 嵌套列表采用不同符号

+ 有序列表：
    - 混合嵌套
    - 也不会有影响
+ 第二步
    + 当然你也可以继续嵌套
        + 再嵌套
    + 嵌套列表也会自动缩进
+ 第三步

/ 定义: 你还可以定义一个术语，并给出解释。

== 代码块

```python
def factorial(n):
    return 1 if n <= 1 else n * factorial(n-1)
print(factorial(5))  # 输出: 120
```

= 学术组件

== 题目与解答

#problem[
    求 $f(x) = x^2 - 4x + 3$ 的最小值。
]

#solution[
    配方得：
    $
        f(x) = (x-2)^2 - 1
    $

    当 $x = 2$ 时，函数取最小值 $-1$。
]

#summary[
    本题通过配方求解二次函数的最小值，体现了配方在数学问题中的应用。
]

#definition[
    定义1
]

#tip[
    提示框
]

#theorem[
    定理
]

#example[
    示例
]

== 数学公式

重要公式会自动编号：
$
    pardiff(f(x,y), x) = pardiff("", x)((x^2+y^2) / 2) = x
$ <eq:partial>

辅助公式不编号：
$
    sin^2(x) + cos^2(x) = 1
$

还添加了点好用的工具:
- 偏微分符号：$pardiff(f(x,y), x)$

- 结论框: $boxed(998244353"是一个素数")$

== 表格功能
// 三线表格
#figure(
    table(
        columns: 4,
        [*项目*], [*数值*], [*单位*], [*备注*],
        [长度], [10.5], [cm], [注释],
        [质量], [2.3], [kg], [注释],
        [温度], [25.0], [°C], [注释],
    ),
    caption: [实验数据表],
) <tab:data>



下面的文字是引用功能，可以引用@eq:partial 和@tab:data。支持外部#link("https://typst.app")[链接]和脚注#footnote[这是脚注内容]。

= 结论

本模板提供了完整的学术写作功能，适用于报告、作业和笔记撰写。主要特色包括题目解答框、三线表格、公式编号和交叉引用等功能。

#chapter-page(title: "capture 2", subtitle: "样例")

// 这是参考文献内容
#bibliography("ref.bib")
