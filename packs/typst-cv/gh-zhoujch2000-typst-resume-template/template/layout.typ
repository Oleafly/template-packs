#import "icons.typ": *;

#let SHOW_SECTION_ICONS = true // 是否展示模块图标
#let POSITION_TIME_GAP = 17em // 职位和时间之间的距离
#let SHOW_ITEM_BACKGROUND = true // 是否让条目的标题显示一个背景
#let ITEM_BACKGROUND_COLOR = rgb("#e9e6e6") // 条目标题背景颜色

/******** 全局样式 ********/
#let template(doc) = {
    set page(
        margin: (
            x: 0.9cm,
            top: 0.9cm,
            bottom: 0.9cm,
        ), // 页边距
        paper: "a4", // 纸张大小
    )
    set text(
        size: 10.5pt, // 字体大小
        font: ("Palatino Linotype", "Source Han Serif"),
    )
    show link: text
    set par(justify: true) // 段落默认两端对齐
    set list(
        body-indent: 0.1em,
        marker: text(size: 14pt, baseline: -0.05em)[▪],
    ) // 列表前的字符样式
    doc
}

/******** 页眉信息 ********/
#let resume_header(
    title: "",
    name: "",
    pic_path: "",
    description: "",
    keywords: (),
) = {
    set document(
        title: title,
        author: name,
        description: description,
        keywords: keywords,
        date: auto,
    ) // PDF元数据设置
    set align(center)
    text(weight: "bold", size: 25pt)[#name]
    if pic_path != "" {
        place(
            top + right,
            dx: -1em,
            dy: -2em, // 头像的位置
            image(pic_path, height: 28mm),
        )
    }
    set align(left) // 对齐方式改为左对齐
}

/******** 联系信息 ********/
#let contact_info(
    color: rgb(0, 0, 0), // 默认颜色
    separator: " ", // 默认分隔符
    ..infos,
) = {
    set text(fill: color)
    set align(center)
    let items = infos
        .pos()
        .map(dir => {
            box(height: 1.1em)[
                #{
                    if "icon" in dir {
                        if type(dir.icon) == str { icon(dir.icon) } else { dir.icon }
                        h(0.15em)
                    }
                }
                #{
                    if "link" in dir {
                        link(dir.link, dir.content)
                    } else {
                        dir.content
                    }
                }
            ]
        })
    items.join(h(0.5em) + separator + h(0.5em))
}


/******** 分割线 ********/
#let section_divider() = {
    v(-4.5pt) // 分割线上方间距
    line(length: 100%)
    v(-6pt) // 分割线下方间距
}

/******** 模块标题 ********/
#let resume_section(title, icon) = {
    [== #box({
        set text(size: 15pt)
        if SHOW_SECTION_ICONS and icon != none {
            icon
            h(-0.1em)
        }
        text(size: 14.5pt, weight: "extrabold")[#title]
    })]
    section_divider()
}

/******** 条目标题 ********/
// 实习公司/项目名称，部门，职位，时间，是否显示背景，职位和时间之间的间距
#let resume_item(
    title,
    dept,
    position,
    start_time,
    end_time,
    background: SHOW_ITEM_BACKGROUND,
    position_time_gap: POSITION_TIME_GAP,
) = {
    let item_content = [
        // 标题和部门列表（左对齐）
        *#title*
        #if type(dept) == array {
            for d in dept { [·#d] }
        } else if dept != none and dept != "" {
            [·#dept]
        }
        #h(1fr)
        // 职位（中间加粗，距time的宽度可调）
        #box(width: position_time_gap, align(left)[
            #if position != none and position != "" {
                [*#position*]
            }
        ])
        // 时间 (右对齐)
        #if start_time != none and start_time != "" {
            set text(font: "Cambria", features: ("tnum",))
            [*#start_time* —— *#end_time*]
        }
    ]
    if background {
        block(
            width: 100%,
            fill: ITEM_BACKGROUND_COLOR,
            inset: (left: 0.2em, right: 0.2em, top: 0.28em, bottom: 0.28em),
            above: 10pt,
            below: 2pt,
        )[#item_content]
    } else {
        item_content
        linebreak()
    }
}

/******** 条目要点 ********/
#let resume_desc(point, detail) = {
    [- *#point*：#detail]
}
