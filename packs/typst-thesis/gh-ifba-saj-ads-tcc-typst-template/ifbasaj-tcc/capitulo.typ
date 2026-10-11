// capitulo.typ — Permite compilar um capítulo sozinho (preview de um arquivo de capitulos/).
//
// Uso, no topo de cada capítulo:
//   #import "../ifbasaj-tcc/imports.typ": *
//   #show: capitulo.with(numero: 3)
//
// Dentro do main.typ (documento completo) o wrapper não faz nada. Aberto sozinho, o capítulo
// ganha o estilo ABNT, a numeração certa, a bibliografia de ../referencias.bib, e as
// referências a rótulos de outros capítulos aparecem como ‹rótulo› em vez de erro.
#import "layout.typ": _abnt-page, _abnt-body, _abnt-headings
#import "bibliography.typ": register-bib, cite
#import "code-algo.typ": init-codly

// Dentro do main.typ o template() já numerou os títulos (set heading(numbering: ...)).
// Lê o estilo corrente, e não uma query: na 1ª passada de layout toda query volta vazia.
#let _no-main() = heading.numbering != none

// parbreak() antes e depois: sem isso, #include consecutivos no main.typ põem o bloco
// contextual dentro de um parágrafo, onde quebra de página (abertura de capítulo) é proibida.
#let capitulo(numero: none, bibliografia: "../referencias.bib", body) = parbreak() + context {
  if _no-main() { return body }
  show: _abnt-page
  show: _abnt-body
  show: _abnt-headings
  show: init-codly
  register-bib(read(bibliografia))
  show ref: it => {
    if query(it.target).len() > 0 { return it }
    let k = str(it.target)
    if state("ifba-bibsrc", "").get().contains(k) { cite(k) } else {
      text(fill: rgb("#b00020"))[‹#k›]
    }
  }
  if numero != none { counter(heading).update(numero - 1) }
  body
} + parbreak()
