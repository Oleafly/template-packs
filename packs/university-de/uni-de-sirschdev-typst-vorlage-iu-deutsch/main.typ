#import "template/structure.typ": structure
#import "template/functions.typ": qfigure
#import "@preview/glossarium:0.5.10": gls, glspl


// ══════════════════════════════════════════════════════════
// Daten für Titelblatt eingeben
// Bei leerem Titel wird Kursname fett gedruckt
// ══════════════════════════════════════════════════════════
#let titel = ""
#let pruefungsform = "Z. B. Seminararbeit"
#let kursname = "Methoden der Einzel- und Gruppenberatung"
#let studiengang = "Soziale Arbeit"
#let author = "Max Mustermann"
#let matrikel = "123456"
#let betreuertyp = "Betreuende Person/ Tutor:in"
#let betreuer = "Prof. Dr. Simone Musterfrau"
#let date = datetime.today()

// Manuelle Seitenumbrüche vor Verzeichnissen
#let pagebreak_b4_abbildungsv = false
#let pagebreak_b4_tabellenv = false
#let pagebreak_b4_glossar = false

// Zeige Genderhinweis
#let genderhinweis = false

// ══════════════════════════════════════════════════════════
// Inhalt
// ══════════════════════════════════════════════════════════
#let body = [
  // ── BODY START ────────────────────────────────────────────────
  //
  // Hier Text schreiben
  // = Level 1 Überschrift
  // == Level 2 Überschrift
  // - Level 1 ul-Auzählung
  // -- Level 2 ul-Auzählung
  // + Level 1 ol-Aufzählung
  // _kursiver Text_
  // *fetter Text*
  // $Mathemathische Ausdrücke$
  // Zitat @qulle-key[S.~1--3] oder #cite(<quelle-key>) für mehr Einstellungen
  // Verweis auf Anhang, Glossar, Abbildung mit @verweis-key
  // Abbildungen mit custom-function #qfigure(image("quelle",args)|Table([Zelle1],[Zelle2]),[caption],[quelle])<key> 
  // 
  // -> Typst Tutorial: https://typst.app/docs/tutorial/
  // -> mehr infos zu image: https://typst.app/docs/reference/visualize/image/
  // -> mehr infos zu table: https://typst.app/docs/reference/model/table/
  // -> mehr infos zu Mathe-Notation: https://typst.app/docs/reference/math/
  // 
  // ────────────────────────────────────────────────── BODY END ── 
]

// ══════════════════════════════════════════════════════════
// Anhang
// ══════════════════════════════════════════════════════════
#let anhang = [
  //  Beispiel:
  //  #qfigure(
  //    image("/img/logo.jpg"),
  //    [IU Logo],
  //    [Quelle]
  //  )<logo>
  // 
]

// ══════════════════════════════════════════════════════════
// Glossar / Abkürzungsverzeichnis
// ══════════════════════════════════════════════════════════
#let entry-list = (
  // Beispiel:
  // (
  //   key: "ki",
  //   short: "KI",
  //   plural: "KIs",
  //   long: "Künstliche Intelligenz",
  //   longplural: "Künstliche Intelligenzen",
  // ),
  // Nutzung: @ki, @ki:pl, @Ki, @Ki:pl, @ki:short, @ki:long
  // Doku: https://typst.app/universe/package/glossarium
)


// ══════════════════════════════════════════════════════════
// Dokument rendern
// ══════════════════════════════════════════════════════════
#show: structure.with(
  titel: titel,
  pruefungsform: pruefungsform,
  kursname: kursname,
  studiengang: studiengang,
  author: author,
  matrikel: matrikel,
  betreuertyp: betreuertyp,
  betreuer: betreuer,
  date: date,
  pagebreak_b4_abbildungsv: pagebreak_b4_abbildungsv,
  pagebreak_b4_tabellenv: pagebreak_b4_tabellenv,
  pagebreak_b4_glossar: pagebreak_b4_glossar,
  genderhinweis: genderhinweis,
  body-content: body,
  anhang-content: anhang,
  entry-list: entry-list,
)