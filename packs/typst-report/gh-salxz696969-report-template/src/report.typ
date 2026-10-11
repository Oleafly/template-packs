// DO NOT EDIT ANYTHING APART FROM THE AREA MENTIONED TO BE EDITABLE

#import "theme/global-theme.typ": main-style
#import "theme/header-style.typ": centered-unnumbered-header, numbered-header

// Global styling
#show: main-style

#set page(numbering: "I")
#counter(page).update(1)
#show: centered-unnumbered-header

// Acknowledgement, Abstracts, TOC, etc.
#include "chapters/0_intro.typ"

#set page(numbering: "1")
#counter(page).update(1)
#show: numbered-header

// ========= Move these files to reorder ======================================

#include "chapters/1_introduction.typ"
#include "chapters/2_project_definition.typ"
#include "chapters/3_literature.typ"
#include "chapters/4_project_analysis.typ"
#include "chapters/5_detail_concept.typ"
#include "chapters/6_implementation.typ"
#include "chapters/7_conclusion.typ"

// ============================================================================
#set heading(numbering: none)
#show: centered-unnumbered-header

= REFERENCES
#bibliography("references.bib", style: "ieee", title: none)

#include "chapters/x_appendices.typ"
