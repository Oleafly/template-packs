// Dokumentstruktur: Baut das gesamte Dokument aus den Nutzerdaten zusammen.
// Einbindung in main.typ über  #show: structure.with(...)

#import "template.typ": conf as template
#import "functions.typ": abk_print_entry, has-gloss-ref, qfigure
#import "@preview/glossarium:0.5.10": make-glossary, print-glossary, register-glossary
#import "titelblatt.typ": titelblatt

#let structure(
  titel: "",
  pruefungsform: "",
  kursname: "",
  studiengang: "",
  author: "",
  matrikel: "",
  betreuertyp: "",
  betreuer: "",
  date: datetime.today(),
  pagebreak_b4_abbildungsv: false,
  pagebreak_b4_tabellenv: false,
  pagebreak_b4_glossar: false,
  genderhinweis: false,
  body-content: [],
  anhang-content: [],
  entry-list: (),
  doc,
) = {
  show: template
  show: make-glossary
  register-glossary(entry-list)
  
  // Metainformationen
  set document(
    title: if titel == "" { kursname } else { titel },
    author: author,
    description: pruefungsform,
    date: date,
  )
  
  // ── Titelblatt ───────────────────────────────────────────
  set page(numbering: none)
  titelblatt(
    pruefungsform: pruefungsform,
    kursname: kursname,
    studiengang: studiengang,
    titel: titel,
    author: author,
    matrikel: matrikel,
    betreuertyp: betreuertyp,
    betreuer: betreuer,
    date: date,
  )
  
  // ── Inhaltsverzeichnis & Verzeichnisse ───────────────────
  set page(numbering: "I")
  outline()
  
  // Abbildungsverzeichnis (ab 3 Abbildungen)
  context if query(figure.where(kind: image)).len() >= 3 {
    if pagebreak_b4_abbildungsv { pagebreak() } else { v(6pt) }
    outline(
      title: heading(level: 1, outlined: true, numbering: none)[Abbildungsverzeichnis],
      target: figure.where(kind: image),
    )
  }
  
  // Tabellenverzeichnis (ab 3 Tabellen)
  context if query(figure.where(kind: table)).len() >= 3 {
    if pagebreak_b4_tabellenv { pagebreak() } else { v(6pt) }
    outline(
      title: heading(level: 1, outlined: true, numbering: none)[Tabellenverzeichnis],
      target: figure.where(kind: table),
    )
  }
  
  // Abkürzungsverzeichnis (ab 1 referenziertem Eintrag)
  if entry-list.len() > 0 {
    context {
      let used = entry-list.filter(e => has-gloss-ref(e.at("key")))
      if used.len() > 0 {
        if pagebreak_b4_glossar { pagebreak() }
        heading(numbering: none, outlined: true)[Abkürzungsverzeichnis]
      }
    }
    
    print-glossary(
      entry-list,
      user-print-gloss: abk_print_entry,
    )
  }
  
  if genderhinweis {
    pagebreak()
    heading(numbering: none, outlined: false)[Hinweis zur geschlechtergerechten Sprache]
    par[
      Aus Gründen der besseren Lesbarkeit wird in diesem Dokument überwiegend das generische Maskulinum verwendet. Selbstverständlich sind damit Personen aller Geschlechter gleichermaßen gemeint.  
    ]
  }
  
  pagebreak()
  
  // ── Body ─────────────────────────────────────────────────
  set page(numbering: "1")
  counter(page).update(1)
  
  body-content
  
  // ── Quellenverzeichnis ───────────────────────────────────
  // Inspiriert von @yemouus Code (GitHub)
  show bibliography: bib-it => {
    set block(inset: 0in)
    show block: block-it => context {
      if block-it.body == auto {
        block-it
      } else {
        if block-it.body.func() != [].func() {
          block-it.body
          parbreak()
        } else {
          par(block-it.body)
        }
      }
    }
    
    bib-it
  }
  
  /* TODO:
  - Podcast fehlt Rolle, Episodennummer sollte kein Präfix haben, Typ wird nicht angezeigt
  - Filmen fehlt die Rolle
  - Suffixe zur Eindeutigkeit werden nach Aufrufreihenfolge benannt, statt nach Position im Literaturverzeichnis. -> Workaround: #hide(@quelle-a) vor @quelle-b aufrufen falls sortierung falsch
  */
  
  show bibliography: it => context if query(cite).len() > 0 {
    pagebreak()
    it
  }
  bibliography(
    "/bib/literatur.bib",
    title: "Literaturverzeichnis",
    style: "/csl/apa7-iu.csl",
  )
  
  // ── Anhangsverzeichnis ───────────────────────────────────
  context if query(figure.where(kind: "anhang")).len() > 1 {
    pagebreak()
    outline(
      title: heading(level: 1, outlined: true, numbering: none)[Anhangsverzeichnis],
      target: figure.where(kind: "anhang"),
    )
  }
  
  show outline.entry: it => link(
    it.element.location(),
    it.indented(it.prefix(), it.inner()),
  )
  
  context if query(figure.where(kind: "anhang")).len() > 0 {
    pagebreak()
  }
  
  {
    set figure(kind: "anhang")
    show figure.where(kind: "anhang"): set block(above: 1em + 12pt)
    anhang-content
  }
  
  doc
}
