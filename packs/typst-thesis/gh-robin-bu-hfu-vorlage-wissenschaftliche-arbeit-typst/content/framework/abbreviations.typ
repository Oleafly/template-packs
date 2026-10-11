#import "../../template.typ": unnumbered-chapter

// ##################################################
// Abkuerzungsverzeichnis und Abkuerzungsbefehle
//
// Damit der Build ohne Paket-Download reproduzierbar bleibt (wie die
// mitgelieferten Schriften), ist die Abkuerzungslogik hier selbst umgesetzt.
// Nur tatsaechlich im Text verwendete Abkuerzungen erscheinen im
// Abkuerzungsverzeichnis.
//
// Verwendung im Text (siehe content/chapters/chapter_1.typ):
//   #ac("KI")   -> ERSTE Nutzung "Künstliche Intelligenz (KI)", danach nur "KI"
//   #acf("KI")  -> immer Vollform "Künstliche Intelligenz (KI)"
//   #acl("KI")  -> immer Langform "Künstliche Intelligenz"
//   #acs("KI")  -> immer Kurzform "KI"
// ##################################################

// Abkuerzungsdefinitionen: Kuerzel -> (Kurzform, Langform).
// Reihenfolge = Reihenfolge im Verzeichnis.
#let acronyms = (
  "KI": ("KI", "Künstliche Intelligenz"),
  "ML": ("ML", "Machine Learning"),
  "API": ("API", "Application Programming Interface"),
  "HFU": ("HFU", "Hochschule Furtwangen"),
  "IEEE": ("IEEE", "Institute of Electrical and Electronics Engineers"),
)

// Zustand: bereits im Text eingefuehrte Abkuerzungen (in Dokumentreihenfolge)
#let _ac-used = state("ac-used", ())

#let _ac-get(key) = {
  assert(key in acronyms, message: "Unbekannte Abkürzung: \"" + key + "\" -- bitte in abbreviations.typ ergänzen.")
  acronyms.at(key)
}

// Kuerzel als verwendet markieren (idempotent) -> steuert die Anzeige im
// Abkuerzungsverzeichnis (nur verwendete)
#let _ac-mark(key) = _ac-used.update(u => if key in u { u } else { u + (key,) })

// Label des zugehoerigen Eintrags im Abkuerzungsverzeichnis
#let _ac-label(key) = label("acr-" + key)
// Abkuerzungstext klickbar auf den Verzeichniseintrag verlinken
#let _ac-link(key, body) = link(_ac-label(key), body)

// immer Kurzform
#let acs(key) = {
  let (short, _) = _ac-get(key)
  _ac-mark(key)
  _ac-link(key, short)
}

// immer Langform
#let acl(key) = {
  let (_, long) = _ac-get(key)
  _ac-mark(key)
  _ac-link(key, long)
}

// immer Vollform "Langform (Kurzform)"
#let acf(key) = {
  let (short, long) = _ac-get(key)
  _ac-mark(key)
  _ac-link(key, [#long (#short)])
}

// Erstnutzung: Vollform, danach Kurzform
#let ac(key) = context {
  let (short, long) = _ac-get(key)
  let first = key not in _ac-used.get()
  _ac-mark(key)
  _ac-link(key, if first [#long (#short)] else [#short])
}

// Abkuerzungsverzeichnis -- zweispaltig (Kurzform | Erklaerung), Kapitel 2.8.
// Listet nur verwendete Abkuerzungen in der oben definierten Reihenfolge.
#let abbreviations = {
  unnumbered-chapter("Abkürzungsverzeichnis")

  context {
    let used = _ac-used.final()
    let rows = ()
    for (key, (short, long)) in acronyms {
      // Label an der Kurzform -> Sprungziel der Verweise aus dem Text
      if key in used { rows.push(([#short#_ac-label(key)], [#long])) }
    }

    if rows.len() == 0 {
      [Es werden keine Abkürzungen verwendet.]
    } else {
      grid(
        columns: (auto, 1fr),
        column-gutter: 1em,
        row-gutter: 0.8em,
        ..rows.flatten(),
      )
    }
  }
}
