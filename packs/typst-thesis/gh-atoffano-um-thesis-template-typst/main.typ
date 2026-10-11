// --- VARIABLES ---
#import "metadata.typ": *
// --- CONFIGURATION GLOBALE ---

// 1. Métadonnées
#set document(
  title: thesis_title, 
  author: author_name
)

// 2. Configuration de la page et des marges
#set page(
  paper: "a4",
  margin: (x: 2.5cm, y: 2.5cm),
  numbering: "1",
  header: context {
    let page-num = here().page()
    let is-even = calc.even(page-num)
    
    // Trouve le chapitre actif (niveau 1) pour cette page
    let chapters = query(heading.where(level: 1)).filter(h => h.location().page() <= page-num)
    if chapters.len() == 0 { return none }
    let active-ch = chapters.last()
    
    // Cache l'en-tête avant le premier chapitre
    if active-ch.location().page() == page-num { return none }
    
    // Selection du titre de section actif (niveau 2) pour les pages paires
    let subs = query(heading.where(level: 2)).filter(h => 
      h.location().page() <= page-num and h.location().page() >= active-ch.location().page()
    )
    let active-sub = if subs.len() > 0 { subs.last() } else { none }

    let header-text = none
    
    // En-tête alternant entre titre du chapitre et titre de la section pour les pages paires et impaires
    if is-even {
      // Chapitre
      let ch-num = if active-ch.numbering != none { str(counter(heading).at(active-ch.location()).at(0)) } else { "" }
      let prefix = if ch-num != "" { "Chapitre " + ch-num + " – " } else { "" }
      header-text = align(left)[#text(size: 8pt, style: "italic")[#prefix #active-ch.body]]
    } else {
      // Sous-section
      if active-sub != none {
        let nums = counter(heading).at(active-sub.location())
        let sub-num = if nums.len() > 1 { str(nums.at(0)) + "." + str(nums.at(1)) + " " } else { "" }
        header-text = align(right)[#text(size: 8pt, style: "italic")[#sub-num #active-sub.body]]
      } else {
        // Fallback au titre du chapitre si pas de section active
        let ch-num = if active-ch.numbering != none { str(counter(heading).at(active-ch.location()).at(0)) } else { "" }
        let prefix = if ch-num != "" { "Chapitre " + ch-num + " – " } else { "" }
        header-text = align(right)[#text(size: 8pt, style: "italic")[#prefix #active-ch.body]]
      }
    }
    
    stack(
      spacing: 0.5em,
      header-text,
      line(length: 100%, stroke: 0.5pt)
    )
  },
  footer: context [
    #grid(
      columns: (1fr, auto, 1fr),
      align: (left, center, right),
      [], 
      counter(page).display("1"),
      text(size: 8pt)[Université de Montpellier]
    )
  ]
)

// 3. Typographie
#set text(
  font: "New Computer Modern",
  size: 12pt,
  lang: "fr",
)
#set heading(numbering: "1.1") // Format de la numérotation des sections

// Page de garde des chapitres (Niveau 1) -> Police marquée, aligné à droite
#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  v(4%)
  
  align(right)[
    // Seulement s'il existe une numérotation au chapitre.
    #if it.numbering != none [
      #text(size: 16pt, fill: rgb("#555555"))[Chapitre #counter(heading).display()]
      #v(-0.5em)
    ]
    #text(size: 28pt, weight: "bold")[#it.body]
  ]
  v(0.5em)
  line(length: 100%, stroke: 0.5pt)
  v(2em)
}
#show heading: it => {
  if it.level > 1 {
    block(above: 2em, below: 1em)[#it]
  } else {
    it
  }
}

#show link: set text(fill: rgb("#000080")) // Hyperlinks colorés
#set math.equation(numbering: "(1)") // Numérotation des équations

// Paragraphes
#set par(
  leading: 0.65em,
  justify: true,
)

// --- CONSTRUCTION DU DOCUMENT ---
// 1. Page de Titre
#page(
  numbering: none, 
  header: none, 
  footer: none,
  background: image("assets/global/bg_um.jpg", width: 100%, height: 100%),
  margin: (x: 2.5cm, y: 2.5cm)
)[
  #include "chapters/00-frontpage.typ"
]

// 2. Pages Liminaires
#include "chapters/00-liminar.typ"
#pagebreak()

// 3. Table des Matières
#outline(
  title: "Table des matières",
  depth: 3, 
)
#pagebreak()

// Listes - Abbréviations, tableau et figures
#heading(numbering: none)[Liste des abréviations]
/ UM: Université de Montpellier
/ CNRS: Centre National de la Recherche Scientifique

#outline(
  title: "Liste des figures",
  target: figure.where(kind: image),
)

#outline(
  title: "Liste des tableaux",
  target: figure.where(kind: table),
)
#pagebreak()

// 4. Corps de la thèse
#include "chapters/01-introduction.typ"
#pagebreak()

// 5. Annexes
#include "chapters/99-appendices.typ"

// 6. Bibliographie
#pagebreak()
#bibliography(
  "bib/references.bib",
  style: "nature", 
)

// 7. 4e de couverture
#pagebreak()
#include "chapters/99-lastpage.typ"