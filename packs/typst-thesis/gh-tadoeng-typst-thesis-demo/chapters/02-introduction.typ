#import "../theme.typ": callout

#let method = json("/data/method.json")

= Introduction <sec:intro>

Computational structural engineering projects are document-heavy. A good thesis often needs a title page, consistent chapter hierarchy, numbered equations, figures, tables, appendices, and references that stay stable even when sections move around. Typst is useful because the document stays close to code and data instead of devolving into fragile manual formatting @typst.

#callout([What to notice while learning], [Every major block in this demo is reusable. The theme lives in one file, each chapter lives in its own file, data lives outside the prose, and figures are stored as normal assets in a dedicated folder.])

The research problem in this case study can be expressed through three questions:

#for q in method.questions [
- #q
]

As a thesis topic, *EtabExtension* is attractive because it sits at the intersection of structural analysis, engineering workflows, and software architecture. It also creates many opportunities for clean figures, data tables, and case-study comparisons.
