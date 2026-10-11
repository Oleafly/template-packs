#import "/style/colours.typ": imperial_blue

#let basic_formatting(doc,
  main-font: "New Computer Modern", font-size: 11pt,
  header-chapter_name: true, header-include: true
) = {
  set page(header: context [
    // check if this page starts a new chapter
    #let internal_page_num = here().page()
    #let is-start-chapter = query(
      heading.where(level:1)
    ).map(
      it => it.location().page()
    ).contains(internal_page_num)

    // no page number header on chapter start pages
    #if is-start-chapter or not header-include {
      return
    }

    #let prev_headings = selector(heading.where(level: 1)).before(here())
    #let last_heading = query(prev_headings).last()

    #let header-text = if header-chapter_name {last_heading.body} else {none}

    #set text(fill: imperial_blue)

    #let page_num = counter(page).get().at(0);
    #if calc.even(page_num) [
      #counter(page).display()
      #h(1fr)
      #upper(header-text)
     ] else [
      #upper(header-text)
      #h(1fr)
      #counter(page).display()
     ]

    #line(length: 100%, stroke: 0.5pt + imperial_blue)
  ], footer: [])

  show heading: it => {
    v(5mm)
    it
    v(5mm)
  }
  show heading.where(
    level: 1
  ): it => {
    v(1cm)
    align(right, text(9mm, fill: imperial_blue, it))
    v(1cm)
  }

  // --- text settings ---

  set text(font: main-font, size: font-size, lang: "en")

  set par(leading: 1.2em, justify: true)

  set cite(style: "ieee")

  doc
}