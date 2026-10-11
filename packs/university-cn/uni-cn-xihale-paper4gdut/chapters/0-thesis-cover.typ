// 本科毕业设计（论文）封面
// 由 template.typ 中的 thesis 函数调用

#import "../fonts.typ": fonts
#import "cover.typ": cover-info-table, cover-header

#let thesis-cover(metadata) = [
  // 封面页采用对称页边距，使校徽/横幅/标题在整页水平居中
  // （正文用 30/20mm 不对称边距是为装订留位，封面不需要）
  #set page(margin: (top: 25mm, bottom: 25mm, left: 25mm, right: 25mm))
  #cover-header("../images/thesis/cover_logo.webp",
                "../images/thesis/cover_banner.webp",
                "本科毕业论文",
                logo-width: 1.5cm,
                banner-width: 8cm)

  #align(center)[
    #text(font: fonts.heiti, size: 22pt, weight: "bold")[#metadata.title]
    #if metadata.title_en != "" [
      #v(0.3em)
      #text(font: fonts.heiti, size: 18pt, weight: "bold")[#metadata.title_en]
    ]
    #v(2cm)

    #cover-info-table((
      ("学　　院", metadata.school),
      ("专　　业", metadata.major),
      ("年级班别", metadata.class_info),
      ("学　　号", metadata.student_id),
      ("学生姓名", metadata.author),
      ("指导教师", metadata.advisor),
    ))

    #v(1.5cm)
    #text(font: (fonts.times, fonts.songti), size: 16pt)[
      #metadata.date.display("[year] 年 [month] 月")
    ]
  ]
  #pagebreak()
]
