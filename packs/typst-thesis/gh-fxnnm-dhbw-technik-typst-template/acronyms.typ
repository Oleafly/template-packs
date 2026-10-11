// ============================================================
//  Abkürzungen
//  Neue Einträge in _acronyms ergänzen.
//
//  Verwendung im Text:
//    #acr("API")   → Erstnennung: "Application Programming Interface (API)"
//                    Folgenennung: "API"
//    #acrs("API")  → immer nur Kurzform:  "API"
//    #acrl("API")  → immer nur Langform:  "Application Programming Interface"
//
//  Verzeichnis ausgeben:
//    #print-acronyms()
// ============================================================

// ── Abkürzungsliste ───────────────────────────────────────────
// Format:  "KÜRZEL": ("KÜRZEL", "Ausgeschriebene Bedeutung")
#let _acronyms = (
  "AI":    ("AI",    "Artificial Intelligence"),
  "API":   ("API",   "Application Programming Interface"),
  "CAD":   ("CAD",   "Computer-Aided Design"),
  "CLI":   ("CLI",   "Command-Line Interface"),
  "CPU":   ("CPU",   "Central Processing Unit"),
  "DHBW":  ("DHBW",  "Duale Hochschule Baden-Württemberg"),
  "GPIO":  ("GPIO",  "General-Purpose Input/Output"),
  "GUI":   ("GUI",   "Graphical User Interface"),
  "HTML":  ("HTML",  "Hypertext Markup Language"),
  "HTTP":  ("HTTP",  "Hypertext Transfer Protocol"),
  "HTTPS": ("HTTPS", "Hypertext Transfer Protocol Secure"),
  "IDE":   ("IDE",   "Integrated Development Environment"),
  "IoT":   ("IoT",   "Internet of Things"),
  "JSON":  ("JSON",  "JavaScript Object Notation"),
  "ML":    ("ML",    "Machine Learning"),
  "OS":    ("OS",    "Operating System"),
  "PDF":   ("PDF",   "Portable Document Format"),
  "RAM":   ("RAM",   "Random Access Memory"),
  "REST":  ("REST",  "Representational State Transfer"),
  "ROM":   ("ROM",   "Read-Only Memory"),
  "SQL":   ("SQL",   "Structured Query Language"),
  "SSD":   ("SSD",   "Solid-State Drive"),
  "UML":   ("UML",   "Unified Modeling Language"),
  "USB":   ("USB",   "Universal Serial Bus"),
  "XML":   ("XML",   "Extensible Markup Language"),
)

// ── Zustand: bereits verwendete Kürzel ───────────────────────
#let _acr-state = state("acr-used", ())

// ── Hilfsfunktionen ───────────────────────────────────────────

// Erstnennung → "Langform (Kürzel)", danach → "Kürzel"
#let acr(key) = [#context {
  let text = if _acr-state.get().contains(key) {
    _acronyms.at(key).at(0)
  } else {
    _acronyms.at(key).at(1) + " (" + _acronyms.at(key).at(0) + ")"
  }
  link(label("acr-" + key), text)
}#_acr-state.update(u => if u.contains(key) { u } else { u + (key,) })]

// Immer Kurzform (trägt ebenfalls zum Verzeichnis bei)
#let acrs(key) = [#link(label("acr-" + key), _acronyms.at(key).at(0))#_acr-state.update(u => if u.contains(key) { u } else { u + (key,) })]

// Immer Langform (trägt ebenfalls zum Verzeichnis bei)
#let acrl(key) = [#link(label("acr-" + key), _acronyms.at(key).at(1))#_acr-state.update(u => if u.contains(key) { u } else { u + (key,) })]

// ── Verzeichnis ───────────────────────────────────────────────
#let print-acronyms() = {
  heading(numbering: none, level: 1)[Abkürzungsverzeichnis]
  v(0.3em)
  context {
    let used   = _acr-state.final()
    let sorted = _acronyms.keys().filter(k => used.contains(k)).sorted()
    table(
      columns: (2.5cm, 1fr),
      stroke: none,
      inset: (x: 0pt, y: 3pt),
      ..sorted.map(k => (
        [#strong(_acronyms.at(k).at(0))#label("acr-" + k)],
        _acronyms.at(k).at(1),
      )).flatten()
    )
  }
}
