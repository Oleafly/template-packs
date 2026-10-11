// chicv —— 简历版式定义
//
// 派生自 Matchy 的 chicv 模板（MIT License，Copyright (c) 2023 Matchy），详见 LICENSE。
// 本文件只负责「长什么样」，简历内容在 resume-cn.typ / resume-en.typ 里。
// 想改版式就改这里：字体、字号、行距、页边距、章节标题样式、条目布局。

#import "fontawesome.typ": *

// 章节标题下方的横线
#let chiline() = {
    v(-8pt);
    line(length: 100%, stroke: gray);
    v(-8pt)
}

// 带图标的外链，如 #iconlink("https://example.com", label: "主页", icon: globe)
#let iconlink(
    uri, label: "", icon: link-icon
) = {
    if label != "" {
        link(uri)[#text[#fa[#icon]] #label]
    } else {
        link(uri)[#text[#fa[#icon]]]
    }
}

// GitHub 仓库链接简写，如 #ghrepo("your-handle/repo")
#let ghrepo(
    repo, add_link: true, icon: true
) = {
    if add_link {
        if icon {
            iconlink("https://github.com/" + repo, label: repo, icon: github)
        } else {
            link("https://github.com/" + repo)[#repo]
        }
    } else {
        [#fa[#icon] #repo]
    }
}

// 一条经历。主标题左、时间右，下面可挂一行副标题，再下面是正文（通常是列表）。
//
//   tl = 主标题（左）        tr = 时间（右）
//   bl = 副标题（左）        br = 副标题（右）
//
// 例：
//   #cventry(tl: [某某项目], tr: [2025], bl: [负责人])[
//     - 做了什么事
//   ]
#let cventry(
    tl: lorem(2),
    tr: "",
    bl: "",
    br: "",
    content
) = {
    block(
        inset: (left: 0pt),
        text(weight: "bold", size: 1.14em)[#tl] +
        h(1fr) + tr +
        linebreak() +
        if bl != "" or br != "" {
            bl + h(1fr) + br + linebreak()
        } +
        content
    )
}

// 双模式脱敏：同一份源码，编出两份 PDF。
//
//   --input level=submit   投递版，原样输出 body
//   --input level=post     公开版，把 body 换成 alter
//   不传 level             输出黑条，提醒你忘了加参数
//
// alter 是「公开版里显示什么」，可以是任意内容：
//
//   #redact(alter: [your-handle])[张三]        → 公开版显示 your-handle
//   #redact(alter: [Top])[3/120（2.5%）]        → 公开版显示 Top
//   #redact(alter: [])[you\@example.com | ]     → 公开版整段消失
//   #redact(mark: true)[敏感内容]               → 公开版打黑条（不给替代文本时）
//
// 注意：body 要整段包进来。曾经写过
//   #redact(alter: [Top])[3/120（]2.5%#redact(alter: [%])[）]
// 这种「局部替换」的写法，投递版拼出 3/120（2.5%）看着没问题，公开版却拼成
// Top2.5%%——多了一个百分号。分开的片段要保证拼起来正好是你想要的文本。
#let redact(alter: none, mark: false, color: black, body) = {
    let level = sys.inputs.at("level", default: none);
    if level == "submit" {
        body
    } else if level == "post" {
        if alter == none and mark {
            box(hide(body), fill: color)
        } else if alter == none and not mark {
            box(fill: color)[(missing)]
        } else {
            alter
        }
    } else {
        box(fill: color)[(missing)]
    }
}

// 全局版式。改字体、字号、页边距都在这里。
#let chicv(body) = {
    // 中英混排：拉丁字符走 TeX Gyre Pagella（Palatino 的开源克隆），
    // 缺字再回退到思源宋体。想换风格改这两行即可。
    let fonts = (
        "TeX Gyre Pagella",
        "Source Han Serif SC",
    )
    show heading.where(
        level: 1
    ): set text(
        size: 28pt,
        font: fonts,
        weight: "regular",
    )

    show heading.where(
        level: 2
    ): it => text(
        size: 13pt,
        font: fonts,
        weight: "bold",
        block(
            v(0.35em) + chiline() + v(0.14em) + it + v(0.24em),
        )
    )
    set list(indent: 2pt)

    show link: it => underline(offset: 1.8pt, it)
    set page(margin: (x: 0.7cm, y: 1cm), numbering: "1 / 1")
    set par(justify: true, leading: 0.84em)
    set text(font: fonts, size: 10pt, weight: "regular")

    body
}
