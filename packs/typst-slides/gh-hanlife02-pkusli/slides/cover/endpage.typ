#import "../../style/cover/homepage.typ": cover-slide

#let end-page(
  ..cover-args,
  title: [感谢老师和同学批评指正],
  subtitle: none,
  author: none,
  institution: none,
  date: none,
) = cover-slide(
  ..cover-args,
  title: title,
  subtitle: subtitle,
  author: author,
  institution: institution,
  date: date,
)
