// 默认本科生毕业论文的页面设置 (CS 格式)
#import "../fonts/font-def.typ": *

// 页面大小
#let _set_paper_page_size(body) = {
    set page(paper: "a4", margin: (
        top: 2.5cm,
        bottom: 2.5cm,
        left: 2.5cm,
        right: 2cm
    ))

    body
}

// 页面布局
#let _set_paper_page_par(body) = {
    set text(font: songti, 12pt)
    set par(justify: true, leading: 1.24em, first-line-indent: 2em, spacing: 20pt)
    // set par(spacing: 20pt)
    body
}

// 页眉
#let _set_paper_page_header(anonymous: false, title: "",  body) = {
    set page(
        header: {
            set par(spacing: 12pt)
            set text(font: songti, 10pt, baseline: 8pt)
            [四川大学本科生课程论文]; 
            h(1fr); 
            if title != "" {
                title;
            }
            line(length: 100%, stroke: 0.7pt)
        },
        header-ascent: 1cm
    )
    
    body
}

// 摘要部分页脚
#let _set_paper_page_footer_pre(body) = {
    set page(
        footer: {
            set align(center)            
            context {
                text(font: songti, 10pt, baseline: -3pt, 
                    counter(page).display("I")
                )
            }
        },
        footer-descent: 1cm
    )

    body
}

// 正文部分页脚
#let _set_paper_page_footer_main(body) = {
    set page(
        footer: {
            set align(center)
            context {
                text(font: songti, 10pt, baseline: -3pt, 
                    counter(page).display("1")
                )
            }
        },
        footer-descent: 1cm
    )

    body
}