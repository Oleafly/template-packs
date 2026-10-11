// prelude.typ
// Unified entrypoint exporting the document template, components, math macros, and themes

#import "template.typ": document-template

#import "components/theme.typ": (
  current-theme,
  resolve-palette,
  light-palette,
  dark-palette,
)

#import "components/boxes.typ": (
  badge-box,
  rivet-box,
  left-bar-box,
  continuation-box,
  ribbon-box,
  frame-box,
)

#import "components/note.typ": (
  note,
  nt,
  tip,
  info,
  warning,
  caution,
)

#import "components/blockquote.typ": (
  blockquote,
  quote-box,
  epigraph,
)

#import "components/codeblock.typ": (
  codeblock,
  plaincodeblock,
  latexcodeblock,
  consoleblock,
  codeinline,
)

#import "components/callouts.typ": (
  callout,
)

#import "components/math_blocks.typ": (
  definition,
  dfn,
  dfnc,
  example,
  ex,
  theorem,
  thm,
  thmcon,
  theorem-continuation,
  proposition,
  mprop,
  prop,
  lemma,
  mlemma,
  corollary,
  cor,
  claim,
  clm,
  iclm,
  iclaim,
  exercise,
  mer,
  remark,
  rmk,
  question,
  qs,
  solution,
  sol,
  solbox,
  proof,
  pf,
  myproof,
  wrong-concept,
  concept,
  wconc,
  wc,
  circled,
  circled-num,
  clist,
)

#import "components/toc.typ": (
  toc-header,
  format-toc-entry,
)

#import "components/macros.typ": (
  RR,
  NN,
  ZZ,
  QQ,
  CC,
  FF,
  PP,
  HH,
  EE,
  bbR,
  bbN,
  bbZ,
  bbQ,
  bbC,
  bbF,
  eps,
  veps,
  bs,
  emptyset,
  Var,
  Cov,
  span,
  id,
  Id,
  null,
  range,
  dim,
  norm,
  abs,
  floor,
  ceil,
  inner,
  dv,
  pdv,
  pdvn,
)
