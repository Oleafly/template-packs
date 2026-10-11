#import "/utils/print_pagebreak.typ": print_pagebreak
#import "/style/colours.typ": imperial_blue

#let content_formatting(doc,
  main-font: "New Computer Modern", font-size: 11pt, is_print: false,
  header_section_prefix: [CHAPTER], thumb_label_num_format: "1",
  par-fl_indent: 2em
) = {
  // set heading configurations
  show heading: it => [
    #v(5mm)
    #it
    #v(5mm)
  ]
  show heading.where(
    level: 1
  ): it => {
    // skip for first section
    if not (counter(heading).get().at(0) == 1) {
      // ensure all chapters start on odd pages
      print_pagebreak(print: is_print, to: "odd")
    }
    v(3cm)
    align(right, [
      #set text(font: main-font, fill: imperial_blue)
      #text(3cm, weight: "semibold", counter(heading).display())\
      #v(-5mm)\  // adjust default spacing to match ic template
      #text(9mm, it.body)
    ])
    v(1cm)
  }

  // set page configurations
  set page(header: context [
    // check if this page starts a new chapter
    #let internal_page_num = here().page()
    #let is-start-chapter = query(
      heading.where(level:1)
    ).map(
      it => it.location().page()
    ).contains(internal_page_num)

    // get current page number
    #let page_num = counter(page).get().at(0);

    // select current chapter
    #let prev_ch_headings = selector(heading.where(level: 1)).before(here())
    #let ch_headings = query(prev_ch_headings)
    #let ch_level = counter(heading).get().at(0)  // top-level heading count
    #if is-start-chapter {ch_level += 1}
    // ^ workaround, cos `page` header is rendered before heading is evaluated


    #if ch_headings.len() == 0 {
      return
    }
    #let last_ch_heading = ch_headings.last()

    // Add chapter labels on each page
    #let chapter_circle(side) = circle(
      fill: imperial_blue,
      radius: 8mm, align(
        horizon + side,
        text(
          numbering(thumb_label_num_format, ch_level),
          fill: white, size: 1cm
        )
      )
    )
    #let chapter_rectangle = rect(
      fill: imperial_blue,
      height: 16mm,
      width: 16mm,
    )
    #if calc.even(page_num) {
      place(left, dx: -30mm, dy: 3cm, chapter_rectangle)
      place(left, dx: -22mm, dy: 3cm, chapter_circle(left))
    } else {
      place(right, dx: 30mm, dy: 3cm, chapter_rectangle)
      place(right, dx: 22mm, dy: 3cm, chapter_circle(right))
    }

    // TODO: dynamically adapt dy based on which chapter `here` is at
    // the package used in the LaTeX template does this

    // make sure all heading text is 'branded'
    #set text(fill: imperial_blue)

    // no page number header on chapter start pages
    #if is-start-chapter {
      // but include them if not is_print, since there won't be
      // at least one page to provide a page number
      if not is_print {
        align(center, counter(page).display())
      }
      return
    }

    // select current sub*-section
    #let prev_headings = selector(heading).before(here())
    #let curr_level = counter(prev_headings)
    #let headings = query(prev_headings)

    #let last_heading = headings.last()

    // add page numberings with section information
    #if calc.even(page_num) [
      #counter(page).display()
      #h(1fr)
      #header_section_prefix
      #numbering(thumb_label_num_format, ch_level)\. #" "
      #upper(last_ch_heading.body)
    ] else [
      #curr_level.display()\. #" " #upper(last_heading.body)
      #h(1fr)  // --- set formatting configs ---
      #counter(page).display()
    ]
    #line(length: 100%, stroke: 0.5pt + imperial_blue)
  ], footer: [])

  // set text formatting

  set text(font: main-font, size: font-size)

  set par(justify: true, first-line-indent: par-fl_indent)

  show math.equation: set text(weight: 400)

  show figure: set text(size: 0.85em)

  set cite(style: "ieee")

  // --- end formatting configs ---

  doc
}