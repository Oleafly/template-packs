#import "style.typ": *

#show: report(
  leading: 1em,
  spacing: 1.2em,
)

#cover(
  title: "基于Typst的中文报告简易模板",
)

#abstract(
  keywords: ("Typst", "文档排版", "辅助工具")
)[
  本文主要介绍了Typst排版工具，以及一些相关工具。

]

#show: contents()

=  概述

在文档编辑与排版领域，Word、LaTeX 作为长期占据市场的主流工具，虽各有成熟应用场景，但在实际使用中仍存在显著局限。

Word 作为面向大众的可视化编辑工具，在复杂排版场景中暴露出明显短板。其在长文档（如学术专著、大型报告）编辑时，样式一致性难以保障，交叉引用、目录更新易出现异常偏移；数学公式编辑功能虽能满足基础需求，但在专业符号排版精度、公式编号自动化方面效率较低；且文件格式兼容性受版本差异影响显著，高版本特性在低版本打开时易出现样式错乱，大文件还存在卡顿、崩溃风险。

LaTeX 作为学术排版领域的标杆工具，虽然有许多现成的模板可以使用，但编译流程耗时较长，尤其在包含大量图表、公式的大型文档中，修改后的实时预览体验较差。而且，LaTeX的编译过程比较复杂，错误提示也不够直观，调试过程需依赖专业知识。

Typst 作为新兴排版系统，在吸收传统工具经验的基础上实现了技术突破。其采用简洁直观的标记语法，兼顾了 Word 的易用性与 LaTeX 的排版精度，大幅降低了专业排版的入门门槛；支持实时预览功能，修改内容可即时呈现排版效果，显著提升编辑效率；内置完善的数学公式、图表、交叉引用等核心功能，无需复杂宏包配置即可实现专业级排版效果；文件体积轻量化，编译速度远快于 LaTeX，在中小文档场景中优势尤为明显。

尽管 Typst 展现出强劲发展潜力，但其生态成熟度仍有待提升。在格式兼容性方面，目前主要是编译为 PDF 格式文件（导出PNG格式和SVG不太常用，导出HTML目前还处于试验阶段），缺乏对 DOCX、EPUB 等主流格式的直接导出能力。使用其他工具进行格式转换过程中易出现样式失真问题，限制了跨场景文档复用。

在智能化支持层面，受限于技术发展阶段，AI 辅助生成 Typst 代码的能力显著落后于 LaTeX—— 后者依托长期积累的语法规范与庞大语料库，已形成成熟的 AI 辅助编辑生态，而 Typst 相关的 AI 模型训练数据不足，代码生成准确性与效率均存在差距。此外，其社区生态、第三方模板资源数量与 LaTeX 相比仍有较大差距，复杂场景下的定制化支持能力有待加强。


= 模板使用

== Typst环境

安装Typst：https://github.com/typst/typst?tab=readme-ov-file#installation

安装好Typst后，可以使用`typst compile main.typ`命令来编译`main.typ`，得到`main.pdf`。

本地使用Typst，推荐使用VSCode作为编辑器，配合Tinymist插件，编辑体验非常棒。
还可以根据需要安装Typst Math、Draw.io Integration、Git Graph等插件。


== 下载模板

使用git clone 克隆本仓库后，在`template.typ`中撰写内容。
可以通过修改参数来调节字体，字号等，或者直接修改`style.typ`文件。


== 字体

模板中用到了下面的字体，需要提前安装或者在`style.typ`文件中修改为其他字体：

#list(indent: 2em)[
  Times New Roman：英文衬线字体。
][
  Source Han Serif SC：思源宋体#footnote[https://github.com/adobe-fonts/source-han-serif]，开源的中文衬线字体。
][
  Ubuntu Mono：等宽字体，适合代码显示、终端界面等场景。
][
  KaiTi：楷体。
][
  Source Han Sans SC：思源黑体#footnote[https://github.com/adobe-fonts/source-han-sans]，开源的中文无衬线字体。
][
  FZXiaoBiaoSong-B05S：方正小标宋字体，字形工整秀丽，常用于公文标题、标牌等正式场合。
]

== Typst语法

官方文档：https://typst.app/docs/

LaTeX和Typst的一些对应关系：https://tug.ctan.org/info/typstfun/typstfun.pdf

其他资料：https://gist.github.com/NMNMCC/f3409d33db1ce9b6185c6a2892468f71

https://github.com/qjcg/awesome-typst


= 其他实用工具推荐

== 流程图、框图绘制

=== Draw.io

使用Draw.io绘制流程图，保存为`.drawio.png`后缀的可编辑位图文件，这样可以直接在Typst文档中导入，不必额外导出PNG文件。如果直接导入的图片比较模糊，可以修改draw.io文件属性中的缩放（从100%调到200%或者300%）。

=== fletcher
fletcher#footnote[https://typst.app/universe/package/fletcher/]是一个基于CeTZ（类似于TikZ的Typst绘图库）的绘图库，CeTZ本身用起来比较繁琐，效率较低，
用这个库更加方便快捷。

#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#figure(
  caption: "使用fletcher绘制的图片",
  diagram(cell-size: 15mm, $
    G edge(f, ->) edge("d", pi, ->>) & im(f) \
    G slash ker(f) edge("ur", tilde(f), "hook-->")
  $)
)<fletcher-img>

#figure(
  caption: [@fletcher-img 所示图片对应的代码],
  ```typ
  #diagram(cell-size: 15mm, $
    G edge(f, ->) edge("d", pi, ->>) & im(f) \
    G slash ker(f) edge("ur", tilde(f), "hook-->")
  $)
  ```
)

== 插入PDF图片

Typst本身不支持插入PDF图片，不过社区中有人实现了插入PDF图片，如果有需要，可以参考：https://typst.app/universe/package/muchpdf/

== 插入Excel表格

插入Excel文件作为表格，参考：https://typst.app/universe/package/rexllent/

== 插入LaTeX公式

Typst的公式写法和LaTeX不同，如果需要插入LaTeX格式的公式，可以使用mitex库：https://typst.app/universe/package/mitex/

== 更优美的代码显示

codly库实现了更优美的代码显示，参考：https://typst.app/universe/package/codly/ 

== pdftk

将文档编译为PDF后，可能还需要进行一些额外操作，例如添加水印、PDF加密、PDF拼接等。可以使用pdftk这款工具（推荐安装对应的命令行软件，便于编写脚本来进行自动化操作）。

== Makefile

对于一些复杂的需求，最终的成品往往是由多个部分组成，例如编写好正文部分后需要添加封面和水印，封面和水印则保存在另外的文件中。可以编写一个简单的Makefile来自动化构建，Windows系统上可以使用nmake。

== Git

Typst文档本质上是一个纯文本文件，可以使用Git来进行版本管理。
