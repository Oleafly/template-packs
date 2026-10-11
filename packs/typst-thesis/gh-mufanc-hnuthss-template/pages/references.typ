#import "/configs.typ": font, fontsize

// Tips：你可以用这个工具将 BibTeX 格式的引用转换为 Hayagriva 格式
// - https://jonasloos.github.io/bibtex-to-hayagriva-webapp

#let references = [
    // 标题居中、标题字体
    #show heading.where(depth: 1): set align(center)
    #show heading.where(depth: 1): set text(size: fontsize.L3, font: font.sans, weight: "regular")

    // 标题与内容间距
    #show heading: h => h + v(1em)

    // 内容字体
    #set text(size: fontsize.L5)

    #bibliography("/references.yml", style: "gb-7714-2015-numeric")
]
