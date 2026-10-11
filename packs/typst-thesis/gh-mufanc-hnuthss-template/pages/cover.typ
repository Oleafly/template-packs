#import "/configs.typ": font, fontsize

#let basic_info(..info) = [
    #let info = info.named()

    #set align(center)

    #show table.cell.where(x: 0): set text(font: font.sans, size: fontsize.L4)
    #show table.cell.where(x: 1): set text(size: fontsize.L3s)
    #show table.cell.where(x: 0, y: 0): content => [
        #set text(size: fontsize.L2s, weight: 600)
        #set par(justify: true)
        #content
    ]
    #show table.cell.where(x: 1, y: 0): content => [
        #set par(leading: 1.4em, justify: true)
        #content
    ]

    #table(
        columns: (5.1cm, 7.5cm),
        rows: 1.07cm,
        // 自动换行的 dirty fix
        inset: (x, y) => if x == 1 and y == 0 { (x: 5pt, y: 12pt) } else { 5pt },
        align: (x, y) => 
            if x == 1 and y == 0 { left + top }  // 自动换行的 dirty fix 
            else if x == 0 { right + bottom }
            else if x == 1 { left + bottom },
        stroke: (x, y) => if x == 1 { (bottom: 0.1pt) } else { none },
        column-gutter: 3pt,
        "论文（设计）题目:", info.project,
        "", "",
        "学 生 姓 名：", info.name,
        "学 生 学 号：", info.id,
        "专 业 班 级：", info.class,
        "学 院 名 称：", info.college,
        "指 导 老 师：", info.supervisor
    )
]

#let cover(..info) = [
    #page(
        background: align(center + top)[
            #v(3cm)
            #image("/assets/logos/logo-grayscale.svg", width: 12cm)
        ]
    )[
        #align(center, image("/assets/logos/logo-text-grayscale.svg", width: 7cm))

        #v(1.5cm)
        #text(size: 45pt, " 本科生毕业论文(设计)")

        #v(2.5cm)
        #basic_info(..info)

        #let date = info.named().date
        #align(center + bottom, text(size: fontsize.L4)[
            #date.year() 年 #date.month() 月 #date.day() 日
        ])
    ]
]
