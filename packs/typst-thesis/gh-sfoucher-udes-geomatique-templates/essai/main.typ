// =============================================================================
// Mémoire / essai — Université de Sherbrooke, géomatique appliquée
// Fichier principal. Compilation :  typst compile main.typ
// =============================================================================
#import "styles.typ": *
#import "auxiliaires/sigles.typ": acronymes

#show: thesis.with(
  titre: "Titre du mémoire ou de l'essai",
  auteur: "Prénom NOM",
)
#register-glossary(acronymes)

// =============================================================================
// Pages liminaires sans en-tête ni numéro
// =============================================================================
#set page(header: none, footer: none, numbering: none)
#include "fichiers_introductifs/page_titre.typ"
#include "fichiers_introductifs/jury.typ"
#include "fichiers_introductifs/citation.typ"
// page blanche (verso de la citation)
#page(header: none, footer: none, numbering: none)[]

// =============================================================================
// Pages liminaires en chiffres romains
// =============================================================================
#set page(footer: pied-page, numbering: "i")
#counter(page).update(1)

#include "fichiers_introductifs/resume_abstract.typ"

// --- Table des matières (absente d'elle-même) ---
#heading(level: 1, numbering: none, outlined: false)[Table des matières]
#outline(title: none, depth: 3, indent: auto)

// --- Liste des figures (obligatoire) ---
#chapitre-nn[Liste des figures]
#outline(title: none, target: figure.where(kind: image))

// --- Liste des tableaux (obligatoire) ---
#chapitre-nn[Liste des tableaux]
#outline(title: none, target: figure.where(kind: table))

// --- Liste des algorithmes (commenter s'il n'y a pas d'algorithmes) ---
#chapitre-nn[Liste des algorithmes]
#outline(title: none, target: figure.where(kind: "algorithm"))

// --- Liste des scripts (commenter s'il n'y a pas de scripts) ---
#chapitre-nn[Liste des scripts]
#outline(title: none, target: figure.where(kind: raw))

// --- Liste des abréviations et des sigles (obligatoire) ---
#chapitre-nn[Liste des abréviations et des sigles]
#{
  // les entrées de glossarium sont des figures : on annule localement
  // l'espacement de 1,8 em hérité du module
  show figure: set block(above: 0.65em, below: 0.65em)
  set par(leading: 0.65em, spacing: 0.65em)
  print-glossary(
    acronymes,
    user-print-gloss: (entry, ..args) => {
      // espace additionnel au changement de lettre initiale
      let tri = acronymes.sorted(key: e => upper(e.short))
      let idx = tri.position(e => e.key == entry.key)
      if idx != none and idx > 0 {
        let prev = upper(tri.at(idx - 1).short.first())
        let cur = upper(entry.short.first())
        if prev != cur { v(0.9em) }
      }
      grid(
        columns: (2.5cm, 1fr),
        strong(entry.short),
        {
          if "long" in entry and entry.long != none { entry.long }
          context {
            let refs = get-entry-back-references(entry)
            if refs.len() > 0 [ #refs.join(", ")]
          }
        },
      )
    },
  )
}

// --- Liste des symboles et des formules chimiques ---
#include "fichiers_introductifs/symboles.typ"

// --- Pages optionnelles ---
#include "fichiers_introductifs/remerciements.typ"
#include "fichiers_introductifs/avant_propos.typ"
// --- Page obligatoire ---
#include "fichiers_introductifs/declaration_ia.typ"

// =============================================================================
// Corps du document : chiffres arabes + en-têtes
// =============================================================================  
#pagebreak()
 
#set page(header: entete-corps, numbering: "1")
#counter(page).update(1)
#counter(heading).update(0)

#include "chapitres/1_introduction.typ"
#include "chapitres/2_cadre_theorique.typ"
#include "chapitres/3_methodologie.typ"
#include "chapitres/4_resultats.typ"
#include "chapitres/5_discussion.typ"
#include "chapitres/6_conclusion.typ"

// =============================================================================
// Bibliographie
// =============================================================================
#chapitre-nn[Bibliographie]
// APA en anglais (style intégré à Typst)
// #bibliography("bibliographie.bib", title: none, style: "american-psychological-association")
// APA en français (fichier CSL à la racine du projet, à côté de main.typ)
#bibliography("bibliographie.bib", title: none, style: "universite-de-montreal-apa.csl")
// =============================================================================
// Annexes (numérotation A, B, C… — équivaut à \appendix)
// =============================================================================
#counter(heading).update(0)
#{
  set heading(numbering: "A.1")
  include "chapitres/annexes.typ"
}
