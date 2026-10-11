#import "Template/Thesis.typ": project
#import "Template/Thesis.typ": no-ai
#import "Template/Thesis.typ": use-ai
#import "Template/Config.typ": configure


// Hlavní soubor dokumentu, který obsahuje nastavení a vkládá jednotlivé kapitoly.

// --- Nastavení dokumentu ---

#show: project.with(
  title:      "Název práce SOC",
  title-en:   "Title of the SOC Thesis",
  author:     "Jméno Příjmení",
  school:     "Název školy",
  supervisor: "Titul. Jméno Příjmení",
  field:      18, // číslo oboru
  place:      "Město",
  year:       "2026",
  ai: use-ai(
    model: "google.gemini.com", 
    usage: "gramatických kontrol"
  ),
  abstract-cs: [
    Abstrakt v češtině...
  ],
  abstract-en: [
    Abstract in English...
  ],
  keywords-cs: ("klíčové slovo 1", "klíčové slovo 2", "klíčové slovo 3"),
  acknowledgement: [
    Poděkování...
  ],
  keywords-en: ("keyword 1", "keyword 2", "keyword 3"),
)


// --- kapitoly ---

#include "Intro.typ"
#include "Kapitola.typ"


// --- Literatura, Přílohy ---

#heading(level: 1, numbering: none, outlined: true)[Seznam obrázků]
#outline(
  title: none,
  target: figure.where(kind: "image"),
)

#heading(level: 1, numbering: none, outlined: true)[Seznam tabulek]
#outline(
  title: none,
  target: figure.where(kind: "table"),
)

#heading(level: 1, numbering: none, outlined: true)[Seznam kódů]
#outline(
  title: none,
  target: figure.where(kind: "code"),
)

#pagebreak()
#bibliography("literatura.bib")

#pagebreak()

#include "Appendicies.typ"
