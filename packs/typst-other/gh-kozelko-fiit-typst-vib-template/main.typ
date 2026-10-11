#import "template.typ": project

#show: project.with(
  name: "Bc. Meno Priezvisko",
  title: "Master's Thesis Title / Názov diplomovej práce",
  subtitle: "Research Proposal / Výskumný zámer",
  note: [
    _Výskumný zámer môže byť v EN alebo SK, rovnako ako DP téma._\
    _Pište celý dokument len v jednom jazyku (SK alebo EN), nemixujte jazyky._
  ],
  page-limit: "Max 12 pages with 12 references",
  study-programme: "Intelligent Software Systems",
  study-field: "Computer Science",
  supervisor: "doc. Ing. Giang Nguyen Thu, PhD.",
  date: "November 202x",
)

// Bibliography setup
#let bibliography-file = "mybib.bib"

= Introduction / Úvod <intro>

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.

= Related Work / Prehľad súčasného stavu problematiky <sota>
@wu2023federated @deep-learning.

== Oblasť výskumu (napr. Recommender System)

=== Užšia oblasť výskumu (napr. Data Privacy)

K všeobecným znamným veciam ako všeobecne o RecSys len stručne ak musia byť. Sú klasické ale nie sú nové.

== Výberové inteligentné riešenie (napr. AI deployment)

=== Hlboké učenie / Deep Learning

K všeobecným znamným veciam ako všeobecne o AI, ML, NN len stručne ak musia byť. Sú klasické ale nie sú nové.

== (Výberové) inteligentné riešenie vo (užšej) oblasti výskumu <selected>

=== Výberová _1_ v kontexte ...

=== Výberová _n_ v kontexte ...

== Summary / Zhrnutie <summary>

Find a gap(s) in some research areas, identify the need of our society, define a way to improve/fill these gaps, and the innovative potential of proposed solutions to address the need.

= Research Objectives / Východiskové body výskumu <objectives>

Na základe analýzy, navrhujem nasledujúce ciele diplomovej práce:
- výskumná otázka - research objective 01
- výskumná otázka - research objective (max) 03

s nasledujúcimi potencionálnymi špecifikáciami
- funkcionálne
- nefunkcionálne

= Realization / Realizácia <realization>

== Realization Plan / Plán realizácie <plan>

- Komplexná analýza problematiky
- Návrh prototypu
- Implementácia
- Overenie riešenia a vyhodnotenie
- Nasadenie riešenia
- Perspektíva ďalšej práce vo výskumnej oblasti.

Spôsob výberu a práca s ... je momentálne predmetom diskusie spolu s výberom najvhodnejších ... / The realization plan will be adopted in the next phases based on a deeper study of the research area.

== Evaluation Plan / Plán vyhodnotenia výsledkov <eval>

- Metrics: ML/DL, NLP, RecSys, distance, similarity, privacy, quality, security, compression, loss, errors... Vlastne metriky, dodefinovane metriky, porovnavanie s inými pristupmi...
- Monitoring, monitoring systems, ... Meranie výkonnosti, runtime, complexity ... Sledovanie požiadaviek na pamäť, hardware, libaries, storage ...

== Supporting Tools / Podporné nástroje <tools>

- Communication - Microsoft Teams
- Code management - GitHub repository
- Documentation preparation (PDF) - Overleaf
- File sharing - Google Drive
- Programming language - Python, ... others ...

== Timeline / Harmonogram <timeline>

- DP1 plan
- DP2 plan
- DP3 plan

= Conclusion / Záver <conclusion>

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.

#pagebreak()

#bibliography(bibliography-file, title: "References", style: "ieee")

#pagebreak()

// Switch to appendix numbering
#counter(heading).update(0)
#set heading(numbering: "A.1.1")

= Assignment / Zadanie <zadanie>

Supervisor / Vedúci DP: doc. Ing. Giang Nguyen Thu, PhD.\
Diplomant: Bc. Meno Priezvisko

*Keywords / Oblasť problematiky: 3 kľúčové slová*

Zadanie môže byť v SK alebo EN podľa dohody s vedúcim DP.\
_The assignment can be in SK or EN based on the agreement with the supervisor._

== Master's Thesis Title in English

== Názov diplomovej práce v slovenčine

_Vysvetlenie: Text zadania obsahuje stručnú motiváciu k výskumnému problému (1-3 vety), čo má študent analyzovať, preskúmať, na čo sa má pri tom zamerať; odporúčame pri tom použiť priamu formuláciu "*Analyzujte*..."._

_Ďalej čo má študent navrhnúť (tu je potenciál pre nové poznatky); odporúčame použiť priamu formuláciu "*Navrhnite metódu / model / reprezentáciu / prístup* ...". Je vhodné uviesť aj prípadné ohraničenia._

_Dôležité je uviesť v zadaní ako má študent preukázať vlastnosti navrhnutého riešenia (spôsob overenia), napr. "Navrhnuté riešenie *vyhodnoťte* v kontexte ... vytvorením softvérového prototypu... experimentujte s navrhnutým riešením v doméne..."_

_(Source: YonBan)._

_Hlavným výsledkom diplomovej práce by mala byť *metóda* alebo *prístup*._

_Text zadania má obsahovať od 500 do 1700 znakov vrátane medzier. Príklad je dole._

*Úvodný paragraf k problematike ... 3 vety ... stručná motivácia DP.* Motivačná časť: aká je motivácia k téme Vašej DP? Aké sú medzery, nedostatok venovaniu, nedostatok riešenia, alebo žiaduci trend či potreby z praxu (identify the gaps and the needs) v danej oblasti? Prečo ste si zvolili nejaké moderné, pokrokové technológie (napr. NN či DL)? Prečo nestačia iné podobné ale iné techniky či technológie na riešenie Vašej DP? Čo očakavate ako prínos Vašej práce do IT oblasti?

*Analyzujte* súčasný stav problematiky v oblasti ... *Navrhnite metódu / prístup* na ... Navrhnuté riešenie vyhodnoťte v kontexte … vytvorením softvérového prototypu. *Implementujte* vybrané aspekty návrhu riešenia na ... Cieľom je vytvorenie takého riešenia, ktoré bude schopné ... Zároveň je důležité navrhnúť ... tak, aby dosahoval čo najlepšie výsledky pri určitých podmienkach ... Ako jeden z niekoľkých prostriedkov preskúmajte možnosť ... v doméne ... *Vyhodnoťte* navrhnuté riešenie pomocou dostupných metrík ... v kontexte ... Porovnajte dosiahnuté výsledky s inými prístupmi.

*Literatúra / References:* 2 papers (journal/conf. STN ISO 690) + DOI
