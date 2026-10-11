#import "data/requirements_list.typ": *
#import "../config/variables.typ": *
#pagebreak(to:"odd")

= Conclusioni<cap:conclusioni>
#text(style: "italic", [
    In questo capitolo traggo le conclusioni sul progetto.
])
#v(1em)
== Consuntivo finale
Una volta terminato il progetto ho redatto il consuntivo orario finale nella @fig:tabella-calcolo-ore che suddivide in maniera approssimata le ore dedicate alle varie fasi.
#v(1em)
#set table(
  align: (center+horizon, center+horizon), 
)
#figure(
  caption: [Consuntivo orario finale.],
  table(
    columns: 2,
    table.header([*Fase*], [*Ore*]),
    [_Onboarding_ del progetto],[5],
    [Analisi dei requisiti],[30],
    [...], [...],
    [*Totale*],[320]
  )
)<fig:tabella-calcolo-ore>
#v(1em)

== Raggiungimento degli obiettivi

== Requisiti soddisfatti
Arrivato alla fine del progetto ho implementato...
#v(1em)
#figure(
  table(
    columns: (auto, 1fr, 1fr, auto, auto),
    table.header([*Tipo*], [*Mandatory*], [*Desirable*],[*Optional*], [*Somma*]),
    [Functional], [0/#getFR(getLen: true).at(0)], [0/#getFR(getLen: true).at(1)], [0/#getFR(getLen: true).at(2)], [0/#getFR(getLen: true).sum()],
    [Qualitative], [0/#getQR(getLen: true).at(0)], [0/#getQR(getLen: true).at(1)], [0/#getQR(getLen: true).at(2)], [0/#getQR(getLen: true).sum()],
    [Constraint], [0/#getCR(getLen: true).at(0)], [0/#getCR(getLen: true).at(1)], [0/#getCR(getLen: true).at(2)], [0/#getCR(getLen: true).sum()],
    [*Totale*],
      [*0/#{getFR(getLen: true).at(0)+getQR(getLen: true).at(0)+getCR(getLen: true).at(0)}*],
      [*0/#{getFR(getLen: true).at(1)+getQR(getLen: true).at(1)+getCR(getLen: true).at(1)}*],
      [*0/#{getFR(getLen: true).at(2)+getQR(getLen: true).at(2)+getCR(getLen: true).at(2)}*],
      [*0/#{getFR(getLen: true).sum()+getQR(getLen: true).sum()+getCR(getLen: true).sum()}*],
    align: (center+horizon)
  ),
  caption: "Riepilogo dei requisiti soddisfatti."
)<tab:requisiti-soddisfatti>
== Rischi occorsi e mitigati
I rischi emersi durante lo stage sono riportati in @fig:rischi-occorsi.\
#v(1em)
#figure(
  caption: [Rischi occorsi con la loro mitigazione.],
  table(
    columns: 2,
    table.header([*Descrizione*],[*Mitigazione*]),
    [*R1* -- Descrizione del rischio],[Soluzione]
  )
)<fig:rischi-occorsi>
#v(1em)
== Valutazione personale
