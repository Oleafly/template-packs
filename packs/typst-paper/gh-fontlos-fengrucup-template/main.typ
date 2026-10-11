#import "template.typ": *

#show: frb.with(
    title: "\"冯如杯\" 竞赛主赛道项目论文 Typst 模板",
    subtitle: "基于 Typst 的论文模板",
    header: "北京航空航天大学“冯如杯”竞赛主赛道参赛作品论文模板",
    author: "Fontlos",
    abstract-CN: [
        本 Typst 模板是北京航空航天大学大学第三十四届 "冯如杯" 竞赛主赛道论文模板, 相比 Word 排版更加强大, 相比 Latex 模板更加轻量方便快捷
    ],
    keyword-CN: [
        冯如杯, 模板, Typst
    ],
    abstract-EN: [
        This Typst template is made for the main track paper of the 34rd Fengru Cup Competition of Beijing University of Aeronautics and Astronautics (BUAA), which is more powerful compared to Word, and lighter and easier to use compared to the Latex template.
    ],
    keyword-EN: [
        Fengru Cup, Template, Typst
    ],
    bibliography-file: "refs.bib",
    auto-num-title: true,
)

= Typst 简介

Typst 是可用于出版的可编程标记语言, 拥有变量, 函数与包管理等现代编程语言的特性, 注重于科学写作 (science writing), 定位与 LaTeX 相似. 相比于 Latex, 有语法简洁, 编译速度快, 环境搭建简单等优势

= 使用方法

所有样式已参照北京航空航天大学大学第三十四届 "冯如杯" 竞赛主赛道论文格式要求制定, 使用者只需专注于文字编辑即可

== 环境配置

=== 编译器及必要文件准备

- 从 #link("https://github.com/typst/typst/releases/")[*Github Release*] 下载对应系统打包好的可执行文件并加入环境变量
- 确保电脑上装有宋体(SimSun), 华文中宋体(STZhongsong), 黑体(SimHei), 华文新魏(STXinwei), Times New Roman 等字体(不确定是否安装可输入 `typst fonts` 命令查看)
- `git clone` 或 下载本储存库

=== 编辑器配置

推荐使用 *Vscode* 并搭配 *Typst LSP* 和 *Typst Preview* 插件

== 模板使用

基本语法详情参照 #link("https://typst.app/docs/reference")[#bold("官方文档")], 这里仅介绍一下如何使用模板

```typ
#import "template.typ": frb

#show: frb.with(
    title: "Title",
    subtitle: "Subtitle",
    header: "Header",
    author: none,
    abstract-CN: [中文摘要],
    keyword-CN: [关键词1, 关键词2],
    abstract-EN: [English Abstract],
    keyword-EN: [Keyword1, Keyword2],
    bibliography-file: "refs.bib",
    bibliography-title: "参考文献",
    bibliography-style: "gb-7714-2015-numeric",
    auto-num-title: true,
)
= First title

== Second title

=== Third title

Your article
```

- `title`: 论文标题, 显示在封面页, 必填
- `subtitle`: 论文副标题, 可以留空, 无需手动写出破折号
- `header`: 论文页眉内容
- `author`: 虽然作者根据冯如杯规则理应留空或者填写 `none`, 但还是加上了
- `abstract-CN`: 中文摘要, 直接在中括号内填写即可, 内容要求同正文相同, 下面的 `abstract-EN`同理
- `keyword-CN`: 中文关键词, 直接在中括号内填写即可, 用逗号隔开, 下面的 `abstract-EN`同理
- `bibliography-file`: 参考文献目录文件是一个 `.bib` 文件, 具体写法可以参照下面的内容以及本储存库根目录的 `refs.bib`
- `bibliography-title`: 参考文献目录标题
- `bibliography-style`: 参考文献样式
- `auto-num-title`: 按照冯如杯的规范对标题进行自动标号, 默认启用, 如果你有需要也可以关闭此功能手动标号

=== 样式说明

对于 1, 2, 3 级标题, 模板已经适配了对应的样式

由于结论章节不进行标题编号, 所以需要使用单独的 `#conclusion()` 函数来生成结论章节标题

模板已经做好了段首自动缩进, 输入时仅需要空一行作为分段即可

但是 Typst 目前仅能给连续段落除第一段以外的段落进行段首缩进, 所以会打破段落连续性的元素可能导致缩进失败

在本模板中, 以下会导致段落连续性被打破的元素已经做好了段首缩进适配

- Heading
- List
- Numbered list
- Table
- Math block
- Code block
- `img` function

对于其他元素, 可以通过 `#indent` 或 `#h(2em)` 手动添加缩进

对于数学表达式和代码块, 其字体使用内建字体, 如果需要替换请直接修改模板代码

目前 Typst 对中文字体样式的支持不够完善, 因此模板内提供了一些函数进行辅助, 包括用于加粗文本的 `bold` 函数, 使文本斜体的 `italic` 函数, 以及专门针对中文字符的版本, 如果你希望可以通过原生语法实现中文字体加粗, 可以通过 `#show: bold-rule` 来开启全局规则, 斜体同理, 但可能会产生一些冲突和难以排查的错误

注: `bold` 函数可能会与数学表达式块中的同名函数冲突, 可以通过别名导入解决此问题

=== 内建函数说明

只展示最基础的用法, 详细说明见模板源码

- `img`: 添加一张带有说明的图片
    - 用法: `#img(path:"path/to/image")[caption]`
    - 可选参数:
        - `width`: 图片宽度, 接受百分制参数
        - `num`: 是否启用图片标号, 默认关闭
- 下面的函数针对于非英文字符
- `bold`: 加粗文字
    - 用法: `#bold[Text]`
    - 可选参数:
        - `reg`: 正则表达式
        - `base-weight`: 字重, 接受 `em` 单位的参数
- `bold-cn`: 针对中文的加粗, 参考 `bold`
- `bold-rule`: 启用加粗规则, 使你能够通过 `**` 加粗文字
    - 用法: `#show: bold-rule`
- `bold-cn-rule`
- `italic`: 斜体文字
    - 用法: `#italic[Text]`
    - 可选参数:
        - `reg`: 正则表达式
        - `ang`: 倾斜角, 弧度制
        - `spacing`: 两侧空白
- `italic-rule`: 启用斜体规则, 使你能够通过 `__` 倾斜文字
    - 用法: `#show: italic-rule`

=== 参考文献目录文件

一个 `.bib` 文件通常包含若干条以下内容

```bib
@article{refa,
    author    = {Author},
    title     = {Title},
    journal   = {Journal},
    volume    = {1},
    pages     = {1--2},
    year      = {2024},
}

@book{refb,
    author    = {Author},
    title     = {Title},
    edition   = {Edition},
    address   = {Address},
    publisher = {Publisher},
    year      = {2024},
}

@phdthesis{refp,
    author = {Author},
    title  = {Title},
    school = {School},
    year   = {2024},
}
```

这三种分别代表文章, 书籍, 博士论文. `refa` 等代表引用名称, 可以在正文中通过 `@refa` 在具体位置添加引用@refa @refb @refp. 其他参数很容易理解. 最后将在文章末尾添加参考文献目录. 其他参数和类型请自行参阅 LaTex BibTex 标准

#conclusion()

无论是对比 Word 还是 Latex, Typst 都是论文编写更加高效更加现代化的方式, 值得推广让更多人学习使用