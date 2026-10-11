// ============================================================
// jlreq.typ
// W3C「日本語組版処理の要件」(JLReq) に準拠した Typst テンプレート
// main.typ から #import "jlreq.typ": jlreq, jidori
// で読み込んで使用する。
// ============================================================

// ────────────────────────────────────────────────────────────
// 用紙サイズ辞書（縦向き基準、単位: pt）
// 辞書の値は常に (短辺, 長辺) の順で格納し、
// flipped パラメータで幅・高さを入れ替える。
// ────────────────────────────────────────────────────────────
#let _paper-sizes = (
  "a0": (2383.93pt, 3370.36pt),
  "a1": (1683.77pt, 2383.93pt),
  "a2": (1190.53pt, 1683.77pt),
  "a3": (841.88pt, 1190.53pt),
  "a4": (595.27pt, 841.88pt),
  "a5": (419.52pt, 595.27pt),
  "a6": (297.63pt, 419.52pt),
  "a7": (209.76pt, 297.63pt),
  "b3": (1031.79pt, 1459.84pt),
  "b4": (728.49pt, 1031.79pt),
  "b5": (515.90pt, 728.49pt),
  "b6": (362.83pt, 515.90pt),
  "b7": (257.95pt, 362.83pt),
  "jis-b4": (857.53pt, 1212.26pt),
  "jis-b5": (606.13pt, 857.53pt),
  "jis-b6": (428.76pt, 606.13pt),
  "us-letter": (611.99pt, 791.99pt),
  "us-legal": (611.99pt, 1007.98pt),
)

// ────────────────────────────────────────────────────────────
// テンプレート関数
// ────────────────────────────────────────────────────────────
#let jlreq(
  // 書誌情報
  title: none,
  subtitle: none,
  author: none,
  // 所属一覧（配列）。beamerの\instituteに相当。番号付きで下部にまとめて表示
  institute: none,
  // 各著者の所属を institute 配列内の番号(1始まり)で指定
  // 単一著者なら整数または整数の配列、複数著者ならauthorと同じ順の配列
  // （複数所属の場合はその著者の要素を配列にする 例: (1, (1,2), 2)）
  author-institute: none,
  // 所属番号を表示する際の記号列。author-institute の数値をこの配列の
  // インデックスとして引き、脚注の数字と見分けやすい記号に変換する。
  // 11箇所目以降は記号が尽きるため番号そのものにフォールバックする。
  institute-symbols: ("*", "†", "‡", "§", "¶", "‖", "**", "††", "‡‡", "§§", "¶¶", "‖‖"),
  // 著者ごとに固有の脚注（メールアドレス等）。単一著者なら文字列、
  // 複数著者ならauthorと同じ順の配列
  author-note: none,
  date: none,

  // 用紙
  paper: "a4", // "a4" / "b5" / "jis-b5" など
  flipped: false, // false = 縦向き（既定）、true = 横向き

  // フォントサイズ
  font-size: 10pt, // 本文和文フォントサイズ（全組版の基準単位）

  // 版面（はんづら）指定
  // ・line-length    : 一行の長さ（横方向の版面幅）
  //   auto → 後述の余白計算から自動決定
  // ・number-of-lines: 一ページの行数（縦方向の版面高さ）
  //   auto → 後述の余白計算から自動決定
  // margin-* を明示指定した場合はそちらが優先される。
  line-length: auto,
  number-of-lines: auto,

  // 余白（上下左右を独立指定）
  // auto のとき:
  //   左右余白候補 = (紙幅 - 紙幅×75% の font-size 整数倍) / 2
  //   上下余白候補 = (紙高 - 紙高×75% の leading 整数倍)  / 2
  //   → 両候補の小さい方を上下左右すべてに適用
  //     （外周から等距離に版面を置く JLReq の精神に従う）
  margin-top: auto,
  margin-bottom: auto,
  margin-left: auto,
  margin-right: auto,

  /// 行送り（font-size への倍率で指定、JLReq 推奨: 1.7）
  // 例: 1.7 → base-leading = font-size × 1.7
  leading: auto,

  // 段組
  num-columns: 1,
  gap-columns: 2em,

  // フォント
  ja-serif: "Harano Aji Mincho",
  en-serif: "Nimbus Roman",
  ja-sans: "Harano Aji Gothic",
  en-sans: "Nimbus Sans",
  code-font: "HackGen", // コードブロック用等幅フォント

  // 見出し番号書式（none で番号なし）
  heading-numbering: "1.1.",

  // ページスタイル
  page-numbering: "1",
  running-head: none,

  // 本文
  body,
) = {
  // ══════════════════════════════════════════════════════════
  // § 1  基本寸法の計算
  // ══════════════════════════════════════════════════════════

  // 行送り（ベースライン間隔）
  let base-leading = if leading == auto { font-size * 1.7 } else { font-size * leading }

  // Typst の par.leading は「行間」（ベースライン間隔 − フォントサイズ）
  let line-gap = base-leading - font-size

  // ── 用紙寸法の取得（縦向き基準、flipped で入れ替え）──────
  let psize = _paper-sizes.at(paper, default: (0pt, 0pt))
  let short = psize.at(0)
  let long = psize.at(1)
  // 縦向き: 幅=短辺, 高=長辺 / 横向き: 幅=長辺, 高=短辺
  let paper-w = if flipped { long } else { short }
  let paper-h = if flipped { short } else { long }
  let known = paper-w > 0pt

  // ── 版面幅・版面高さの決定 ────────────────────────────────
  // margin-* がすべて auto かつ line-length / number-of-lines も auto のとき、
  // 用紙サイズから算出する（後段の余白計算で使う）。

  // 紙幅の 75% を font-size の整数倍に切り捨てた版面幅候補
  let ll-auto = if known {
    calc.floor(paper-w * 0.75 / font-size) * font-size
  } else { auto }

  // 紙高の 75% を base-leading の整数倍に切り捨てた版面高候補
  let nl-auto = if known {
    calc.floor(paper-h * 0.75 / base-leading)
  } else { auto }

  // line-length / number-of-lines が明示されていればそちらを使う
  let ll = if line-length == auto { ll-auto } else { line-length }
  let nl = if number-of-lines == auto { nl-auto } else { number-of-lines }
  let text-h = if nl == auto { auto } else { nl * base-leading }

  // ── 余白の決定 ────────────────────────────────────────────
  //
  // 【auto の場合の計算手順】
  //   1. 左右余白候補 = (紙幅 − 版面幅) / 2
  //   2. 上下余白候補 = (紙高 − 版面高) / 2
  //   3. uniform = min(左右候補, 上下候補)
  //      → 上下左右すべてに同じ余白を適用
  //        （外周から等距離に版面を置く）
  //
  // 【margin-* が明示されている場合】
  //   その値をそのまま使用（他辺の auto には uniform を適用）

  let calc-lr = if known and ll != auto { (paper-w - ll) / 2 } else if known { paper-w * 0.125 } else { none }

  let calc-tb = if known and text-h != auto { (paper-h - text-h) / 2 } else if known { paper-h * 0.125 } else { none }

  // 上下・左右の小さい方を uniform マージンとして採用
  let uniform = if calc-lr != none and calc-tb != none {
    calc.min(calc-lr, calc-tb)
  } else if calc-lr != none { calc-lr } else if calc-tb != none { calc-tb } else { none }

  let resolve(explicit, fallback) = {
    if explicit != auto { explicit } else if fallback != none { fallback } else { auto }
  }

  let m-top = resolve(margin-top, uniform)
  let m-bottom = resolve(margin-bottom, uniform)
  let m-left = resolve(margin-left, uniform)
  let m-right = resolve(margin-right, uniform)

  // ══════════════════════════════════════════════════════════
  // § 2  ドキュメント設定
  // ══════════════════════════════════════════════════════════

  set document(
    title: if title != none { title } else { "" },
    author: if author != none { author } else { "" },
  )

  // ══════════════════════════════════════════════════════════
  // § 3  ページ設定
  // ══════════════════════════════════════════════════════════

  set page(
    paper: paper,
    flipped: flipped,
    margin: (
      top: m-top,
      bottom: m-bottom,
      left: m-left,
      right: m-right,
    ),
    numbering: page-numbering,
    header: if running-head != none {
      align(center, text(size: font-size * 0.85, running-head))
    } else { none },
    footer: context align(
      center,
      text(size: font-size * 0.85, counter(page).display(page-numbering)),
    ),
  )

  // ══════════════════════════════════════════════════════════
  // § 4  テキスト設定
  // ══════════════════════════════════════════════════════════

  // 本文
  set text(
    font: ((name: en-serif, covers: "latin-in-cjk"), ja-serif),
    size: font-size,
    lang: "ja",
    region: "JP",
  )

  // 見出し：ゴシック
  show heading: set text(
    font: ((name: en-sans, covers: "latin-in-cjk"), ja-sans),
  )

  // ══════════════════════════════════════════════════════════
  // § 5  段落設定
  // ══════════════════════════════════════════════════════════
  //
  // leading : 行内の行間（= base-leading − font-size）
  // spacing : 段落間の追加空き = leading と同値にして行送りのリズムを統一

  set par(
    first-line-indent: (amount: 1em, all: true),
    leading: line-gap,
    spacing: line-gap,
    justify: true,
    linebreaks: "optimized",
  )

  // ══════════════════════════════════════════════════════════
  // § 6  見出し設定
  // ══════════════════════════════════════════════════════════

  set heading(numbering: heading-numbering)

  // 節 (level 1) 数式カウンタを節ごとにリセット
  show heading.where(level: 1): it => {
    counter(math.equation).update(0) // ← リセットをここに統合
    set text(size: font-size * 1.4, weight: "bold")
    block(above: base-leading * 1.0, below: line-gap * 1.4, it)
  }
  // 小節 (level 2)
  show heading.where(level: 2): it => {
    set text(size: font-size * 1.2, weight: "bold")
    block(above: base-leading * 1.0, below: line-gap * 1.2, it)
  }

  // 項 (level 3)
  show heading.where(level: 3): it => {
    set text(size: font-size * 1.1, weight: "bold")
    block(above: base-leading * 1.0, below: line-gap * 1.1, it)
  }

  // 目 (level 4)
  show heading.where(level: 4): it => {
    set text(size: font-size, weight: "bold")
    block(above: base-leading * 1.0, below: line-gap * 1.0, it)
  }

  // ══════════════════════════════════════════════════════════
  // § 7  その他の要素
  // ══════════════════════════════════════════════════════════

  // 箇条書き（JLReq: 字下げは全角単位）
  set list(indent: 1em, body-indent: 0.5em)
  set enum(indent: 1em, body-indent: 0.5em)
  set terms(indent: 1em, hanging-indent: 1.65em)

  // キャプション設定
  // ・表：キャプションを上・標準ウェイト
  // ・図：キャプションを下（既定）・標準ウェイト
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.caption: it => {
    set text(size: font-size * 1.0, weight: "regular")
    block(above: 0.5em, it)
  }

  // 引用（JLReq: 前後に一行空き、左右インデント、フォント縮小）
  show quote: it => {
    block(
      above: base-leading,
      below: base-leading,
      inset: (left: 2em, right: 2em),
      text(size: font-size * 0.95, it.body),
    )
  }

  // 脚注（JLReq: 本文より一段小さいフォント、字下げなし・左詰め）
  // Typst 既定の footnote.entry テンプレートは番号列に固定幅の
  // ぶら下げインデントを内部で設定しており、first-line-indent を
  // 0pt にしても字下げが残ることがある。そのため既定テンプレートには
  // 頼らず、番号と本文を自前で組み立てて完全に左詰めにする。
  show footnote.entry: it => {
    set text(size: font-size * 0.90)
    set par(first-line-indent: 0pt, hanging-indent: 0pt, justify: false)
    let num = counter(footnote).at(it.location()).first()
    numbering(it.note.numbering, num)
    h(0.2em)
    it.note.body
  }

  // コードブロック
  // コード：フォント指定はshow内に集約
  show raw: it => {
    if it.block {
      block(
        fill: luma(245),
        stroke: 0.5pt + luma(180),
        inset: (x: 10pt, y: 8pt),
        radius: 4pt,
        width: 100%,
        above: base-leading,
        below: base-leading,
        text(font: code-font, size: font-size * 0.9, it),
      )
    } else {
      highlight(
        fill: luma(232),
        radius: 2pt,
        extent: 3pt,
        text(font: code-font, size: font-size * 0.9, it),
      )
    }
  }

  // 数式番号（章番号連動・章リセット）
  // level 1 見出しが現れるたびに数式カウンタをリセット
  // 表示形式: (1.1), (1.2), … / 章が変わると (2.1), (2.2), … にリセット
  set math.equation(
    numbering: num => context {
      let h1 = counter(heading).get().first()
      numbering("(1.1)", h1, num)
    },
    supplement: none, // show ref で独自整形するため supplement は使わない
  )

  // 数式の相互参照：「式 N.N」形式で出力（括弧なし）
  // #it をそのまま使うと supplement + 番号書式が展開されて重複するため、
  // カウンタから章番号・式番号を直接取り出して整形する。
  show ref: it => {
    if it.element != none and it.element.func() == math.equation {
      context {
        let loc = it.element.location()
        let h1 = counter(heading).at(loc).first()
        let num = counter(math.equation).at(loc).first()
        [式 #h1.#num]
      }
    } else {
      it
    }
  }

  // ══════════════════════════════════════════════════════════
  // § 8  タイトルページ
  // ══════════════════════════════════════════════════════════

  if title != none {
    align(center)[
      #v(base-leading * 0.00)
      #text(size: font-size * 1.80, weight: "bold", title)
      #if subtitle != none {
        v(base-leading * 0.30)
        text(size: font-size * 1.40, subtitle)
      }
      #v(base-leading * 0.7)
      #if author != none {
        // 所属番号(数値)を記号に変換して上付き表示するヘルパー
        // 数値のまま指定させ、表示だけ institute-symbols の記号に置き換える
        let symbol-for(n) = {
          if n >= 1 and n <= institute-symbols.len() {
            institute-symbols.at(n - 1)
          } else {
            str(n)   // 記号が尽きたら番号にフォールバック
          }
        }
        let inst-mark(idx) = {
          if idx == none { return }
          let idxs = if type(idx) == array { idx } else { (idx,) }
          super(text(size: font-size * 1.0, idxs.map(symbol-for).join("")))
        }
        if type(author) == array {
          // 複数著者: author / author-institute / author-note を同じ順で対応させる
          let notes = if type(author-note) == array { author-note } else { (none,) * author.len() }
          let insts = if type(author-institute) == array { author-institute } else { (none,) * author.len() }
          for (i, a) in author.enumerate() {
            if i > 0 { text(size: font-size * 1.00, "、") }
            text(size: font-size * 1.00, a)
            if i < insts.len() { inst-mark(insts.at(i)) }
            let note = if i < notes.len() { notes.at(i) } else { none }
            if note != none { footnote(note) }
          }
        } else {
          // 単一著者
          text(size: font-size * 1.00, author)
          inst-mark(author-institute)
          if type(author-note) == str { footnote(author-note) }
        }
      }
      #if institute != none {
        v(base-leading * 0.30)
        block(
          for (i, inst) in institute.enumerate() {
            if i > 0 { linebreak() }
            let mark = if i + 1 <= institute-symbols.len() {
              institute-symbols.at(i)
            } else {
              str(i + 1)
            }
            text(size: font-size * 0.80)[#super(text(size: font-size * 1.00, mark)) #inst]
          }
        )
      }
      #if date != none {
        v(base-leading * 0.4)
        text(size: font-size, date)
      }
      #v(base-leading * 1.0)
    ]
  }

  // ══════════════════════════════════════════════════════════
  // § 9  本文出力
  // ══════════════════════════════════════════════════════════
  // set page(columns: ...) はページ全体のプロパティであり、本文の直前で
  // 変更してもタイトルを含むページ全体に遡って適用されてしまう
  // （ページ内で列数を混在させられないため）。
  // そこで columns() 関数（ブロックレベルの段組）を使い、
  // 本文だけをローカルに段組する。タイトルはこの影響を受けない。

  if num-columns > 1 {
    columns(num-columns, gutter: gap-columns, body)
  } else {
    body
  }
}

// ============================================================
// ユーティリティ関数（main.typ から個別に import して使用）
// ============================================================

// 字取り（n 文字分の幅に均等配置）
// body は文字列（"均等割付"）または content（[均等割付]）どちらでも可。
// content の場合は一度 str に変換してから文字単位に分割する。
#let jidori(width, body) = {
  // content → str に変換（plain text として取り出す）
  let s = if type(body) == str { body } else { body.text }
  let chars = s.clusters()
  box(
    width: width,
    // 先頭と末端は揃える（h(1fr) だけだと両端に余白ができるため
    // 先頭・末端を 0fr、文字間を 1fr にする）
    stack(
      dir: ltr,
      ..chars.map(c => text(c)).intersperse(h(1fr)),
    ),
  )
}
