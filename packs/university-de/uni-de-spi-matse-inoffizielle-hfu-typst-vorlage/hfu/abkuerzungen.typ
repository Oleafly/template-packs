// Verwaltung der im Dokument definierten und verwendeten Abkürzungen.
// `ac` folgt dem Grundverhalten des LaTeX-Pakets `acronym`.
// Die erste Verwendung wird als Langform mit Kurzform in Klammern gesetzt.
// Danach erscheint nur noch die Kurzform.

#let pruefe-abkuerzungen(abkuerzungen) = {
  assert(
    type(abkuerzungen) == array,
    message: "hfu-vorlage: `abkuerzungen` muss ein Array sein.",
  )

  let bekannte = ()
  for eintrag in abkuerzungen {
    assert(
      type(eintrag) == dictionary,
      message: "hfu-vorlage: Jeder Abkürzungseintrag muss ein Dictionary sein.",
    )

    let kurz = eintrag.at("kurz", default: none)
    let lang = eintrag.at("lang", default: none)
    assert(
      type(kurz) == str and kurz.trim() != "",
      message: "hfu-vorlage: Jede Abkürzung benötigt eine nichtleere `kurz`-Angabe.",
    )
    assert(
      type(lang) == str and lang.trim() != "",
      message: "hfu-vorlage: Jede Abkürzung benötigt eine nichtleere `lang`-Angabe.",
    )
    assert(
      kurz not in bekannte,
      message: "hfu-vorlage: Die Abkürzung `" + kurz + "` ist mehrfach definiert.",
    )
    bekannte.push(kurz)
  }
}

#let registriere-abkuerzungen(abkuerzungen) = {
  pruefe-abkuerzungen(abkuerzungen)
  [#metadata(abkuerzungen)<hfu-abkuerzungen>]
}

#let definitionen() = {
  let register = query(<hfu-abkuerzungen>)
  assert(
    register.len() == 1,
    message: "hfu-vorlage: Die Abkürzungen sind nicht eindeutig registriert.",
  )
  register.first().value
}

#let finde-abkuerzung(schluessel) = {
  assert(
    type(schluessel) == str and schluessel.trim() != "",
    message: "hfu-vorlage: `ac` erwartet eine nichtleere Kurzform als String.",
  )

  let eintrag = definitionen().find(eintrag => eintrag.kurz == schluessel)
  assert(
    eintrag != none,
    message: "hfu-vorlage: Die Abkürzung `" + schluessel
      + "` ist nicht in `inhalt/abkuerzungen.typ` definiert.",
  )
  eintrag
}

#let verwendung(schluessel) = [#metadata(schluessel)<hfu-abkuerzung-verwendung>]

#let markiere-abkuerzungen-verwendet(..schluessel) = {
  for eintrag in schluessel.pos() {
    verwendung(eintrag)
    state("hfu-abkuerzung-verwendet-" + eintrag, false).update(true)
  }
}

#let ac(schluessel) = context {
  let eintrag = finde-abkuerzung(schluessel)
  let verwendet = state("hfu-abkuerzung-verwendet-" + schluessel, false)
  let erste-verwendung = not verwendet.get()

  verwendung(schluessel)
  verwendet.update(true)

  if erste-verwendung {
    [#eintrag.lang (#eintrag.kurz)]
  } else {
    eintrag.kurz
  }
}
