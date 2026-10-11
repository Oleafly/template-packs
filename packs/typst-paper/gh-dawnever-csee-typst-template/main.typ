#import "template.typ": *
#show: project.with(
  title: "Typist Template for CSEE",
  authors: ("Alice","Bob","Cindy","David"),
  address: "School of Electric and Electrical Engineering, Huazhong University of Science and Technology, Wuhan, 430074, China",
  title_cn: "标题二号，黑体，英文字体为Arial，希腊字母保持不变，段前空12pt",
  authors_cn: ("张三","李四","王五","赵六"),
  address_cn: "华中科技大学电气与电子工程学院，武汉市 洪山区 430074",
  abstract: [
    #lorem(100)
  ],
  abstract_cn:[
    英文摘要为小五号Times New Roman字体，行距为14pt，标点为半角。
    中文摘要为小五号宋体，行距为14pt，中间标点为全角，段首空6pt。],

  keywords: ("A", "B", "C", "D"),
  keywords_cn:("啊", "啵", "呲", "嘚"),
  bibliography-file: "refs.bib",
)

= 引言
正文字号五号，首行缩进0.74cm，中文宋体，英文及数字为Times New Roman，
行距为单倍行距（“根据页面设置确定行高线”选项选中），段尾不要单字成行。
文中字母与公式中字

#lorem(30)

= 二级标题为小四黑，英文字体为Arial，换行时悬挂缩进为0，段前段后均空6pt，希腊字母保持不变

== 三级标题五号黑体，英文及数字用Arial，希腊字母保持不变

=== 四级标题五号宋体，英文及数字用Times New Roman 字体，换行时悬挂缩进为0，段前段

Citation example of reference papers#cite(<example>).

中文引用案例。#cite(<example_cn>)


= Theoretical Framework
#lorem(30) 

Citation example of Fig @a.

#grid(
    columns: (auto, auto),
    rows:    (auto, auto),
    gutter: 1pt,
    [ #figure(
      image("./img/image.png"),
      caption: [字为Times New Roman， 行距为],
    )<a> ],
    [ #figure(
      image("./img/image.png"),
      caption: [字为Times New Roman， 行距为],
    )<b> ],
    [ #figure(
      image("./img/image.png"),
      caption: [Times New Roman],
    )<c> ],
    [ #figure(
      image("./img/image.png"),
      caption: [字为行距为],
    )<d> ],
)\

正文字号五号，首行缩进0.74cm，中文宋体，英文及数字为Times New Roman， 行距为单倍行距（“根据页面设置确定行高线”选项选中），段尾不要单字成行。文中字母与公式中字

= Methodological Framework
#figure(
  table(
  columns: (auto, auto, auto,auto, auto, auto),
  inset: 3pt,
  align: horizon,
  [*Parameter*], [*Value*], [*Unit*],[*Parameter*], [*Value*], [*Unit*],
  [#lorem(2)],[#lorem(2)],[],
  [#lorem(2)],[#lorem(2)],[],
  [#lorem(2)],[#lorem(2)],[],
  [#lorem(2)],[#lorem(2)],[mm],
  [#lorem(2)],[#lorem(2)],[mm],
  ),

  caption: [（文字黑体顶格，数字Times],
)<baseline_motor_parameter>\


#text(font: font_def)[*定义1*]

#text(font: font_def)[*定理1* （文字黑体顶格，数字Times New Roman，加黑。）]

==  公式的输入要求
使用MathType公式编辑器。
尺寸定义：完全10.5pt、上标/下标6.5pt、次上标/下标4.5pt、符号15pt、次符号12pt；有编号的公式右对齐。
公式1行排不下时第2行以下应有明显缩进，公式转行时就优先在=，>,<，→等关系符号处，其次在＋，－，×，÷，/等运算符号处转行；
转行时关系符号和运算符号应位于上行末，下行首不再重复。对于“ ”类型的公式，改成横排时，不要排成“a/b*c”应改为“a/(bc)”，公式转行时排列格式如下：
引用公式@aa。

$
a + b = c/d
$<aa>

== 表格的要求
1）中文表题小五黑，数字与英文字体及英文表题为Times New Roman（加黑），居中，段前及英文表题后空3 pt，行距为固定值14磅。

2）表中物理量：单位用分数形式表示，单位与物理量需折行排时，分数线要划在上一行的行末。以百分数表示的量，一般用“φB/%”表示。

3）表内栏目线0.5pt，顶线和底线0.75pt。表中文字为六宋，数字及英文为Times New Roman，行距为14pt。列间一律用制表位对齐。

#lorem(1000)
\