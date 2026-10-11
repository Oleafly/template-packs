#import "@preview/glossarium:0.5.10": gls, glspl, make-glossary, print-glossary, register-glossary
#import "./glossary.typ": entry-list
#import "@preview/citegeist:0.2.2": load-bibliography
// Couleurs
#let main_color = rgb("#007F7F")

// number_per_chapter pour numéroter les tableaux et images par chapitre ou en global
// display_prefix pour afficher le préfixe (figure, tableau, ...) dans les listes de figures, tableaux, ...
#let project(
  title: "",
  project: "",
  authors: (),
  verifier: (),
  approver: (),
  reference: "",
  number_per_chapter: true,
  display_prefix: false,
  revision: (),
  body,
) = {
  // Document
  set document(author: authors, title: title)
  set text(lang: "fr")

  // Glossaire
  show: make-glossary
  register-glossary(entry-list)
  let print-title(entry) = {
    return entry.short + box(width: 1fr, repeat(gap: 0.15em)[.])
  }
  let print-description(entry) = {
    return entry.description
  }

  // Police
  set text(12pt, font: "Times New Roman")

  // Liste
  set list(marker: (
    text(fill: main_color, size: 14pt)[•],
    text(fill: main_color, size: 14pt)[‣],
    text(fill: main_color, size: 14pt)[-],
  ))

  // Style des légendes
  show figure.where(kind: image): set figure(supplement: [Figure])
  show figure.where(kind: raw): set figure(supplement: [Listing])
  set figure.caption(separator: [ -- ])
  show figure.caption: c => [
    #text(fill: main_color)[
      #context [#smallcaps(c.supplement) #c.counter.display(c.numbering)]]
    #c.separator#c.body]
  // Numéro des tables et images par chapitre
  set figure(numbering: (..num) => numbering("1.1", counter(heading).get().first(), num.pos().first())) if (
    number_per_chapter == true
  )

  // Mise en forme du code
  set raw(align: left)
  show figure.where(
    kind: raw,
  ): it => {
    box(stroke: black, fill: silver, width: 100%, radius: 5pt, inset: 5pt)[#align(left)[#it.body]]
    [#it.caption]
  }

  // Entête
  set heading(numbering: "1.1.1.1.")
  show heading: set text(main_color)
  show heading: it => {
    counter(heading).display(it.numbering)
    h(1em)
    smallcaps(it.body)
    v(-0.5em)
  }
  show heading.where(level: 1): it => {
    // Remise à zéro des compteurs pour les figures
    if number_per_chapter == true {
      counter(figure.where(kind: image)).update(0)
      counter(figure.where(kind: table)).update(0)
    }
    // Affichage du titre
    counter(heading).display(it.numbering)
    h(1em)
    smallcaps(it.body)
    v(-0.5em)
  }
  show heading.where(numbering: none): it => {
    smallcaps(it.body)
    v(0.1em)
  }
  show heading.where(level: 1): set text(1.5em)
  show heading.where(level: 2): set text(1.25em)
  show heading.where(level: 3): set text(1.25em)
  // Ajoute un saut de page avant chaque chapitre, si nécessaire
  show heading.where(depth: 1): body => {
    pagebreak(weak: true)
    body
  }

  // Entête et format de la page
  set page("a4", header: [
    #box[#image("logo.png", height: 1cm)]
    #h(1fr) #box[#project \ #title]
    #line(stroke: 1pt + main_color, length: 100%)
  ])

  // Page de garde
  set page(
    footer: context [
      #line(stroke: 1pt + main_color, length: 100%)
      #set align(center)
      #set text(8pt, fill: gray)
      Societe - SAS au capital de XXX XXX,00 € - 12 avenue nulle part - 38240 MEYLAN, France • \
      http://www.ma_société.com • SIRET : XXX XXX XXX XXXXX • APE : XXXXX \
      Tél : 33 (0)4 76 XX XX XX • Fax : 33 (0)4 76 XX XX XX • E-mail : contact\@ma_société.com
    ],
    margin: (bottom: 3cm),
  )

  v(1fr)
  block(fill: main_color, stroke: black + 1pt, width: 100%, inset: 1.5em, align(alignment.center)[
    #text(smallcaps[#project], fill: white, size: 2em) \ \
    #text(smallcaps[#title], fill: white, size: 2em) \ \
    #text([Réf : #reference], fill: white, size: 1em) ])
  v(1cm)
  table(
    columns: (1fr, 1fr, 1fr),
    inset: 10pt,
    align: center,
    fill: (_x_, y) => if y == 0 { main_color } else { white },
    table.header(
      text(weight: "bold", fill: white, [Rédaction]),
      text(weight: "bold", fill: white, [Vérification]),
      text(weight: "bold", fill: white, [Approbation]),
    ),
    [*#authors* #v(2.5cm)], [*#verifier*], [*#approver*],
  )
  v(1fr)
  pagebreak()

  // Pied de page de l'introduction (historique, table des matières, etc.)
  set page(
    footer: context [
      #line(stroke: 1pt + main_color, length: 100%)
      #box(height: 100%)[Réf : #reference \ Date : #datetime.today().display()]
      #h(1fr) #box(height: 100%)[Page #counter(page).display("i") / #numbering("i", counter(page).at(<end>).at(0))]
    ],
    margin: (bottom: 2.5cm),
    numbering: "i",
  )

  // Retour à 1 du numéro de page (la page de garde n'est pas comptée)
  counter(page).update(1)

  heading("Historique de versions", level: 1, numbering: none)
  table(
    columns: (1fr, 1fr, 3fr),
    inset: 5pt,
    align: (center, center, left),
    fill: (_x_, y) => if y == 0 { main_color } else { white },
    table.header(
      text(weight: "bold", fill: white, [Version]),
      text(weight: "bold", fill: white, [Date]),
      text(weight: "bold", fill: white, [Description]),
    ),
    ..revision
      .map(row => {
        let version = row.at("version", default: "")
        let description = row.at("description", default: "")
        let date = row.at("date", default: "")
        if (type(date) == datetime) {
          date = date.display("[day]/[month]/[year]")
        }

        (version, date, description)
      })
      .flatten(),
  )

  // Style des tables et listes
  show outline: set heading(outlined: true)
  show outline.entry.where(level: 1): set block(above: 1.2em)
  // Format des entrées de listes (avec ou sans le préfixe)
  show outline.entry: it => {
    if display_prefix == true {
      link(it.element.location(), it.indented(it.prefix(), [#smallcaps(it.body())
        #box(width: 1fr, repeat(gap: 0.15em)[.])
        #it.page()]))
    } else {
      if it.prefix() != none {
        if it.prefix().has("children") {
          link(it.element.location(), it.indented(it.prefix().at("children").at(2), [#smallcaps(it.body())
            #box(width: 1fr, repeat(gap: 0.15em)[.])
            #it.page()]))
        } else {
          link(it.element.location(), it.indented(it.prefix(), [#smallcaps(it.body())
            #box(width: 1fr, repeat(gap: 0.15em)[.])
            #it.page()]))
        }
      } else {
        link(it.element.location(), it.indented(it.prefix(), [#smallcaps(it.body())
          #box(width: 1fr, repeat(gap: 0.15em)[.])
          #it.page()]))
      }
    }
  }

  // Table des matières
  outline()

  // Liste des tableau (si le document en contient)
  context [#if counter(figure).final().at(0) != 0 {
    outline(title: [Liste des tableaux], target: figure.where(kind: table))
  }]

  // Liste des images (si le document en contient)
  context [#if counter(figure).final().at(0) != 0 {
    outline(title: [Liste des figures], target: figure.where(kind: image))
  }]

  // Liste des listing (si le document en contient)
  context [#if counter(figure).final().at(0) != 0 {
    outline(title: [Liste des listing], target: figure.where(kind: raw))
  }]

  // Glossaire
  heading("Terminologie et abréviations", level: 1, numbering: none)
  print-glossary(
    entry-list,
    disable-back-references: true,
    user-print-title: print-title,
    user-print-description: print-description,
    description-separator: "",
  )

  // Bibliographie
  // Chargement de la bibliographie sans affichage
  show bibliography: none
  bibliography("biblio.bib")
  // Chargement de la bibliographie pour affichage
  let bibtex_string = read("biblio.bib")
  let bib = load-bibliography(bibtex_string)

  heading("Documents de référence", level: 1, numbering: none)
  [Les documents suivants ont servi de référence à l'élaboration du présent document :]
  context {
    let cite_ref_list = query(ref.where(element: none)).dedup()
    table(
      columns: (1fr, 10fr, 2fr),
      inset: 5pt,
      align: (center + horizon, left + horizon, center + horizon),
      fill: (_x_, y) => if y == 0 { main_color } else { white },
      table.header(
        text(weight: "bold", fill: white, [Réf.]),
        text(weight: "bold", fill: white, [Nom du document]),
        text(weight: "bold", fill: white, [Version]),
      ),
      ..cite_ref_list
        .map(row => {
          let name = str(row.target)
          let title = bib.at(name).fields.title
          let version = bib.at(name).fields.version
          //let version = row.at("version")
          (row, title, version)
        })
        .flatten(),
    )
  }

  // Marqueur caché pour avoir le nombre de page de l'introduction
  hide[a <end>]

  // Pied de page du corps du document
  set page(
    footer: context [
      #line(stroke: 1pt + main_color, length: 100%)
      #box(height: 100%)[Réf : #reference \ Date : #datetime.today().display()]
      #h(1fr) #box(height: 100%)[Page #counter(page).display("1 / 1", both: true)]
    ],
    numbering: "1",
  )
  // Retour à 1 du numéro de page
  counter(page).update(1)

  // Corps du document
  pagebreak()
  body
}

// Passage dans la section annexe
#let appendix(
  number_per_chapter: true,
  body,
) = {
  // Page de garde des annexes
  pagebreak()
  align(center + horizon)[#text(fill: main_color, size: 40pt)[#smallcaps()[Annexes]]]
  pagebreak()

  // Change le style de numérotation
  set heading(numbering: "A.1.1.1.")
  counter(heading).update(0)
  set figure(numbering: (..num) => numbering("A.1", counter(heading).get().first(), num.pos().first())) if (
    number_per_chapter == true
  )

  body
}
