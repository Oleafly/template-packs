// Titelblatt nach Tabelle 5 und Abbildung 4 der Richtlinie.
//
// Die Richtlinie schreibt vor: "Die Formatierung des Titelblattes muss der Vorlage entsprechen."
// Dazu gehören die Beschriftungen "Vorgelegt am" und "Vorgelegt von".

#import "config.typ" as cfg

#let zeile-paar(bezeichnung, wert) = (
  text(size: cfg.groesse.titelblatt, bezeichnung),
  text(size: cfg.groesse.titelblatt, wert),
)

#let titelblatt(
  art: none,
  studiengang: none,
  titel: none,
  untertitel: none,
  referent: none,
  korreferent: none,
  ersetztes-modul: none,
  vorgelegt-am: none,
  autor: (:),
) = {
  let datum = if type(vorgelegt-am) == datetime {
    vorgelegt-am.display("[day].[month].[year]")
  } else {
    vorgelegt-am
  }

  // Die erste Zeile der Personendaten steht neben "Vorgelegt von".
  // Die weiteren Zeilen stehen gemäß Abbildung 4 darunter in derselben Spalte.
  let person = (
    autor.at("name", default: none),
    autor.at("matrikelnummer", default: none),
    autor.at("strasse", default: none),
    autor.at("ort", default: none),
    autor.at("email", default: none),
  ).filter(z => z != none and z != "")

  let angaben = ()
  angaben += zeile-paar("Referent:", referent)
  if korreferent != none { angaben += zeile-paar("Korreferent:", korreferent) }
  if ersetztes-modul != none { angaben += zeile-paar("Ersetztes Modul:", ersetztes-modul) }
  angaben += zeile-paar("Vorgelegt am:", datum)
  angaben += zeile-paar("Vorgelegt von:", person.first())
  for weitere in person.slice(1) {
    angaben += zeile-paar([], weitere)
  }

  page(header: none, footer: none, numbering: none, {
    if cfg.logo != none {
      align(right, image(
        cfg.logo,
        height: cfg.logo-hoehe,
        alt: "Logo der Hochschule Furtwangen",
      ))
    }

    v(2cm)

    align(center, {
      // Tabelle 2: Art der Arbeit 18 pt
      set par(justify: false, leading: 0.6em)
      text(size: cfg.groesse.art, art)
      linebreak()
      text(size: cfg.groesse.art, "in")
      linebreak()
      text(size: cfg.groesse.art, studiengang)

      v(1.5cm)

      // Tabelle 2: Titel 22 pt fett, Untertitel 18 pt
      text(size: cfg.groesse.titel, weight: "bold", titel)
      if untertitel != none and untertitel != "" {
        linebreak()
        v(0.3cm)
        text(size: cfg.groesse.untertitel, untertitel)
      }
    })

    v(1fr)

    // Tabelle 2: Referent:in, Korreferent:in, Vorgelegt am / von je 12 pt
    align(center, block(
      grid(
        columns: 2,
        column-gutter: 1em,
        row-gutter: 0.9em,
        align: left,
        ..angaben,
      ),
    ))

    v(2cm)
  })
}
