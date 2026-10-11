// Logica comune ai template: dati, variante, lingua, filtri, date.

#let cv = yaml("/data/cv.yaml")
#let vname = sys.inputs.at("variant", default: "data-it")
#let variant = yaml("/variants/" + vname + ".yaml")
#let lang = variant.lang
#let profile = variant.profile
#let maxp = variant.at("max_priority", default: 2)
// Varianti "draft: true" (o --input draft=1) evidenziano i TODO in rosso.
#let draft = variant.at("draft", default: false) or sys.inputs.at("draft", default: "0") == "1"


// ---------- etichette ----------
#let L = (
  it: (summary: "Profilo", experience: "Esperienza", education: "Formazione",
       skills: "Competenze", certifications: "Certificazioni", languages: "Lingue",
       interests: "Interessi", projects: "Progetti", present: "oggi",
       months: ("gen", "feb", "mar", "apr", "mag", "giu", "lug", "ago", "set", "ott", "nov", "dic")),
  en: (summary: "Profile", experience: "Experience", education: "Education",
       skills: "Skills", certifications: "Certifications", languages: "Languages",
       interests: "Interests", projects: "Projects", present: "present",
       months: ("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")),
).at(lang)

// ---------- helper ----------
#let is-todo(x) = type(x) == str and x.contains("TODO")

// Testo bilingue -> stringa nella lingua della variante.
#let t(x) = {
  if x == none { return none }
  if type(x) == dictionary {
    let r = x.at(lang, default: none)
    if r == none { return "[" + upper(lang) + " TODO] " + str(x.at("it", default: "")) }
    return r
  }
  str(x)
}

// Mostra una stringa; se contiene TODO la evidenzia (bozza) o la nasconde (finale).
#let show-t(x) = {
  let s = t(x)
  if s == none { return none }
  if is-todo(s) {
    if draft { text(fill: red, s) } else { none }
  } else { s }
}

#let included(item) = {
  let tags = item.at("tags", default: ())
  let p = item.at("priority", default: 1)
  p <= maxp and (profile in tags or "core" in tags)
}

#let fmt-date(d) = {
  if d == none { return L.present }
  let s = str(d)
  if s.contains("TODO") { return if draft { text(fill: red, "TODO") } else { "" } }
  if s.len() == 4 { return s }
  let parts = s.split("-")
  L.months.at(int(parts.at(1)) - 1) + " " + parts.at(0)
}

#let date-range(a, b) = [#fmt-date(a) – #fmt-date(b)]

// Titolo sotto il nome: per profilo ({data: {...}, asd: {...}}) o unico ({it, en}).
#let headline() = {
  let hl = cv.personal.headline
  if type(hl) == dictionary and profile in hl { hl = hl.at(profile) }
  show-t(hl)
}

// Esperienze filtrate, con eventuale riordino da variante (experience_first: [id, ...]).
#let experience-items() = {
  let items = cv.experience.filter(included)
  let first = variant.at("experience_first", default: ())
  if first.len() > 0 {
    items = first.map(id => items.filter(e => e.id == id)).flatten() + items.filter(e => e.id not in first)
  }
  items
}

#let exp-org(e) = {
  let org = e.org
  if e.at("show_via", default: false) and e.at("via", default: none) != none { org = org + " (" + e.via + ")" }
  org
}

#let edu-dates(e) = if e.at("hide_dates", default: false) { none } else { date-range(e.start, e.end) }
