// ═══════════════════════════════════════════════════════════════════════════
// MAIN — the whole thesis
// ═══════════════════════════════════════════════════════════════════════════
//
//   typst compile main.typ        build main.pdf once
//   typst watch main.typ          rebuild on every save
//
// This file has two jobs: apply the template, and list the pieces of the
// thesis in the order they should appear. All the settings live in config.typ.

#import "config.typ": thesis-info, bib-file, bib-style
#import "lib/thesis.typ": thesis
#import "lib/abbreviations.typ": setup-abbreviations
#import "lib/appendix.typ": appendix
#import "lib/blocks.typ": show-todos, strict-todos
#import "lib/utils.typ": strict-xref

// Draft notes (`#todo[...]`, `#mark[...]`) are highlighted while this is
// `true` and invisible while it is `false`.
#show-todos.update(true)

// Set this to `true` for the version you hand in: the thesis then refuses to
// compile while a single draft note is left anywhere in it, and names them
// all in one error. Hiding notes with `show-todos` does not get past it.
#strict-todos.update(false)

// In the complete thesis every `#xref(<label>, [fallback])` must find its
// target, so a missing or misspelled label is a compile error rather than a
// fallback that quietly reads "Chapter 3" forever. preview.typ leaves this
// off, because there the other chapters really are absent.
#strict-xref.update(true)

// Expand acronyms such as `@AUC`. Must come before the template so that the
// front matter and the table of contents are covered too.
#show: setup-abbreviations

// Apply the template. `..thesis-info` spreads every entry of the dictionary in
// config.typ into a named argument of `thesis()`.
#show: thesis.with(
  ..thesis-info,

  // Front matter: no chapter numbers, roman page numbers, printed before the
  // table of contents.
  frontmatter: [
    #include "frontmatter/acknowledgements.typ"
    #include "frontmatter/summary.typ"
    #include "frontmatter/publications.typ"
  ],
)

// ═══════════════════════════════════════════════════════════════════════════
// CHAPTERS — numbered, page numbering restarts at 1
// ═══════════════════════════════════════════════════════════════════════════

#include "chapters/01-introduction.typ"
#include "chapters/02-theory.typ"
#include "chapters/03-results.typ"
#include "chapters/04-conclusion.typ"

// ═══════════════════════════════════════════════════════════════════════════
// BIBLIOGRAPHY
// ═══════════════════════════════════════════════════════════════════════════

#bibliography(bib-file, style: bib-style)

// ═══════════════════════════════════════════════════════════════════════════
// APPENDIX — chapters become A, B, C ...; figures become A.1, A.2, ...
// ═══════════════════════════════════════════════════════════════════════════

#show: appendix

#include "appendix/abbreviations.typ"
#include "appendix/symbols.typ"
#include "appendix/lists.typ"
#include "appendix/supplementary.typ"

