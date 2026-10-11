// lib/titlepage.typ
// ═══════════════════════════════════════════════════════════════════════════
// Titelblatt nach dem Muster in Anhang 1–4 der "Hinweise zur Anfertigung von
// Projekt- und Bachelorarbeiten" (H 3.1).
//
// Pflichtangaben (H 3.1): Thema, Verfasser*in, Kurs, Duales Partnerunternehmen,
// wissenschaftliche Betreuung, Abgabedatum sowie – falls vorhanden – der
// Hinweis auf den Sperrvermerk. Logos von DHBW und Dualem Partner sind erlaubt.
//
// Felder, die in main.typ noch leer sind, erscheinen wie im Muster von Anhang 1
// als Auslassungspunkte "…" — so ist auf einen Blick sichtbar, was noch fehlt.
// Das Titelblatt trägt keine Seitenzahl und wird nicht mitgezählt.
// ═══════════════════════════════════════════════════════════════════════════

#let _fmt_date(d) = if type(d) == datetime {
  d.display("[day].[month].[year]")
} else { d }

#let _leer(v) = v == none or v == "" or v == []

// Platzhalter für noch nicht ausgefüllte Angaben (wie "…." in Anhang 1)
#let _oder_punkte(v) = if _leer(v) { text(fill: luma(120))[…] } else { [#v] }

#let titlepage(
  title: "",
  thesis_type: "",
  degree: "",
  faculty: "",
  course_of_studies: "",
  course: "",
  author: "",
  company: (:),
  university_advisor: "",
  submission_date: none,
  has_blocking_notice: false,
  dhbw_logo: none,
  company_logo: none,
) = {
  set page(header: none, footer: none, numbering: none)
  set par(justify: false, leading: 0.65em, spacing: 0.65em)

  let company_name = company.at("name", default: none)
  let company_location = company.at("location", default: none)
  let company_advisor = company.at("advisor", default: none)

  // Pflichtangaben im Fuß des Titelblatts (H 3.1) – Reihenfolge wie Anhang 1
  let angaben = (
    [Verfasst von:], _oder_punkte(author),
    [Kurs:], _oder_punkte(course),
    [Partnerunternehmen:],
    if _leer(company_name) { _oder_punkte(none) } else if _leer(company_location) {
      [#company_name]
    } else [#company_name, #company_location],
  )
  // Betriebliche Betreuung ist keine Pflichtangabe → nur wenn ausgefüllt
  if not _leer(company_advisor) {
    angaben += ([Betreuung im Unternehmen:], [#company_advisor])
  }
  angaben += (
    [Wissenschaftlich betreut von:], _oder_punkte(university_advisor),
    [Abgabedatum:], _oder_punkte(_fmt_date(submission_date)),
  )

  align(center)[
    // ── Logos: DHBW links, Dualer Partner rechts (H 3.1, beide optional) ──
    // `fit: "contain"` hält beide Logos unabhängig vom Seitenverhältnis in
    // ihrem Feld — Höhe bei Bedarf anpassen.
    #let logo(pfad, hoehe) = image(pfad, width: 100%, height: hoehe, fit: "contain")
    #if not _leer(dhbw_logo) and not _leer(company_logo) {
      grid(
        columns: (1fr, 1.5cm, 1fr),
        align: center + horizon,
        logo(dhbw_logo, 3cm),
        [],
        logo(company_logo, 2.4cm),
      )
    } else if not _leer(dhbw_logo) {
      logo(dhbw_logo, 3.5cm)
    } else if not _leer(company_logo) {
      logo(company_logo, 3cm)
    }

    #v(1.5cm)
    #text(size: 14pt)[Fakultät #_oder_punkte(faculty)]

    #v(1cm)
    #text(size: 14pt)[Studiengang #_oder_punkte(course_of_studies)]

    #v(1.5cm)
    #text(size: 18pt, weight: "bold")[#_oder_punkte(title)]

    #v(1cm)
    #text(size: 14pt)[#_oder_punkte(thesis_type)]

    #v(1em)
    Im Rahmen der Prüfung zum #_oder_punkte(degree)

    // ── Hinweis auf den Sperrvermerk (H 3.1/3.2) ─────────────────────────
    #if has_blocking_notice {
      v(1cm)
      text(size: 14pt, weight: "bold")[Sperrvermerk]
    }

    #v(1fr)

    #grid(
      columns: (1fr, 1fr),
      row-gutter: 1.5em,
      column-gutter: 0.5cm,
      align: (right, left),
      ..angaben,
    )
  ]
}
