// ミニマムな日本語ドキュメント用テンプレート

// フォントは「欧文, 和文」の順に並べる。和文フォントは環境に合わせて差し替える
// (Linux なら "Noto Serif CJK JP" / "Noto Sans CJK JP" など)
#let serif-ja = ("Libertinus Serif", "Hiragino Mincho ProN")
#let sans-ja = ("Helvetica Neue", "Hiragino Sans")
// 等幅。和文も等幅の BIZ UDGothic に落とす (プロポーショナルだとコードの桁が揃わない)
#let mono-ja = ("Menlo", "BIZ UDGothic")
// 数式フォント。和文は数式中でも明朝に落とす
#let math-ja = ("New Computer Modern Math", "Hiragino Mincho ProN")

// コードブロックの枠。label には言語名かファイル名が入る
#let code-frame(label, body) = block(
  width: 100%,
  radius: 3pt,
  clip: true,
  stroke: 0.5pt + luma(221),
  {
    // 見出し帯とコード本体を密着させる
    set block(spacing: 0pt)
    if label != none {
      block(
        width: 100%,
        fill: luma(240),
        inset: (x: 10pt, y: 4pt),
        stroke: (bottom: 0.5pt + luma(221)),
        // 帯だけがページ末に取り残されないようにする
        sticky: true,
        text(size: 0.8em, font: mono-ja, fill: luma(90), label),
      )
    }
    block(
      width: 100%,
      fill: luma(249),
      inset: (x: 10pt, y: 8pt),
      {
        set par(leading: 0.62em)
        body
      },
    )
  },
)

// 見出し帯にファイル名を出す。言語名のかわりに表示される
#let code-file = state("code-file", none)

#let code(body, file: none) = {
  code-file.update(file)
  body
  code-file.update(none)
}

// 定理環境。定義・定理・補題などで番号を共有し、章ごとに 1.1, 1.2 と振る
#let thm-kind = "theorem"

// 主張（定義・定理など）は左罫で強調する。例・注意は補足なので罫を引かない
#let thm-claims = ("定義", "公理", "定理", "命題", "補題", "系")

#let thm-numbering(n) = context {
  let ch = counter(heading).get()
  if ch.len() > 0 and ch.first() > 0 {
    numbering("1.1", ch.first(), n)
  } else {
    numbering("1", n)
  }
}

#let thm(term, body, name: none) = figure(
  kind: thm-kind,
  supplement: term,
  numbering: thm-numbering,
  caption: none,
  {
    // 定理の主張そのものである式には番号を振らない。
    // 番号が要る式は #[#set math.equation(numbering: "(1)") $ ... $] で戻す。
    set math.equation(numbering: none)
    if name != none [(#name)#h(0.4em)]
    body
  },
)

#let definition(body, name: none) = thm("定義", body, name: name)
#let axiom(body, name: none) = thm("公理", body, name: name)
#let theorem(body, name: none) = thm("定理", body, name: name)
#let proposition(body, name: none) = thm("命題", body, name: name)
#let lemma(body, name: none) = thm("補題", body, name: name)
#let corollary(body, name: none) = thm("系", body, name: name)
#let example(body, name: none) = thm("例", body, name: name)
#let remark(body, name: none) = thm("注意", body, name: name)

// 証明。番号は振らず、末尾に □ を置く
#let proof(body) = block(width: 100%, above: 1.2em, below: 1.2em, inset: (left: 1em))[
  #set par(first-line-indent: 0pt)
  #text(font: sans-ja)[証明.]#h(0.5em)#body#h(1fr)#sym.square
]

#let jdoc(
  title: none,
  author: none,
  date: none,
  // 表紙の次、目次の前に置く前書き。見出しには番号を振らない
  preface: none,
  toc: true,
  // 参考文献ファイル。パスは lib.typ から見た相対位置で解決される
  bib: none,
  // "sist02" は日本語の規格だが supplement が出力されない。既定は ieee
  bib-style: "ieee",
  font: serif-ja,
  heading-font: sans-ja,
  size: 11pt,
  // コードの文字サイズ。本文には連動させず、収容桁数から決める
  code-size: 8.4pt,
  body,
) = {
  set document(title: title, author: if author == none { () } else { author })

  set page(
    paper: "a4",
    margin: (x: 25mm, y: 25mm),
    numbering: "1",
    number-align: center,
  )

  set text(font: font, size: size, lang: "ja", region: "JP")
  set par(
    justify: true,
    leading: 0.9em,
    spacing: 1.2em,
    first-line-indent: (amount: 1em, all: true),
  )

  // 引用符を和文のものにする (既定は欧文の "" のまま)
  set smartquote(quotes: (single: ("『", "』"), double: ("「", "」")))

  // 定理環境。見出しだけゴシックにし、本文は明朝のまま
  // (figure は既定で中央寄せなので左寄せに戻す)
  show figure.where(kind: thm-kind): set align(left)
  show figure.where(kind: thm-kind): it => {
    let claim = thm-claims.map(t => [#t]).contains(it.supplement)
    let num = context it.counter.display(it.numbering)
    block(
      width: 100%,
      above: 1.2em,
      below: 1.2em,
      // 縦の inset で罫を文字の上下に少し伸ばす (行の高さぴったりだと詰まって見える)
      inset: (left: 1em, y: 0.5em),
      // 引用の罫 (2pt luma(210)) より濃く太くして見分けられるようにする
      stroke: if claim { (left: 2.5pt + luma(120)) } else { none },
      {
        set par(first-line-indent: 0pt)
        if claim {
          text(font: sans-ja)[#it.supplement #num]
        } else {
          text(font: sans-ja, fill: luma(90), size: 0.95em)[#it.supplement #num]
        }
        h(0.5em)
        it.body
      },
    )
  }

  // 章が変わったら定理番号をリセットする
  show heading.where(level: 1): it => {
    counter(figure.where(kind: thm-kind)).update(0)
    it
  }

  // 図表のキャプション
  set figure(gap: 0.8em)
  show figure.caption: set text(size: 0.9em)

  // 和文の明朝には太字がないので、強調はゴシックに切り替える。
  // 和文に斜体はなく _..._ は合成斜体になるため、強調は *...* に一本化し
  // emph には手を入れない。
  show strong: set text(font: sans-ja)

  set heading(numbering: "1.1")
  set math.equation(numbering: "(1)")
  show heading: set text(font: heading-font)
  show heading: set block(above: 1.6em, below: 1em)

  // ブロック引用。左罫で本文と区切る
  show quote.where(block: true): it => block(
    width: 100%,
    // 罫が行の高さぴったりだと短く見えるので上下に伸ばす。
    // 定理の罫 (0.5em) より控えめにして階層差をつける
    inset: (left: 1em, y: 0.35em),
    stroke: (left: 2pt + luma(210)),
    {
      it.body
      if it.attribution != none {
        set par(first-line-indent: 0pt)
        align(right, text(size: 0.9em, [——#it.attribution]))
      }
    },
  )

  // 脚注。番号のあとに四分アキを入れ、2 行目以降を番号の幅ぶら下げる
  set footnote.entry(
    separator: line(length: 30%, stroke: 0.5pt + luma(150)),
    clearance: 1.2em,
    gap: 0.5em,
  )
  show footnote.entry: it => {
    let loc = it.note.location()
    let num = numbering(it.note.numbering, ..counter(footnote).at(loc))
    set par(hanging-indent: 1.4em, first-line-indent: 0pt)
    [#super(text(size: 0.9em, link(loc, num)))#h(0.4em)#it.note.body]
  }

  // 相対値 (0.9em など) で書くと show rule の入れ子でサイズが累乗して縮むため
  // 絶対値で指定する。8.4pt で 88 桁入り、Black / Ruff (88) や
  // Prettier (80) で整形したコードがはみ出さない
  show raw: set text(font: mono-ja, size: code-size)

  // コードブロック。見出し帯には言語名、code で包んだ場合はファイル名が出る
  show raw.where(block: true): it => context {
    let file = code-file.get()
    code-frame(if file != none { file } else { it.lang }, it)
  }

  // 文中のコード
  show raw.where(block: false): it => box(
    fill: luma(245),
    radius: 2pt,
    outset: (y: 3pt),
    inset: (x: 2pt),
    it,
  )


  // 数式中の和文を明朝に揃える
  show math.equation: set text(font: math-ja)

  // 文中の数式と和文のあいだに四分アキを入れる (行頭・行末では消える)
  show math.equation.where(block: false): it => {
    h(0.25em, weak: true) + it + h(0.25em, weak: true)
  }

  // 数式の参照を「式 (1)」の形にする
  show ref: it => {
    let el = it.element
    if el != none and el.func() == math.equation {
      link(el.location(), [式 #numbering(
        el.numbering,
        ..counter(math.equation).at(el.location()),
      )])
    } else {
      it
    }
  }
  // 色を付けるのは外部リンクだけ。相互参照は本文色のままにする
  show link: it => if type(it.dest) == str {
    text(fill: blue.darken(20%), it)
  } else {
    it
  }

  // 表紙。ページ番号は振らず、本文を 1 ページ目として数え直す
  if title != none {
    page(numbering: none, align(center + horizon, {
      block(inset: (bottom: 1.2em), text(
        font: heading-font,
        size: 2.2em,
        weight: "bold",
        title,
      ))
      if author != none [ #text(size: 1.1em, author) \ ]
      if date != none [ #v(0.8em) #text(size: 0.95em, date) ]
    }))
    counter(page).update(1)
  }

  // 前書き。章番号は振らず、目次にも載せない
  if preface != none {
    [
      #set heading(numbering: none, outlined: false)
      #preface
    ]
    pagebreak(weak: true)
  }

  // 目次 (lang: "ja" なので見出しは自動で「目次」になる)
  if toc {
    outline(indent: auto)
    pagebreak(weak: true)
  }

  body

  if bib != none {
    bibliography(bib, style: bib-style)
  }
}
