#import "config.typ"
#import "theme/global-theme.typ": main-style
#import "theme/header-style.typ": centered-unnumbered-header, numbered-header

// Blank placeholder pages — build.py overlays out/report-header.pdf here.
// Count is driven by config.header-page-count; edit it there, not here.
#{
  for _ in range(config.header-page-count) {
    pagebreak()
  }
}

//============================= Editable ======================================
#set document(title: config.title)
//=============================================================================
// Global styling
#show: main-style
#set page(numbering: "I")
#show: centered-unnumbered-header
#include "chapters/0_intro.typ"

#set page(numbering: "1")
#show: numbered-header
#counter(page).update(1)

// CONFIGURE: add/remove/reorder chapters here; each is numbered (level-1 heading).
//============================= Editable ======================================
#include "chapters/1_introduction.typ"
#include "chapters/2_project_definition.typ"
#include "chapters/3_literature.typ"
#include "chapters/4_project_analysis.typ"
#include "chapters/5_detail_concept.typ"
#include "chapters/6_implementation.typ"
#include "chapters/7_conclusion.typ"
//=============================================================================

#set heading(numbering: none)
#show: centered-unnumbered-header

= REFERENCES
#bibliography("references.bib", style: "ieee", title: none)

#include "chapters/x_appendices.typ"
