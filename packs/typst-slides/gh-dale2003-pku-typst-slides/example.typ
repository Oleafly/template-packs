#import "template/pku-template.typ": *

#show: doc => pku-theme(
  title: "北京大学Typst演示文稿模板",
  subtitle: "简洁、专业的学术演示",
  author: "宇航员Dale",
  institute: "信息科学技术学院\n北京大学",
  date: "2025年5月25日",
  doc,
)

// 第一章节后面紧跟小标题，所以这里关闭自动分页
= 模板介绍
#pku-enable-pagebreak(false) // 关闭分页
== 基本功能

#text(size: 20pt, fill: pku-red)[北大Typst模板介绍]
#v(0.5em)

- 适用于学术报告、课程演示等场景
- 包含北大校徽和标准配色
- 支持中文显示
- 多种主题选项可供选择
- 自定义函数提高排版效率

#v(1em)

#pku-alert-block(title: "特别提醒")[
  使用Typst编译以获得最佳中文支持和排版效果
]

// 下一个小标题需要分页
#pku-enable-pagebreak(true) // 打开分页
== 基本元素

#text(size: 20pt, fill: pku-red)[基本元素展示]
#v(0.5em)

#pku-columns(
  60%,
  [
    *左侧内容 (60%)*
    
    - 列表项目1
    - 列表项目2
      - 子项目A
      - 子项目B
    - 列表项目3
    
    #pku-block(title: "文本块")[
      这是一个文本块示例，可以用来强调重要内容。
    ]
    
    #align(center)[
      #text(fill: pku-red)[北大红色文本] 和 #text(fill: pku-blue)[北大蓝色文本]
    ]
  ],
  [
    *右侧内容 (40%)*
    
    #figure(
      image("assets/images/fig_7seg_led.png", width: 80%),
      caption: "示例图片"
    )
    
    1. 数字列表1
    2. 数字列表2
    3. 数字列表3
  ]
)

// 后续章节会自动分页
= 高级功能
// 这个小标题紧跟大标题，不需要再分页
#pku-enable-pagebreak(false)
== 代码展示

#text(size: 20pt, fill: pku-red)[代码示例]

#block(
  fill: rgb(245, 245, 245),
  stroke: (left: 3pt + pku-blue),
  radius: 4pt,
  width: 100%,
  inset: 10pt,
  ```python
  # 这是一个Python代码示例
  def hello_pku():
      """向北京大学问好"""
      print("Hello, Peking University!")
      
  if __name__ == "__main__":
      hello_pku()
  ```
)

#block(
  fill: rgb(245, 245, 245),
  stroke: (left: 3pt + pku-blue),
  radius: 4pt,
  width: 100%,
  inset: 10pt,
  ```cpp
  // 这是一个C++代码示例
  #include <iostream>

  int main() {
      std::cout << "Hello, PKU!" << std::endl;
      return 0;
  }
  ```
)

// 后面这个小标题需要分页
#pku-enable-pagebreak(true)
== 表格与公式

#text(size: 20pt, fill: pku-red)[表格]

#align(center)[
  #table(
    columns: (auto, auto, auto),
    inset: 10pt,
    align: (left, center, right),
    stroke: 0.7pt,
    [*左对齐*], [*居中*], [*右对齐*],
    [数据1], [数据2], [数据3],
    [更长的数据], [中等长度], [短数据],
  )
]

#pku-block(title: "表格说明")[
  表格用于展示结构化数据，可以使用不同的对齐方式。
  上述表格展示了三种对齐方式：左对齐、居中和右对齐。
]

#pku-alert-block(title: "注意")[
  表格中的数据应简洁明了，避免过于复杂的格式。
  使用表格时，请确保数据的可读性和易理解性。
]

#pku-pagebreak()

#v(0.5cm)
#text(size: 20pt, fill: pku-red)[数学公式]

#pku-block(title: "数学公式示例")[
  爱因斯坦质能方程:
  $ E = m c^2 $
  
  麦克斯韦方程组:
  $ nabla dot arrow(E) &= frac(rho, epsilon_0) \
    nabla dot arrow(B) &= 0 \
    nabla times arrow(E) &= -frac(partial arrow(B), partial t) \
    nabla times arrow(B) &= mu_0 arrow(J) + mu_0 epsilon_0 frac(partial arrow(E), partial t) $
]

// 最后一章
= 结束
// 不需要分页
#pku-enable-pagebreak(false)

#align(center)[
  #v(1cm)
  #text(size: 25pt, weight: "bold")[感谢使用北京大学Typst模板]
  
  #v(1cm)
  
  #image("assets/images/pku-logo.png", height: 4cm)
  
  #v(1cm)
  
  #text(size: 25pt, weight: "bold")[
    模板文件位于 `template/` 目录下\
    图片资源位于 `assets/images/` 目录下
  ]
]