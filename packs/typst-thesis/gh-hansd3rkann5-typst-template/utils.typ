#import "data.typ": glossary, symbols
#import "config.typ": chapter-pagebreak, show-wordometer
#import "@preview/wordometer:0.1.4": total-words

#let inwriting = true
#let draft = true

#assert(not(inwriting and not(draft)), message: "If inwriting is true, draft should be true as well.")

// --- HELPERS ---

#let todo(it) = [
  #if inwriting [
    #text(size: 0.8em)[#emoji.pencil] #text(it, fill: red, weight: 600)
  ]
]

#let silentheading(level, body) = [
  #heading(outlined: false, level: level, numbering: none, bookmarked: true)[#body]
]

#let gap() = {
  v(0.5em)
  h(-1.8em)
}

// --- EQUATIONS ---

#let eq(body, label: none, vars: ()) = {
  block(width: 100%)[
    #math.equation(block: true, body)
    #if label != none { label }
  ]
  if vars.len() > 0 {
    pad(left: 1.1em, top: -0.5em)[
      #set text(size: 0.85em)
      #grid(
        columns: (2em, 1.5em, auto),
        row-gutter: 0.4em,
        ..vars.map(v => (v.at(0), [=], v.at(1))).flatten()
      )
    ]
  }
}

// --- GLOSSARY LOGIC ---

#let used-keys = state("used-keys", ())

// Hilfsfunktion zur Registrierung (zentrale Logik für Kapitelzuordnung)
#let register-key(k) = context {
  let history = used-keys.get()
  if not history.any(it => it.key == k) {
    let ch-num = counter(heading).get()
    let ch-str = ch-num.map(str).join(".") 
    used-keys.update(h => h + ((key: k, ch: ch-str),))
  }
}

// 1. Hauptfunktion: Langform bei Erstnennung, sonst Kurzform
#let gl(key) = context {
  let k = str(key)
  let entry = (glossary + symbols).find(e => str(e.key) == k)
  
  if entry == none { 
    return text(red)["#k" is not defined in data.typ] 
  }

  let history = used-keys.get()
  let is-first = not history.any(it => it.key == k)

  if is-first {
    register-key(k)
    [#entry.at("long", default: entry.short) (#entry.short)]
  } else {
    entry.short
  }
}

// 2. Heading-Funktion: Immer Kurzform, keine Registrierung (verhindert TOC-Vortrigger)
#let glh(key) = context {
  let k = str(key)
  let entry = (glossary + symbols).find(e => str(e.key) == k)
  if entry == none {
    return text(red)["#k" is not defined in data.typ]
  }
  entry.short
}

// 3. Kurzform-Funktion: Immer nur Symbol/Kurzform (z. B. für Gleichungen)
#let gls(key) = context {
  let k = str(key)
  let entry = (glossary + symbols).find(e => str(e.key) == k)
  
  if entry == none { 
    return text(red)[short "#k" is not defined in data.typ] 
  }

  register-key(k)
  entry.short
}

// 3. Lowercase-Funktion: Immer die kleingeschriebene Langform
#let gll(key) = context {
  let k = str(key)
  let entry = (glossary + symbols).find(e => str(e.key) == k)
  
  if entry == none { 
    return text(red)[lower for "#k" is not defined in data.typ] 
  }

  let history = used-keys.get()
  let is-first = not history.any(it => it.key == k)

  if is-first {
    register-key(k)
    [#entry.at("lower", default: entry.short) (#entry.short)]
  } else {
    entry.short
  }
}

// --- HEADER & PAGE LAYOUT ---

#let header(section_title, body) = {
  // Seiten-Konfiguration setzen
  set page(
    header: context {
      let all_headings = query(selector(heading.where(level: 1)))
      let target = all_headings.filter(h => h.location().page() <= here().page()).at(-1, default: none)
      
      let display_title = if target != none {
        if target.numbering != none {
          let num = counter(heading).at(target.location()).at(0)
          [#num #target.body]
        } else {
          target.body
        }
      } else {
        section_title
      }
      
      grid(
        columns: (1fr, 1fr),
        align: (left + bottom, right + bottom),
        inset: (bottom: 5pt),
        stroke: (bottom: 0.5pt),
        text(weight: "regular", display_title),
        image("figures/Logo.png", height: 16pt) 
      )
    }
  )

  body
  if chapter-pagebreak { pagebreak(weak: true) }
  if inwriting and show-wordometer {
    v(1em)
    align(right)[
      #text(fill: luma(160), size: .78em, style: "italic")[#section_title: #total-words words]
    ]
  }
}

// --- SI UNIT HELPER ---

#let si(value, unit) = {
  // Dictionary für gängige Einheiten (erweitert um deine Lab-Daten)
  let units = (
    rho: $g / (c m^3)$,
    deg: $degree$,
    perc: [$%$],
    temp: $degree C$,
    stress: [$M P a$],
    modulus: [$G P a$],
    visc: $P a dot s$,
    ohm: $Omega$,
    jg: $J / g$,
    kg: [$k g$],
    mg: [$m g$],
    m3: $m^3$,
    N: [$N$],
    au: [a.u.],
    t: [$t$],
    "none": [$-$]
  )

  // Prüfen, ob das Kürzel existiert, sonst die Eingabe direkt nutzen
  let final-unit = if type(unit) == str and unit in units {
    units.at(unit)
  } else {
    unit
  }

  // Box verhindert Zeilenumbruch; h(0.1em) ist das schmale Leerzeichen
  // Wir prüfen, ob value leer ist (für die Tabellenspalte), dann kein Space
  box([
    #if str(value).len() > 0 [$#value$#h(0.12em, weak: true)]
    #final-unit
  ])
}

// --- BIBLIOGRAPHY & APPENDIX HELPERS ---

#let bib-appendix(path: "items.bib", style: "ieee") = context {
  // Check if any sources were actually cited in the document
  let citations = query(cite)
  
  if citations.len() > 0 {
    // 1. Style: Shift the bracketed numbers [6] down
    show bibliography: it => {
      show regex("\[\d+\]"): set text(baseline: 0.15em)
      it
    }

    // 2. Page Layout: Switch to Roman numbering for the appendix
    set page(numbering: "I")
    counter(page).update(1)

    // 3. Render: Add a pagebreak and the bibliography
    pagebreak(weak: true)
    bibliography(path, style: style)
  }
}