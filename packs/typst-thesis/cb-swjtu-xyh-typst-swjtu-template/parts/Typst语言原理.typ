= Typst语言原理

本章介绍Typst排版语言的原理，作为后续实际论文排版的工具。

== 基本情况
Typst是由Martin Haug和Laurenz Mädje共同开发的现代排版语言，发布于2021年。两位作者当时都是德国柏林工业大学计算机专业的硕士生，Typst语言是他们的硕士毕业论文成果。其中Laurenz Mädje负责语言设计，Martin Haug负责增量编译功能设计。

他们的灵感来源于LaTeX，希望设计一款现代化的标记排版语言，比LaTeX更简单、易用、高效。

== 设计思想

Typst语言的设计思想可以总结为以下三个方面：
+ 一致性带来简单 (Simplicity through Consistency)：语法规则一致，避免出现例外情况。

+ 组合性带来强大 (Power through Composability)：尽量避免直接提供大量琐碎的具体功能，而是提供实现功能的机制，让用户根据需求自行组合实现具体功能。

+ 纯函数带来极致性能 (Performance via Pure Functions)：与TeX本质是一种字符串替换的宏语言(Macro Language)不同，Typst本质是一个函数式编程语言(Functional Language)，支持纯函数、范围等现代函数式语言的功能，方便写出简介高效的代码。

在具体实现上，Typst注重运行速度，即编译一篇学位论文的时间控制在毫秒级。为了实现这个目标首先Typst采用Rust语言开发，贴近硬件底层。然后再系统架构中强调缓存和增量编译，当一篇百万字论文修改了一个字时，Typst不需要重头编译整个论文而只需要编译受影响的部分。

== 工作机制

Typst程序本质上是一个编译器，基本工作方式为
+ 打开`.typ`源文件，作为字符串读入。
+ 将源文件字符串转化为token
+ 将token串转化为语法树
+ 根据语法树解释运行，结果为content
+ 使用排版算法将content转化为frame，每个frame代表一页
+ 将frame转化为输出格式，比如`.pdf`、`.png`、`.svg`等

与一般编译器不同，Typst可能需要对一个文件循环编译多次，以满足排版的一致性要求。默认设置循环不能超过5次，5次还没收敛Typst报错。