#import "@preview/codelst:2.0.2": *
#import "@preview/acrostiche:0.5.1": *

#let htwgCite(lbl, vgl: true, page: none, pageRange: none) = {
  if pageRange != none {
    if vgl {
      footnote([Vgl. #cite(label(lbl), supplement: [Seite #pageRange], style: "ieee", form: "prose")])
    } else {
      footnote([#cite(label(lbl), supplement: [Seite #pageRange], style: "ieee", form: "prose")])
    }
  } else if page != none {
    if vgl {
      footnote([Vgl. #cite(label(lbl), supplement: [Seite #page], style: "ieee", form: "prose")])
    } else {
      footnote([#cite(label(lbl), supplement: [Seite #page], style: "ieee", form: "prose")])
    }
  } else {
    if (vgl) {
      footnote([Vgl. #cite(label(lbl), style: "ieee", form: "prose")])
    } else {
      footnote([#cite(label(lbl), style: "ieee", form: "prose")])
    }
  }
}

#let std-bibliography = bibliography

#let todo(msg) = {
  [#text(fill: red, weight: "bold", size: 12pt)[TODO #msg]]
}

// Titelseite
#let titlepage(
  authors, title, subtitle, type, 
  language, date, at-university, 
  logo, logo-height, university, 
  department, course, semester, 
  supervisor, heading-font, 
  show-student-id, submission-location
) = {  // Layout beginnen
  page(numbering: none, margin: (left: 2cm, right: 2cm, top: 2cm, bottom: 3.2cm))[
    // Logo
    #align(center, if logo != none {
      set image(height: logo-height)
      logo
    })
    
    #v(2fr)

    #align(center, text(weight: "semibold", font: heading-font, 2.2em, title))
    
    #if subtitle != none {
      v(1em)
      align(center, text(weight: "semibold", font: heading-font, 1.5em, subtitle))
    }
    
    #v(2em)
    #align(center, text(weight: "semibold", font: heading-font, 1.5em, type))
    
    #v(1em)
    #align(center, text(1.2em, [#if (language == "de") {
      [an der #university]
    } else {
      [at the #university]
    }]))

    #v(1em)
    #align(center, text(1.2em, [#if (language == "de") {
      [Fachbereich #department]
    } else {
      [Department #department]
    }]))
    
    #v(2em)
    #align(center, text(1em, if (language == "de") {
      "vorgelegt von"
    } else {
      "submitted by"
    }))
    
    #v(1em)
    #grid(
      columns: 100%,
      rows: auto,
      gutter: 18pt,
      ..authors.map(author => align(center, {
        text(weight: "medium", 1.5em, [#author.name])
      }))
    )
    
    #v(2em)
    #align(center, text(1.2em, date.display(
      "[day].[month].[year]"
    )))

    #v(2fr)

    // Autor-Informationen
    #grid(
      columns: (if (language == "de") {
        200pt
      } else {
        180pt
      }, auto),
      gutter: 11pt,
      
      // Studiengang
      text(weight: "semibold", if (language == "de") {
        [Studiengang:]
      } else {
        [Course of Study:]
      }),
      
      text(course),
      
      // Matrikelnummer
      text(weight: "semibold", if (language == "de") {
        if (show-student-id) { 
          [Matrikelnummer:]
        } else {
          []
        }
      } else {
        if (show-student-id) { 
          [Student ID:]
        } else {
          []
        }
      }),
      
      if (show-student-id) {
        stack(
          dir: ttb,
          for author in authors {
            text([#author.student-id])
            linebreak()
          }
        )
      },
      
      // Semester
      text(weight: "semibold", if (language == "de") {
        [Semester:]
      } else {
        [Semester:]
      }),
      
      text(semester),
      
      // Betreuer
      if (supervisor != "") {
        text(weight: "semibold", if (language == "de") {
          "Betreuer:"
        } else {
          "Supervisor:"
        })
      },
      
      if (supervisor != "") {
        text(supervisor)
      },
      
      // Firmen-Info
      if (not at-university) {
        text(weight: "semibold", if (language == "de") {
          "Unternehmen:"
        } else {
          "Company:"
        })
      },
      
      if (not at-university) {
        stack(
          dir: ttb,
          for author in authors {
            if author.company != none {
              let company-info = [#author.company.name]
              if author.company.address != none {
                company-info += [, #author.company.address]
              }
              text(company-info)
              linebreak()
            }
          }
        )
      }
    )
    
    // Abgabeort und -datum
    #v(2em)
    #align(center, text(weight: "semibold", if (language == "de") {
      [Abgabeort und -datum: #submission-location, #date.display("[day].[month].[year]")]
    } else {
      [Place and Date of Submission: #submission-location, #date.display("[day].[month].[year]")]
    }))
  ]
}

// Eidesstattliche Erklärung
#let declaration-of-authorship(authors, title, date, language) = {
  page(numbering: "I")[
    #v(2em)
    #text(size: 21pt, weight: "bold", if (language == "de") {
      "Eidesstattliche Erklärung"
    } else {
      "Declaration of Authorship"
    })

    #v(1em)
    #if (language == "de") {
      par(justify: true, leading: 1em, [
        Ich versichere hiermit, dass ich die vorliegende Arbeit mit dem Thema:
      ])
      v(1em)
      align(center,
        text(weight: "bold", title)
      )
      v(1em)
      par(justify: true, leading: 1em, [
        selbstständig verfasst und keine anderen als die angegebenen Quellen und Hilfsmittel benutzt habe. Ich versichere zudem, dass die eingereichte elektronische Fassung mit der gedruckten Fassung übereinstimmt.
      ])
    } else {
      par(justify: true, leading: 1em, [
        I hereby declare that I have written this thesis independently and have not used any sources or aids other than those cited in the text. I also confirm that the electronic version submitted is identical to the printed version.
      ])
      v(1em)
      align(center,
        text(weight: "bold", title)
      )
    }

    #v(3em)
    #text([#if (language == "de") {
      [Konstanz, #date.display("[day].[month].[year]")]
    } else {
      [Konstanz, #date.display("[day].[month].[year]")]
    }])

    #for author in authors {
      v(5em)
      line(length: 40%)
      author.name
    }
  ]
}

// Hauptfunktion
#let htwg(
  title: "",
  subtitle: none,
  type: "Projektarbeit",
  authors: (:),
  language: "de",
  at-university: true,
  show-declaration-of-authorship: true,
  show-table-of-contents: true,
  show-acronyms: true,
  show-list-of-figures: true,
  show-list-of-tables: true,
  show-code-snippets: false,
  show-appendix: false,
  show-abstract: true,
  show-preface: false,
  show-header: true,
  show-student-id: true,
  show-symbols: false,
  captions-top: false, // Set to true to position all figure captions at the top
  numbering-style: "1",
  numbering-alignment: center,
  abstract: none,
  appendix: none,
  acronyms: none,
  preface: none,
  symbols: none,
  university: "Hochschule Konstanz Technik, Wirtschaft und Gestaltung",
  department: "",
  course: "",
  semester: "",
  supervisor: "",
  date: datetime.today(),
  submission-location: "Konstanz",
  bibliography: none,
  logo: none,
  logo-height: 2.4cm,
  body,
) = {
  // Dokument-Eigenschaften
  set document(title: title, author: authors.map(author => author.name))
  
  // Akronyme initialisieren
  init-acronyms(acronyms)

  // Schriftarten
  let body-font = "Arial"
  let heading-font = "Arial"
  
  // Abbildungen formatieren
  set figure.caption(separator: [: ], position: if captions-top { top } else { bottom })
  // Schrift für den gesamten Text
  set text(font: body-font, lang: language, 12pt)
  
  // Formatierung für Fußnoten (10pt)
  show footnote.entry: set text(size: 10pt)
    // Überschriften formatieren
  show heading: set text(weight: "semibold", font: heading-font)
    // Überschriftennummerierung
  set heading(numbering: (..nums) => {
    let level = nums.pos().len()
    let pattern = if level == 1 {
      "1"
    } else if level == 2 {
      "1.1"
    } else if level == 3 {
      "1.1.1"
    }
    if pattern != none {
      numbering(pattern, ..nums)
    }
  })
    // Überschriften mit Abstand danach und neue Seite bei Hauptüberschriften
  show heading: it => {
    // Bei Level-1-Überschriften mit Nummerierung eine neue Seite beginnen
    if it.level == 1 and it.numbering != none {
      pagebreak(weak: true)
    }
    
    // Überschrift mit Abstand danach anzeigen
    stack(
      it,
      v(0.8em) // Abstand nach jeder Überschrift
    )
  }
  
  // Links unterstrichen
  show link: it => underline(text(it))
  
  // Formelzeichen-Funktionalität importieren
  import "symbols.typ": format-symbols-table
    // 1. Deckblatt/Außentitel
  titlepage(
    authors, title, subtitle, type, language, 
    date, at-university, logo, logo-height, 
    university, department, course, semester, 
    supervisor, heading-font, show-student-id, submission-location
  )
  
  // Kopfzeile für alle nachfolgenden Seiten - römische Nummerierung für Vorspann
  set page(
    margin: (left: 2cm, right: 2cm, top: 2cm, bottom: 3.2cm),
    header: {
      if (show-header) {
        align(center, text(size: 9pt, title))
        line(length: 100%)
      }
    },
    numbering: "I",
    number-align: numbering-alignment,
  )
  
  // 4. Eidesstattliche Erklärung (Pflicht für Bachelorarbeit)
  if (show-declaration-of-authorship) {
    declaration-of-authorship(authors, title, date, language)
  }
  
  // 5. Ggf. Danksagung
  // Hier könnte in Zukunft eine Danksagung eingefügt werden
  
  // 6. Vorwort
  if (show-preface and preface != none) {
    page(numbering: "I")[
      #heading(level: 1, outlined: false, numbering: none)[#if (language == "de") {
        [Vorwort]
      } else {
        [Preface]
      }]
      #v(2em)
      #preface
    ]
  }
  
  // 7. Kurzzusammenfassung/Abstract
  if (show-abstract and abstract != none) {
    // Deutsch
    if (abstract.de != none) {
      page(numbering: "I")[
        #heading(level: 1, outlined: false, numbering: none)[Kurzzusammenfassung]
        #v(2em)
        #abstract.de
      ]
    }
    
    // Englisch
    if (abstract.en != none) {
      page(numbering: "I")[
        #heading(level: 1, outlined: false, numbering: none)[Abstract]
        #v(2em)
        #abstract.en
      ]
    }
  }

  // Formatierung für Gliederungseinträge
  show outline.entry.where(level: 1): it => {
    v(18pt, weak: true)
    strong(it)
  }
  
  // 8. Gliederung mit Seitenzahlen (Inhaltsverzeichnis)
  if (show-table-of-contents) {
    page(numbering: "I")[
      #heading(level: 1, outlined: false, numbering: none)[#if (language == "de") {
        [Inhalt]
      } else {
        [Table of Contents]
      }]
      #v(2em)
      #outline(title: none, indent: auto)
    ]
  }
  
  // 9. Liste der Formelzeichen und Einheiten
  if (show-symbols and symbols != none) {
    page(numbering: "I")[
      #heading(level: 1, outlined: false, numbering: none)[#if (language == "de") {
        [Liste der Formelzeichen und Einheiten]
      } else {
        [Symbols]
      }]
      #v(2em)
      #format-symbols-table(symbols)
    ]
  }
  
  // 10. Verzeichnis Tabellen, Gleichungen, Bildern, Zitaten
  
  // Abbildungsverzeichnis
  if (show-list-of-figures) {
    context {
      let elems = query(figure.where(kind: image))
      let count = elems.len()
        if (count > 0) {
        page(numbering: "I")[
          #heading(level: 1, outlined: false, numbering: none)[#if (language == "de") {
            [Abbildungsverzeichnis]
          } else {
            [List of Figures]
          }]
          #v(2em)
          #outline(title: none, target: figure.where(kind: image))
        ]
      }
    }
  }
  
  // Tabellenverzeichnis
  if (show-list-of-tables) {
    context {
      let elems = query(figure.where(kind: table))
      let count = elems.len()
        if (count > 0) {
        page(numbering: "I")[
          #heading(level: 1, outlined: false, numbering: none)[#if (language == "de") {
            [Tabellenverzeichnis]
          } else {
            [List of Tables]
          }]
          #v(2em)
          #outline(title: none, target: figure.where(kind: table))
        ]
      }
    }
  }
  
  // Codeverzeichnis (falls vorhanden)
  if (show-code-snippets) {
    context {
      let elems = query(figure.where(kind: raw))
      let count = elems.len()
        if (count > 0) {
        page(numbering: "I")[
          #heading(level: 1, outlined: false, numbering: none)[#if (language == "de") {
            [Codeverzeichnis]
          } else {
            [Code Snippets]
          }]
          #v(2em)
          #outline(title: none, target: figure.where(kind: raw))
        ]
      }
    }
  }
  
  // Abkürzungsverzeichnis
  if (show-acronyms and acronyms != none) {
    page(numbering: "I")[
      #heading(level: 1, outlined: false, numbering: none)[#if (language == "de") {
        [Abkürzungsverzeichnis]
      } else {
        [List of Acronyms]
      }]
      #v(2em)
      
      // Akronyme verarbeiten
      #let keys = acronyms.keys().sorted()
      #for key in keys {
        grid(
          columns: (1fr, 3fr),
          gutter: 1em,
          [*#key*], [#acronyms.at(key)\ ]
        )
      }
    ]
  }
  
  // Textformatierung - Blocksatz mit 20% Durchschuss
  set par(justify: true, leading: 1.2em)
  
  // Arabische Seitennummerierung für den Hauptteil
  set page(
    numbering: numbering-style,
    number-align: numbering-alignment,
    header: {
      if (show-header) {
        align(center, text(size: 9pt, title))
        line(length: 100%)
      }
    }
  )
  counter(page).update(1)
    // Hauptinhalt (Einleitung bis Zusammenfassung)
  body
  
  // 11. Anhang
  if (show-appendix and appendix != none) {
    page[
      #heading(level: 1, outlined: true, numbering: none)[#if (language == "de") {
        [Anhang]
      } else {
        [Appendix]
      }]
      #v(2em)
      #appendix
    ]
  }
  
  // 13. Literaturverzeichnis (immer am Ende)
  if bibliography != none {
    page[
      #heading(level: 1, outlined: true, numbering: none)[#if (language == "de") {
        [Literaturverzeichnis]
      } else {
        [References]
      }]
      #v(2em)
      #set std-bibliography(title: none)
      #bibliography
    ]
  }
}
