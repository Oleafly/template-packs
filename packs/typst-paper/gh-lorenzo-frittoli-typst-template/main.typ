#import "lib.typ": *

#let meta = toml("metadata.toml")

#show: show-theorion
#show: article.with(
  cols: none, // Tip: use #colbreak() instead of #pagebreak() to seamlessly toggle columns
  header-display: true,
  eq-chapterwise: true,
  eq-numbering: "(1,1)",

  header-title: meta.title,
  lang: meta.lang,
)

// Frontmatter
#maketitle(
  title: meta.title,
  authors: meta.authors,
  date: datetime.today().display("[day]. [month repr:long] [year]"),
)
