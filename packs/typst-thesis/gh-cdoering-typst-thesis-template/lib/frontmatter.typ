// =============================================================================
// VORSPANN: ABSTRACT UND VERZEICHNISSE
//
// MUSS als Show-Rule angewendet werden:
//   #show: doc => frontmatter(cfg, abstract: include "chapters/00-abstract.typ", doc)
//
// Grund: set-Regeln gelten in Typst nur innerhalb des Blocks, in dem sie
// stehen. Bei einem gewoehnlichen Funktionsaufruf wuerde der Wechsel von
// roemischer auf arabische Seitennummerierung nur innerhalb des Rueckgabe-
// werts wirken -- der Textteil bliebe ohne Seitenzahlen.
//
// Seitenzaehlung:
//   Sperrvermerk       ohne Seitenzahl
//   Abstract           ohne Seitenzahl
//   Verzeichnisse      roemisch, beginnend bei I
//   Danksagung         roemisch
//   Textteil bis Ende  arabisch, beginnend bei 1
// =============================================================================

#import "@preview/glossarium:0.5.10": print-glossary
#import "../acronyms.typ": entry-list
#import "../symbols.typ": symbol-groups
#import "helpers.typ": symgroup, symtable, listing-kind
#import "i18n.typ": t

#let frontmatter(cfg, confidentiality: none, abstract: none, acknowledgements: none, body) = {
  let s = cfg.sections

  // --- Sperrvermerk und Abstract -------------------------------------------
  // Beide ohne Seitenzahl, unmittelbar nach dem Titelblatt.
  if s.confidentiality and confidentiality != none {
    set page(numbering: none)
    confidentiality
    pagebreak()
  }

  if s.abstract and abstract != none {
    set page(numbering: none)
    abstract
    pagebreak()
  }

  // --- Roemische Nummerierung ----------------------------------------------
  set page(numbering: "I", number-align: bottom + right)
  counter(page).update(1)

  // --- Inhaltsverzeichnis --------------------------------------------------
  if s.toc {
    // Code-Block statt block[...]: begrenzt die show-Regel, erzeugt aber
    // keinen Container. In einem Container waere der Seitenumbruch, den die
    // Kapitelueberschrift ausloest, nicht erlaubt.
    {
      show outline.entry: set block(above: cfg.toc_spacing, below: cfg.toc_spacing)
      outline(title: t.toc, depth: cfg.toc_depth)
    }
    pagebreak()
  }

  // --- Abkuerzungsverzeichnis ----------------------------------------------
  if s.acronyms {
    heading(level: 1, numbering: none, outlined: true)[#t.acronyms]
    let sorted = entry-list.sorted(key: it => lower(it.short))
    grid(
      columns: (6em, 1fr),
      column-gutter: 2em,
      row-gutter: 0.45em,
      ..sorted.map(e => ([*#e.short*], [#e.long])).flatten()
    )
    pagebreak()
  }

  // --- Symbolverzeichnis ---------------------------------------------------
  if s.symbols and symbol-groups.len() > 0 {
    heading(level: 1, numbering: none, outlined: true)[#t.symbols]
    for (i, group) in symbol-groups.enumerate() {
      symgroup(group.at(0), first: i == 0)
      symtable(group.at(1))
    }
    pagebreak()
  }

  // --- Abbildungsverzeichnis -----------------------------------------------
  if s.figures {
    heading(level: 1, numbering: none, outlined: true)[#t.figures]
    outline(title: none, target: figure.where(kind: image))
    pagebreak()
  }

  // --- Tabellenverzeichnis -------------------------------------------------
  if s.tables {
    heading(level: 1, numbering: none, outlined: true)[#t.tables]
    outline(title: none, target: figure.where(kind: table))
    pagebreak()
  }

  // --- Quelltextverzeichnis ------------------------------------------------
  if s.listings {
    heading(level: 1, numbering: none, outlined: true)[#t.listings]
    outline(title: none, target: figure.where(kind: listing-kind))
    pagebreak()
  }

  // --- Danksagung ----------------------------------------------------------
  // Nach den Verzeichnissen, noch mit roemischer Seitenzahl.
  if s.acknowledgements and acknowledgements != none {
    acknowledgements
    pagebreak()
  }

  // --- Textteil ------------------------------------------------------------
  set page(numbering: "1", number-align: bottom + right)
  counter(page).update(1)

  // Die unnummerierten Vorspann-Ueberschriften haben den Kapitelzaehler
  // hochgezaehlt. Ohne diesen Reset begaenne die Einleitung nicht bei 1.
  counter(heading).update(0)

  // Erzeugt die Sprungmarken, auf die #gls() im Fliesstext verweist. Laeuft
  // IMMER -- der Schalter cfg.sections.acronyms steuert nur die sichtbare
  // Liste. Ohne diesen Aufruf brechen alle #gls()-Verweise ab.
  //
  // Der Aufruf steht bewusst GANZ AM ENDE des Dokuments: place(hide(...))
  // belegt die Seite, auf der es notiert ist. Stand es im Vorspann oder
  // unmittelbar vor dem Textteil, galt eine frisch umgebrochene Seite als
  // benutzt -- der Seitenumbruch der folgenden Kapitelueberschrift loeste
  // dann erneut aus und hinterliess eine sichtbar leere Seite mit blosser
  // Seitenzahl. Am Dokumentende folgt keine Ueberschrift mehr, die Marken
  // landen auf der letzten ohnehin gefuellten Seite.
  //
  // Fuer die Aufloesung von #gls() ist die Position unerheblich: Typst sucht
  // Labels dokumentweit.
  body
  place(hide(print-glossary(entry-list, show-all: true, disable-back-references: true)))
}
