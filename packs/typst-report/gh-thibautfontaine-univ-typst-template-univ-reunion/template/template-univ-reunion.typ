// Template Université de La Réunion
// Inspiré de silky-report-insa
// https://typst.app/universe/package/silky-report-insa

// =============================================================================
// COULEURS ET CONSTANTES
// =============================================================================

#let univ-bleu-outremer = rgb("#203363")  // Couleur principale charte graphique
#let univ-bleu-clair = rgb("#4a6da7")     // Variante plus claire
#let univ-gris = rgb("#6b7280")           // Gris pour texte secondaire

// =============================================================================
// FONCTIONS UTILITAIRES
// =============================================================================

/// Traduit un texte selon la langue
#let univ-translate(lang, fr: none, en: none) = {
  if lang == "fr" { fr } else { en }
}

// =============================================================================
// PAGE DE COUVERTURE
// =============================================================================

/// Crée une page de couverture stylisée
/// - logo-univ: Chemin vers le logo de l'université
/// - logo-composante: Chemin vers le logo de la composante (facultatif)
/// - titre: Titre principal du document
/// - sous-titre: Sous-titre (facultatif)
/// - auteurs: Liste des auteurs
/// - date: Date du document
/// - formation: Nom de la formation/département
/// - annee-universitaire: Année universitaire (ex: "2024-2025")
/// - type-document: Type de document (ex: "Rapport de stage", "Mémoire")
/// - encadrants: Liste des encadrants (facultatif)
/// - style: Style de couverture ("moderne", "classique", "minimaliste")
#let page-couverture(
  logo-univ: none,
  logo-composante: none,
  titre: "",
  sous-titre: none,
  auteurs: (),
  date: none,
  formation: none,
  annee-universitaire: none,
  type-document: none,
  encadrants: none,
  style: "moderne",
) = {
  set page(margin: 0pt)

  if style == "moderne" {
    // Style moderne avec bandeau coloré
    block(
      width: 100%,
      height: 100%,
      fill: white,
      {
        // Bandeau supérieur coloré
        place(
          top + left,
          block(
            width: 100%,
            height: 12%,
            fill: univ-bleu-outremer,
          )
        )

        // Logo université (dans le bandeau) - encadré arrondi
        if logo-univ != none {
          place(
            top + left,
            dx: 40pt,
            dy: 15pt,
            block(
              fill: white,
              radius: 8pt,
              inset: 8pt,
              image(logo-univ, height: 50pt)
            )
          )
        }

        // Logo composante (à droite du bandeau) - encadré arrondi
        if logo-composante != none {
          place(
            top + right,
            dx: -40pt,
            dy: 15pt,
            block(
              fill: white,
              radius: 8pt,
              inset: 8pt,
              image(logo-composante, height: 50pt)
            )
          )
        }

        // Contenu principal centré
        place(
          center + horizon,
          dy: -20pt,
          block(
            width: 80%,
            {
              // Type de document
              if type-document != none {
                align(center)[
                  #text(
                    size: 14pt,
                    fill: univ-bleu-outremer,
                    weight: "medium",
                    smallcaps(type-document)
                  )
                ]
                v(20pt)
              }

              // Titre principal
              align(center)[
                #text(
                  font: ("Playfair Display", "Libertinus Serif"),
                  size: 28pt,
                  fill: univ-bleu-outremer,
                  weight: "bold",
                  titre
                )
              ]

              // Sous-titre
              if sous-titre != none {
                v(12pt)
                align(center)[
                  #text(
                    size: 16pt,
                    fill: univ-gris,
                    style: "italic",
                    sous-titre
                  )
                ]
              }

              v(40pt)

              // Ligne décorative
              align(center)[
                #line(length: 40%, stroke: 2pt + univ-bleu-outremer)
              ]

              v(40pt)

              // Auteurs
              if auteurs.len() > 0 {
                align(center)[
                  #text(size: 12pt, fill: univ-gris)[Présenté par]
                ]
                v(8pt)
                for auteur in auteurs {
                  align(center)[
                    #text(size: 14pt, weight: "medium", auteur)
                  ]
                }
              }

              // Encadrants
              if encadrants != none and encadrants.len() > 0 {
                v(24pt)
                align(center)[
                  #text(size: 12pt, fill: univ-gris)[Encadré par]
                ]
                v(8pt)
                for encadrant in encadrants {
                  align(center)[
                    #text(size: 14pt, encadrant)
                  ]
                }
              }
            }
          )
        )

        // Bandeau inférieur avec informations
        place(
          bottom + left,
          block(
            width: 100%,
            height: 15%,
            fill: univ-bleu-outremer.lighten(95%),
            {
              place(
                center + horizon,
                {
                  set text(size: 11pt)

                  if formation != none {
                    text(weight: "medium", formation)
                    linebreak()
                  }

                  if annee-universitaire != none {
                    text(fill: univ-gris)[Année universitaire #annee-universitaire]
                    linebreak()
                  }

                  if date != none {
                    text(fill: univ-gris, date)
                  }
                }
              )
            }
          )
        )
      }
    )
  } else if style == "classique" {
    // Style classique sobre
    block(
      width: 100%,
      height: 100%,
      inset: 60pt,
      {
        // Logos en haut
        grid(
          columns: (1fr, 1fr),
          align: (left, right),
          if logo-univ != none {
            image(logo-univ, height: 55pt)
          },
          if logo-composante != none {
            image(logo-composante, height: 55pt)
          }
        )

        v(1fr)

        // Type de document
        if type-document != none {
          align(center)[
            #text(size: 14pt, fill: univ-bleu-outremer, smallcaps(type-document))
          ]
          v(20pt)
        }

        // Titre
        align(center)[
          #block(
            width: 100%,
            stroke: (y: 2pt + univ-bleu-outremer),
            inset: 20pt,
            text(
              font: ("Playfair Display", "Libertinus Serif"),
              size: 24pt,
              weight: "bold",
              fill: univ-bleu-outremer,
              titre
            )
          )
        ]

        // Sous-titre
        if sous-titre != none {
          v(16pt)
          align(center)[
            #text(size: 14pt, style: "italic", sous-titre)
          ]
        }

        v(1fr)

        // Auteurs
        if auteurs.len() > 0 {
          align(center)[
            #text(size: 11pt, fill: univ-gris)[Auteur(s)]
            #v(4pt)
            #for auteur in auteurs {
              text(size: 13pt, weight: "medium", auteur)
              linebreak()
            }
          ]
        }

        // Encadrants
        if encadrants != none and encadrants.len() > 0 {
          v(20pt)
          align(center)[
            #text(size: 11pt, fill: univ-gris)[Encadrant(s)]
            #v(4pt)
            #for encadrant in encadrants {
              text(size: 13pt, encadrant)
              linebreak()
            }
          ]
        }

        v(1fr)

        // Formation et date
        align(center)[
          #if formation != none {
            text(size: 12pt, weight: "medium", formation)
            linebreak()
          }
          #if annee-universitaire != none {
            text(size: 11pt, fill: univ-gris)[Année universitaire #annee-universitaire]
            linebreak()
          }
          #if date != none {
            text(size: 11pt, fill: univ-gris, date)
          }
        ]
      }
    )
  } else {
    // Style minimaliste
    block(
      width: 100%,
      height: 100%,
      inset: 60pt,
      {
        // Logos en header
        grid(
          columns: (1fr, 1fr),
          align: (left, right),
          if logo-univ != none {
            image(logo-univ, height: 50pt)
          },
          if logo-composante != none {
            image(logo-composante, height: 50pt)
          }
        )

        v(1fr)

        // Titre
        text(
          font: ("Playfair Display", "Libertinus Serif"),
          size: 32pt,
          weight: "bold",
          fill: univ-bleu-outremer,
          titre
        )

        if sous-titre != none {
          v(12pt)
          text(size: 16pt, fill: univ-gris, sous-titre)
        }

        v(40pt)

        for auteur in auteurs {
          text(size: 14pt, auteur)
          linebreak()
        }

        v(1fr)

        text(size: 11pt, fill: univ-gris)[
          #if formation != none { formation; linebreak() }
          #if date != none { date }
        ]
      }
    )
  }

  pagebreak()
}

// =============================================================================
// DOCUMENT PRINCIPAL
// =============================================================================

/// Configure le document avec le style Université de La Réunion
/// - titre: Titre du document (pour les métadonnées PDF)
/// - auteurs: Liste des auteurs
/// - date: Date du document
/// - lang: Langue du document ("fr" ou "en")
/// - resume: Résumé du document (facultatif)
/// - mots-cles: Mots-clés (facultatif)
/// - abstract: Abstract en anglais (facultatif)
/// - keywords: Keywords en anglais (facultatif)
/// - bibliographie: Chemin vers le fichier de bibliographie (facultatif)
/// - toc: Afficher la table des matières (défaut: true)
/// - body: Contenu du document
#let univ-report(
  titre: "",
  auteurs: (),
  date: none,
  lang: "fr",
  resume: none,
  mots-cles: none,
  abstract: none,
  keywords: none,
  bibliographie: none,
  toc: true,
  body
) = {
  // Configuration du document
  set document(
    title: titre,
    author: auteurs,
    date: if date != none { auto } else { none },
  )

  // Police principale : Raleway (sans-serif) pour le corps du texte
  set text(
    font: ("Raleway", "Libertinus Serif"),
    size: 11pt,
    lang: lang,
  )

  set page(
    paper: "a4",
    margin: (
      top: 2.5cm,
      bottom: 2.5cm,
      left: 2.5cm,
      right: 2.5cm,
    ),
    header: context {
      if counter(page).get().first() > 1 {
        set text(size: 9pt, fill: univ-gris)
        grid(
          columns: (1fr, 1fr),
          align: (left, right),
          titre,
          counter(page).display("1")
        )
        v(-5pt)
        line(length: 100%, stroke: 0.5pt + univ-gris.lighten(50%))
      }
    },
    footer: context {
      if counter(page).get().first() > 1 {
        line(length: 100%, stroke: 0.5pt + univ-gris.lighten(50%))
        v(-5pt)
        set text(size: 9pt, fill: univ-gris)
        grid(
          columns: (1fr, 1fr),
          align: (left, right),
          // Auteur(s)
          if auteurs.len() > 0 {
            auteurs.join(", ")
          },
          // Date
          if date != none {
            if type(date) == datetime {
              date.display("[day]/[month]/[year]")
            } else {
              date
            }
          }
        )
      }
    },
  )

  // Style des titres
  set heading(numbering: "1.1.")

  // Police des titres : Playfair Display (serif élégante) avec fallbacks
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    v(20pt)
    block(
      width: 100%,
      {
        text(
          font: ("Playfair Display", "Libertinus Serif"),
          size: 22pt,
          weight: "bold",
          fill: univ-bleu-outremer,
          {
            if it.numbering != none {
              counter(heading).display()
              h(12pt)
            }
            it.body
          }
        )
        v(8pt)
        line(length: 100%, stroke: 2pt + univ-bleu-outremer)
      }
    )
    v(16pt)
  }

  show heading.where(level: 2): it => {
    v(16pt)
    text(
      font: ("Playfair Display", "Libertinus Serif"),
      size: 16pt,
      weight: "bold",
      fill: univ-bleu-outremer.lighten(20%),
      {
        if it.numbering != none {
          counter(heading).display()
          h(8pt)
        }
        it.body
      }
    )
    v(8pt)
  }

  show heading.where(level: 3): it => {
    v(12pt)
    text(
      font: ("Playfair Display", "Libertinus Serif"),
      size: 13pt,
      weight: "semibold",
      fill: univ-bleu-clair,
      {
        if it.numbering != none {
          counter(heading).display()
          h(6pt)
        }
        it.body
      }
    )
    v(6pt)
  }

  // Style des liens
  show link: it => {
    text(fill: univ-bleu-outremer, it)
  }

  // Style des blocs de code
  show raw.where(block: true): it => {
    block(
      width: 100%,
      fill: univ-bleu-outremer.lighten(95%),
      stroke: 1pt + univ-bleu-outremer.lighten(70%),
      radius: 4pt,
      inset: 10pt,
      it
    )
  }

  show raw.where(block: false): it => {
    box(
      fill: univ-bleu-outremer.lighten(90%),
      outset: 2pt,
      radius: 2pt,
      it
    )
  }

  // Style des figures
  show figure: it => {
    set align(center)
    v(12pt)
    it.body
    v(8pt)
    text(size: 10pt)[
      #text(weight: "bold", fill: univ-bleu-outremer)[
        #it.supplement #context it.counter.display(it.numbering)
      ]
      #if it.caption != none [ -- #it.caption.body]
    ]
    v(12pt)
  }

  // Style des tableaux
  set table(
    stroke: 0.5pt + univ-gris.lighten(50%),
    inset: 8pt,
  )

  show table.cell.where(y: 0): set text(weight: "bold", fill: white)
  show table.cell.where(y: 0): set table.cell(fill: univ-bleu-outremer)

  // Résumé / Abstract
  if resume != none or abstract != none {
    if resume != none {
      block(
        width: 100%,
        stroke: (left: 3pt + univ-bleu-outremer),
        inset: (left: 15pt, y: 10pt),
        {
          text(weight: "bold", size: 12pt, fill: univ-bleu-outremer)[Résumé]
          v(8pt)
          text(size: 10pt, resume)
          if mots-cles != none {
            v(8pt)
            text(weight: "bold", size: 10pt)[Mots-clés : ]
            text(size: 10pt, style: "italic", mots-cles)
          }
        }
      )
      v(16pt)
    }

    if abstract != none {
      block(
        width: 100%,
        stroke: (left: 3pt + univ-bleu-clair),
        inset: (left: 15pt, y: 10pt),
        {
          text(weight: "bold", size: 12pt, fill: univ-bleu-clair)[Abstract]
          v(8pt)
          text(size: 10pt, abstract)
          if keywords != none {
            v(8pt)
            text(weight: "bold", size: 10pt)[Keywords: ]
            text(size: 10pt, style: "italic", keywords)
          }
        }
      )
    }

    pagebreak()
  }

  // Table des matières
  if toc {
    outline(
      title: univ-translate(lang, fr: "Table des matières", en: "Table of Contents"),
      indent: auto,
      depth: 3,
    )
    pagebreak()
  }

  // Contenu principal
  body

  // Bibliographie
  if bibliographie != none {
    pagebreak()
    bibliography(bibliographie, style: "ieee")
  }
}

// =============================================================================
// COMPOSANTS ADDITIONNELS
// =============================================================================

/// Crée une boîte d'information
#let info-box(title: none, content, type: "info") = {
  let (bg-color, border-color, icon) = if type == "warning" {
    (rgb("#fef3c7"), rgb("#f59e0b"), "⚠️")
  } else if type == "danger" {
    (rgb("#fee2e2"), rgb("#ef4444"), "❌")
  } else if type == "success" {
    (rgb("#d1fae5"), rgb("#10b981"), "✓")
  } else {
    (univ-bleu-outremer.lighten(90%), univ-bleu-outremer, "ℹ")
  }

  block(
    width: 100%,
    fill: bg-color,
    stroke: (left: 3pt + border-color),
    radius: (right: 4pt),
    inset: 12pt,
    {
      if title != none {
        text(weight: "bold", fill: border-color)[#icon #title]
        v(6pt)
      }
      content
    }
  )
}

/// Crée une citation mise en évidence
#let citation-block(content, source: none) = {
  block(
    width: 100%,
    inset: (left: 20pt, right: 20pt, y: 12pt),
    {
      text(style: "italic", size: 12pt, fill: univ-gris.darken(20%))[
        "#content"
      ]
      if source != none {
        v(8pt)
        align(right)[
          #text(size: 10pt, fill: univ-gris)[— #source]
        ]
      }
    }
  )
}

/// Crée une page de remerciements
#let page-remerciements(content) = {
  heading(numbering: none)[Remerciements]
  content
  pagebreak()
}

/// Crée une liste de figures
#let liste-figures() = {
  outline(
    title: "Liste des figures",
    target: figure.where(kind: image),
  )
}

/// Crée une liste de tableaux
#let liste-tableaux() = {
  outline(
    title: "Liste des tableaux",
    target: figure.where(kind: table),
  )
}

/// Crée un glossaire simple
#let glossaire(termes) = {
  heading(numbering: none)[Glossaire]

  for (terme, definition) in termes {
    block(
      width: 100%,
      inset: (bottom: 8pt),
      {
        text(weight: "bold", fill: univ-bleu-outremer, terme)
        h(8pt)
        text(definition)
      }
    )
  }
}

/// Crée une lettre formelle (recommandation, motivation, etc.)
/// - logo-gauche: Logo à gauche de l'en-tête (ex: université)
/// - logo-droite: Logo à droite de l'en-tête (ex: entreprise, composante)
/// - logo-centre: Logo centré dans l'en-tête (utilisé seul, prioritaire sur gauche/droite)
/// - expediteur-nom: Nom de l'expéditeur
/// - expediteur-titre: Titre/fonction de l'expéditeur
/// - expediteur-service: Service ou département
/// - expediteur-adresse: Adresse de l'expéditeur (facultatif)
/// - expediteur-email: Email de l'expéditeur (facultatif)
/// - expediteur-telephone: Téléphone de l'expéditeur (facultatif)
/// - destinataire: Bloc destinataire (facultatif, texte libre)
/// - lieu: Lieu de rédaction (ex: "Saint-Denis de La Réunion")
/// - date: Date de la lettre
/// - objet: Objet de la lettre
/// - corps: Contenu de la lettre (content)
/// - signature-img: Chemin vers une image de signature (facultatif)
#let lettre-formelle(
  logo-gauche: none,
  logo-droite: none,
  logo-centre: none,
  expediteur-nom: "",
  expediteur-titre: none,
  expediteur-service: none,
  expediteur-adresse: none,
  expediteur-email: none,
  expediteur-telephone: none,
  destinataire: none,
  lieu: none,
  date: none,
  objet: none,
  corps,
  signature-img: none,
) = {
  set document(
    title: if objet != none { objet } else { "Lettre" },
    author: (expediteur-nom,),
  )

  set text(
    font: ("Raleway", "Libertinus Serif"),
    size: 11pt,
    lang: "fr",
  )

  set page(
    paper: "a4",
    margin: (
      top: 2.5cm,
      bottom: 2.5cm,
      left: 2.5cm,
      right: 2.5cm,
    ),
    header: none,
    footer: none,
  )

  set par(justify: true, leading: 0.65em)

  // === EN-TÊTE AVEC LOGOS ===
  {
    let has-left = logo-gauche != none
    let has-right = logo-droite != none
    let has-centre = logo-centre != none

    if has-centre {
      align(center, image(logo-centre, height: 45pt))
      v(6pt)
      line(length: 100%, stroke: 1.5pt + univ-bleu-outremer)
      v(12pt)
    } else if has-left or has-right {
      grid(
        columns: if has-left and has-right { (1fr, 1fr) } else { (1fr,) },
        align: if has-left and has-right { (left, right) } else if has-left { (left,) } else { (right,) },
        ..if has-left { (image(logo-gauche, height: 45pt),) } else { () },
        ..if has-right { (image(logo-droite, height: 45pt),) } else { () },
      )
      v(6pt)
      line(length: 100%, stroke: 1.5pt + univ-bleu-outremer)
      v(12pt)
    }
  }

  // === BLOC EXPÉDITEUR ===
  {
    set text(size: 9.5pt)
    text(weight: "bold", fill: univ-bleu-outremer, size: 11pt, expediteur-nom)
    linebreak()
    if expediteur-titre != none {
      text(fill: univ-gris, expediteur-titre)
      linebreak()
    }
    if expediteur-service != none {
      text(fill: univ-gris, expediteur-service)
      linebreak()
    }
    if expediteur-adresse != none {
      text(fill: univ-gris, expediteur-adresse)
      linebreak()
    }
    if expediteur-email != none {
      text(fill: univ-bleu-outremer, expediteur-email)
      linebreak()
    }
    if expediteur-telephone != none {
      text(fill: univ-gris, expediteur-telephone)
    }
  }

  v(14pt)

  // === LIEU ET DATE ===
  {
    let date-str = if date != none {
      if type(date) == datetime {
        date.display("[day] [month repr:long] [year]")
      } else {
        date
      }
    }

    align(right)[
      #text(size: 11pt)[
        #if lieu != none [#lieu, ]
        #if date-str != none [le #date-str]
      ]
    ]
  }

  v(14pt)

  // === DESTINATAIRE ===
  if destinataire != none {
    align(right)[
      #block(
        width: 50%,
        align(left)[
          #text(size: 11pt, destinataire)
        ]
      )
    ]
    v(14pt)
  }

  // === OBJET ===
  if objet != none {
    text(weight: "bold", size: 11pt)[Objet : ]
    text(size: 11pt, objet)
    v(14pt)
  }

  // === CORPS DE LA LETTRE ===
  corps

  v(30pt)

  // === SIGNATURE ===
  align(right)[
    #block(width: 50%)[
      #align(left)[
        #text(weight: "bold", expediteur-nom)
        #if expediteur-titre != none {
          linebreak()
          text(size: 10pt, fill: univ-gris, expediteur-titre)
        }
        #if signature-img != none {
          v(8pt)
          image(signature-img, height: 50pt)
        }
      ]
    ]
  ]
}

/// Crée une quatrième de couverture (page de garde finale)
/// - logo-gauche: Logo à gauche du footer (ex: université)
/// - logo-centre: Logo au centre du footer (ex: composante IUT, ESIROI, etc.)
/// - logo-droite: Logo à droite du footer (ex: ministère)
/// - nom: Nom de l'auteur
/// - email: Adresse email
/// - telephone: Numéro de téléphone (facultatif)
/// - adresse: Adresse postale (facultatif)
/// - site-web: Site web (facultatif)
/// - linkedin: Profil LinkedIn (facultatif)
#let page-garde-finale(
  logo-gauche: "../img/UR_LOGO_2025_BLEU.jpg",
  logo-centre: none,
  logo-droite: none,
  nom: "",
  email: "",
  telephone: none,
  adresse: none,
  site-web: none,
  linkedin: none,
) = {
  pagebreak()
  set page(
    margin: 0pt,
    header: none,
    footer: none,
  )

  block(
    width: 100%,
    height: 100%,
    fill: white,
    {
      // Header avec logo de la composante
      if logo-centre != none {
        place(
          top + center,
          dy: 40pt,
          image(logo-centre, height: 80pt)
        )
      }

      // Zone centrale avec les coordonnées
      place(
        center + horizon,
        block(
          width: 70%,
          {
            // Ligne décorative supérieure
            align(center)[
              #line(length: 60%, stroke: 1pt + univ-bleu-outremer)
            ]

            v(30pt)

            // Nom de l'auteur
            align(center)[
              #text(
                font: ("Playfair Display", "Libertinus Serif"),
                size: 20pt,
                weight: "bold",
                fill: univ-bleu-outremer,
                nom
              )
            ]

            v(25pt)

            // Coordonnées
            align(center)[
              #set text(size: 11pt, fill: univ-gris)

              // Email
              #text(weight: "medium", fill: univ-bleu-outremer)[#email]

              // Téléphone
              #if telephone != none {
                linebreak()
                v(5pt)
                telephone
              }

              // Adresse
              #if adresse != none {
                linebreak()
                v(5pt)
                adresse
              }

              // Site web
              #if site-web != none {
                linebreak()
                v(5pt)
                link(site-web)[#site-web]
              }

              // LinkedIn
              #if linkedin != none {
                linebreak()
                v(5pt)
                link(linkedin)[LinkedIn]
              }
            ]

            v(30pt)

            // Ligne décorative inférieure
            align(center)[
              #line(length: 60%, stroke: 1pt + univ-bleu-outremer)
            ]
          }
        )
      )

      // Footer avec les logos
      place(
        bottom + left,
        block(
          width: 100%,
          height: 140pt,
          fill: univ-bleu-outremer,
          {
            // Logo gauche (université)
            place(
              horizon + left,
              dx: 30pt,
              {
                if logo-gauche != none {
                  block(
                    fill: white,
                    radius: 8pt,
                    inset: 10pt,
                    image(logo-gauche, height: 60pt)
                  )
                }
              }
            )

            // Logo droite (ministère) - plus grand
            place(
              horizon + right,
              dx: -30pt,
              {
                if logo-droite != none {
                  block(
                    fill: white,
                    radius: 8pt,
                    inset: 10pt,
                    image(logo-droite, height: 85pt)
                  )
                }
              }
            )
          }
        )
      )
    }
  )
}
