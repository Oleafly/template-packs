// --- CONSTANTES ET PALETTE DE COULEURS

// Couleurs
#let _BACKGROUND     = rgb("#FAFAFA")
#let _TEXT-MAIN      = black
#let _TEXT-SECONDARY = rgb("#607877")
#let _ACCENT-MAIN    = rgb("#1A4342")
#let _ACCENT-SOFT    = rgb("#E8F0F0")
#let _IMPORTANT      = rgb("#D99218")
#let _IMPORTANT-SOFT = rgb("#FDF5E6")
#let _ALERT          = rgb("#9E3A34")
#let _ALERT-SOFT     = rgb("#F9EBEA")

// --- FONCTION MAÎTRESSE ---

// Cette fonction redéfinit le comportement des composants usuels de typst, afin d'être cohérents visuellement. Elle définit aussi la page de titre.

#let presentation(
  title: "Titre de la Présentation",
  subtitle: none,
  author: "Votre Nom",
  date: none,
  cover: none,
  cover-filter-transparency: 20%,
  body
) = {

  set page(
    paper: "presentation-16-9",
    margin: (x: 2cm, top: 2cm, bottom: 2cm),
    fill: _BACKGROUND,
    // Définition des header
    header: [
      #text(size: 0.8em, fill: _TEXT-SECONDARY)[#title]
      #h(1fr)
      #if author != none {
        text(size: 0.8em, fill: _TEXT-SECONDARY)[#author]
      }
    ],
    // Définition du footer
    footer: context [
      #if date != none {
        text(size: 0.8em, fill: _TEXT-SECONDARY)[#date]
      }
      #h(1fr)
      #text(
        size: 0.8em,
        fill: _TEXT-SECONDARY,
        counter(page).display("1 / 1", both: true)
      )
    ]
  )

  set text(
    font: "Noto Sans", 
    size: 14pt, 
    fill: _TEXT-MAIN
  )

  show link: set text(
    fill: _ACCENT-MAIN,
  )

  set par(
    justify: false, 
    leading: 0.8em,
    spacing: 1em
  )

  set list(
    spacing: 1em, 
    marker: text(fill: _ACCENT-MAIN, "•")
  )

  show figure: it => {
    block(
      radius: 10pt,
      stroke: 1pt + _ACCENT-MAIN,
      clip: true,
      it
    )
  }

  show raw: it => {
    if it.block {
      block(
        width: 100%,
        inset: 10pt,
        radius: 5pt,
        fill: _ACCENT-SOFT,
        it
      )
    } else {
      box(
        fill: _ACCENT-SOFT,
        radius: 3pt,
        inset: (x: 4pt, y: 2pt),
        baseline: 1pt,
        it
      )
    }
  }

  set grid(
    gutter: 1em,
  )

  // --- PAGE DE TITRE ---
  page(
    header: none, 
    footer: [
      #if author != none {
        text(size: 1em, weight: "medium", fill: _BACKGROUND)[#author]
      }
      #h(1fr)
      #if date != none {
        text(size: 1em, fill: _BACKGROUND)[#date]
      }
    ],
    background: if (cover != 0) {
      place(
        top + left,
        image(
          cover,
          width: 100%,
          height: 100%,
          fit: "cover"
        )
      )
      place(
        top + left,
        rect(width: 100%, height: 100%, fill: _ACCENT-MAIN.transparentize(cover-filter-transparency))
      )
    },
    fill: if (cover == none) {
      _ACCENT-MAIN
    }
  )[
    #set align(center + horizon)
    #text(size: 3em, weight: "bold", fill: _BACKGROUND)[#title]

    #if sub != none {
      v(0.5em)
      text(size: 1.5em, style: "italic", fill: _BACKGROUND)[#subtitle]
    }

  ]

  body
}

// --- MACROS DE MISE EN PAGE

#let _layout-grid(..args) = {
  grid(
    gutter: 1em,
    ..args
  )
}

#let section(
  title,
  subtitle: none
) = {
  pagebreak(weak: true)

  set page(
    fill: _ACCENT-MAIN,
    margin: 3cm,
    header: none,
    footer: none
  )

  set text(
    fill: _BACKGROUND
  )

  align(center + horizon)[
    #if title != none {
      text(
        size: 2em,
        weight: "bold",
        title
      )
      [#metadata((type: "section", text: title)) <section_entry>]
    }

    #if title != none and subtitle != none {
      v(1em)
    }

    #if subtitle != none {
      text(
        size: 1.5em,
        style: "italic",
        subtitle
      )
    }
  ]
}

#let _title(title) = {
  block(
      width: 100%,
    )[
    #set par(
      spacing: 0.5em
    )
    #text(
      fill: _ACCENT-MAIN,
      weight: "bold",
      size: 2em
    )[#title]
    #metadata((type: "slide", text: title)) <slide_entry>
    #line(
      length: 100%,
      stroke: 1.5pt + _ACCENT-MAIN
    )
  ]
}

#let _content-block(content) = {
  block(
    spacing: 0pt,
    content
  )
}

#let single(
  title: none,
  ratio: none,
  content
) = {
  pagebreak(weak: true)

  if title != none {
    _layout-grid()[
      #_title(title)
    ][
      #_content-block(content)
    ]
  } else {
    _layout-grid()[
      #_content-block(content)
    ]
  }
}

#let split-2(
  title: none,
  ratio: none,
  left-content,
  right-content
) = {
  pagebreak(weak: true)

  if (title != none) {
    _layout-grid(
      columns: (1fr, 1fr),
      grid.cell(colspan: 2)[
        #_title(title)
      ],
      _content-block(left-content),
      _content-block(right-content)
    )
  } else {
    _layout-grid(
      columns: (1fr, 1fr),
      _content-block(left-content),
      _content-block(right-content)
    )
  }
}

#let split-3(
  title: none,
  left-content,
  middle-content,
  right-content
) = {
  pagebreak(weak: true)

  if (title != none) {  
    _layout-grid(
      columns: (1fr, 1fr, 1fr),
      rows: (auto, 1fr),
      grid.cell(
        colspan: 3,
        _title(title)
      ),
      _content-block(left-content),
      _content-block(middle-content),
      _content-block(right-content)
    )
  } else {
    _layout-grid(
      columns: (1fr, 1fr, 1fr),
      rows: 1fr,
      gutter: 1em,
      _content-block(left-content),
      _content-block(middle-content),
      _content-block(right-content)
    )
  }
}

// Permet de mettre un contenu en valeur en le plaçant au centre de la slide.
#let focus-slide(
  title: none,
  content,
) = {

  pagebreak(weak: true)

  if title != none {
    _layout-grid(
      columns: (1fr),
      rows: (auto, 1fr),
      _title(title),
      grid.cell(
        align: center + horizon,
        _content-block(content) 
      )
    )
  } else {
    _layout-grid(
      columns: (1fr),
      rows: (1fr),
      grid.cell(
        align: center + horizon,
        _content-block(content) 
      )
    )
  }
}

// Crée une slide d'index à partir des titres des slides et des sections

#let index() = single(
  title: "Index"
)[
  #context {
    let entries = query(selector(<slide_entry>).or(<section_entry>))

    let formated-list = entries.map(entry => {

      let info = entry.value

      show link: set text(fill: _TEXT-MAIN)

      let content-item = if info.type == "section" {
        v(1em, weak: true)
        strong(text(size: 1.1em, info.text))
      } else if info.type == "slide" {
        v(1em, weak: true)
        pad(left: 1.5em, text(size: 0.9em, info.text))
      }

      link(entry.location(), content-item)
    })

    columns(2, gutter: 30pt)[
      #formated-list.join()
    ]
  }
]

// Permet de mettre un contenu en valeur lui donnant tout l'espace de la slide et en supprimant header, footer et marges

#let cover(content) = {
  pagebreak(weak: true)

  set page(
    header: none,
    footer: none,
    margin: 0pt
  )

  _layout-grid(
    rows: (1fr),
    columns: (1fr),
    align: center + horizon,
    _content-block(content)
  )
}

// --- COMPOSANTS RÉUTILISABLES ---

// Une boîte de mise en valeur (Callout)
#let _level = (
  focus: "focus",
  important: "important",
  alert: "alert"
)

#let focus(
  level: _level.focus,
  content
) = {

  if (level == _level.focus) {
    block(
      fill: _ACCENT-SOFT,
      stroke: (left: 4pt + _ACCENT-MAIN),
      inset: 15pt,
      width: 100%,
      content
    )
  }

  if (level == _level.important) {
    block(
      fill: _IMPORTANT-SOFT,
      stroke: (left: 4pt + _IMPORTANT),
      inset: 15pt,
      width: 100%,
      content
    )
  }

  if (level == _level.alert) {
    block(
      fill: _ALERT-SOFT, 
      stroke: (left: 4pt + _ALERT),
      inset: 15pt,
      width: 100%,
      content
    )
  }

}

#let small(text) = {
  text(
    size: 0.8em,
    text
  )
}