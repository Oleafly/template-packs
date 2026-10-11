// ============================================================
// 复旦大学学位论文 Typst 模板 - 主入口 (Facade)
// 支持：本科、硕士（学术/专业）、博士（学术/专业）
// 遵循：《复旦大学博士、硕士学位论文规范（2026 年 6 月修订版）》
// ============================================================

#import "config.typ": *
#import "utils.typ": *
#import "styles.typ": *
#import "pages/cover.typ": cover-page
#import "pages/declaration.typ": declaration-page
#import "pages/committee.typ": committee-page
#import "pages/abstract-zh.typ": abstract-zh-page
#import "pages/abstract-en.typ": abstract-en-page
#import "pages/outline-page.typ": outline-page, list-of-figures-page, list-of-tables-page
#import "pages/notation-page.typ": notation-page

// 生成可被目录和 PDF 书签捕获、但不在正文中重复显示的前置条目。
#let outline-marker(title) = {
  show heading: it => []
  heading(level: 1, numbering: none, outlined: true, bookmarked: true, title)
}

// 默认论文信息
#let default-info = (
  title: "论文题目",
  title-en: "Thesis Title",
  author: "作者姓名",
  student-id: "00000000000",
  school: "培养单位名称",
  major: "专业名称",
  supervisor: "导师姓名　教授",
  supervisor-second: none,
  degree: "doctor",
  degree-category: none,
  secret-level: none,
  equivalent-education: false,
  english-program: false,
  date: datetime.today(),
  clc: none,
)

// ============================================================
// 主模板函数
// ============================================================
#let thesis(
  info: (:),
  abstract-zh: [],
  keywords-zh: (),
  abstract-en: [],
  keywords-en: (),
  blind: false,
  twoside: true,
  outline-depth: 3,
  list-of-image: false,
  list-of-table: false,
  bibliography-content: none,
  acknowledgements: none,
  appendix: none,
  committee: none,
  notation: none,
  body,
) = {
  // 合并用户信息与默认值
  let info = default-info + info

  // 支持命令行参数覆盖
  let blind = parse-bool(sys.inputs.at("blind", default: none), blind)
  let twoside = parse-bool(sys.inputs.at("twoside", default: none), twoside)

  // 规范中可机检的限制尽量在编译时拦截。空摘要允许用于起草。
  assert(("bachelor", "master", "doctor").contains(info.degree),
    message: "degree 必须为 bachelor、master 或 doctor")
  assert(info.title.clusters().len() <= 30,
    message: "根据 2026 年规范，中文论文题目应不超过 30 个汉字")
  assert(keywords-zh.len() == 0 or (keywords-zh.len() >= 3 and keywords-zh.len() <= 8),
    message: "中文关键词应为 3–8 个")
  assert(keywords-en.len() == 0 or (keywords-en.len() >= 3 and keywords-en.len() <= 8),
    message: "英文关键词应为 3–8 个")

  // ========================================================
  // 全局文档元数据
  // ========================================================
  set document(
    title: info.title,
    author: if blind { () } else { info.author },
    description: "复旦大学学位论文（" + specification-version + "）",
  )

  // ========================================================
  // 全局页面设置（A4，Word 默认页边距）
  // ========================================================
  set page(
    paper: "a4",
    margin: page-margin,
  )

  // ========================================================
  // 全局文本设置
  // 规范：正文宋体、小四号、标准字符间距、行距20磅
  // ========================================================
  set text(
    font: font-family.宋体,
    size: font-size.小四,
    lang: "zh",
    region: "cn",
  )

  set par(
    first-line-indent: 2em,
    leading: body-leading,
    justify: true,
  )

  // ========================================================
  // 标题样式
  // 一级：居中、黑体、三号、加粗，前后间距
  // 二级：黑体、四号、加粗
  // 三级：黑体、小四、加粗
  // ========================================================
  set heading(numbering: chinese-numbering)

  show heading: it => {
    set par(first-line-indent: 0em)

    if it.level == 1 {
      // 规范要求每章另起页；只有正文首页强制从右页开始。
      pagebreak(weak: true)
      // 图、表、式均按章重新编号。
      counter(figure.where(kind: image)).update(0)
      counter(figure.where(kind: table)).update(0)
      counter(math.equation).update(0)
      v(10pt)
      set text(font: font-family.黑体, size: font-size.三号, weight: "bold")
      set align(center)
      if it.numbering != none {
        counter(heading).display(it.numbering)
        h(0.5em)
      }
      it.body
      v(20pt)
    } else if it.level == 2 {
      v(10pt)
      set text(font: font-family.黑体, size: font-size.四号, weight: "bold")
      if it.numbering != none {
        counter(heading).display(chinese-numbering)
        h(0.5em)
      }
      it.body
      v(8pt)
    } else if it.level == 3 {
      v(6pt)
      set text(font: font-family.黑体, size: font-size.小四, weight: "bold")
      if it.numbering != none {
        counter(heading).display(chinese-numbering)
        h(0.5em)
      }
      it.body
      v(4pt)
    } else {
      v(4pt)
      set text(font: font-family.黑体, size: font-size.小四)
      if it.numbering != none {
        counter(heading).display(chinese-numbering)
        h(0.5em)
      }
      it.body
      v(2pt)
    }
  }

  // ========================================================
  // 图编号：图 1-1（按章编号）
  // ========================================================
  set figure(gap: 1em)

  show figure.caption: it => {
    set text(font: font-family.宋体, size: font-size.五号)
    it
  }

  set figure.caption(separator: " ")

  show figure.where(kind: image): set figure(
    numbering: (..nums) => {
      context {
        let chapter = counter(heading).get().first()
        let prefix = if appendix-mode.get() { numbering("A", chapter) } else { str(chapter) }
        prefix + "-" + str(nums.pos().first())
      }
    },
    supplement: [图],
  )

  // 表编号：表 1-1（按章编号）
  show figure.where(kind: table): set figure(
    numbering: (..nums) => {
      context {
        let chapter = counter(heading).get().first()
        let prefix = if appendix-mode.get() { numbering("A", chapter) } else { str(chapter) }
        prefix + "-" + str(nums.pos().first())
      }
    },
    supplement: [表],
  )

  // 表格标题置于表格上方
  show figure.where(kind: table): set figure.caption(position: top)

  // ========================================================
  // 公式编号：(1-1)（按章编号）
  // ========================================================
  set math.equation(numbering: (..nums) => {
    context {
      let chapter = counter(heading).get().first()
      let prefix = if appendix-mode.get() { numbering("A", chapter) } else { str(chapter) }
      "(" + prefix + "-" + str(nums.pos().first()) + ")"
    }
  })

  // ========================================================
  // 列表样式
  // ========================================================
  set enum(indent: 2em, body-indent: 0.5em)
  set list(indent: 2em, body-indent: 0.5em)

  // ========================================================
  // 代码块样式
  // ========================================================
  show raw.where(block: true): it => {
    set text(font: font-family.等宽, size: font-size.五号)
    set par(first-line-indent: 0em)
    block(
      width: 100%,
      fill: luma(245),
      inset: 10pt,
      radius: 3pt,
      it,
    )
  }

  show raw.where(block: false): it => {
    set text(font: font-family.等宽)
    it
  }

  // ========================================================
  // 第一部分：封面
  // ========================================================
  appendix-mode.update(false)
  cover-page(info, blind: blind)

  // ========================================================
  // 第二部分：扉页（指导小组成员名单，可选）
  // ========================================================
  if committee != none and not blind {
    pagebreak()
    committee-page(info, committee-members: committee)
  }

  if twoside { pagebreak(to: "odd") }

  // ========================================================
  // 第三部分：前置内容（目录、摘要、图表清单）
  // ========================================================
  set page(
    header: make-header(info: info, twoside: twoside),
    footer: make-front-footer(),
  )

  counter(page).update(1)

  // 目录（规范要求位于中英文摘要之前）
  heading(level: 1, numbering: none, outlined: false, bookmarked: true)[目#h(1em)录]
  outline-page(depth: outline-depth)

  pagebreak()

  // 中文摘要：附件三样式为“题目 + 摘要： + 正文 + 关键词”
  outline-marker([摘要])
  abstract-zh-page(
    title: info.title,
    abstract-body: abstract-zh,
    keywords: keywords-zh,
  )

  pagebreak()

  // 英文摘要
  outline-marker([Abstract])
  abstract-en-page(
    title: info.title-en,
    abstract-body: abstract-en,
    keywords: keywords-en,
  )

  // 插图目录（可选）
  if list-of-image {
    pagebreak()
    heading(level: 1, numbering: none, outlined: true, bookmarked: true)[插图目录]
    list-of-figures-page()
  }

  // 表格目录（可选）
  if list-of-table {
    pagebreak()
    heading(level: 1, numbering: none, outlined: true, bookmarked: true)[表格目录]
    list-of-tables-page()
  }

  // 主要符号对照表（可选）
  if notation != none {
    pagebreak()
    heading(level: 1, numbering: none, outlined: true, bookmarked: true)[主要符号对照表]
    notation-page(notation)
  }

  // ========================================================
  // 第五部分：正文（阿拉伯数字页码）
  // ========================================================
  if twoside { pagebreak(to: "odd") } else { pagebreak() }
  set page(
    header: make-body-header(info: info),
    footer: make-footer(),
  )

  counter(page).update(1)
  counter(heading).update(0)
  counter(figure.where(kind: image)).update(0)
  counter(figure.where(kind: table)).update(0)
  counter(math.equation).update(0)

  body

  // ========================================================
  // 第六部分：参考文献
  // 格式须符合 GB/T 7714—2015
  // ========================================================
  if bibliography-content != none {
    if twoside { pagebreak(to: "odd") } else { pagebreak() }
    {
      set text(font: font-family.宋体, size: font-size.五号)
      set par(first-line-indent: 0em)
      bibliography-content
    }
  }

  // ========================================================
  // 第七部分：附录（可选）
  // ========================================================
  if appendix != none {
    if twoside { pagebreak(to: "odd") } else { pagebreak() }
    appendix-mode.update(true)
    set heading(numbering: appendix-numbering)
    counter(heading).update(0)
    appendix
  }

  // ========================================================
  // 第八部分：致谢（非盲审时显示）
  // ========================================================
  if acknowledgements != none and not blind {
    if twoside { pagebreak(to: "odd") } else { pagebreak() }
    heading(level: 1, numbering: none, outlined: true, bookmarked: true)[致#h(1em)谢]
    set text(font: font-family.宋体, size: font-size.小四)
    set par(first-line-indent: 2em, leading: body-leading, justify: true)
    acknowledgements
  }

  // ========================================================
  // 第九部分：独创性声明与授权声明（非盲审，页眉页脚为空）
  // ========================================================
  if not blind {
    pagebreak()
    declaration-page(twoside: twoside)
  }
}
