
// ╔══════════════════════════════════════════════════════════════╗
// ║   lib.typ — Template générique pour support de cours         ║
// ╚══════════════════════════════════════════════════════════════╝
//
// Auteurices :
//   - Jérémy La Scala <jeremy.lascala@unil.ch>
// 
// ── Packages ────────────────────────────────────────────────────
#import "@preview/gentle-clues:1.3.1": *
#import "@preview/drafting:0.2.2": set-page-properties, margin-note

// ── Constantes et configuration ─────────────────────────────────

#let MARGINS = (top: 2.2cm, bottom: 2.2cm, left: 2.5cm, right: 2.5cm)

#let exercice_counter = counter("exercice")
#exercice_counter.update(1)

// ── Ré-export des symboles utiles ───────────────────────────────
// L'utilisateur n'a pas besoin de ré-importer ces packages.
#let info    = info
#let warning = warning
#let tip     = tip
#let success = success
#let clue    = clue
#let exercice = task.with(
  title: [
    #exercice_counter.step()
    Exercice #context exercice_counter.display()
    ],
  breakable: true,
)

// ── Utilitaires publics ─────────────────────────────────────────

/// Affiche le barème en bleu aligné à droite de la ligne.
/// Usage : = Exercice 1 #pts(10)
#let pts(n) = {
  text(fill: luma(50%), style: "italic")[
    (#n pt#if n > 1 { "s" })
  ]
}

#let colors-unil = (
  lettres: (
    main: rgb("#0093B2"),
    dark: rgb("#005A6F"),
    light: rgb("#8BD3E6"),
  )
)

#let contenu_enseignant(body) = {
  context{
    let ens = query(<version-enseignant>).first(default: false).value
    if ens {
      body
    } else {
      none
    }
  }
}

#let contenu_corrige(body) = {
  context{
    let ens = query(<corrigé>).first(default: false).value
    if ens {  
      body
    } else {
      none
    }
  }
}

#let reponse(body) = {
  contenu_corrige(
      success(title: [Réponse], breakable: true)[
        #body
      ]
  )
}

#let note_marge_enseignant(body) = contenu_enseignant(margin-note(stroke: rgb("#1e66f5"), notify(title: "Rappel", body)))

// ── En-tête du document (interne) ──────────────────────────────
#let _entete(meta) = {
  block(
    width: 100%,
    fill: colors-unil.lettres.light.lighten(80%),
    // stroke: 1pt + rgb("#1a6ea8"),
    radius: 0pt,
    inset: 14pt,
  )[
        #set text(fill: colors-unil.lettres.main, size: 12pt)
        #grid(columns: (2fr, 1fr), gutter: 2em, [
          #if meta.code != none [
            #meta.code | 
          ]
          #meta.cours --- #meta.session
        ],
        [
          #if meta.auteurice != none {
            align(right, {
            set text(size: 9pt)
            if type(meta.auteurice) == str or type(meta.auteurice) == content {
              [#meta.auteurice]
            } else if type(meta.auteurice) == dictionary {
              [#link(meta.auteurice.lien)[#meta.auteurice.nom]]
            }
            })
          }
        ])
        #v(4pt)
        #text(size: 16pt, weight: "bold", fill: colors-unil.lettres.dark)[#meta.titre] \
        #v(2pt)

        #set text(size: 9pt, fill: color.gray)
        #meta.date.display("[day].[month].[year]")
        #if meta.document_type != none [ --- #meta.document_type]
  ]
  v(0.8em)
}

// ── Pied de page formulaire (interne) ──────────────────────────
#let _pied(meta) = {
  v(1em)
  line(length: 100%, stroke: 0.4pt + luma(200))
  align(center)[
    #text(size: 8pt, fill: luma(140))[
      #meta.cours — #meta.code — #meta.session #if meta.auteur != "" [ — #meta.auteur ]
    ]
  ]
}

#let _get_version_enseignant() = {
  let version_enseignant = if sys.inputs.at("version-enseignant", default: false) == "true" {
    true
  } else {
    false
  }
  [
    #metadata(version_enseignant) <version-enseignant>
  ]
}

#let _get_corrige() = {
  let corrige = if sys.inputs.at("corrige", default: false) == "true" {
    true
  } else {
    false
  }
  [
    #metadata(corrige) #label("corrigé")
  ]
}

// ── Fonction principale : show rule ────────────────────────────
//
// Paramètres :
//   titre, document_type, cours, code, session, date,
//   duree, materiel, total_pts, auteur — métadonnées du document
//   instructions             — contenu de la boîte Instructions
//                              (none pour masquer)
//   annexe                   — contenu de la page annexe finale
//                              (none pour masquer)
//   body                     — injecté automatiquement par #show:
//
#let coursesheet(
  titre:         "Titre du document",
  document_type: none,
  cours:         "Cours",
  code:          none,
  session:       none,
  date:          datetime.today(),
  auteurice:     none,
  version:       [v#datetime.today().display("[year][month][day]")],
  lien:          none,
  champs_nom_prenoms: false,
  body,
) = {

  _get_version_enseignant()
  _get_corrige()

  // Stockage des métadonnées dans un dictionnaire local
  let meta = (
    titre:        titre,
    document_type: document_type,
    cours:        cours,
    code:         code,
    session:      session,
    date:         date,
    auteurice:    auteurice,
    version:      version,
  )

  // ── Mise en page ──────────────────────────────────
  set page(
    paper:  "a4",
    margin: MARGINS,
    header: context {
      if counter(page).get().first() > 1 {
        set text(size: 8pt, fill: colors-unil.lettres.dark)
        grid(
          columns: (1fr, 1fr),
          align(left, (meta.cours, meta.titre).join([ --- ])),
        )
        line(length: 100%, stroke: 0.4pt + colors-unil.lettres.dark)
      }
    },
    footer: context {
      set text(size: 8pt, fill: colors-unil.lettres.dark)
      stack(
        dir: ltr,
        align(left, box(image("/assets/logo-unil.pdf"), clip: true, inset: (right: -40%, bottom: -60%))),
        align(right)[
              Page #counter(page).display() / #counter(page).final().first() \
              #align(bottom)[#meta.version]
              // #box(image("/assets/by-nc-sa.eu.svg", height: 2em))
            ]
      )
    },
    // background: {
    //   place(
    //     horizon + left,
    //     dx: +5pt,
    //     rotate(-90deg)[
    //       #box(image("/assets/by-nc-sa.eu.svg", height: 2em))
    //       #box[Coursesheet © 2026 by Jérémy La Scala is licensed under CC BY-NC-SA 4.0. To view a copy of this license, visit https://creativecommons.org/licenses/by-nc-sa/4.0/]
    //     ]
    //   )
    // }
  )

  set text(font: "Luciole", size: 11pt, lang: "fr")
  show math.equation: set text(font: "Luciole Math")
  set par(justify: true, leading: 0.7em)
  set heading(numbering: none)

  set-page-properties(margin-left: MARGINS.left, margin-right: MARGINS.right)

  show raw: set text(hyphenate: false)

  show link: set text(fill: colors-unil.lettres.main)
  show link: underline

  set heading(numbering: "1.1.A.a.i")

  show heading.where(level: 1): it => {
    v(1.2em)
    block(it)
    v(0.4em)
  }
  show heading.where(level: 2): it => {
    v(0.8em)
    block(it)
    v(0.2em)
  }

  // ── En-tête du document ───────────────────────────
  _entete(meta)

  v(0.8em)

  // ── Corps du document ─────────────────────────────
  body
}


#let exercices(
  titre:         "Titre du document",
  document_type: "Fiche d'exercices",
  cours:         "Cours",
  code:          none,
  session:       none,
  date:          datetime.today(),
  auteurice:     none,
  version:       [v#datetime.today().display("[year][month][day]")],
  lien:          none,
  champs_nom_prenoms: false,
  body,
) = {

  _get_version_enseignant()
  _get_corrige()

  // Stockage des métadonnées dans un dictionnaire local
  let meta = (
    titre:        titre,
    document_type: document_type,
    cours:        cours,
    code:         code,
    session:      session,
    date:         date,
    auteurice:    auteurice,
    version:      version,
  )

  show: coursesheet.with(
    titre:         meta.titre,
    document_type: meta.document_type,
    cours:         meta.cours,
    code:          meta.code,
    session:       meta.session,
    date:          meta.date,
    auteurice:     meta.auteurice,
    version:       meta.version,
  )



  body
}
