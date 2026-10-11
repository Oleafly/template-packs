// gdg-polylux.typ
// Tema Polylux com identidade dos Google Developer Groups.
//
// ---------------------------------------------------------------
// Guia rápido deste arquivo
// ---------------------------------------------------------------
// Objetivo:
// - Fornecer um tema reutilizável para decks no Polylux.
// - Manter identidade visual GDG de forma consistente.
//
// O que este módulo exporta:
// - `theme`: aplica configuração global (página, tipografia, seções, outline).
// - `slide`: slide padrão com header/footer automáticos.
// - `title-slide`: slide de abertura sem header/footer.
// - `focus-slide`: slide de destaque com fundo sólido.
// - `centered-slide`: conteúdo centralizado para transições/encerramento.
//
// Fluxo de uso recomendado:
// 1) No arquivo de slides, faça `#import "gdg-polylux.typ": *`.
// 2) Configure o tema uma única vez com `#show: theme.with(...)`.
// 3) Estruture conteúdo com `= Seção` e blocos `#slide[...]`.
//
// Convenções internas importantes:
// - Heading nível 1 (`=`) gera automaticamente uma capa de seção.
// - Heading nível 2 (`==`) é o título principal do slide de conteúdo.
// - Rodapé mostra texto global + número atual/total de slides.

// Polylux + helpers internos.
// Importamos `slide` com alias para poder criar um wrapper próprio sem perder
// a função original do Polylux. O módulo `toolbox` concentra utilitários como
// numeração e seção atual na série 0.4.
#import "@preview/polylux:0.4.0": *
#import "@preview/polylux:0.4.0": slide as polylux-slide, toolbox
#import "@preview/cades:0.3.1": qr-code as cades-qr-code
#import "@preview/codly:1.3.0": codly, codly-init

// ---------------------------
// Paleta de cores GDG
// ---------------------------
// Core colors (GDG / Google for Developers):
// Blue 500  : #4285F4
// Red 500   : #EA4335
// Yellow 600: #F9AB00
// Green 500 : #34A853
// Grey      : #5F6368 (texto / neutro)
#let gdg-blue   = rgb("#4285F4")
#let gdg-red    = rgb("#EA4335")
#let gdg-yellow = rgb("#F9AB00")
#let gdg-green  = rgb("#34A853")
#let gdg-grey   = rgb("#5F6368")

// Estado para texto de rodapé global.
#let gdg-footer = state("gdg-footer", [])

// ---------------------------
// Elementos visuais de marca
// ---------------------------

// Faixa horizontal com as quatro cores (estilo GDG bracket).
#let gdg-color-strip(width: 4em, height: 0.16em) = {
  grid(
    columns: (1fr, 1fr, 1fr, 1fr),
    gutter: 0.08em,
    rect(fill: gdg-blue,   width: width, height: height, radius: 0.08em),
    rect(fill: gdg-red,    width: width, height: height, radius: 0.08em),
    rect(fill: gdg-yellow, width: width, height: height, radius: 0.08em),
    rect(fill: gdg-green,  width: width, height: height, radius: 0.08em),
  )
}

// Formatação padrão de textos de cabeçalho/rodapé.
#let gdg-meta-text(body) = text(
  size: 0.7em,
  fill: gdg-grey,
  body,
)

// Preset de estilo para QR Code usando as cores base do tema GDG.
// Pode ser aplicado em chamadas diretas da cades com `..gdg-qrcode-style`.
#let gdg-qrcode-style = (
  color: gdg-blue,
  background: white,
  error-correction: "M",
)

// Helper pronto para gerar QR Code com o preset GDG.
// Exemplo:
//   #gdg-qr-code("https://gdg.community.dev", width: 2.8cm)
#let gdg-qr-code(
  content,
  width: auto,
  height: auto,
  style: gdg-qrcode-style,
) = {
  cades-qr-code(
    content,
    width: width,
    height: height,
    ..style,
  )
}

// Preset de estilo para blocos de código com Codly.
// Pode ser aplicado em chamadas diretas com `#codly(..gdg-codly-style)`.
#let gdg-codly-style = (
  default-color: gdg-blue,
  radius: 0.38em,
  inset: 0.42em,
  fill: rgb("#F8FBFF"),
  zebra-fill: rgb("#F1F7FF"),
  stroke: 1pt + rgb("#AECBFA"),
  lang-stroke: (lang) => 0.6pt + gdg-blue,
  lang-fill: (lang) => rgb("#E8F0FE"),
  number-placement: "outside",
  number-align: right + horizon,
  number-format: (number) => text(fill: gdg-blue, size: 0.82em)[#number],
  display-icon: true,
  smart-indent: true,
)

// Preset de estilo para tabelas no visual GDG.
// Exemplo:
//   #table(columns: (auto, auto, 1fr), ..gdg-table-style, ...)
#let gdg-table-style = (
  inset: (x: 10pt, y: 8pt),
  align: horizon,
  stroke: (_, row) => {
    if row == 0 {
      (
        top: 1pt + gdg-blue,
        left: 0.9pt + gdg-blue,
        right: 0.9pt + rgb("#8AB4F8"),
        bottom: 1.2pt + rgb("#8AB4F8"),
      )
    } else {
      (
        top: 0.35pt + rgb("#F3F8FF"),
        left: 0.35pt + rgb("#F3F8FF"),
        right: 0.5pt + rgb("#D2E3FC"),
        bottom: 0.85pt + rgb("#AECBFA"),
      )
    }
  },
  fill: (_, row) => {
    if row == 0 {
      rgb("#E8F0FE")
    } else if calc.odd(row) {
      rgb("#F6F9FF")
    } else {
      white
    }
  },
)

// ---------------------------
// Tema principal
// ---------------------------

// gdg-theme: wrapper principal para configurar página, textos, outline, etc.
// Importante: dentro de funções Typst, usamos `set`, `show` e chamadas diretas
// sem o prefixo `#`, porque já estamos em modo de código.
// Uso típico:
//   #show: gdg-theme.with(
//     aspect-ratio: "16-9",
//     footer: [GDG Londrina · 2026],
//   )
#let gdg-theme(
  aspect-ratio: "16-9",
  footer: [],
  background: white,
  foreground: gdg-grey,
  title-color: gdg-blue,
  body,
) = {
  // Layout base de página (formatação global) – como no tutorial de formatting.
  set page(
    paper: "presentation-" + aspect-ratio,
    margin: 2em,
    header: none,
    footer: none,
    fill: background,
  )
  set text(
    font: "Roboto",
    size: 20pt,
    fill: foreground,
  )

  // Headings: nível 1 = seção, nível 2 = título de slide.
  show heading.where(level: 1): set text(
    size: 1.4em,
    weight: "bold",
    fill: title-color,
  )
  show heading.where(level: 2): set block(below: 1.5em)
  show heading.where(level: 2): set text(
    size: 1.1em,
    weight: "bold",
    fill: title-color,
  )

  // Notas de rodapé menores.
  show footnote.entry: set text(size: 0.6em)

  // Blocos de código levemente menores que o texto base dos slides.
  show raw.where(block: true): set text(size: 0.82em)

  // Outline baseado em headings de nível 1 (seções).
  set outline(
    target: heading.where(level: 1),
    title: none,
  )
  show outline.entry: it => it
  show outline: it => block(inset: (x: 1em), it)

  // Cada seção (heading nível 1) vira um slide-capa próprio.
  // Isso garante que a seção ocupe uma página dedicada sem afetar
  // o conteúdo do slide anterior.
  show heading.where(level: 1): it => {
    toolbox.register-section(it.body)
    polylux-slide(
      align(
        center + horizon,
        {
          gdg-color-strip()
          v(1.2em)
          text(
            size: 1.4em,
            weight: "bold",
            fill: title-color,
            it.body,
          )
        },
      )
    )
  }

  // Atualiza texto de rodapé global a partir do parâmetro footer.
  gdg-footer.update(footer)

  // Inicializa e aplica o estilo global de blocos de código (Codly).
  show: codly-init.with()
  codly(..gdg-codly-style)

  // Corpo do documento/slides.
  body
}

// ---------------------------
// Funções de slide
// ---------------------------

// API pública (resumo):
// - theme(aspect-ratio, footer, background, foreground, title-color, body)
// - slide(body)
// - title-slide(body)
// - focus-slide(background, foreground, body)
// - centered-slide(body)
// - gdg-qrcode-style (preset para `cades.qr-code`)
// - gdg-qr-code(content, width, height, style)
// - gdg-codly-style (preset para `codly`)
// - gdg-table-style (preset para `table`)

// Parâmetros principais de `theme`:
// - aspect-ratio: formato de apresentação (ex.: "16-9").
// - footer: conteúdo exibido no canto esquerdo do rodapé.
// - background/foreground: cores base do documento.
// - title-color: cor de títulos e elementos de destaque.

// Slide centrado no meio da tela (útil para seções ou mensagens curtas).
#let gdg-centered-slide(body) = {
  polylux-slide(align(center + horizon, body))
}

// Title slide: remove outline do heading de nível 1 e centraliza,
// com a faixa de cores GDG acima.
#let gdg-title-slide(body) = {
  // Mantém heading nível 1 normal dentro do title slide,
  // sem acionar a regra global de capa de seção.
  show heading.where(level: 1): it => it
  set heading(outlined: false)
  set page(header: none, footer: none)
  polylux-slide(
    align(
      center + horizon,
      {
        gdg-color-strip()
        v(1.5em)
        body
      },
    )
  )
}

// Focus slide: slide de destaque, com fundo colorido (default: azul GDG).
#let gdg-focus-slide(
  background: gdg-blue,
  foreground: white,
  body,
) = {
  set page(
    fill: background,
    header: none,
    footer: none,
  )
  set text(
    fill: foreground,
    size: 1.5em,
  )
  polylux-slide(align(center + horizon, body))
}

// Slide padrão com cabeçalho (faixa + seção atual) e rodapé (footer + paginação).
#let gdg-slide(body) = {
  // Cabeçalho dinâmico: faixa de cores GDG + nome da seção atual.
  // A seção é registrada automaticamente pelo show rule no gdg-theme.
  let header-content = block[
    #v(0.4em)
    #gdg-color-strip()
    #v(0.2em)
    #gdg-meta-text(toolbox.current-section)
  ]

  // Rodapé: texto configurável à esquerda + contador de slide à direita.
  let footer-content = context gdg-meta-text([
    #gdg-footer.get()
    #h(1fr)
    #toolbox.slide-number
    #text(" / ")
    #toolbox.last-slide-number
  ])

  set page(
    header: header-content,
    footer: footer-content,
    footer-descent: 1em,
    header-ascent: 1.2em,
  )

  polylux-slide(body)
}

// ---------------------------
// Reexports com nomes "padrão" Polylux
// ---------------------------

#let slide          = gdg-slide
#let title-slide    = gdg-title-slide
#let centered-slide = gdg-centered-slide
#let focus-slide    = gdg-focus-slide
#let theme          = gdg-theme
