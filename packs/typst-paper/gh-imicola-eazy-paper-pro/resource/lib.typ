// ================================
// 字体配置
// ================================
#let font = (
    // 中文字体
    zh_shusong: "Source Han Serif SC",
    zh_zhongsong: "Source Han Serif SC",
    zh_kai: "Source Han Serif SC",
    zh_hei: "Source Han Sans SC",
    zh_fangsong: "Source Han Sans SC",
    // 英文字体
    en_sans_serif: "Latin Modern Roman",
    en_serif: "Latin Modern Roman",
    en_typewriter: "Source Sans Pro",
    en_code: "Maple Mono NF",
)

// ================================
// 字号配置
// ================================

#let font-size = (
    s2: 18pt, // 二号
    n3: 16pt, // 三号
    s3: 15pt, // 小三
    n4: 14pt, // 四号
    s4: 12pt, // 小四
    n5: 10.5pt, // 五号
    s5: 9pt, // 小五
)

// ================================
// 样式配置
// ================================

#let config = (
    // 字号设置
    text-size: font-size.n5,
    author-size: font-size.n5,
    title-size: font-size.s2,
    title1-size: font-size.s3,
    title2-size: font-size.n4,
    title3-size: font-size.s4,
    // 字体设置
    title-font: (font.en_serif, font.zh_hei),
    author-font: (font.en_sans_serif, font.zh_shusong),
    body-font: (font.en_serif, font.zh_shusong),
    heading-font: (font.en_serif, font.zh_zhongsong),
    caption-font: (font.en_serif, font.zh_kai),
    header-font: (font.en_serif, font.zh_kai),
    strong-font: (font.en_serif, font.zh_hei),
    emph-font: (font.en_serif, font.zh_kai),
    raw-font: (font.en_code, font.zh_hei),
    // 间距设置
    spacing: 1.5em,
    leading: 1.0em,
    indent: 2em,
    small-space: 1em,
    block-space: 0.75em,
    // 颜色设置
    raw-color: rgb("#f0f0f0"),
    problem-color: rgb(241, 241, 255),
    summary-color: rgb(240, 248, 255),
    // 列表样式
    list-marker: ([•], [◦], [▶]),
    enum-numbering: ("1.", "(1)", "①", "a."),
    // 表格样式
    table-stroke: 0.08em,
    table-header-stroke: 0.05em,
)

// ================================
// 全局状态
// ================================

// 全局title状态
#let title-state = state("document-title", "")
// 新页状态：true 表示当前处于刚换到的新空白页（页顶尚未放置任何内容）
#let fresh-page = state("fresh-page", false)

// ================================
// 工具函数
// ================================

// 解决首段缩进问题的空白段
#let fake-par = {
    par(box())
    v(-config.spacing)
}

// 偏微分符号
#let pardiff(x, y) = $frac(partial #x, partial #y)$

// ================================
// 学术组件
// ================================

// 通用框组件
#let custom-block(
    title: none,
    color: rgb(245, 245, 245),
    it,
) = {
    set text(font: config.emph-font)
    let body = if title != none {
        strong(title) + h(config.block-space) + it
    } else {
        it
    }

    block(
        fill: color,
        inset: 8pt,
        radius: 2pt,
        width: 100%,
        body,
    )
    fake-par
}

// 题目框
#let problem-counter = counter("problem")
#let problem = custom-block.with(
    title: [
        #problem-counter.step()
        题目 #context problem-counter.display().
    ],
    color: config.problem-color,
)

// 解答框
#let solution(it) = {
    set enum(numbering: "(1)")
    let body = [*解答.*] + h(config.block-space) + it
    block(
        inset: 8pt,
        below: config.leading,
        width: 100%,
        body,
        fill: rgb("#f7c2f938"),
    )
    fake-par
}

// 总结框
#let summary = custom-block.with(
    title: [总结.],
    color: config.summary-color,
)

// 新增：定义框
#let definition = custom-block.with(
    title: "定义",
    color: rgb("#e8f4f8"), // 浅蓝色
)

// 新增：定理框
#let theorem = custom-block.with(
    title: "定理",
    color: rgb("#fff8e1"), // 浅黄色
)

// 新增：示例框
#let example = custom-block.with(
    title: "示例",
    color: rgb("#81ed3e40"), // 浅绿色
)

#let important(it) = {
    // title: "重要",
    block(
        fill: rgb("#f4222224"), // 浅红色,
        stroke: (left: 4pt + rgb("#f42222")),
        inset: 1em,
        width: 100%,
        radius: 2pt,
        [*重要：* #it],
    )
    fake-par
}

// 新增：提示/注意框 (Admonition)
#let tip(it) = {
    block(
        fill: rgb("#e6fffa"),
        stroke: (left: 4pt + teal),
        inset: 1em,
        width: 100%,
        radius: 2pt,
        [*提示：* #it],
    )
    fake-par
}


#let equation-box(it) = {
    set text(font: config.emph-font)
    block(
        fill: rgb("#f8fbff"),
        inset: (x: 10pt, y: 8pt),
        radius: 6pt,
        width: 100%,
        stroke: 0.4pt + luma(220),
        outset: (x: 0pt, y: 3pt),
        grid(
            columns: (6pt, 1fr, auto),
            column-gutter: 12pt,
            align: (center, center, right),
            // 左侧装饰条
            box(width: 6pt, fill: rgb("#2b9cff"), radius: 3pt),
            // 中间放公式（居中）
            align(center)[#it],
        ),
    )
    fake-par
}

// 类似 LaTeX \boxed{} 的简单公式边框
#let boxed(it) = {
    h(2pt) // 向下移动 3pt，可按需调整
    box(stroke: 0.5pt + black, inset: 5pt, it)
}

// 三线表格
#let three-line-table(it) = {
    if it.children.any(c => c.func() == table.hline) {
        return it
    }

    let meta = it.fields()
    meta.stroke = none
    meta.remove("children")

    let header = it.children.find(c => c.func() == table.header)
    let cells = it.children.filter(c => c.func() == table.cell)

    if header == none {
        let columns = meta.columns.len()
        header = table.header(..cells.slice(0, columns))
        cells = cells.slice(columns)
    }

    return table(
        ..meta,
        table.hline(stroke: config.table-stroke),
        header,
        table.hline(stroke: config.table-header-stroke),
        ..cells,
        table.hline(stroke: config.table-stroke),
    )
}

#let header-style(heading) = {
    set text(font: config.header-font)
    let title = title-state.get()
    grid(
        columns: (1fr, 1fr),
        align(left, title), align(right, heading),
    )
    v(-1.2em)
    line(stroke: 1pt + gray, length: 100%)
}

#let prev-header = context {
    let headings = query(heading.where(level: 1).before(here()))
    if headings.len() == 0 {
        return
    }
    let level = counter(heading.where(level: 1)).display("一")
    let heading = level + h(config.small-space) + headings.last().body
    header-style(heading)
}

#let next-header = context {
    let headings = query(heading.where(level: 1).after(here()))
    if headings.len() == 0 {
        return
    }
    let count = counter(heading.where(level: 1)).get().first() + 1
    let level = numbering("一", count)
    let heading = level + h(config.small-space) + headings.first().body
    header-style(heading)
}

// 标题
#let make-title(
    title: "",
    subtitle: "",
    author: "",
    date: none,
    abstract: none,
    keywords: (),
) = {
    // 主标题
    align(center)[
        #block(
            text(
                font: config.title-font,
                weight: "bold",
                config.title-size,
                title,
            ),
        )
        // 副标题
        #if subtitle != "" {
            v(0.5em)
            block(
                text(
                    font: config.title-font,
                    weight: "regular",
                    font-size.n3, // 使用三号字
                    subtitle,
                ),
            )
        }
        #v(0.5em)
    ]

    // 作者
    if author != "" {
        set text(config.author-size, font: config.author-font)
        align(center, author)
    }

    // 日期
    if date != none {
        date = if date == auto {
            datetime.today().display("[year]年[month]月[day]日")
        } else {
            date
        }
        set text(config.author-size, font: config.author-font)
        align(center, date)
    }

    // 摘要和关键词
    if abstract != none [
        #v(2pt)
        #fake-par
        *摘要：* #abstract

        #if keywords != () [
            *关键字：* #keywords.join("；")
        ]
        #v(2pt)
    ]
}

// ================================
// 主模板函数
// ================================

#let project(
    title: "",
    subtitle: "",
    author: "",
    date: none,
    abstract: none,
    keywords: (),
    toc: true,
    body,
) = {
    title-state.update(title)

    // 文档设置
    set document(author: author, title: title, date: date, keywords: keywords)

    // 页面设置
    set page(
        numbering: "1",
        number-align: center,
        // 使用原生 query 实现页眉标题获取，避免外部库报错
        header: context {
            // 奇数页显示章节标题
            if calc.odd(here().page()) {
                // 获取当前位置之前的所有一级标题
                let headings = query(heading.where(level: 1).before(here()))
                // 如果有标题，取最后一个作为当前章节
                let current-heading = if headings.len() > 0 { headings.last() } else { none }

                let header-text = if current-heading != none {
                    // 获取该标题处的计数器状态（例如 "第一章"）
                    let count = counter(heading).at(current-heading.location()).first()
                    let number = numbering("一", count)
                    // 组合编号和标题
                    number + h(1em) + current-heading.body
                } else {
                    title // 如果还没开始章节，显示文档标题
                }

                align(right, text(font: config.header-font, header-text))
            } else {
                // 偶数页显示文档标题
                align(left, text(font: config.header-font, title))
            }
            v(-0.5em)
            line(length: 100%, stroke: config.table-header-stroke)
        },
    )

    // 基础样式设置
    // 注释下方可以关闭自动标号
    set heading(numbering: "1.1")
    set text(
        font: config.body-font,
        lang: "zh",
        region: "cn",
        size: config.text-size,
    )
    set par(
        first-line-indent: config.indent,
        justify: true,
        leading: config.leading,
        spacing: config.spacing,
    )
    set enum(
        indent: config.indent,
        full: true,
        numbering: (..n) => {
            n = n.pos()
            let level = n.len()
            let number = config.enum-numbering.at(level - 1, default: "1.")
            numbering(number, ..n.slice(level - 1))
        },
    )
    set list(
        indent: config.indent,
        marker: config.list-marker,
    )
    set math.equation(numbering: "(1)")
    set underline(evade: false)

    // ================================
    // 标题样式
    // ================================

    show heading: it => {
        set text(font: config.heading-font)
        let body = if it.numbering != none {
            counter(heading).display() + h(config.small-space) + it.body
        } else {
            it.body
        }
        box(width: 100%, body)
        // 任意内容渲染后取消“新页空白”状态
        fresh-page.update(false)
    }

    show heading.where(level: 1): it => {
        set align(center)
        set heading(numbering: "一")
        set text(config.title1-size)
        it
        fresh-page.update(false)
    }

    show heading.where(level: 2): it => {
        v(-0.75em)
        set text(config.title2-size)
        it
        v(-0.25em)
        fresh-page.update(false)
    }

    show heading.where(level: 3): it => {
        v(-1em)
        set text(config.title3-size)
        it
    }

    // 新增：四级标题样式（小标题）
    show heading.where(level: 4): it => {
        v(-1em)
        set text(config.text-size, weight: "bold")
        it
    }

    // ================================
    // 元素样式
    // ================================

    // 数学公式：无标签则不编号
    show math.equation: it => {
        set block(breakable: true)
        if it.block and not it.has("label") [
            #counter(math.equation).update(v => v - 1)
            #math.equation(it.body, block: true, numbering: none)#label("_")
        ] else {
            it
        }
        fresh-page.update(false)
    }

    // 图表样式
    show figure: it => {
        set block(breakable: true)
        set text(font: config.caption-font)
        it + fake-par
        fresh-page.update(false)
    }
    show figure.where(kind: table): set figure.caption(position: top)
    show table: it => {
        set text(font: config.body-font)
        it + fake-par
        fresh-page.update(false)
    }
    show image: it => {
        it + fake-par
        fresh-page.update(false)
    }
    show image: it => it + fake-par

    // 列表样式
    show list: it => {
        set list(indent: 0em)
        set enum(indent: 0em)
        it + fake-par
        fresh-page.update(false)
    }
    show enum: it => {
        set list(indent: 0em)
        set enum(indent: 0em)
        it + fake-par
        fresh-page.update(false)
    }
    show terms: it => {
        set text(font: config.caption-font)
        it + fake-par
        fresh-page.update(false)
    }

    // 文字样式
    show strong: set text(font: config.strong-font)
    show emph: set text(font: config.emph-font)
    show ref: set text(red)
    show link: it => {
        set text(blue)
        underline(it)
        fresh-page.update(false)
    }

    // 代码样式
    show raw.where(block: false): it => {
        set text(font: config.raw-font)
        box(
            fill: config.raw-color,
            inset: (x: 3pt, y: 0pt),
            outset: (x: 0pt, y: 3pt),
            radius: 2pt,
            it,
        )
        fresh-page.update(false)
    }
    show raw.where(block: true): it => {
        set text(font: config.raw-font, size: 9pt) // 代码通常比正文小一号
        set par(leading: 0.6em, justify: false)

        block(
            width: 100%,
            fill: config.raw-color,
            inset: 10pt,
            radius: 4pt,
            stroke: 0.5pt + luma(200), // 增加边框增加质感
            // 开启行号
            grid(
                columns: (auto, 1fr),
                column-gutter: 1em,
                align(right, text(fill: luma(150), it.lines.enumerate().map(x => str(x.at(0) + 1)).join("\n"))), it,
            ),
        )
        fake-par
        fresh-page.update(false)
    }

    // ================================
    // 文档标题部分
    // ================================
    make-title(
        title: title,
        subtitle: subtitle,
        author: author,
        date: date,
        abstract: abstract,
        keywords: keywords,
    )

    context {
        let elems = query(heading.where(level: 1))
        if toc and elems.len() > 0 {
            show outline.entry: it => {
                set text(font: config.body-font)
                it
            }
            outline(
                title: "目录",
                indent: 2em,
                depth: 3, // 控制目录显示深度
            )
            pagebreak() // 目录后换页
            fresh-page.update(true)
        }
    }
    // 正文内容
    body
}

// ================================
// 章节分隔页（空出一页 + 居中靠右的大标题）
// ================================
#let chapter-page(
    title: "",
    subtitle: none,
    title-size: 42pt,
    subtitle-size: 22pt,
) = context {
    // 如果当前不是“新空白页”，则插入一整页空白
    if not fresh-page.get() {
        pagebreak()
        fresh-page.update(true)
    }

    // 渲染标题页内容（此时这页不再为空白）
    fresh-page.update(false)

    block(width: 100%, height: 100%)[
        #v(1fr)
        #align(right)[
            #text(font: config.title-font, weight: "bold", size: title-size)[#title]
            #if subtitle != none {
                v(0.6em)
                text(font: config.heading-font, size: subtitle-size)[#subtitle]
            }
        ]
        #v(1fr)
    ]

    // 标题页后另起一页开始正文
    pagebreak()
    fresh-page.update(true)
}

// ================================
// 封面组件
// ================================

#let cover-page(
    // 封面图片（可选）
    image-path: none,
    image-height: 35%,
    // 文档标题
    title: "",
    subtitle: none,
    // 作者信息
    author: "",
    student-id: none,
    department: none,
    major: none,
    // 指导教师（可选）
    advisor: none,
    // 日期
    date: auto,
    // 学校/机构信息（可选）
    institution: none,
    institution-logo: none,
    // 样式配置
    title-color: black,
    accent-color: rgb("#005eb8"),
) = {
    page(
        margin: (top: 2cm, bottom: 2cm, left: 2.5cm, right: 2.5cm),
        header: none,
        footer: none,
        numbering: none,
    )[
        #place(top + right, dx: 30%, dy: -10%)[
            #circle(radius: 15cm, fill: accent-color.lighten(90%))
        ]

        // 1. 顶部：机构信息 (左对齐，更像信头)
        #grid(
            columns: (auto, 1fr),
            gutter: 1em,
            align: (left + horizon, left + horizon),
            if institution-logo != none {
                block(
                    clip: true,
                    radius: 10pt,
                    if type(institution-logo) == str {
                        image(institution-logo, width: 1.8cm)
                    } else {
                        set image(width: 1.8cm)
                        institution-logo
                    },
                )
            },
            if institution != none {
                text(
                    size: 14pt,
                    font: config.title-font,
                    weight: "bold",
                    fill: luma(80),
                    institution,
                )
            },
        )

        #v(2fr)

        // 2. 标题区域 (左对齐 + 强调线条)
        #block(width: 100%)[
            // 装饰短线
            #text(
                size: 32pt,
                font: config.title-font,
                weight: "bold",
                fill: title-color,
                title,
            )
            #v(2pt)
            #block(width: 25em, height: 6pt, fill: accent-color, radius: 3pt)
            #if subtitle != none {
                v(0.8em)
                text(
                    size: 18pt,
                    font: config.title-font,
                    weight: "regular",
                    fill: luma(100),
                    subtitle,
                )
            }

        ]

        #v(1.5fr)

        // 3. 中部：图片 (如果有)
        #if image-path != none {
            block(
                width: 100%,
                height: image-height,
                clip: true,
                radius: 10pt, // 圆角
                stroke: none,
                {
                    if type(image-path) == str {
                        image(image-path, fit: "cover", width: 100%, height: 100%)
                    } else {
                        set image(fit: "cover", width: 100%, height: 100%)
                        image-path
                    }
                },
            )
        }

        #v(2fr)

        // 4. 底部：作者信息卡片
        #if author != "" {
            block(
                width: 100%,
                fill: luma(98.04%, 0%),
                inset: 1.5em,
                radius: 4pt,
                stroke: (left: 4pt + accent-color.lighten(50%)),
            )[
                #set text(size: 11pt, font: config.body-font)
                #grid(
                    columns: (auto, 1fr),
                    column-gutter: 2em,
                    row-gutter: 0.8em,

                    // 标签样式函数
                    ..{
                        let label(it) = text(fill: luma(100), weight: "bold", it)
                        let val(it) = text(fill: black, weight: "medium", it)

                        (
                            label("作者"),
                            val(author),
                            ..if student-id != none { (label("学号"), val(student-id)) } else { () },
                            ..if department != none { (label("院系"), val(department)) } else { () },
                            ..if major != none { (label("专业"), val(major)) } else { () },
                            ..if advisor != none { (label("指导教师"), val(advisor)) } else { () },
                        )
                    }
                )
            ]
        }

        #v(1em)

        // 日期 (右对齐，作为落款)
        #align(right)[
            #{
                let display-date = if date == auto {
                    datetime.today().display("[year] 年 [month] 月 [day] 日")
                } else if date != none {
                    date
                }

                if display-date != none {
                    text(
                        size: 11pt,
                        font: config.author-font,
                        fill: luma(120),
                        display-date,
                    )
                }
            }
        ]
    ]
    pagebreak()
}