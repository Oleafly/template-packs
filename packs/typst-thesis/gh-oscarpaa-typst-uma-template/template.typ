
// PARAMETROS DE LA PLANTILLA
#let titlename = "<TÍTULO DEL TRABAJO>"
#let titlenameENG = "<TÍTULO DEL TRABAJO EN INGLÉS>"
#let author = "<AUTOR>"
#let tutor = "<TUTOR>"
#let titulacion = "<TITULACIÓN>"
#let anno = "202X"

// Función para citar acrónimos
#let acr(sigla) = {
  let sigla_str = sigla.text
  link(label("acr_" + sigla_str))[#sigla]
}

// Función para simular small capitalls 
#let sc(body) = {
  context {
    let scaling = 0.8
    let texto = if type(body) == content { body.text } else { body }
    let caracteres = texto.clusters()
    
    let resultado = caracteres.map(ch => {
      if ch.matches(regex("\p{Ll}")).len() > 0 {
        text(size: scaling * 1em, upper(ch)) + h(text.tracking)
      } else if ch.matches(regex("[\p{Lu}\p{N}\.]")).len() > 0 {
        ch + h(text.tracking)
      } else {
        ch
      }
    })
    
    resultado.join()
  }
}

#let hide_header = state("hide_header", false)
#let chapterend() = {
  hide_header.update(true)
  pagebreak(to: "odd", weak: false)
  hide_header.update(false)
}

#let section-type = state("section-type", "Capítulo")

#let index_style(doc) = {
  let last_chapter_loc = state("last_chapter_loc", none)

  show outline.entry: it => {
    let is_heading_l1 = it.level == 1 and it.element.func() == heading
    let is_figure = it.element.func() == figure

    let dot_leader = repeat([.#h(0.5em)])
    let fixed_separation = 0.7em

    if is_heading_l1 {
      v(1.8em, weak: true)
      set par(first-line-indent: 0pt)
      let number = if it.element.numbering != none {
        context {
          box(width: 1.5em)[
            #numbering(it.element.numbering, ..counter(heading).at(it.element.location()))
          ]
        }
      }
      strong([
        #number 
        #link(it.element.location())[#it.element.body] 
        #h(1fr) 
        #it.page()
      ])
    } else if is_figure {
      context {
        let loc = it.element.location()
        let fig_item = it.element

        let kind_str = if type(fig_item.kind) == symbol { str(fig_item.kind) } else { repr(fig_item.kind) }
        let is_first_entry = state("is_first_" + kind_str, true)
        
        if is_first_entry.get() {
          v(1.5em, weak: true) 
          is_first_entry.update(false)
        }

        let current_before = query(heading.where(level: 1).before(loc))
        let current_ch = if current_before.len() > 0 { current_before.last() } else { none }
        let current_ch_loc = if current_ch != none { current_ch.location() } else { none }
        let prev_ch_loc = last_chapter_loc.get()
        
        if prev_ch_loc != none and prev_ch_loc != current_ch_loc {
          v(1.8em, weak: true)
        }
        last_chapter_loc.update(current_ch_loc)

        v(0.8em, weak: true)
        
        let fig_num = if fig_item.numbering != none {
          let fig_counter = counter(figure.where(kind: fig_item.kind)).at(loc).first()
          if current_ch != none and current_ch.numbering != none {
            let ch_prefix = numbering(current_ch.numbering, ..counter(heading).at(current_ch.location()))
            ch_prefix + "." + str(fig_counter)
          } else {
            str(fig_counter)
          }
        } else { "" }

        pad(left: 1.8em)[
          #grid(
            columns: (2.3em, 1fr, 1.5em),
            align: (left + top, left + top, right + bottom),
            row-gutter: 0pt,
            fig_num,
            [
              #link(loc)[#fig_item.caption.body]
              #h(1em, weak: true)
              #box(width: 1fr)[#dot_leader]
            ],
            [#it.page()]
          )
        ]
      }
    } else {
      v(1em, weak: true)
      context {
        let loc = it.element.location()
        
        let get_width_of_level(lvl) = {
          if it.element.numbering != none {
            let counts = counter(heading).at(loc)
            let sub_counts = counts.slice(0, calc.min(lvl, counts.len()))
            let num_string = numbering(it.element.numbering, ..sub_counts)
            let clusters = num_string.clusters()
            let text_width = clusters.map(c => if c == "." { 0.26em } else { 0.64em }).sum()
            return text_width + fixed_separation 
          }
          return 2.3em
        }
        
        let get_pad(lvl) = {
          if lvl <= 2 { 1.8em } 
          else { get_pad(lvl - 1) + get_width_of_level(lvl - 1) + 0.15em}
        }
        
        let left_pad = get_pad(it.level)
        let current_num_width = get_width_of_level(it.level)
        
        pad(left: left_pad)[
          #grid(
            columns: (current_num_width, 1fr, 1.5em),
            align: (left + top, left + top, right + bottom),
            row-gutter: 0pt,
            if it.element.func() == heading and it.element.numbering != none {
              numbering(it.element.numbering, ..counter(heading).at(loc))
            },
            [
              #link(loc)[#it.element.body]
              #h(1em, weak: true)
              #box(width: 1fr)[#dot_leader]
            ],
            [#it.page()]
          )
        ]
      }
    }
  }
  doc
}

#let project(body) = {
  set page(
    paper: "a4",
    margin: (
      left: 3cm,
      right: 3cm,
      top: 3.5cm,
      bottom: 5.5cm,
    ),
    header: context {
      let current_page = here().page()
      if hide_header.at(here()) == true { return }

      let all_h1 = query(heading.where(level: 1))
      let is_start_of_ch = all_h1.any(h => h.location().page() == current_page)
      let chapters_before = query(heading.where(level: 1).before(here()))

      if chapters_before.len() > 0 and not is_start_of_ch {
        let is_odd = calc.odd(current_page)
        let current_chapter = chapters_before.last()
        let has_numbering = current_chapter.numbering != none
        let ch_num = counter(heading).at(current_chapter.location()).first()

        if is_odd {
          let all_sections = query(heading.where(level: 2))
          let sections_in_page = all_sections.filter(s => s.location().page() == current_page)
          let section_text = ""

          if sections_in_page.len() > 0 {
            let s = sections_in_page.first()
            section_text = numbering(s.numbering, ..counter(heading).at(s.location())) + "  " + s.body
          } else {
            let sections_before = all_sections.filter(s => s.location().page() < current_page)

            if sections_before.len() > 0 {
              let last_s = sections_before.last()
              let is_from_current_ch = (
                (last_s.location().page() > current_chapter.location().page())
                  or (
                    last_s.location().page() == current_chapter.location().page()
                      and last_s.location().position().y > current_chapter.location().position().y
                  )
              )

              if is_from_current_ch {
                section_text = (
                  numbering(last_s.numbering, ..counter(heading).at(last_s.location())) + "  " + last_s.body
                )
              } else {
                section_text = current_chapter.body
              }
            } else {
              section_text = current_chapter.body
            }
          }

          grid(
            columns: (1fr, auto),
            align(left, section_text), align(right, counter(page).display()),
          )
        } else {
          grid(
            columns: (auto, 1fr),
            align(left, counter(page).display()),
            align(right, context {
              let type = section-type.at(here())
              let num = if has_numbering {
                numbering(current_chapter.numbering, ..counter(heading).at(current_chapter.location()))
              }

              if has_numbering {
                [#type #num. #current_chapter.body]
              } else {
                [#current_chapter.body]
              }
            }),
          )
        }
        v(-0.6em)
        line(length: 100%, stroke: 0.8pt)
        v(-0.3em)
      }
    },
    footer: context {
      let current_page = here().page()
      let all_h1 = query(heading.where(level: 1))

      let is_start_of_ch = all_h1.any(h => h.location().page() == current_page)

      if is_start_of_ch {
        v(-0.7cm)
        set align(center)
        counter(page).display()
      }
    },
  )

  set math.equation(numbering: "(1)")

  set text(font: "Nimbus Sans", size: 12pt, tracking: 0.02em, lang: "es")
  set par(
    justify: true,
    leading: 0.5em,
    spacing: 0.91em,
    first-line-indent: (amount: 1.5em, all: true),
  )

  set heading(numbering: "1.1")

  set figure(
    numbering: n => context {
      let before = query(heading.where(level: 1).before(here()))

      if before.len() > 0 {
        let last_h = before.last()
        let h_counter = counter(heading).at(last_h.location())

        if last_h.numbering != none {
          let ch_prefix = numbering(last_h.numbering, ..h_counter)
          [#ch_prefix.#n]
        } else {
          [#n]
        }
      } else {
        [#n]
      }
    },
  )

  show figure: it => {
    v(0.8em)
    it
    v(0.8em)
  }

  show heading: it => {
    set par(first-line-indent: 0pt)
    if it.level == 1 {
      counter(figure.where(kind: image)).update(0)
      counter(figure.where(kind: table)).update(0)

      pagebreak(weak: true)
      v(2.4cm)
      set text(size: 25pt, weight: "bold")

      if it.numbering != none {
        let type = section-type.at(it.location())
        let num = numbering(it.numbering, ..counter(heading).at(it.location()))

        [#type #num]
        v(0.1cm)
        block(it.body)
      } else {
        block(it.body)
      }
      v(1.2cm)
    } else if it.level == 2 {
      v(0.8em)
      set text(size: 17pt, weight: "bold")
      if it.numbering != none {
        let num = numbering(it.numbering, ..counter(heading).at(it.location()))
        [#num #h(1em) #it.body]
      } else {
        it.body
      }
      v(0.4em)
    } else if it.level == 3 {
      v(0.4em)
      set text(size: 14pt, weight: "bold")
      if it.numbering != none {
        let num = numbering(it.numbering, ..counter(heading).at(it.location()))
        [#num #h(0.9em) #it.body]
      } else {
        it.body
      }
      v(0.2em)
    } else {
      if it.numbering != none {
        let num = numbering(it.numbering, ..counter(heading).at(it.location()))
        [#num #h(0.8em) #it.body]
      } else {
        it.body
      }
    }
  }

  show ref: it => {
    let el = it.element
    if el != none {
      context {
        if el.func() == heading {
          link(el.location())[#numbering(el.numbering, ..counter(heading).at(el.location()))]
        } else if el.func() == figure {
          let fig_counter = counter(figure.where(kind: el.kind)).at(el.location()).first()
          
          let current_before = query(heading.where(level: 1).before(el.location()))
          if current_before.len() > 0 and current_before.last().numbering != none {
            let ch_prefix = numbering(current_before.last().numbering, ..counter(heading).at(current_before.last().location()))
            link(el.location())[#ch_prefix.#fig_counter]
          } else {
            link(el.location())[#fig_counter]
          }
        } else if el.func() == math.equation {
          if el.numbering != none {
            let eq_counter = counter(math.equation).at(el.location()).first()
            link(el.location())[#str(eq_counter)]
          } else {
            it
          }
        } else {
          it
        }
      }
    } else {
      it
    }
  }

  body
}

#let appendices(doc) = {
  counter(heading).update(0)
  set heading(numbering: "A.1")
  show heading.where(level: 1): it => {
    section-type.update("Apéndice")
    it
  }

  doc
}

#let minitoc() = context {
  let current_loc = here()
  let chapters_before = query(heading.where(level: 1).before(current_loc))
  if chapters_before.len() == 0 { return }

  let current_ch = chapters_before.last()
  let chapters_after = query(heading.where(level: 1).after(current_loc))
  let next_ch_loc = if chapters_after.len() > 0 { chapters_after.first().location() } else { none }

  v(0.5em)
  set par(first-line-indent: 0pt)
  text(size: 14pt, weight: "bold")[Contenido]
  v(-0.7em)
  line(length: 100%, stroke: 0.4pt)
  v(-0.4em)

  set text(size: 11pt)

  pad(left: 2em)[
    #block(width: 95%, breakable: true)[
      #set align(left)
      #show outline.entry: it => {
        let it_loc = it.element.location()
        let is_after_start = (
          it_loc.position().page > current_ch.location().position().page
            or (
              it_loc.position().page == current_ch.location().position().page
                and it_loc.position().y >= current_ch.location().position().y
            )
        )

        let is_before_next = if next_ch_loc != none {
          (
            it_loc.position().page < next_ch_loc.position().page
              or (
                it_loc.position().page == next_ch_loc.position().page and it_loc.position().y < next_ch_loc.position().y
              )
          )
        } else { true }

        if is_after_start and is_before_next and it.level > 1 {
          v(0.45em, weak: true)
          if it.level == 2 {
            strong(it)
          } else {
            it
          }
        } else {
          none
        }
      }

      #outline(
        title: none,
        target: heading.where(level: 2).or(heading.where(level: 3)),
      )
    ]
  ]

  v(-0.3em)
  line(length: 100%, stroke: 0.4pt)
}
