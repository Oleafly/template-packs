#import "state.typ": course-info
#import "i18n.typ": default-lang
#import "components/page-frame.typ": page-frame
#import "components/typography.typ": typography
#import "components/headings.typ": heading-style
#import "components/code.typ": code-style
#import "components/table.typ": table-style
#import "components/figures.typ": figure-style
#import "components/outline.typ": outline-style, index-page
#import "components/frontmatter.typ": title-block, frontmatter

#let project(
  title: none,
  author: none,
  mail: none,
  date: none,
  version: none,
  university: none,
  university-short: none,
  cdl: none,
  class: none,
  cfu: none,
  lang: default-lang,
  intro: none,
  topics: (), // array di (title, items): mappa argomenti nel frontespizio
  sources: (), // array di chiavi di citations.bib: fonti in evidenza
  body,
) = {
  course-info.update((
    author: author,
    mail: mail,
    university: university,
    university-short: university-short,
    cdl: cdl,
    class: class,
    lang: lang,
    intro: intro,
    topics: topics,
    sources: sources,
  ))

  set document(author: author, title: title)

  show: page-frame.with(cdl: cdl, class: class, university: university)
  show: typography.with(lang: lang)
  show: heading-style
  show: code-style
  show: table-style
  show: figure-style.with(lang: lang)
  show: outline-style

  title-block(title: title, author: author, date: date, cfu: cfu, version: version)
  frontmatter()
  index-page(lang: lang)

  body
}
