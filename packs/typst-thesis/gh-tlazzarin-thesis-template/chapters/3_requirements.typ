#import "../config/thesis-config.typ": glpl
#import "data/requirements_list.typ": *

#pagebreak(to:"odd")

= Analisi dei requisiti<cap:analisi-requisiti>

#text(style: "italic", [
    In questo capitolo effettuo l'analisi degli utenti, sviluppo le user stories e compongo la lista dei requisiti dividendoli per tipologia e necessità.
])
#v(1em)

== Analisi degli utenti

== User stories<cap:user-stories>
Nel contesto dello sviluppo agile...

== Lista delle user stories<cap:lista-user-stories>
#[
#set heading(
  numbering: (..numbers) => {
    let level = numbers.pos().len()
    if (level == 4) {
      return numbering("US1", numbers.pos().at(level - 1))
    }
  }
)
#set heading(supplement: none)
#let d = [*Descrizione: *]
#let ac = [#v(0.5em) *Acceptance criteria: *]

#heading(numbering: none, level: 3)[Epic 1. Gestione utenti]
==== Login<us:login>
#d Come utente non autenticato, voglio poter fare il login per accedere alle funzionalità dell’applicativo.\
#ac
1. L'utente deve poter inserire le proprie credenziali (email e password) in un modulo di login.
2. Se l’utente inserisce credenziali corrette, il sistema reindirizza l'utente alla dashboard.
3. Se l’utente inserisce credenziali errate, il sistema mostra un messaggio di errore.

==== Registrazione<us:registrazione>
#d Come utente non autenticato, voglio potermi registrare per accedere alla piattaforma.
#ac
1. L'utente deve poter compilare un modulo di registrazione con i campi richiesti (nome, cognome, email, password).
2. Il sistema effettua la verifica che l’utente non sia già registrato in piattaforma.
3. Dopo la verifica, il sistema invia una email all’utente che si sta registrando con un codice per poter attivare il proprio account.
4. Quando l'utente inserisce il codice ricevuto nella webapp, il suo account viene attivato e ha la possibilità di accedere.
]

== Tracciamento dei requisiti
Ad ogni requisito è associato un codice costruito in base alle sue caratteristiche:
#v(1em)
#align(center)[*(F/Q/C)(M/D/O)R*]
#v(1em)
#set list(marker: none)
- F (_Functional_): definisce una funzione di un sistema o dei suoi componenti;
- Q (_Qualitative_): rappresentano come il sistema deve essere per soddisfare i requisiti dello stakeholder;
- C (_Constraint_): rappresentano dei vincoli o dei limiti che il sistema deve rispettare;
#v(0.5em)
- M (_Mandatory_): irrinunciabili per qualcuno degli stakeholder;
- D (_Desirable_): non strettamente necessari ma a valore aggiunto riconoscibile;
- O (_Optional_): relativamente utili oppure contrattabili anche in fasi avanzate del progetto;
#v(0.3em)
- R (_Requirement_): requisito
#v(1em)
In @tab:requisiti-funzionali, @tab:requisiti-qualitativi e @tab:requisiti-vincolo sono riassunti i requisiti e il loro tracciamento con gli use case delineati in fase di analisi.
#[
#show figure: set block(breakable: true)
#set table(
  align: (center+horizon, left+horizon, center+horizon),
  columns: (auto, 5fr, 1.5fr),
)
#v(1em)
#figure(
    table(
        table.header([*Codice*], [*Descrizione*], [*Fonti*]),
        ..getFR().flatten()
    ),
    caption: "Tracciamento dei requisiti funzionali.",
)
<tab:requisiti-funzionali>

#v(2em)
#figure(
    table(
      align: (center+horizon, left+horizon, center+horizon),
      table.header([*Codice*], [*Descrizione*], [*Fonti*]),
      ..getQR().flatten()
    ),
    caption: "Tracciamento dei requisiti di qualità.",
)
<tab:requisiti-qualitativi>

#v(2em)
#figure(
    table(
      align: (center+horizon, left+horizon, center+horizon),
      table.header([*Codice*], [*Descrizione*], [*Fonti*]),
      ..getCR().flatten()
    ),
    caption: "Tracciamento dei requisiti di vincolo.",
)
<tab:requisiti-vincolo>

#v(2em)
Di seguito, nella @tab:riepilogo-requisiti ho inserito il riepilogo dei requisiti, suddivisi per tipologia e necessità.
#v(1em)
#show figure: set block(breakable: false)
#figure(
  table(
    columns: (auto, 1fr, 1fr, auto, auto),
    table.header([*Tipo*], [*Mandatory*], [*Desirable*],[*Optional*], [*Somma*]),
    [Functional], [#getFR(getLen: true).at(0)], [#getFR(getLen: true).at(1)], [#getFR(getLen: true).at(2)], [#getFR(getLen: true).sum()],
    [Qualitative], [#getQR(getLen: true).at(0)], [#getQR(getLen: true).at(1)], [#getQR(getLen: true).at(2)], [#getQR(getLen: true).sum()],
    [Constraint], [#getCR(getLen: true).at(0)], [#getCR(getLen: true).at(1)], [#getCR(getLen: true).at(2)], [#getCR(getLen: true).sum()],
    [*Totale*],
      [*#{getFR(getLen: true).at(0)+getQR(getLen: true).at(0)+getCR(getLen: true).at(0)}*],
      [*#{getFR(getLen: true).at(1)+getQR(getLen: true).at(1)+getCR(getLen: true).at(1)}*],
      [*#{getFR(getLen: true).at(2)+getQR(getLen: true).at(2)+getCR(getLen: true).at(2)}*],
      [*#{getFR(getLen: true).sum()+getQR(getLen: true).sum()+getCR(getLen: true).sum()}*],
    align: (center+horizon)
  ),
  caption: "Riepilogo dei requisiti."
)<tab:riepilogo-requisiti>
]
