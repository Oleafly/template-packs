#import "@preview/touying:0.6.1": *
#import "../lib.typ": *

#show: sdu-theme.with(config-info(
  title: [sdu-touying template],
  subtitle: [template example based on touying],
  author: [xmdjy],
  institution: [计算机科学与技术学院],
  date: datetime.today(),
))

#title-slide()

#outline-slide()

= typst简介
== typst简介
#text(fill: blue,weight: "bold")[Typst]是一款轻量的编程语言，具有与`markdown`类似的语法，又有不输`latex`的强大的数学排版能力，适合学术汇报，实验报告等场景使用 \
在codex的帮助下，我完成基于`touying`的sdu-touying模板开发，你可以使用最基本的typst语法来完成你的学术汇报，或者在此基础上进行个性化定制

== 基本语法
- 标题使用\= , \==分别表示一级标题和二级标题
- *加粗*使用\*包裹,_斜体_使用\_包裹
- #highlight(fill: yellow)[高亮]使用\#highlight[]包裹，用`fill`字段来改颜色
- #super[上标]和#sub[下标]分别用\#super[]和\#sub[]来包裹
- 无序列表用\-开头，有序列表用\+开头
  + content1
  + content2

== 代码块 & 类obsidan模块
#codly(languages: codly-languages)
```python
def hello():
    print("Hello, World!")
```
#info[信息框]

#warning[警示框]
更多样式请参考gentle-clues的仓库和教程

== 数学公式
行内公式用\$包裹，行间公式唯一的区别就是每个\$左右侧各加一个空格\
行内公式示例：$z_k = sum_(i=1)^n W_"ij"x_i$\
行间公式示例：$ A = pi r^2 $ \
更复杂一点的：$ cal(F)(omega) = integral_(-infinity)^(infinity) f(t) e^(-i omega t) d t $ \
其他示例：$ A = mat(1, 2; 3, 4)  \ quad sum_(i=1)^n i = (n(n+1)) / 2 $ \
打多了`latex`会很难适应，但实际上`typst`的数学公式更好打\
(不用忍受\\begin{bmatrix}这种语法了)

= touying 使用教程

== 最小化模板例子
```typst
#import "@preview/touying:0.6.1": *
#import "../lib.typ": *

#show: sdu-theme.with(config-info(
  title: [主标题],
  subtitle: [副标题],
  author: [作者],
  institution: [单位],
  date: datetime.today(), //时间，这里默认用当天时间
))

#title-slide()

#outline-slide()

== 致谢 <touying:unoutlined>

#end-slide()
```
理论上，你的框架模板只需要有以上的内容就可以，具体字段请自行修改\
写PPT内容的时候，只需要\=和\==开一二级标题然后写内容就行，资源文件(如你需要使用的图片)建议放在/image目录下面(注意不要动其他的资源文件，否则模板会崩掉)，一个比较适合放图片的写法是用\#grid()排版，开两个`column`，第一列放图片，第二列放文字说明，只需一个\image[]和一个\caption[]函数

== details
#text(fill: blue,size:32pt,weight: "bold")[_wait to update..._]

== end
感谢你的使用和浏览，如果你有任何的问题和发现了bug，请随时联系我或提交`issue`\
*给个`star`吧谢谢你！*
顺便宣传一下实验报告模板：#link("https://github.com/xmdjy/exp-report-template")[sdu-exp-report-template]

== 致谢 <touying:unoutlined>

#end-slide()
