// Copyright (c) 2025 Lorenzo Panieri <lorenzo.panieri@pm.me>
// See LICENSE file for details

// Configure your dependencies here.

#import "@preview/acrostiche:0.5.2": ac, acp, init-acronyms, print-index, reset-acronym, reset-all-acronyms
#import "@preview/codly:1.3.0" as cd
#import "@preview/codly:1.3.0": codly, local
#import "@preview/codly-languages:0.1.8": codly-languages

#import "style.typ": palette

#let codly-init(c) = [
  #show: cd.codly-init
  #codly(
    languages: codly-languages,
    inset: 2pt,
    fill: palette.bg-grey1,
    zebra-fill: palette.bg-grey2,
    number-format: c => text(numbering("1", c), fill: palette.fg-grey1),
    number-placement: "outside",
    display-icon: false,
  )
  #show raw.where(block: true): set text(size: 9pt)
  #c
]
