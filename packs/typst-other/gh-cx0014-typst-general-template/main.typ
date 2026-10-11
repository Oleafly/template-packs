#import "template.typ": *

#import "@preview/physica:0.9.8": *
#import "@preview/gentle-clues:1.3.0": *
#import "@preview/mannot:0.3.2": *
#import "@preview/lovelace:0.3.0": *

// Configuration

#show: project.with(
  title: "General Template",
  subtitle: [
    Hui Chun Wai --- `SID_HIDDEN` \
    ...... `cwhuiaf@connect.ust.hk`
  ],
  comma-add-space: true,
)

#let lovelace-defaults = (
  booktabs: true,
  indentation: 1.5em,
  hooks: .5em,
)

#let pseudocode = pseudocode.with(..lovelace-defaults)
#let pseudocode-list = pseudocode-list.with(..lovelace-defaults)

// Main Content

Primal optimization problem: Minimize
$ 1/2 ||w||^2 + markhl(C sum_ell xi_ell), e, e $

= Test Header
#lorem(50)
