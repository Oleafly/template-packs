// Vorlage für WABs der Provadis Hochschule
// Basiert auf phs-latex-templates von kannX
// Konvertiert zu Typst
// CC BY 4.0

// Glossy für Glossar und Abkürzungen
// Verwendung in Kapiteln: @lorem-ipsum, @lorem-ipsum:long, @lorem-ipsum:short, @lorem-ipsum:pl
#import "@preview/glossy:0.9.2": init-glossary, glossary

// Haupttemplate-Funktion
#let phs-thesis(
  titel: "",
  fullname: "",
  email: "",
  matnr: "",
  tel-mobil: "",
  fakultaet: "Informatik und Wirtschaftsinformatik",
  unternehmen: "",
  abgabedatum: "",
  ref-first: "",
  ref-second: "",
  studiengang: "",
  art: "Bachelorarbeit",
  akademischer-grad: "Bachelor of Science",
  abkuerzung-grad: "B.Sc.",
  show-sperrvermerk: true,
  show-abstract: true,
  abstract-text: none,
  glossary-file: "glossary.yaml",
  logo: none,
  logo-unternehmen: none,
  body,
) = {
  // Load glossary from YAML file
  let glossary-entries = yaml(glossary-file)

  // Initialize glossy with the glossary entries
  show: init-glossary.with(glossary-entries, show-term: (body) => [#emph(body)])

  // Dokumenteinstellungen
  set document(
    title: titel,
    author: fullname,
  )

  // Seitenformat
  set page(
    paper: "a4",
    margin: (left: 3cm, right: 2cm, top: 3cm, bottom: 3cm),
  )

  // Schriftart (Times-ähnlich)
  set text(
    font: "Libertinus Serif",
    size: 12pt,
    lang: "de",
    region: "DE",
  )

  // Absatzeinstellungen
  set par(
    justify: true,
    leading: 1.5 * 0.65em,
  )

  // Überschriften
  set heading(numbering: "1.1.1")

  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    v(1em)
    text(size: 18pt, weight: "bold")[
      #if it.numbering != none {
        counter(heading).display()
        h(0.5em)
      }
      #it.body
    ]
    v(1em)
  }

  show heading.where(level: 2): it => {
    v(0.8em)
    text(size: 14pt, weight: "bold")[
      #if it.numbering != none {
        counter(heading).display()
        h(0.5em)
      }
      #it.body
    ]
    v(0.5em)
  }

  show heading.where(level: 3): it => {
    v(0.6em)
    text(size: 12pt, weight: "bold")[
      #if it.numbering != none {
        counter(heading).display()
        h(0.5em)
      }
      #it.body
    ]
    v(0.3em)
  }

  // Links
  show link: it => text(fill: rgb("#000080"), it)

  // ============= TITELSEITE =============
  page(
    margin: (left: 3cm, right: 2cm, top: 3cm, bottom: 3cm),
    header: none,
    footer: none,
  )[
    #set par(leading: 0.65em)

    // Logos
    #grid(
      columns: (1fr, 1fr),
      align: (left, right),
      {
        if logo != none {
          image(logo, height: 2.06cm)
        } else {
          // Platzhalter für Hochschul-Logo
          text(size: 10pt, fill: gray)[_Hochschul-Logo hier einfügen_]
        }
      },
      {
        if logo-unternehmen != none {
          image(logo-unternehmen, height: 2.06cm)
        }
      }
    )

    #v(1cm)

    #align(center)[
      #text(size: 12pt)[#art]

      #v(2cm)

      #text(size: 14pt, weight: "bold")[#titel]

      #v(3cm)

      #text(size: 12pt)[
        Zur Erlangung des akademischen Grades \
        '#akademischer-grad' #abkuerzung-grad \
        im Studiengang '#studiengang'
      ]

      #v(2cm)

      #text(size: 12pt)[
        vorgelegt dem Fachbereich #fakultaet der \
        Provadis School of International Management and Technology \
        von
      ]

      #v(1cm)

      #text(size: 12pt)[
        #fullname \
        #matnr \
        #studiengang \
        #email \
        #tel-mobil
      ]
    ]

    #v(1fr)

    #grid(
      columns: (auto, auto),
      row-gutter: 0.25cm,
      column-gutter: 1em,
      [Erstgutachter:], ref-first,
      [Zweitgutachter:], ref-second,
      [Ende der Bearbeitungsfrist:], abgabedatum,
    )
  ]

  // ============= VORSPANN (römische Seitenzahlen) =============
  set page(
    numbering: "i",
    header: context {
      let page-num = counter(page).get().first()
      if page-num > 1 {
        line(length: 100%, stroke: 0.5pt)
      }
    },
    footer: context {
      line(length: 100%, stroke: 0.5pt)
      v(0.3em)
      align(center)[#counter(page).display("i")]
    },
  )
  counter(page).update(1)

  // Sperrvermerk
  if show-sperrvermerk {
    heading(level: 1, numbering: none)[Sperrvermerk]

    block(
      fill: rgb("#fff3cd"),
      inset: 1em,
      radius: 4pt,
      width: 100%,
    )[
      _Ein Sperrvermerk ist nur zulässig, wenn zwingend schützensnotwendige, vertrauliche Informationen in der Arbeit enthalten sind._
    ]

    v(1em)

    block(
      inset: (left: 2em, right: 2em),
    )[
      Diese Arbeit wurde unter Verwendung von vertraulichen Informationen der Firma „#unternehmen" angefertigt. Diese Arbeit darf Dritten ohne ausdrückliche Zustimmung der Firma „#unternehmen" nicht zugänglich gemacht werden.

      Alle Nutzungen für die Begutachtung durch die Hochschule und von ihr beauftragte Dienstleister sind explizit erlaubt. Zu der Begutachtung gehört auch die Prüfung auf Plagiate und die Verwendung künstlicher Intelligenz unter Nutzung entsprechender IT-Plattformen.
    ]

    pagebreak()
  }

  // Abstract
  if show-abstract and abstract-text != none {
    heading(level: 1, numbering: none)[Abstract]
    abstract-text
    pagebreak()
  }

  // Inhaltsverzeichnis
  heading(level: 1, numbering: none)[Inhaltsverzeichnis]
  outline(
    title: none,
    indent: 1.5em,
    depth: 3,
  )
  pagebreak()

  // Abbildungsverzeichnis
  heading(level: 1, numbering: none)[Abbildungsverzeichnis]
  outline(
    title: none,
    target: figure.where(kind: image),
  )
  pagebreak()

  // Tabellenverzeichnis
  heading(level: 1, numbering: none)[Tabellenverzeichnis]
  outline(
    title: none,
    target: figure.where(kind: table),
  )
  pagebreak()

  // Glossar (mit Abkürzungen)
  if glossary-entries.len() > 0 {
    glossary(title: "Glossar")
    pagebreak()
  }

  // ============= HAUPTTEIL (arabische Seitenzahlen) =============
  set page(
    numbering: "1",
    header: context {
      line(length: 100%, stroke: 0.5pt)
    },
    footer: context {
      line(length: 100%, stroke: 0.5pt)
      v(0.3em)
      align(center)[#counter(page).display("1")]
    },
  )
  counter(page).update(1)

  body
}

// ============= HILFSFUNKTIONEN =============

// Zitat/Dictum (Motto)
#let dictum(author: none, body) = {
  align(right)[
    #block(
      width: 60%,
      inset: 1em,
    )[
      #set text(style: "italic")
      #body
      #if author != none {
        v(0.3em)
        align(right)[--- #author]
      }
    ]
  ]
}

// Todo-Notiz
#let todo(body) = {
  block(
    fill: rgb("#fff3cd"),
    stroke: rgb("#ffc107"),
    inset: 0.8em,
    radius: 4pt,
    width: 100%,
  )[
    #text(weight: "bold")[TODO: ]#body
  ]
}

// Anhang-Kapitel (ohne Nummerierung)
#let anhang(title, body) = {
  heading(level: 1, numbering: none)[#title]
  body
}

// KI-Verzeichnis Tabelle
#let ki-verzeichnis(entries) = {
  if entries.len() == 0 {
    block(inset: (left: 2em))[
      Es wurde keine KI verwendet.
    ]
  } else {
    table(
      columns: (15%, 50%, 25%),
      stroke: (x, y) => if y == 0 { (bottom: 1pt) } else { none },
      inset: 0.7em,
      align: left,
      table.header(
        [*System*], [*Prompt*], [*Verwendung*],
      ),
      ..entries.map(e => (e.system, e.prompt, e.verwendung)).flatten()
    )
  }
}

// Selbstständigkeitserklärung
#let selbststaendigkeitserklaerung(fullname, ort: "Frankfurt") = {
  heading(level: 1, numbering: none)[Selbstständigkeitserklärung]

  [Hiermit bestätige ich, dass ich die vorliegende Arbeit persönlich und selbständig verfasst und keine anderen als die angegebenen Quellen und Hilfsmittel verwendet habe. Alle Stellen, die wörtlich oder sinngemäß anderen Quellen entnommen wurden, sind als solche kenntlich gemacht. Die Zeichnungen, Abbildungen und Tabellen in dieser Arbeit sind von mir selbst erstellt oder wurden mit einem entsprechenden Quellennachweis versehen. Diese Arbeit wurde weder in gleicher noch in ähnlicher Form von mir an anderen Hochschulen zur Erlangung eines akademischen Abschlusses eingereicht.]

  v(2cm)

  grid(
    columns: (auto, 1fr),
    column-gutter: 1em,
    [#ort, den #datetime.today().display("[day].[month].[year]")],
    align(right)[
      #line(length: 6cm, stroke: 0.5pt)
      #v(-0.3em)
      #text(size: 9pt)[#fullname]
    ]
  )
}

// Code-Block mit Syntax-Highlighting
#let code-block(lang: none, body) = {
  block(
    fill: rgb("#f5f5f2"),
    inset: 1em,
    radius: 4pt,
    width: 100%,
  )[
    #set text(font: "DejaVu Sans Mono", size: 9pt)
    #if lang != none {
      raw(body, lang: lang)
    } else {
      raw(body)
    }
  ]
}
