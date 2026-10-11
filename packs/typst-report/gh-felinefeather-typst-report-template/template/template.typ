#import "../package/format.typ": *

#show: project.with(
  lab_name: "单摆测量重力加速度实验",
  stu_name: "你的名字",
  stu_id: "PB24114514",
  department: "排版与Typst开发学院",
  date: datetime.today(),

  abstract: [abstract 是摘要],
  keywords: ([keywords],"是",[关键词],"更多功能详见代码")
)
== 引言：
单摆实验是一个经典实验，周期公式可列为
 $ T = 2pi sqrt(l/g [1+d^2/(20 l^2) - m_0/(12 m)(1+d/(2l)+m_0/m)+rho_0/(2rho) + theta^2/16]) $

== 实验装置：
钢卷

== 实验内容：
1. 基础内容
  - 这是一个基础内容
  - 这是另一个基础内容
    - 这是二级目录
+ 进阶内容
4. 高阶内容

== 实验数据分析：
=== 一、基础内容实验数据分析

#figure(caption: "基础内容数据记录", table(
  columns: 7,
  [表格],[的],[名字],[一般],[在],[表格],[上面]
))

=== 二、提升内容实验数据分析：

#figure(caption: "但是图片的名字在图片下面", image("../package/USTC-logo.png"))


=== 三、高阶内容实验数据分析：
你可以在这里 ```typ @参考文献``` 来召唤参考文献！
@大学物理实验-第一册
== 结论：

这是一个极简版的Typst模板，如果嫌麻烦就用这个吧

#bibliography("works.bib")