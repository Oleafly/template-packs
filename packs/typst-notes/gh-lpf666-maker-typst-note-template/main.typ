#import "@preview/ergo:0.2.0": ergo-colors, ergo-styles
#import "notebook.typ": notebook, title-page
#import "chapters/01-learning/chapter.typ" as learning
#import "chapters/02-mathematics/chapter.typ" as mathematics
#import "chapters/03-algorithms/chapter.typ" as algorithms
#import "chapters/04-ergo-cheatsheet/chapter.typ" as ergo-cheatsheet
#import "chapters/05-git-github/chapter.typ" as git-github

#show: notebook.with(
  title: "Typst 学习笔记模板",
  author: "Your Name",
  short-title: [Typst 学习笔记 · Learning Notes],
  colors: ergo-colors.bootstrap,
  styles: ergo-styles.sidebar1,
)

#title-page(
  title: [Typst 学习笔记],
  subtitle: [A bilingual, multi-chapter notebook powered by Ergo],
  author: [Your Name],
  date: [YYYY-MM-DD],
)

#outline(title: [目录 / Contents], depth: 2, indent: auto)
#pagebreak()

#learning.chapter-content
#mathematics.chapter-content
#algorithms.chapter-content
#ergo-cheatsheet.chapter-content
#git-github.chapter-content
