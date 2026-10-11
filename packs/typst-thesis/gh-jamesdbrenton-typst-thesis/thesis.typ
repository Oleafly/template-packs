// ******************************************************************************
// thesis.typ -- main entry point (the counterpart of thesis.tex)
//
// Compile with:  typst compile thesis.typ
// (add --font-path fonts if you're using a font option that isn't bundled
// with Typst -- see README.md's "Fonts" section for which ones need it)
// ******************************************************************************

#import "template.typ": *
#import "thesis-info.typ": *

// ******************************************************************************
// thesis() options -- mirrors \documentclass[...]{lualatex-thesis}
// ******************************************************************************
//
// font: "latin-modern" (default, bundled) | "times" (STIX Two) |
//       "fourier" (Erewhon) | "libertinus" (Libertinus) |
//       "cambridge" (Open Sans/Fira Math body, Feijoa headings -- commercial
//       font, see README.md's "Fonts" section)
//
// mode: "online" (default: same margins as print, blue links) |
//       "print" (adds a 5mm binding-offset margin, black links) |
//       "screen" (symmetric 25mm margins, forces twoside: false, blue
//       links -- the electronic exam-copy mode)
//
// twoside: true (default) | false -- ignored (forced false) under
//          mode: "screen"
//
// page-style: "default" (this port's folio-in-footer convention) |
//             "I" (name + folio combined in header, empty footer) |
//             "II" (name in header, folio in footer)
//
// Bibliography style is NOT a thesis() argument -- it's set separately,
// at the #bibliography(...) call near the bottom of this file, via
// resolve-bib-style(...). Pass it one of:
//   "numbered" (default, IEEE-style numeric) | "authoryear" (APA-style) |
//   "nature" (CSL project's official Nature style) | "csl" (same file as
//   "nature" here -- swap the path in template.typ's bib-style-table to
//   point at a different journal's .csl file, downloaded from
//   zotero.org/styles)
//
// This demo mirrors the LaTeX repo's thesis.tex, which currently uses
// [times, nature, screen] -- the LaTeX class's `index` option has no
// direct Typst equivalent and isn't ported (see README.md).
#show: thesis.with(
  title: thesis-title,
  author: thesis-author,
  keywords: thesis-keywords,
  font: "",
  mode: "screen",
)

// ******************************** Front matter ********************************
#title-page(
  title: thesis-title,
  subtitle: thesis-subtitle,
  author: thesis-author,
  department: thesis-department,
  university: thesis-university,
  crest: thesis-crest,
  college-shield: thesis-college-shield,
  supervisor: thesis-supervisor,
  advisor: thesis-advisor,
  degree-title: thesis-degree-title,
  college: thesis-college,
  degree-date: thesis-degree-date,
)

#show: frontmatter

#include "front/dedication.typ"
#include "front/declaration.typ"
#include "front/acknowledgements.typ"
#include "front/abstract.typ"

#thesis-outline()

// ******************************** Main matter *********************************
#show: mainmatter

#include "chapters/chapter1.typ"
#include "chapters/chapter2.typ"
#include "chapters/chapter3.typ"

// ******************************** Bibliography *********************************
#heading(numbering: none, outlined: false)[References]
#bibliography("References/references.bib", title: none, style: resolve-bib-style("nature"))

// ******************************** Appendices ***********************************
#show: appendices

#include "appendix/appendix1.typ"
#include "appendix/appendix2.typ"
