// 武汉大学计算机学院课程设计报告 Typst 模板
// 依据：武汉大学计算机学院课程设计报告书写规范（修订版）.doc

// 字体定义 (根据规范要求)
#let font-song = ("SimSun", "STSong") // 宋体
#let font-hei = "SimHei"   // 黑体
#let font-en = "Times New Roman"                            // 英文/数字字体

// 字号定义 (Pt)
#let size-no1 = 26pt      // 一号
#let size-no2 = 22pt      // 二号
#let size-small-no2 = 18pt // 小二
#let size-no3 = 16pt      // 三号
#let size-small-no3 = 15pt // 小三
#let size-no4 = 14pt      // 四号
#let size-small-no4 = 12pt // 小四 (正文)
#let size-no5 = 10.5pt    // 五号 (页眉页脚)

#let indent = h(2em)
#let noindent = h(-2em)

#let fakepar = context {
  let b = par(box())
  b
  v(-measure(b + b).height)
}



// ----------------------------------------------------------------
// 核心功能：目录页封装
// ----------------------------------------------------------------
#let outline-page() = {
  pagebreak()

  // --- 目录样式定制 (局部生效，不影响正文) ---
  // 1. 定制目录条目样式
  show outline.entry: it => {
    if it.level == 1 {
      // Level 1 (章)：黑体，四号，weight: regular (防止伪粗体糊住)
      v(12pt, weak: true) // 章之间稍微加点空隙
      text(font: font-hei, size: size-no4, weight: "regular", it)
    } else {
      // Level 2+ (节)：默认宋体，小四
      text(font: font-song, size: size-small-no4, it)
    }
  }

  // 2. 生成目录
  outline(
    // 标题居中，黑体小二，中间加全角空格
    title: align(center)[
      #text(font: font-hei, size: size-small-no2, weight: "regular")[目　　录]
    ],
    indent: 1.5em,
    depth: 3,
  )

  pagebreak()
}


// 导出主函数
#let project(
  title: "实验报告标题",
  major: "计算机科学与技术",
  course: "课程名称",
  student-name: "你的名字",
  student-id: "202xxxxxxxxx",
  advisor: "指导教师",
  date: "二〇XX年X月",
  body,
) = {
  // 1. 页面设置
  set page(
    paper: "a4",
    margin: (top: 25mm, bottom: 20mm, left: 30mm, right: 30mm),
    // 页眉，无规定，可去除
    header: {
      set text(font: font-song, size: size-no5)
      align(center)[武汉大学计算机学院本科生课程设计报告] // 可以在这里放页眉内容，规范未强行规定页眉文字，通常为空或文件名，这里暂留空或按需修改
      line(length: 100%, stroke: 0.5pt)
    },
    footer: {
      set text(font: font-en, size: size-no5)
      align(center)[#context counter(page).display("1")]
    },
  )

  // 2. 段落与字体基础设置
  set text(font: font-song, size: size-small-no4, lang: "zh")

  // 因为标准宋体/黑体没有 Bold 字重，Typst 默认无法加粗。
  // 这里使用 stroke (描边) 来模拟 Word 的加粗效果。
  // 0.028em 是经验值，不仅加粗明显，而且不会糊在一起。
  show strong: it => {
    text(stroke: 0.028em + black, it.body)
  }

  // 强制代码块使用 Consolas (Win) 或 Courier New (Mac)，
  // 中文回退到黑体 (SimHei)，看起来更像现代 IDE 的风格。
  show raw: set text(font: ("Consolas", "Courier New", "SimHei"))


  // 规范要求：行距固定值 23 磅。
  // Typst 中 leading 是行间距。字号 12pt，行距 23pt，则 leading = 11pt。
  // 11pt / 12pt ≈ 0.92em
  set par(
    leading: 0.92em,
    first-line-indent: 2em, // 首行缩进
    justify: true,
  )

  // 3. 标题设置
  // 一级标题：黑体小2号，段前0.8行，段后0.5行
  show heading.where(level: 1): it => {
    set text(font: (font-hei), size: size-small-no2)
    set par(first-line-indent: 0em, leading: 1em, spacing: 1em) // 调整段间距模拟段前段后
    v(0.8em)
    align(center)[#block(it)]
    v(0.5em)
    fakepar
  }

  // 二级标题：黑体4号，段前0.5行，段后0.5行
  show heading.where(level: 2): it => {
    set text(font: (font-en, font-hei), size: size-no4)
    set par(first-line-indent: 0em)
    v(0.5em)
    block(it)
    v(0.5em)
    fakepar
  }

  // 三级标题：黑体小4号
  show heading.where(level: 3): it => {
    set text(font: (font-en, font-hei), size: size-small-no4)
    set par(first-line-indent: 0em)
    v(0.5em)
    block(it)
    v(0.5em)
    fakepar
  }

  // 标题编号设置 (1, 1.1, 1.1.1)
  set heading(numbering: "1.1")

  // 拦截公式引用，强制数字引用变为 Regular (不加粗) ---
  show ref: it => {
    let el = it.element
    if el != none and el.func() == math.equation {
      // 如果引用的是公式，手动重构编号文本，并强制设为 regular
      let loc = el.location()
      let ch = counter(heading).at(loc).first()
      let num = counter(math.equation).at(loc).first()
      let str-val = "式  (" + str(ch) + "." + str(num) + ")"
      link(loc)[#text(font: ("Times New Roman","SimSun"), weight: "regular", str-val)]
    } else {
      // 其他引用（如图表）保持默认
      it
    }
  }
  // 公式样式 (Math)
  // 编号格式：(章.序号)
  // 字体：Times New Roman
  set math.equation(numbering: (..nums) => {
    // 获取当前章节号
    let chapter = counter(heading).get().first()
    // 组合编号 (1.1)
    let number-str = "(" + str(chapter) + "." + str(nums.pos().first()) + ")"
    // 强制使用 Times New Roman 显示编号
    text(font: (font-en, font-hei), weight: "bold", number-str)
  })

  // 单行公式后默认缩进
  show math.equation.where(block: true): it => {
    it
    fakepar
  }

  // 图表样式 (Figure)
  set figure(gap: 1.2em) // Caption和内容之间的间距
  show figure: it => {
    set align(center)

    // 分情况处理 Table 和 Image
    if it.kind == table {
      // --- 表格样式 ---
      // 1. 标题在上方
      set figure.caption(position: top)
      // 2. 标题样式：中文黑体，英文Times，加粗，小四号
      // 利用字体回退：先找 Times (处理数字字母)，再找 SimHei (处理中文)
      show figure.caption: caption-it => {
        set text(
          font: (font-en, font-hei),
          weight: "bold",
          size: size-small-no4,
        )
        caption-it
      }
      // 3. 表格内部内容样式：五号字
      set text(size: size-no5)
      // 渲染
      it
      fakepar
    } else {
      // --- 图片样式 ---
      // 1. 标题在下方 (默认就是 bottom，但显式写出来保险)
      set figure.caption(position: bottom)
      // 2. 标题样式：中文宋体，英文Times，不加粗，小四号
      show figure.caption: caption-it => {
        set text(
          font: (font-en, font-hei),
          weight: "bold",
          size: size-small-no4,
        )
        caption-it
      }
      // 图片内容保持默认字号 (或者也改成 5 号，看需求，通常图片里没有字)
      it
      fakepar
    }
  }

  // 图表编号重置逻辑
  show heading.where(level: 1): it => {
    counter(math.equation).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: raw)).update(0)
    it
  }
  set figure(numbering: (..nums) => {
    let chapter = counter(heading).get().first()
    // 编号格式：1.1
    str(chapter) + "." + str(nums.pos().first())
  })

  // ------------------ 封面开始 ------------------
  // 封面不显示页码
  page(header: none, footer: none)[
    #set align(center)
    #v(2cm)

    #text(font: font-song, size: size-no1, weight: "bold")[*武汉大学计算机学院\ 本科生课程设计报告*]

    #v(2cm)

    #text(font: font-hei, size: size-no2)[#title]

    #v(2cm)

    // 封面信息表格
    #set text(font: font-song, size: size-small-no3)

    #align(center)[
      #grid(
        // 关键点1：两列都设为 1fr，意味着左右各占 50%，中轴线就在正中间
        columns: (1fr, 1fr),

        // 关键点2：行间距和列间距
        row-gutter: 1.5em,
        // 行与行之间的距离
        column-gutter: 0.5em,
        // 冒号和文字之间的距离

        // 填充内容：左边右对齐，右边左对齐
        align(right)[专 业 名 称：], align(left)[#major],
        align(right)[课 程 名 称：], align(left)[#course],
        align(right)[指 导 教 师：], align(left)[#advisor],
        align(right)[学 生 学 号：], align(left)[#student-id],
        align(right)[学 生 姓 名：], align(left)[#student-name],
      )
    ]

    #v(1fr)

    #text(font: font-song, size: size-no3)[
      #date
    ]

    #v(3cm)
  ]
  // ------------------ 封面结束 ------------------

  // ------------------ 声明页 ------------------
  page(header: none, footer: none)[
    #set align(center)
    #v(2cm)
    #text(font: font-song, size: size-no2, weight: "bold")[*郑 重 声 明*]
    #v(2cm)
    #set align(left)
    #set text(font: font-song, size: size-no4)
    #par(first-line-indent: 2em)[
      本人呈交的设计报告，是在指导老师的指导下，独立进行实验工作所取得的成果，所有数据、图片资料真实可靠。尽我所知，除文中已经注明引用的内容外，本设计报告不包含他人享有著作权的内容。对本设计报告做出贡献的其他个人和集体，均已在文中以明确的方式标明。本设计报告的知识产权归属于培养单位。
    ]

    // 划线用的函数
    #let field(width) = box(width: width, stroke: (bottom: 0.5pt + black))

    #v(3cm)
    #align(center)[
      #grid(
        columns: 2,
        gutter: 20pt,
        [本人签名：#field(4cm)], [日期：#field(4cm)],
      )
    ]
  ]

  // 重置页码计数器，正文开始
  counter(page).update(1)

  body
}

// 辅助函数：摘要
#let abstract-page(cn-abstract, keywords, en-abstract: none) = {
  page(header: none)[
    #align(center)[#text(font: font-hei, size: size-small-no2)[摘　要]]
    #v(1em)
    #cn-abstract
    #v(1em)
    #text(font: font-hei, size: size-small-no4)[关键词：]#keywords

    #if en-abstract != none {
      pagebreak()
      align(center)[#text(font: font-en, size: size-small-no2, weight: "bold")[ABSTRACT]]
      v(1em)
      set text(font: font-en)
      en-abstract
    }
  ]
}


// 参考文献页封装
#let bib-list(body) = {
  pagebreak()
  // 生成不带编号的一级标题
  heading(level: 1, numbering: none)[参考文献]
  // 关键修改：强制取消首行缩进
  set par(first-line-indent: 0em)
  body
}


// 教师评语页封装
#let grading-page() = {
  pagebreak()
  set page(footer: none)
  // 1. 标题：教师评语评分 (宋体小二)
  align(center)[
    #text(font: font-song, size: size-small-no2, weight: "bold")[*教师评语评分*]
  ]
  v(1cm) // 标题和内容的间距

  // 2. 评语区
  set par(first-line-indent: 0em)
  text(font: font-song, size: size-no4)[评语：]

  // 关键：使用 1fr 占据剩余所有空间，把下面的内容推到底部
  v(1fr)

  // 3. 评分与签名区 (靠右对齐，但内部左对齐)
  align(right)[
    #block(width: 180pt)[ // 限制宽度，确保"评分"和"评阅人"看起来是左对齐的
      #set align(left)
      #set text(font: font-song, size: size-no4)
      #grid(
        columns: (auto, 1fr),
        row-gutter: 1.5cm, // 行间距
        [评~~分：], [],
        [评阅人：], []
      )
    ]
  ]

  v(1cm)

  // 4. 日期 (靠右)
  align(right)[
    #text(font: font-song, size: size-no4)[
      年 #h(2.5em) 月 #h(2.5em) 日 #h(2em)
    ]
  ]

  v(1cm)

  // 5. 底部备注 (居中，五号字)
  align(center)[
    #text(font: font-song, size: size-no4)[（备注：对该实验报告给予优点和不足的评价，并给出百分制评分。）]
  ]
}