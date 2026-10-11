#let meta = (
  title: "Dispensa",
  author: "Nome Cognome",
  mail: "nicola.iantomasi@studenti.unimi.it",
  date: "A.A. 2025/2026",
  university: "Università degli Studi di Milano",
  university-short: "UniMi",
  cdl: "Sicurezza dei Sistemi e delle Reti Informatiche",
  class: "Nome dell'Insegnamento",
  cfu: 6,
  version: "Version 1.0",
  lang: "en",
)

#let intro = [
  Questa dispensa raccoglie e riordina i contenuti del corso in un'unica
  mappa di studio: non sostituisce libri, slide o lezioni, ma aiuta a
  orientarsi, ripassare e collegare gli argomenti tra loro.
]

#let parts = (
  (
    title: "Theory",
    chapters: (
      (path: "chapters/ch1.typ", label: "Argomento 1.1"),
      // (path: "chapters/01-parte-1/02-altro-capitolo.typ", label: "Argomento 1.2"),
    ),
  ),
  // (
  //   title: "Parte 2",
  //   chapters: (
  //     (path: "chapters/argomento.typ", label: "Argomento 2.1"),
  //   ),
  // ),
)

#let topics = parts.map(part => (
  title: part.title,
  items: part.chapters.map(ch => ch.label),
))

#let sources = (
  "esempio_libro_2024",
  "esempio_articolo_2023",
)
