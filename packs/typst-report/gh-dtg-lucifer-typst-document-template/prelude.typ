// prelude.typ
// Unified entrypoint exporting the master document template, modular components, theme palettes, and macros.
// Import this single file in main.typ:
// #import "prelude.typ": *

#import "template.typ": document-template

#import "components/theme.typ": (
  current-theme,
  resolve-palette,
  light-palette,
  dark-palette,
  primary-color,
  secondary-color,
  accent-red,
  bg-callout,
  border-callout,
  bg-note,
  border-note,
  bg-challenge,
  border-challenge,
  bg-tech,
  border-tech,
)

#import "components/callouts.typ": (
  callout,
  takeaway,
  challenge-box,
  info,
  warning,
  danger,
  tip,
  highlight-box,
)

#import "components/boxes.typ": (
  left-bar-box,
  card-box,
  metric-card,
  metric-grid,
  key-value-grid,
)

#import "components/badges.typ": (
  badge,
  status-badge,
  mitre-tag,
  tech-tag,
  protocol-tag,
)

#import "components/codeblock.typ": (
  codeblock,
  plaincodeblock,
  consoleblock,
  codeinline,
)

#import "components/tables.typ": (
  styled-table,
  zebra-fill,
)

#import "components/cover.typ": (
  render-cover-page,
)

#import "components/toc.typ": (
  toc-header,
  format-toc-entry,
  outline-divider,
)

#import "components/macros.typ": (
  RR,
  NN,
  ZZ,
  QQ,
  CC,
  step-flow,
)
