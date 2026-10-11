#import "/Daten.typ": Style
#let literatur() = {
  bibliography(
    "/Quellen.bib", //biblatex file, kann von fast allen Zitierhilfsprogrammen ausgegeben werden
    title: none, //wird in main.typ betitelt
    full: false, //ob man alle oder nur die zitierten Quellen angibt
    style: Style, // man kann eigene CSL-Dateien hinzufügen und deren Stil nehmen
  )
}