#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm), // 页边距
  header: [#h(1fr) _Template_],
  numbering: none
)

#set par(
  first-line-indent: (amount: 2em, all: true),
  justify: true,
  leading: 0.65em, // 行间距
  spacing: 1.2em, // 段间距
)

#set heading(numbering: "1.1")

#set text(
  font: ((name: "libertinus serif", covers: "latin-in-cjk"), "SimSun"),
  size: 12pt,
)

// 代码块
#show raw.where(block: true): block.with(
  fill: luma(240),
  inset: 10pt, // 内边距
  radius: 4pt, // 圆角
  width: 100%, // 宽度
  breakable: false, // 是否可分页
)

#show raw.where(block: true): set text(font: "Consolas", size: 10pt)

/*******************************************************************************/
#outline(title: "目录")     // 目录
#pagebreak()                // 分页
/*******************************************************************************/

#counter(page).update(1)       // 页码计数器
#set page(numbering: "1 / 1")  // 页码格式

= Introduction
== Preliminaries
=== The third level

Numbered list:
#set enum(numbering: "1.", indent: 2em)
+ *Preparations*
+ _Analysis_
+ #underline[important]
+ #strike[delete this]
+ #smallcaps[Hello]
+ Content#sub[note]
+ #highlight[important] or #highlight(fill: rgb("#00ff00a1"))[important]
+ ```cpp int main()```
+ Conclusions

*Bullet list:*
#set list(indent: 2em) // 缩进
- Text
- Math
- Layout

//////////////////// Code /////////////////
```cpp
#include <iostream>
#include <string>

int main()
{
  std::cout << "Hello World!" << std::endl;
  return 0;
}
```
///////////////////////////////////////////

#lorem(50)

=== The third level
#lorem(50)

= 第一级标题
== 第二级标题
=== 第三级标题
项王军壁垓下，兵少食尽，汉军及诸侯兵围之数重。夜闻汉军四面皆楚歌，项王乃大惊曰：“汉皆已得楚乎？是何楚人之多也！”项王则夜起，饮帐中。有美人名虞，常幸从；骏马名骓，常骑之。

=== 第三级标题
项王军壁垓下，兵少食尽，汉军及诸侯兵围之数重。夜闻汉军四面皆楚歌，项王乃大惊曰：“汉皆已得楚乎？是何楚人之多也！”项王则夜起，饮帐中。有美人名虞，常幸从；骏马名骓，常骑之。


#lorem(50)

#lorem(70)

#lorem(70)
