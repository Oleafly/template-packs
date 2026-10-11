#import "@preview/acrostiche:0.7.0": *

#let ai_template(
  title: "Thesis title",
  type: "Seminar thesis/Bachelor thesis/Master thesis",
  first_name: "First name",
  last_name: "Last name",
  address: "Street no., PLZ city",
  study_program: "Bachelor/Master Wirtschaftsinformatik",
  student_number: "1234567",
  reviewer_1: "Prof. Dr. Mario Nadj",
  reviewer_2: "N.N. (only for Bachelor/Master thesis)",
  date: "TT.MM.JJJJ",
  semester: "Summer/Winter semester 2025, 4th Semester",
  acronyms: (
    "BPM": ("Business Process Management",),
    "RPA": ("Robotic Process Automation",),
  ),
  omit_lof: false,
  omit_lot: false,
  omit_loa: false,
  table_full_width: false,
  doc,
) = {
  let margins = (left: 3cm, right: 2cm, top: 2.75cm, bottom: 2cm)

  set text(font: "Verdana")
  set heading(numbering: "1.1")
  set outline(indent: n => {
    if n == 0 or n == 1 {
      return 0em
    } else {
      return n * 1em
    }
  })
  set list(marker: (sym.bullet, sym.bullet.stroked, sym.square.filled.tiny), indent: 16pt)

  set page(
    margin: margins,
    header: box(stroke: (bottom: 0.5pt + black), width: 1fr, inset: (bottom: 2pt), {
      set text(size: 8pt)
      title
      h(1fr)
      context counter(page).display()
      let num = context counter(heading).at(here())
    }),
    footer: none,
  )

  // Header image
  place(top + left, dx: -margins.left + 0.4cm, dy: -margins.top + 0.5cm, image(
    "figures/ude_header.png",
    width: 100% + margins.left + margins.right - 2 * 0.4cm,
  ))

  // Title page content
  [
    #set par(leading: 0.65em * 0.8)
    #set align(center)

    // Header text
    #v(8.5em)
    #set text(size: 28pt)
    #text(weight: "bold", title) \
    #text(size: 12pt, type)

    // Paper information
    #v(1em)
    #set text(size: 10pt)
    #table(
      columns: (1fr, 1fr),
      align: left,
      stroke: none,
      inset: 9pt,
      "Submitted by:", [#first_name #last_name],
      "Address:", address,
      "Study program:", study_program,
      "Matriculation number:", student_number,
      "First reviewer:", reviewer_1,
      ..if reviewer_2 != none { ("Second reviewer:", reviewer_2) },
      "Delivery date:", date,
      "Semester of study:", semester,
    )

    #v(4.5em)
    University of Duisburg-Essen \ \
    Chair of Information Systems and Artificial Intelligence in Marketing \ \
    Faculty of Computer Science
  ]

  // Footer image
  place(bottom + left, dx: -margins.left + 0.4cm, dy: margins.bottom - 1cm, image(
    "figures/ude_footer.png",
    width: 100% + margins.left + margins.right - 2 * 0.4cm,
  ))

  show figure.caption: set text(size: 8pt, weight: "bold")
  show figure.where(kind: table): set figure.caption(position: top)
  set table(inset: 12pt, stroke: 0.5pt + black)
  show table.cell.where(y: 0): set table.cell(inset: 0pt)

  let table_pad = if table_full_width { 0pt } else { 0.8cm }

  show table: it => {
    set par(justify: false)
    pad(left: table_pad, right: table_pad, it)
  }

  show outline.entry.where(level: 1): it => {
    block(above: 2em, it)
  }

  show heading: it => {
    if (it.level == 1) {
      pagebreak()
    }

    set text(size: 18pt - (it.level * 2pt), weight: "bold")

    block(above: 1.5em, below: 1.5em, {
      if (it.numbering != none) {
        counter(heading).display(it.numbering)
        h(0.8em)
      }
      it.body
    })
  }

  counter(page).update(1)
  set page(numbering: "i")

  set text(font: "Verdana", size: 10pt)
  set par(leading: 0.65em * 1.65, spacing: 1.2em * 1.5, justify: true)

  {
    set text(size: 9pt)
    show outline.entry.where(level: 1): it => {
      set text(weight: "bold")
      block(above: 1.6em, it)
    }
    outline(title: "Table of Contents")
  }

  if not omit_lof {
    heading(numbering: none, "List of Figures")

    outline(
      title: none,
      target: figure.where(kind: image),
    )
  }

  if not omit_lot {
    heading(numbering: none, "List of Tables")

    outline(
      title: none,
      target: figure.where(kind: table),
    )
  }

  if not omit_loa {
    if acronyms != none {
      heading(numbering: none, "List of Abbreviations")

      init-acronyms(acronyms)
      print-index(title: "", row-gutter: 1.2em, delimiter: "")
    }
  } else {
    init-acronyms(acronyms)
  }

  counter(page).update(0)
  set page(numbering: "1")

  doc
}

// Display the "Eidesstattliche Versicherung".
//
// - hilfsmittel_date (str): Date of the E-Mail "Liste erlaubter Hilfsmittel"
#let versicherung(loc_date, hilfsmittel_date) = [
  #set par(leading: 0.65em * 0.9, spacing: 1.2em * 0.9, justify: true)
  #set text(lang: "de")

  #pagebreak()

  #align(right, image("figures/declaration-logo.png"))
  #v(1.5em)
  #align(center, text(weight: "bold", underline("Eidesstattliche Versicherung")))
  #v(1.5em)

  Hiermit versichere ich an Eides Statt, dass ich diese Arbeit bzw. im Fall einer Gruppenarbeit den von mir entsprechend gekennzeichneten Anteil an der Arbeit selbständig verfasst habe. Ich habe keine unzulässige Hilfe Dritter in Anspruch genommen. Zudem habe ich keine anderen als die angegebenen Quellen und Hilfsmittel benutzt und alle Ausführungen (insbesondere Zitate), die anderen Quellen wörtlich oder sinngemäß entnommen wurden, kenntlich gemacht. Die Liste zugelassener Hilfsmittel vom #hilfsmittel_date ist mir ausdrücklich bekannt.

  Ich versichere, dass die von mir in elektronischer Form eingereichte Version dieser Arbeit mit den eingereichten gedruckten Exemplaren übereinstimmt.

  Mir ist bekannt, dass im Falle eines Täuschungsversuches die betreffende Leistung als mit "nicht ausreichend" (5,0) bewertet gilt. Zudem kann ein Täuschungsversuch als Ordnungswidrigkeit mit einer Geldbuße von bis zu 50.000 Euro geahndet werden. Im Falle eines mehrfachen oder sonstigen schwerwiegenden Täuschungsversuchs kann ich zudem exmatrikuliert werden.

  Mir ist bekannt, dass sich die Prüferin oder der Prüfer bzw. der Prüfungsausschuss zur Feststellung der Täuschung des Einsatzes einer entsprechenden Software oder sonstiger elektronischer Hilfsmittel bedienen kann.

  Ich versichere an Eides Statt, dass ich die vorbenannten Angaben nach bestem Wissen und Gewissen gemacht habe und dass die Angaben der Wahrheit entsprechen und ich nichts verschwiegen habe.

  Die Strafbarkeit einer falschen eidesstattlichen Versicherung ist mir bekannt, insbesondere die Strafandrohung gemäß §§ 156, 161 StGB, auf welche ich konkret hingewiesen wurde.

  #v(1.5em)

  #block(stroke: 1pt + black, inset: 0.5em)[
    #set text(size: 9pt)

    #v(1em)
    #align(center, text(weight: "bold", "§ 156 Falsche Versicherung an Eides Statt"))

    Wer vor einer zur Abnahme einer Versicherung an Eides Statt zuständigen Behörde eine solche Versicherung falsch abgibt oder unter Berufung auf eine solche Versicherung falsch aussagt, wird mit Freiheitsstrafe bis zu drei Jahren oder mit Geldstrafe bestraft.

    #align(center, text(
      weight: "bold",
      "§ 161 Fahrlässiger Falscheid; fahrlässige falsche Versicherung an Eides Statt",
    ))

    (1) Wenn eine der in den §§ 154 bis 156 bezeichneten Handlungen aus Fahrlässigkeit begangen worden ist, so tritt Freiheitsstrafe bis zu einem Jahr oder Geldstrafe ein.

    (2) Straflosigkeit tritt ein, wenn der Täter die falsche Angabe rechtzeitig berichtigt. Die Vorschriften des § 158 Abs. 2 und 3 gelten entsprechend.

    #v(1em)
  ]

  #v(4.5em)

  #block(width: 50%, {
    text(underline(repeat(sym.space)))
    par(text(size: 9pt, [Ort, Datum #h(3em) Unterschrift]))
  })
]
