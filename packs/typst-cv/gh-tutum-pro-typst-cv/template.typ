// template.typ — cała logika składu i stylu CV.
// Treść mieszka w data.yaml; ten plik zamienia dane w dokument.

// ---- Paleta i konfiguracja ------------------------------------------------
#let accent = rgb("#1f4e79") // stonowany granat; zmień na swój kolor marki
#let ink = luma(28) // tekst podstawowy
#let muted = luma(105) // daty, lokalizacje, drobne teksty
#let rule-color = luma(190) // linie sekcji

// ---- Elementy pomocnicze --------------------------------------------------

// Wiersz kontaktowy: łączy tylko obecne pola separatorem "·".
// Pola website/github/linkedin przyjmują też listę wartości.
#let contact-line(contact) = {
  let as-link(key, v) = {
    if key == "email" { link("mailto:" + v)[#v] } else { link("https://" + v)[#v] }
  }
  let collect(keys) = {
    let parts = ()
    for key in keys {
      let v = contact.at(key, default: none)
      if v == none { continue }
      if type(v) == array {
        for item in v { parts.push(as-link(key, item)) }
      } else if key in ("email", "website", "github", "linkedin") {
        parts.push(as-link(key, v))
      } else {
        parts.push(v)
      }
    }
    parts
  }
  let sep = text(fill: rule-color)[ \u{2002}·\u{2002} ]
  let row1 = collect(("email", "phone", "location"))
  let row2 = collect(("website", "github", "linkedin"))
  set text(size: 8.8pt, fill: muted, hyphenate: false)
  stack(
    spacing: 0.45em,
    if row1.len() > 0 { row1.join(sep) },
    if row2.len() > 0 { row2.join(sep) },
  )
}

// Nagłówek sekcji: rozstrzelone wersaliki, linia odsunięta od tekstu
#let section(title) = block(
  above: 1.75em,
  below: 0.9em,
  width: 100%,
  stack(
    spacing: 0.42em,
    text(size: 9pt, weight: "semibold", tracking: 0.16em, fill: accent, upper(title)),
    line(length: 100%, stroke: 0.5pt + rule-color),
  ),
)

// Lista wypunktowana o wspólnym stylu (wiszący wcięcie, marker w kolorze akcentu)
#let bullets(items) = {
  set text(size: 9.7pt, fill: ink)
  set par(leading: 0.55em, spacing: 0.44em)
  set list(
    marker: text(fill: accent, size: 9.7pt)[\u{2013}],
    indent: 0.1em,
    body-indent: 0.55em,
    spacing: 0.44em,
  )
  list(..items.map(i => [#i]))
}

// Pełny wpis doświadczenia: stanowisko + daty w jednym wierszu,
// firma i lokalizacja w drugim, poniżej wypunktowania.
#let entry(role: "", org: "", location: none, dates: "", highlights: ()) = block(
  below: 1.3em,
  breakable: false,
  width: 100%,
  {
    grid(
      columns: (1fr, auto),
      align: (left + bottom, right + bottom),
      column-gutter: 1em,
      text(size: 10.8pt, weight: "semibold", fill: ink)[#role],
      text(size: 9pt, fill: muted)[#dates],
    )
    v(0.28em, weak: false)
    {
      set text(size: 9.5pt)
      text(fill: accent, weight: "medium")[#org]
      if location != none { text(fill: muted)[ \u{2002}·\u{2002} #location] }
    }
    if highlights.len() > 0 {
      v(0.5em, weak: false)
      bullets(highlights)
    }
  },
)

// Wpis skondensowany — jedna linia na rolę (starsze doświadczenie)
#let compact-entry(dates: "", role: "", org: "", note: none) = block(
  below: 0.7em,
  width: 100%,
  grid(
    columns: (2.9cm, 1fr),
    column-gutter: 0.8em,
    align: (left + top, left + top),
    text(size: 9pt, fill: muted)[#dates],
    {
      set text(size: 9.7pt)
      text(weight: "semibold", fill: ink)[#role]
      text(fill: accent)[ · #org]
      if note != none {
        linebreak()
        text(size: 9pt, fill: muted)[#note]
      }
    },
  ),
)

// Wpis projektu: nazwa po lewej, klikalny adres po prawej, opis poniżej
#let project-entry(name: "", link-url: none, note: none) = block(
  below: 0.85em,
  breakable: false,
  width: 100%,
  {
    grid(
      columns: (1fr, auto),
      align: (left + bottom, right + bottom),
      column-gutter: 1em,
      text(size: 10.2pt, weight: "semibold", fill: ink)[#name],
      if link-url != none {
        text(size: 9pt, fill: accent)[#link("https://" + link-url)[#link-url]]
      },
    )
    if note != none {
      v(0.22em, weak: false)
      set text(size: 9.5pt, fill: luma(52))
      set par(leading: 0.55em)
      note
    }
  },
)

// ---- Główna funkcja dokumentu ---------------------------------------------
#let cv(data) = {
  set document(title: data.name + " — CV", author: data.name)
  set page(
    paper: "a4",
    margin: (x: 2cm, top: 1.5cm, bottom: 1.4cm),
    footer: context {
      let here = counter(page).get().first()
      let total = counter(page).final().first()
      if total > 1 and here > 1 {
        set text(size: 8pt, fill: muted)
        grid(
          columns: (1fr, auto),
          align: (left + horizon, right + horizon),
          data.name + " \u{2002}·\u{2002} CV",
          [#here / #total],
        )
      }
    },
  )
  set text(font: "IBM Plex Sans", size: 10pt, lang: data.at("lang", default: "pl"), fill: ink, hyphenate: false)
  set par(justify: false, leading: 0.6em, spacing: 0.6em)

  // Numer telefonu wstrzykiwany przy kompilacji, żeby nie leżał w repozytorium:
  //   typst compile --input phone="+48 ..." cv.typ cv.pdf
  // Bez tego w dokumencie zostaje zamaskowana wartość z pliku danych.
  let contact = data.contact
  let phone-override = sys.inputs.at("phone", default: "")
  if phone-override.trim() != "" {
    contact.insert("phone", phone-override.trim())
  }

  // --- Nagłówek: imię, tytuł, kontakt ---
  block(below: 0.55em)[
    #text(size: 26pt, weight: "light", fill: luma(20))[#data.name]
    #v(-0.5em)
    #text(size: 11.5pt, weight: "medium", fill: accent, tracking: 0.02em)[#data.title]
  ]
  block(below: 0.5em)[#contact-line(contact)]
  line(length: 100%, stroke: 0.8pt + accent)

  // --- Podsumowanie ---
  let summary = data.at("summary", default: none)
  if summary != none {
    block(above: 1em, below: 0.2em)[
      #set text(size: 9.9pt, fill: luma(52))
      #set par(leading: 0.58em)
      #summary
    ]
  }

  // --- Kluczowe technologie (pasek pod podsumowaniem) ---
  let focus = data.at("focus", default: ())
  if focus.len() > 0 {
    block(
      above: 0.9em,
      below: 0.2em,
      width: 100%,
      fill: accent.lighten(94%),
      inset: (x: 0.75em, y: 0.6em),
      radius: 2pt,
      {
        set text(size: 9.3pt, fill: luma(45))
        focus.join(text(fill: accent)[ \u{2002}·\u{2002} ])
      },
    )
  }

  // --- Doświadczenie ---
  let exp = data.at("experience", default: ())
  if exp.len() > 0 {
    section(data.at("experience_title", default: "Doświadczenie"))
    for e in exp {
      entry(
        role: e.at("role", default: ""),
        org: e.at("company", default: ""),
        location: e.at("location", default: none),
        dates: e.at("start", default: "") + " \u{2013} " + e.at("end", default: ""),
        highlights: e.at("highlights", default: ()),
      )
    }
  }

  // --- Projekty własne ---
  let projects = data.at("projects", default: ())
  if projects.len() > 0 {
    block(breakable: false, below: 1.1em, width: 100%, {
      section(data.at("projects_title", default: "Projekty własne"))
      let intro = data.at("projects_intro", default: none)
      if intro != none {
        block(below: 0.85em, width: 100%)[
          #set text(size: 9.5pt, fill: luma(52))
          #set par(leading: 0.55em)
          #intro
        ]
      }
      for pr in projects {
        project-entry(
          name: pr.at("name", default: ""),
          link-url: pr.at("link", default: none),
          note: pr.at("note", default: none),
        )
      }
      let note = data.at("projects_note", default: none)
      if note != none {
        block(above: 0.45em, below: 0.75em, width: 100%)[
          #set text(size: 9pt, fill: muted, style: "italic")
          #set par(leading: 0.55em)
          #note
        ]
      }
    })
  }

  // --- Wcześniejsze doświadczenie (skondensowane) ---
  let earlier = data.at("earlier", default: ())
  if earlier.len() > 0 {
    block(breakable: false, width: 100%, {
      section(data.at("earlier_title", default: "Wcześniejsze doświadczenie"))
      for e in earlier {
        compact-entry(
          dates: e.at("start", default: "") + " \u{2013} " + e.at("end", default: ""),
          role: e.at("role", default: ""),
          org: e.at("company", default: ""),
          note: e.at("note", default: none),
        )
      }
    })
  }

  // --- Umiejętności ---
  let skills = data.at("skills", default: ())
  if skills.len() > 0 {
    section(data.at("skills_title", default: "Umiejętności"))
    grid(
      columns: (5.2cm, 1fr),
      row-gutter: 0.5em,
      column-gutter: 0.8em,
      ..skills
        .map(s => (
          text(weight: "semibold", size: 9.2pt, fill: luma(45))[#s.category],
          {
            set text(size: 9.5pt)
            set par(leading: 0.5em)
            s.at("items", default: ()).join(text(fill: rule-color)[ · ])
          },
        ))
        .flatten(),
    )
  }

  // --- Certyfikaty ---
  let certs = data.at("certifications", default: ())
  if certs.len() > 0 {
    section(data.at("certifications_title", default: "Certyfikaty"))
    bullets(certs)
  }

  // --- Szkolenia ---
  let courses = data.at("courses", default: ())
  if courses.len() > 0 {
    section(data.at("courses_title", default: "Wybrane szkolenia"))
    bullets(courses)
  }

  // --- Wykształcenie ---
  let edu = data.at("education", default: ())
  if edu.len() > 0 {
    section(data.at("education_title", default: "Wykształcenie"))
    for ed in edu {
      block(below: 0.5em, width: 100%)[
        #grid(
          columns: (1fr, auto),
          align: (left + bottom, right + bottom),
          column-gutter: 1em,
          {
            set text(size: 9.9pt)
            text(weight: "semibold")[#ed.at("degree", default: "")]
            text(fill: accent)[ · #ed.at("school", default: "")]
            let loc = ed.at("location", default: none)
            if loc != none { text(size: 9pt, fill: muted)[, #loc] }
          },
          text(size: 9pt, fill: muted)[
            #(ed.at("start", default: "") + " \u{2013} " + ed.at("end", default: ""))
          ],
        )
      ]
    }
  }

  // --- Zainteresowania ---
  let interests = data.at("interests", default: ())
  if interests.len() > 0 {
    section(data.at("interests_title", default: "Zainteresowania"))
    text(size: 9.7pt)[#interests.join(text(fill: rule-color)[ \u{2002}·\u{2002} ])]
  }

  // --- Języki ---
  let langs = data.at("languages", default: ())
  if langs.len() > 0 {
    section(data.at("languages_title", default: "Języki"))
    text(size: 9.7pt)[
      #langs.map(l => [*#l.name* — #l.at("level", default: "")]).join(text(fill: rule-color)[ \u{2002}·\u{2002} ])
    ]
  }
}
