// ==============================================================================
// 📐 AU DMin Layout, Typography, Spacing & Show Rules
// Conforms to: Doctor of Ministry Project Writing Manual (4th Edition, Aug 2019)
// ==============================================================================

#import "state.typ": *
#import "i18n.typ": *

// ==============================================================================
// 📏 Spacing Constants (Strictly integer pt values / MS Word & AU DMin Standard)
// ==============================================================================
#let word-single-leading = 0.65em      // Одинарний інтервал (14pt baseline)
#let word-double-leading = 1.6em     // Подвійний інтервал (28pt baseline)
#let word-space-skip-1 = 0.65em       // Double space (пропуск 1 одинарного рядка)
#let word-space-skip-2 = 1.6em       // Triple space (пропуск 2 одинарних рядків)
#let word-space-skip-3 = 3.2em       // Four spaces (пропуск 3 одинарних рядків)
#let word-space-skip-4 = 4.8em       // Four spaces (пропуск 3 одинарних рядків)


/// Helper to handle string/content line breaks with \ or \n and uppercase conversion
#let format-title(t, to-upper: false) = {
  if type(t) == str {
    let s = if to-upper { upper(t) } else { t }
    let s-norm = s.replace("\\", "\n")
    let lines = s-norm.split("\n").map(l => l.trim()).filter(l => l.len() > 0)
    if lines.len() > 1 {
      lines.join(linebreak())
    } else {
      s
    }
  } else if type(t) == content {
    if to-upper { upper(t) } else { t }
  } else {
    t
  }
}

/// Helper to determine the number of lines in a title
#let count-title-lines(t) = {
  if type(t) == str {
    let s-norm = t.replace("\\", "\n")
    let lines = s-norm.split("\n").map(l => l.trim()).filter(l => l.len() > 0)
    calc.max(1, lines.len())
  } else if type(t) == content {
    let rep = repr(t)
    let breaks = rep.matches("linebreak").len()
    breaks + 1
  } else {
    1
  }
}


#let apply-dmin-layout(lang: "en", body) = {
  // ============================================================================
  // PAGE GEOMETRY — Chapter 3 (p. 12)
  // Left margin: 1.5" (for binding); Right/Top/Bottom: 1.0"
  // ============================================================================
  set page(
    paper: "us-letter",
    margin: (
      left: 1.5in,
      right: 1.0in,
      top: 1.0in,
      bottom: 1.0in,
    ),
    header: none,
    footer: context {
      align(center)[
        #text(size: 12pt)[
          #counter(page).display()
        ]
      ]
    },
  )

  // ============================================================================
  // TYPOGRAPHY — Chapter 1 (p. 1)
  // "Fonts similar to Times New Roman... serif... 10-12 points"
  // ============================================================================
  set text(
    font: ("Times New Roman", "Liberation Serif", "Nimbus Roman"),
    size: 12pt,
    lang: lang,
    costs: (widow: 300%, orphan: 300%, runt: 300%),
    hyphenate: false,
  )

  // Запобігання висячим коротким прийменникам, сполучникам та числам з крапкою
  show regex("(?:\b|^)([а-яА-ЯіІїЇєЄґҐa-zA-Z]{1,2}|[0-9]+\.)\s"): it => {
    it.text.trim() + sym.space.nobreak
  }

  // ============================================================================
  // SPACING — Chapter 3 (p. 12-13)
  // All text: double-spaced (28pt baseline = 14pt font box + 14pt leading)
  // Ragged right margin (NOT justified)
  // Paragraph indent: 0.5 inches
  // ============================================================================
  set par(
    leading: word-double-leading,
    spacing: word-double-leading,
    first-line-indent: (amount: 0.5in, all: true),
    justify: false,
  )

  show par: it => consecutive-subhead.update(false) + it

  // ============================================================================
  // BIBLIOGRAPHY — Chapter 5 & Appendix A
  // Запобігання розриву окремих бібліографічних записів між сторінками
  // ============================================================================
  show bibliography: set grid.cell(breakable: false)

  // ============================================================================
  // FOOTNOTES — Chapter 5 (p. 21)
  // 10pt font, single-spaced within, double space between, 0.5in indent
  // ============================================================================
  show footnote.entry: it => {
    set text(size: 10pt)
    set par(leading: 2pt, spacing: 12pt, first-line-indent: 0.5in, justify: false)
    it
  }

  // ============================================================================
  // HEADINGS — Chapter 2 (p. 9-10) & Chapter 3 (p. 13-14) & Exhibit I
  // ============================================================================
  set heading(numbering: none)
  show heading: it => {
    if it.level == 1 {
      consecutive-subhead.update(true)
      if it.has("supplement") and it.supplement == [Appendix-cover] {
        // Handled by appendix cover sheet, do not render duplicate heading on content page
        none
      } else if it.has("supplement") and (it.supplement == [same-page] or repr(it.supplement) == "[same-page]") {
        // Section on same page without pagebreak (e.g., List of Tables right after List of Illustrations)
        v(word-space-skip-2)
        block(width: 100%, below: word-space-skip-1, sticky: true)[
          #align(center)[
            #set text(size: 12pt, weight: "regular")
            #set par(leading: word-single-leading, justify: false, first-line-indent: 0pt)
            #upper(it.body)
          ]
        ]
      } else {
        // Major Section / Chapter: 2" from top edge of paper (1.0in margin + 1.0in v)
        pagebreak(weak: true)
        v(1.0in)
        if it.numbering != none {
          if it.has("supplement") and it.supplement == [Appendix] {
            block(width: 100%, below: word-space-skip-2, sticky: true)[
              #align(center)[
                #set text(size: 12pt, weight: "regular")
                #context {
                  let s = dmin-get-strings(au-dmin-lang.get())
                  [#s.appendix #appendix-counter.display("A") \ ]
                }
                #v(word-space-skip-2)
                #context {
                  let user-lines = dmin-chapter-lines.get()
                  let test-m = measure(block(width: 100%)[
                    #set text(size: 12pt, weight: "regular")
                    #set par(leading: 0pt, justify: false, first-line-indent: 0pt)
                    #upper(it.body)
                  ])
                  let title-leading = if user-lines != auto {
                    if user-lines >= 3 { word-single-leading } else { word-double-leading }
                  } else if test-m.height >= 35pt {
                    word-single-leading
                  } else {
                    word-double-leading
                  }
                  block(width: 100%)[
                    #set par(leading: title-leading, justify: false, first-line-indent: 0pt)
                    #upper(it.body)
                  ]
                }
              ]
            ]
          } else {
            block(width: 100%, below: word-space-skip-3, sticky: true)[
              #align(center)[
                #set text(size: 12pt, weight: "regular")
                #context {
                  let s = dmin-get-strings(au-dmin-lang.get())
                  [#s.chapter #counter(heading).display("1") \ ]
                }
                #v(word-space-skip-3)
                #context {
                  let user-lines = dmin-chapter-lines.get()
                  let test-m = measure(block(width: 100%)[
                    #set text(size: 12pt, weight: "regular")
                    #set par(leading: 0pt, justify: false, first-line-indent: 0pt)
                    #upper(it.body)
                  ])
                  let title-leading = if user-lines != auto {
                    if user-lines >= 3 { word-single-leading } else { word-double-leading }
                  } else if test-m.height >= 35pt {
                    word-single-leading
                  } else {
                    word-double-leading
                  }
                  block(width: 100%)[
                    #set par(leading: title-leading, justify: false, first-line-indent: 0pt)
                    #upper(it.body)
                  ]
                }
              ]
            ]
          }
        } else {
          block(width: 100%, below: word-space-skip-2, sticky: true)[
            #align(center)[
              #set text(size: 12pt, weight: "regular")
              #context {
                let user-lines = dmin-chapter-lines.get()
                let test-m = measure(block(width: 100%)[
                  #set text(size: 12pt, weight: "regular")
                  #set par(leading: 0pt, justify: false, first-line-indent: 0pt)
                  #upper(it.body)
                ])
                let title-leading = if user-lines != auto {
                  if user-lines >= 3 { word-single-leading } else { word-double-leading }
                } else if test-m.height >= 35pt {
                  word-single-leading
                } else {
                  word-double-leading
                }
                block(width: 100%)[
                  #set par(leading: title-leading, justify: false, first-line-indent: 0pt)
                  #upper(it.body)
                ]
              }
            ]
          ]
        }
      }
    } else if it.level == 2 {
      // AU Level 1 Subheading: Centered, Bold, Title Case
      // Triple space before (28pt); Double space after (14pt); Double space between consecutive subheads (14pt)
      context {
        let is-consec = (
          it.has("supplement") and (it.supplement == [consecutive] or repr(it.supplement) == "[consecutive]")
        )
        let was-subhead = consecutive-subhead.get()
        let abv = if is-consec or was-subhead { word-space-skip-2 } else { word-space-skip-3 }
        consecutive-subhead.update(true)
        block(width: 100%, above: abv, below: word-space-skip-2, sticky: true)[
          #align(center)[
            #block(width: 4.75in)[
              #set text(size: 12pt, weight: "bold")
              #set par(leading: word-single-leading, justify: false, first-line-indent: 0pt)
              #it.body
            ]
          ]
        ]
      }
    } else if it.level == 3 {
      // AU Level 2 Subheading: Centered, Regular (not bold), Title Case
      context {
        let is-consec = (
          it.has("supplement") and (it.supplement == [consecutive] or repr(it.supplement) == "[consecutive]")
        )
        let was-subhead = consecutive-subhead.get()
        let abv = if is-consec or was-subhead { word-space-skip-2 } else { word-space-skip-3 }
        consecutive-subhead.update(true)
        block(width: 100%, above: abv, below: word-space-skip-2, sticky: true)[
          #align(center)[
            #block(width: 4.75in)[
              #set text(size: 12pt, weight: "regular")
              #set par(leading: word-single-leading, justify: false, first-line-indent: 0pt)
              #it.body
            ]
          ]
        ]
      }
    } else if it.level == 4 {
      // AU Level 3 Subheading: Left margin, Bold, Title Case
      context {
        let is-consec = (
          it.has("supplement") and (it.supplement == [consecutive] or repr(it.supplement) == "[consecutive]")
        )
        let was-subhead = consecutive-subhead.get()
        let abv = if is-consec or was-subhead { word-space-skip-2 } else { word-space-skip-3 }
        consecutive-subhead.update(true)
        block(width: 100%, above: abv, below: word-space-skip-2, sticky: true)[
          #align(left)[
            #block(width: 3.0in)[
              #set text(size: 12pt, weight: "bold")
              #set par(leading: word-single-leading, justify: false, first-line-indent: 0pt)
              #it.body
            ]
          ]
        ]
      }
    } else if it.level == 5 {
      // AU Level 4 Subheading: Left margin, Regular (not bold), Sentence style
      context {
        let is-consec = (
          it.has("supplement") and (it.supplement == [consecutive] or repr(it.supplement) == "[consecutive]")
        )
        let was-subhead = consecutive-subhead.get()
        let abv = if is-consec or was-subhead { word-space-skip-2 } else { word-space-skip-3 }
        consecutive-subhead.update(true)
        block(width: 100%, above: abv, below: word-space-skip-2, sticky: true)[
          #align(left)[
            #block(width: 3.0in)[
              #set text(size: 12pt, weight: "regular")
              #set par(leading: word-single-leading, justify: false, first-line-indent: 0pt)
              #it.body
            ]
          ]
        ]
      }
    } else {
      it
    }
  }

  // ============================================================================
  // TABLES AND FIGURES — Chapter 2 (p. 7-8) & Chapter 3 (p. 13) & Exhibit F
  // ============================================================================
  show figure.where(kind: table): it => {
    consecutive-subhead.update(false)
    block(width: 100%, above: word-space-skip-4, below: word-space-skip-4)[
      #set align(left)
      #set par(leading: word-single-leading, justify: false, first-line-indent: 0pt)
      #if it.has("caption") and it.caption != none [
        #context {
          let s = dmin-get-strings(au-dmin-lang.get())
          text(weight: "bold")[#s.table #it.counter.display(). #it.caption.body]
        }
        #v(word-space-skip-2, weak: true)
      ]
      #it.body
    ]
  }

  show figure.where(kind: image): it => {
    consecutive-subhead.update(false)
    block(width: 100%, above: word-space-skip-4, below: word-space-skip-4)[
      #set align(left)
      #set par(leading: word-single-leading, justify: false, first-line-indent: 0pt)
      #align(center)[#it.body]
      #if it.has("caption") and it.caption != none [
        #v(word-space-skip-2, weak: true)
        #context {
          let s = dmin-get-strings(au-dmin-lang.get())
          text(weight: "regular")[#s.figure #it.counter.display(). #it.caption.body]
        }
      ]
    ]
  }

  // ============================================================================
  // TABLE OF CONTENTS & LIST ENTRIES — Exhibits E & F (p. 38-40)
  // ============================================================================
  show outline.entry: it => {
    set text(size: 12pt)
    let loc = it.element.location()
    let p-num = counter(page).at(loc)
    let format = loc.page-numbering()
    let is-roman = format != none and (format == "i" or format == "I")
    let p = if format != none { numbering(format, ..p-num) } else { str(p-num.first()) }
    let fill-dots = box(width: 1fr, repeat[ . ])
    let p-box = box(width: 0.35in, align(right)[#link(loc)[#p]])

    if it.element.func() == figure and it.element.kind == table {
      // List of Tables entry per Exhibit F (p. 40)
      v(word-space-skip-3, weak: true)
      let cap = it.element.caption.body
      context {
        let num = it.element.counter.at(loc).first()
        grid(
          columns: (0.35in, 1fr),
          align: (top + left, top + left),
          [#num.],
          [
            #set par(
              leading: word-single-leading,
              first-line-indent: 0pt,
              justify: false,
            )
            #show linebreak: it => [#it#h(0.30in)]
            #link(loc)[#cap]#fill-dots#h(word-space-skip-2)#p-box
          ],
        )
      }
    } else if it.element.func() == figure and it.element.kind == image {
      // List of Illustrations entry per Exhibit F (p. 40)
      v(word-space-skip-3, weak: true)
      let cap = it.element.caption.body
      context {
        let num = it.element.counter.at(loc).first()
        grid(
          columns: (0.35in, 1fr),
          align: (top + left, top + left),
          [#num.],
          [
            #set par(
              leading: word-single-leading,
              first-line-indent: 0pt,
              justify: false,
            )
            #show linebreak: it => [#it#h(0.30in)]
            #link(loc)[#cap]#fill-dots#h(word-space-skip-2)#p-box
          ],
        )
      }
    } else if it.element.func() == heading {
      if it.level == 1 {
        is-first-subhead.update(true)
        if is-roman {
          // Preliminary pages in TOC (e.g. LIST OF TABLES, ACKNOWLEDGMENTS) — Flush left
          v(word-space-skip-2, weak: true)
          block(above: word-space-skip-2, below: 0pt)[
            #set par(
              leading: word-single-leading,
              first-line-indent: 0pt,
              justify: false,
            )
            #link(loc)[#upper(it.element.body)]#fill-dots#h(word-space-skip-1)#p-box
          ]
        } else if (
          it.element.has("supplement")
            and (it.element.supplement == [Appendix] or it.element.supplement == [Appendix-cover])
        ) {
          // Appendix entry per Exhibit E (p. 38-39)
          context {
            let s = dmin-get-strings(au-dmin-lang.get())
            let was-seen = seen-appendix.get()
            if not was-seen {
              seen-appendix.update(true)
              v(word-space-skip-2, weak: true)
              block(width: 100%, above: word-space-skip-1, below: 6pt)[
                #set par(first-line-indent: 0pt, leading: word-single-leading)
                #s.appendix_word
              ]
            } else {
              v(word-space-skip-2, weak: true)
            }
            let a-num = appendix-counter.at(loc)
            let letter = numbering("A.", ..a-num)
            block(above: 2pt, below: 0pt)[
              #pad(left: 0.3in)[
                #grid(
                  columns: (0.3in, 1fr),
                  align: (top + left, top + left),
                  [#letter],
                  [
                    #set par(
                      leading: word-single-leading,
                      first-line-indent: 0pt,
                      justify: false,
                    )
                    #link(loc)[#upper(it.element.body)]#fill-dots#h(word-space-skip-1)#p-box
                  ],
                )
              ]
            ]
          }
        } else if it.element.numbering == none {
          // Unnumbered level 1 headings (REFERENCE LIST, VITA, etc.) — Flush left
          v(word-space-skip-2, weak: true)
          block(above: word-space-skip-2, below: 0pt)[
            #set par(
              leading: word-single-leading,
              first-line-indent: 0pt,
              justify: false,
            )
            #link(loc)[#upper(it.element.body)]#fill-dots#h(word-space-skip-1)#p-box
          ]
        } else {
          // Chapter entry per Exhibit E (p. 38-39)
          context {
            let s = dmin-get-strings(au-dmin-lang.get())
            let was-seen = seen-chapter.get()
            if not was-seen {
              seen-chapter.update(true)
              v(word-space-skip-2, weak: true)
              block(width: 100%, above: word-space-skip-1, below: 6pt)[
                #set par(first-line-indent: 0pt, leading: word-single-leading)
                #s.chapter_word
              ]
            } else {
              v(word-space-skip-1, weak: true)
            }
            let c-num = counter(heading).at(loc)
            let num = numbering(it.element.numbering, ..c-num)
            block(above: 2pt, below: 0pt)[
              #pad(left: 0.3in)[
                #grid(
                  columns: (0.3in, 1fr),
                  align: (top + left, top + left),
                  [#num],
                  [
                    #set par(
                      leading: word-single-leading,
                      first-line-indent: 0pt,
                      justify: false,
                    )
                    #link(loc)[#upper(it.element.body)]#fill-dots#h(word-space-skip-1)#p-box
                  ],
                )
              ]
            ]
          }
        }
      } else {
        // AU DMin Manual (p. 7, 9): TOC must reflect only the first 3 levels of subheadings (Typst levels 2, 3, 4).
        // 4th and 5th levels of subheadings (Typst level > 4) are excluded.
        if it.level > 4 {
          return none
        }

        // Subheadings (levels 2, 3, 4) — Single-spaced per Exhibit E (p. 38-39)
        // With hanging indent on runover lines and manual line breaks (\).
        let indent = if it.level == 2 {
          0.9in
        } else if it.level == 3 {
          1.2in
        } else {
          1.5in
        }

        context {
          let first = is-first-subhead.get()
          if first {
            is-first-subhead.update(false)
            v(word-space-skip-2, weak: true)
          }
          block(above: 6pt, below: 6pt)[
            #pad(left: indent)[
              #set par(
                leading: word-single-leading,
                first-line-indent: 0pt,
                justify: false,
              )
              #show linebreak: it => [#it#h(0.30in)]
              #link(loc)[#it.element.body]#fill-dots#h(word-space-skip-1)#p-box
            ]
          ]
        }
      }
    }
  }

  body
}
