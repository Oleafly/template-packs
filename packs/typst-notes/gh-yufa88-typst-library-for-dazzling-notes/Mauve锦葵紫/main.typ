#import "lib.typ": *

#show: project.with(
  title: "Mauve Flow",
  author: "Typst User",
  sidebar-content: [
    #text(weight: "bold", fill: c-mauve.darken(10%))[Directory]
    #v(0.5em)
    #outline(title: none, indent: 1em, depth: 2)
    #v(2em)
    #capsule-callout(title: "布局说明", icon: "✨")[
      第一页是侧边栏布局，翻页后我们将切换到全宽布局。
    ]
  ]
)

= 第一页：侧边栏模式

这里的文字会自动避让左侧的玻璃侧边栏。因为我们在 `page` 设置中预留了 `7cm` + `1cm` 的左边距。

#capsule-callout(title: "提示", icon: "🎈")[
  在第一页写满之前，布局都会保持这个状态。案例中的英文为随机内容，旨在展现多页排版
]

== 后文英文为随机生成内容，
=== 展现多页排版：\

#lorem(50)

== Mac 代码块测试
```rust
fn main() {
    println!("Hello, Flow Layout!");
}
```
#capsule-callout(title: "关于分页", icon: "📄")[ 继续往下写，当内容超过一页时，Typst 会自动分页。

默认情况下，第二页左侧会保持空白（为了保持阅读流的一致性）。如果你想在第二页回收左侧空间，请看下方。 ]

#lorem(70)

// ----------------------------------------------------- // 重点修正：使用 show 规则来切换布局 
#show: switch-to-full-width



= 第二页：自动延伸

#capsule-callout(title: "关于分页", icon: "📄")[这是第二页的内容。你可以看到：

+ 侧边栏消失了（没有了玻璃条和头像）。

+ 文字自动流转到了这里，没有被截断。

*如果不调用 \#switch-to-full-width()，这一页左侧会保留空白，这在学术论文或书籍排版中很常见（留白美学）。*

如果你调用了它，下面的文字就会顶格显示。]

#lorem(100)

== 更多测试

$ F(x) = integral_0^infinity e^(-x) dif x $

#lorem(100)
#lorem(1000)