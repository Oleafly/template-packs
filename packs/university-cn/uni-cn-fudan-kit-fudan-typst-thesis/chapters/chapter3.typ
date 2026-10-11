= 高级功能

== 盲审模式

模板支持盲审模式，启用后将自动隐藏以下个人信息：

- 封面上的作者姓名、学号、培养单位、指导教师
- 声明页（独创性声明和授权声明）
- 致谢内容

可通过两种方式启用盲审模式：

*方式一*：在 `main.typ` 中设置参数：

```typst
#show: thesis.with(
  blind: true,
  // ...
)
```

*方式二*：通过命令行参数覆盖（优先级更高）：

```bash
typst compile --input blind=true main.typ
```

盲审封面仅保留校名图片、学位类型、论文标题、英文标题、学科专业和论文提交日期，不显示任何可识别作者身份的信息。

== 双面打印

启用双面打印模式后：

- 一级标题从奇数页（右侧页）开始
- 页眉在奇偶页交替显示：奇数页显示"复旦大学博士学位论文"，偶数页显示当前章标题
- 在章节之间自动插入空白页以保证排版正确

```typst
#show: thesis.with(
  twoside: true,
  // ...
)
```

或通过命令行：`typst compile --input twoside=true main.typ`

== 学位类型配置

=== 博士学术学位论文（默认）

```typst
info: (
  degree: "doctor",
  degree-category: "学术学位",
  major: "计算机科学与技术",  // 填写学科专业名称
  // ...
)
```

=== 博士专业学位论文

```typst
info: (
  degree: "doctor",
  degree-category: "专业学位",
  major: "电子信息",  // 填写学科专业名称
  // ...
)
```

按 2026 年标准样本，学术学位与专业学位封面均使用“学科专业”字段；`degree-category` 只控制“（学术学位）”或“（专业学位）”标识。

=== 硕士学术学位论文

```typst
info: (
  degree: "master",
  degree-category: "学术学位",
  major: "计算机科学与技术",
  // ...
)
```

=== 硕士专业学位论文

```typst
info: (
  degree: "master",
  degree-category: "专业学位",
  major: "电子信息",
  // ...
)
```

=== 本科毕业论文

```typst
info: (
  degree: "bachelor",
  // 本科无需设置 degree-category
  // 本科封面额外显示"题目"和"学号"字段
  // ...
)
```

== 涉密论文

涉密论文需要在封面标注密级和保密年限：

```typst
info: (
  secret-level: "秘密五年",
  // 其他可选值："机密十年"、"绝密永久" 等
  // ...
)
```

启用后，密级信息将显示在封面右上角学校代码的上方。设为 `none`（默认）则不显示密级信息。

== 同等学力与英文项目

同等学力人员和英文项目的标识会显示在封面右上角学号下方：

```typst
info: (
  equivalent-education: true,  // 同等学力人员
  english-program: true,       // 英文项目
  // ...
)
```

== 扉页（指导小组）

根据规范要求，论文扉页列出指导小组成员名单。通过 `committee` 参数配置：

```typst
#show: thesis.with(
  committee: (
    "张三　教授　　复旦大学",
    "李四　副教授　复旦大学",
    "王五　研究员　中国科学院",
  ),
  // ...
)
```

设置为 `none`（默认）则不生成扉页。

== 副指导教师

如有副指导教师，可通过 `supervisor-second` 字段设置：

```typst
info: (
  supervisor: "李四　教授",
  supervisor-second: "王五　副教授",
  // ...
)
```

副指导教师姓名会显示在封面"指导教师"字段中，排列在主指导教师之后。

== 附录

附录内容在 `chapters/appendix.typ` 中编写，附录标题使用大写字母编号（附录 A、附录 B……）。

```typst
// chapters/appendix.typ
= 补充实验数据

附录正文内容...

== 附录小节标题

二级标题编号为 A.1、A.2...

= 代码实现

另一个附录，编号为附录 B。
```

== 插图目录与表格目录

如需生成插图目录或表格目录，在 `main.typ` 中启用：

```typst
#show: thesis.with(
  list-of-image: true,
  list-of-table: true,
  // ...
)
```

插图目录列出所有 `figure` 类型的图片及其页码，表格目录列出所有 `table` 类型的表格及其页码。

== 自定义字体

如需更改字体，可修改 `template/config.typ` 中的 `font-family` 配置。例如：

```typst
#let font-family = (
  宋体: ("Times New Roman", "SimSun", "STSongti-SC-Regular", "Noto Serif CJK SC"),
  黑体: ("Times New Roman", "SimHei", "STHeiti", "Noto Sans CJK SC"),
  // ...
)
```

字体列表按优先级排列，Typst 会自动选择系统中第一个可用的字体。模板已内置多平台字体回退方案，通常无需手动调整。

== 中图分类号

中图分类号（CLC）按附件一显示在论文封面左上方，不显示在摘要页。设置方式：

```typst
info: (
  clc: "TP391",  // 中图分类号
  // ...
)
```

设为 `none` 则不显示中图分类号。

== 论文结构规范

根据《复旦大学博士、硕士学位论文规范（2026 年 6 月修订版）》，电子版论文应包含如下内容（本模板已按此顺序自动组装）：

+ 论文封面
+ 扉页：指导小组成员名单（可选）
+ 目录
+ 中文摘要（3–8 个关键词）
+ 英文摘要（3–8 个关键词）
+ 插图和附表清单（有则必备）
+ 引言（前言）/ 正文
+ 参考文献（格式须符合 GB/T 7714—2015）
+ 附录（可选）
+ 致谢
+ 论文独创性声明和论文使用授权声明

用户只需在对应文件中填写具体内容，模板会自动按规范顺序编排、设置页码和页眉。
