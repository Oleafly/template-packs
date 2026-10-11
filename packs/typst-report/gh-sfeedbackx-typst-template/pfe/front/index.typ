// ======================================================
// FRONT MATTER INDEX
// ------------------------------------------------------
// Includes dedication, acknowledgment, table of contents,
// and lists of figures/tables/abbreviations.
// ======================================================

#set page(
  footer: context {
    stack(
      dir: ttb,
      spacing: 8pt,
      line(length: 100%, stroke: 0.5pt),
      align(right, counter(page).display()),
    )
  },
  numbering: "i",
)
#counter(page).update(1)

#set par(justify: true)

// Uncomment the next line to include signature pages:
// #include "signature.typ"

#include "dedication.typ"
#include "acknowledgment.typ"
#include "navigation.typ"
