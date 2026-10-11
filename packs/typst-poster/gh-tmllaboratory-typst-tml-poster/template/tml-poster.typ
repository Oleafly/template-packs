// tml-poster.typ — TML Lab A0 poster layout (do not edit)
#import "colors.typ": *

// ── logo card ─────────────────────────────────────────────────────────────

#let logo-card(img, card-height: 9.5cm, card-width: 13cm, bg: white) = block(
  fill: bg,
  radius: if bg == none { 0pt } else { 8pt },
  inset: if bg == none { (x: 0pt, y: 0pt) } else { (x: 14pt, y: 10pt) },
  width: card-width,
  height: card-height,
  clip: false,
  align(center + horizon,
    image(img, width: 100%, height: card-height - 20pt, fit: "contain"),
  ),
)

// ── section box ───────────────────────────────────────────────────────────
//
// section() は必ず poster-body() の引数として使う。
// 戻り値は (span:, content:) の辞書で、poster-body() が grid/flow に応じて処理する。
//
// 引数:
//   span: 1   → 1カラム（デフォルト）
//   span: 2   → 全幅（grid/flow どちらでも任意の位置に置ける）
//   accent: true → タイトルバーをアクセントカラー（オレンジ）にする

#let _section-box(title, body, accent: false) = {
  let bar-color = if accent { tml-accent } else { tml-blue }
  let box-content = stack(
    block(
      width: 100%,
      inset: (x: 18pt, y: 9pt),
      fill: bar-color,
      radius: (top-left: 8pt, top-right: 8pt),
      text(fill: white, weight: "bold", size: 28pt, title),
    ),
    block(
      width: 100%,
      inset: (x: 18pt, y: 14pt),
      fill: tml-light,
      radius: (bottom-left: 8pt, bottom-right: 8pt),
      body,
    ),
  )
  block(breakable: false, box-content)
}

#let section(title, body, span: 1, accent: false) = (
  span: span,
  content: _section-box(title, body, accent: accent),
)

// ── highlight box ─────────────────────────────────────────────────────────

#let highlight-box(body) = block(
  width: 100%,
  inset: (x: 18pt, y: 12pt),
  fill: rgb("#fff8ed"),
  stroke: (left: (thickness: 6pt, paint: tml-accent)),
  body,
)

// ── reference list ───────────────────────────────────────────────────────
//
// 参考文献リスト（IEEE番号順）。enum の "+" マーカーで番号 [1],[2]... が
// 自動で振られる。本文中の引用は手書きで [1] のように書く。
//
//   #let sec-references = reference-list[
//     + T. G. Dietterich and G. Bakiri, ``Solving multiclass ...,''
//       _J. Artif. Intell. Res._, vol. 2, pp. 263–286, 1995.
//     + 雲居 玄道, 他, ``...,'' _Int. J. Neural Syst._, vol. 33, 2023.
//   ]
//
// 文献数が多いときは cols: 2 で2段組にできる。
#let reference-list(body, size: 18pt, cols: 1) = {
  set text(size: size, fill: tml-text)
  set par(leading: 0.5em, spacing: 0.55em)
  set enum(numbering: "[1]", body-indent: 0.5em, indent: 0pt)
  if cols == 1 { body } else { columns(cols, body) }
}

// ── poster body ───────────────────────────────────────────────────────────
//
// flow: false（デフォルト）= グリッドモード: 同じ行のボックスは高さが揃う
// flow: true              = フローモード: 左右カラムが独立した高さになる
//
// どちらのモードでも span: 2 のセクションは先頭・中間・末尾の任意の位置に置ける。
//
// グリッドモード:
//   #poster-body(
//     section[A][...],          // 左カラム
//     section[B][...],          // 右カラム  ← A と同じ高さに揃う
//     section([C], ..., span: 2),  // 全幅（中間に差し込み可）
//     section[D][...],          // 左カラム
//     section[E][...],          // 右カラム
//   )
//
// フローモード:
//   #poster-body(
//     flow: true,
//     section([C], ..., span: 2),  // 全幅（先頭でも可）
//     section[A][...],             // 左カラム（高さ独立）
//     section[B][...],             // 右カラム（高さ独立）
//   )

#let poster-body(flow: false, ..blocks) = {
  let blks = blocks.pos()

  if not flow {
    // ── グリッドモード: 行ごとに高さを揃える（デフォルト） ──────────────────
    let cells = blks.map(b => {
      if b.span == 2 {
        grid.cell(colspan: 2, b.content)
      } else {
        b.content
      }
    })
    grid(
      columns: (1fr, 1fr),
      column-gutter: 1.5cm,
      row-gutter: 1.1cm,
      ..cells,
    )

  } else {
    // ── フローモード: 左右カラムが独立した高さ ──────────────────────────────
    // span:1 ブロックを連続グループにまとめ、span:2 を区切りとして挿入する。
    // 例: [A1, A2, span2-B, C1, C2] → cols(A1,A2) / full(B) / cols(C1,C2)

    let segs = ()   // (kind: "cols"|"full", ...) の配列
    let cur  = ()   // 収集中の span:1 content

    for b in blks {
      if b.span == 2 {
        if cur.len() > 0 {
          segs = (..segs, (kind: "cols", items: cur))
          cur = ()
        }
        segs = (..segs, (kind: "full", item: b.content))
      } else {
        cur = (..cur, b.content)
      }
    }
    if cur.len() > 0 { segs = (..segs, (kind: "cols", items: cur)) }

    let parts = segs.map(seg => {
      if seg.kind == "full" {
        seg.item
      } else {
        // span:1 を左右に振り分け（奇数番目→左, 偶数番目→右）
        let left  = ()
        let right = ()
        let go-left = true
        for item in seg.items {
          if go-left { left  = (..left,  item) }
          else       { right = (..right, item) }
          go-left = not go-left
        }
        grid(
          columns: (1fr, 1fr),
          column-gutter: 1.5cm,
          stack(spacing: 1.5cm, ..left),
          if right.len() > 0 { stack(spacing: 1.5cm, ..right) } else { [] },
        )
      }
    })
    stack(spacing: 1.5cm, ..parts)
  }
}

// ── header & footer content builders ─────────────────────────────────────

#let _make-header(title, subtitle, authors, affil) = block(
  width: 100%,
  fill: tml-blue,
  inset: (x: 2cm, top: 1.2cm, bottom: 0cm),
  stack(
    grid(
      columns: (13cm, 1fr, 13cm),
      column-gutter: 1.2cm,
      align: horizon,
      logo-card("../assets/logo-nut-white.png", bg: none),
      align(center)[
        #text(size: 50pt, weight: "bold", fill: white, title)
        #v(0.35cm)
        #text(size: 28pt, fill: rgb("#ccd6ee"), subtitle)
        #v(0.3cm)
        #text(size: 28pt, fill: white, authors)
        #v(0.2cm)
        #text(size: 23pt, fill: rgb("#a0b4cc"), affil)
      ],
      logo-card("../assets/logo-tml-white.png", bg: none),
    ),
    v(1cm),
    block(width: 100%, height: 0.6cm, fill: tml-accent),
  ),
)

#let _make-footer(conf, contact, funding) = block(
  width: 100%,
  fill: tml-blue,
  inset: (x: 2cm, y: 0.8cm),
  grid(
    columns: (1fr, 1fr, 1fr),
    align: horizon,
    text(fill: white, size: 22pt, conf),
    align(center, text(fill: white, size: 22pt, contact)),
    align(right, text(fill: rgb("#a0b4cc"), size: 20pt, funding)),
  ),
)

// ── main show rule ────────────────────────────────────────────────────────

#let tml-poster(
  title: [],
  subtitle: [],
  authors: [],
  affil: [],
  conf: [],
  contact: [],
  funding: [],
  body,
) = {
  let hdr = _make-header(title, subtitle, authors, affil)
  let ftr = _make-footer(conf, contact, funding)

  set page(
    width: 84.1cm,
    height: 118.9cm,
    margin: (top: 0pt, bottom: 0pt, left: 0pt, right: 0pt),
    header: none,
    footer: none,
  )
  set text(
    font: ("Noto Sans CJK JP", "Hiragino Sans", "Yu Gothic",
           "New Computer Modern"),
    size: 26pt,
    lang: "ja",
    fill: tml-text,
  )
  set par(leading: 0.8em, spacing: 1em)
  set math.equation(numbering: none)
  show math.equation: set text(font: ("New Computer Modern Math",
                                       "New Computer Modern"))
  show figure.caption: set text(size: 20pt, fill: tml-gray)
  set figure(supplement: [図])

  place(top + left, hdr)
  place(bottom + left, ftr)

  block(
    width: 100%,
    inset: (x: 2cm, top: 12.5cm, bottom: 2.8cm),
    body,
  )
}
