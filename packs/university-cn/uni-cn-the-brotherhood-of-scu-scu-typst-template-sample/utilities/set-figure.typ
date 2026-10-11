#import "../fonts/font-def.typ": *

// 设置图表
#let _set_figure(body) ={
    // 设置前缀
    show figure.where(kind: image): set figure(supplement: [图])

    show figure.where(kind: table): set figure(supplement: [表])
    show figure.where(kind: table): set figure.caption(position: top)
    
    // 设置表格使用五号宋体
    show figure.where(kind: table): set text(font: songti, size: 10.5pt)

    // 使用正确的编号与图表标题字体及分隔符
    show figure.caption: set text(font: heiti, size: 10.5pt)
    set figure.caption(separator: "　")

    set math.equation(supplement: [公式])

    body
}
