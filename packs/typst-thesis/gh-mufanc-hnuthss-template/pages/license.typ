#import "/configs.typ": font, fontsize
#import "/components.typ": anchor

#let headline(content) = [
    #set text(font: font.sans, size: fontsize.L2s)
    #set align(center)
    #content
]

#let sign(role) = [
    #text(role)签名：#h(11em)日期：20#h(1.5em) 年 #h(1.5em) 月 #h(1.5em) 日
]

#let checkbox = [
    #box(baseline: 15%, square(size: 1em))
]

#let license = [
    #show parbreak: br => v(0em)

    #anchor[毕业论文（设计）原创性声明和毕业论文（设计）版权使用授权书]

    #v(1em)

    #headline[湖 南 大 学]

    #v(2em)

    #headline[毕业论文（设计）原创性声明]

    #v(0.5em)

    本人郑重声明：所呈交的论文（设计）是本人在导师的指导下独立进行研究所取得的研究成果。除了文中特别加以标注引用的内容外，本论文不包含任何其他个人或集体已经发表或撰写的成果作品。对本文的研究做出重要贡献的个人和集体，均已在文中以明确方式标明。本人完全意识到本声明的法律后果由本人承担。

    #v(1.5em)

    #sign[学生]

    #v(3em)

    #headline[毕业论文（设计）版权使用授权书]

    #v(0.5em)

    本毕业论文（设计）作者完全了解学校有关保留、使用论文（设计）的规定，同意学校保留并向国家有关部门或机构送交论文（设计）的复印件和电子版，允许论文（设计）被查阅和借阅。本人授权湖南大学可以将本论文（设计）的全部或部分内容编入有关数据库进行检索，可以采用影印、缩印或扫描等复制手段保存和汇编本论文（设计）。

    本论文（设计）属于

    #align(center)[
        #box(inset: (left: 4em))[
            #set par(first-line-indent: 0em)
            #set align(left)

            1、保#h(1em)密 #checkbox，在 #box(line(length: 3em, stroke: 0.1pt)) 年解密后适用本授权书。

            2、不保密 #checkbox。

            #h(0.5em)（请在以上相应方框内打“√”）
        ]
    ]

    #v(1.5em)

    #sign[学生]

    #sign[导师]
]
