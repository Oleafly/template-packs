#import "/configs.typ": font, fontsize
#import "/components.typ": header

// 默认字体：宋体、小四
#set text(lang: "zh", size: fontsize.L4s, font: font.serif)

// - 封面 - // 

#import "/pages/cover.typ": cover

#cover(
    project: "这是一个测试项目名字长长长长长长长长长长", 
    name: "旅行者", 
    id: "314159265358", 
    class: "测试 1234 班", 
    college: "学院名称长长长长长", 
    supervisor: "无名氏",
    date: datetime.today()
)

#pagebreak()

// - 原创性声明 & 版权使用授权书 - // 

#set page(
    // 上边距：30mm；下边距：25mm；左边距：30mm；右边距：20mm
    margin: (top: 30mm, bottom: 25mm, left: 30mm, right: 20mm),
    header: header
)

#set par(
    leading: 1.5em,         // 1.5 倍行距
    justify: true,          // 文本两端对齐
    first-line-indent: 2em  // 首行缩进
)

#set page(numbering: "I")
#counter(page).update(1)

#import "/pages/license.typ": license

#license

#pagebreak()

// - 中文摘要 - //

#import "/pages/abstract.typ"

#abstract.zh

#pagebreak()

// - 英文摘要 - //

#abstract.en

#pagebreak()

// - 目录 - //

#import "/pages/outlines.typ"

#outlines.list-of-contents

#pagebreak()

// - 插图索引 - //

#outlines.list-of-figures

#pagebreak()

// - 附表索引 - //

#outlines.list-of-tables

#pagebreak()

// - 正文 - //

// 更新页码
#set page(numbering: "1")
#counter(page).update(1)

#import "/pages/substance.typ"

#substance.main

#pagebreak()

// - 参考文献 - //

#import "/pages/references.typ": references

#references

#pagebreak()

// - 致谢 - //

#import "/pages/acknowledgments.typ": acknowledgments

#acknowledgments
