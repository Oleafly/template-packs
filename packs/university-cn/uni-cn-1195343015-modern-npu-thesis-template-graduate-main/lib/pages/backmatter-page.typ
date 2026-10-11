#import "../utils.typ": page-title

// 后置部分通用页面（致谢、毕业设计小结、学术成果等）
// 换页、标题样式、正文格式全部由 mainmatter 继承
#let backmatter-page(
  title-key,
  graduate: false,
  english-writing: false,
  body,
) = {
  heading(level: 1, numbering: none, outlined: true, page-title(title-key, graduate: graduate, english-writing: english-writing))
  body
}
