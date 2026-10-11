// 多文献交叉引用辅助模块
// 支持在单对 < > 号内同时引用多篇文献，简化正文引用写法

#let bib_cite(..names) = {
    for name in names.pos() {
        cite(name)
    }
}