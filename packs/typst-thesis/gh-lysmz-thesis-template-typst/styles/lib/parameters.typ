/*
 * Typst Thesis Template @ Ohm
 *
 * Copyright (c) 2026 Nils Weber <me@vimkat.dev>
 */

#let thesis-parameters = state("thesis-parameters")
#let p(key, default: none, map: v => v) = {
  let value = thesis-parameters.get().at(key, default: default)
  return map(value)
}
