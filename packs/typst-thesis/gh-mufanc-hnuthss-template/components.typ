// 页眉
#let header = [
    #set text(size: 9pt)
    #align(center, "湖南大学本科生毕业论文（设计）")
    #pad(top: -6pt, line(length: 100%, stroke: 1.5pt))
    #pad(top: -8.5pt, line(length: 100%, stroke: 0.6pt))
]


// 锚点，生成一个不可见的标题以供目录定位
#let anchor(content, level: 1) = [
    #text(size: 0em, heading(level: 1, content))
]

// 假段落，处理 https://github.com/typst/typst/issues/311 的问题
#let fp = context[
    #let base = par(box())
    #(2 * base)
    #let line-height = measure(2 * base).height - measure(base).height
    #v(-2 * line-height)
]

// dirty fix, 抵消刚好在标题后换页时段落内容和页眉重合的问题
#let rfp = v(1em) + parbreak()

// 段落
#let paragraph(content, lp: 0.6em) = [
    #show parbreak: br => br + v(lp)
    #show heading: h => h + fp
    #content
]

#let hstack(captions: none, ..args) = {
    let cntr = counter("subfigure")
    cntr.update(0)
    show image: img => {
        stack(dir: ttb, spacing: 0.5em, img)[
            #cntr.step()
            #if captions != none {
                context {
                    text(weight: "regular")[
                        #cntr.display("(a)") #captions.at(cntr.get().at(0) - 1)
                    ]
                }
            }
        ]
    }
    stack(dir: ltr, spacing: 2em, ..args)
}

