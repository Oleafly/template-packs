// 标题样式与自动编号模块
// 四级标题排版：一级居中显示“第X章”，二至四级首行缩进，兼容 numbering: none 的无编号标题

#import "../fonts/font-def.typ": *

#let _set_heading(body) = {
    set heading(numbering: "1.1.1.1")   // 保留，确保计数器正确递增

    show heading: it => {
        if it != none {
            set par(first-line-indent: 0em)
            let is_abstract = it.has("label") and it.label in (<abstract-zh>, <abstract-en>)

            // 摘要标题保留原有视觉样式，同时让 heading.body 只保存纯标题内容。
            // 从目录排除数组中移除摘要标签后，目录因此可以正常继承目录字体。
            if is_abstract {
                set align(center)
                set text(font: heiti, size: 14pt, weight: "regular")
                v(13.6mm)
                it.body
                v(12.4mm)
            } else {
                let vals = counter(heading).at(it.location())

                // 标题明确标注 numbering: none 时，不添加编号。
                let num = if it.numbering == none {
                    none
                } else if it.level == 1 {
                    numbering("第1章", vals.first())
                } else {
                    numbering("1.1.1.1", ..vals)
                }
                
                // 只有存在编号时，才添加编号与标题正文之间的间距。
                let content = if num == none {
                    it.body
                } else {
                    num + h(3mm) + it.body
                }
                if it.level == 1 {
                    set align(center)
                    set text(font: heiti, size: 16pt, weight: "regular")
                    set par(leading: 0em, spacing: 0em)
                    set block(spacing: 0em)
                    v(13.2mm)
                    content
                    v(12.2mm)
                } else if it.level == 2 {
                    set text(font: heiti, size: 14.2pt, weight: "regular")
                    set par(leading: 0em, spacing: 0em, first-line-indent: 2em)
                    set block(spacing: 0em)
                    v(6mm)
                    content
                    v(6mm)
                } else if it.level == 3 {
                    set text(font: heiti, size: 13pt, weight: "regular", )
                    set par(leading: 0em, spacing: 0em, first-line-indent: 2em)
                    set block(spacing: 0em)
                    v(3.25mm)
                    content
                    v(3.25mm)
                } else if it.level == 4 {
                    set text(font: heiti, size: 13pt, weight: "regular")
                    set par(leading: 0em, spacing: 0em, first-line-indent: 2em)
                    set block(spacing: 0em)
                    v(3mm)
                    content
                    v(3mm)
                } else {
                    content
                }
            }
        } else {
            ""
        }
    }
    body
}
