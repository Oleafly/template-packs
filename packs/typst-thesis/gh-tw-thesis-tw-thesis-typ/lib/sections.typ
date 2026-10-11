// Unnumbered level-1 sections. Each takes the config so nothing here knows
// which thesis it belongs to.

#let section(title, body) = {
  heading(level: 1, numbering: none)[#title]
  body
}

#let abstract-zh(cfg, keywords: (), body) = {
  let s = cfg.sections
  section(s.abstract, body)
  v(1em)
  [*#s.keywords-label*] + keywords.join(s.keywords-sep)
}

#let abstract-en(cfg, keywords: (), body) = {
  let s = cfg.sections
  section(s.abstract-en, body)
  v(1em)
  [*#s.keywords-label-en* ] + keywords.join(s.keywords-sep-en)
}

#let acknowledgement(cfg, body) = section(cfg.sections.acknowledgement, body)

#let denotation(cfg, body) = section(cfg.sections.denotation, body)
