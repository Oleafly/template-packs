// 程序设计课程设计报告封面
// 由 template.typ 中的 course-report 函数调用

#import "../fonts.typ": fonts
#import "cover.typ": cover-info-table, cover-header

#let course-report-cover(metadata) = [
  // 封面页采用对称页边距，使校徽/横幅/标题在整页水平居中
  #set page(margin: (top: 25mm, bottom: 25mm, left: 25mm, right: 25mm))
  #cover-header("../images/course/head.webp",
                "../images/thesis/cover_banner.webp",
                "程序设计课程设计报告")

  #align(center)[
    #cover-info-table((
      ("题    目", metadata.title),
      ("学    院", metadata.school),
      ("专    业", metadata.major),
      ("年级班别", metadata.class_info),
      ("学    号", metadata.student_id),
      ("学生姓名", metadata.author),
      ("指导教师", metadata.advisor),
      ("成    绩", metadata.grade),
    ))

    #v(1fr)
    #text(font: fonts.songti, size: 14pt)[
      #metadata.date.display("[year] 年 [month] 月")
    ]
  ]
  #pagebreak()
]
