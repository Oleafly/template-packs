// lib.typ — ifba-saj-tcc
// Modelo ABNT para TCC do IFBA, campus Santo Antônio de Jesus (ADS).
// Reexporta a API pública do pacote.

#import "layout.typ": default-theme
#import "pre-textual.typ": template
#import "elements.typ": figura, quadro, tabela, fonte, myself
#import "bibliography.typ": cite, prose, references, register-bib, citacao-curta, citacao-longa
#import "code-algo.typ": codigo, algoritmo
#import "diagrams.typ": diagram, cetz
#import "charts.typ": chart
#import "gloss.typ": abbrev, gloss, lista-abreviaturas, glossario
#import "annexes.typ": apendice, anexo
#import "capitulo.typ": capitulo
#import "editor-tools.typ": equacao, figura-equacao, orientacao
#import "config.typ": get-autor, get-titulo, get-ano, get-orientador, get-curso, get-cidade, get-config

// Reexportações públicas.
#let theme = default-theme
