#import "../lib/lib.typ": *

= 引用与交叉引用 <sec:refs>

Typst 里引用只有一个语法：`@标签`。文档内部的东西（图、表、公式、定理、章节）
和参考文献都用它，编译器自己判断该显示成什么。

== 交叉引用

给要引用的东西加一个尖括号标签，引用处写 `@标签`。
标签名随便取，但建议加前缀分类，写多了自己找得到。

#figure(
  table(
    columns: 3,
    [对象], [打标签], [引用效果],
    [一级标题], [`= 标题 <sec:refs>`], [@sec:refs],
    [二级标题], [`== 小节 <sec:cross>`], [@sec:cross],
    [图], [`#figure(...) <fig:incline>`], [@fig:incline],
    [表], [`#figure(table(...)) <tab:dim>`], [@tab:dim],
    [公式], [`$ ... $ <eq:faraday>`], [@eq:faraday],
    [代码], [`#figure(..., kind: raw) <code:leapfrog>`], [@code:leapfrog],
    [定理类], [`#theorem[...] <thm:eq>`], [@thm:eq],
  ),
  caption: [各类对象的交叉引用],
) <tab:xref>

== 引用标题的特殊处理 <sec:cross>

标题引用默认只显示一个数字，模板给它补上了「第 X 章 / 第 X.Y 节」的说法：
`@sec:refs` 出来是 @sec:refs，`@sec:cross` 出来是 @sec:cross。
措辞在 `lib/theme.typ` 的 `chapter-ref` 和 `section-ref` 里改。

#tip[
  引用不用管顺序，前后引都行；编号变了也不用手动改。
  编译时如果某个标签找不到，Typst 会直接报错指出位置，不会像 LaTeX 那样
  留个 `??` 让你自己发现。
]

== 文献引用

参考文献放在 `refs.bib`（标准 BibTeX 格式，Zotero、Google Scholar 导出的直接能用），
`main.typ` 末尾用 `#bibliography("refs.bib")` 生成文献表。

引用时同样是 `@标签`，标签就是 bib 条目的 key：

- 单篇：`@einstein1905` → @einstein1905
- 多篇连续写：`@dirac1928 @verlet1967` → @dirac1928 @verlet1967
- 带页码等补充：`#cite(<landau-mechanics>, supplement: [§ 15])` →
  #cite(<landau-mechanics>, supplement: [§ 15])
- 把作者写进句子里（`form: "prose"`）：
  #cite(<griffiths-em>, form: "prose") 里对这个问题有详细讨论。
- 中文文献一样用：@zeng-qm

只有被引用过的条目才会出现在文献表里。想把 `.bib` 全部列出来，
在 `main.typ` 里写 `#bibliography("refs.bib", full: true)`。

== 换文献样式

默认是国标顺序编码制 `gb-7714-2015-numeric`。在 `main.typ` 的 `note(...)` 里
加一行 `bib-style: "..."` 就能换：

#figure(
  table(
    columns: 2,
    [样式名], [说明],
    [`gb-7714-2015-numeric`], [国标 2015，顺序编码制（默认）],
    [`gb-7714-2015-author-date`], [国标 2015，著者-出版年制],
    [`gb-7714-2005-numeric`], [国标 2005，顺序编码制],
    [`ieee`], [IEEE，物理和工程期刊常用],
    [`american-physics-society`], [APS，投 PRL / PRB 用],
    [`nature`], [Nature],
  ),
  caption: [几个常用的文献样式],
)

Typst 内置了 CSL 样式库，完整列表见官方文档的 `bibliography` 一节；
也可以自己塞一个 `.csl` 文件进去：`bib-style: "my-style.csl"`。

#warning(title: "作者名的大小写")[
  国标样式会把西文作者姓氏转成全大写，这是 GB/T 7714 的要求，不是排版出错。
  如果投的是英文期刊，换成 `ieee` 或 `american-physics-society`。
]
