#let template = doc => {
  import "constants.typ" as const
  import "/parameters.typ" as parameters
  import "/conteudo/resumo.typ" as resumo

  set document(
    title: parameters.titulo-do-trabalho,
    author: (parameters.nome-do-autor),
    description: [#resumo],
    keywords: parameters.palavras-chave + parameters.keywords,
  )

  let x-margin = if parameters.impressao-frente-e-verso {
    (inside: 3cm, outside: 2cm)
  } else {
    (left: 3cm, right: 2cm)
  }
  set page("a4", margin: (top: 3cm, bottom: 2cm, ..x-margin))
  set par(
    justify: true,
    first-line-indent: (all: true, amount: 1.3cm),
    spacing: 1.2em,
    leading: const.ONE-AND-HALF-SPACING,
  )
  set text(size: 12pt, lang: "pt", region: "br", bottom-edge: "descender")
  set enum(numbering: "a)")
  show link: set text(fill: rgb("#0000ee"))
  set heading(numbering: "1.1")

  set table(stroke: (x, y) => (
    top: if y <= 1 { 1pt } else { 0pt },
    bottom: 1pt,
  ))

  show figure: it => block(breakable: false, {
    text(size: 10em / 12, it.caption)
    it.body
  })

  show quote.where(block: true): it => {
    set text(size: 10em / 12)
    align(right, block(
      width: 80%,
      align(left, it),
    ))
  }


  include "elementos-pre-textuais/capa.typ"
  include "elementos-pre-textuais/folha-de-rosto.typ"
  include "elementos-pre-textuais/ficha-catalografica.typ"
  include "elementos-pre-textuais/folha-de-aprovacao.typ"
  include "elementos-pre-textuais/dedicatoria.typ"
  include "elementos-pre-textuais/agradecimentos.typ"
  include "elementos-pre-textuais/epigrafe.typ"
  include "elementos-pre-textuais/resumo.typ"
  include "elementos-pre-textuais/abstract.typ"
  include "elementos-pre-textuais/indices.typ"

  let paginas-pre-textuais = counter("paginas-pre-textuais")
  context {
    // Precisamos subtrair um, pois a ficha catalografica nao eh contada.
    // Precisamos subtrair um, tambem, porque o contador pega a primeira
    // folha textual. Por isso, subtraimos 2.
    paginas-pre-textuais.update(counter(page).get().first() - 2)
  }
  counter(page).update(1)
  set page(
    header: context {
      let number-alignment = if (
        parameters.impressao-frente-e-verso == false
          or calc.even(counter(page).get().first())
      ) {
        right
      } else {
        left
      }
      set align(number-alignment)
      counter(page).display("1")
    },
  )

  doc

  include "elementos-pos-textuais/bibliografia.typ"
  context {
    counter(page).update(
      counter(page).get().first() + paginas-pre-textuais.get().first(),
    )
  }
}

#let abnt-figure(fonte: none, ..args) = {
  if fonte == none {
    panic(
      "
      As normas ABNT preveem que as ilustrações possuam uma fonte, mesmo que
      tenham sido produzidas pelo próprio autor.
      ",
    )
  }
  let body = align(center, block(breakable: false, {
    args.pos().at(0) + text(size: 10em / 12, { "Fonte: " + fonte })
  }))
  figure(body, ..args.named())
}
