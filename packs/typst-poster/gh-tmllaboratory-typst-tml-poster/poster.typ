// poster.typ — エントリーポイント（学生は触らないでください）
#import "template/tml-poster.typ": *
#import "content.typ": *

#show: tml-poster.with(
  title:    poster-title,
  subtitle: poster-subtitle,
  authors:  poster-authors,
  affil:    poster-affil,
  conf:     poster-conf,
  contact:  poster-contact,
  funding:  poster-funding,
)

// ── ポスターレイアウト ────────────────────────────────────────────────
// section(タイトル, 内容)               → 1カラム（デフォルト）
// section(タイトル, 内容, span: 2)     → 全幅（2カラム幅）
// section(タイトル, 内容, accent: true) → アクセントカラーのバー
// 上から左→右の順でセルが埋まります。
// ────────────────────────────────────────────────────────────────────
#poster-body(
  // 行1
  section[研究背景][#sec-background],
  section[提案手法][#sec-method],

  // 行2
  section[実験設定][#sec-experiment],
  section[実験結果][#sec-results],

  // 行3：全幅・アクセントカラー
  section([まとめ & 今後の課題], sec-conclusion, span: 2, accent: true),

  // 行4：参考文献（全幅）
  section([参考文献], sec-references, span: 2),
)
