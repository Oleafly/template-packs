// =============================================================================
// Modèle Typst de thèse / mémoire / essai — Université de Sherbrooke
// Département de géomatique appliquée
// Converti du modèle LaTeX de Philippe Apparicio
// =============================================================================
#import "@preview/glossarium:0.5.6": make-glossary, register-glossary, print-glossary, gls, glspl, get-entry-back-references
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.8": *
#import "@preview/lovelace:0.3.0": *

// -----------------------------------------------------------------------------
// Palette de couleurs de l'Université de Sherbrooke
// (https://www.usherbrooke.ca/.../CharteCouleurs_Contrastes_UdeS.pdf)
// -----------------------------------------------------------------------------
#let UdesBlanc = rgb("#FFFFFF")
#let UdesNoir = rgb("#000000")
#let UdesDeveloppementDurable = rgb("#95C14E")
#let UdesVivacite = rgb("#79B551")
#let UdesCreativite = rgb("#5AAD55")
#let UdesFierte = rgb("#00A759")
#let UdesSolidarite = rgb("#3D8F58")
#let UdesBienEtre = rgb("#447C5A")
#let UdesReussite = rgb("#486A5C")
#let UdesGris = rgb("#B6BAAF")
#let UdesJaune = rgb("#E5A939")
#let UdesOrange = rgb("#B45E2F")
#let UdesViolet = rgb("#805286")
#let UdesReussiteContraste1 = rgb("#11594B")
#let UdesReussiteContraste2 = rgb("#18463A")
#let UdesDDContrasteUn = rgb("#A6C74B")
#let UdesFierteAccessible = rgb("#018849")
#let darkred = rgb("#CC0000")
#let eclipsepurple = rgb("#7F0055")

// -----------------------------------------------------------------------------
// État interne : distingue les pages de « Partie » des autres chapitres
// -----------------------------------------------------------------------------
#let _is-part = state("udes-is-part", false)
#let _part-num = state("udes-part-num", "")
#let _part-title = state("udes-part-title", [])

// -----------------------------------------------------------------------------
// Légende courte pour les listes (équivaut à \caption[court]{long})
// Appel : caption: flex-caption([légende longue...], [légende courte])
// -----------------------------------------------------------------------------
#let _in-outline = state("udes-in-outline", false)
#let flex-caption(long, short) = context {
  if _in-outline.get() { short } else { long }
}

// -----------------------------------------------------------------------------
// En-tête courant (corps du document) : titre courant + filet vert
// -----------------------------------------------------------------------------
#let _running-header = context {
  let loc = here()
  let chaps = query(heading.where(level: 1).before(loc))
  if chaps.len() == 0 { return }
  let chap = chaps.last()
  // ne pas afficher l'en-tête sur les pages de « Partie »
  if _is-part.at(chap.location()) { return }
  // pas d'en-tête sur la page d'ouverture d'un chapitre (style « plain »)
  let starts-here = query(heading.where(level: 1)).any(h => h.location().page() == loc.page())
  if starts-here { return }
  let secs = query(heading.where(level: 2).before(loc))
  let fmt(h) = {
    if h.numbering != none {
      numbering(h.numbering, ..counter(heading).at(h.location()).slice(0, h.level))
      [. ]
    }
    h.body
  }
  set text(size: 10pt, fill: UdesReussite)
  if calc.even(loc.page()) {
    // page paire (verso) : section courante à gauche, sinon le chapitre
    let sec = if secs.len() > 0 { secs.last() } else { chap }
    align(left, fmt(sec))
  } else {
    // page impaire (recto) : chapitre courant à droite
    align(right, fmt(chap))
  }
  v(2pt)
  line(length: 100%, stroke: 0.4pt + UdesReussite)
}

// -----------------------------------------------------------------------------
// Pied de page : « -- n -- » centré, en vert
// -----------------------------------------------------------------------------
#let _page-footer = context {
  set text(fill: UdesReussite)
  let n = counter(page).display()
  align(center, [-- #n --])
}

// -----------------------------------------------------------------------------
// Fonction principale : à utiliser via `#show: thesis.with(...)`
// -----------------------------------------------------------------------------
#let thesis(
  titre: "Titre du document",
  auteur: "Prénom Nom",
  body,
) = {
  set document(title: titre, author: auteur)

  // --- Polices et paragraphe ---
  set text(font: "Libertinus Serif", size: 12pt, lang: "fr", region: "CA")
  show math.equation: set text(font: "New Computer Modern Math")
  // équations calées à gauche avec retrait de 1 cm (équivalent fleqn + mathindent)
  show math.equation.where(block: true): it => block(
    width: 100%,
    inset: (left: 1cm),
    align(left, it),
  )
  set par(justify: true, leading: 1em, spacing: 0.9em, first-line-indent: 0pt)
  // listes à puces : tiret demi-cadratin (usage français)
  set list(marker: [--])

  // --- Mise en page (lettre US, marges 2,5 cm) ---
  set page(
    paper: "us-letter",
    margin: 2.5cm,
    header: _running-header,
    header-ascent: 30%,
    footer: _page-footer,
    numbering: "1",
  )

  // --- Numérotation ---
  set heading(numbering: "1.1")
  // équations : « (3.1) » dans le corps
  set math.equation(supplement: none, numbering: n => {
    numbering("(1.1)", counter(heading).get().first(), n)
  })
  // figures, tableaux, codes, algorithmes : « 3.1 » dans le corps, « A.1 » en
  // annexe (le motif du chapitre englobant est détecté dynamiquement)
  set figure(numbering: n => context {
    let ch = counter(heading).get().first()
    let chaps = query(heading.where(level: 1).before(here())).filter(h => h.numbering != none)
    let pattern = if chaps.len() > 0 { chaps.last().numbering } else { "1.1" }
    [#numbering(pattern, ch).#n]
  })

  // --- Figures et tableaux ---
  set figure.caption(separator: [ #sym.dash.en ])
  set figure(supplement: [Figure])
  // Espacement avant et après les figures, tableaux, algo
  show figure: set block(above: 1.8em, below: 1.8em)
  show figure.where(kind: table): set figure(supplement: [Tableau])
  show figure.where(kind: table): set figure.caption(position: top)
  // codes et algorithmes : numérotation par chapitre (héritée), légende en haut
  show figure.where(kind: raw): set figure(supplement: [Code])
  show figure.where(kind: raw): set figure.caption(position: top)
  show figure.where(kind: "algorithm"): set figure(supplement: [Algorithme])
  show figure.where(kind: "algorithm"): set figure.caption(position: top)
  // légende : étiquette en petites capitales grasses (labelfont=bf)
  show figure.caption: it => block(width: 100%, align(center, {
    set text(size: 12pt)
    strong(smallcaps({ it.supplement; [ ]; context it.counter.display(it.numbering) }))
    it.separator
    it.body
  }))
  set table(stroke: none)
  set table.hline(stroke: 0.6pt + UdesNoir)   // épaisseur des filets des tableaux
  show table: set text(size: 11pt)            // taille du texte dans le tableau
  show table: set par(leading: 0.55em)
  // tableaux calés au centre
  show figure.where(kind: table): set align(center)

  // --- Titres : chapitres (niveau 1) ---
  show heading.where(level: 1): it => context {
    // Page de « Partie » (thèse par articles)
    if _is-part.at(it.location()) {
      pagebreak(weak: true)
      set page(header: none, footer: none)
      set align(center + horizon)
      let num = _part-num.at(it.location())
      let titre = _part-title.at(it.location())
      block({
        text(size: 30pt, fill: UdesReussite, smallcaps[Partie #num])
        v(1cm)
        text(size: 25pt, smallcaps(titre))
      })
      return
    }
    // saut de page
    if it.numbering == none {
      pagebreak(weak: true)
    } else {
      //pagebreak(weak: true, to: "odd")
      pagebreak(weak: true)
    }
    // remise à zéro des compteurs par chapitre
    // (figures, tableaux, codes, algorithmes, équations)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)
    counter(figure.where(kind: "algorithm")).update(0)
    counter(math.equation).update(0)

    set text(fill: UdesReussiteContraste2)
    if it.numbering == none {
      // chapitre non numéroté (Résumé, Remerciements, listes…)
      block(below: 20pt, text(size: 18pt, weight: "bold", it.body))
    } else {
      // chapitre numéroté : gros numéro + titre + filet
      // (respecte le motif du chapitre : « 1 » en corps, « A » en annexe)
      let n = counter(heading).at(it.location()).first()
      v(20pt)
      text(size: 70pt, weight: "bold", numbering(it.numbering, n))
      v(10pt)
      block(text(size: 30pt, weight: "bold", it.body))
      v(-10pt)
      line(length: 100%, stroke: 0.8pt + UdesReussiteContraste2)
      v(20pt)
    }
  }

  // --- Titres : sections et sous-sections ---
  show heading.where(level: 2): it => block(above: 18pt, below: 14pt,
    text(size: 16pt, weight: "bold", fill: UdesReussiteContraste2, it))
  show heading.where(level: 3): it => block(above: 18pt, below: 14pt,
    text(size: 14pt, weight: "bold", fill: UdesReussiteContraste2, it))
  show heading.where(level: 4): it => block(above: 18pt, below: 14pt,
    text(size: 12pt, weight: "bold", fill: UdesReussiteContraste2, it))

  // --- Table des matières et listes ---
  // légendes courtes (flex-caption) dans les listes de figures/tableaux
  show outline: it => {
    _in-outline.update(true)
    it
    _in-outline.update(false)
  }
  // Force l'interligne simple (0.65em) sur tout l'outline
  show outline: set par(leading: 0.65em, spacing: 0.65em)
  // Compacter la table des matières
  show outline.entry: it => {
    // On réduit l'espace vertical par défaut de Typst autour de chaque ligne
    v(-0.35em)
    it
  }
  // Style spécifique du niveau 1
  show outline.entry.where(level: 1): it => {
    if it.element.func() == heading {
      // chapitres (table des matières) : gras, sans points de conduite,
      // lien cliquable et coloré (via `show link`)
      block(above: 1em, below: 0pt,
        link(it.element.location(),
          strong(it.indented(it.prefix(), it.body() + h(1fr) + it.page()))))
    } else if it.element.func() == figure {
      // listes des figures, tableaux, codes, algorithmes : préfixe recalculé
      // à l'emplacement de la figure (sinon le compteur de chapitre vaut 0
      // dans les pages liminaires → « 0.1 »); points de conduite conservés
      let el = it.element
      let loc = el.location()
      let val = counter(figure.where(kind: el.kind)).at(loc).first()
      let ch = counter(heading).at(loc).first()
      let chaps = query(heading.where(level: 1).before(loc)).filter(h => h.numbering != none)
      let pattern = if chaps.len() > 0 { chaps.last().numbering } else { "1.1" }
      let prefix = [#el.supplement #numbering(pattern, ch).#val]
      link(loc, it.indented(prefix, it.inner()))
    } else {
      it
    }
  }

  // --- Hyperliens et citations ---
  show link: set text(fill: UdesReussiteContraste1)
  show cite: set text(fill: UdesViolet)
  // renvois : n'affichent que le numéro (comportement de \ref) — « 3.1 »,
  // « A.1 » en annexe; équations « 3.1 » sans parenthèses
  show ref: it => {
    let el = it.element
    if el == none { return it }  // citations : gérées par `show cite`
    set text(fill: UdesReussiteContraste1)
    let loc = el.location()
    if el.func() == heading {
      link(loc, numbering(el.numbering, ..counter(heading).at(loc).slice(0, el.level)))
    } else if el.func() == math.equation {
      let ch = counter(heading).at(loc).first()
      let eq = counter(math.equation).at(loc).first()
      link(loc, numbering("1.1", ch, eq))
    } else if el.func() == figure {
      // toutes les figures (images, tableaux, codes, algorithmes) :
      // chapitre.numéro avec le motif du chapitre (« 3.1 », « A.1 »)
      let val = counter(figure.where(kind: el.kind)).at(loc).first()
      let ch = counter(heading).at(loc).first()
      let chaps = query(heading.where(level: 1).before(loc)).filter(h => h.numbering != none)
      let pattern = if chaps.len() > 0 { chaps.last().numbering } else { "1.1" }
      link(loc, [#numbering(pattern, ch).#val])
    } else {
      it
    }
  }

  // --- Glossaire (acronymes) ---
  show: make-glossary

  // --- Blocs de code ---
  show: codly-init
  codly(
    languages: codly-languages,
    zebra-fill: none,
    fill: luma(242),
    inset: (x: 4pt, y: 2pt),   // y = espace entre les lignes de code (compact)
    radius: 0pt,
    stroke: 0.6pt + luma(160),
  )

  body
}

// -----------------------------------------------------------------------------
// En-tête et pied de page exportés (pour piloter les pages liminaires)
// -----------------------------------------------------------------------------
#let entete-corps = _running-header
#let pied-page = _page-footer

// -----------------------------------------------------------------------------
// Chapitre non numéroté avec entrée dans la table des matières
// (équivaut à \chapter*{...} + \addcontentsline)
// -----------------------------------------------------------------------------
#let chapitre-nn(titre) = heading(level: 1, numbering: none, outlined: true, titre)

// -----------------------------------------------------------------------------
// Page de « Partie » (thèse par articles) — divise le document et ajoute une
// entrée dans la table des matières.
// -----------------------------------------------------------------------------
#let partie(numero, titre) = {
  _is-part.update(true)
  _part-num.update(numero)
  _part-title.update(titre)
  heading(level: 1, numbering: none, outlined: true)[#smallcaps[Partie #numero : #titre]]
  _is-part.update(false)
}

// -----------------------------------------------------------------------------
// Page titre — bandeau vert vertical, texte pivoté, logo, bloc de titre à droite
// `option-logo` : 1 = logo horizontal à côté ; 2 = logo dans le bandeau
// -----------------------------------------------------------------------------
#let page-titre(
  type-doc: [ESSAI DE MAÎTRISE],
  bandeau-sous: [Géomatique appliquée et télédétection],
  bandeau-couleur-1: UdesFierte,
  bandeau-couleur-2: UdesFierteAccessible,
  logo-bandeau: none,
  logo-cote: none,
  option-logo: 2,
  titre: [Titre dans la langue de rédaction \ (français ou anglais)],
  titre-fr: [Titre en français, si la langue de rédaction est l'anglais],
  auteur: [#smallcaps[Prénom] NOM],
  mention: [Essai présenté à la Faculté des lettres et sciences humaines \
    au Département de géomatique appliquée \
    en vue de l'obtention du grade de],
  grade: [_Maître ès sciences_ (M. Sc.) en géomatique appliquée et télédétection],
  date: [Mois 20XX],
  copyright: [© #smallcaps[Prénom] NOM, 20XX],
) = page(margin: 0pt, header: none, footer: none, numbering: none, {
  // bandeau vertical à gauche (2,5 cm)
  place(top + left, rect(
    width: 2.5cm, 
    height: 100%,
    fill: if option-logo == 1 { bandeau-couleur-1} else { bandeau-couleur-2}))
  // logo dans le bandeau (option 2)
  if option-logo == 2 and logo-bandeau != none {
    place(top + left, dy: 0.7cm, box(width: 2.5cm, align(center, logo-bandeau)))
  }
  // texte pivoté du bandeau, aligné en bas
  place(bottom + left, dx: 1.8cm, dy: -2cm,
    rotate(-90deg, origin: bottom + left, reflow: false,
      box(width: 22cm, {
        set text(font: "TeX Gyre Heros", fill: white, weight: "bold")
        set par(leading: 0.7em)
        text(size: 20pt, type-doc)
        linebreak()
        text(size: 15pt, bandeau-sous)
      })))
  // bloc de titre à droite
  block(width: 100%, height: 100%,
    inset: (left: 3.0cm, right: 1.5cm, top: 2cm, bottom: 1cm), {
    set align(right)
    set par(justify: false)
    if option-logo == 1 and logo-cote != none {
      align(left, logo-cote)
      v(2.0cm)
    } else {
      v(2.5cm)
    }
    par(leading: 1.4em, text(size: 22pt, weight: "bold", fill: UdesReussite, titre))
    v(0.5cm)
    text(size: 16pt, fill: UdesReussiteContraste2, titre-fr)
    v(2.5cm)
    text(size: 22pt, weight: "bold", fill: UdesReussite, auteur)
    v(2cm)
    text(size: 12pt, fill: UdesReussiteContraste1, mention)
    v(0.4cm)
    text(size: 12pt, fill: UdesReussiteContraste1, grade)
    v(2.5cm)
    text(size: 12pt, fill: UdesReussiteContraste1, date)
    v(1fr)
    text(size: 12pt, fill: UdesReussiteContraste1, copyright)
  })
})

// -----------------------------------------------------------------------------
// Citation en retrait (équivaut à l'environnement `customquote`)
// -----------------------------------------------------------------------------
#let citation-bloc(body) = block(inset: (left: 2cm, right: 2cm), {
  set text(size: 10pt)
  set par(leading: 0.65em)
  body
})

// -----------------------------------------------------------------------------
// Bloc de code source avec légende (liste des scripts)
// Appel : #code-source(read("../Scripts_Programmes/GEE1.js"), "js", [légende])
// (le `read` doit être écrit dans le fichier appelant pour que le chemin
//  relatif soit résolu correctement)
// -----------------------------------------------------------------------------
#let code-source(texte, langue, legende, etiquette: none) = {
  let fig = figure(
    {
      set text(size: 10pt)
      raw(texte, lang: langue, block: true)
    },
    caption: legende,
    kind: raw,
    supplement: [Code],
  )
  if etiquette != none [ #fig #etiquette ] else { fig }
}

// -----------------------------------------------------------------------------
// Algorithme (style algorithm2e) via lovelace, dans un flottant numéroté
// -----------------------------------------------------------------------------
// Traits pour l'encadré des algorithmes
#let pseudocode-list = pseudocode-list.with(
  booktabs: true,
  booktabs-stroke: 0.8pt + UdesReussiteContraste2,  // filets horizontaux (défaut : 2pt)
  stroke: 0.5pt + luma(180),          // guides d'indentation (défaut : 1pt + gray)
)

#let algorithme(legende, body, etiquette: none) = {
  let fig = figure(
    kind: "algorithm",
    supplement: [Algorithme],
    caption: legende,
    body,
  )
  if etiquette != none [ #fig #etiquette ] else { fig }
}
