#import "sizes.typ": *
#import "util.typ":custom_outline_size, custom_outline_space
#import "translation.typ": get-i8n
#import "data.typ": *
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#import "@preview/drafting:0.2.2": *


#set document(author: nombre_autor, title: titulo_trabajo, date: fecha)
#set text(size: normal_size, lang: lang)
// #set text(font: "Bookman Old Style")
#set text(font: ("URW Bookman", "Bookman Old Style", "libertinus serif"))
#set page(paper: "a4", margin: (y: 3.5cm, x: 3cm))

#show smallcaps: set text(font: "Latin Modern Roman Caps")

// Si quieres usar comillas altas en vez de angulares, descomenta la siguiente linea
// #set smartquote(quotes: "“”")

#set par(justify: true)

#show: codly-init.with()

// Aqui puede cambiar los bloques de codigo
#codly(languages: codly-languages, number-format: it => text(numbering("1",it), fill: gray.darken(15%)))

#let page_zone = counter(<page-zone>)

#show outline.entry.where(
  level: 1
): set block(above: 1.2em)

#show outline.entry.where(
  level: 1
): set text(weight: "bold")
#set outline.entry(fill: repeat([.], gap: 0.45em))
#show outline.entry.where(
  level: 1
): set outline.entry(fill: none)

#show outline.entry.where(
  level: 1
): it => {
  let sz = custom_outline_size.at(it.element.location())
  let space = custom_outline_space.at(it.element.location())
  set text(size: sz) if sz != none
  set block(above: space) if space != none
  it
  // [#(sz, it.element.location()) #it]
}

#include "portada/portada.typ"


#show heading: it => {
  v(0.7cm)
  it
	if it.level == 2 [
		#metadata([#counter(heading).display(it.numbering) #it.body]) <section-start>
	]
  v(0.5cm)
}
#show heading.where(level: 1): set heading(supplement: get-i8n("chapter"))
#show heading.where(level: 1): it => {
  [
    #{
      set page(header: none, numbering: none)
      pagebreak(weak: true, to: "odd")
    }
    // #
    // #set page(numbering: none)
    // #
    #v(4.5cm)
    #if it.numbering != none [
      #set text(size: LARGE_size)
      #it.supplement #counter(heading).display(it.numbering.replace(regex("\."), ""))
    ]

    #set text(size: Huge_size + 2pt)
    #it.body
		#metadata([
			#if it.numbering != none [ #it.supplement #counter(heading).display(it.numbering) ] #it.body]) <chapter-start>
    #v(1cm)
  ]
}
#set page(header: context {
  let matches = query(selector(<chapter-start>))
  let current_page = counter(page).get().at(0)
  let current_zone = page_zone.get().at(0)
  let chapter-start = matches.find(m => counter(page).at(m.location()).at(0) == current_page and page_zone.at(m.location()).at(0) == current_zone)

  if chapter-start == none {
    if calc.odd(current_page) {
      let current_section = query(selector(<section-start>).before(here())).last(default: none)
      if current_section != none {
        let c = counter(heading).get()
				set align(right)
        // [*#current_section.supplement #numbering("1.", c.at(0), c.at(1)) #current_section.body*]
        [*#current_section.value*]
      }
    } else {
      let current_chapter = query(selector(<chapter-start>).before(here())).last(default: none)
      if current_chapter != none {
        [*#current_chapter.value*]
      }
    }
    move(line(length: 100%), dy: -0.25cm)
  }
})

#pagebreak()
#metadata("roman-numbers")<page-zone>
#counter(page).update(1)
#set page("a4", numbering: "i")

#include "secciones/agradecimientos.typ"
#include "secciones/resumen.typ"

#pagebreak()

#outline(title: get-i8n("toc"))


#set heading(numbering: "1.")
#{
  set page(header: none, numbering: none)
  pagebreak(weak: true, to: "odd")
}
#metadata("arabic-numbers")<page-zone>
#counter(page).update(1)
#set page("a4", numbering: "1")

#include "secciones/intro.typ"
#include "secciones/desarrollo.typ"
#include "secciones/impacto.typ"
#include "secciones/conclusiones.typ"

#bibliography("secciones/biblio.yml")

#{
  show heading: none
  {
    set page(header: none, numbering: none)
    pagebreak(weak: true, to: "odd")
  }

  custom_outline_size.update(large_size)
  custom_outline_space.update(2em)
  heading(get-i8n("annex-pl"), numbering: none)
  custom_outline_size.update(none)
  custom_outline_space.update(none)

  set align(center)
  v(1fr)
  text(size: Huge_size + 2pt)[
    *#get-i8n("annex-pl")*
    #metadata([]) <chapter-start>
  ]
  v(1fr)
}

#show heading: set heading(numbering: "A.1.")
#show heading.where(level: 1): set heading(numbering: "A.", supplement: get-i8n("annex"))
#counter(heading).update(0)

#include "secciones/anexo1.typ"



