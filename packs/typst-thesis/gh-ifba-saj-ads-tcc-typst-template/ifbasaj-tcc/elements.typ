// elements.typ — Figuras, Quadros e Tabelas com atribuição automática de fonte.

#import "config.typ": get-config

#let _cm-dash = " – "

// Linha de fonte ABNT abaixo da ilustração (tamanho 10, centralizada).
#let _src(body) = {
  set text(size: 10pt)
  set par(leading: 0.6em, first-line-indent: 0pt, justify: false)
  v(3pt, weak: true)
  align(center, [Fonte#_cm-dash#body])
}

// Fonte padrão: "Elaborado pelo próprio autor (ano)".
#let _self-source() = context {
  let cfg = get-config()
  let ano = if cfg.year == none { "ano" } else { cfg.year }
  [_Elaborado pelo próprio autor (#ano)._]
}

#let _render-source(src) = if src == none {
  none
} else if src == auto {
  _src(_self-source())
} else {
  _src(src)
}

// Linha "Fonte" exposta publicamente (source: none remove).
#let fonte = _src
#let myself = context { let cfg = get-config(); let ano = if cfg.year == none { "ano" } else { cfg.year }; [_Elaborado pelo próprio autor (#ano)._] }

// 📸 Figura — caption acima, fonte abaixo.
#let figura(
  body,
  caption: none,
  source: auto,
) = {
  figure(
    {
      body
      _render-source(source)
    },
    caption: caption,
    numbering: "1",
    kind: image,
    supplement: [Figura],
  )
}

// 🖼 Quadro — bordas fechadas, numeração independente.
#let quadro(
  cells,
  caption: none,
  source: auto,
  columns: auto,
  align: auto,
) = {
  figure(
    {
      table(
        columns: columns,
        align: align,
        stroke: 0.5pt,
        inset: (x: 6pt, y: 3pt),
        ..cells,
      )
      _render-source(source)
    },
    caption: caption,
    numbering: "1",
    kind: "frame",
    supplement: [Quadro],
  )
}

// 📊 Tabela estilo IBGE/ABNT — sem laterais, topo/base fechados, header delimitado.
#let tabela(
  caption: none,
  source: auto,
  columns: auto,
  align: auto,
  font-size: 11pt,
  header: none,
  width: auto,
  ..rows,
) = {
  figure(
    {
      [#box(width: width)[
        #set text(size: font-size)
        #table(
        columns: columns,
        align: align,
        stroke: none,
        inset: (x: 6pt, y: 3pt),
        table.hline(stroke: 1.5pt),
        ..if header != none {
          (table.header(..header.map(h => [ *#h* ])), table.hline(stroke: 0.8pt))
        } else { () },
        ..rows.pos().flatten(),
        table.hline(stroke: 1.5pt),
      )
      ]
      #_render-source(source)]
    },
    caption: caption,
    numbering: "1",
    kind: table,
    supplement: [Tabela],
  )
}