// 图 / 表 / 公式题注样式模块
// 统一配置插图、表格和行间公式的中文题注标签、位置及字体

#import "../fonts/font-def.typ":*

#let _set_figure(body) = {
    show figure.where(kind: image): set figure(supplement: [图])
    show figure.where(kind: image): set figure.caption(position: bottom)
    show figure.where(kind: table): set figure(supplement: [表])
    show figure.where(kind: table): set figure.caption(position: top)
    show figure.caption: set text(font: heiti)
    set figure.caption(separator: " ")
    set math.equation(supplement: [公式])
    body
}