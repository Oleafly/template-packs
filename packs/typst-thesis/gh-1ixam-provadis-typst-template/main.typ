#import "template.typ": Template
#import "chapters/appendix.typ": appendix_content
#import "@preview/glossarium:0.5.10": make-glossary, register-glossary, print-glossary, gls, glspl



/*#show: make-glossary
  ( key: "oidc", short: "OIDC", long: "Open ID Connect" ),
  ( key: "haus", short: "Haus", long: "Konstruktion bestehend aus 4 Wänden und einem Dach" ),
)
#register-glossary(my_entries)
#print-glossary(
 my_entries
)*/



#show: Template.with(
  bib: arguments("sources.bib", style: "ieee"), 
  appendix: appendix_content,
  show_lists_after_content: false,
  confidental_clause: false,
  abbreviation_entries: (
    ( key: "llm", short: "LLM", long: "Large Language Model" ),
  ),
  
  glossary_entries: (
/*     (
    key: "apl",
    short: "APL",
long: "A proprietary, high-level programming language used within the Digital Route MediationZone platform to implement custom data processing workflows."
  ), */
  ),
  ai_entries: (
    ( "ChatGPT 6.7", "Schreib meine Bachelorarbeit", "Bachelorarbeit schreiben lassen und lieber Fortnite zocken" ),
/*     ( "OpenAI ChatGPT", "Schreib meine Bachelorarbeit", "Bachelorarbeit schreiben lassen und lieber Fortnite zocken" ),
    ( "Google Gemini", "Gib mir Motivationstipps", "Die Nerven beibehalten" ) */
  ),
  /* for us to decide, nice for marketing */
  abstract: [
kurze Übersicht zur Arbeit
  ],
  //preface: []
)

#include "chapters/01_einleitung.typ"
#pagebreak()
#include "chapters/02_grundlagen.typ"
#pagebreak()
#include "chapters/03_methode.typ"
#pagebreak()
#include "chapters/04_umsetzung.typ"
#pagebreak()
#include "chapters/05_evaluierung.typ"
#pagebreak()
#include "chapters/06_diskussion.typ"
#pagebreak()
#include "chapters/07_fazit.typ"
#pagebreak()

