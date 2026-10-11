#import "mace.typ": codex, codex-table, title-page, table-of-contents

#show: codex.with(
  title: "MACE Adventurer's Codex",
  author: "Justin Hamilton",
)

#title-page(
  title: [MACE],
  tagline: [Medieval Adventure Campaign Engine],
  subtitle: [Example Codex],
  // art: image("art/dragon.png", width: 70%),
  blurb: [Examples for building a Codex in the style of MACE],
  version: [version 08-19-2026],
  license: [
    MACE: Example Codex © 2026 by Cryptic Codex, LLC. \
    Licensed under CC BY-SA 4.0. To view a copy of this license, visit \
    https://creativecommons.org/licenses/by-sa/4.0/
  ],
)

#table-of-contents()

= Introduction

_Medieval Adventure Campaign Engine_ (_MACE_) is a body of house rules for
the original edition of _Dungeons & Dragons_#footnote[Dungeons & Dragons
is a registered trademark of Wizards of the Coast, LLC (WOTC). Authors and
contributors to this text are not affiliated in any way with WOTC or
HASBRO.] (1974). This example codex exists to help build zines in the style of MACE, should you so wish (its mostly for me to use).

= Using this Template

Please see the README file in this repo for more details on how to use.

= H1
== H2
=== H3

= Lists
== Bulleted Lists
- *Bulleted List 1:* Goblins.
- *Bulleted List 2:* Trolls.
- *Bulleted List 3:* Ghosts

== Numbered Lists
1. First Item
2. Second Item
3. Third Item

= Tables

Write down the corresponding modifier for each ability, using the chart
below:

#codex-table(
  columns: (1fr, 1fr),
  align: (left, center),
  header: ([Die Rolled], [Result]),
  [1], [--1],
  [2--5], [0],
  [6], [+1],
)
