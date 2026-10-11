#import "@preview/touying:0.7.4": *
#import "bnl-theme.typ": *

#show: bnl-theme.with(
  config-info(
    title: [A BNL Touying Theme],
    subtitle: none,
    author: [Presenter Name],
    affiliation: [affiliation],
    date: datetime.today(),
    institution: [Brookhaven National Laboratory],
  ),
)

#title-slide()

= Program overview

== Slide Header

Body Text

- Bullet Tier 1
  - Bullet Tier 2

#slide(title: [Two-column layout], composer: (1fr, 1fr))[
  *Left column*

  Use the standard Touying composer for parallel content.
][
  *Right column*

  The BNL master artwork and footer remain fixed.
]

#section-slide(
  [Print-friendly Section Break],
  subtitle: [Optional subtitle],
  print-friendly: true,
)

#title-slide(
  print-friendly: true,
  title: [Print-friendly Title Slide],
  author: [Presenter Name],
  date: datetime.today(),
)
