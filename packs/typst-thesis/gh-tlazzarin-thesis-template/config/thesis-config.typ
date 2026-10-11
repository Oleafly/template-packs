#import "@preview/glossarium:0.5.9": make-glossary, register-glossary, print-glossary, gls, glspl, gls-short, gls-description
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.8": *
#import "../config/constants.typ": chapter, appendix
#import "../appendix/glossary/terms.typ": glossary-terms

// This file sets up the properties of the document and the libraries used

#let config(
  myAuthor: "Nome cognome",
  myTitle: "Titolo",
  myLang: "it",
  myNumbering: "1.1",
  body,
) = {
  // Set the document's basic properties.
  set document(author: myAuthor, title: myTitle)

  // Codly bootstrap and setup
  show: codly-init.with()
  codly(languages: codly-languages, zebra-fill: gray.lighten(90%))

  // LaTeX look https://typst.app/docs/guides/guide-for-latex-users#latex-look
  set page(margin: 1.75in, numbering: myNumbering, number-align: center)
  set par(
    leading: 0.55em,
    spacing: 0.55em,
    justify: true,
  )
  set text(font: "New Computer Modern", lang: myLang)
  set heading(numbering: myNumbering)
  show raw: set text(font: "DejaVu Sans Mono", size: 10pt)
  set par(spacing: 0.55em)
  show heading: set block(above: 2em, below: 1.4em)
  show heading.where(level: 1): it => {
    stack(
      spacing: 2em,
      if it.numbering=="A.1"{
        text(size: 1.5em)[#appendix #counter(heading).display()]
      } else if it.numbering != none {
        text(size: 1.5em)[#chapter #counter(heading).display()]
      },
      text(size: 2em, it.body),
      [],
    )
  }

  // Custom styling
  set list(marker: (sym.bullet, sym.dash))
  set table(inset: 10pt)
  set table(
    fill: (x, y) => { 
        if calc.even(y) { 
          gray.lighten(70%)
        } else { white }
      }
  )
  show figure: it => {
    v(1em)
    it
    v(1em)
  }
  // Il comando sotto lo tengo commentato perché altrimenti può succedere che l'immagine e la sua caption finiscano in due pagine diverse.
  // Per questo motivo ogni tabella deve essere racchiusa in un blocco di codice #{ } o di contenuto #[ ] per isolarne le regole. (se trovate un modo migliore aprite una pr :D )
  //show figure: set block(breakable: true)

  // Glossary bootstrap and setup
  show: make-glossary
  register-glossary(glossary-terms)
  body
}

// Creare delle funzioni wrapper di Glossarium è l'unica soluzione che ho trovato per personalizzare l'aspetto del testo (Sono anche più corte).
// L'unica alternativa è al seguente link ma funziona solo se usi Glossarium con le ref ad esempio '@TERMINE' 
// https://forum.typst.app/t/how-do-you-apply-a-style-to-glossarium-references-that-is-different-to-other-reference-types/2089?u=ogre
#let glossary-style(body) = {
  text(style: "italic", rgb(155, 0 , 20), body+sub[G])
}

#let gl(key,
  suffix: none,
  long: false,
  display: none,
  link: true,
  update: true,
  capitalize: false
) = glossary-style(
  gls(
    key,
    suffix: suffix, 
    long: long,
    display: display, 
    link: link, 
    update: update, 
    capitalize: capitalize
  )
)

#let glpl(
  key,
  long: false,
  link: true,
  update: true,
  capitalize: false
) = glossary-style(
  glspl(
    key, 
    capitalize: capitalize, 
    link: link, 
    long: long, 
    update: update
  )
)

// Utile per quando si introducono le tecnologie (link+corsivo+footnote)
#let linkfn(url, body) = (
  link(url, text(style: "italic", body))+footnote(link(url))
)
