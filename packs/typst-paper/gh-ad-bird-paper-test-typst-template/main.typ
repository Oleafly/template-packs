//余白・ヘッダー・フッター
#set page(margin: (top:20mm,left:25mm, right:20mm, bottom:20mm),
  header:[#h(1fr)#text(8pt)[20XX年度　〇〇テスト　時間：60分]], 
  footer: context [
    #set align(center)
    #set text(8pt)
    #counter(page).display("1")
  ]
) 
//行間leadingデフォルト:0.65em 段落間spacing 
#set par(leading: 0.7em,spacing: 1em)

//番号リストのリスト間のスペース
#set enum(spacing: 9pt)

//フォント設定（別途後述の「見出しのフォントサイズ」設定が必要）
#set text(font:"Noto Serif CJK JP",lang:"ja",size:10.5pt,)

//見出し設定
// 見出し番号設定
#set heading(numbering: "1.1")
#show heading: set par(leading: 0.5em)//見出しの行間
// デザイン設定
#let heading-size = 10.5pt //見出しのフォントサイズ
#let box-size = 1em
// level=1 の見出しに適用（章など）
#show heading.where(level: 1): it => {
  v(1.5em, weak: true)
  block(below: 01em)[
    // 左側に四角い番号ボックスを配置
    #place(dx: -5mm, dy: -3.3pt)[
      #box(width: box-size)[
        #context {
          align(center + horizon)[
            #box(stroke: 0.5pt + black, inset: 3pt)[
              // カウンタから番号を取得
              #text(
                font: "Noto Serif CJK JP",
                size: heading-size,
                weight: "regular",
                [#counter(heading).get().first()]
              )
            ]
          ]
        }
      ]
    ]

    // 見出し本文
    #set par(hanging-indent: 0.5em) //ぶら下げインデント
    #h(0.5em)//番号と見出し本文との間のスペース
    #text(font:"Noto Serif CJK JP",lang:"ja",size: heading-size, weight: "regular", it.body)
  ]
}

///文末脚注（解答解説）設定
#let allendotes = state("endnotes", ())
#let amt-of-endnotes = counter("amt-of-endnotes")
#let endnote(cnt) = {
  amt-of-endnotes.step(level: 2)
  context {
    allendotes.update(x => x + (cnt + parbreak(),))
    let idx = amt-of-endnotes.get().last()
    let num = amt-of-endnotes.get().map(str).join(".")  // pseudo-uuid
    let in-document = query(selector(label(num))).len() >= 1
    if not in-document {
      return // showendnote() was not called before last endnotes
    }
    link(
      label(num),
      text(white)[#idx]//本文中の文末脚注番号（フォントを白くして見えないようにしている）
    )
  }
}
#let showendnote(name: "解答解説") = context {
  if amt-of-endnotes.get().len() == 1 {
    return
  }
  v(2em)
  align(left, [#text(weight: "bold")[#name]])//解答解説の見出し
  let (level, amt) = amt-of-endnotes.get()
  for idx in range(amt) {
    let num = str(level) + "." + str(idx + 1)
    [#box(stroke: 0.5pt,outset: 3pt)[#(idx + 1)]　] + [#h(5pt)] +[#allendotes.get().at(idx) #label(num)]
  }
  amt-of-endnotes.step()
  allendotes.update(x => ())
}

//ルビ（ふりがな）
#import "@preview/rubby:0.10.2": get-ruby
#let ruby = get-ruby(
  size: 0.5em,         // Ruby font size
  dy: 0pt,             // Vertical offset of the ruby
  pos: top,            // Ruby position (top or bottom)
  alignment: "center", // Ruby alignment ("center", "start", "between", "around")
  delimiter: "|",      // The delimiter between words
  auto-spacing: true,  // Automatically add necessary space around words
)

// ========= 本文 ==========
#text(font: "Noto Sans CJK JP")[出席番号：#h(10em)氏名：]

= 問題文の見出し

正答・解説を文書末に表示させる方法として、文末脚注を利用する。`#endnote[]`で解答解説を挿入。

たとえばこのように。#endnote[これが正答。

簡単な解説も書ける。]

= #ruby[なつめ|そうせき][夏目|漱石]が書いた作品として、最も妥当なものはどれか。1つ選び、数字で答えよ。
+ 吾輩は猫である
+ 吾輩は鳥である
+ あれから
+ 五六郎 #endnote[1　（３点）

『吾輩は猫である』の吾輩は、最後はビールを飲んで大きな甕に落ちて死んでしまう。]

= 空欄に入る語句の組み合わせとして、妥当なものはどれか。

　#ruby[わがはい][吾輩]は（　①　）である。名前はまだ無い。

　どこで生れたかとんと#ruby[けんとう][見当]がつかぬ。何でも薄暗いじめじめした所でニャーニャー泣いていた事だけは記憶している。吾輩はここで始めて（　②　）というものを見た。
#v(1em)
#set enum(numbering: "ア.")
+ ①猫　　②人間
+ ①人間　②猫
+ ①犬　　②人間
+ ①猫　　②犬
#endnote[ア]

= 鹿児島県にはない山はどれか。1つ選び、数字で答えよ。
#set enum(numbering: "1.")
+ 桜島
+ 開聞岳
+ 霧島山
+ 市房山
+ 高隈山

#endnote[4　（３点）

市房山は宮崎県と熊本県にまたがる山。]


= 次の文章の空欄に当てはまる数字の組み合わせとして、最も妥当なものはどれか。

鹿児島県の島の数は、全国（　ア　）番目に多く、有人島の数は（　イ　）番目に多い。

+ ア：3　　イ：2
+ ア：3　　イ：4
+ ア：2　　イ：4
+ ア：2　　イ：2
+ ア：2　　イ：1
#endnote[2  （3点）]

= 次の式を展開せよ。
#set enum(numbering: "①")
+ $( x - 1 ) ( a + 1 )$
#endnote[① $a x + x - a - 1$]


///////// 解答用紙ページ ///////////////
#pagebreak()
*解答用紙*
#v(1em)
#text(font: "Noto Sans CJK JP")[出席番号：#h(10em)氏名：]
#v(2em)
#align(right)[得点：#h(15em)／60点]
#v(2em)

#align(center)[
#table(
  columns: (auto,15em,auto,15em),
  align: center,
  inset: 15pt,
  stroke: 0.5pt,
[問題\ 番号],[#v(0.8em)解答],[問題\ 番号],[#v(0.8em)解答],
[1],[],[11],[],
[2],[],[12],[],
[3],[],[13],[],
[4],[],[14],[],
[5],[],[15],[],
[6],[],[16],[],
[7],[],[17],[],
[8],[],[18],[],
[9],[],[19],[],
[10],[],[20],[],
)
]



///////// 解答解説ページ ///////////////
#pagebreak()//改ページ
#set par(leading: 1em,spacing: 1.5em)
#showendnote() //文末脚注（解答解説）が自動的に挿入される
