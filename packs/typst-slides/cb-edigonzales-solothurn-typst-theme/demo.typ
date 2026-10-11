#import "@preview/touying:0.7.4": *
#import "solothurn-pro.typ": *

#show: solothurn-pro-theme.with(
  title-font: "Frutiger LT Com 55 Roman",
  body-font: "Frutiger LT Com 55 Roman",
  config-info(
    title: [Name der Präsentation],
    author: [Stefan Ziegler],
    institution: [Amt für Geoinformation],
    date: "31. August 2026",
  ),
)

#let ph = "assets/img/placeholder-phone-grass.png"

// 1 — Titelfolie
#so-title-slide()

// 2 — Intro mit austauschbarem Vollbild
#so-intro-slide(
  image-path: ph,
  title: [Willkommen!],
  subtitle: [Ich bin ein Introslide],
  date: [6. September 2024],
)

// 3/4 — Zwischenfolie mit bzw. ohne Bild
#so-interlude-slide(image-path: ph, title: [Ich bin ein Zwischenslide])
#so-interlude-slide(image-path: none, title: [Ich bin eine Zwischenslide])

// 5 — Agenda aus dem Screenshot: fünf feste Slots
#so-agenda-slide(
  title: [Agenda],
  items: (
    [Text hinzufügen],
    [Text hinzufügen],
    [Text hinzufügen],
    [Text hinzufügen],
    [Text hinzufügen],
  ),
)

// 6/7 — Kapiteltrenner
#so-section-slide(number: [01], title: [Willkommen!], subtitle: [Ich bin ein neues Kapitel], color: so-colors.red)
#so-section-slide(number: [01], title: [Willkommen!], subtitle: [Ich bin ein neues Kapitel], color: so-colors.blue)

// 8 — Titel/Text/Bild
#so-title-text-image-slide(
  title: [Hallo ich bin ein #linebreak() Titel],
  text: [Lauftext Einfacher und Zielgruppen spezifischer Zugang zu Informationen und einfachen digitalen Behördenservices],
  image-path: ph,
)

// 9 — Titel/Text/2 Bilder: entspricht Screenshot 105707
#so-title-text-two-images-slide(
  title: [Hallo ich bin ein #linebreak() Titel],
  text: [Lauftext Einfacher und Zielgruppen spezifischer Zugang zu Informationen und einfachen digitalen Behördenservices],
  image-left: none,
  image-right: none,
)

// 10 — 3 Bilder
#so-three-images-slide(images: (ph, ph, ph))

// 11 — 2 Texte + Bild: entspricht Screenshot 105729
#so-two-texts-image-slide(
  title: [Hallo ich bin ein #linebreak() Titel],
  left: [Text hinzufügen],
  right: [Text hinzufügen],
  image-path: ph,
)

// 12 — 3 Textspalten
#so-three-text-slide(
  title: [Hallo ich bin ein #linebreak() Titel],
  texts: ([Text hinzufügen], [Text hinzufügen], [Text hinzufügen]),
)

// 13 — 6 Textblöcke
#so-six-text-blocks-slide(
  title: [Hallo ich bin ein langer Titel],
  texts: ([Text], [Text], [Text], [Text], [Text], [Text]),
)

// 14 — Bild über Inhaltsfläche
#so-content-full-image-slide(image-path: ph)

// 15 — fünf Bilder/Legenden gestaffelt: entspricht Screenshot 105802
#so-five-images-caption-slide(
  title: [Introslide mit Bilder],
  images: (ph, ph, ph, ph, ph),
)

// 16 — Zusammenfassung
#so-summary-slide()

// 17 — leere Standardfolie
#so-empty-slide()

// 18/19 — Quote rot/blau
#so-quote-slide(color: so-colors.red)
#so-quote-slide(color: so-colors.blue)

// 20 — Abschluss: entspricht Screenshot 105834
#so-thanks-slide(
  qr: "https://so.ch",
  image-path: ph,
  title: [Danke für Ihre #linebreak() Aufmerksamkeit],
  text: [Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor],
  name: [Vorname Name],
  details: [Text hinzufügen],
)

// QR optional: mit `qr: none` bleibt links oben bewusst leer.
// Vorbereitete QR-Grafiken funktionieren weiterhin über `qr-image:`.

// Zusätzliche in der PPTX vorhandene Layouts
#so-five-text-blocks-slide(title: [Titel], texts: ([Text], [Text], [Text], [Text], [Text]))
#so-five-portraits-slide(title: [Team], images: (ph, ph, ph, ph, ph))
