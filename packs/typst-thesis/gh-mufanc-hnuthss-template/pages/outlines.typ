#import "@preview/i-figured:0.2.4"

#import "/configs.typ": font, fontsize
#import "/components.typ": anchor

#let title(content) = [
    #align(center, text(font: font.sans, size: fontsize.L3, content))
]

// 目录
#let list-of-contents = [
    #title[目#h(3.5em)录]

    // 目录中一级标题用小四号黑体，其余用小四号宋体
    #set text(size: fontsize.L4s)
    #show outline.entry.where(level: 1): set text(font: font.sans)

    #outline(title: [], indent: auto)
]

#let list-of-figures = [
    #anchor("插图索引")
    #title("插图索引")
    #outline(
        title: [], 
        target: figure.where(kind: i-figured._prefix + repr(image))
            .or(figure.where(kind: i-figured._prefix + repr(raw)))
    )
]

#let list-of-tables = [
    #anchor("附表索引")
    #title("附表索引")
    #outline(title: [], target: figure.where(kind: i-figured._prefix + repr(table)))
]
