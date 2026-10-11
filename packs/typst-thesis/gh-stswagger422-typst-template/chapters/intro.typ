// 导入公共模块和配置
// 本章节为示例教程，展示如何使用模板编写正文、插图、表格与引用。
// 参考指南项：正文格式见《写作指南》2.3.9（正文），页8-9；图表编号与题注、三线表与续表见《写作指南》2.3.19（图、表和表达式），页12-13；引用格式与参考文献见《写作指南》第3章（3.4–3.5），页20-21。
#import "_common.typ":*
#show: doc => chapter_conf(settings, doc: doc)

#let main = [
  = 简要教程

  // #emoji.face.monocle 建议将本教程的源码和PDF预览结合食用

  == 初始化
  我的

  === 字体设置

  论文的基础信息设置与正文以外的内容请前往 `metadata.typ` 填写。开始前请务必在此处配置字体，消除字体相关警告。#footnote([#lorem(20)中文])


  == #lorem(20)

  使用等号衔接空格标记标题，等号数量对应标题等级等级，例如：`= 一级标题（章节标题）`、`== 二级标题`，以此类推。

  == 正文

  普通文本（Regular Text）。
  两侧添加星号显示为*加粗文本（Bold text）*。
  两侧添加下划线将中文显示为_楷体_，西文显示为斜体/意大利体（_Italic Text_）。
  两侧添加反单引号显示为行内代码（`Inline Code`）样式。
  两侧添加Dollar符号显示为数学公式 $dot(z) = 6$ 。
  两侧添加斜杠和星号，不显示/*被包含在其中的*/文本。 //在文本前添加双斜杠也可以做到。

  分段应空行，而不是简单换行。

  上下标使用`#super[]`和`#sub[]`实现，例如：#super[上标] #sub[下标]

  特殊符号使用`#sym.xxx`输入，详见https://typst.app/docs/reference/symbols/sym/


  == 图片

  简单图片可以使用 `#tupian()` 添加，如 @图片示例 所示。该函数支持便捷地添加说明文本（figure legend），且图片本体与图题、说明文本不会跨页。

  #tupian(
    body: "images/tupianhint.png",
    width: 70%,
    caption: [图题],
    legend: [#lorem(3)],
    label: <图片示例>,
  ) // width, legend 和 label可以不填

  更复杂的图片排版请使用原生的`#figure()`函数搭配`#image()`函数实现，详见 https://typst.app/docs/reference/model/figure/。两种方式添加的图片编号互通。

  == 表格

  简单表格片可以使用 `#biaoge()` 添加，如@表格示例 所示。该函数支持使用Markdown语法便捷地生成三线表（Powered by `tablem`），且跨页自动生成续表题。

  #biaoge(
    caption: [表题],
    body: [
      | *`#biaoge()` 参数名*          | *示例*                  |
      | ---------------------------- | ----------------------- |
      | `caption:`                   | `[Some caption]`        |
      | `body:`                      | `[Markdown-like table]` |
      | `label:`                     | `<Some_Label>`          |
      | ^/*垂直(^)或水平(<)合并单元格*/ | or no label             |
    ],
    label: <表格示例>,
  )

  更复杂的表格排版请使用原生的`#figure()`函数搭配`#table()`函数实现。两种方式添加的表格编号互通。

  == 引用

  === 提及本文内容 <提及>

  为了防止正文中小节、表格、图片等编号与实际内容不对应的情况发生，行文时提及被编号的内容应当避免直接输入其编号，而应首先在被提及的内容后使用尖括号 `< >` 添加标签，然后在提及他们的地方使用 `@` 来引用标签。例如：本节是 @提及

  === 引用参考文献

  在你的内容管理软件（推荐Zotero，搭配Better BibTeX插件）中将文献库导出为BibLaTeX格式，粘贴到 `ref.bib` 中，然后在正文中使用 `@` 来引用即可。例如：我在此引用两篇AlphaFold的论文 @AF2 @AF3。

  Zotero导出时，如果引文期刊名称需要缩写，请勾选使用缩写的期刊名。

  引用文献的格式可以在 `metadata.typ` 中设置。详见 https://typst.app/docs/reference/model/bibliography/#parameters-style


  == 特殊名词格式

  对于一些需要特殊格式或包含特殊字符的名词，逐个调整或输入费时费力。可以使用`#show`规则来统一设置格式，简化输入。例如：
  #[
    #set align(center)

    *Before*: Drosophila melanogaster, EcoRI, NF-κB, Lgr5Δ/+

    #show "Dmel": [_Drosophila melanogaster_]
    #show "EcoRI": [#emph[Eco]RI] // 不能直接使用形如 _Eco_RI 的方法来使一个词的一部分斜体
    #show "NF-kappaB": [NF-] + sym.kappa + [B] // κ不方便直接输入
    #show regex("(?i)Lgr5-del"): [_Lgr5_#super[#sym.Delta/+]] // 使用正则表达式 regex("(?i)xxxxx") 来不区分大小写地匹配字符串

    *After*: Dmel, EcoRI, NF-kappaB, lgr5-del

  ]

]

#main
#bibliography("../ref.bib", style: settings.参考文献格式)
