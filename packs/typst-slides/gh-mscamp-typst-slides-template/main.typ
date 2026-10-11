#import "@preview/diatypst:0.7.1": *
#import "@preview/physica:0.9.5": *

#show: slides.with(
  title: "Titolo della presentazione",
  subtitle: "Sottotitolo della presentazione",
  date: "dd/mm/yyyy",
  authors: "Autore",

  // Styling
  ratio: 16 / 9,
  layout: "medium",
  title-color: red.darken(20%),
  first-slide: true,
  toc: false,
  count: none,
  footer: false,
  theme: "full",
)

= Prima sezione

== Prima slide

#lorem(100)

/ *Blocco di testo con equazione*: #lorem(10) #align(
    center,
  )[ \ $curl (grad f), tensor(T, -mu, +nu), pdv(f, x, y, [1,2])$ ] \ #lorem(10)

== Seconda slide

#lorem(230)
