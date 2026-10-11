gggg//=============================================================================================
//=============================================================================================
//=============================================================================================
//==================== 公共变量 ====================

#let 字号 = (初号: 42pt, 小初: 36pt, 一号: 26pt, 小一: 24pt, 二号: 22pt, 小二: 18pt, 三号: 16pt, 小三: 15pt, 四号: 14pt, 中四: 13pt, 小四: 12pt, 五号: 10.5pt, 小五: 9pt,  六号: 7.5pt,  小六: 6.5pt,  七号: 5.5pt,  小七: 5pt,)

#let 罗马数字 = ("0","Ⅰ","II","III","IV","V","VI","VII","VIII","IX","X","XI","XII","XIII","XIV","XV","XVI","XVII","XVIII","XIX","XX","XXI","XXII","XXIII","XXIV","XXV","XXVI","XXVII","XXVIII","XXIX","XXX")

#let 字体 = (
  仿宋: ("Times New Roman", "STFangsong"), 
  宋体: ("Times New Roman", "STSong"),  
  黑体: ("Arial", "STHeiti"), 
  楷体: ("Times New Roman", "STKaiti"), 
  代码: ("Menlo", "Times New Roman", "Courier New",),
)

//==================================================
//==================================================
//==================== 伪粗体 =======================

#let emph(..arguments, content) = {
    let args = (
        color: black,
        bold: 4,
    )
    args += arguments.named()
    context {
        let textsettings = if args.color == none {(fill:text.fill)} else {(fill:args.color)}
        let strokesetting = if args.color == none {
            (thickness:args.bold*0.01em, paint:text.fill)
            } else {(thickness:args.bold*0.01em, paint:args.color)}
        let argu = textsettings + (stroke:strokesetting)
        set text( ..argu)
        content
    }
}

//==================================================
//==================================================
//==================== 添加空白页 ====================

#let pagebreakToOdd() = {
    set page(header: none, footer: none)
    pagebreak(to:"odd")
}

#let pagebreakToEven() = {
    set page(header: none, footer: none)
    pagebreak(to:"even")
}

//=============================================================================================
//=============================================================================================
//=============================================================================================

//=============================================================================================
//=============================================================================================
//============= 全局设置 =======================================================================

#let setDocuments(..arguments, it) = {
    let args = (
        //-------- 页面设置 ----------
        上页边距: 2.5cm,
        下页边距: 3.0cm,
        左页边距: 2.6cm,
        右页边距: 2.6cm,
        //-------- 标题设置 ----------
        标题字体一级: 字体.黑体,
        标题字号一级: 字号.三号,
        标题字体二级: 字体.黑体,
        标题字号二级: 字号.小四,
        标题字体三级: 字体.黑体,
        标题字号三级: 字号.小四,
        标题对齐一级: center,
        标题样式一级: "第一章",
        标题样式二级: "1.1",
        标题样式三级: "1.1",
        标题段前间距: 0.0em,
        标题段后间距: 1.3em,
        //---------- 正文设置 ----------
        行间距长度: 1.3em,
        段间距长度: 0.0em,
        首行缩进长度: 2em,
        正文字号: 字号.小四,
        正文字体: 字体.宋体,
        正文语言: "zh",
        //---------- 图表设置 ----------
        图表标题字体: 字体.黑体,
        图表标题字号: 字号.五号,
        表格正文字体: 字体.宋体,
        表格正文字号: 字号.五号,
        图表标题间距: 1em,
        图表标题分隔: [. ],
        图片拉伸模式: "stretch",
        //---------- 脚注设置 ----------
        脚注字体: 字体.宋体,
        脚注字号: 字号.小五,
        脚注编号样式: "①",
        脚注文中字号: 字号.四号,
        脚注前留白: 1em,
        脚注行间距: 0.5em,
        脚注缩进: 0pt,
        //---------- 代码设置 ----------
        代码字体: 字体.代码,
        代码字号: 1.12em,//字号.五号,
        段内代码背景色: luma(240),
        段内代码圆角半径: 1pt,
        段内代码横内边距: 1em,
        段内代码纵内边距: 0pt,
        段内代码横外边距: 0pt,
        段内代码纵外边距: 0.5em,
        代码框背景色: luma(240),
        代码框圆角半径: 5pt,
        代码框宽度: 100%,
        代码框横内边距: 2.5em,
        代码框纵内边距: 1em,
        代码框横外边距: 0pt,
        代码框纵外边距: 0pt,
        代码框对齐方式: center,
        代码行间距: 0.65em,
        //---------- 公式设置 ----------
        数学公式编号格式: "(1)",
        //---------- 目录设置 ----------
        目录标题字体: 字体.黑体,
        目录标题字号: 字号.三号,
        目录正文字体: 字体.宋体,
        目录正文字号: 字号.小四,
        目录字体一级: 字体.黑体,
        目录字号一级: 字号.小四,
        目录行距: 1.0em,
        目录段间距一级: 1.2em,
        //---------- 附件设置 ----------
        附件标题字体: 字体.黑体,
        附件标题字号: 字号.三号,
        附件标题对齐: center,
        //---------- 页眉设置 ----------
        页眉字体: 字体.宋体,
        页眉字号: 字号.五号,
        页眉间距: 1em,
        对齐方式: center,
        页眉横线粗细: 0.5pt,
        页眉底部间距: 3pt,
        页眉行间距: 0pt,
        页眉段间距: 0pt,
        页眉横线长度: 100%,
        //---------- 页脚设置 ----------
        页脚字体: 字体.宋体,
        页脚字号: 字号.小五,
        页码对齐: center,
        //---------- 系统日期 ----------
        日期: datetime.today(),
    )
    args += arguments.named()

    //====================================================
    //==================== set页面 ========================
    //====================================================
    set page(
        //---------- set 页边距 ---------- 
        margin: (
            top: args.上页边距, 
            bottom: args.下页边距,
            left: args.左页边距,
            right: args.右页边距
        ),
        //----------  set 页脚页码 ---------- 
        footer: context [
            #set align(args.页码对齐)
            #set text(font:args.页脚字体, size:args.页脚字号)
            #counter(page).display("1")
        ],
        //---------- set 页眉 ---------- 
        header-ascent: args.页眉间距,  
        footer-descent: args.页眉间距, 
        header: [
            #counter(footnote).update(0)
            #set align(args.对齐方式); 
            #set par(leading: args.页眉行间距,spacing: args.页眉行间距+args.页眉段间距); 
            #set text(font: args.页眉字体, size:args.页眉字号); 

            #let showheader(it) = {
                if calc.even(here().page()) {
                    [北京大学博士学位论文]
                } else {
                    if it.has("caption") {
                        it.caption.body
                    } else {
                        numbering(args.标题样式一级,counter(heading).at(it.location()).first())
                    }
                }
                v(args.页眉底部间距) 
                line(length: args.页眉横线长度, stroke: args.页眉横线粗细)
            }
            #context {
                let nextheadings = query(heading.where(level: 1).after(here())
                    .or(figure.where(kind:"accessory").after(here())))
                let lastheadings = query(heading.where(level: 1).before(here())
                    .or(figure.where(kind:"accessory").before(here())))
                if nextheadings != () and lastheadings != () {
                    if nextheadings.first().location().page() == here().page() {
                        showheader(nextheadings.first())
                    } else {
                        showheader(lastheadings.last())
                    }
                } else if nextheadings == () and lastheadings != () {
                    showheader(lastheadings.last())
                }
                else {
                    if nextheadings.first().location().page() == here().page() {
                        showheader(nextheadings.first())
                    }
                }
            }
        ]
    )

    //====================================================
    //==================== set 标题 ====================
    //====================================================
    show heading: set block(above: args.标题段前间距, below:args.标题段后间距)
    show heading.where(level: 1): set heading(numbering: args.标题样式一级)
    show heading.where(level: 2): set heading(numbering: args.标题样式二级)
    show heading.where(level: 3): set heading(numbering: args.标题样式三级)
    show heading.where(level: 2): set text(font: args.标题字体二级, size: args.标题字号二级)
    show heading.where(level: 3): set text(font: args.标题字体三级, size: args.标题字号三级)
    show heading.where(level: 1): it => {
        set text(font: args.标题字体一级, size: args.标题字号一级)
        set align(args.标题对齐一级); it
    }

    //====================================================
    //==================== set段落 ====================
    //====================================================
    set par(
        leading: args.行间距长度,  
        spacing: args.行间距长度 + args.段间距长度,  
        first-line-indent: (amount: args.首行缩进长度, all:true),
        justify: true,  
        linebreaks: "optimized",
    )

    //====================================================
    //==================== set 正文 ====================
    //====================================================
    set text(
        lang: args.正文语言, 
        font: args.正文字体, 
        size: args.正文字号,
    )  

    //====================================================
    //==================== set 图表 ====================
    //====================================================
    show figure.caption: set block(above: args.图表标题间距, below:args.图表标题间距)
    set image(fit: args.图片拉伸模式)
    set figure.caption(separator: args.图表标题分隔)
    show figure: it => {
        if it.kind == "accessory" {
            set text(font:args.附件标题字体, size:args.附件标题字号)
            align(args.附件标题对齐)[#it.caption]
        } 
        else if it.kind == table {
            set figure.caption(position: top); 
            set text(font: args.图表标题字体, size:args.图表标题字号)
            it.caption
            set text(font: args.表格正文字体, size:args.表格正文字号)
            it.body
        } else if it.kind == raw {
            set text(font: args.图表标题字体, size:args.图表标题字号)
            set figure.caption(position: top); it
        } else {it}
    }

    //====================================================
    //==================== set 公式 ====================
    //====================================================
    set math.equation(numbering: args.数学公式编号格式)

    //====================================================
    //==================== set 脚注 ====================
    //====================================================
    set footnote(numbering: args.脚注编号样式)
    show footnote: it => {
        set text(size:args.脚注文中字号); it
    }

    show footnote.entry: it => {
        set footnote.entry(clearance: args.脚注前留白,  gap: args.脚注行间距, indent:args.脚注缩进)
        set text(font: args.脚注字体, size: args.脚注字号)
        let loc = it.note.location()
        numbering(args.脚注编号样式, ..counter(footnote).at(loc),)
        h(1em)
        it.note.body
    }

    //====================================================
    //==================== set 代码 ====================
    //====================================================
    show raw.where(block: false): box.with(
        fill: args.段内代码背景色,
        radius: args.段内代码圆角半径,
        inset: ( x: args.段内代码横内边距, y: args.段内代码纵内边距),
        outset: (x: args.段内代码横外边距, y: args.段内代码纵外边距),
    )
    show raw.where(block: true): it => {
        set block(
            fill: args.代码框背景色,
            width: args.代码框宽度, 
            radius: args.代码框圆角半径,
            inset: (x: args.代码框横内边距, y: args.代码框纵内边距),  
            outset: (x: args.代码框横外边距, y: args.代码框纵外边距),
        )
        set align(args.代码框对齐方式)
        set text(font:args.代码字体, size:args.代码字号)
        set par(leading: args.代码行间距)
        it
    }

    //====================================================
    //==================== set 目录 ====================
    //====================================================
    show outline.entry: it => {
        if it.element.func() == figure and int(it.page().text) < 10 {
            link(
            it.element.location(),
            it.indented(
                it.prefix(), 
                it.body()+box(width: 1fr, it.fill)+罗马数字.at(int(it.page().text)))
                )
        }
        else{
            link(
            it.element.location(),
            it.indented(it.prefix(), it.inner()))
        }
    }
    show outline.entry.where(level: 1): it => {
        set block(above: args.目录段间距一级)
        set text(font:args.目录字体一级, size:args.目录字号一级)
        it
    }
    it
}

//=============================================================================================
//=============================================================================================
//=============================================================================================


//=============================================================================================
//=============================================================================================
//=============================================================================================
//==================== 添加无编号附件页 ====================

#let addAccessoryHeading( ..arguments) = {
    let args = (
        标题: [附件],
        收入目录: true,
    )
    args += arguments.named()
    set text(size:5pt)
    figure(
        none,
        kind:"accessory",
        caption: args.标题,
        supplement: none,
        numbering: none,
        outlined: args.收入目录
    )
}

//=============================================================================================
//=============================================================================================
//=============================================================================================
//==================== 添加封面页 ====================

#let addFrontPage( ..arguments) = {
    set page(footer: none,)
    set par(leading: 1em,spacing: 0.3em)
    block(height: 1cm)  
    figure(
        image("logo.png", width: 8.41cm, height: 2.36cm),
    )
    set text(font: 字体.黑体, size: 字号.小初)
    align(center)[博士研究生学位论文]
    v(0.3em)

    align(center)[
        #table(
            columns: (2.75cm,10.8cm),
            rows: 1.48cm,
            stroke: none,
            align: (left,center),
            inset: (
                x: 0.19cm,
            ),
            [#set text(font: 字体.宋体, size: 字号.二号); #align(horizon)[题目： ]], 
            [#set text(font: 字体.黑体, size: 字号.一号); #align(horizon)[博士毕业论文]],
            table.hline(stroke: 0.5pt,  start: 1),
            [], [#set text(font: 字体.黑体, size: 字号.一号); #align(horizon)[typst模板]],
            table.hline(stroke: 0.5pt,  start: 1),
        )
    ]
    v(4.0cm)
    align(center)[
        #table(
            columns: (3.2cm,7.65cm),
            rows: 1.2cm,
            stroke: none,
            align: (center,center),
            inset: (x: 0.19cm,),
            [#set text(font: 字体.黑体, size: 字号.小三); #align(horizon)[姓#h(2em)名：]], 
            [#set text(font: 字体.仿宋, size: 字号.三号); #align(horizon)[姓名]],
            table.hline(stroke: 0.5pt,  start: 1),
            [#set text(font: 字体.黑体, size: 字号.小三); #align(horizon)[学#h(2em)号：]], 
            [#set text(font: 字体.仿宋, size: 字号.三号); #align(horizon)[学号]],
            table.hline(stroke: 0.5pt,  start: 1),
            [#set text(font: 字体.黑体, size: 字号.小三); #align(horizon)[院#h(2em)系：]], 
            [#set text(font: 字体.仿宋, size: 字号.三号); #align(horizon)[院系]],
            table.hline(stroke: 0.5pt,  start: 1),
            [#set text(font: 字体.黑体, size: 字号.小三); #align(horizon)[专#h(2em)业：]], 
            [#set text(font: 字体.仿宋, size: 字号.三号); #align(horizon)[专业]],
            table.hline(stroke: 0.5pt,  start: 1),
            [#set text(font: 字体.黑体, size: 字号.小三); #align(horizon)[研究方向：]], 
            [#set text(font: 字体.仿宋, size: 字号.三号); #align(horizon)[研究方向]],
            table.hline(stroke: 0.5pt,  start: 1),
            [#set text(font: 字体.黑体, size: 字号.小三); #align(horizon)[导师姓名：]], 
            [#set text(font: 字体.仿宋, size: 字号.三号); #align(horizon)[导师姓名]],
            table.hline(stroke: 0.5pt,  start: 1),
        )
    ]
    v(1.5cm)
    align(center)[
        #set text(font: 字体.仿宋, size: 字号.三号)
        \u{2610} 学术学位 #h(1em) \u{2610} 专业学位
    ]    
    v(0.7em)
    align(center)[
        #set text(font: 字体.宋体, size: 字号.三号)
        二〇二五
        #set text(font: 字体.黑体, size: 字号.三号)
        年
        #set text(font: 字体.宋体, size: 字号.三号)
        八
        #set text(font: 字体.黑体, size: 字号.三号)
        月
    ]
    pagebreakToOdd()
}

//=============================================================================================
//=============================================================================================
//=============================================================================================
//==================== 添加参考文献列表页 ====================

#let addBibliographyPage(path, ..arguments) = {
    let args = (
        参考文献标题: [参考文献],
        参考文献列表字体: 字体.楷体,
        参考文献列表字号: 字号.小四,
        参考文献列表行间距: 0.8em,
        参考文献列表段间距: 0.5em,
        参考文献首行缩进: 0pt
    )
    args += arguments.named()
    show bibliography: it => {
        set text(
            lang: "en", 
            font: args.参考文献列表字体, 
            size: args.参考文献列表字号
        )
        show heading: set heading(numbering: none)
        it
    }
    set par(
        first-line-indent: args.参考文献首行缩进, 
        leading:args.参考文献列表行间距, 
        spacing: args.参考文献列表行间距 + args.参考文献列表段间距,
    )
    v((0.5cm))
    addAccessoryHeading(标题:args.参考文献标题)

    bibliography(path, title: none) // title系统默认使用一级标题的设置
    pagebreakToOdd()
}

//=============================================================================================
//=============================================================================================
//=============================================================================================
//==================== 添加目录页 ====================

#let addOutlinePage( ..arguments) = {
    let args = (
        目录标题: [目#h(1em)录],
        标题字体: 字体.黑体,
        标题字号: 字号.四号,
        目录字体: 字体.宋体,
        目录字号: 字号.小四,
        目录行间距: 0.8em,
        目录段间距: 0.5em,
        目录缩进: 2em,
        目录层级: 3,
        标题对齐: center,
        页脚字体: 字体.宋体,
        页脚字号: 字号.小五,
        页码对齐: center,
    )
    args += arguments.named()
    set page(
        footer: context [
            #set align(args.页码对齐)
            #set text(font:args.页脚字体, size:args.页脚字号)
            #counter(page).display("I")
        ]
    )
    set par(
            first-line-indent: (amount:0pt, all:true),
            leading: args.目录行间距, 
            spacing: args.目录行间距 + args.目录段间距
    )
    v((0.5cm))
    addAccessoryHeading(标题:[目录])

    set text(font: args.目录字体, size: args.目录字号)
    outline(title: none, target: heading.where(outlined: true).or(figure.where(kind:"accessory")), depth: args.目录层级, indent: args.目录缩进)

    pagebreakToOdd()
}

//=============================================================================================
//=============================================================================================
//=============================================================================================
//==================== 添加版权说明页 ====================

#let addCopyrightPage() = {
    set page(header:none, footer: none)
    v(1cm)
    addAccessoryHeading(标题:[版权声明], 收入目录:false)
    v(1.5cm)
    [任何收存和保管本论文各种版本的单位和个人，未经本论文作者同意，不得将本论文转借他人，亦不得随意复制、抄录、拍照或以任何方式传播。否则，引起有碍作者著作权之问题，将可能承担法律责任。]

    pagebreakToOdd()
}

//=============================================================================================
//=============================================================================================
//=============================================================================================
//==================== 添加摘要页 ====================

#let addAbstractPage() = {
    counter(page).update(1)
    let args = (
        页脚字体: 字体.宋体,
        页脚字号: 字号.小五,
        页码对齐: center,
    )
    set page(
        footer: context [
            #set align(args.页码对齐)
            #set text(font:args.页脚字体, size:args.页脚字号)
            #counter(page).display("I")
        ]
    )
    v(1cm)
    addAccessoryHeading(标题:[摘要])
    v(1cm)
    [论文#footnote[本研究得到某某基金（编号：XXX）资助。]摘要是对论文内容不加注释和评论的简短陈述#footnote[你懂你懂你懂你懂你懂你懂你懂你懂]，其目的是让读者不阅读论文全文即能获得必要的信息. 论文摘要应包含以下内容：①从事这一研究的目的和重要性；②研究的主要内容，指明完成了哪些工作；③获得的基本结论和研究成果，突出论文的新见解；④结论或结果的意义. 论文摘要的文字必须十分简炼，内容亦需充分概括，篇幅大小一般限制其字数不超过论文字数的5%. 论文摘要的四要素分别是：目的、方法、结果和结论.]
    v(1cm)
    [关键词：关键词1，关键词2，关键词3……]

    pagebreakToOdd()

    v(1cm)
    align(center)[#set text(font:"Arial", size:字号.三号); English Title]
    v(1cm)

    align(center)[Author Name ( Major )]
    align(center)[Supervised by your Supervisor]

    v(1cm)
    addAccessoryHeading(标题:[ABSTRACT])

    v(1cm)
    [In environmental economics, environmental resources including environmental quality are categorized as amenity resources. Due to its importance to human welfare, the amenity resources theoretical study and valuation is an ongoing issue at the academic frontier in the environmental economics area.]
    v(1cm)
    [KEY WORDS: Key word 1, Key word 2, Key word 3, ……]

    pagebreakToOdd()
}

//=============================================================================================
//=============================================================================================
//=============================================================================================
//==================== 添加致谢页 ====================

#let addAcknowledgementPage() = {
    v(1cm)
    addAccessoryHeading(标题:[致谢])
    v(1cm)

    [本论文是在xx老师的悉心指导下完成的。xx老师作为一名优秀的、经验丰富的教师，具有丰富的xx知识和xx经验，在整个论文实验和论文写作过程中，对我进行了耐心的指导和帮助，提出严格要求，引导我不断开阔思路，为我答疑解惑，鼓励我大胆创新，使我在这一段宝贵的时光中，既增长了知识、开阔了视野、锻炼了心态，又培养了良好的实验习惯和科研精神。在此，我向我的指导老师表示最诚挚的谢意！]

    pagebreakToOdd()
}

//=============================================================================================
//=============================================================================================
//=============================================================================================
//==================== 添加原创说明页 ====================



#let addStatementPage() = {
    v(1cm)
    addAccessoryHeading(标题:[北京大学学位论文原创性声明和使用授权说明])
    v(1cm)

    align(center)[#set text(size:字号.四号); #emph()[原创性声明]]
    v(0.3cm)

    [本人郑重声明：所呈交的学位论文，是本人在导师的指导下，独立进行研究工作所取得的成果。除文中已经注明引用的内容外，本论文不含任何其他个人或集体已经发表或撰写过的作品或成果。对本文的研究做出重要贡献的个人和集体，均已在文中以明确方式标明。本声明的法律结果由本人承担。]
    v(0.4cm)

    align(right)[#h(5cm)论文作者签名： #h(2cm) 日期： #h(0.5cm)    年 #h(0.2cm)  月 #h(0.2cm) 日]

    v(2cm)
    align(center)[#set text(size:字号.四号); #emph()[学位论文使用授权说明]]
    v(0.3cm)

    [本人完全了解北京大学关于收集、保存、使用学位论文的规定，即：]
    v(0cm)

    [\u{25CF} #h(1em)按照学校要求提交学位论文的印刷本和电子版本； ]
    v(0cm)

    [\u{25CF} #h(1em)学校有权保存学位论文的印刷本和电子版，并提供目录检索与阅览服务，在校\ #h(3.85em)园网上提供服务； ]
    v(0cm)

    [\u{25CF} #h(1em)学校可以采用影印、缩印、数字化或其它复制手段保存论文； \ ]
    v(0cm)

    [\u{25CF} #h(1em)因某种特殊原因需要延迟发布学位论文电子版，授权学校 \u{2610}一年/ \u{2610}两年/ \u{2610}三 \ #h(3.85em) 年以后，在校园网上全文发布。 \ ]

    align(center)[（保密论文在解密后遵守此规定）]
    v(2cm)

    align(center)[论文作者签名：   #h(2.5cm)      导师签名：]
    v(0.5cm)

    align(right)[#h(5cm)日期： #h(0.5cm)    年 #h(0.2cm)  月 #h(0.2cm) 日 #h(3cm)]

    pagebreakToEven()
}



