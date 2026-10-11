// Seitenaufbau, Kopfzeile, Nummerierungsphasen und Überschriften.
//
// Der Kern ist `hfu-thesis`, eine Show-Rule-Funktion mit der in Tabelle 3 festgelegten Reihenfolge der Bestandteile.
// Der Dokumentkörper enthält deshalb nur den inhaltlichen Teil der Arbeit.
// Alles andere wird als benanntes Argument übergeben.

#import "config.typ" as cfg
#import "abkuerzungen.typ": registriere-abkuerzungen
#import "kapitel.typ": auf-rechte-seite, kopfzeile, kopfzeile-marke
#import "kapitel.typ": seitenzahl-neustart, trennblatt
#import "kapitel.typ": unnummeriertes-kapitel, vorspann-kapitel
#import "sperrvermerk.typ" as sperr
#import "titelblatt.typ": titelblatt
#import "verzeichnisse.typ": abbildungsverzeichnis, abkuerzungsverzeichnis
#import "verzeichnisse.typ": inhaltsverzeichnis, tabellenverzeichnis
#import "versicherung.typ": versicherung

#let fehlt(feld, wert, fundstelle) = {
  if wert == none or wert == "" {
    panic(
      "hfu-vorlage: `" + feld + "` muss in thesis.typ gesetzt sein (Richtlinie " + fundstelle + ").",
    )
  }
}

// Erzeugt ein Verzeichnis nur, wenn im fertig gesetzten Dokument mindestens ein passendes Element vorkommt.
// Entscheidend ist das Vorhandensein und nicht eine zusätzliche Referenz mit `@label`.
#let verzeichnis-wenn-vorhanden(titel, ziel, erstellen) = context {
  if query(ziel).len() > 0 {
    vorspann-kapitel(titel, erstellen())
  }
}

// ── Hauptfunktion ───────────────────────────────────────────────────────────

#let hfu-thesis(
  // Titelblatt — Tabelle 5 und Abbildung 4
  art: none,
  studiengang: none,
  titel: none,
  untertitel: none,
  referent: none,
  korreferent: none,
  ersetztes-modul: none,
  vorgelegt-am: none,
  autor: (:),
  // Typografie — §1.3 schreibt keine konkrete Schriftfamilie vor
  schrift: cfg.schrift,
  schrift-mono: cfg.schrift-mono,
  blocksatz: cfg.blocksatz,
  // Bestandteile — Tabelle 3
  vorwort: none,
  sperrvermerk: none,
  abstract-en: none,
  abstract-de: none,
  abkuerzungen: (),
  quellen: none,
  anhang: (),
  body,
) = {
  fehlt("art", art, "Tabelle 5")
  fehlt("studiengang", studiengang, "Tabelle 5")
  fehlt("titel", titel, "Tabelle 5")
  fehlt("referent", referent, "Tabelle 5")
  if type(art) == str and lower(art).contains("bachelor") {
    fehlt("korreferent", korreferent, "Tabelle 5")
  }
  fehlt("autor.name", autor.at("name", default: none), "Tabelle 5")
  fehlt(
    "autor.matrikelnummer",
    autor.at("matrikelnummer", default: none),
    "Tabelle 5",
  )
  fehlt("autor.strasse", autor.at("strasse", default: none), "Tabelle 5")
  fehlt("autor.ort", autor.at("ort", default: none), "Tabelle 5")
  fehlt("autor.email", autor.at("email", default: none), "Tabelle 5")
  assert(
    type(vorgelegt-am) == datetime,
    message: "hfu-vorlage: `vorgelegt-am` muss als `datetime` gesetzt sein (Richtlinie Tabelle 5).",
  )
  if type(art) == str {
    let art-klein = lower(art)
    assert(
      not (
        art-klein.contains("master")
          and (art-klein.contains("seminar") or art-klein.contains("bericht"))
      ),
      message: "hfu-vorlage: Master-Seminararbeiten und -Berichte müssen im IEEE-Conference-Layout erstellt werden.",
    )
  }
  if abstract-de == none or abstract-en == none {
    panic("hfu-vorlage: Der Abstract ist in deutscher und englischer Sprache verpflichtend (Richtlinie §2.4).")
  }
  if quellen == none {
    panic("hfu-vorlage: Das Literaturverzeichnis ist verpflichtend (Richtlinie Tabelle 3 und §2.9.5).")
  }
  registriere-abkuerzungen(abkuerzungen)

  if sperrvermerk != none {
    if type(sperrvermerk) != dictionary {
      panic("hfu-vorlage: `sperrvermerk` muss ein Dictionary mit `firma` und `variante` sein.")
    }
    fehlt("sperrvermerk.firma", sperrvermerk.at("firma", default: none), "Sperrvermerk")
    let variante = sperrvermerk.at("variante", default: "bericht")
    if type(variante) != str or not variante in ("bericht", "bachelorarbeit") {
      panic("hfu-vorlage: `sperrvermerk.variante` muss `bericht` oder `bachelorarbeit` sein.")
    }
  }

  set document(title: titel, author: autor.at("name"), date: vorgelegt-am)

  // ── Seite ─────────────────────────────────────────────────────────────────
  // §1.1 legt DIN A4 fest und §1.2.1 grundsätzlich Hochformat.
  // §1.2.2 verlangt beidseitigen Druck im Buchformat.
  // Tabelle 1 definiert die Ränder; der Bundsteg liegt am inneren Rand.
  set page(
    paper: "a4",
    binding: left,
    margin: (
      top: cfg.rand-oben,
      bottom: cfg.rand-unten,
      inside: cfg.rand-innen + cfg.bundsteg,
      outside: cfg.rand-aussen,
    ),
    header: kopfzeile(),
    header-ascent: 40%,
    // Die Seitenzahl steht laut §1.2.5 in der Kopfzeile, nicht in der Fußzeile.
    footer: none,
    numbering: none,
  )

  // ── Text ──────────────────────────────────────────────────────────────────
  // `top-edge` und `bottom-edge` fixieren die Zeilenbox auf exakt 1 em.
  // Erst dadurch ergibt `leading` schriftunabhängig den in `config.typ` geforderten Grundlinienabstand.
  set text(
    font: schrift,
    size: cfg.groesse.text,
    lang: "de",
    top-edge: 0.75em,
    bottom-edge: -0.25em,
  )
  set par(
    justify: blocksatz, // §1.3.2
    leading: cfg.zeile - 1em, // §1.3.2
    spacing: cfg.absatzabstand, // §1.2.6
    first-line-indent: 0pt,
  )
  // ── Überschriften ─────────────────────────────────────────────────────────
  // Ebene 1 erhält einen Punkt wie in "1. Einleitung".
  // Die Ebenen 2 und 3 folgen den Richtlinienbeispielen ohne abschließenden Punkt.
  set heading(numbering: (..n) => {
    let z = n.pos()
    if z.len() == 1 { numbering("1.", ..z) } else { numbering("1.1", ..z) }
  })
  // Tabelle 2
  show heading.where(level: 1): set text(size: cfg.groesse.h1, weight: "bold")
  show heading.where(level: 2): set text(size: cfg.groesse.h2, weight: "bold")
  show heading.where(level: 3): set text(size: cfg.groesse.h3, weight: "regular")
  show heading: set block(above: 1.2 * cfg.zeile, below: 0.7 * cfg.zeile)

  // ── Abbildungen, Tabellen, Quellcode ──────────────────────────────────────
  // §2.6/§2.7: Beschriftung unterhalb, Muster "Abbildung [Nummer]: [Titel]".
  // Beides ist Typst-Standard; die Wörter "Abbildung"/"Tabelle" liefert lang.
  show figure: set align(cfg.figur-ausrichtung)
  show figure.caption: set align(cfg.figur-ausrichtung)
  show figure.caption: set text(size: cfg.groesse.beschriftung)
  set figure(gap: 0.6 * cfg.zeile)
  // Tabellen 7/8: fortlaufende Nummerierung, nicht kapitelweise (Typst-Standard)

  show footnote.entry: set text(size: cfg.groesse.fussnote) // Tabelle 2
  show quote.where(block: true): set block(
    inset: (left: 1cm, right: 0.5cm),
    above: cfg.absatzabstand,
    below: cfg.absatzabstand,
  )
  // Nur Quellcode darf nach §1.3 eine zweite Monospace-Schrift verwenden.
  show raw: set text(font: schrift-mono, size: cfg.groesse.quellcode)

  // ── 1. Titelblatt (ohne Seitenzahl, ohne Kopfzeile) ───────────────────────
  titelblatt(
    art: art,
    studiengang: studiengang,
    titel: titel,
    untertitel: untertitel,
    referent: referent,
    korreferent: korreferent,
    ersetztes-modul: ersetztes-modul,
    vorgelegt-am: vorgelegt-am,
    autor: autor,
  )

  // Der optionale Sperrvermerk steht unmittelbar nach dem Titelblatt.
  // Er besitzt keine Kopfzeile, Seitenzahl oder Eintragung im Inhaltsverzeichnis.
  // Das anschließende leere Trennblatt vor Vorwort beziehungsweise Abstract bleibt gemäß §2.2 erhalten.
  if sperrvermerk != none {
    sperr.sperrvermerk(
      titel,
      sperrvermerk.at("firma"),
      variante: sperrvermerk.at("variante", default: "bericht"),
    )
  }

  // ── 2. Leeres Trennblatt (§2.2) ───────────────────────────────────────────
  trennblatt()

  // ── 3.–9. Vorspann: römische Ziffern ab I (Tabelle 4) ─────────────────────
  set page(numbering: "I")
  counter(page).update(1)
  seitenzahl-neustart()

  if vorwort != none {
    vorspann-kapitel("Vorwort", vorwort)
  }

  // §2.4, Abbildung 5: englische Fassung zuerst, danach die deutsche.
  vorspann-kapitel("Abstract", {
    set text(lang: "en")
    abstract-en
    v(cfg.zeile)
    set text(lang: "de")
    abstract-de
  })

  vorspann-kapitel(
    "Inhaltsverzeichnis",
    inhaltsverzeichnis(),
    im-inhaltsverzeichnis: cfg.inhaltsverzeichnis-listet-sich-selbst,
  )

  // Tabelle 3: verpflichtend, sofern Abbildungen bzw. Tabellen vorhanden sind.
  verzeichnis-wenn-vorhanden(
    "Abbildungsverzeichnis",
    figure.where(kind: image),
    abbildungsverzeichnis,
  )
  verzeichnis-wenn-vorhanden(
    "Tabellenverzeichnis",
    figure.where(kind: table),
    tabellenverzeichnis,
  )
  vorspann-kapitel("Abkürzungsverzeichnis", abkuerzungsverzeichnis(abkuerzungen))

  // ── 10. Inhaltlicher Teil: arabische Ziffern ab 1 (Tabelle 4) ─────────────
  // Zuerst wird auf eine rechte Seite gewechselt und erst dort die Nummerierung zurückgesetzt.
  // Andernfalls könnte eine notwendige Füllseite bereits die arabische Seitenzahl 1 tragen.
  auf-rechte-seite()
  set page(numbering: "1")
  counter(page).update(1)
  seitenzahl-neustart()

  {
    // §1.2.3: Hauptkapitel beginnen immer auf der rechten Seite.
    // Diese Regel gilt nur hier; der Vorspann kennt sie nicht.
    show heading.where(level: 1): it => {
      auf-rechte-seite()
      it
      context {
        let nummer = if it.numbering != none {
          numbering("1", counter(heading).get().first())
        }
        kopfzeile-marke(if nummer != none { [#nummer #it.body] } else { it.body })
      }
    }

    body

    // ── 11. Literaturverzeichnis (§2.9.5) ───────────────────────────────────
    unnummeriertes-kapitel("Literaturverzeichnis", {
      // §2.9.5 verlangt zwischen den Quellenangaben 1,5-zeiligen Abstand und innerhalb einer Quelle einzeiligen Abstand.
      set par(leading: cfg.zeile-einfach - 1em, spacing: cfg.zeile - 1em)
      quellen
    })
  }

  // ── 12. Leeres Trennblatt und Versicherung (§2.11) ────────────────────────
  trennblatt()
  versicherung(autor.at("name"))

  // ── 13. Anhang (§2.13) ────────────────────────────────────────────────────
  if anhang != none and anhang.len() > 0 {
    trennblatt()
    // Überschriften im Anhang tragen keine Kapitelnummern.
    // Die Gliederung erfolgt über die Anhangsbuchstaben.
    set heading(numbering: none)
    for (i, teil) in anhang.enumerate() {
      let buchstabe = numbering("A", i + 1)
      // Zuerst wird auf die rechte Seite gewechselt und danach umnummeriert.
      // Andernfalls trüge bereits die vorherige Füllseite die Seitenzahlen des Anhangsteils.
      auf-rechte-seite()
      // Tabelle 4: Seitenzahl nach dem Muster "[Buchstabe]-[Zahl]".
      set page(numbering: (..n) => buchstabe + "-" + str(n.pos().first()))
      counter(page).update(1)
      seitenzahl-neustart()
      heading(level: 1, numbering: none, outlined: true)[
        Anhang #buchstabe: #teil.at(0)
      ]
      // §2.13: Die Kopfzeile folgt dem Muster "Anhang [Buchstabe]".
      kopfzeile-marke("Anhang " + buchstabe)
      teil.at(1)
    }
  }
}
