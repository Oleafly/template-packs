#import "titlepage.typ":titlepage
#import "@preview/algorithmic:1.0.2": style-algorithm, algorithm-figure
#import "@preview/hydra:0.6.1": hydra, anchor
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *



//BFPaper Steht für Beautiful Paper
#let BFPaper(
  title: "",
  left_image: "",
  right_image: "",
  image_height: 2cm,
  work_type: "",
  author: "",
  matrikelnummer: "",
  dualer_partner: "",
  betreuer: "",
  pruefer: "",
  bearbeitungszeitraum: "",
  body
) = {
  // Setze Papiergröße und Ränder
  set page(paper:"a4",margin: 2.5cm, header: context{
    if hydra(1) != none {
      anchor()
      align(center,hydra(1))
      v(0.5em)
      line(length: 100%)
    }
  })

  // Setze Seiteblocksatz und Zeilenabstand
  set par(justify:true, spacing: 1.5mm)

  //Setze Schriftart und Zeilenabstand
  set text(lang: "de", size: 12pt, font: "New Computer Modern")

  //Definiere das verhalten von Überschriften
  set heading(numbering: "1.1", supplement: [Kapitel])
  // Kapitelüberschriften sollen größer sein als normal und einen Absatz besitzen

  
  show heading: it => {
    if it.level == 1 {
      pagebreak(weak: true)
      text(weight: "bold", it, size: 25pt)
      v(2em)
    } else {
      text(weight: "bold", it)
      v(1em)
    }
  }

  //Definiere Figure Umgebung damit die Figures platz haben
  show figure: it => {
    v(2em)
    it
    v(2em)
  }

  //Definiere Algorithm Umgebung
  show: style-algorithm

  titlepage(
    title: title,
    left_image: left_image,
    right_image: right_image,
    image_height: image_height,
    work_type: work_type,
    author: author,
    matrikelnummer: matrikelnummer,
    dualer_partner: dualer_partner,
    betreuer: betreuer,
    pruefer: pruefer,
    bearbeitungszeitraum: bearbeitungszeitraum
  )
  // Definiere den Seitenstil mit Seitenzahlen auf römisch
  set page(
  footer: context {
    line(length: 100%)
    align(center,counter(page).display("I"))
    
  })
  // Resette die Seitenzahl auf 1
  counter(page).update(1)
  
  

  //Inhaltsverzeichnis (Explizit nur headings)
  // Refactoren in eigene funktion genau so wie Abbildungsverzeichnis
  {
    show outline.entry.where(level: 1): it => {
      set block(above: 1.2em)
      text(weight: "bold", it)
    }
    outline(
      title: "Inhaltsverzeichnis",
      target: heading,
    )
  }

 
  pagebreak()
  //Setze outline für alle anderen outlines wieder auf Default zurück
  
 
//Abbildungsverzeichnis
  outline(
    title: "Abbildungsverzeichnis",
    target: figure,
  )
  
  pagebreak()
  //Definiere Codly Umgebung für schön formatierte Codeblöcke
  show: codly-init.with()
  // Initalisiere Codly mit vordefinierten Sprachen für weitere Sprachen verwende Anleitung in https://typst.app/universe/package/codly
  codly(languages: codly-languages)

  // Definiere Page Style mit Seitenzahlen auf Arabisch
  set page(
  footer: context {
    line(length: 100%)
    align(center,counter(page).display("1"))
    
  })
  //Resette die Seitenzahl auf 1
  counter(page).update(1)
  body
}