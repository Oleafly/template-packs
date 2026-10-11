// This thesis. Binds the template to config.yml and re-exports everything the
// content files use, so they import one thing.
//
// Anything specific to this thesis -- custom figures, notation, one-off
// tweaks -- belongs in this folder, not in lib/.

#import "/lib/mod.typ"
#import "code.typ": code, code-style
#import "figure.typ" as figure-mod
#import "/misc/lorem.typ": en-lorem, zh-lorem
#import "/misc/latex.typ": bibtex, latex
#import "/misc/typst.typ": typst
#import "table.typ" as table-mod
#import "table.typ": bottomrule, cmidrule, midrule, toprule

#let cfg = mod.load("/config.yml")

// numbering: value for `#set math.equation(...)`, driven by `layout.equation-numbering`
// and `layout.equation-per-chapter`
#let eq-numbering = mod.eq-numbering(cfg.layout)

// 圖/表 or Figure/Table, whichever this thesis is written in -- the default
// caption prefix, overridable per call via `supplement:`
#let fig-supplement = if cfg.layout.language == "chinese" { cfg.strings.figure } else {
  cfg.strings.figure-en
}
#let table-supplement = if cfg.layout.language == "chinese" { cfg.strings.table } else {
  cfg.strings.table-en
}

#let fig(..args, supplement: auto) = figure-mod.fig(
  ..args,
  supplement: if supplement == auto { fig-supplement } else { supplement },
)
#let fig-row(..args, supplement: auto) = figure-mod.fig-row(
  ..args,
  supplement: if supplement == auto { fig-supplement } else { supplement },
)
#let fig-grid(..args, supplement: auto) = figure-mod.fig-grid(
  ..args,
  supplement: if supplement == auto { fig-supplement } else { supplement },
)
#let tlt(..args, supplement: auto) = table-mod.tlt(
  ..args,
  supplement: if supplement == auto { table-supplement } else { supplement },
)

#let thesis(body) = mod.thesis(cfg, code-style(body))
#let references() = mod.references(cfg)

#let abstract-zh(keywords: (), body) = mod.abstract-zh(cfg, keywords: keywords, body)
#let abstract-en(keywords: (), body) = mod.abstract-en(cfg, keywords: keywords, body)
#let acknowledgement(body) = mod.acknowledgement(cfg, body)
#let denotation(body) = mod.denotation(cfg, body)

// natbib equivalents: \citet \citep \citeauthor \citeyear
#import "/lib/mod.typ": c, ca, cp, cy
