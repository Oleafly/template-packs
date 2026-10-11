#import "/layout/proposal_template.typ": *
#import "/layout/author_declaration.typ": *

#let metadata = toml("metadata.toml")
#set document(title: metadata.thesis.title, author: metadata.author.name)
#show: proposal.with(metadata, bib_path: "/thesis.bib")

// =============================================================================
// =============================== Front matter ================================
// =============================================================================

#table-of-contents()

// =============================================================================
// =============================== Main content ================================
// =============================================================================

#include "content/chapter01.typ"
#include "content/chapter02.typ"

// =============================================================================
// ============================= Appendix section ==============================
// =============================================================================

#pagebreak(weak: true)

#author_declaration(
  metadata.author.name,
  metadata.author.signature_place,
  metadata.dates.submission,
  metadata.settings.language,
)
#list-of-figures()
#list-of-tables()

