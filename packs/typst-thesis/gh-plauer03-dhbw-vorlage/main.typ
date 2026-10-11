#import "template.typ": style
#import "metadata.typ": meta
#import "flyleaf/titlepage.typ": titlepage

// IMPORT STYLE
#show: doc => style(doc)

#titlepage(meta)

#set page(numbering: "i")

// Inhaltsverzeichnis
#heading(numbering: none, outlined: false)[Inhaltsverzeichnis]
#outline(title: none)

// Abbildungsverzeichnis
#heading(numbering: none, outlined: false)[Abbildungsverzeichnis]
#outline(target: figure.where(alt: none),title: none)

// Tabellenverzeichnis
#heading(numbering: none, outlined: false)[Tabellenverzeichnis]
#outline(target: figure.where(alt: "table"),title: none)

//Seitenzahl Arabisch für Hauptteil
#set page(numbering: "1")

#counter(page).update(1)

= Einleitung
#include "content/einleitung.typ"

= Grundlagen
#include "content/grundlagen.typ"

= Zusammenfassung und Ausblick
#include "content/fazit.typ"


#set page(numbering: "i")
#heading(numbering: none)[Literatur]
#bibliography(title: none,"literatur.bib")
