#import "@preview/cjk-spacer:0.1.0": cjk-spacer

// --- 設定関数 ---
#let conf(
  title: "",
  authors: (),
  affiliation: "",
  date: datetime.today().display("[year]年[month]月[day]日"),
  body
) = {
  show: cjk-spacer

  // 1. 文書設定
  set page(
    paper: "a4",
    margin: (x: 2.5cm, y: 3cm),
    numbering: "1",
  )
  set text(font: ("New Computer Modern", "Hiragino Mincho ProN"), lang: "ja", size: 11pt)

  // 2. 見出し設定
  set heading(numbering: "1.1")

  // カウンターのリセット処理
  show heading.where(level: 1): it => {
    counter(math.equation).update(0)
    pagebreak(weak: true)
    it
    v(1em)
  }
  show heading.where(level: 2): it => {
    counter(math.equation).update(0)
    it
    v(0.5em)
  }

  // 3. 数式の番号設定
  set math.equation(numbering: (..nums) => context {
    let num = nums.pos().at(0)
    let h = counter(heading).get()
    let c = if h.len() > 0 { h.at(0) } else { 0 }
    let s = if h.len() > 1 { h.at(1) } else { 0 }
    "(" + str(c) + "." + str(s) + "." + str(num) + ")"
  })

  // ★重要: 参照用のfigure（theorem-env）の見た目をリセットするルール
  // これがないと、定理の周りに余計な隙間ができたり、標準の図表番号が出てしまいます
  show figure.where(kind: "theorem-env"): it => it.body

  // 4. タイトルページの描画
  align(center)[
    #v(6em)
    #text(2.5em, weight: 700, title)
    #v(3em)
    #text(1.3em, weight: "medium", authors.join(", "))
    #if affiliation != "" {
      v(0.5em)
      text(1.1em, affiliation)
    }
    #v(1em)
    #text(1.1em, date)
    #v(6em)
  ]

  // 目次
  outline(indent: auto)
  pagebreak()

  body
}

// --- 定理環境の定義 ---

// 共通のボックス作成関数
// lab引数を追加 (label型を受け取る)
// 共通のボックス作成関数
// 共通のボックス作成関数
#let env-box(kind, title, lab, body) = {
  counter(math.equation).step()

  context {
    let num = counter(math.equation).get().at(0)
    let h = counter(heading).get()
    let c = if h.len() > 0 { h.at(0) } else { 0 }
    let s = if h.len() > 1 { h.at(1) } else { 0 }
    let num-str = str(c) + "." + str(s) + "." + str(num)

    let head-text = [*#kind #num-str*]
    if title != none {
      head-text = [*#kind #num-str* (#title)]
    }

    // デザインされたボックス
    let content-box = block(
      width: 100%,
      inset: (x: 0.9em, y: 0.8em),
      stroke: 0.6pt,
      radius: 4pt,
      below: 1.5em,
    )[
      #head-text \
      #body
    ]

    if lab != none {
      let fig = figure(
        kind: "theorem-env",
        supplement: kind,
        numbering: _ => num-str,
        outlined: false,
        // ★修正: figure内でも強制的に左揃え(start)を維持する
        align(start, content-box)
      )
      [#fig #lab]
    } else {
      content-box
    }
  }
}

// --- 各種環境 ---
// 引数に lab: none を追加し、env-boxへ渡す

#let theorem(title: none, lab: none, body) = env-box("Theorem", title, lab, math.italic(body))

#let proposition(title: none, lab: none, body) = env-box("Proposition", title, lab, math.italic(body))

#let lemma(title: none, lab: none, body) = env-box("Lemma", title, lab, math.italic(body))

#let corollary(title: none, lab: none, body) = env-box("Corollary", title, lab, math.italic(body))

#let definition(title: none, lab: none, body) = env-box("Definition", title, lab, body)

#let proof(body) = {
  block(below: 1.5em)[
    _Proof._ #h(0.5em) #body #h(1fr) $square$
  ]
}

// 練習問題 (採番あり・デザイン変更版)
#let exercise(title: none, lab: none, body) = {
  // 1. カウンターを進める (数式・定理と共通)
  counter(math.equation).step()

  context {
    // 2. 番号生成ロジック
    let num = counter(math.equation).get().at(0)
    let h = counter(heading).get()
    let c = if h.len() > 0 { h.at(0) } else { 0 }
    let s = if h.len() > 1 { h.at(1) } else { 0 }
    let num-str = str(c) + "." + str(s) + "." + str(num)

    // ヘッダー作成
    let head-text = [*Exercise #num-str*]
    if title != none {
      head-text = [*Exercise #num-str* (#title)]
    }

    // 3. デザイン定義 (ここだけenv-boxと異なる)
    let content-box = block(
      fill: luma(250),              // 薄いグレー背景
      stroke: (left: 2pt + black),  // 左に黒い太線
      inset: (x: 1em, y: 0.8em),
      width: 100%,
      below: 1.5em,
      radius: 0pt,                  // 角丸なし
    )[
      #head-text \
      #body
    ]

    // 4. 参照用ラップ処理
    if lab != none {
      let fig = figure(
        kind: "theorem-env",   // 定理と同じkindにしておくか、"exercise-env"にするかはお好みで(今回は定理と混ぜるため共通化)
        supplement: "Exercise",
        numbering: _ => num-str,
        outlined: false,
        align(start, content-box)
      )
      [#fig #lab]
    } else {
      content-box
    }
  }
}

// 解答用の簡易スタイル (変更なし)
#let answer(body) = {
  block(
    below: 1.5em,
    text(fill: luma(10%), size: 0.9em)[
    _Answer._ #h(0.5em) #body #h(1fr) $square$
  ])
}
