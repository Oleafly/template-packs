// =============================================================================
// FOM-Template: Zitieren (Leitfaden Kapitel 3 "Zitieren")
// =============================================================================
// Der Leitfaden erlaubt zwei Zitierweisen (Leitfaden 3.2), die vorab gewählt
// und konsequent beibehalten werden müssen. Zusätzlich – nicht Teil des
// Leitfadens, aber als dritte Option ergänzt – steht "apa" (APA 7th Edition)
// zur Verfügung:
//
//   "chicago" (Standard): Kurzbeleg in der Fußnote
//       indirekt:  Vgl. Mayer, D., Finanzinvestitionen, 2019, S. 438.
//       direkt:    Mayer, D., Finanzinvestitionen, 2019, S. 438.
//
//   "harvard": Kurzbeleg in Klammern im Fließtext
//       indirekt:  (vgl. Mayer, 2019, S. 438)
//       direkt:    (Mayer, 2019, S. 438)
//
//   "apa": Kurzbeleg in Klammern im Fließtext (wie Harvard, aber "&" vor
//   dem letzten Verfasser und Literaturverzeichnis nach APA-7-Regeln)
//       indirekt:  (vgl. Mayer & Schmidt, 2019, S. 438)
//       direkt:    (Mayer & Schmidt, 2019, S. 438)
//
// Verwendung im Text:
//   #vgl(<mayer2019>, seite: "438")    -> indirektes Zitat
//   #zit(<mayer2019>, seite: "438")    -> direktes (wörtliches) Zitat
//   #zitat(<mayer2019>, seite: "438")  -> nur der Kurzbeleg (z. B. für eigene
//                                         Fußnoten mit mehreren Quellen)
//
// Für E-Book-Quellen ohne verlagsgetreue Seiten tritt `kap:` an die Stelle
// von `seite:` (Kapitel statt Seite):
//   #vgl-kap(<mayer2019>, kap: "3.2")  -> indirektes Zitat mit Kapitelangabe
//   #zit-kap(<mayer2019>, kap: "3.2")  -> direktes Zitat mit Kapitelangabe
//
// Sekundärzitate (Zitat aus zweiter Hand) kombinieren Original- und
// Sekundärquelle; `-nach-kap` deckt zusätzlich den Fall ab, dass eine der
// beiden Quellen (oder beide) keine Seitenzahlen hat – `seite`/`seite-sek`
// und `kap`/`kap-sek` lassen sich beliebig mischen:
//   #vgl-nach(<original>, <sekundaer>, seite: "12", seite-sek: "88")
//   #vgl-nach-kap(<original>, <sekundaer>, seite: "12", kap-sek: "5")
//   #vgl-nach-kap(<original>, <sekundaer>, kap: "2", kap-sek: "5")
//
// "ebd." (Leitfaden 3.2): Belegt ein Zitat unmittelbar erneut dieselbe Quelle,
// tritt "ebd." an die Stelle des Kurzbelegs; eine abweichende Seiten- bzw.
// Kapitelangabe bleibt erhalten:
//   #vgl(<mayer2019>, seite: "438")    -> Vgl. Mayer, D., Finanzinv., 2019, S. 438.
//   #vgl(<mayer2019>, seite: "440")    -> Vgl. ebd., S. 440.
//   #vgl(<mayer2019>, seite: "440")    -> Vgl. ebd.
// Abgeschaltet wird das dokumentweit über `fom-arbeit(ebd: false)`, für einen
// einzelnen Beleg über `#vgl(..., ebd: false)` – etwa wenn der vorangehende
// Beleg durch einen Seitenumbruch weit entfernt steht.
//
// Schlusspunkt: Endet der Kurzbeleg selbst auf einen Punkt, darf die Fußnote
// keinen zweiten setzen. Bei der Stellenangabe ("o. S.", "12 f.") erkennen die
// Helfer das selbst; endet dagegen die *Jahres*angabe auf einen Punkt, weil die
// Quelle kein Erscheinungsjahr hat und die CSL "o. J." einsetzt, ist das aus
// Typst heraus nicht erkennbar – dort unterdrückt `punkt: false` den
// Schlusspunkt:
//   #vgl(<quelleOhneJahr>, punkt: false)  -> Vgl. AWS, CloudWatch, o. J.

#let _zitierweise = state("fom-zitierweise", "chicago")
#let _ebd-aktiv = state("fom-ebd", true)

// Zuletzt gesetzter Einzelbeleg als Grundlage für "ebd."; `none` unterbricht
// die Kette bewusst (siehe `_huelle`).
//
// Wichtig: Der Zustand darf ausschließlich an Stellen fortgeschrieben werden,
// deren Position im Dokument nicht vom Seitenumbruch abhängt – also im
// Fließtext, nie im Körper einer Fußnote. Fußnoten werden in den Fußnotenraum
// der Seite ausgelagert; ein Update von dort aus würde je nach Umbruch mal vor
// und mal hinter den folgenden Belegen liegen, und das Dokument liefe in eine
// Endlosschleife ("document did not converge"). Aus demselben Grund darf die
// Entscheidung auch keinen Wert lesen, der vom Umbruch abhängt – `counter(footnote)`
// etwa löst Typst im Fußnotenraum auf und ist damit tabu. Die nackten
// `zitat`-Bausteine stehen typischerweise in selbst geschriebenen Fußnoten und
// rühren den Zustand deshalb gar nicht an; dass eine fremde Fußnote
// dazwischenliegt, erkennt stattdessen `kette-unterbrechen`.
#let _letzter-beleg = state("fom-letzter-beleg", none)

// Wird vom Template beim Dokumentstart aufgerufen.
#let zitierweise-setze(stil) = {
  assert(stil in ("chicago", "harvard", "apa"), message: "zitierweise muss 'chicago', 'harvard' oder 'apa' sein.")
  _zitierweise.update(stil)
}

// Wird vom Template beim Dokumentstart aufgerufen.
#let ebd-setze(aktiv) = _ebd-aktiv.update(aktiv)

// Jede Fußnote unterbricht die "ebd."-Kette: In der Fußnoten-Zitierweise
// bezieht sich "ebd." auf die unmittelbar vorangehende Fußnote, und die muss
// dann auch der vorige Beleg sein – eine dazwischengeschobene (z. B.
// erklärende) Fußnote würde "ebd." sonst auf den falschen Beleg zeigen lassen.
// Wird vom Template als `show footnote: kette-unterbrechen` gesetzt.
//
// Die Unterbrechung sitzt bewusst an der Fußnotenziffer im Fließtext und nicht
// im Fußnotenkörper: Fußnotenkörper werden in den Fußnotenraum der Seite
// ausgelagert, ihre Position hinge damit am Seitenumbruch – und weil "ebd."
// kürzer ausfällt als der Kurzbeleg, hinge der Umbruch umgekehrt an dieser
// Entscheidung. Das Dokument liefe in eine Endlosschleife ("document did not
// converge").
#let kette-unterbrechen(it) = {
  _letzter-beleg.update(none)
  it
}

// Stellenangabe im Kurzbeleg. `art` ist "seite" oder "kap"; fehlende Seiten
// werden als "o. S." o. Ä. übergeben und dann unverändert übernommen
// (Leitfaden 2.6).
#let _stellenangabe(art, wert) = if wert == none {
  none
} else if art == "kap" {
  [Kap. #wert]
} else if type(wert) == str and wert.trim().starts-with("o.") {
  [#wert]
} else {
  [S. #wert]
}

// Kurzbeleg ohne jede Nebenwirkung – Bausteinschicht unter allen Helfern.
#let _zitat-roh(quelle, art, wert) = cite(quelle, supplement: _stellenangabe(art, wert))

// Vergleichswert für "dieselbe Stelle": `seite: 12` und `seite: "12"` sollen
// als identisch gelten.
#let _norm(wert) = if type(wert) == int { str(wert) } else { wert }

// Nackter Kurzbeleg (ohne Fußnote/Klammern) – Baustein für eigene Fußnoten:
//   #footnote[Vgl. #zitat(<a>, seite: "5"); #zitat(<b>, seite: "7").]
// Für Internetquellen ohne Seitenzahl: seite: "o. S." (Leitfaden 2.6).
// Ein nackter Kurzbeleg steht typischerweise in einer selbst geschriebenen
// Fußnote oder in einer Quellenzeile unter einer Abbildung; er ist deshalb kein
// Bezugspunkt für ein folgendes "ebd." – rührt die Kette aber auch nicht an
// (siehe Hinweis zur Konvergenz bei `_letzter-beleg`).
#let zitat(quelle, seite: none) = _zitat-roh(quelle, "seite", seite)

// Nackter Kurzbeleg mit Kapitel- statt Seitenangabe – für E-Book-Quellen ohne
// verlagsgetreue Seiten; sonst identisch zu `zitat`.
#let zitat-kap(quelle, kap: none) = _zitat-roh(quelle, "kap", kap)

// Endet die Seitenangabe selbst auf einen Punkt – "o. S.", "o. J.", "o. O."
// (Leitfaden 2.6) oder "12 f." –, darf der Schlusspunkt der Fußnote nicht
// zusätzlich gesetzt werden, sonst entsteht "..., o. S..".
#let _endet-auf-punkt(seite) = type(seite) == str and seite.trim().ends-with(".")

// Setzt den fertigen Beleg je nach Zitierweise in eine Fußnote oder in
// Klammern. `praefix: none` = direktes Zitat (kein "Vgl."), sonst indirektes
// Zitat. Sowohl "harvard" als auch "apa" setzen den Kurzbeleg in Klammern im
// Fließtext; nur "chicago" verwendet Fußnoten.
#let _umschliessen(stil, beleg, praefix, punkt) = {
  let schluss = if punkt { [.] } else { [] }
  if stil == "chicago" {
    if praefix == none { footnote[#beleg#schluss] } else { footnote[#praefix #beleg#schluss] }
  } else {
    if praefix == none { [(#beleg)] } else { [(#lower(praefix) #beleg)] }
  }
}

// Hülle für Belege, die nicht mit "ebd." fortgeführt werden dürfen (derzeit
// die Sekundärzitate): setzt den Beleg und unterbricht die "ebd."-Kette.
#let _huelle(beleg, praefix, punkt: true) = {
  _letzter-beleg.update(none)
  context _umschliessen(_zitierweise.get(), beleg, praefix, punkt)
}

// Einzelbeleg aus genau einer Quelle – gemeinsame Basis von #vgl/#zit und den
// Kapitel-Varianten. Hier entscheidet sich, ob der Kurzbeleg oder "ebd."
// (Leitfaden 3.2) erscheint.
#let _einzelbeleg(quelle, art, wert, praefix, ebd: true, punkt: auto) = context {
  let stil = _zitierweise.get()
  // `auto` = Schlusspunkt setzen, außer die Stellenangabe bringt schon einen mit.
  let schlusspunkt = if punkt == auto { not _endet-auf-punkt(wert) } else { punkt }
  let vorher = _letzter-beleg.get()
  // "ebd." setzt voraus, dass unmittelbar zuvor dieselbe Quelle belegt wurde.
  // Fremde Fußnoten und Sekundärzitate dazwischen haben die Kette bereits
  // unterbrochen (`kette-unterbrechen` bzw. `_huelle`).
  let ebenda = ebd and _ebd-aktiv.get() and vorher != none and vorher.quelle == quelle

  let ausgabe = if ebenda {
    // Gleiche Quelle *und* gleiche Stelle: "ebd." allein. Sonst bleibt die
    // Seiten- bzw. Kapitelangabe erhalten ("Vgl. ebd., S. 440.").
    let stelle = if vorher.art == art and vorher.wert == _norm(wert) {
      none
    } else {
      _stellenangabe(art, wert)
    }
    // Am Fußnotenanfang groß, hinter "Vgl." bzw. in Klammern klein.
    let wort = if stil == "chicago" and praefix == none { "Ebd." } else { "ebd." }
    if stelle == none {
      // "ebd." bringt seinen Punkt selbst mit.
      _umschliessen(stil, [#wort], praefix, false)
    } else {
      _umschliessen(stil, [#wort, #stelle], praefix, schlusspunkt)
    }
  } else {
    _umschliessen(stil, _zitat-roh(quelle, art, wert), praefix, schlusspunkt)
  }

  // Reihenfolge ist entscheidend: Erst der Beleg – dessen Fußnote über
  // `kette-unterbrechen` den Zustand zurücksetzt –, dann der eigene Eintrag.
  ausgabe
  _letzter-beleg.update((quelle: quelle, art: art, wert: _norm(wert)))
}

// Indirektes Zitat ("Vgl."). Über `praefix` lässt sich z. B. "S. dazu"
// (entfernte Anlehnung, Leitfaden 3.2) setzen; `ebd: false` erzwingt den
// vollständigen Kurzbeleg.
#let vgl(quelle, seite: none, praefix: "Vgl.", ebd: true, punkt: auto) = _einzelbeleg(
  quelle,
  "seite",
  seite,
  praefix,
  ebd: ebd,
  punkt: punkt,
)

// Direktes (wörtliches) Zitat – Kurzbeleg ohne "Vgl.".
#let zit(quelle, seite: none, ebd: true, punkt: auto) = _einzelbeleg(quelle, "seite", seite, none, ebd: ebd, punkt: punkt)

// Indirektes Zitat mit Kapitel- statt Seitenangabe (E-Book ohne Seiten).
#let vgl-kap(quelle, kap: none, praefix: "Vgl.", ebd: true, punkt: auto) = _einzelbeleg(
  quelle,
  "kap",
  kap,
  praefix,
  ebd: ebd,
  punkt: punkt,
)

// Direktes Zitat mit Kapitel- statt Seitenangabe.
#let zit-kap(quelle, kap: none, ebd: true, punkt: auto) = _einzelbeleg(quelle, "kap", kap, none, ebd: ebd, punkt: punkt)

// Kurzbeleg für Sekundärzitate ohne Nebenwirkung. Pro Quelle wird `kap`/
// `kap-sek` verwendet, falls gesetzt, sonst `seite`/`seite-sek`.
// Der Block wird bewusst einzeilig gehalten: ein Zeilenumbruch direkt nach "["
// bzw. vor "]" erzeugt in Typst führenden/nachfolgenden Leerraum, wodurch im
// Aufrufkontext "..., S. 67 ." statt "..., S. 67." entstünde.
#let _zitat-nach-roh(original, sekundaer, seite: none, kap: none, seite-sek: none, kap-sek: none) = {
  let beleg-original = if kap != none { _zitat-roh(original, "kap", kap) } else { _zitat-roh(original, "seite", seite) }
  let beleg-sekundaer = if kap-sek != none {
    _zitat-roh(sekundaer, "kap", kap-sek)
  } else {
    _zitat-roh(sekundaer, "seite", seite-sek)
  }
  [#beleg-original, zitiert nach #beleg-sekundaer]
}

// Nackter Kurzbeleg für Sekundärzitate – Baustein wie `zitat`.
// `original`   = die Quelle, aus der der Inhalt stammt
// `sekundaer`  = das Werk, in dem du sie gefunden hast
// `seite`      = Seite im Original, `seite-sek` = Seite in der Sekundärquelle
#let zitat-nach(original, sekundaer, seite: none, seite-sek: none) = _zitat-nach-roh(
  original,
  sekundaer,
  seite: seite,
  seite-sek: seite-sek,
)

// Nackter Kurzbeleg für Sekundärzitate, bei denen Original und/oder
// Sekundärquelle keine Seitenzahlen haben – Kombination aus `zitat-nach` und
// `zitat-kap`.
#let zitat-nach-kap(original, sekundaer, seite: none, kap: none, seite-sek: none, kap-sek: none) = _zitat-nach-roh(
  original,
  sekundaer,
  seite: seite,
  kap: kap,
  seite-sek: seite-sek,
  kap-sek: kap-sek,
)

// Indirektes Sekundärzitat: Vgl. Original, S. X, zitiert nach Sekundärquelle, S. Y.
// Ein Sekundärzitat nennt zwei Quellen und taugt deshalb weder als Ziel noch
// als Ausgangspunkt für "ebd." – `_huelle` unterbricht die Kette.
#let vgl-nach(original, sekundaer, seite: none, seite-sek: none, praefix: "Vgl.") = {
  _huelle(
    _zitat-nach-roh(original, sekundaer, seite: seite, seite-sek: seite-sek),
    praefix,
    punkt: not _endet-auf-punkt(seite-sek),
  )
}

// Direktes (wörtliches) Sekundärzitat – ohne "Vgl.".
#let zit-nach(original, sekundaer, seite: none, seite-sek: none) = {
  _huelle(
    _zitat-nach-roh(original, sekundaer, seite: seite, seite-sek: seite-sek),
    none,
    punkt: not _endet-auf-punkt(seite-sek),
  )
}

// Indirektes Sekundärzitat, bei dem Original und/oder Sekundärquelle über
// Kapitel statt Seite belegt werden – Kombination aus `vgl-nach` und `vgl-kap`.
#let vgl-nach-kap(original, sekundaer, seite: none, kap: none, seite-sek: none, kap-sek: none, praefix: "Vgl.") = {
  _huelle(
    _zitat-nach-roh(original, sekundaer, seite: seite, kap: kap, seite-sek: seite-sek, kap-sek: kap-sek),
    praefix,
    punkt: kap-sek != none or not _endet-auf-punkt(seite-sek),
  )
}

// Direktes Sekundärzitat, bei dem Original und/oder Sekundärquelle über
// Kapitel statt Seite belegt werden.
#let zit-nach-kap(original, sekundaer, seite: none, kap: none, seite-sek: none, kap-sek: none) = {
  _huelle(
    _zitat-nach-roh(original, sekundaer, seite: seite, kap: kap, seite-sek: seite-sek, kap-sek: kap-sek),
    none,
    punkt: kap-sek != none or not _endet-auf-punkt(seite-sek),
  )
}
// Nackter Kurzbeleg für Sekundärzitate – Baustein wie `zitat`.
// `original`   = die Quelle, aus der der Inhalt stammt
// `sekundaer`  = das Werk, in dem du sie gefunden hast
// `seite`      = Seite im Original, `seite-sek` = Seite in der Sekundärquelle
#let zitat-nach(original, sekundaer, seite: none, seite-sek: none) = [
  #zitat(original, seite: seite), zitiert nach #zitat(sekundaer, seite: seite-sek)
]

// Interner Baustein: nimmt den fertigen Beleg und entscheidet Fußnote vs. Klammer.
// `praefix: none` = direktes Zitat (kein "Vgl."), sonst indirektes Zitat.
#let _huelle-nach(beleg, praefix) = context {
  if _zitierweise.get() == "chicago" {
    if praefix == none { footnote[#beleg.] } else { footnote[#praefix #beleg.] }
  } else {
    if praefix == none { [(#beleg)] } else { [(#lower(praefix) #beleg)] }
  }
}

// Indirektes Sekundärzitat: Vgl. Original, S. X, zitiert nach Sekundärquelle, S. Y.
#let vgl-nach(original, sekundaer, seite: none, seite-sek: none, praefix: "Vgl.") = {
  _huelle-nach(zitat-nach(original, sekundaer, seite: seite, seite-sek: seite-sek), praefix)
}

// Direktes (wörtliches) Sekundärzitat – ohne "Vgl.".
#let zit-nach(original, sekundaer, seite: none, seite-sek: none) = {
  _huelle-nach(zitat-nach(original, sekundaer, seite: seite, seite-sek: seite-sek), none)
}
