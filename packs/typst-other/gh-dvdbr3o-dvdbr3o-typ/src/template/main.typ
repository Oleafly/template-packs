#import "dvdbr3o.typ": *

#show: dvdbr3otypst.with(
  title: [实验报告],
  subtitle: [哈哈我是实验报告],
  author: [路人甲],
  xno: [114514],
  bib: bibliography("reference.bib"),
)

#pagebreak()

= 第一章

== 展示

一段文字

另一端文字

引用 @vaswani2023attentionneed

=== 代码块

```cpp
#include <iostream>

int main() {
	std::cout << "hello world!\n";
}
```

=== 公式

$
integral.cont_(L)P dif x + Q dif y = integral.double_(D) ((partial Q) / (partial x) - (partial P) / (partial y)) dif x dif y
$
