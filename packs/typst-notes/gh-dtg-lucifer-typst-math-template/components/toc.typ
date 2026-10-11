// components/toc.typ
// Table of Contents matching Charlie's LaTeX template exactly (Screenshot 5 & cmt.sty lines 860-910)
// Fully clickable links for PDF navigation

#import "theme.typ": resolve-palette

/// Top right "Contents" banner matching Charlie's LaTeX template exactly
#let toc-header(title: "Contents", theme: none) = {
  context {
    let p = resolve-palette(theme-override: theme)
    v(-10pt)
    align(right)[
      #box(
        fill: p.accent-muted,
        inset: (x: 28pt, y: 14pt),
        radius: 0pt, // Sharp rectangular corners as in Charlie's TikZ banner
        text(
          fill: rgb("#ffffff"),
          size: 24pt,
          weight: "bold",
          font: ("New Computer Modern", "Libertinus Serif"),
          title
        )
      )
    ]
    v(28pt)
  }
}

/// Formatter for outline entries matching Charlie's style:
/// Chapter: [Chapter N] badge on left, horizontal line to "Page P", and line to right margin.
/// Section: Indented number, title, blank space (no dots, no lines), and right-aligned page number.
/// Every entry is an active clickable hyperlink to the corresponding section.
#let format-toc-entry(it, chapter-label: "Chapter", theme: none) = {
  context {
    let p = resolve-palette(theme-override: theme)
    let loc = it.element.location()
    let pg = counter(page).at(loc).first()

    if it.level == 1 {
      let nums = counter(heading).at(loc)
      let num-str = if nums.len() > 0 and nums.first() > 0 {
        chapter-label + " " + str(nums.first())
      } else {
        none
      }

      let has-body = it.element.body != [] and it.element.body != [ ]

      v(22pt)
      link(loc)[
        #grid(
          columns: (
            if num-str != none { auto } else { 0pt },
            if has-body { auto } else { 0pt },
            1fr,
            auto,
            28pt
          ),
          gutter: (8pt, 8pt, 8pt, 6pt),
          align: (left + horizon, left + horizon, horizon, right + horizon, horizon),
          if num-str != none {
            box(
              fill: p.accent-muted,
              inset: (x: 9pt, y: 4.5pt),
              radius: 0pt,
              text(
                fill: rgb("#ffffff"),
                weight: "bold",
                size: 11pt,
                font: ("New Computer Modern", "Libertinus Serif"),
                num-str
              )
            )
          } else { [] },
          if has-body {
            text(
              fill: p.text,
              weight: "bold",
              size: 11pt,
              font: ("New Computer Modern", "Libertinus Serif"),
              it.element.body
            )
          } else { [] },
          line(length: 100%, stroke: 0.65pt + p.accent-muted),
          text(
            fill: p.accent-muted,
            weight: "bold",
            size: 10.5pt,
            font: ("New Computer Modern", "Libertinus Serif"),
            [Page #pg]
          ),
          line(length: 100%, stroke: 0.65pt + p.accent-muted)
        )
      ]
      v(6pt)
    } else if it.level == 2 {
      // Sections: indented by 36pt, section number, title, space, right-aligned page
      let nums = counter(heading).at(loc)
      let sec-num = if nums.len() >= 2 {
        str(nums.at(0)) + "." + str(nums.at(1))
      } else {
        ""
      }

      v(3pt)
      link(loc)[
        #block(width: 100%, inset: (left: 36pt))[
          #grid(
            columns: (if sec-num != "" { 24pt } else { 0pt }, 1fr, auto),
            gutter: 6pt,
            align: (left + horizon, left + horizon, right + horizon),
            if sec-num != "" {
              text(fill: p.text, size: 9.5pt, sec-num)
            } else { [] },
            text(fill: p.text, size: 9.5pt, it.element.body),
            text(fill: p.text, size: 9.5pt, str(pg)),
          )
        ]
      ]
    } else {
      // Subsections: further indented, bullet, title, space, page
      v(2pt)
      link(loc)[
        #block(width: 100%, inset: (left: 60pt))[
          #grid(
            columns: (12pt, 1fr, auto),
            gutter: 4pt,
            align: (left + horizon, left + horizon, right + horizon),
            text(size: 8.5pt, fill: p.text-muted)[•],
            text(size: 8.5pt, fill: p.text-muted, it.element.body),
            text(fill: p.text-muted, size: 8.5pt, str(pg)),
          )
        ]
      ]
    }
  }
}
