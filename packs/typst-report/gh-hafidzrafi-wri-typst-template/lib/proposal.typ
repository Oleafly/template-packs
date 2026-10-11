// lib/proposal.typ
// Master Engine Standar Format Proposal Kegiatan Workshop dan Riset Informatika (WRI) Polinema

#import "terbilang.typ": terbilang-rupiah, format-rupiah
#import "rab.typ": render-sumber-dana, render-pengeluaran-sie, render-rekapitulasi, hitung-total-pengeluaran, hitung-total-sumber-dana
#import "cover.typ": render-cover
#import "pernyataan.typ": render-surat-pernyataan
#import "pengesahan.typ": render-lembar-pengesahan
#import "kepanitiaan.typ": render-susunan-kepanitiaan
#import "acara.typ": render-susunan-acara
#import "lampiran.typ": render-daftar-panitia-offline
#import "ttd.typ": render-box-materai, render-ttd-pair, render-ttd-pernyataan

#let proposal(
  doc
) = {
  // A4 paper with Polinema margins (Left 4.0cm, Right 2.5cm, Top 3.0cm, Bottom 3.0cm)
  set page(
    paper: "a4",
    margin: (
      left: 4.0cm,
      right: 2.5cm,
      top: 3.0cm,
      bottom: 3.0cm
    ),
    header: none,
    footer: none
  )

  // Typography: Times New Roman, 12pt, 1.5 line spacing (leading 1.00em = 24pt pitch)
  set text(
    font: "Times New Roman",
    size: 12pt,
    lang: "id"
  )

  set par(
    leading: 0.75em,
    spacing: 12pt,
    justify: true,
    first-line-indent: 0pt
  )

  // Reset indentation and line spacing for tables, grids, and lists
  show heading: set par(first-line-indent: 0pt, leading: 0.75em, justify: false)
  show table: set par(first-line-indent: 0pt, leading: 0.75em, justify: false)
  show grid: set par(first-line-indent: 0pt, leading: 0.75em, justify: false)
  show enum: set par(first-line-indent: 0pt, leading: 0.75em, justify: true)
  show list: set par(first-line-indent: 0pt, leading: 0.75em, justify: true)
  show rect: set par(first-line-indent: 0pt, justify: false)
  set enum(spacing: 12pt)
  set list(spacing: 12pt)

  // Heading Level 1 (Grey Banner #BFBFBF)
  show heading.where(level: 1): it => {
    v(12pt, weak: true)
    let m = if it.body.has("text") {
      it.body.text.match(regex("^([IVXLCDM]+\.)\s*(.*)$"))
    } else {
      none
    }
    let formatted = if m != none {
      let num = m.captures.at(0)
      let rest = m.captures.at(1)
      grid(
        columns: (30pt, 1fr),
        align: left + horizon,
        [#num],
        [#rest]
      )
    } else {
      it.body
    }
    rect(
      width: 100%,
      fill: rgb("BFBFBF"),
      stroke: none,
      inset: (left: 6pt, right: 6pt, y: 3.5pt),
      radius: 0pt,
      align(left)[
        #text(weight: "bold", size: 12pt)[#formatted]
      ]
    )
    v(6pt, weak: true)
  }

  // Heading Level 2
  show heading.where(level: 2): it => {
    v(12pt, weak: true)
    text(weight: "bold", size: 12pt)[#it.body]
    v(6pt, weak: true)
  }

  doc
}
