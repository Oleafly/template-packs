#import "@preview/glossarium:0.5.10": print-glossary,make-glossary,register-glossary


#let code_identifier =  "code"

#let code(body,caption: "",supplement: "") = {
  figure(
    block(
      width: 100%,
      fill: rgb("#f3f5f7"),
      stroke: 0.8pt + rgb("#77838f"),
      radius: 4pt,
      inset: (x: 12pt, y: 10pt),
      breakable: true,
    )[#body],
    kind: code_identifier,
    caption: caption,
    supplement: supplement
  )
}

#let Template(
  language: "de",
  cover_language: "de",
  title: [Ein Kurzer Title],
  authors: (
    (
      name: "Max Mustermann", 
      email: "mustermannz@stud-provadis-hochschule.de", 
      postal: [Musterstraße 67 \ 08008 Musterstadt],
      matrikel: "A123"
    ),
  ),
  //logo: image("img/t-systems.png", width: 180pt, height: 2.06cm, fit: "contain"),
  abstract: lorem(100),
  preface: lorem(100),
  acknowledgement: "Für meine Brudis",
  document-type: "Bachelor's Thesis",
  reason: [
    To obtain the academic degree \
    ’Bachelor of Science’ B.Sc.
    in the program ’BIN-T’
  ],
  submitted_to: [
    submitted to the Department of Computer Science and Business Information Systems at the \
    Provadis School of International Management and Technology \
    by
  ],
  first_appraiser: "Prof. Dr. Schlag mich tot",
  second_appraiser: "Prof. Dr. ...",
  supervisor: "..",
  bib: "sources.bib",
  appendix: (),
  location: "pi",
  deadline: "xx.xx.20xx",
  declaration_of_independence: true, // 🇺🇸🇺🇸🇺🇸🇺🇸🦅🦅🦅
  confidental_clause: false,
  glossary_entries: (),
  abbreviation_entries: (),
  show_lists_after_content: false,
  ai_entries: (),
  body
  ) = {
  show: make-glossary

  register-glossary(abbreviation_entries)
  register-glossary(glossary_entries)

  if(cover_language == none) {
    cover_language = language
  }
  let translations = json("translations.json").at(language)
  let cover_translations = json("translations.json").at(cover_language)
  // Main Context
let abbreviation-title(entry) = {
  let short = entry.at("short", default: none)
  let long = entry.at("long", default: none)

  if short != none and long != none {
    strong(short) + [ -- ] + long
  } else if short != none {
    strong(short)
  } else {
    long
  }
}

let glossary-page(heading-text, entries, abbreviation-titles: false) = {
  if entries.len() == 0 { return }
  pagebreak()
  heading(heading-text, supplement: [Vorwort], numbering: none, outlined: true)
  if abbreviation-titles {
    print-glossary(
      entries,
      disable-back-references: true,
      user-print-title: abbreviation-title,
    )
  } else {
    print-glossary(
      entries,
      disable-back-references: true,
      user-print-title: abbreviation-title,
    )
  }
}

  let table_of_code() = context {
    if counter(figure.where(kind: code_identifier)).final().at(0) > 0 {
      pagebreak()
      show outline: set heading(outlined: true, supplement: [#translations.vorwort])
      outline(title: translations.codeausschnittverzeichnis, depth: 3, indent: auto, target: figure.where(kind: code_identifier))
    }
  }

  let table_of_tables() = context {
    if counter(figure.where(kind: table)).final().at(0) > 0 {
      pagebreak()
      show outline: set heading(outlined: true, supplement: [#translations.vorwort])
      outline(title: translations.tabellenverzeichnis, depth: 3, indent: auto, target: figure.where(kind: table))
    }
  }

  let table_of_figures() = context {
    if counter(figure.where(kind: image)).final().at(0) > 0 {
      show outline: set heading(outlined: true, supplement: [#translations.vorwort])
      outline(title: translations.abbildungsverzeichnis, depth: 3, indent: auto, target: figure.where(kind: image))
    }
  }

let render_lists() = {
  pagebreak(weak: true)
  table_of_figures()
  glossary-page([Glossary], glossary_entries)
  table_of_tables()
  table_of_code()
  glossary-page(translations.abkuerzungsverzeichnis, abbreviation_entries, abbreviation-titles: true)
}

    set document(author: authors.map(a => a.name), title: title)
    set text(font: "Times New Roman", lang: cover_language, size: 12pt)
    set par(justify: true, leading: 0.65em)
    set heading(numbering: "1.1")
    show heading: set block(above: 1.5em, below: 0.75em)
    show heading.where(level: 1): set text(size: 14pt)
    show heading.where(level: 2): set text(size: 12pt)


    // -------------
    //  COVER PAGE
    // -------------
    set page(
      margin: (
        top: 3cm,
        right: 2cm,
        left: 3cm,
        bottom: 2cm
      )
    )

    place(
      top,
      float: false,
      clearance: 0em,
        grid(
        columns: (1fr,1fr),
        align(left ,image("img/provadis.png", height: 2.06cm)),
        //align(right,logo),
      )
    )

    v(11em)

    align(center, text(1.1em,document-type)) 
    v(1cm)

    set par(leading: 1em)
    align(center,
      text(14pt, weight: 600, title)
    )

    v(2.5cm)

    set par(justify: true, leading: 1.5em)
    align(center, 
      text(1.1em, reason),
    ) 

    v(1cm)
    set par(justify: true, leading: 0.65em)

    align(center, 
      text(1.1em, submitted_to),
    ) 
    
    v(2em)
    set block(spacing: 1em)
    align(
      center,
      grid(
        ..authors.map(author => align(center)[
          #author.name 

          #author.matrikel 

          #author.email 

          #author.postal 

          #{if author.keys().contains("affiliation") {
            author.affiliation
          }}
        ]),
      )
    )

    place(
      bottom + left,
      grid(
        columns: (auto, auto),
        rows: (auto, auto),
        row-gutter: 15pt,
        column-gutter: 15pt,
        [#cover_translations.erstgutachter:],
        [#first_appraiser],
        ..({if second_appraiser != none {
                (
                  [#cover_translations.zweitgutachter:],
                  [#second_appraiser]
                )
          }}
        ),    [#cover_translations.betreuung:],
        [#supervisor],
        [#cover_translations.endeDerBearbeitungsfrist:],
        [#deadline],
        v(1em)
      )
    )
    


  
    // Workaroung um Monate in der ausgewählte Sprache (deutsch,english) anzuzeigen, bis Typst es out-of-the-box unterstüzt
    // text(
    //   [
    //     Frankfurt am Main, #translations.meta.monatZeitPrefix #translations.monate.at(datetime.today().display("[month repr:long]")) #datetime.today().display("[year]")
    //   ]
    // )
    // v(.5fr)
    // 
    
    set text(lang: language)

    if type(acknowledgement) == "content" or type(acknowledgement) == "string" {
      pagebreak()
      place(
        center + horizon,
        text(acknowledgement, style: "italic", size: 14pt)
      )
    }

    counter(page).update(0)


   // --- VORSPANN (Römische Zahlen) ---
  set page(
    margin: (top: 3cm, right: 2cm, left: 3cm, bottom: 2cm),
    numbering: "i",
header: context {
  let here = here()
  // Wir suchen alle Überschriften Ebene 1
  let headings = query(heading.where(level: 1))
  // Wir nehmen die letzte Überschrift, die auf der aktuellen Seite oder davor ist
  let before = headings.filter(it => it.location().page() <= here.page())
  
  let section = if before.len() > 0 { 
    before.last().body 
  } else { 
    "" 
  }

  stack(
    dir: ttb, 
    [#section #h(1fr) #counter(page).display()],
    [#v(4pt)],
    [#line(length: 100%)]
  )
},
  )

  if confidental_clause {
      heading([Sperrvermerk], outlined: false, numbering: none, supplement: [Vorwort])
      v(1em)
      [Die vorliegende Arbeit enthält vertrauliche Informationen. Eine Einsichtnahme in diese Arbeit ist ohne ausdrückliche Genehmigung des Verfassers und des betreuenden Unternehmens nicht gestattet.]
      pagebreak()
  }

  if abstract != none {
      align(center, heading([Abstract], outlined: false, numbering: none, supplement: [Vorwort]))
      v(1em)
      abstract
      pagebreak(weak: true)
  }

  pagebreak(weak: true)
  {
    // Dieses Styling gilt nur für das Inhaltsverzeichnis.
    show outline.entry.where(level: 1): it => { v(12pt, weak: true); strong(it) }
    outline(depth: 3, indent: auto, title: translations.tabellenverzeichnis)
  }

if not show_lists_after_content { render_lists() }

    // Main Body Context
    pagebreak()
counter(page).update(1)
  set page(numbering: "1")
  set heading(supplement: translations.chapter)

      body

      // After Main Body Contexts
 // --- ANHANG / VERZEICHNISSE AM ENDE ---
if show_lists_after_content { render_lists() }

      counter(page).update(1)
      set page(numbering: "I")
      
      if bib != none {
          if type(bib) == "string" { bibliography(bib,style: "ieee") } else { bibliography(..bib) }
      }

      // KI Verzeichnis
      pagebreak()
      heading(translations.ai, numbering: none)
      if ai_entries.len() == 0 { 
        [Es wurden keine KI-gestützten Werkzeuge für diese Arbeit verwendet.] 
      } else { 
        table(
          columns: 3, 
          table.header([*System*], [*Prompt / Input*], [*Usage*]), 
          ..ai_entries.flatten()
        ) 
      }

      // Appendix
      if appendix.len() > 0 {
          pagebreak()
          heading(translations.appendix, outlined: true, numbering: none)
          set heading(numbering: "A")
          counter(heading).update(0)
          {
            show heading: set heading(outlined: false)
            appendix.join(pagebreak())
          }
      }
  

  if declaration_of_independence {
      pagebreak()
      set page(header: none)
      heading([Declaration on my word of honor], outlined: false, numbering: none)
      [I hereby confirm that I have written this thesis personally and independently and have used no sources or aids other than those indicated. All passages taken verbatim or paraphrased from other sources have been marked as such. The drawings, illustrations, and tables in this thesis were created by me or are accompanied by an appropriate source citation. This thesis has not been submitted by me, in the same or a similar form, to any other higher education institution for the purpose of obtaining an academic degree.
       ]
      v(4em)
      line(length: 40%)
      [Signature]
      v(2em)
      [#location, #deadline]
  }
}
