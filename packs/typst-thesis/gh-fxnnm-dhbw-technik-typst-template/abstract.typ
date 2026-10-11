// ============================================================
//  DHBW Stuttgart – Kurzfassung / Abstract
// ============================================================

// Erstellt eine zweisprachige Abstract-Seite.
// german-text und english-text: Typst-Inhalt ([...])
#let abstract-page(german-text: [], english-text: []) = {
  pagebreak()

  // Kurzfassung (Deutsch)
  heading(numbering: none, level: 1)[Kurzfassung]
  v(0.3em)
  german-text

  v(1.5em)

  // Abstract (Englisch)
  heading(numbering: none, level: 1)[Abstract]
  v(0.3em)
  english-text
}
