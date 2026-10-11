// ============================================================
// tjutthesis.typ
// 天津理工大学本科毕业设计说明书（毕业论文）Typst 模版
// 依据：《天津理工大学本科毕业设计说明书（毕业论文）撰写规范(2025)》
//
// 编译：typst compile --font-path ./fonts main.typ
//      （typst.app 网页版：把 fonts/ 里的字体文件一并上传即可）
//
// 本模版只覆盖：标题/摘要/关键词、目录、正文、参考文献、附录、致谢。
// 封皮、首页、原创性声明、选题审批表、任务书、开题报告、底图
// 使用教务处统一模板，单独制作后合并装订。
//
// Copyright (c) 2026 seatres (https://github.com/seatres)
// 本模版依据 LaTeX Project Public License 1.3c（或更新版本）发布；
// 当前维护者 seatres (https://github.com/seatres)，许可全文见 LICENSE。
// 注意：本许可不含、也不授权任何第三方字体（中易 宋/黑/楷/仿宋、Times
//       New Roman 等）；字体版权归各自所有者，获取方式见 fonts/README.md。
// ============================================================

// ---------- 中文字号 -> 磅值 ----------
#let zihao = (
  erhao: 22pt,    // 二号
  sanhao: 16pt,   // 三号
  xiaosan: 15pt,  // 小三
  sihao: 14pt,    // 四号
  xiaosi: 12pt,   // 小四
  wuhao: 10.5pt,  // 五号
  xiaowu: 9pt,    // 小五
)

// ---------- 字体（西文 Times New Roman，中文中易字体） ----------
#let songti   = ("Times New Roman", "SimSun")
#let heiti    = ("Times New Roman", "SimHei")
#let kaiti    = ("Times New Roman", "KaiTi")
#let fangsong = ("Times New Roman", "FangSong")

// ---------- 行距（按 Word 行为精确校准） ----------
// Word 单倍行距 = 宋体度量 (winAscent+winDescent+externalLeading)/upm
//              = 292/256 = 1.1406em（旁证：五号 10.5pt 单倍 ≈ 12 磅）
// Typst 基线距 = 行盒高 + leading；行盒高实测：宋 0.684em / 黑 0.688em /
// 楷 0.688em / Times New Roman 0.662em。故 leading = 目标行距 − 行盒高。
#let leading-1-25 = 0.742em        // 1.25 倍：1.25×1.1406em − 0.684em（小四实测基线距 17.11pt）
#let leading-1-5  = 1.023em        // 1.5 倍（标题黑体）：1.5×1.1406em − 0.688em
#let abstract-leading = 20pt - 0.688em     // 中文摘要固定 20 磅（楷体）
#let en-abstract-leading = 20pt - 0.662em  // 英文摘要固定 20 磅（Times New Roman）
#let appendix-leading = 18pt - 0.684em     // 附录固定 18 磅（宋体五号）

// ============================================================
// 全文设置：#show: tjut-thesis.with(grad-year: "2026", ...)
// ============================================================
#let tjut-thesis(
  grad-year: "XXXX",
  doc,
) = {
  set page(paper: "a4", margin: 2.5cm)                    // A4，页边距 2.5cm
  set text(font: songti, size: zihao.xiaosi, lang: "zh")  // 正文小四宋体
  set par(
    leading: leading-1-25,                                // 1.25 倍行距
    spacing: leading-1-25,                                // 段间不额外加距（同 Word）
    first-line-indent: (amount: 2em, all: true),          // 段首缩进两个汉字
    justify: true,
  )

  // ---------- 章节标题 ----------
  // 章：第一章（中文数字）；节/小节：1.1 / 1.1.1
  set heading(numbering: (..nums) => {
    let n = nums.pos()
    if n.len() == 1 { numbering("第一章", ..n) }
    else { numbering("1.1", ..n) }
  })

  // ---- 标题与上下文的间距（按学校 Word 模板精确换算） ----
  // 依据基准 docx 样式：标题 1.5 倍行距（line=360/auto）、段前段后 0。
  // Word 把行距加在文字上方，故基线距需计入相邻两行字体下伸差
  // （中易字体下伸 = 0.1406em：三号 2.25pt / 小三 2.11pt / 四号 1.97pt / 小四 1.69pt）：
  //   上一段正文基线→标题基线 = 正文下伸 + 标题行高(1.5×1.1406em×字号) − 标题下伸
  //   标题基线→下一段正文基线 = 标题下伸 + 正文行高(17.11pt) − 正文下伸
  // Typst 换算：above = 目标 − 标题行盒(0.688em×字号)；below = 目标 − 正文行盒(8.2pt)
  //   三号16pt: above = 26.81−11.01 = 15.8pt   below = 17.67−8.2 = 9.5pt
  //   小三15pt: above = 25.24−10.32 = 14.9pt   below = 17.53−8.2 = 9.3pt
  //   四号14pt: above = 23.67−9.63  = 14.0pt   below = 17.39−8.2 = 9.2pt
  // 注：Word 的「文档网格」若开启会再抬大实际行距，但网格非规范条款且
  // 各文档取值不一，本模版按规范语义的纯倍数模型执行。

  // 章标题：三号黑体居中，每章另起一页，1.5 倍行距；
  // 章序号与标题之间空一个汉字；并重置本章图/表/公式计数
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(math.equation).update(0)
    set par(leading: leading-1-5, first-line-indent: 0pt)
    block(above: 15.8pt, below: 9.5pt, width: 100%,
      align(center, text(font: heiti, size: zihao.sanhao, weight: "regular", {
        if it.numbering != none {
          counter(heading).display(it.numbering)
          h(1em)
        }
        it.body
      })))
  }

  // 节标题：小三号黑体居中；序号与标题之间空一个西文字符
  show heading.where(level: 2): it => {
    set par(leading: leading-1-5, first-line-indent: 0pt)
    block(above: 14.9pt, below: 9.3pt, width: 100%,
      align(center, text(font: heiti, size: zihao.xiaosan, weight: "regular", {
        counter(heading).display(it.numbering)
        h(0.3em)
        it.body
      })))
  }

  // 小节标题：四号黑体左起
  show heading.where(level: 3): it => {
    set par(leading: leading-1-5, first-line-indent: 0pt)
    block(above: 14.0pt, below: 9.2pt, width: 100%,
      text(font: heiti, size: zihao.sihao, weight: "regular", {
        counter(heading).display(it.numbering)
        h(0.3em)
        it.body
      }))
  }

  // ---------- 图、表 ----------
  // 编号按章：图 3.2 / 表 5.4
  set figure(numbering: (..nums) => context {
    let ch = counter(heading).get().first()
    numbering("1.1", ch, ..nums.pos())
  })
  show figure.where(kind: image): set figure(supplement: [图])
  show figure.where(kind: table): set figure(supplement: [表])
  show figure.where(kind: table): set figure.caption(position: top) // 表题在表上方
  show figure.where(kind: table): set text(size: zihao.wuhao)      // 表内文字五号
  // 图题后空一行、表格后空一行再续正文（规范二9②③）：
  // 目标基线距 = 两个正文行高 34.2pt；换算为外层 block 的 below 间隙
  // （图题底边=基线：34.2−8.2=26pt；表底边在末行基线下约 5pt：34.2−5−8.2=21pt）
  show figure.where(kind: image): it => block(below: 26pt, it)
  show figure.where(kind: table): it => block(below: 21pt, it)
  show figure.caption: set text(font: kaiti, size: zihao.wuhao)    // 图题表题五号楷体
  set figure.caption(separator: h(1em))                            // 编号后空一格

  // ---------- 公式 ----------
  // 编号按章 (4.2)，标注于所在行最右边（Typst 自动靠右）
  set math.equation(numbering: (..nums) => context {
    let ch = counter(heading).get().first()
    numbering("(1.1)", ch, ..nums.pos())
  })

  doc
}

// ============================================================
// 中文标题 / 摘要 / 关键词（规范二7）
// 用法：#cn-abstract(title: "标题", keywords: ("a", "b"))[摘要正文]
//       两人以上课题加 subtitle: "副标题"
// ============================================================
#let cn-abstract(title: "", subtitle: none, keywords: (), body) = {
  set par(first-line-indent: (amount: 2em, all: true), justify: true)
  // 标题：黑体二号居中（不超过 36 个汉字）
  align(center, par(leading: leading-1-5,
    text(font: heiti, size: zihao.erhao, title)))
  // 副标题：楷体三号，空一行
  if subtitle != none {
    v(1em)
    align(center, text(font: kaiti, size: zihao.sanhao, [——#subtitle]))
  }
  // 标题后空一行，黑体三号居中“摘 要”（中间空一个汉字）
  v(1em)
  align(center, text(font: heiti, size: zihao.sanhao, [摘#h(1em)要]))
  v(0.5em)
  // 摘要正文：楷体四号，行距固定 20 磅，300–800 字
  {
    set text(font: kaiti, size: zihao.sihao)
    set par(leading: abstract-leading, spacing: abstract-leading)
    body
  }
  // 关键词：空一行缩进两个汉字，黑体三号“关键词：”+ 楷体四号，3–8 个
  v(20pt)
  par(first-line-indent: 0pt)[#h(2em)#text(font: heiti, size: zihao.sanhao)[关键词：]#text(font: kaiti, size: zihao.sihao, keywords.join(h(1em)))]
}

// ============================================================
// 英文标题 / 摘要 / 关键词（规范二7）
// 与中文摘要不另起新页，紧随其后使用；每个关键词首字母大写
// ============================================================
#let en-abstract(title: "", subtitle: none, keywords: (), body) = {
  set text(font: songti)
  set par(first-line-indent: (amount: 2em, all: true), justify: true)
  // 空两行后打印英文标题（二号居中加黑）
  v(2em)
  align(center, par(leading: leading-1-5,
    text(size: zihao.erhao, weight: "bold", title)))
  // 空一行打印英文副标题（三号）
  if subtitle != none {
    v(1em)
    align(center, text(size: zihao.sanhao, [——#subtitle]))
  }
  // 空一行，居中三号加黑 ABSTRACT
  v(1em)
  align(center, text(size: zihao.sanhao, weight: "bold", "ABSTRACT"))
  v(0.5em)
  // 英文摘要：四号，行距固定 20 磅
  {
    set text(size: zihao.sihao)
    set par(leading: en-abstract-leading, spacing: en-abstract-leading)
    body
  }
  // Key Words：加黑三号 + 四号关键词
  v(20pt)
  par(first-line-indent: 0pt)[#text(size: zihao.sanhao, weight: "bold")[Key Words: ]#text(size: zihao.sihao, keywords.join(h(1em)))]
}

// ============================================================
// 目录（规范二8）：“目  录”三号黑体居中（中间空四格）；
// 章名黑体四号，节/小节小四宋体，“……”连接页码，页码右对齐
// ============================================================
#let toc() = {
  pagebreak(weak: true)
  align(center, text(font: heiti, size: zihao.sanhao, [目#h(2em)录]))
  v(2em)
  // 目录条目行距同正文 1.25 倍（标题行除外）；em 按各条目字号解析，
  // 章条目（四号）与节/小节条目（小四）的基线距分别为 ~20pt / 17.11pt
  set par(leading: leading-1-25, spacing: leading-1-25, first-line-indent: 0pt)
  show outline.entry.where(level: 1): set text(font: heiti, size: zihao.sihao)
  show outline.entry.where(level: 2): set text(font: songti, size: zihao.xiaosi)
  show outline.entry.where(level: 3): set text(font: songti, size: zihao.xiaosi)
  outline(title: none, depth: 3)
}

// ============================================================
// 正文开始：页码从 1 连续编排（宋体小五居中）；
// 页眉宋体五号居中加页眉线，至致谢结束
// 用法：#show: mainmatter.with(grad-year: "2026")
// ============================================================
#let mainmatter(grad-year: "XXXX", doc) = {
  set page(
    header: align(center,
      stack(spacing: 3pt,
        text(font: songti, size: zihao.wuhao,
          [天津理工大学#grad-year\u{5c4a}本科毕业设计说明书（毕业论文）]),
        line(length: 100%, stroke: 0.4pt))),
    footer: align(center,
      text(font: songti, size: zihao.xiaowu,
        context counter(page).display("1"))),
  )
  counter(page).update(1)
  doc
}

// ============================================================
// 小节内小标题：黑体小四、缩进两个汉字、单列一行（序号 1、2、3……自行书写）
// ============================================================
// （作为普通段落排版，沿用全局的段首缩进两个汉字）
#let minisection(body) = par(text(font: heiti, size: zihao.xiaosi, body))

// 段落标题（如“⑴建模假设”）：宋体加黑小四，置于段首
#let paratitle(body) = text(font: songti, weight: "bold", body)

// ============================================================
// 参考文献（规范二10）：另起一页三号黑体居中；条目小四宋体、
// [1] 连续编号、悬挂缩进 2 字符、1.25 倍行距
// 用法：#references[ + 条目1  + 条目2 ]（每条用 + 开头，自动编号）
// ============================================================
#let references(body) = {
  heading(level: 1, numbering: none)[参考文献]
  set text(size: zihao.xiaosi)
  set par(leading: leading-1-25, spacing: leading-1-25, first-line-indent: 0pt)
  set enum(numbering: "[1]", indent: 0pt, body-indent: 0.5em, spacing: leading-1-25)
  body
}

// ============================================================
// 附录（规范二11）：标题三号黑体居中、自动编号“附录1”；
// 正文 5 号、行距固定 18 磅。单个附录可用 numbered: false 去掉编号
// 用法：#show: appendix   然后 = 附录名
// ============================================================
#let appendix(numbered: true, doc) = {
  counter(heading).update(0)
  set heading(numbering: if numbered {
    (..nums) => {
      let n = nums.pos()
      if n.len() == 1 { numbering("附录1", ..n) }
      else { numbering("1.1", ..n) }
    }
  } else { none })
  set text(size: zihao.wuhao)
  set par(leading: appendix-leading, spacing: appendix-leading)
  doc
}

// ============================================================
// 致谢（规范二12）：另起一页“致  谢”三号黑体居中（中间空两个汉字）；
// 中文小四宋体，1.25 倍行距
// ============================================================
#let acknowledgements(body) = {
  heading(level: 1, numbering: none)[致#h(2em)谢]
  set text(font: songti, size: zihao.xiaosi)
  set par(leading: leading-1-25, spacing: leading-1-25)
  body
}
