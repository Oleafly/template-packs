// 上海交通大学课程报告模板 - Typst版本
// 基于原LaTeX模板转换：https://github.com/Jiazhen-Lei/SJTU_Course_Template_Latex

#import "sjtu-report.typ": *

// 文档配置
#show: sjtu-report.with(
  title: "XXXX课程报告",
  subtitle: "XXXXXX进展调研", 
  school: "航空航天学院",
  class: "XX24MXXX",
  student-id: "024xxxxxxx", 
  author: "XXX",
  date: datetime.today(),
  header: "页眉中",
)

// 正文内容开始
= 模板说明

本模板主要适用于一些课程的平时论文以及期末论文，默认页边距为2.5cm，中文宋体，英文New Computer Modern，字号为10.5pt（五号）。

编译方式：直接使用 `typst compile main.typ` 即可生成PDF。

默认模板文件由以下部分组成：
- `main.typ` 主文件
- `sjtu-report.typ` 模板样式文件
- `references.bib` 参考文献文件
- `figures/` 放置图片的文件夹

第一次使用时需在主文件顶部修改标题、姓名、学号、院所、页眉等信息，设置完后即可一劳永逸。

默认带有封面页以及目录页，页码从目录页开始。

= 一些插入功能

== 插入公式

行内公式 $v - epsilon + phi = 2$。

插入行间公式如 @Euler：
$ v - epsilon + phi = 2 $ <Euler>

== 插入图片

SJTU校徽如 @SJTU 所示，注意这里使用了 `@` 符号进行引用，会自动生成"图""式"等前缀。

此外，模版同时提供了校徽，如 @SJTU_notitle 所示，请根据实际需求使用。

#figure(
  image("figures/sjtu_logo_page-0001.jpg", width: 50%),
  caption: [上海交通大学],
) <SJTU>

#figure(
  image("figures/sjtu_logo_notitle_page-0001.jpg", width: 40%),
  caption: [校徽],
) <SJTU_notitle>

插入上面图片的代码：

```typst
#figure(
  image("figures/sjtu_logo.pdf", width: 40%),
  caption: [上海交通大学],
) <SJTU>
```

== 插入文本框

本模板定义了一个圆角灰底的文本框，使用 `#tbox[]` 即可：

#tbox[
  这是一个圆角灰底的文本框
]

== 插入表格

本模板文件如 @doc 所示。

#figure(
  table(
    columns: 2,
    stroke: 0.5pt,
    [*文件名*], [*说明*],
    [`main.typ`], [主文件],
    [`sjtu-report.typ`], [模板样式文件],
    [`references.bib`], [参考文献],
    [`figures/`], [图片文件夹],
  ),
  caption: [本模板文件组成],
) <doc>

== 插入参考文献

直接使用 `@` 符号引用参考文献的标签即可。

例如：

此处引用了文献 @wang2023intention。

引用过的文献会自动出现在参考文献中。

= 写在最后

== 发布地址

- GitHub: https://github.com/h-zhichao-w/-Typst

== 原latex模板

- GitHub: https://github.com/Jiazhen-Lei/SJTU_Course_Template_Latex