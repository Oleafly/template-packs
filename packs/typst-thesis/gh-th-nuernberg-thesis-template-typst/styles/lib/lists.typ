/*
 * Typst Thesis Template @ Ohm
 *
 * Copyright (c) 2026 Nils Weber <me@vimkat.dev>
 */

#import "translations.typ" : t
#import "util.typ" : frontmatter-heading

#let thesis-toc() = context {
  frontmatter-heading(t("TOC"))

  show outline.entry.where(level: 1): set outline.entry(fill: none)
  show outline.entry.where(level: 1): it => {
    set text(weight: "bold")
    set block(above: 2em)
    it
  }
  block(above: 0em, outline(title: none, depth: 3))
}

#let outline-loX(..args) = {
  show outline.entry: it => link(it.element.location(), it.indented(it.element.counter.display(at: it.element.location()), it.inner()))
  outline(title: none, ..args)
}

#let thesis-lof() = context {
  frontmatter-heading(t("LOF"))
  outline-loX(target: figure.where(kind: image))
}

#let thesis-lot() = context {
  frontmatter-heading(t("LOT"))
  outline-loX(target: figure.where(kind: table))
}

#let thesis-lol() = context {
  frontmatter-heading(t("LOL"))
  outline-loX(target: figure.where(kind: raw))
}
