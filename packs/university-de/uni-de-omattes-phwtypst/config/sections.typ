#import "meta.typ": colors, get_author_names, page_margins, typography

#let roman_page_setup() = {
  set page(paper: "a4", margin: page_margins, numbering: "I", footer: context {
    set text(
      font: typography.font_family,
      size: typography.header_footer_size,
      fill: colors.text,
    )

    align(center)[
      #counter(page).display("I")
    ]
  })

  set text(
    font: typography.font_family,
    size: typography.main_text_size,
    fill: colors.text,
  )

  set par(justify: false)

  show heading.where(level: 1): it => {
    text(
      size: typography.heading_sizes.h1,
      weight: "bold",
      fill: colors.accent,
    )[#it]
  }
}

#let arabic_page_setup(header_title: "Document") = {
  set page(
    paper: "a4",
    margin: page_margins,
    numbering: "1",
    header: context [
      #set text(
        font: typography.font_family,
        size: typography.header_footer_size,
        fill: colors.text,
      )

      #grid(
        columns: (3fr, 1fr),
        align: (left, right),
        text(weight: "regular")[#effective_header], text(weight: "regular")[#get_author_names()],
      )

      #v(-0.5em)
      #line(length: 100%, stroke: 0.5pt + colors.subtle)
    ],
    footer: context {
      set text(
        font: typography.font_family,
        size: typography.header_footer_size,
        fill: colors.text,
      )

      align(center)[
        #counter(page).display("1")
      ]
    },
  )

  set text(
    font: typography.font_family,
    size: typography.main_text_size,
    fill: colors.text,
  )

  set par(
    spacing: typography.line_height.main * 1em,
    leading: typography.line_height.main * 0.65em,
    justify: true,
  )

  show heading.where(level: 1): it => {
    text(
      size: typography.heading_sizes.h1,
      weight: "bold",
      fill: colors.accent,
    )[#it]
  }
}

#let lower_roman_page_setup(header_title: "Document") = {
  set page(
    paper: "a4",
    margin: page_margins,
    numbering: "i",
    header: context [
      #set text(
        font: typography.font_family,
        size: typography.header_footer_size,
        fill: colors.text,
      )

      #grid(
        columns: (3fr, 1fr),
        align: (left, right),
        text(weight: "regular")[#effective_header], text(weight: "regular")[#get_author_names()],
      )

      #v(-0.5em)
      #line(length: 100%, stroke: 0.5pt + colors.subtle)
    ],
    footer: context {
      set text(
        font: typography.font_family,
        size: typography.header_footer_size,
        fill: colors.text,
      )

      align(center)[
        #counter(page).display("i")
      ]
    },
  )

  set text(
    font: typography.font_family,
    size: typography.main_text_size,
    fill: colors.text,
  )

  set par(
    spacing: typography.line_height.main * 1em,
    leading: typography.line_height.main * 0.65em,
    justify: true,
  )

  show heading.where(level: 1): it => {
    text(
      size: typography.heading_sizes.h1,
      weight: "bold",
      fill: colors.accent,
    )[#it]
  }
}

#let section_heading(title, large: false) = {
  if large {
    text(
      size: 24pt,
      weight: "bold",
      fill: colors.accent,
      tracking: 0.5pt,
    )[#title]
  } else {
    text(
      size: 18pt,
      weight: "bold",
      fill: colors.accent,
    )[#title]
  }
}

#let roman_section(title, content, large_title: false) = {
  // Set page configuration
  set page(
    paper: "a4",
    margin: page_margins,
    numbering: "I",
    header: context [
      #set text(
        font: typography.font_family,
        size: typography.header_footer_size,
        fill: colors.text,
      )

      #grid(
        columns: (3fr, 1fr),
        align: (left, right),
        text(weight: "regular")[#title], text(weight: "regular")[#get_author_names()],
      )

      #v(-0.5em)
      #line(length: 100%, stroke: 0.5pt + colors.subtle)
    ],
    footer: context {
      set text(
        font: typography.font_family,
        size: typography.header_footer_size,
        fill: colors.text,
      )

      align(center)[
        #counter(page).display("I")
      ]
    },
  )

  set text(
    font: typography.font_family,
    size: typography.main_text_size,
    fill: colors.text,
  )

  set par(justify: true)

  show heading.where(level: 1): it => {
    text(
      size: typography.heading_sizes.h1,
      weight: "bold",
      fill: colors.accent,
    )[#it]
  }

  heading(level: 1, numbering: none)[#title]

  if large_title {
    align(center)[#section_heading(title, large: true)]
    v(2.5cm)
  } else {
    v(1cm)
  }

  content

  pagebreak()
}

#let list_section(title, outline_target) = {
  roman_section(title, [
    #outline(
      title: none,
      target: outline_target,
    )
  ])
}

#let text_section(title, content) = {
  roman_section(title, content)
}

#let arabic_section(title, content, header_title: none) = {
  let effective_header = if header_title != none { header_title } else { title }

  set page(
    paper: "a4",
    margin: page_margins,
    numbering: "1",
    header: context [
      #set text(
        font: typography.font_family,
        size: typography.header_footer_size,
        fill: colors.text,
      )

      #grid(
        columns: (3fr, 1fr),
        align: (left, right),
        text(weight: "regular")[#effective_header], text(weight: "regular")[#get_author_names()],
      )

      #v(-0.5em)
      #line(length: 100%, stroke: 0.5pt + colors.subtle)
    ],
    footer: context {
      set text(
        font: typography.font_family,
        size: typography.header_footer_size,
        fill: colors.text,
      )

      align(center)[
        #counter(page).display("1")
      ]
    },
  )

  set text(
    font: typography.font_family,
    size: typography.main_text_size,
    fill: colors.text,
  )

  set par(
    spacing: typography.line_height.main * 1em,
    leading: typography.line_height.main * 0.65em,
    justify: true,
  )

  show heading.where(level: 1): it => {
    text(
      size: typography.heading_sizes.h1,
      weight: "bold",
      fill: colors.accent,
    )[#it]
  }

  heading(level: 1, numbering: none)[#title]
  v(1cm)

  content

  pagebreak()
}

#let lower_roman_section(title, content, header_title: none, reset_counter: true) = {
  let effective_header = if header_title != none { header_title } else { title }

  set page(
    paper: "a4",
    margin: page_margins,
    numbering: "i",
    header: context {
      let page_num = counter(page).get().first()
      if page_num > 1 [
        #set text(
          font: typography.font_family,
          size: typography.header_footer_size,
          fill: colors.text,
        )

        #grid(
          columns: (3fr, 1fr),
          align: (left, right),
          text(weight: "regular")[#effective_header], text(weight: "regular")[#get_author_names()],
        )

        #v(-0.5em)
        #line(length: 100%, stroke: 0.5pt + colors.subtle)
      ]
    },
    footer: context {
      set text(
        font: typography.font_family,
        size: typography.header_footer_size,
        fill: colors.text,
      )

      align(center)[
        #counter(page).display("i")
      ]
    },
  )

  set text(
    font: typography.font_family,
    size: typography.main_text_size,
    fill: colors.text,
  )

  set par(
    spacing: typography.line_height.main * 1em,
    leading: typography.line_height.main * 0.65em,
    justify: true,
  )

  show heading.where(level: 1): it => {
    text(
      size: typography.heading_sizes.h1,
      weight: "bold",
      fill: colors.accent,
    )[#it]
  }

  if reset_counter {
    counter(page).update(1)
  }

  heading(level: 1, numbering: none)[#title]
  v(1cm)

  content
}

#let appendix_section(title, content) = {
  set page(
    paper: "a4",
    margin: page_margins,
    numbering: "i",
    header: context [
      #set text(
        font: typography.font_family,
        size: typography.header_footer_size,
        fill: colors.text,
      )

      #grid(
        columns: (3fr, 1fr),
        align: (left, right),
        text(weight: "regular")[Anhang], text(weight: "regular")[#get_author_names()],
      )

      #v(-0.5em)
      #line(length: 100%, stroke: 0.5pt + colors.subtle)
    ],
    footer: context {
      set text(
        font: typography.font_family,
        size: typography.header_footer_size,
        fill: colors.text,
      )

      align(center)[
        #counter(page).display("i")
      ]
    },
  )

  set text(
    font: typography.font_family,
    size: typography.main_text_size,
    fill: colors.text,
  )

  set par(
    spacing: typography.line_height.main * 1em,
    leading: typography.line_height.main * 0.65em,
    justify: true,
  )

  counter(page).update(1)

  set heading(numbering: (..nums) => {
    let level = nums.pos().len()
    if level == 1 {
      none
    } else if level == 2 {
      numbering("A", nums.pos().at(1))
    } else if level == 3 {
      numbering("A", nums.pos().at(1)) + "." + str(nums.pos().at(2))
    } else if level == 4 {
      numbering("A", nums.pos().at(1)) + "." + str(nums.pos().at(2)) + "." + str(nums.pos().at(3))
    }
  })

  show heading.where(level: 1): it => {
    v(1em)
    text(
      size: typography.heading_sizes.h1,
      weight: "bold",
      fill: colors.accent,
    )[#it]
  }
  show heading.where(level: 2): it => {
    if (counter(heading).get().at(1) != 1) {
      pagebreak(weak: true)
    }
    v(2em)
    text(
      size: typography.heading_sizes.h2,
      weight: "bold",
      fill: colors.text,
    )[#it]
    v(1em)
  }

  show heading.where(level: 3): it => {
    v(1em)
    text(
      size: typography.heading_sizes.h3,
      weight: "bold",
      fill: colors.text,
    )[#it]
    v(0.25em)
  }

  show heading.where(level: 4): it => {
    v(0.75em)
    text(
      size: typography.main_text_size,
      weight: "bold",
      fill: colors.text,
    )[#it]
    v(0.15em)
  }

  heading(level: 1, numbering: none)[#title]
  counter(heading).update((0, 0))

  content

  pagebreak()
}

#let table_of_contents_section() = {
  set page(
    paper: "a4",
    margin: page_margins,
    numbering: "I",
    header: context [
      #set text(
        font: typography.font_family,
        size: typography.header_footer_size,
        fill: colors.text,
      )

      #grid(
        columns: (3fr, 1fr),
        align: (left, right),
        text(weight: "regular")[Inhaltsverzeichnis], text(weight: "regular")[#get_author_names()],
      )

      #v(-0.5em)
      #line(length: 100%, stroke: 0.5pt + colors.subtle)
    ],
    footer: context {
      set text(
        font: typography.font_family,
        size: typography.header_footer_size,
        fill: colors.text,
      )

      align(center)[
        #counter(page).display("I")
      ]
    },
  )

  set text(
    font: typography.font_family,
    size: typography.main_text_size,
    fill: colors.text,
  )

  set par(justify: false)

  show heading.where(level: 1): it => {
    text(
      size: typography.heading_sizes.h1,
      weight: "bold",
      fill: colors.accent,
    )[#it]
  }
  counter(page).update(1)

  heading(level: 1, numbering: none)[Inhaltsverzeichnis]
  v(1cm)

  show outline.entry: it => {
    let level = it.level

    if level == 1 {
      v(1.2em, weak: true)
      text(
        size: 13pt,
        weight: "bold",
        fill: colors.text,
      )[#it]
      v(0.4em, weak: true)
    } else if level == 2 {
      v(0.6em, weak: true)
      text(
        size: 12pt,
        fill: colors.text,
      )[#it]
      v(0.2em, weak: true)
    } else {
      v(0.3em, weak: true)
      text(size: 11pt, fill: colors.text.lighten(15%))[#it]
    }
  }

  outline(
    title: none,
    depth: 2, // Nur Überschriften bis Ebene 2 anzeigen
    indent: 1.5em,
  )

  pagebreak()
}
