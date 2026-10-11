// =============================================================================
// UL FRI Magistrsko delo – Front pages
// Naslovnica, avtorske pravice, zahvala, posvetilo, kratice
// =============================================================================

#import "style.typ": clear-empty-double-page

// --- Naslovnica (title page) -------------------------------------------------

#let title-page(config: (:)) = {
  set page(numbering: none, header: none, footer: none)
  set align(center)

  // University and faculty name
  text(size: 14pt, weight: "regular")[
    #smallcaps[Univerza v Ljubljani] \
    #smallcaps[Fakulteta za računalništvo in informatiko]
  ]

  v(10em)

  // Author name
  text(size: 14pt)[#config.author]

  v(2em)

  // Thesis title
  block[
    #set par(justify: false)
    #set text(hyphenate: false)
    #text(size: 18pt, weight: "bold")[#config.title]
  ]

  v(2em)

  // Thesis type and program
  block[
    #set par(justify: false)
    #set text(hyphenate: false)
    #smallcaps[MAGISTRSKO DELO]
    #linebreak()
    #v(2mm)
    #smallcaps[#config.program]

    #if config.at("track", default: none) != none {
      linebreak()
      v(2mm)
      smallcaps[Smer: #config.track]
    }
  ]

  v(1fr)

  // Supervisor
  block[
    #set par(justify: false)
    #set text(hyphenate: false)
    #text(size: 12pt)[
      #smallcaps[Mentor]: #config.supervisor
    ]

    #if config.at("cosupervisor", default: none) != none {
      linebreak()
      text(size: 12pt)[
        #smallcaps[Somentor]: #config.cosupervisor
      ]
    }
  ]

  v(2em)

  text(size: 12pt)[Ljubljana, #config.year]

  clear-empty-double-page()
}

// --- Avtorske pravice (copyright page) ---------------------------------------

#let copyright-page(config: (:)) = {
  set page(numbering: none, header: none, footer: none)

  v(1fr)

  set text(size: 9pt)

  [
    To delo je ponujeno pod licenco _Creative Commons Priznanje avtorstva-Deljenje pod enakimi pogoji 4.0 Mednarodna (CC BY-SA 4.0)_.
    To pomeni, da se lahko besedilo, slike, grafi in druge sestavine tega dela prosto delijo, reproducirajo, priobčujejo javnosti in predelujejo za vsak namen, tudi komercialno, če se jasno navede avtor (po možnosti tudi naslov in povezava do izvirnika), priloži povezava do licence, označijo morebitne spremembe, pri predelavah pa se uporabi enaka licenca (CC BY-SA 4.0). Licenca ne dovoljuje dodajanja dodatnih pravnih ali tehničnih omejitev in ne velja za dele, za katere nosilec pravic ni avtor.
    Podrobnosti licence so dostopne na spletni strani #link("https://creativecommons.org").
  ]

  v(4mm)

  // CC icons
  align(center)[
    #box(image("assets/cc-licenca/cc_cc_30.svg", height: 12pt))
    #h(4pt)
    #box(image("assets/cc-licenca/cc_by_30.svg", height: 12pt))
    #h(4pt)
    #box(image("assets/cc-licenca/cc_sa_30.svg", height: 12pt))
  ]

  if config.at("code-published", default: false) {
    v(1.5cm)
    set text(size: 9pt)
    [
      Izvorna koda zaključnega dela, njeni rezultati in v ta namen razvita programska oprema so ponujeni pod licenco GNU General Public License,
      različica 3 (ali novejša). To pomeni, da se lahko prosto distribuirajo in/ali predelujejo pod njenimi pogoji in so na voljo na #link(config.at("code-url", default: "")).
      Podrobnosti licence so dostopne na spletni strani #link("http://www.gnu.org/licenses/").
    ]
  }

  v(1cm)

  align(center, text(size: 9pt, smallcaps[
    \u{00A9} #config.year #config.author
  ]))

  clear-empty-double-page()
}

// --- Zahvala (acknowledgments) -----------------------------------------------

#let acknowledgments-page(body) = {
  set page(numbering: none, header: none, footer: none)

  align(center)[
    #text(size: 14pt, weight: "bold", smallcaps[Zahvala])
  ]

  v(0.5cm)

  body

  clear-empty-double-page()
}

// --- Posvetilo (dedication) --------------------------------------------------

#let dedication-page(body) = {
  set page(numbering: none, header: none, footer: none)

  v(0.20fr)

  align(right)[
    #block(width: 55%)[
      #body
    ]
  ]

  clear-empty-double-page()
}

// --- Seznam kratic (list of abbreviations) -----------------------------------

#let abbreviations-page(entries) = {
  heading(numbering: none, outlined: false, bookmarked: true)[Seznam uporabljenih kratic]

  table(
    columns: (auto, 1fr, 1fr),
    stroke: (x, y) => {
      if x > 0 and x < 3 { (left: 0.5pt + black) }
    },
    inset: (x: 8pt, y: 4pt),
    table.header(
      [*kratica*], [*angleško*], [*slovensko*],
      table.hline(),
    ),
    ..entries.map(e => (
      [*#e.at(0)*], e.at(1), e.at(2),
    )).flatten(),
  )

  clear-empty-double-page()
}
