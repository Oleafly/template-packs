// ============================================================
//  catalog.typ — Dados da Ficha Catalográfica
// ============================================================
//
//  Preencha os campos abaixo para gerar a ficha catalográfica
//  automaticamente. O formato segue as normas ISBD / AACR2,
//  padrão exigido pela Câmara Brasileira do Livro para CIP
//  (Catalogação na Publicação).
// ============================================================

#import "config.typ": ano-edição, autor-livro, edição, sobrenome-autor, prenome-autor, subtítulo, titulo-livro

#let ficha = (
  // ─── Identificação do autor ─────────────────────────────
  //  Use o sobrenome em maiúsculas (padrão ISBD de entrada)
  autor: autor-livro,
  sobrenome-autor: sobrenome-autor,
  prenome-autor: prenome-autor,
  // ─── Identificação da obra ──────────────────────────────
  titulo: titulo-livro,
  subtítulo: subtítulo,
  // ─── Edição e produção ──────────────────────────────────
  edicao: edição,
  cidade: "Rio de Janeiro",
  editora: "Quarto Seis Ateliê",
  ano: ano-edição,
  // ─── Dados físicos ──────────────────────────────────────
  paginas: "000",
  formato: "14,8 × 21 cm", // dimensões do papel A5
  // ─── Produção tipográfica ────────────────────────────────
  papel: "Papel Pólen 80 g/m²",
  tipografia: "EB Garamond",
  // ─── Identificadores e classificação ────────────────────
  isbn: "978-00-0000-000-0",
  cdd: "000", // Classificação Decimal de Dewey
  cdu: "000", // Classificação Decimal Universal
  // ─── Descritores / Assuntos ─────────────────────────────
  //  Liste os assuntos em ordem de especificidade
  assuntos: (
    "Assunto principal",
    "Assunto secundário",
    "Assunto terciário",
  ),
  // ─── Direitos e avisos ──────────────────────────────────
  direitos: "Todos os direitos desta edição reservados ao autor.",
  aviso: "É expressamente proibida a reprodução total ou parcial desta obra, por qualquer meio ou processo, sem autorização por escrito do autor.",
)
