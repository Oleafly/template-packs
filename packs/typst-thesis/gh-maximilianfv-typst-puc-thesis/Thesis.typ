// Thesis.typ — mirrors Thesis.tex of the original LaTeX template
#import "pucthesis.typ": *

#show: pucthesis.with(
  mdate: "Month Day, Year",
  version: "1",
  title: "(LONG THESIS TITLE)",
  author: "Author's name",
  address: [Escuela de Ingeniería \
    Pontificia Universidad Católica de Chile \
    Vicuña Mackenna 4860 \
    Santiago, Chile \
    _Tel._ : 56 (2) 354-2000],
  email: "username@uc.cl",
  faculty-to: "the School of Engineering",
  faculty: "Faculty of Engineering",
  degree: "Master of Science in Engineering",
  advisor: "Professor's name",
  committee-member-a: "Member A",
  guest-member-a: "Member B",
  ogrs-member: "Member C",
  subject: "Structural Engineering",
  date: "Month Year",
  copyright-name: "Author's name",
  copyright-year: "MMXV",
  dedication: [Gratefully to my parents and siblings],
  spanish: false,
)

// ===== PRELIMINARIES: pages i & ii cover, page iii dedication (automatic) ====

// page iv: ACKNOWLEDGEMENTS
#heading(level: 1, numbering: none)[ACKNOWLEDGEMENTS] <acknowledgements>
#include "chapters/acknowledgments.typ"

// pages v+: TOC, LOF, LOT
#toc()
#lof()
#lot()

// ABSTRACT — RESUMEN
#heading(level: 1, numbering: none)[ABSTRACT] <abstract>
#include "chapters/abstract.typ"

#heading(level: 1, numbering: none)[RESUMEN] <resumen>
#include "chapters/resumen.typ"

// ===== TEXT OF THESIS (\pagenumbering{arabic}) ================================
#set page(numbering: "1")
#counter(page).update(1)
#counter(heading).update(0)

= Introduction
#include "chapters/introduction.typ"

= Chapter 1 <ch1>
#include "chapters/chapter1.typ"

= Chapter 2 <ch2>
#include "chapters/chapter2.typ"

= Conclusions
#include "chapters/conclusions.typ"

// ===== REFERENCES =============================================================
#heading(level: 1, numbering: none)[REFERENCES] <references>
#bibliography("Thesis.bib", style: "apa", title: none)

// ===== APPENDICES =============================================================
#show: appendix

= First Appendix
#include "chapters/appendix1.typ"

= An Interesting Short Story
#include "chapters/appendix2.typ"
