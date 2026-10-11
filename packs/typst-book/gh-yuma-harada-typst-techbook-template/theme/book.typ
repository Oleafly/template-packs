#import "@preview/codly:1.3.0": codly, codly-init
#import "colors.typ": border, ink, ink-muted, surface, surface-strong
#import "layout.typ": resolve-layout
#import "typography.typ": mono-font, sans-font, serif-font

#let techbook(config: (:), profile: "preview", body) = {
  let title = config.title
  let subtitle = config.subtitle
  let author = config.author
  let edition = config.edition
  let publication-date = config.date
  let page-layout = resolve-layout(config, profile)
  let mainmatter = state("techbook-mainmatter", false)

  set document(
    title: title,
    author: author,
  )

  set page(
    width: page-layout.width,
    height: page-layout.height,
    bleed: page-layout.bleed,
    binding: page-layout.binding,
    margin: page-layout.margin,
    numbering: "1",
    footer: context {
      if mainmatter.get() {
        let current = counter(page).get().first()
        let side = if calc.even(current) { left } else { right }

        set text(
          font: sans-font,
          size: 8pt,
          fill: ink-muted,
        )

        align(side, counter(page).display("1"))
      }
    },
    footer-descent: 35%,
  )

  set text(
    font: serif-font,
    lang: "ja",
    size: 9pt,
    fill: ink,
  )

  set par(
    justify: true,
    leading: 0.8em,
    spacing: 0.6em,
  )

  set heading(numbering: "1.1")
  show heading: set text(font: sans-font)

  // 目次見出しは除外し、番号付きの章だけを奇数ページから始める。
  show heading.where(level: 1, numbering: "1.1"): it => {
    if page-layout.chapter-starts-on-odd-page {
      pagebreak(weak: true, to: "odd")
    }

    block(
      above: 0pt,
      below: 1.2em,
      text(size: 18pt, weight: "bold", it),
    )
  }

  show heading.where(level: 2): set text(
    size: 14pt,
    weight: "bold",
  )

  show heading.where(level: 3): set text(
    size: 11pt,
    weight: "bold",
  )

  // 本文はモノクロ印刷なので、色付きハイライトを無効にする。
  set raw(
    theme: none,
    tab-size: 2,
  )

  show raw: set text(
    font: mono-font,
    size: 8pt,
    fill: ink,
  )

  show raw.where(block: false): box.with(
    fill: surface,
    inset: (x: 3pt, y: 1pt),
    outset: (y: 2pt),
    radius: 2pt,
  )

  show: codly-init.with()

  codly(
    display-icon: false,
    display-name: true,
    default-color: ink,
    fill: surface,
    zebra-fill: none,
    stroke: 0.5pt + border,
    radius: 3pt,
    lang-fill: _ => surface-strong,
    lang-stroke: _ => 0.5pt + border,
    smart-indent: true,
  )

  show table: set table(
    inset: 5pt,
    align: left,
    stroke: 0.5pt + border,
  )

  show table.cell.where(y: 0): set table.cell(
    fill: surface-strong,
  )

  show table.cell.where(y: 0): set text(
    font: sans-font,
    weight: "bold",
  )

  // 表とコードのキャプションは上、画像などの図は既定どおり下に配置する。
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: raw): set figure.caption(position: top)

  show figure.caption: set text(
    size: 8pt,
    weight: "black",
    fill: ink,
  )

  // 扉。本文のページ番号はまだ表示しない。
  align(center + horizon)[
    #text(
      font: sans-font,
      size: 24pt,
      weight: "bold",
    )[#title]

    #if subtitle != "" [
      #v(5mm)
      #text(size: 13pt)[#subtitle]
    ]

    #v(20mm)
    #text(size: 12pt)[#author]

    #v(8mm)
    #text(size: 9pt)[
      #edition #h(1em) #publication-date
    ]
  ]

  pagebreak(weak: true)

  outline(
    title: [目次],
    indent: auto,
  )

  // 本文を右ページ（奇数ページ）から開始する。
  pagebreak(weak: true, to: "odd")
  mainmatter.update(true)
  counter(page).update(1)

  body
}
