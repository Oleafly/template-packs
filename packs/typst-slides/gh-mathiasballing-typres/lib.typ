#import "@preview/polylux:0.4.0" as pl: *


#let slide-aspect-ratio = state("aspect-ratio", "16-9") // 16-9 or 4-3
#let slide-fg-color = state("fg-color", black)
#let slide-bg-color = state("bg-color", white)
#let slide-accent-fg-color = state("accent-fg-color", white)
#let slide-accent-bg-color = state("accent-bg-color", rgb("#000055"))
#let slide-size = state("size", 20pt)
#let slide-padding = state("padding", 1.5em)
#let slide-progress-indicator = state("progress-indicator", "progress")
#let slide-counter-position = state("counter-position", top + right)
#let slide-counter-style = state("counter-style", "accent") // accent or normal
#let slide-notes = state("notes", true) // accent or normal

#let set_option(state, value, options: none, force: false) = {
  if value != none or force {
    if options != none {
      let is-an-option = false
      for opt in options {
        if value == opt {
          is-an-option = true
        }
      }
      if not is-an-option {
        panic("Option '" + value + "' is not valid for " + name + ". Valid options are: " + options.join(", "))
      } else {
        state.update(value)
      }
    } else {
      state.update(value)
    }
  }
}

#let typres-template(
  aspect-ratio: none, // 16-9 or 4-3
  size: none, // Size
  fg-color: none, // Color
  bg-color: none, // Color
  accent-fg-color: none,
  accent-bg-color: none,
  padding: none,
  progress-indicator: none, // none, dots, count, progress
  counter-position: none, // Alignment
  counter-style: none, // none | accent or normal
  show-notes: none, // true or false
  body,
) = context {
  set_option(slide-aspect-ratio, aspect-ratio, options: ("16-9", "4-3"))
  set_option(slide-fg-color, fg-color)
  set_option(slide-bg-color, bg-color)
  set_option(slide-accent-fg-color, accent-fg-color)
  set_option(slide-accent-bg-color, accent-bg-color)
  set_option(slide-size, size)
  set_option(slide-padding, padding)
  set_option(slide-progress-indicator, progress-indicator, options: ("none", "dots", "count", "progress"))
  set_option(slide-counter-style, counter-style, options: ("accent", "normal"))
  set_option(slide-notes, show-notes)

  set_option(slide-counter-position, counter-position)
  let counter-position = slide-counter-position.get()
  if counter-position.x == none { counter-position.x = right }
  if counter-position.y == none { counter-position.y = top }
  set_option(slide-counter-position, counter-position)

  set page(
    paper: "presentation-" + slide-aspect-ratio.get(),
    fill: slide-bg-color.get(),
    margin: 0pt,
    header: none,
    footer: none,
    header-ascent: 0pt,
    footer-descent: 0pt,
  )

  set text(
    fill: slide-fg-color.get(),
    size: slide-size.get(),
  )

  body
}

// Dot
#let slide(
  title: none,
  new-section: false, // If it should count in TOC
  progress-indicator: true,
  hide-header: false, // Should hide the section name
  padding: true,
  count-slide: true,
  // counter-position: none, // Override default counter position: top-right, top-left, bottom-right, bottom-left
  // counter-style: none, // Override default counter style: accent or normal
  body,
) = context {
  if new-section {
    if title != none {
      pl.toolbox.register-section(title)
    } else {
      panic("A title is required for a new section")
    }
  }

  let slide-padding = slide-padding.get()
  let accent-bg-color = slide-accent-bg-color.get()
  let accent-fg-color = slide-accent-fg-color.get()
  let normal-bg-color = slide-bg-color.get()
  let normal-fg-color = slide-fg-color.get()
  let slide-size = slide-size.get()

  let progress(fill) = context {
    let last = counter("logical-slide").final().first()
    let current = counter("logical-slide").get().first()
    let current = if count-slide { current } else { current - 1 }
    set text(size: slide-size, fill: fill)

    let method = slide-progress-indicator.get()

    if method == "none" {} else if method == "count" {
      set text(size: 0.8em)
      [*#current / #last*]
    } else if (
      method == "progress"
    ) {
      set text(size: 0.5em)
      let ratio = current / last * 100%
      block(width: 10em, height: 1em, radius: 100%)[
        #place(left)[#rect(width: 10em, height: 100%, radius: 100%, stroke: fill)]
        #place(left)[#rect(width: ratio, height: 100%, radius: 100%, fill: fill)]
      ]
    } else if method == "dots" {
      set text(size: 0.8em)
      let over-current = false
      for i in range(1, last + 1) {
        if current == i {
          $compose.o$
          over-current = true
        } else if (over-current) {
          $circle.stroked$
        } else { $circle.filled$ }
        h(0.1em)
      }
    } else {
      panic("progress-indicator must be either 'none', 'dots', 'count', or 'progress'")
    }
  }

  let progress-filled = {
    set align(left)
    let style = slide-counter-style.get()
    let fill = if style == "accent" {
      if hide-header { accent-bg-color } else { accent-fg-color }
    } else if style == "normal" {
      if hide-header { normal-bg-color } else { normal-fg-color }
    } else {
      panic("counter-style must be either 'accent' or 'normal'")
    }
    progress(fill)
  }
  let header = {
    set text(fill: accent-fg-color)
    set align(horizon + left)
    pad(rest: slide-padding, {
      place(horizon + left, [= #title])
    })
  }

  let content = {
    if hide-header {
      block(width: 100%, height: 100%, pad(
        rest: if padding { slide-padding } else { 0em },
        {
          set heading(offset: 1)
          body
        },
      ))
    } else {
      block(fill: accent-bg-color, width: 100%, header)
      v(-1cm)
      block(fill: normal-bg-color, width: 100%, height: 1fr, pad(
        rest: if padding { slide-padding } else { 0em },
        {
          set heading(offset: 1)
          body
        },
      ))
    }
  }


  pl.slide({
    set text(size: slide-size)
    content
    if progress-indicator {
      let pos = slide-counter-position.get()
      if pos.x == none { pos = pos.y + right }
      if pos.y == none { pos = pos.x + top }

      let dy = if pos.y == top {
        slide-padding + -0.4em
      } else if pos.y == bottom {
        -slide-padding + 0.4em
      } else {
        0cm
      }

      let dx = if pos.x == right {
        -slide-padding
      } else if pos.x == left {
        slide-padding
      } else {
        0cm
      }

      place(pos, dy: dy, dx: dx, progress-filled)
    }
  })

  if not count-slide {
    counter("logical-slide").update(n => n - 1)
  }
}


#let toc-slide(title: none) = context {
  set page(
    margin: (top: 0cm, bottom: 0cm),
    header: none,
    footer: none,
    fill: slide-accent-bg-color.get(),
  )

  // TOC
  let content = {
    if title != none {
      align(center, text(size: 1.2em, weight: "bold", title))
      v(-0.5em)
    }
    pl.toolbox.all-sections((sections, current) => {
      for i in sections [
        + #text(i)
      ]
    })
  }

  pl.slide({
    set align(horizon + center)
    set text(
      size: slide-size.get() * 1.2,
      fill: slide-accent-fg-color.get(),
    )
    show: box
    set align(left)
    content
  })

  counter("logical-slide").update(n => n - 1)
}


#let title-slide(
  title: "title",
  subtitle: "subtitle",
  authors: "auther",
  date: "01.01.2026",
  body: none,
) = context {
  set text(
    size: slide-size.get(),
  )

  let slide-padding = slide-padding.get()
  let accent-bg-color = slide-accent-bg-color.get()
  let accent-fg-color = slide-accent-fg-color.get()
  let normal-bg-color = slide-bg-color.get()
  let normal-fg-color = slide-fg-color.get()


  let content = grid(
    inset: slide-padding,
    columns: 1fr,
    rows: (5fr, 4fr),
    fill: (x, y) => {
      if y == 0 { accent-bg-color } else { normal-bg-color }
    },
    [
      #set text(fill: accent-fg-color, size: 1.2em)
      #set align(left + bottom)
      = #title
    ],
    [
      #set text(fill: normal-fg-color)
      #set align(left + top)
      #show heading.where(level: 2): it => {
        text(fill: accent-bg-color, it.body)
      }
      // #show heading.where(level: 2): it => {
      //   text(fill: accent-fill-bg, it.body)
      // }
      == #subtitle\
      #date
      #set align(left + bottom)
      #authors
    ]
  )

  pl.slide({ content })

  counter("logical-slide").update(n => n - 1)
}

#let empty-slide(
  title: none,
  new-section: false, // If it should count in TOC
  progress-indicator: false,
  hide-header: true, // Should hide the section name
  padding: true,
  count-slide: true,
  body,
) = slide(
  title: title,
  new-section: new-section,
  progress-indicator: progress-indicator,
  hide-header: hide-header,
  padding: padding,
  count-slide: count-slide,
  body,
)

#let note(body) = context {
  if slide-notes.get() {
    set page(paper: "a4", margin: (top: 2cm, bottom: 2cm, left: 2.5cm, right: 2.5cm))
    set text(size: 12pt, fill: black)
    body
  }
}

