#import "metadata/config.typ": template, titulo-capitulo
#import "metadata/catalog.typ": ficha
#import "template/front-matter.typ": ficha-catalografica, pagina-titulo

#show: template

// ─── Pré-texto ───────────────────────────────────────────────
// Páginas sem cabeçalho nem rodapé.
// Os metadados do livro são lidos de config.typ.
// Os dados da ficha catalográfica são lidos de catalog.typ.

#pagina-titulo()
#ficha-catalografica(ficha)
#include "content/dedicatoria.typ"
#include "content/agradecimentos.typ"

// ─── Sumário ─────────────────────────────────────────────────

#pagebreak()
#outline(title: "Sumário")

// ─── Capítulos ───────────────────────────────────────────────
// Adicione novos capítulos abaixo, na ordem desejada.
// Cada #include "content/ch_N.typ" deve usar a função capitulo().

#import "template/back-matter.typ": exibir-notas-livro, bibliografia, last_page

#include "content/introdução.typ"
#include "content/ch_1.typ"
#include "content/ch_2.typ"

// #include "content/ch_3.typ"

// ─── Apêndices ────────────────────────────────────────────────
#include "content/appendix/apendice_a.typ"

// ─── Pós-texto (Back Matter) ──────────────────────────────────
#exibir-notas-livro()
#bibliografia()
#last_page(ficha)

