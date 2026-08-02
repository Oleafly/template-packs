#import "@preview/showybox:2.0.4": showybox
#import "@preview/itemize:0.2.0" as el

#let default-config = (
  font: "Open Sans",
  headingFont: "Montserrat",
  mathFont: "STIX Two Math",
  margins: 1.5cm,
  radius: 4pt,
  font_sizes: (
    document_title: 25pt,
    document_subtitle: 20pt,
    text: 12pt,
  ),
)

#let header_seperator(colors) = {
  h(6pt)
  box(
    baseline: -0.8pt,
    rect(fill: colors.primary, radius: 1pt, height: 6.5pt, width: 6.5pt),
  )
  h(6pt)
}

#let header(subject, title, test_name, doc_version, logo_type, config) = [
  #rect(
    stroke: (left: config.margins + config.colors.primary),
    fill: config.colors.primary.lighten(80%),
    width: 100%,
    inset: config.margins,
  )[
    #grid(
      columns: (1fr, auto),
      [
        #text(title, size: config.font_sizes.document_title, weight: "bold")\
        #text(
          test_name,
          size: config.font_sizes.document_subtitle,
          weight: "bold",
        )
        #v(0.3cm)
        #sym.copyright XAB
        #header_seperator(config.colors)
        #datetime.today().display("[year]-[month]-[day]")
        #header_seperator(config.colors)
        #doc_version
      ],
      image(
        "branding/" + subject + "/XAB_" + logo_type + "_" + subject + ".svg",
        height: 3cm,
      ),
    )
  ]
]

#let xab-helper(
  subject,
  test_name,
  title: "HELPER",
  doc_version: "v1.0",
  logo_type: "FULL",
  config: default-config,
  body,
) = {
  let subject_colors = json("colors.json")
  let colors = (
    primary: rgb(subject_colors.at(subject)),
  )

  config.insert("colors", colors)

  // ------------------ BASIC STYLES ------------------

  set document(
    author: "Koalition-XAB",
    date: datetime.today(),
    title: test_name,
  )
  set text(font: config.font, lang: "de", size: config.font_sizes.text)
  show heading: set text(font: config.headingFont)
  show link: set text(fill: blue)
  show link: underline
  set page(margin: 2cm, numbering: "1")
  set heading(numbering: "1.1")
  show math.equation: set text(font: config.mathFont, size: 13pt)
  show math.equation.where(block: false): set text(bottom-edge: "bounds", top-edge: "bounds")

  set par(justify: true)
  show heading: h => block(h, below: 8pt, above: 16pt)
  show heading.where(level: 1): h => block(h, below: 16pt, above: 32pt)
  show heading.where(level: 2): h => block(h, below: 10pt, above: 24pt)
  set terms(separator: [ ... ])
  show list: el.default-enum-list
  show enum: el.default-enum-list

  // ------------------ TABLE STYLES ------------------

  show table: t => {
    if (t.has("label") and t.label == <nostyle>) {
      return t
    }
    let fields = t.fields()
    if ("label" in fields.keys()) {
      let _ = fields.remove("label")
    }
    let chld = fields.remove("children")

    block(
      radius: config.radius,
      clip: true,
      stroke: 1pt,
    )[
      #table(
        ..fields,
        fill: (x, y) => {
          if (calc.odd(y)) {
            config.colors.primary.darken(60%).transparentize(90%)
          } else {
            rgb(0, 0, 0, 0)
          }
        },
        ..chld
      )<nostyle>
    ]
  }

  show <top-header>: t => {
    show table.cell.where(y: 0): h => {
      if (h.has("label") and h.label == <done>) {
        return h
      }
      let fields = h.fields()
      let body = fields.remove("body")
      if ("label" in fields.keys()) {
        let _ = fields.remove("label")
      }

      [#table.cell(..fields, [*#body*])<done>]
    }
    t
  }

  show <side-header>: t => {
    show table.cell.where(x: 0): h => {
      if (h.has("label") and h.label == <done>) {
        return h
      }
      let fields = h.fields()
      let body = fields.remove("body")
      if ("label" in fields.keys()) {
        let _ = fields.remove("label")
      }

      [#table.cell(..fields, [*#body*])<done>]
    }
    t
  }

  show <both-header>: t => {
    show table.cell.where(y: 0): h => {
      if (h.has("label") and h.label == <done>) {
        return h
      }
      let fields = h.fields()
      let body = fields.remove("body")
      if ("label" in fields.keys()) {
        let _ = fields.remove("label")
      }

      [#table.cell(..fields, [*#body*])<done>]
    }
    show table.cell.where(x: 0): h => {
      if (h.has("label") and h.label == <done>) {
        return h
      }
      let fields = h.fields()
      let body = fields.remove("body")
      if ("label" in fields.keys()) {
        let _ = fields.remove("label")
      }

      [#table.cell(..fields, [*#body*])<done>]
    }
    t
  }
  // ------------------ HEADER + BODY ------------------

  [
    #page(margin: 0pt)[
      #header(subject, title, test_name, doc_version, logo_type, config)
      #block(inset: (top: 1cm, rest: config.margins))[
        #outline(depth: 3)
      ]
    ]
    #counter(page).update(1)
    // Left bar
    #set page(background: {
      align(left)[
        #rect(fill: colors.primary, height: 100%, width: .5cm)
      ]
    })
    #body
    #pagebreak()
    = Haftungsausschluss
    Dieses Dokument wird unter Ausschluss jeglicher Gewährleistung zur Verfügung
    gestellt. Die Autoren übernehmen keine Haftung für die inhaltliche Richtigkeit,
    Vollständigkeit oder Aktualität der Informationen. Insbesondere wird keine
    Garantie für das Erreichen bestimmter Noten oder Prüfungsergebnisse übernommen.
    Die Nutzung der Inhalte erfolgt auf eigene Gefahr.

    = Spenden
    Spenden sind sowohl in bar als auch über PayPal möglich. Barspenden werden bevorzugt, da bei PayPal Gebühren anfallen. Für Barspenden wenden Sie sich bitte an:
    - Awan Moeez (BHITS)
    - Fritz Lukas (AHITS)
    #underline(link("https://www.paypal.com/donate/?hosted_button_id=RUZ6T9W2RK968")[Hier]) finden Sie unsere PayPal-Spendenseite. Der zugehörige QR-Code ist im Anschluss abgebildet.
    #image("docs/img/xab-donations-qr-code.png", width: 25%)
  ]
}

// ------------------ COMPONENTS ------------------

#let info = showybox.with(title: "Info", frame: (
  body-color: rgb("#0284c7").lighten(92%),
  title-color: rgb("#0284c7"),
  border-color: rgb("#0284c7"),
))

#let example = showybox.with(
  title: "Beispiel",
  frame: (
    body-color: rgb("#059669").lighten(92%),
    title-color: rgb("#059669"),
    border-color: rgb("#059669"),
  ),
)

#let danger = showybox.with(
  title: "Achtung",
  frame: (
    body-color: rgb("#ea580c").lighten(92%),
    title-color: rgb("#ea580c"),
    border-color: rgb("#ea580c"),
  ),
)
