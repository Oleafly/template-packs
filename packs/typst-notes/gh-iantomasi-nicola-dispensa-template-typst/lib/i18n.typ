#let default-lang = "it"

#let strings = (
  it: (
    index: "Indice",
    figure-supplement: "Fig.",
    before-you-start: "Prima di cominciare",
    contents: "CONTENUTI",
    main-sources: "FONTI PRINCIPALI",
    sources-note: "A questi si aggiungono le slide del corso e il materiale fornito dal docente.",
    fair-use-label: "Fair use.",
    fair-use-text: (
      course,
      university,
    ) => [Il materiale — testi, diagrammi ed esercizi — è tratto dai volumi sopra citati, salvo diversa indicazione, ed è impiegato in quantità limitata a scopo didattico per gli studenti del corso #course presso l'#university; non ha finalità commerciali. Per un approfondimento si rimanda ai testi originali.],
    license-label: "Licenza.",
    license-text: (
      author,
      year,
      cdl,
      university,
      university-short,
    ) => [© #author, #year. Uso riservato agli studenti del Corso di Laurea in #cdl, #university (#university-short); ogni riproduzione o distribuzione al di fuori di questo contesto richiede autorizzazione scritta dell'autore.],
    feedback-label: "Feedback.",
    feedback-text: "Errori o suggerimenti:",
    support-label: "Sostieni il progetto.",
  ),
  en: (
    index: "Contents",
    figure-supplement: "Fig.",
    before-you-start: "Before you start",
    contents: "CONTENTS",
    main-sources: "MAIN SOURCES",
    sources-note: "In addition to these, course slides and material provided by the instructor are used.",
    fair-use-label: "Fair use.",
    fair-use-text: (
      course,
      university,
    ) => [The material — text, diagrams and exercises — is drawn from the volumes cited above, unless otherwise noted, and is used in limited amounts for educational purposes for students of the #course course at #university; it has no commercial purpose. Please refer to the original texts for further study.],
    license-label: "License.",
    license-text: (
      author,
      year,
      cdl,
      university,
      university-short,
    ) => [© #author, #year. For use by students of the degree course in #cdl, #university (#university-short) only; any reproduction or distribution outside this context requires the author's written permission.],
    feedback-label: "Feedback.",
    feedback-text: "Errors or suggestions:",
    support-label: "Support this project.",
  ),
)

#let t(key, lang: default-lang) = {
  let table = strings.at(lang, default: strings.at(default-lang))
  table.at(key, default: "[" + key + "]")
}
