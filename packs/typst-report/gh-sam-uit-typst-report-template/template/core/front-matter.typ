// /template/core/front-matter.typ
// Front-matter / preamble orchestration
// Author: Sam Dinh
// Version: 0.2.0
// License: MIT
//
// Renders preamble sections (summary, forewords, acknowledgement, etc.)
// and lists (TOC, LOT, LOF, LOC, etc.) based on resolved component flags.

#import "utils.typ": unheading, toc-section-wrapper

// MARK: Preamble Sections

/// Renders a preamble section if the corresponding flag is enabled.
/// Each section gets unnumbered heading styling and a pagebreak separator.
///
/// - config (dictionary): Resolved config with component flags
/// - labels (dictionary): i18n labels
/// - two-sided (bool): Whether to use blank pages for odd-start
#let render-preamble-sections(config, labels) = {
  // No Heading Numbering, No Outlined for preamble sections
  set heading(numbering: none, outlined: true)

  // Summary / Abstract (thesis only)
  if config.show-summary {
    include "/content/preamble-summary.typ"
    pagebreak()
  }

  // Forewords (thesis only)
  if config.show-forewords {
    include "/content/preamble-forewords.typ"
    pagebreak()
  }

  // Acknowledgement (thesis only)
  if config.show-acknowledgement {
    include "/content/preamble-ack.typ"
    pagebreak()
  }

  // Instructor's comment (thesis only)
  if config.show-instructor-comment {
    include "/content/preamble-comment.typ"
    // pagebreak()
  }

  // Author page (report)
  if config.show-author {
    set heading(numbering: none, outlined: false)
    include "/author/author.typ"
  }
}

// MARK: Lists & Outlines

/// Renders Table of Contents, List of Tables/Figures/Code, TODO list,
/// and Abbreviations table based on component flags.
///
/// - config (dictionary): Resolved config with component flags
/// - labels (dictionary): i18n labels
/// - accent (color): Accent color for TOC wrappers
/// - acronyms: Acronym data (array, dictionary, or none)
/// - needs-pagebreak (bool): Whether lists should be on separate pages
#let render-lists(config, labels, accent, acronyms, needs-pagebreak) = {
  // MARK: Table of Contents
  if config.show-toc {
    if needs-pagebreak { pagebreak() }
    toc-section-wrapper(accent)[
      #unheading[#labels.toc]
      #outline(title: none, indent: auto, depth: 2)
    ]
  }

  // MARK: List of Tables
  if config.show-lot {
    context {
      let lots = query(figure.where(kind: table))
      if lots.len() > 0 {
        if needs-pagebreak { pagebreak() }
        toc-section-wrapper(accent)[
          #unheading[#labels.lot]
          #outline(title: none, target: figure.where(kind: table))
        ]
      }
    }
  }

  // MARK: List of Figures
  if config.show-lof {
    context {
      let lofs = query(figure.where(kind: image))
      if lofs.len() > 0 {
        if needs-pagebreak { pagebreak() }
        toc-section-wrapper(accent)[
          #unheading[#labels.lof]
          #outline(title: none, target: figure.where(kind: image))
        ]
      }
    }
  }

  // MARK: List of Code Snippets
  if config.show-loc {
    context {
      let locs = query(figure.where(kind: raw))
      if locs.len() > 0 {
        if needs-pagebreak { pagebreak() }
        toc-section-wrapper(accent)[
          #unheading[#labels.loc]
          #outline(title: none, target: figure.where(kind: raw))
        ]
      }
    }
  }

  // MARK: List of TODOs (conditional on existence)
  if config.show-todo-list {
    context {
      let todos = query(figure.where(kind: "todo"))
      if todos.len() > 0 {
        if needs-pagebreak { pagebreak() }
        toc-section-wrapper(red)[
          #unheading[#labels.todo-list]
          #outline(title: none, target: figure.where(kind: "todo"))
        ]
      }
    }
  }

  // MARK: Abbreviations Table
  if config.show-acronyms and acronyms != none and acronyms.len() > 0 {
    if needs-pagebreak { pagebreak() }

    [ #unheading[#labels.abbreviations] ]

    // Normalize acronym data from dict or array
    let content = if type(acronyms) == dictionary {
      acronyms.pairs().map(((key, value)) => (key, value)).flatten()
    } else if type(acronyms) == array {
      // Skip header row if present
      if acronyms.len() > 0 and acronyms.at(0).at(0) == labels.abbreviation-short {
        acronyms.slice(1).flatten()
      } else if acronyms.len() > 0 and acronyms.at(0).at(0) == "Viết Tắt" {
        // Backward compat: Vietnamese header in CSV
        acronyms.slice(1).flatten()
      } else {
        acronyms.flatten()
      }
    } else {
      ()
    }

    figure(
      table(
        columns: (20%, 80%),
        inset: (x: 0.6em, y: 0.4em),
        // Only horizontal rules — no vertical borders in the acronyms list
        stroke: (bottom: 0.5pt + orange.lighten(90%)),
        align: (right, left),
        table.header([*#labels.abbreviation-short*], [*#labels.abbreviation-full*]),
        ..content,
      ),
      caption: [*#labels.abbreviations*],
      kind: table,
      outlined: false,
      numbering: none,
    )
  }
}
