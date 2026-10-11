#import "template.typ": *

#show: doc.with(bibliography: bibliography("refs.bib"))

= 引言

#mark1(1)分点1

#mark2(1)子分点1

#mark3(1)子子分点1

#mark4(1)子子子分点1

#mark4(2)子子子分点2

#mark3(2)子子分点2

#mark2(2)子分点2

#mark1(2)分点2

= 标题一

#figure(
  rect[],
  caption: [示例图片],
) <img:rect>

这是对@img:rect 的引用。

#figure(
  table(
    columns: 3,
    [A], [B], [C],
    [A], [B], [C],
  ),
  caption: [示例表格],
) <tab:abc>

这是对#[@tab:abc]的引用。

$ F(n) = F(n-1) + F(n-2) $ <equ:fib>

这是对#[@equ:fib]的引用。

这是对参考文献#[@redoli2025kubernetescloudvsbare]的引用。

这是脚注#footnote[示例脚注]

== 子标题一

=== 子子标题一

=== 子子标题二

== 子标题二

= 标题二

= 结论
