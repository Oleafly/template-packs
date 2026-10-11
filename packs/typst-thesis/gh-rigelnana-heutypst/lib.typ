#import "src/utils.typ": font-size, font-family, cjk-fill, fixed-leading, show-cn-fakebold
#import "src/styles.typ": *
#import "src/pages/cover.typ": cover-page
#import "src/pages/titlepage.typ": title-page
#import "src/pages/abstract-zh.typ": abstract-zh
#import "src/pages/abstract-en.typ": abstract-en
#import "src/pages/outline.typ": outline-page
#import "src/pages/conclusion.typ": conclusion-page
#import "src/pages/bibliography.typ": bibliography-page
#import "src/pages/achievements.typ": achievements-page
#import "src/pages/acknowledgement.typ": acknowledgement-page
#import "src/pages/appendix.typ": appendix-page
#import "src/pages/spine.typ": spine-page

/// 哈尔滨工程大学本科生毕业论文模板
///
/// 参数说明：
/// - title: 中文论文题目
/// - title-en: 英文论文题目
/// - author: 作者姓名
/// - student-id: 学号
/// - classification: 密级（默认"公开"）
/// - department: 学院名称
/// - major: 专业名称
/// - supervisor: 指导教师姓名
/// - supervisor-title: 指导教师职称
/// - supervisor-dept: 指导教师所在单位
/// - submit-date: 论文提交日期
/// - defense-date: 论文答辩日期
/// - degree-unit: 学位授予单位（默认"哈尔滨工程大学"）
/// - date: 封面日期（默认当天）
/// - abstract-zh-keywords: 中文关键词数组
/// - abstract-zh-body: 中文摘要内容
/// - abstract-en-keywords: 英文关键词数组
/// - abstract-en-body: 英文摘要内容
/// - conclusion: 结论内容
/// - bib-file: 参考文献 .bib 文件路径
/// - achievements: 学术成果内容（none 则不生成）
/// - acknowledgement: 致谢内容
/// - show-spine: 是否生成书脊页（默认 true）
/// - body: 正文内容
#let heuthesis(
  // 论文基本信息
  title: "",
  title-en: "",
  author: "",
  student-id: "",
  classification: "公开",
  department: "",
  major: "",
  supervisor: "",
  supervisor-title: "",
  supervisor-dept: "",
  submit-date: "",
  defense-date: "",
  degree-unit: "哈尔滨工程大学",
  date: datetime.today(),
  // 摘要
  abstract-zh-keywords: (),
  abstract-zh-body: [],
  abstract-en-keywords: (),
  abstract-en-body: [],
  // 结论
  conclusion: [],
  // 参考文献
  bib-file: none,
  // 学术成果
  achievements: none,
  // 致谢
  acknowledgement: [],
  // 附录（content 或 none）
  appendix: none,
  // 书脊
  show-spine: true,
  // 正文
  body,
) = {
  // ===== 全局设置 =====
  set document(title: title, author: author)
  set text(font: font-family.songti, size: font-size.xiaosihao, lang: "zh", region: "cn")
  set par(first-line-indent: (amount: 2em, all: true), leading: 22pt - 1em, justify: true)
  // 列表样式：悬挂缩进对齐，行距与正文一致
  set enum(indent: 2em, body-indent: 0.5em, numbering: "（1）", spacing: 22pt - 1em)
  set list(indent: 2em, body-indent: 0.5em, spacing: 22pt - 1em)

  // ===== 封面（无页码） =====
  cover-page(
    title: title,
    student-id: student-id,
    classification: classification,
    department: department,
    major: major,
    author: author,
    supervisor: supervisor,
    date: date,
  )

  // ===== 扉页（无页码） =====
  title-page(
    title: title,
    title-en: title-en,
    student-id: student-id,
    classification: classification,
    author: author,
    department: department,
    major: major,
    supervisor: supervisor,
    supervisor-title: supervisor-title,
    supervisor-dept: supervisor-dept,
    submit-date: submit-date,
    defense-date: defense-date,
    degree-unit: degree-unit,
  )

  // ===== 前置部分（罗马数字页码） =====
  set page(
    paper: "a4",
    margin: (top: 28mm, bottom: 28mm, left: 25mm, right: 25mm),
    numbering: "I",
    number-align: center + bottom,
    header: {
      set text(font: font-family.songti, size: font-size.wuhao)
      set par(spacing: 0pt)
      set block(spacing: 0pt)
      align(center, even-header-content)
      header-line()
    },
  )
  counter(page).update(1)

  // 中文摘要
  abstract-zh(keywords: abstract-zh-keywords, abstract-zh-body)

  // 英文摘要
  abstract-en(keywords: abstract-en-keywords, abstract-en-body)

  // 目录
  outline-page()

  // ===== 正文部分（阿拉伯数字页码） =====
  set heading(numbering: "1.1.1.1")
  set page(
    numbering: "1",
    header: context {
      set text(font: font-family.songti, size: font-size.wuhao)
      set par(spacing: 0pt)
      set block(spacing: 0pt)
      let page-num = counter(page).get().first()
      if calc.odd(page-num) {
        // 单页：正文章节显示"第X章 名"，其余显示论文题名
        let headings = query(heading.where(level: 1))
        let current-headings = headings.filter(h => h.location().page() <= here().page())
        if current-headings.len() > 0 {
          let current = current-headings.last()
          let chap-num = counter(heading).at(current.location()).first()
          if chap-num > 0 {
            // 有编号的正文章节
            align(center)[第#chap-num 章#h(0.5em)#current.body]
          } else {
            // 无编号章节（结论、致谢等）：显示论文题名
            align(center, title)
          }
        } else {
          align(center, title)
        }
      } else {
        // 双页：固定文字
        align(center, even-header-content)
      }
      header-line()
    },
  )
  counter(page).update(1)

  // 标题样式
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    v(22pt)
    set text(font: font-family.heiti, size: font-size.xiaoerhao)
    set par(leading: 22pt - 1em, justify: false)
    align(center)[第#numbering("1", ..counter(heading).get())章#h(0.5em)#it.body]
    v(22pt)
  }
  show heading.where(level: 2): it => {
    v(11pt)
    set text(font: font-family.heiti, size: font-size.xiaosanhao)
    set par(leading: 22pt - 1em, justify: false, first-line-indent: 0pt)
    [#numbering("1.1", ..counter(heading).get())#h(0.5em)#it.body]
    v(11pt)
  }
  show heading.where(level: 3): it => {
    v(11pt)
    set text(font: font-family.heiti, size: font-size.sihao)
    set par(leading: 22pt - 1em, justify: false, first-line-indent: 0pt)
    [#numbering("1.1.1", ..counter(heading).get())#h(0.5em)#it.body]
    v(11pt)
  }
  show heading.where(level: 4): it => {
    v(11pt)
    set text(font: font-family.heiti, size: font-size.xiaosihao)
    set par(leading: 22pt - 1em, justify: false, first-line-indent: 0pt)
    [#numbering("1.1.1.1", ..counter(heading).get())#h(0.5em)#it.body]
    v(11pt)
  }

  // 图表编号
  set figure(numbering: (..nums) => {
    let chapter = counter(heading).get().first()
    numbering("1.1", chapter, ..nums)
  })
  // 图表标题：图序/表序与题目间空一字符
  set figure.caption(separator: h(1em))

  // === 表格样式 ===
  // 表题置于表上居中，小4号宋体
  show figure.where(kind: table): set figure.caption(position: top)
  // 三线表（开放式），表内文字5号宋体居中，行距18磅，总宽度100%
  show figure.where(kind: table): it => {
    set text(font: font-family.songti, size: font-size.wuhao)
    set par(leading: 18pt - 1em, justify: false)
    set align(center)
    block(above: 11pt, below: 11pt, {
      // 表题用小4号宋体
      text(font: font-family.songti, size: font-size.xiaosihao, it.caption)
      v(5pt)
      block(width: 100%, it.body)
    })
  }
  show table: set text(font: font-family.songti, size: font-size.wuhao)
  show table: set par(leading: 18pt - 1em)
  set table(
    align: center + horizon,
    stroke: none,
    inset: (x: 5pt, y: 4pt),
  )

  // === 图片样式 ===
  // 图题置于图下，小4号宋体，居中
  show figure.where(kind: image): it => {
    set align(center)
    block(above: 11pt, below: 11pt, {
      it.body
      v(5pt)
      text(font: font-family.songti, size: font-size.xiaosihao, it.caption)
    })
  }

  // 公式编号
  set math.equation(numbering: (..nums) => {
    let chapter = counter(heading).get().first()
    "(" + str(chapter) + "-" + str(nums.pos().first()) + ")"
  })
  // 公式前后间距（确保公式作为独立段落）
  show math.equation.where(block: true): set block(above: 1em, below: 1em)

  // 引用样式：上标，方括号，小4号
  show ref: it => {
    if it.element != none and it.element.func() == figure {
      it
    } else {
      it
    }
  }
  show cite: it => {
    super(it)
  }

  body

  // ===== 结论 =====
  conclusion-page(conclusion)

  // ===== 参考文献 =====
  if bib-file != none {
    bibliography-page(bib-file)
  }

  // ===== 学术成果 =====
  if achievements != none {
    achievements-page(achievements)
  }

  // ===== 致谢 =====
  acknowledgement-page(acknowledgement)

  // ===== 附录 =====
  if appendix != none {
    appendix
  }

  // ===== 书脊 =====
  if show-spine {
    spine-page(title: title, author: author)
  }
}
