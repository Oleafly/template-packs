#import "core/preamble.typ": *

// ── Presentation Info ─────────────────────────────────────────────────────────
#let presentation-title = [Template Example Presentation]
#let presentation-author = [Your Name(s)]
#let conference = [Conference or Meeting Name]
#let presentation-date = datetime.today()  //datetime(year: 2026, month: 4, day: 12)

#show: theme.with(
  slide-fn: slide,
  config-info(
    title: presentation-title,
    author: presentation-author,
    date: presentation-date,
  ),
)

// ── Title Slide ───────────────────────────────────────────────────────────────
#let logo-left = image("core/logos/logo-uds.svg", height: 1.8cm, fit: "contain")
#let logo-center = image("core/logos/logo-nontrivial.svg", height: 1.8cm, fit: "contain")
#let logo-right = image("core/logos/logo-iq.svg", height: 1.8cm, fit: "contain")

#title-slide(
  title: presentation-title,
  authors: presentation-author,
  conference: conference,
  date: presentation-date.display(),
  logo-left: logo-left,
  logo-center: logo-center,
  logo-right: logo-right,
)

// ── Sections ──────────────────────────────────────────────────────────────────
#include "sections/1-overview.typ"
#include "sections/2-layouts.typ"
#include "sections/3-content.typ"
#include "sections/4-animations.typ"
#include "sections/5-references.typ"
