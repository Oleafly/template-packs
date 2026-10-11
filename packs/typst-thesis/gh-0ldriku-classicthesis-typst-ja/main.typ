#import "lib.typ": *
#import "config.typ": *
#import "@preview/glossarium:0.5.9": make-glossary, register-glossary, print-glossary, gls, glspl, Gls, Glspl
#import "frontmatter/abbreviations.typ": abbreviation-list
#import "@preview/cjk-unbreak:0.1.0": remove-cjk-break-space

#show: project.with(
  title: myTitle,
  author: myName,
)

#show: make-glossary
#register-glossary(abbreviation-list)
#show: bib-init
#show: equation
//#show: remove-cjk-break-space

//#show: cjk-spacer

// --- Marginalia Setup ---

#show: marginalia.setup.with(
  inner: ( far: 5mm, width: 15mm, sep: 5mm ),
  outer: ( far: 5mm, width: 35mm, sep: 5mm ),
  top: 30mm,
  bottom: 40mm,
  book: true,
)
// --- Todo and Version History Page (Draft Mode) ---
#include "frontmatter/todo_page.typ"
#include "frontmatter/changelog_page.typ"
#if draft {
  cleardoublepage()
}
// --- Frontmatter ---
// Roman numbering, plain footer (page number at bottom center), no header
#set page(numbering: "i", header: none, footer: plain_footer)
#counter(page).update(1)

#include "frontmatter/title_page.typ"

#include "frontmatter/title_back.typ"

#include "frontmatter/committee.typ"

#cleardoublepage()
#include "frontmatter/dedication.typ"

#cleardoublepage()
#include "frontmatter/abstract.typ"

#cleardoublepage()
#include "frontmatter/publications.typ"

#cleardoublepage()
#include "frontmatter/acknowledgments.typ"

#cleardoublepage()
#outline(depth: 3, indent: auto)

#cleardoublepage()
#nof_break_outline(target: figure.where(kind: image), title: "図目次")
#v(6em)
#nof_break_outline(target: figure.where(kind: table), title: "表目次")

#include "frontmatter/toc_abb.typ"

// --- Mainmatter ---
// First, ensure we start on a physical odd page before resetting counter
#pagebreak(weak: true, to: "odd")

// Now set mainmatter page settings and reset counter
// Arabic numbering, fancy header/footer
#set page(numbering: "1", header: fancy_header, footer: fancy_footer)
#counter(page).update(1)

#part("ガイド")

#cleardoublepage()
#include "chapters/chapter01.typ"



#cleardoublepage()
#include "chapters/chapter02.typ"


#cleardoublepage()
#include "chapters/chapter03.typ"

#cleardoublepage()
#part("実例")

#cleardoublepage()
#include "chapters/chapter04.typ"



#cleardoublepage()
#part("付録")

#cleardoublepage()
#show: appendix_init
#include "chapters/appendix01.typ"
#cleardoublepage()
#include "chapters/appendix02.typ"


#cleardoublepage()
#bibliography-list(
  title:"引用文献",
  bib-sort: true,
  bib-full: false,
  ..bib-file(
    read("bib/Bibliography_en.bib"),
  ),
    ..bib-file(
    read("bib/Bibliography_ja.bib"),
  ),
      ..bib-file(
    read("bib/test_all_types.bib"),
  )
)
