#import "../utils/style.typ": *
#import "../pages/preface-helpers.typ": (
  ai-usage-note, contribution-table, preface-publications_section,
)
#import "../config/publications.typ": (
  publication-chapter-footnote, publication-status-table,
)

#let preface-page(ctx, metadata) = {
  let style = ctx.style
  let locale = ctx.locale
  let contributions = metadata.at("preface_contributions", default: ())
  let sections = metadata.at("preface_sections", default: ())
  let publications = metadata.at("publications", default: ())
  let content = metadata.preface

  set page(
    margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 3cm),
    numbering: "i",
  )

  heading("Preface", numbering: none, outlined: true)
  v(1em)

  if contributions.len() > 0 {
    heading(level: 2, "Contributions")
    v(0.5em)
    contribution-table(contributions)
    v(1em)
  }

  if content != none {
    set par(justify: true, first-line-indent: 1.5em)
    set text(size: 12pt, font: style.fonts.serif, lang: locale)
    content
    v(1em)
  }

  for section in sections {
    let sec-title = if type(section) == dictionary {
      section.at("title", default: "")
    } else { section.at(0, default: "") }
    let sec-content = if type(section) == dictionary {
      section.at("content", default: [])
    } else { section.at(1, default: []) }
    heading(level: 2, sec-title)
    v(0.5em)
    sec-content
    v(1em)
  }

  // Demo usage: show a tiny publications demo for quick visual/manual checks
  if publications.len() > 0 {
    heading(level: 2, "Publications (demo)")
    v(0.5em)
    // Add a chapter-level footnote referring to the first publication (if any)
    set text(size: 12pt)
    text("This chapter refers to an associated publication.")
    publication-chapter-footnote(publications, 0)
    v(0.5em)
    // Show the status table including appendix links where available
    publication-status-table(publications, show_links: true)
    v(1em)
  }

  preface-publications_section(publications)

  // AI / assistance disclosures (optional)
  let ai_entries = metadata.at("ai_assistance", default: ())
  ai-usage-note(ai_entries)

  pagebreak()
}
