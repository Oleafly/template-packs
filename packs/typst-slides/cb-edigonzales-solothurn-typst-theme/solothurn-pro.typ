#import "@preview/touying:0.7.4": *
#import "@preview/cades:0.3.1": qr-code

// Solothurn Pro — Touying theme
// Version 0.3: slot-basierter Nachbau der PowerPoint-Layoutbibliothek.
// Abschlussfolie erzeugt QR-Codes direkt aus URL/Text.
// Geometrie basiert auf der PPTX (13.333 x 7.5 in, 16:9).

#let so-colors = (
  red: rgb("#CC0000"),
  blue: rgb("#81ABD1"),
  bg: rgb("#F2F6FA"),
  white: rgb("#FFFFFF"),
  text: rgb("#111111"),
  muted: rgb("#50555B"),
  placeholder: rgb("#E8EDF2"),
  placeholder-stroke: rgb("#A9B0B7"),
)

#let so-slide-width = 13.333in
#let so-slide-height = 7.5in
#let _u(v) = v * 1in
#let _slide-no() = context { str(calc.max(1, utils.slide-counter.get().first())) }
#let _date(self) = utils.display-info-date(self)

#let _logo(self, variant: "red", width: 1.6in) = {
  if variant == "white" and self.store.logo-white != none {
    image(self.store.logo-white, width: width)
  } else if variant != "white" and self.store.logo-red != none {
    image(self.store.logo-red, width: width)
  } else {
    text(
      font: self.store.body-font,
      size: 9pt,
      weight: "bold",
      fill: if variant == "white" { so-colors.white } else { so-colors.red },
      [KANTON solothurn],
    )
  }
}

#let _box(x, y, w, h, body, fill: none, clip: false, inset: 0pt, alignment: top + left) = {
  place(top + left, dx: _u(x), dy: _u(y))[
    #block(width: _u(w), height: _u(h), fill: fill, clip: clip, inset: inset)[
      #align(alignment)[#body]
    ]
  ]
}

#let _title(self, body, size: 27pt, fill: so-colors.red, weight: "regular") = block(above: 0pt, below: 0pt)[
  #set text(font: self.store.title-font, size: size, weight: weight, fill: fill)
  // Resolve em in the text's own size and keep paragraph styling local.
  #set par(leading: self.store.title-leading)
  #body
]

#let _body(self, body, size: 13pt, fill: so-colors.text, weight: "regular") = block(above: 0pt, below: 0pt)[
  #set text(font: self.store.body-font, size: size, weight: weight, fill: fill)
  // Resolve em in the text's own size and keep paragraph styling local.
  #set par(leading: self.store.body-leading)
  #body
]

#let _image-slot(path, w, h, fit: "cover", placeholder-label: [Bild]) = {
  if path == none {
    rect(
      width: w,
      height: h,
      fill: so-colors.placeholder,
      stroke: so-colors.placeholder-stroke,
      inset: 0pt,
    )[
      #align(center + horizon)[
        #text(size: 9pt, fill: so-colors.muted)[#placeholder-label]
      ]
    ]
  } else {
    block(width: w, height: h, clip: true)[
      #image(path, width: 100%, height: 100%, fit: fit)
    ]
  }
}

#let _standard-chrome(
  self,
  body,
  chapter: auto,
  bg: so-colors.bg,
  show-header: true,
  show-footer: true,
  slide-number: auto,
) = {
  // Chapter-Labels werden folienweise gesetzt; `auto` bedeutet kein Label.
  let ch = if chapter == auto { none } else { chapter }
  let sn = if slide-number == auto { _slide-no() } else { slide-number }
  block(width: 100%, height: 100%, fill: so-colors.white, clip: true)[
    // PPTX master: content background starts at y=0.75in.
    #_box(0, 0.75, 13.333, 6.75, [], fill: bg)

    #if show-header {
      if ch != none {
        _box(0.51, 0.42, 2.30, 0.24, [
          #_body(self, ch, size: 16pt, fill: so-colors.red)
        ])
      }
      _box(9.82, 0.39, 3.00, 0.27, [
        #align(right)[#_body(self, sn, size: 16pt, fill: so-colors.red)]
      ])
    }

    #body

    #if show-footer {
      _box(0.52, 7.14, 3.00, 0.15, [
        #_body(self, _date(self), size: 11pt)
      ])
      _box(10.22, 7.14, 2.69, 0.16, [
        #align(right)[#_body(self, self.info.title, size: 11pt)]
      ])
    }
  ]
}

// Touying default content slide. Deliberately simple; the named so-* helpers
// below correspond to the actual PowerPoint layouts.
#let slide(config: (:), repeat: auto, setting: body => body, title: auto, ..bodies) = touying-slide-wrapper(self => {
  let merged = bodies.pos().sum(default: none)
  let shown-title = if title == auto { utils.display-current-heading(level: 2) } else { title }
  let body = [
    #_box(0.53, 1.58, 12.28, 0.95, [#_title(self, shown-title, size: 26pt)])
    #_box(0.53, 2.96, 12.28, 3.95, [#merged])
  ]
  touying-slide(self: self, config: config, repeat: repeat, setting: setting, _standard-chrome(self, body))
})

// ---------------------------------------------------------------------------
// Spezialfolien: Titel / Intro / Zwischenfolie / Kapitel
// ---------------------------------------------------------------------------

#let so-title-slide(config: (:)) = touying-slide-wrapper(self => {
  let body = block(width: 100%, height: 100%, fill: so-colors.red)[
    #align(center + horizon)[#_logo(self, variant: "white", width: 50%)]
  ]
  touying-slide(self: self, config: config, body)
})

#let _intro-arc(color: so-colors.red, image-mode: true) = {
  if image-mode {
    place(bottom + left, dx: -1.55in, dy: 2.05in)[
      #ellipse(width: 9.7in, height: 5.5in, fill: color)
    ]
  } else {
    place(bottom + left, dx: -1.10in, dy: 2.15in)[
      #ellipse(width: 12.9in, height: 5.35in, fill: color)
    ]
  }
}

#let _intro-slide-arcs(color: so-colors.red) = {
  place(top + left, dx: -11.2in, dy: 3.68in)[
    #ellipse(width: 24.9in, height: 24.9in, fill: color)
  ]
  place(top + left, dx: 4.2in, dy: 6.58in)[
    #ellipse(width: 10.0in, height: 4.2in, fill: color)
  ]
}

#let so-intro-slide(
  config: (:),
  image-path: none,
  title: [Willkommen!],
  subtitle: [Ich bin ein Introslide],
  date: auto,
) = touying-slide-wrapper(self => {
  let d = if date == auto { _date(self) } else { date }
  let body = block(width: 100%, height: 100%, fill: so-colors.white, clip: true)[
    #if image-path != none {
      image(image-path, width: 100%, height: 100%, fit: "cover")
    }
    #_intro-slide-arcs()
    #_box(0.54, 4.05, 3.3, 0.30, [#_logo(self, variant: "white", width: 2.15in)])
    #_box(0.54, 5.04, 3.3, 0.30, [#_body(self, d, size: 14pt, fill: so-colors.white, weight: "bold")])
    #_box(0.54, 5.58, 6.0, 0.70, [#_title(self, title, size: 36pt, fill: so-colors.white, weight: "regular")])
    #_box(0.54, 6.20, 6.0, 0.70, [#_title(self, subtitle, size: 36pt, fill: so-colors.white, weight: "regular")])
    #_box(9.26, 7.14, 2.69, 0.20, [#_body(self, self.info.title, size: 11pt, fill: so-colors.white)])
  ]
  touying-slide(self: self, config: config, body)
})

#let so-interlude-slide(
  config: (:),
  image-path: none,
  title: [Ich bin eine Zwischenslide],
  text: [Hier kann noch etwas kommuniziert werden. Text ist optional],
  color: so-colors.red,
) = touying-slide-wrapper(self => {
  let has-image = image-path != none
  let body = block(width: 100%, height: 100%, fill: so-colors.white, clip: true)[
    #if has-image {
      image(image-path, width: 100%, height: 100%, fit: "cover")
    }
    #_intro-slide-arcs(color: color)
    #_box(0.54, 4.05, 3.3, 0.30, [#_logo(self, variant: "white", width: 2.15in)])
    #_box(0.54, 5.38, 5.8, 0.70, [#_title(self, title, size: 33pt, fill: so-colors.white, weight: "regular")])
    #_box(0.54, 5.98, 5.25, 1.30, [#_body(self, text, size: 22pt, fill: so-colors.white, weight: "regular")])
    #_box(9.26, 7.14, 2.69, 0.20, [#_body(self, self.info.title, size: 11pt, fill: so-colors.white)])
  ]
  touying-slide(self: self, config: config, body)
})

#let so-section-slide(
  config: (:),
  number: [01],
  title: [Willkommen!],
  subtitle: [Ich bin ein neues Kapitel],
  color: so-colors.red,
) = touying-slide-wrapper(self => {
  let number-line = if number != [] {
    (_title(self, number, size: 55pt, fill: so-colors.white, weight: "bold"),)
  } else {
    ()
  }
  let title-line = (_title(self, title, size: 36pt, fill: so-colors.white),)
  let subtitle-line = if subtitle != [] {
    (_title(self, subtitle, size: 36pt, fill: so-colors.white),)
  } else {
    ()
  }
  let section-lines = number-line + title-line + subtitle-line
  let body = block(width: 100%, height: 100%, fill: color)[
    #_box(5.70, 0.42, 1.95, 0.28, [#align(center)[#_logo(self, variant: "white", width: 2.15in)]])
    #_box(2.60, 2.28, 8.15, 2.10, [
      #align(center + horizon)[
        #set par(spacing: 0pt)
        #stack(dir: ttb, spacing: 14pt, ..section-lines)
      ]
    ])
  ]
  touying-slide(self: self, config: config, body)
})

#let new-section-slide(config: (:), level: 1, numbered: false, body) = touying-slide-wrapper(self => {
  let title = utils.display-current-heading(level: level, numbered: numbered)
  touying-slide(self: self, config: config, so-section-slide(number: [], title: title, subtitle: []))
})

// ---------------------------------------------------------------------------
// Layout 16: Agenda — fünf feste Spalten
// ---------------------------------------------------------------------------

#let _agenda-page(
  config: (:),
  title: [Agenda],
  items: (),
  offset: 0,
  chapter: auto,
) = touying-slide-wrapper(self => {
  let body = [
    #_box(0.53, 1.58, 12.28, 0.95, [#_title(self, title, size: 33pt)])
    #for i in range(5) {
      let item-index = offset + i
      if item-index < items.len() {
        let x = (0.52, 3.05, 5.57, 8.10, 10.63).at(i)
        let item-number = item-index + 1
        _box(x, 2.55, 2.29, 0.93, [#_title(self, if item-number < 10 { "0" + str(item-number) } else { str(item-number) }, size: 55pt)])
        _box(x, 3.49, 2.28, 3.48, [#_body(self, items.at(item-index), size: 14pt, fill: so-colors.red)])
      }
    }
  ]
  touying-slide(self: self, config: config, _standard-chrome(self, body, chapter: chapter))
})

#let so-agenda-slide(
  config: (:),
  title: [Agenda],
  items: ([Text hinzufügen], [Text hinzufügen], [Text hinzufügen], [Text hinzufügen], [Text hinzufügen]),
  chapter: auto,
) = {
  let offsets = if items.len() == 0 { (0,) } else { range(0, items.len(), step: 5) }
  let pages = ()
  for offset in offsets {
    pages.push(_agenda-page(
      config: config,
      title: title,
      items: items,
      offset: offset,
      chapter: chapter,
    ))
  }
  pages.sum(default: none)
}

// ---------------------------------------------------------------------------
// Layout 2: Titel + Text + grosses Bild
// ---------------------------------------------------------------------------

#let so-title-text-image-slide(
  config: (:),
  title: [Hallo ich bin ein Titel],
  text: [],
  image-path: none,
  chapter: auto,
) = touying-slide-wrapper(self => {
  let body = [
    #_box(0.53, 1.15, 3.93, 1.50, [#_title(self, title, size: 27pt)])
    #_box(0.53, 2.78, 3.93, 4.16, [#_body(self, text, size: 13pt)])
    #_box(4.72, 0.75, 8.61, 6.19, [#_image-slot(image-path, _u(8.61), _u(6.19))])
  ]
  touying-slide(self: self, config: config, _standard-chrome(self, body, chapter: chapter))
})

// Layout 3: Titel + Text + zwei Bildspalten (Screenshot Folie 9)
#let so-title-text-two-images-slide(
  config: (:),
  title: [Hallo ich bin ein Titel],
  text: [],
  image-left: none,
  image-right: none,
  chapter: auto,
) = touying-slide-wrapper(self => {
  let body = [
    #_box(0.53, 1.15, 3.93, 1.50, [#_title(self, title, size: 27pt)])
    #_box(0.53, 2.78, 3.93, 4.19, [#_body(self, text, size: 13pt)])
    #_box(4.72, 0.75, 3.93, 6.22, [#_image-slot(image-left, _u(3.93), _u(6.22))])
    #_box(8.87, 0.75, 3.94, 6.22, [#_image-slot(image-right, _u(3.94), _u(6.22))])
  ]
  touying-slide(self: self, config: config, _standard-chrome(self, body, chapter: chapter))
})

// Layout 4: drei gleich hohe Bilder
#let so-three-images-slide(
  config: (:),
  images: (none, none, none),
  chapter: auto,
) = touying-slide-wrapper(self => {
  let xs = (0.54, 4.72, 8.89)
  let body = [
    #for i in range(3) {
      _box(xs.at(i), 0.75, 3.92, 6.23, [#_image-slot(images.at(i), _u(3.92), _u(6.23))])
    }
  ]
  touying-slide(self: self, config: config, _standard-chrome(self, body, chapter: chapter))
})

// Layout 5: Titel + zwei Textfelder + rechtes Bild (Screenshot Folie 11)
#let so-two-texts-image-slide(
  config: (:),
  title: [Hallo ich bin ein Titel],
  left: [],
  right: [],
  image-path: none,
  chapter: auto,
) = touying-slide-wrapper(self => {
  let body = [
    #_box(0.53, 1.68, 8.12, 0.95, [#_title(self, title, size: 27pt)])
    #_box(0.53, 2.97, 3.93, 4.02, [#_body(self, left, size: 12.5pt)])
    #_box(4.72, 2.97, 3.93, 4.02, [#_body(self, right, size: 12.5pt)])
    #_box(8.90, 0.75, 3.90, 6.22, [#_image-slot(image-path, _u(3.90), _u(6.22))])
  ]
  touying-slide(self: self, config: config, _standard-chrome(self, body, chapter: chapter))
})

// Layout 6: Titel + drei Textspalten
#let so-three-text-slide(
  config: (:),
  title: [Titel],
  texts: ([], [], []),
  chapter: auto,
) = touying-slide-wrapper(self => {
  let xs = (0.53, 4.72, 8.89)
  let body = [
    #_box(0.53, 1.68, 8.34, 0.95, [#_title(self, title, size: 27pt)])
    #for i in range(3) {
      _box(xs.at(i), 2.97, 3.93, 4.02, [#_body(self, texts.at(i), size: 12pt)])
    }
  ]
  touying-slide(self: self, config: config, _standard-chrome(self, body, chapter: chapter))
})

// Layout 7: Titel + sechs schmale Textblöcke
#let so-six-text-blocks-slide(
  config: (:),
  title: [Titel],
  texts: ([], [], [], [], [], []),
  chapter: auto,
) = touying-slide-wrapper(self => {
  let xs = (0.53, 2.62, 4.69, 6.78, 8.88, 10.97)
  let body = [
    #_box(0.53, 1.68, 12.28, 0.95, [#_title(self, title, size: 27pt)])
    #for i in range(6) {
      _box(xs.at(i), 2.97, 1.84, 4.02, [#_body(self, texts.at(i), size: 10.5pt)])
    }
  ]
  touying-slide(self: self, config: config, _standard-chrome(self, body, chapter: chapter))
})

// Layout 8: Bild über gesamte Inhaltsfläche, Chrome bleibt sichtbar.
#let so-content-full-image-slide(config: (:), image-path: none, chapter: auto) = touying-slide-wrapper(self => {
  let body = [#_box(0.00, 0.76, 13.34, 6.24, [#_image-slot(image-path, _u(13.34), _u(6.24))])]
  touying-slide(self: self, config: config, _standard-chrome(self, body, chapter: chapter))
})

// Layout 20: wirklich ganzseitiges Bild ohne Chrome.
#let so-full-image-slide(config: (:), image-path: none) = touying-slide-wrapper(self => {
  let body = block(width: 100%, height: 100%, clip: true)[#_image-slot(image-path, 100%, 100%)]
  touying-slide(self: self, config: config, body)
})

// Layout 10: leere Folie mit Standard-Chrome.
#let so-empty-slide(config: (:), body: [], chapter: auto) = touying-slide-wrapper(self => {
  touying-slide(self: self, config: config, _standard-chrome(self, body, chapter: chapter))
})

// ---------------------------------------------------------------------------
// Layout 15: fünf Bilder mit Legende — alternierend gestaffelt
// ---------------------------------------------------------------------------

#let so-five-images-caption-slide(
  config: (:),
  title: [Introslide mit Bilder],
  images: (none, none, none, none, none),
  headings: ([XX], [XX], [XX], [XX], [XX]),
  captions: ([Text hinzufügen], [Text hinzufügen], [Text hinzufügen], [Text hinzufügen], [Text hinzufügen]),
  chapter: auto,
) = touying-slide-wrapper(self => {
  let ix = (0.53, 3.01, 5.52, 8.01, 10.53)
  let image-y = (2.55, 3.58, 2.54, 3.56, 2.54)
  let head-y = (5.88, 2.54, 5.89, 2.54, 5.89)
  let cap-y = (6.24, 2.89, 6.24, 2.89, 6.24)
  let body = [
    #_box(0.53, 1.58, 12.28, 0.95, [#_title(self, title, size: 28pt)])
    #for i in range(5) {
      _box(ix.at(i), image-y.at(i), 2.28, 3.08, [#_image-slot(images.at(i), _u(2.28), _u(3.08))])
      _box(ix.at(i), head-y.at(i), 2.28, 0.30, [#_body(self, headings.at(i), size: 14pt, fill: so-colors.red, weight: "bold")])
      _box(ix.at(i), cap-y.at(i), 2.28, 0.74, [#_body(self, captions.at(i), size: 10.5pt, fill: so-colors.red)])
    }
  ]
  touying-slide(self: self, config: config, _standard-chrome(self, body, chapter: chapter))
})

// Layout 17: fünf gleichbreite Textblöcke
#let so-five-text-blocks-slide(
  config: (:),
  title: [Titel],
  texts: ([], [], [], [], []),
  chapter: auto,
) = touying-slide-wrapper(self => {
  let xs = (0.54, 3.02, 5.53, 8.05, 10.55)
  let body = [
    #_box(0.53, 1.58, 12.28, 0.95, [#_title(self, title, size: 28pt)])
    #for i in range(5) {
      _box(xs.at(i), 2.96, 2.26, 3.60, [#_body(self, texts.at(i), size: 11pt)])
    }
  ]
  touying-slide(self: self, config: config, _standard-chrome(self, body, chapter: chapter))
})

// Layout 18: fünf Porträts mit Name/Funktion
#let so-five-portraits-slide(
  config: (:),
  title: [Team],
  images: (none, none, none, none, none),
  names: ([Vorname Name], [Vorname Name], [Vorname Name], [Vorname Name], [Vorname Name]),
  roles: ([], [], [], [], []),
  chapter: auto,
) = touying-slide-wrapper(self => {
  let xs = (0.53, 3.02, 5.53, 8.01, 10.54)
  let body = [
    #_box(0.53, 1.58, 12.28, 0.95, [#_title(self, title, size: 28pt)])
    #for i in range(5) {
      _box(xs.at(i), 2.55, 2.28, 3.08, [#_image-slot(images.at(i), _u(2.28), _u(3.08))])
      _box(xs.at(i), 5.87, 2.28, 0.24, [#_body(self, names.at(i), size: 11pt, fill: so-colors.red, weight: "bold")])
      _box(xs.at(i), 6.12, 2.28, 0.79, [#_body(self, roles.at(i), size: 10pt, fill: so-colors.red)])
    }
  ]
  touying-slide(self: self, config: config, _standard-chrome(self, body, chapter: chapter))
})

// ---------------------------------------------------------------------------
// Zusammenfassung / Quote / Abschluss
// ---------------------------------------------------------------------------

#let so-summary-slide(
  config: (:),
  title: [Zusammenfassung],
  items: ([Zusammenfassung], [Zusammenfassung], [Zusammenfassung]),
) = touying-slide-wrapper(self => {
  let body = block(width: 100%, height: 100%, fill: so-colors.red)[
    #_box(0.53, 0.78, 4.1, 0.45, [#_logo(self, variant: "white", width: 2.70in)])
    #_box(8.05, 1.04, 4.77, 1.50, [#_title(self, title, size: 27pt, fill: so-colors.white)])
    #_box(8.05, 2.74, 4.76, 4.24, [
      #set list(marker: "•", spacing: 0.30em)
      #set text(font: self.store.body-font, size: 12pt, fill: so-colors.white)
      #list(..items)
    ])
  ]
  touying-slide(self: self, config: config, body)
})

#let so-summary-two-column-slide(
  config: (:),
  left-title: [Titel],
  left-items: (),
  right-title: [Titel],
  right-items: (),
) = touying-slide-wrapper(self => {
  let body = block(width: 100%, height: 100%, fill: so-colors.red)[
    #_box(0.53, 0.78, 4.1, 0.45, [#_logo(self, variant: "white", width: 2.70in)])
    #_box(5.53, 1.04, 3.10, 1.50, [#_title(self, left-title, size: 23pt, fill: so-colors.white)])
    #_box(8.87, 1.04, 3.10, 1.50, [#_title(self, right-title, size: 23pt, fill: so-colors.white)])
    #_box(5.53, 2.75, 3.10, 4.23, [
      #set text(fill: so-colors.white)
      #list(..left-items)
    ])
    #_box(8.88, 2.75, 3.10, 4.23, [
      #set text(fill: so-colors.white)
      #list(..right-items)
    ])
  ]
  touying-slide(self: self, config: config, body)
})

#let _quote-art(color) = {
  // Approximation der zwei Kreisbögen aus den PPTX-Quote-Layouts.
  place(top + right, dx: 2.65in, dy: -1.85in)[#ellipse(width: 7.45in, height: 9.8in, fill: color)]
  place(bottom + left, dx: -1.25in, dy: 2.45in)[#ellipse(width: 10.2in, height: 6.2in, fill: color)]
}

#let so-quote-slide(
  config: (:),
  quote: [«Hey ich bin ein Quote #linebreak() Den du dir merken solltest»],
  color: so-colors.red,
) = touying-slide-wrapper(self => {
  let body = block(width: 100%, height: 100%, fill: so-colors.bg, clip: true)[
    #_quote-art(color)
    #_box(0.53, 7.14, 2.69, 0.16, [#_body(self, self.info.title, size: 6pt, fill: so-colors.white)])
    #_box(5.15, 1.70, 4.30, 1.65, [#align(center)[#_title(self, quote, size: 23pt, fill: color, weight: "bold")]])
  ]
  touying-slide(self: self, config: config, body)
})

// Layout 19: Abschluss / Dank — QR oben links, Titel/Text links,
// austauschbares Bild rechts und Name/Funktion darunter.
//
// `qr` ist der bevorzugte Weg: URL oder beliebigen Text übergeben und der
// QR-Code wird beim Typst-Rendern erzeugt. Mit `qr: none` bleibt der Slot leer.
// `qr-image` bleibt für bestehende Präsentationen bzw. vorbereitete QR-Grafiken
// rückwärtskompatibel erhalten und wird nur verwendet, wenn `qr == none`.
#let _thanks-qr(qr: none, qr-image: none, size: 1.38in) = {
  if qr != none {
    qr-code(
      str(qr),
      width: size,
      height: size,
      color: so-colors.text,
      background: so-colors.white,
      error-correction: "M",
    )
  } else if qr-image != none {
    _image-slot(qr-image, size, size, fit: "contain", placeholder-label: [QR])
  }
}

#let so-thanks-slide(
  config: (:),
  title: [Danke für Ihre Aufmerksamkeit],
  text: [Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor],
  qr: none,
  qr-image: none,
  qr-size: 1.38in,
  image-path: none,
  name: [Vorname Name],
  details: [Text hinzufügen],
) = touying-slide-wrapper(self => {
  let body = [
    #if qr != none or qr-image != none {
      _box(0.53, 1.04, 1.38, 1.38, [#_thanks-qr(qr: qr, qr-image: qr-image, size: qr-size)])
    }
    #_box(0.53, 3.54, 6.02, 1.45, [#_title(self, title, size: 29pt)])
    #_box(0.53, 5.26, 6.03, 1.72, [#_body(self, text, size: 12pt, fill: so-colors.red)])
    #_box(8.88, 1.05, 3.93, 4.33, [#_image-slot(image-path, _u(3.93), _u(4.33))])
    #_box(8.88, 5.69, 3.93, 0.24, [#_body(self, name, size: 12pt, fill: so-colors.red, weight: "bold")])
    #_box(8.89, 5.94, 3.93, 0.79, [#_body(self, details, size: 10.5pt, fill: so-colors.red)])
  ]
  touying-slide(self: self, config: config, _standard-chrome(self, body, chapter: none))
})

// Backwards-compatible aliases from prototype 0.1.
#let so-content-slide = so-title-text-image-slide
#let so-two-column-slide(config: (:), title: [Titel], left: [], right: [], chapter: auto) = so-three-text-slide(config: config, title: title, texts: (left, right, []), chapter: chapter)
#let so-text-band-slide(config: (:), title: [Titel], items: (), chapter: auto) = so-five-text-blocks-slide(config: config, title: title, texts: items + range(calc.max(0, 5 - items.len())).map(_ => []), chapter: chapter)
#let so-image-grid-slide(config: (:), title: [Bilder], images: (), columns: 3, chapter: auto) = so-five-images-caption-slide(config: config, title: title, images: images + range(calc.max(0, 5 - images.len())).map(_ => none), chapter: chapter)

#let solothurn-pro-theme(
  title-font: "Frutiger LT Com 55 Roman",
  body-font: "Frutiger LT Com 55 Roman",
  title-leading: 0.42em,
  body-leading: 0.5325em,
  logo-red: "assets/logos/kantons-logo.svg",
  logo-white: "assets/logos/kantons-logo-weiss.svg",
  ..args,
  body,
) = {
  show: touying-slides.with(
    config-page(
      width: so-slide-width,
      height: so-slide-height,
      margin: 0pt,
      fill: so-colors.white,
    ),
    config-common(
      slide-fn: slide,
      new-section-slide-fn: new-section-slide,
      zero-margin-header: true,
      zero-margin-footer: true,
    ),
    config-methods(
      init: (self: none, body) => {
        set text(font: self.store.body-font, size: 12pt, fill: so-colors.text)
        set par(leading: self.store.body-leading)
        set list(marker: "•", spacing: 0.28em, indent: 1.05em, body-indent: 0.42em)
        show strong: set text(weight: "bold")
        body
      },
      alert: utils.alert-with-primary-color,
    ),
    config-colors(primary: so-colors.red, secondary: so-colors.blue),
    config-store(
      title-font: title-font,
      body-font: body-font,
      title-leading: title-leading,
      body-leading: body-leading,
      logo-red: logo-red,
      logo-white: logo-white,
    ),
    ..args,
  )
  body
}
