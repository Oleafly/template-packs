#let hso-thesis(
  title: none,
  author: none,
  tutor-hso: "",
  is-master: false,
  tutor-company: none,
  date: datetime(day: 1, month: 11, year: 2003),
  program: content,
  company: none,
  diploma: "Bachelor of Engineering (B. Eng)",
  lang: "de",
  public: false,
  before: content,
  doc: content,
  after: content,
) = {
  assert(lang == "de" or lang == "en", message: "Language must be de or en")

  let byLang = (de, en) => if lang == "de" { de } else { en }

  set page(
    paper: "a4",
    margin: (
      inside: 3cm,
      outside: 2.5cm,
      top: 2.5cm,
      bottom: 2.5cm,
    ),
    binding: left,
  )

  set document(
    title: title,
    author: author,
    date: date,
  )
  set text(size: 12pt)
  set par(leading: 0.8em, spacing: 1.8em)

  align(top + center, image("./assets/hso.png", width: 6cm))

  // Title
  place(top + center, dy: 62mm, text(size: 18pt, [*#title*]))
  // Author
  place(
    top + center,
    dy: 98mm,
    author,
  )

  place(top + center, dy: 110mm, [
    #set par(spacing: 0.4cm)
    #text(size: 14pt, if is-master {
      byLang([*MASTERARBEIT*], [*MASTER THESIS*])
    } else {
      byLang([*BACHELORARBEIT*], [*BACHELOR THESIS*])
    })

    #byLang([zur Erlangung des akademischen Grades], [for the acquisition of the academic degree])
    #diploma
  ])

  // program
  place(top + center, dy: 145mm, [#byLang([Studiengang], [Course of Studies: ]) #program

    #byLang(
      [Fakultät Elektrotechnik, Medizintechnik und Informationstechnik],
      [Department of Electrical Engineering, Medical Engineering and Computer Science],
    )

    #byLang([Hochschule für Technik, Wirtschaft und Medien Offenburg], [Offenburg University of Applied Sciences])])

  // Date
  place(top + center, dy: 170mm, date.display("[day].[month].[year]"))

  // Company
  place(top + center, dy: 195mm, byLang([Durchgeführt bei der Firma #company], [Conducted at the company #company]))

  // tutors
  place(top + center, dy: 220mm, [#byLang([Betreuer], [Tutors])

    #tutor-hso, #byLang([Hochschule Offenburg], [Offenburg University])
    #parbreak()
    #if tutor-company != none {
      [#tutor-company, #company]
    }])


  pagebreak()

  set par(justify: true)

  heading(outlined: false, byLang([Eidesstattliche Erklärung], [Statutory Declaration]))
  v(0.5cm)

  byLang(
    [Ich versichere hiermit, dass ich die vorliegende Arbeit selbständig und ohne Benutzung anderer als der
      angegebenen Quellen und Hilfsmittel verfasst habe. Wörtlich übernommene Sätze oder Satzteile sind als
      Zitat belegt, andere Anlehnungen, hinsichtlich Aussage und Umfang, unter Quellenangabe kenntlich
      gemacht. Die Arbeit hat in gleicher oder ähnlicher Form noch keiner Prüfungsbehörde vorgelegen und ist
      nicht veröffentlicht. Sie wurde nicht, auch nicht auszugsweise, für eine andere Prüfungs- oder
      Studienleistung verwendet. Zudem versichere ich, dass die von mir abgegebenen schriftlichen
      (gebundenen) Versionen der vorliegenden Arbeit mit der abgegebenen elektronischen Version auf einem
      Datenträger inhaltlich übereinstimmen.],
    [I herewith declare that I have composed the present thesis myself and without use of any other than the
      cited sources and aids. Sentences or parts of sentences quoted literally are marked as such; other references
      with regard to the statement and scope are indicated by full details of the publications concerned. The thesis
      in the same or similar form has not been submitted to any examination body and has not been published.
      This thesis was not yet, even in part, used in another examination or as a course performance. Furthermore
      I declare that the submitted written (bound) copies of the present thesis and the version submitted on a
      data carrier are consistent with each other in contents],
  )
  parbreak()
  [Offenburg, ]
  date.display("[day].[month].[year]")
  parbreak()
  author

  if not public {
    set align(bottom)
    set text(rgb(255, 0, 0))
    heading(outlined: false, byLang([Sperrvermerk], [Confidentiality Notice]))
    v(0.5cm)
    byLang(
      [
        Die vorliegende Thesis mit dem Titel

        #align(center, pad(
          x: 2cm,
          title,
        ))

        beinhaltet vertrauliche Informationen und interne Daten des folgenden Unternehmens:
        #align(center, company)
        Sie darf aus diesem Grund nur zu Prüfzwecken verwendet und ohne ausdrückliche Genehmigung durch die #company weder Dritten zugänglich
        gemacht, noch ganz oder in Auszügen veröffentlicht werden. Die Sperrfrist endet 5 Jahre nach dem Einreichen der Arbeit bei der Hochschule Offenburg.
        Unbeschadet hiervon bleibt die Weitergabe der Arbeit und Einsicht in die Arbeit an die mit der Prüfung befassten Mitarbeiter der Hochschule und Prüfer
        möglich, die ihrerseits zur Geheimhaltung verpflichtet sind, sowie die Verwendung der Arbeit in eventuellen prüfungsrechtlichen Rechtsschutzverfahren nach
        Maßgabe der geltenden verwaltungsprozessualen Regeln.

      ],
      [The present thesis with the title:

        #align(center, pad(
          x: 2cm,
          title,
        ))

        contains confidential information and internal data of the following company:
        #align(center, company)
        For this reason, it may only be used for examination purposes and may not be made accessible to third parties or published in whole or in part without the express authorisation of the company. The restriction period ends 5 years after submission of the thesis to Offenburg University of Applied Sciences. The thesis may be passed on to and inspected by the university staff and examiners involved in the examination, who are obliged to maintain confidentiality, and the thesis may be used in any legal defence proceedings under examination law in accordance with the applicable administrative procedural rules.

      ],
    )
  }
  pagebreak()

  set heading(outlined: false)
  before

  outline(
    title: byLang([Inhaltsverzeichnis], [Table of contents]),
    depth: 4,
    indent: 2.5em,
  )
  pagebreak()

  counter(page).update(1)

  set page(numbering: "1")
  set heading(numbering: "1.1   ", outlined: true)
  set figure(gap: 1em)
  set math.equation(numbering: (..num) => numbering("(1.1)", counter(heading).get().first(), num.pos().first()))
  set figure(numbering: (..num) => numbering("1-1", counter(heading).get().first(), num.pos().first()))

  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: table): set block(below: 2em, above: 3em)

  show figure.where(kind: image): set block(below: 3em, above: 3em)

  show heading: set block(below: 1em, above: 2em)
  show heading.where(level: 1): it => {
    counter(math.equation).update(0)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)
    it
  }

  doc

  set heading(numbering: none)

  outline(title: text(heading(outlined: true, [Table of figures]), size: 0.7143em), target: figure.where(kind: image))
  pagebreak()
  outline(title: text(heading(outlined: true, [Table of tables]), size: 0.7143em), target: figure.where(kind: table))
  pagebreak()
  after
}
