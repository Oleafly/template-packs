#import "preamble.typ": template
#import "colorbox.typ": *
#show: template.with(
  header: "华东师范大学软件工程学院实验报告",
  author: "张梓卫",
  title: "上机实验报告",
)

#v(30pt)

#align(
  center,
  text(17pt)[
    华东师范大学软件工程学院实验报告
  ],
)

#v(17pt)

#table(
  columns: (1fr,) + 3 * (auto,),
  rows: 3,
  align: left + horizon,
  stroke: (x, y) => {
    (top: if y == 0 { 0.45pt + black })
    (bottom: if y == 3 { 0.45pt + black })
  },
  [课程名称：], [年级：], [#h(2.1cm)], [上机实践成绩：],
  [指导教师：], [姓名：], [], [],
  [上机实践名称：], [学号：3141592653], [], [上机实践日期：2025/03/11],
  [上机实践编号：（1）], [组号：], [], [上机实践时间：2学时],
)

#outline(
  title: [#h(-1em)目录],
  indent: 2em,
  depth: 2,
)

= 有序列表和无序列表

- 无序列表
- 有序列表
  1. 有序列表序号 1
  2. 有序列表序号 2

= 代码块

```c
int main() {
  printf("Hello World!\n");
  return 0;
}
```

#pagebreak()

= Admonition

#warning[
  这是一个警告框。
]

#answer[
  这是一个回答框。
]

#brainstorming[
  这是一个头脑风暴框。
]

#tips[
  这是一个提示框。
]

#task[
  这是一个任务框。
]

#question[
  这是一个问题框。
]

#error[
  这是一个错误框。
]

#solution[
  这是一个解答框。
]

// #redbox(title: "测试")

= Other

== 分割线

#CrossLine

== #scr("SCR") 功能

#scr("This is a sentence.")

== 星星包裹

#amazed(color: blue)[Content]
