// 伪加粗, 支持正则表达式, 可自选字重
#let bold(reg: ".", base-weight: none, body) = {
    show regex(reg): it => {
        set text(stroke: 0.02857em)
        set text(weight: base-weight) if base-weight != none
        it
    }
    body
}

// 针对中文的伪加粗
#let bold-cn(s) = {
    bold(reg: "[\p{script=Han} ！-･〇-〰—]", base-weight: "regular", s)
}

// Show 全局加粗规则
#let bold-rule(reg: ".", base-weight: none, body) = {
    show text.where(weight: "bold").or(strong): it => {
        bold(reg: reg, base-weight: base-weight, it)
    }
    body
}

// 针对中文的 Show 全局加粗规则
#let bold-cn-rule(s) = {
    bold-rule(reg: "[\p{script=Han} ！-･〇-〰—]", base-weight: "regular", s)
}

// https://github.com/typst/typst/issues/2749
#let _skew(angle, vscale: 1, body) = {
    let (a, b, c, d) = (1, vscale * calc.tan(angle), 0, vscale)
    let E = (a + d) / 2
    let F = (a - d) / 2
    let G = (b + c) / 2
    let H = (c - b) / 2
    let Q = calc.sqrt(E * E + H * H)
    let R = calc.sqrt(F * F + G * G)
    let sx = Q + R
    let sy = Q - R
    let a1 = calc.atan2(F, G)
    let a2 = calc.atan2(E, H)
    let theta = (a2 - a1) / 2
    let phi = (a2 + a1) / 2
    set rotate(origin: bottom + center)
    set scale(origin: bottom + center)
    box(rotate(phi, scale(x: sx * 100%, y: sy * 100%, rotate(theta, body))))
}

// 伪斜体, 支持正则表达式, 考虑到斜体后可能与后面的字重叠, 可自行设置间距
#let italic(reg: "[^ ]", ang: -0.32175, spacing: none, body) = {
    show regex(reg): _skew.with(ang)
    body
    if spacing != none {h(spacing)}
}

// Show 全局斜体规则
#let italic_rule(reg: "[^ ]", ang: -0.32175, spacing: none, body) = {
    show text.where(style: "italic").or(emph): it => {
        italic(reg: reg, ang: ang, spacing: spacing, it)
    }
    body
}

#let frb(
    title: none,
    subtitle: none,
    header: none,
    author: "",
    abstract-CN: none,
    keyword-CN: none,
    abstract-EN: none,
    keyword-EN: none,
    bibliography-file: none,
    bibliography-title: "参考文献",
    bibliography-style: "gb-7714-2015-numeric",
    auto-num-title: true,
    body
) = {
    // =========================
    //     设置文档基本内容
    // =========================
    set document(author: (author, ), title: title)
    // 设置页边距
    set page(
        margin: (
            top: 2.5cm,
            bottom: 2.5cm,
            left: 3cm,
            right: 2cm,
        )
    )
    // 设置正文, 小4号, 默认新罗马体, 中文回退到宋体
    set text(font: ("Times New Roman" ,"SimSun"), size: 12pt)
    // 设置数学公式字体
    show math.equation: set text(font: "New Computer Modern Math", weight: 400)
    // 设置代码块字体
    show raw : set text(font: ("DejaVu Sans Mono", "SimSun"), weight: 400, size: 9pt)
    // 代码块背景
    show raw.where(block: false): box.with(
        fill: luma(240),
        inset: (x: 3pt, y: 0pt),
        outset: (y: 3pt),
        radius: 2pt,
    )
    show raw.where(block: true): block.with(
        fill: luma(240),
        inset: 10pt,
        radius: 4pt,
    )

    // =========================
    //     设置封面
    // =========================
    v(-0.5em)
    align(left, image("svg/logo.svg", width: 20%))
    v(3.4em)
    align(center, image("svg/name.svg", width: 80%))
    v(4em)
    // 论文题目 2 号 华文中宋 加粗
    align(center, text(22pt, title, font: ("STZhongsong"), stroke: 0.01em))
    v(2em)
    // 可选副标题 3 号 华文新魏 加粗
    if subtitle != none{
        let subtitle = "——" + subtitle
        align(right, text(16pt, subtitle, font:("STXinwei")))
    }

    // =========================
    //     设置摘要与目录页页码
    // =========================
    set page(
        // 设置页码, 5号, 新罗马体
        footer: context {
            align(center, text(size: 10.5pt, counter(page).display("i")))
        },
    )
    pagebreak()
    // 封面, 题名不编页码, 从摘要开始, 摘要图例部分用小写罗马数字
    counter(page).update(1)
    // 设置段间距
    set par(
        spacing: 15.75pt,
        leading: 15.75pt,
        first-line-indent: 2em,
    )

    // 摘要, 关键字与目录
    if abstract-CN != none and keyword-CN != none {
        align(center, text(16pt, font: "SimHei")[摘要])
        [
            #abstract-CN

            #text(font: "SimHei", "关键词：")
            #keyword-CN
        ]
        pagebreak()
    }
    if abstract-EN != none and keyword-EN != none {
        align(center, text(16pt, weight: "bold")[Abstract])
        [
            #abstract-EN

            *Keywords: *
            #strong(keyword-EN)
        ]
        pagebreak()
    }

    // =========================
    //     设置目录
    // =========================
    set par(
        first-line-indent: 0em,
    )
    align(center, text(16pt, font: "SimHei")[目录])
    outline(
        title: none,
        depth: 3,
        indent: 2em,
    )

    // =========================
    //     设置正文页页码与页眉
    // =========================
    set page(
        // 从正文绪论开始一直到参考文献 附录, 用阿拉伯数字编页码
        footer: context {
            align(center, text(size: 10.5pt, counter(page).display("1")))
        },
        header-ascent: 14pt,
        header: {
            set text(size: 9pt, font: "SimSun")
            align(center, header)
            v(-2.6em)
            line(start:(0%,25%),end:(100%,25%),length:100%,stroke: 0.5pt)
        },
    )
    pagebreak()
    counter(page).update(1)

    // =========================
    //     设置正文
    // =========================

    show list: it => {
        it;
        v(0em, weak: true)
        h(0em)
    }
    show enum: it => {
        it;
        text()[#v(0em, weak: true)];
        text()[#h(0em)]
    }
    show table: it => {
        it;
        text()[#v(0.3em, weak: true)];
        text()[#h(0em)]
    }
    show math.equation: it => {
        it;
        // text()[#v(0.3em, weak: true)];
        text()[#h(0em)]
    }
    show raw: it => {
        it;
        // text()[#v(0.3em, weak: true)];
        text()[#h(0em)]
    }
    set par(
        // 间距设置过了
        first-line-indent: 2em,
    )

    // =========================
    //     设置正文标题
    // =========================
    // 章标题 3号, 黑体, 居中
    show heading.where(level:1): it =>{
        set text(size: 16pt, font:("SimHei"))
        v(1em)
        align(center, it)
        v(0.5em, weak: true)
        h(0em)
    }
    // 节标题 4号, 黑体, 居左
    show heading.where(level:2): it =>{
        set text(size: 14pt, font:("SimHei"))
        v(0.2em)
        it
        v(0.0em, weak: true)
        h(0em)
    }
    // 条标题 小4号, 黑体, 居左
    show heading.where(level:3): it =>{
        set text(size: 12pt, font:("SimHei"))
        v(0.2em)
        it
        v(0.2em, weak: true)
        h(0em)
    }

    // 是否开启自动标号
    if auto-num-title != none {
        set heading(numbering: (..nums) => {
            if nums.pos().len()==1 {
                numbering("一、", nums.pos().at(0))
            } else if nums.pos().len()==2 {
                numbering("(一) ", nums.pos().at(1))
            } else if nums.pos().len()==3 {
                numbering("1.", nums.pos().at(2))
            }
        })
        body
    } else {
        body
    }

    // =========================
    //     设置结尾参考文献
    // =========================
    if bibliography-file != none {
        pagebreak()
        bibliography(bibliography-file, title: bibliography-title, style: bibliography-style)
    }
}

// 结论章是没有编号的
#let conclusion(title: "结论") = {
    heading(
        level: 1,
        numbering: none,
        outlined: true,
        title
    )
}

#let img(
    path: none,
    width: 80%,
    num: none,
    body
) = {
    set text(stroke: 0.02857em, size: 10.5pt)
    figure(
        image(path, width: width),
        caption: [#bold(body)],
        numbering: num
    )
    text()[#v(0.3em, weak: true)];
    text()[#h(0em)]
}
