#import "common.typ": *
#import "cover.typ": chinese-cover, english-cover, committee-page
#import "statement.typ": statement-page
#import "frontmatter.typ": abstract-page, contents-page, nomenclature-page
#import "backmatter.typ": special-chapter, experience-page
#import "components.typ": thesis-pagebreak, thesis-figure, thesis-table, academic-table, caption-note

#let header-content(info, fonts) = context {
  let page-number = counter(page).get().first()
  let page-location = here().page()
  let headings = query(heading.where(level: 1)).filter(item => item.location().page() <= page-location)
  let current = if headings.len() > 0 { headings.last() } else { none }
  let current-title = if current == none {
    []
  } else if current.numbering == none {
    current.body
  } else {
    let numbers = counter(heading).at(current.location())
    [#chapter-numbering(..numbers) #current.body]
  }
  let university-title = [北京邮电大学#degree-name-zh(info)学位论文]
  let title = if calc.even(page-number) { university-title } else { current-title }

  block(width: 100%)[
    #align(center)[#text(font: fonts.body, size: 9pt)[#title]]
    #v(-6pt)
    #move(dx: -2mm)[#line(length: 100% + 4mm, stroke: 0.4pt)]
  ]
}

#let footer-content(numbering, fonts) = context {
  align(center)[
    #text(font: fonts.body, size: 10.5pt)[#counter(page).display(numbering)]
  ]
}

#let thesis(
  info: (:),
  committee: (),
  settings: (:),
  abstract_zh: (:),
  abstract_en: (:),
  nomenclature: (),
  references: none,
  appendix: none,
  acknowledgement: none,
  achievements: none,
  experience: (),
  body,
) = {
  let settings = (
    print_mode: false,
    show_english_cover: true,
    show_committee: true,
    show_statement: true,
    show_nomenclature: true,
    toc_depth: 3,
    cover_title_alignment: center,
    page_margin: (top: 25.4mm, bottom: 25.4mm, left: 31.7mm, right: 31.7mm),
    body_size: 12pt,
    body_line_spacing: 20pt,
    abstract_size: 14pt,
    abstract_line_spacing: 20pt,
    fonts: default-fonts,
  ) + settings
  let fonts = settings.fonts
  let body-leading = fixed-leading(settings.body_size, settings.body_line_spacing)
  let metadata-title = if type(info.title_zh) == array {
    info.title_zh.join([ ])
  } else {
    info.title_zh
  }

  set document(title: metadata-title, author: (info.author_zh,))
  set page(
    paper: "a4",
    margin: settings.page_margin,
    numbering: none,
    header: none,
    footer: none,
  )
  set text(
    font: fonts.body,
    size: settings.body_size,
    lang: "zh",
    region: "CN",
    top-edge: 0.8em,
    bottom-edge: -0.2em,
  )
  set par(
    justify: true,
    first-line-indent: paragraph-indent,
    leading: body-leading,
    spacing: body-leading,
  )
  set heading(numbering: chapter-numbering)
  set figure(numbering: scoped-numbering)
  set math.equation(numbering: equation-numbering)

  show heading: it => {
    let level = it.level
    let style = heading-style(level, fonts: fonts)
    let is-english-abstract = level == 1 and it.numbering == none and it.body == [ABSTRACT]

    if level == 1 {
      if it.numbering != none {
        major-break(print-mode: settings.print_mode, weak: true)
        counter(figure.where(kind: image)).update(0)
        counter(figure.where(kind: table)).update(0)
        counter(math.equation).update(0)
      } else {
        pagebreak(weak: true)
      }
      v(if is-english-abstract { 0pt } else { 3.4pt })
    }

    display-heading(
      it,
      if is-english-abstract { fonts.latin } else { style.font },
      style.size,
      alignment: style.alignment,
      above: style.above,
      below: style.below,
      weight: if is-english-abstract { "bold" } else { style.weight },
    )
  }
  show figure.caption: it => {
    set text(font: fonts.kai, size: 10.5pt)
    set par(first-line-indent: 0pt, leading: 4pt)
    align(center)[#it]
  }

  chinese-cover(
    info,
    fonts: fonts,
    title_alignment: settings.cover_title_alignment,
  )
  pagebreak()

  if settings.show_english_cover {
    english-cover(
      info,
      fonts: fonts,
      title_alignment: settings.cover_title_alignment,
    )
    pagebreak()
  }

  if settings.show_committee {
    committee-page(info, committee, fonts: fonts)
    major-break(print-mode: settings.print_mode)
  }

  if settings.show_statement {
    statement-page(info, fonts: fonts)
    major-break(print-mode: settings.print_mode)
  }

  set page(
    paper: "a4",
    margin: settings.page_margin,
    numbering: "I",
    header-ascent: 16.8pt,
    footer-descent: 9pt,
    header: header-content(info, fonts),
    footer: footer-content("I", fonts),
  )
  counter(page).update(1)

  abstract-page(
    [摘　要],
    abstract_zh.body,
    abstract_zh.keywords,
    size: settings.abstract_size,
    line_spacing: settings.abstract_line_spacing,
    fonts: fonts,
  )
  abstract-page(
    [ABSTRACT],
    abstract_en.body,
    abstract_en.keywords,
    english: true,
    size: settings.abstract_size,
    line_spacing: settings.abstract_line_spacing,
    fonts: fonts,
  )
  contents-page(depth: settings.toc_depth, fonts: fonts)
  if settings.show_nomenclature and nomenclature.len() > 0 {
    nomenclature-page(nomenclature, fonts: fonts)
  }

  major-break(print-mode: settings.print_mode)
  set page(
    numbering: "1",
    header-ascent: 16.8pt,
    footer-descent: 9pt,
    header: header-content(info, fonts),
    footer: footer-content("1", fonts),
  )
  counter(page).update(1)

  body

  if references != none {
    special-chapter(
      [参考文献],
      references,
      print_mode: settings.print_mode,
      size: settings.body_size,
      line_spacing: settings.body_line_spacing,
      fonts: fonts,
    )
  }
  if appendix != none {
    special-chapter(
      [附　录],
      appendix,
      print_mode: settings.print_mode,
      size: settings.body_size,
      line_spacing: settings.body_line_spacing,
      fonts: fonts,
    )
  }
  if acknowledgement != none {
    special-chapter(
      [致　谢],
      acknowledgement,
      print_mode: settings.print_mode,
      size: settings.body_size,
      line_spacing: settings.body_line_spacing,
      fonts: fonts,
    )
  }
  if achievements != none {
    special-chapter(
      [攻读学位期间取得的创新成果目录],
      achievements,
      print_mode: settings.print_mode,
      size: settings.body_size,
      line_spacing: settings.body_line_spacing,
      fonts: fonts,
    )
  }
  if experience.len() > 0 {
    experience-page(experience, print_mode: settings.print_mode, fonts: fonts)
  }
}
