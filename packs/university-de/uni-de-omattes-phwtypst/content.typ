#import "config/meta.typ": document_meta, colors, typography, page_margins, get_author_names

#set page(
  paper: "a4",
  margin: page_margins,
  numbering: "1",
  header: context [
    #set text(
      font: typography.font_family,
      size: typography.header_footer_size,
      fill: colors.text,
    )

    #let current_heading = query(selector(heading.where(level: 1)))
    #let here_pos = here().position()
    #let chapter_name = {
      // Find the heading that is currently active at this position
      let active_heading = none
      for h in current_heading {
        if h.location().position().page <= here_pos.page {
          active_heading = h
        } else {
          break
        }
      }
      if active_heading != none {
        active_heading.body
      } else {
        document_meta.title
      }
    }

    #grid(
      columns: (3fr, 1fr),
      align: (left, right),
      text(weight: "regular")[#chapter_name], text(weight: "regular")[#get_author_names()],
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

#set text(
  font: typography.font_family,
  size: typography.main_text_size,
  fill: colors.text,
)

#set par(
  spacing: typography.line_height.main * 1em,
  leading: typography.line_height.main * 0.65em,
  justify: true,
)

#counter(page).update(1)

#set heading(numbering: "1.1")

#show heading.where(level: 1): it => {
  v(2em)
  text(
    size: typography.heading_sizes.h1,
    weight: "bold",
    fill: colors.accent,
  )[#it]
  v(1em)
}

#show heading.where(level: 2): it => {
  v(1.5em)
  text(
    size: typography.heading_sizes.h2,
    weight: "bold",
    fill: colors.text,
  )[#it]
  v(0.5em)
}

#show heading.where(level: 3): it => {
  v(1em)
  text(
    size: typography.heading_sizes.h3,
    weight: "semibold",
    fill: colors.text,
  )[#it]
  v(0.3em)
}

#show heading.where(level: 4): it => {
  v(0.8em)
  text(
    size: typography.heading_sizes.h4,
    weight: "semibold",
    fill: colors.text,
  )[#it]
  v(0.2em)
}

#show figure: it => {
  v(1em)
  it
  v(0.5em)
}

#show table: it => {
  set text(size: typography.main_text_size - 1pt)
  it
}

#show footnote.entry: it => {
  set text(
    size: typography.header_footer_size,
    fill: colors.text,
  )
  set par(leading: typography.line_height.compact * 0.65em)
  it
}

#include "chapters/01-einleitung.typ"
#include "chapters/02-grundlagen.typ"
#include "chapters/03-fazit.typ"
