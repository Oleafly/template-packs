#import "../template.typ": layout-of, running-footer, running-header

#let references(config) = {
  let l = layout-of(config)

  // Declared here rather than inherited because the front matter's page rule
  // is still in effect at this point: it carries no header and numbers its
  // pages in Roman numerals, while the reference list continues the Arabic
  // sequence the table of contents points at. As with a chapter, the first
  // page of the list carries no header; a list long enough to run onto a
  // second page does.
  set page(
    ..l.body,
    header: context {
      let start = query(<references-heading>).first().location().page()
      if here().page() != start { running-header(config) }
    },
    footer: running-footer(config),
  )

  set text(size: config.style.text-size.body, font: config.style.fonts.body)
  set heading(numbering: none)
  // Authored in title case so the contents table lists it as "References"
  // alongside the chapter titles, and uppercased only for display here, where
  // it has to match the caps a chapter page uses.
  show heading.where(level: 1): it => text(
    size: config.style.text-size.h1,
    upper(it.body),
  )

  align(center)[= References <references-heading>]
  v(16pt)

  set par(justify: true, leading: config.style.leading)
  bibliography(
    "../" + config.bibliography.path,
    title: none,
    style: config.bibliography.style,
  )
}
