#import "thesis.typ"                             // szablon pracy

// Konfiguracja szablonu:
#show: thesis.setup.with(

  type: "Projekt inżynierski",                   // rodzaj pracy

  topic-pl: "Szablon pracy dyplomowej",          // tytuł pracy
  topic-en: "Thesis template",                   // PL oraz EN
  
  abstract-pl: read("dodatki/streszczenie.txt"), // streszczenie
  abstract-en: read("dodatki/abstract.txt"),     // PL oraz EN
  
  keywords-pl: ("słowo 1", "słowo 2"),           // słowa kluczowe
  keywords-en: ("keyword 1", "keyword 2"),       // PL oraz EN
  
  promoter: "Promotor pracy",                    // dane promotora
  institute: "Nazwa jednostki",                  // jednostka
  department: "Nazwa wydziału",                  // wydział
  field: "Kierunek studiów",                     // kierunek 
  spec: "Specjalność",                           // specjalność
  year: "2026",                                  // rok złożenia
  
  authors: (                                     // autorzy:
    (name: "Autor Pierwszy", uuid: 123456),      //   pierwszy
    (name: "Autor Drugi", uuid: 654123),         //   drugi
  ),
  
)

// Rozdziały zasadnicze pracy:
#include "rozdzialy/wstep.typ"
#include "rozdzialy/formatowanie.typ"
#include "rozdzialy/wykresy.typ"
#include "rozdzialy/kompilacja.typ"
#include "rozdzialy/wnioski.typ"

// Opcjonalne załączniki do pliku PDF:
#pdf.attach("main.typ",
  relationship: "source",
  mime-type: "text/x-typst",
  description: "Plik źródłowy dokumentu",
)

#pdf.attach("thesis.typ",
  relationship: "supplement",
  mime-type: "text/x-typst",
  description: "Plik szablonu dokumentu",
)
