// pos-textuais/apendice-b-codigo-fonte.typ — Apêndice B: listagens longas de código.
// Código extenso não fica no corpo do texto; vem para cá e é citado
// no Capítulo 4. Use o mesmo #codigo do corpo, lendo o arquivo do repositório.
#import "../ifbasaj-tcc/imports.typ": *

= Código-fonte das classes de domínio <apx-codigo>

#codigo(
  lang: "java",
  caption: [Classe Produto],
  filename: "Produto.java",
  read("../assets/codigos/Produto.java"),
) <cod-produto>

#codigo(
  lang: "java",
  caption: [Classe Estoque],
  filename: "Estoque.java",
  read("../assets/codigos/Estoque.java"),
) <cod-estoque>
