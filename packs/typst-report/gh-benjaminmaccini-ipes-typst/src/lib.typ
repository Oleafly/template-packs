// ===========================================================================
// dossier — a template for comprehensive policy reports.
//
// Everything public lives here. A report needs exactly one `#show: report`,
// after which every other function reads the active theme automatically.
//
//   #import "@preview/dossier:0.1.0": *
//   #show: report.with(title: [..], endnotes: bibliography("refs.bib"))
//
// The underlying packages stay reachable: `meander` for wrap-around pages,
// `gribouille` for grammar-of-graphics charts, `mercator` for maps, `cetz`
// for bespoke drawing. Re-exported below so a report needs one import.
// ===========================================================================

// --- theme -----------------------------------------------------------------
#import "theme.typ": (
  default-fonts, default-page, default-scale, default-spacing,
  get-theme, ipes-theme, make-theme, section-accent, theme-state, themed,
)

// --- document --------------------------------------------------------------
#import "doc.typ": report
#import "covers.typ": back-cover, credits-page, front-cover
#import "contents.typ": contents, index-of
#import "sections.typ": section-opener

// --- blocks ----------------------------------------------------------------
#import "callouts.typ": box-note, case-study, key-messages, recommendation
#import "quotes.typ": epigraph, pull-quote, stat, stat-row
#import "notes.typ": aside, endnotes, margin-note

// --- figures and data ------------------------------------------------------
#import "stories.typ": data-story
#import "viz.typ": asset, chart, chart-colours, chart-theme, map

// --- typographic primitives ------------------------------------------------
#import "marks.typ": caps, hairline, kicker, source-note, tick

// --- escape hatches --------------------------------------------------------
// Re-exported so that a report can reach the underlying engines without a
// second import line. `meander` in particular is deliberately left raw: it
// governs whichever page you hand it and nothing else.
#import "@preview/meander:0.4.4"
#import "@preview/gribouille:0.6.0" as gg
#import "@preview/cetz:0.5.2"
#import "@preview/marginalia:0.3.1"
#import "@preview/showybox:2.0.4": showybox
#import "@preview/droplet:0.3.1": dropcap
#import "@preview/zero:0.7.0"
