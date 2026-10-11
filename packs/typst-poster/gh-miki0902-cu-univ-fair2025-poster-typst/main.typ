// =============================================================================
// JSTポスター テンプレート メインファイル
// =============================================================================
// このファイルは学術ポスター（A0サイズ）のメイン設定ファイルです。
// Typstを使用してポスターのレイアウト、スタイル、構造を定義しています。

// --- グローバル設定のインポート ---
// globals.typから色設定、ユーティリティ関数、数学記法などをインポート
#import "/globals.typ": *

// =============================================================================
// ページ設定（A0ポスター用）
// =============================================================================
#set page(
    paper: "a0", // A0サイズ (841mm x 1189mm) - 学術ポスター標準サイズ
    flipped: false, // 縦向き（Portrait）配置
    margin: (
        // ページ余白の設定
        top: 3cm, // 上余白：タイトル部分のスペース確保
        bottom: 2cm, // 下余白：参考文献用のスペース
        left: 2.5cm, // 左余白：読みやすさのため
        right: 2.5cm, // 右余白：バランス調整
    ),
)

// =============================================================================
// 基本テキスト・図表のスタイル設定
// =============================================================================

// --- 見出しスタイル ---
#set heading(numbering: none) // 見出し番号を非表示（ポスターでは不要）

// --- 図表設定 ---
#set figure(numbering: none) // 図の番号を非表示（ポスターでは図番号より内容重視）

// --- 基本テキストスタイル ---

#set text(lang: "jp", size: 32pt, fill: body-text-color)


// --- 英語テキスト用フォント設定 ---
#show text.where(lang: "en"): set text(size: 1.0em) // 英語は少し小さく

// --- 数式スタイル ---
#show math.equation: set text(size: 32pt)

// --- 参考文献スタイル ---
#show bibliography: set text(size: 0.7em, lang: "en") // 参考文献は小さく英語設定
#show bibliography: set par(leading: 0.2em) // 行間を狭く設定
#show cite: set text(size: 0.7em) // 引用文字も小さく

// =============================================================================
// 表のスタイル設定
// =============================================================================
// 表のヘッダー行（y: 0）を太字・中央揃え・少し小さく設定
#show table.cell.where(
    y: 0, // 最初の行（ヘッダー行）
    align: center, // 中央揃え
): strong // 太字設定

#show table.cell.where(y: 0): set text(size: 0.9em) // ヘッダー行のフォントサイズを調整

// =============================================================================
// 見出しスタイルのカスタマイズ
// =============================================================================

// --- レベル1見出し（セクションタイトル）のスタイル ---
#show heading.where(level: 1): it => {
    block(
        //stroke: (left: 10pt + accent-color), // 左側のアクセント色の線
        //inset: (x: 15pt), // 水平方向の内側余白
    )[
        #set text(
            // サブ見出しのテキスト設定
            size: 45pt, // 中程度のフォントサイズ
            weight: "bold", // セミボールド
            fill: mprg-blue_text, // 見出し用テキスト色
        )
        
        #it // 見出し内容
        //#v(0.5em, weak: true) // 見出し下の余白
        //#line(length: 100%, stroke: 2pt + line-color) // 下線

    ]
    v(1.0em, weak: true) // ブロック下の余白を狭く
}

// --- レベル2見出し（サブセクション）のスタイル ---
#show heading.where(level: 2): it => {
    block(
        //stroke: (left: 10pt + accent-color), // 左側のアクセント色の線
        //inset: (x: 15pt), // 水平方向の内側余白
    )[
        #set text(
            // サブ見出しのテキスト設定
            size: 40pt, // 中程度のフォントサイズ
            weight: "bold", // セミボールド
            fill: mprg-blue_text, // 見出し用テキスト色
        )
        
        #it // 見出し内容
        //#v(0.5em, weak: true) // 見出し下の余白
        //#line(length: 100%, stroke: 2pt + line-color) // 下線

    ]
    v(1.0em, weak: true) // ブロック下の余白を狭く
}
// --- レベル3見出し（サブセクション）のスタイル ---
#show heading.where(level: 3): it => {
    align(center, block(
        fill: accent-color.lighten(90%),
        //stroke: (left: 10pt + accent-color), // 左側のアクセント色の線
        //inset: (x: 15pt), // 水平方向の内側余白
        radius: 4pt, // 角丸
        inset: 0.4em, // 内側余白
        // width: 100%, // 幅を100%に設定 - 削除してテキスト幅に合わせる
        
    )[
        #set text(
            // サブ見出しのテキスト設定
            size: 38pt, // 中程度のフォントサイズ
            weight: "medium", // ミディアム
            fill: body-text-color, // 見出し用テキスト色
        )
        #it // 見出し内容
        //#v(0.5em, weak: true) // 見出し下の余白
        //#line(length: 100%, stroke: 2pt + line-color) // 下線
    ])
    v(1.0em, weak: true) // ブロック下の余白を狭く
}

// --- リストスタイル ---
// 番号なしリスト（箇条書き）のスタイル
#set list(
    marker: (sym.triangle.r.filled, sym.triangle.l.filled),
    indent: 0.5em, // インデントを0.5emに設定
    body-indent: 0.3em, // 本文のインデントを0.1emに設定
)
// 番号なしリストアイテムのテキストスタイルをカスタマイズ
#show list.item: set text(size: 36pt, fill: body-text-color) // リストアイテムのフォントサイズと色を設定
#show list.item: set par(leading: 0.5em) // リストアイテムの行間を統一

// 番号なしリストブロックの下余白を設定
#show list: it => [
    #it
    #v(0.8em, weak: true) // リスト下の余白（0.5em）
]

// --- 番号付きリストスタイル（+を使った箇条書き） ---
#set enum(
    indent: 1.0em, // インデントを0.5emに設定
    body-indent: 0.3em, // 本文のインデントを0.1emに設定
)
// 番号付きリストアイテムのテキストスタイルをカスタマイズ
#show enum.item: set text(size: 36pt, fill: body-text-color) // 番号付きリストアイテムのフォントサイズと色を設定
#show enum.item: set par(leading: 0.5em) // 番号付きリストアイテムの行間を統一

// 番号付きリストブロックの下余白を設定
#show enum: it => [
    #it
    #v(0.5em, weak: true) // 番号付きリスト下の余白（0.5em）
]



// --- 図表キャプションスタイル ---
#show figure.caption: it => {
    v(0.0em) // 上の余白を削除
    align(
        center,
        text(
            // 中央揃えでキャプション表示
            size: 36pt, // キャプション用フォントサイズ
            style: "italic", // イタリック体
            fill: muted-text-color, // 控えめな色
            it, // キャプション内容
        ),
    )
    v(0.0em) // 下の余白を削除
}

// =============================================================================
// タイトルブロック（ポスター上部）
// =============================================================================
#v(-3cm) // ページ上部との間隔を調整

// メインタイトルブロック
#block(
    fill: white, // 背景色を白に設定
    width: 100%, // 幅を100%に設定
    radius: 4pt, // 角丸設定
    inset: (top: 50pt, bottom: 50pt), // 上下の内側余白
)[
    #align(center)[
        // タイトルブロック内を中央揃え
        #set text(fill: black) // テキスト色を黒に設定

        // メインタイトル
        #text(size: 70pt, weight: 700)[
            パネル3：枝刈り
        ]

        #v(-0.5em) // タイトルと著者情報の間隔

        // 発表者名
        #text(size: 50pt)[小林亮太，西川実希]
        #h(1em) // 水平スペース

        // 所属機関
        #text(size: 45pt)[中部大学　MPRG：機械知覚&ロボティクスグループ]
    ]
]

#place(
    right + top,
    dx: 20pt,
    dy: 5pt,
    image("image/mprg.png",width: 500pt)
)


// タイトル下の装飾線（青と水色）
#v(-2.0em) // タイトルブロックとの間隔
#align(center)[
    // 太い青い線
    #line(length: 100%, stroke: 30pt + mprg-blue_1)
    #v(-0.6em) // 線の間隔
    // 細い水色の線
    #line(length: 100%, stroke: 15pt + mprg-blue_2)
]

// =============================================================================
// メインコンテンツ（2カラムレイアウト）
// =============================================================================
// ポスターのメイン内容を2カラムで表示
//#columns(2, gutter: 2.5cm)[
    // 2カラム、間隔2.5cm
//    #include "/contents.typ" // contents.typファイルからメイン内容を読み込み
//]
#include "/contents.typ"

// =============================================================================
// ファイル構成説明：
// - このファイル（main.typ）：レイアウト・スタイル設定
// - globals.typ：色設定・ユーティリティ関数
// - contents.typ：ポスターのメインコンテンツ 