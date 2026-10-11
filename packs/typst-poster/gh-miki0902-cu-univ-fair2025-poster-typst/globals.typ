// =============================================================================
// JSTポスター テンプレート グローバル設定ファイル
// =============================================================================
// このファイルは、Typstポスタープロジェクト全体で使用する共通設定、
// ユーティリティ関数、色定義、数学記法等を定義しています。
// main.typ、contents.typ等から参照されます。

// =============================================================================
// 外部ライブラリのインポート
// =============================================================================

// --- 図表・アノテーション関連ライブラリ ---
#import "@preview/cetz:0.3.1" // 2D描画・作図ライブラリ
#import "@preview/pinit:0.2.2": * // ピン機能（要素の位置指定・アノテーション）

// =============================================================================
// カラーパレット定義（学術ポスター用統一デザイン）
// =============================================================================

// --- メインカラー（JSTブランドカラーに基づく） ---
#let primary-color = rgb("#1e3a8a") // 主要色：JSTブルー（信頼感・学術性）
#let text-on-primary = white // プライマリ背景上のテキスト色（白色）
#let heading-text-color = primary-color.darken(20%) // 見出し用：より濃い青（視認性向上）

// ---MPRG用のカラー
#let mprg-blue_1 = rgb("#0565c0") //濃いめのブルー
#let mprg-blue_2 = rgb("#05a8d4") //少し薄いブルー
#let mprg-blue_text = rgb("004c90")

// --- テキストカラー（読みやすさ重視） ---
#let body-text-color = rgb("#333333") // 本文テキスト：ダークグレー（目に優しい）
#let muted-text-color = rgb("#555555") // 補助テキスト：ミュート色（キャプション等）

// --- アクセント・装飾カラー ---
#let line-color = primary-color.lighten(60%) // 区切り線等：薄い青（控えめな装飾）
#let box-fill-color = primary-color.lighten(93%) // ボックス背景：非常に薄い青
#let accent-color = rgb("#dc2626") // アクセント色：JSTレッド（重要事項の強調）

// =============================================================================
// スタイル定義関数
// =============================================================================

// --- 重要ポイント用ボックススタイル ---
// 用途：定理、重要概念、キーポイントの強調表示
#let key-point(body, alignOption: center) = {
    align(
        alignOption, // テキストの配置（デフォルト：中央）
        block(
            fill: box-fill-color, // 背景色：薄い青
            stroke: (left: 8pt + accent-color), // 左側アクセント線：太い赤線
            radius: 4pt, // 角丸：4pt（優しい印象）
            inset: 0.8em, // 内側余白：0.8em
            width: auto, // 幅：自動調整
            [
                #set text(
                    // ボックス内テキスト設定
                    size: 1.05em, // フォントサイズ：少し大きく
                    weight: "bold", // 太字
                    fill: black, // 色：プライマリカラー
                )
                #body // 内容を表示
            ],
        ),
    )
}



// --- 研究目的用ボックススタイル ---
// 用途：研究目的、仮説、目標の明確な表示
#let research-objective(body) = {
    block(
        fill: accent-color.lighten(90%), // 背景色：薄い赤
        stroke: (left: 8pt + accent-color), // 左側アクセント線
        radius: 4pt, // 角丸
        inset: 1em, // 内側余白
        width: 100%, // 幅を100%に設定
        [
            #set text(
                size: 1.1em, // フォントサイズ：少し大きく
                weight: "bold", // 太字
                fill: accent-color.darken(20%), // 色：濃い赤
            )
            #text(weight: "bold")[研究目的]
            #v(0.5em)
            #set text(
                size: 1em, // 通常サイズ
                weight: "regular", // 通常の太さ
                fill: body-text-color, // 本文色
            )
            #body // 内容を表示
        ],
    )
}

// --- 結果・結論用ボックススタイル ---
// 用途：主要な結果、結論、貢献の強調表示
#let result-box(body) = {
    block(
        fill: primary-color.lighten(85%), // 背景色：薄い青
        stroke: (left: 8pt + primary-color), // 左側アクセント線
        radius: 4pt, // 角丸
        inset: 1em, // 内側余白
        width: 100%, // 幅を100%に設定
        [
            #set text(
                size: 1.1em, // フォントサイズ：少し大きく
                weight: "bold", // 太字
                fill: primary-color.darken(20%), // 色：濃い青
            )
            #text(weight: "bold")[主要結果]
            #v(0.5em)
            #set text(
                size: 1em, // 通常サイズ
                weight: "regular", // 通常の太さ
                fill: body-text-color, // 本文色
            )
            #body // 内容を表示
        ],
    )
}

// =============================================================================
// 数学記法・最適化関数定義
// =============================================================================

// --- 最適化記法 ---
#let argmin = math.op("argmin", limits: true) // argmin演算子（下付き制約付き）
#let argmax = math.op("argmax", limits: true) // argmax演算子（下付き制約付き）
#let prox = math.op("prox", limits: false) // 近接演算子（制約なし）

// --- 統計記法 ---
#let E = math.op("E", limits: false) // 期待値演算子
#let Var = math.op("Var", limits: false) // 分散演算子
#let Cov = math.op("Cov", limits: false) // 共分散演算子

// =============================================================================
// テキスト装飾・サイズ調整関数
// =============================================================================

// --- フォントサイズ調整関数 ---
#let sm(it) = {
    // Small：小さなテキスト
    return text(size: 0.8em, it) // 0.8倍サイズで表示
}
#let lg(it) = {
    // Large：大きなテキスト
    return text(size: 1.2em, it) // 1.2倍サイズで表示
}
#let xl(it) = {
    // Extra Large：非常に大きなテキスト
    return text(size: 1.4em, it) // 1.4倍サイズで表示
}

// =============================================================================
// 追加カラー定義・強調スタイル
// =============================================================================

// --- 拡張カラーパレット ---
#let darkred = red.darken(25%) // 濃い赤：エラー・警告表示
#let darkblue = blue.darken(25%) // 濃い青：情報・補足表示
#let darkgreen = green.darken(25%) // 濃い緑：成功・正常表示
#let lightorange = orange.lighten(50%) // 薄いオレンジ：ハイライト

// --- 意味的強調関数 ---
#let posi(body) = text(darkred, weight: "bold")[#body] // ポジティブ強調（赤太字）
#let nega(body) = text(darkblue, weight: "bold")[#body] // ネガティブ強調（青太字）
#let highlight(body) = text(accent-color, weight: "bold")[#body] // ハイライト強調

// =============================================================================
// 図表作成用ユーティリティ関数
// =============================================================================

// --- 学術図表スタイル関数 ---
// 教科書風の軸・グリッドスタイルを適用
#let schoolbook-style(it) = {
    let filter(value, distance) = value != 0 and distance >= 5pt // 軸ラベル表示フィルタ
    let axis-args = (position: 0, filter: filter) // 軸設定
    show: lq.set-spine(tip: tiptoe.stealth) // 矢印先端スタイル
    show: lq.set-diagram(xaxis: axis-args, yaxis: axis-args) // 軸の適用
    it // 内容を表示
}

// --- フローチャート用スタイル ---
#let flowchart-box(body, fill-color: box-fill-color) = {
    block(
        fill: fill-color,
        stroke: 2pt + primary-color,
        radius: 8pt,
        inset: 0.5em,
        [
            #align(center)[
                #set text(size: 0.9em, weight: "semibold")
                #body
            ]
        ]
    )
}

// =============================================================================
// 3D図形描画関数
// =============================================================================

// --- 多面体描画関数 ---
// 頂点座標と面インデックスから3D多面体を描画
#let polyhedron(vertices, faceIndexes, ..style) = {
    import cetz.draw: * // CeTZ描画機能をインポート
    for face in faceIndexes {
        // 各面に対して
        line(
            ..face.map(i => {
                // 面の頂点を線で結ぶ
                assert(
                    // 頂点インデックスの範囲チェック
                    0 <= i and i < vertices.len(),
                    message: "Vertex index out of bounds",
                )
                vertices.at(i) // 頂点座標を取得
            }),
            close: true, // 閉じた線分
            stroke: style.at("stroke", default: 1pt), // 線のスタイル
            fill: style.at("fill", default: blue), // 面の塗りつぶし色
        )
    }
}

// --- 直方体描画関数 ---
// サイズ指定から直方体を描画
#let cuboid(size, ..style) = {
    polyhedron(
        (
            // 8つの頂点座標を定義
            (-size.at("x"), -size.at("y"), -size.at("z")), // 頂点0
            (-size.at("x"), -size.at("y"), size.at("z")), // 頂点1
            (-size.at("x"), size.at("y"), -size.at("z")), // 頂点2
            (-size.at("x"), size.at("y"), size.at("z")), // 頂点3
            (size.at("x"), -size.at("y"), -size.at("z")), // 頂点4
            (size.at("x"), -size.at("y"), size.at("z")), // 頂点5
            (size.at("x"), size.at("y"), -size.at("z")), // 頂点6
            (size.at("x"), size.at("y"), size.at("z")), // 頂点7
        ),
        (
            // 6つの面を頂点インデックスで定義
            (0, 1, 3, 2), // 左面
            (0, 1, 5, 4), // 下面
            (0, 2, 6, 4), // 前面
            (1, 3, 7, 5), // 上面
            (2, 6, 7, 3), // 右面
            (4, 5, 7, 6), // 後面
        ),
        stroke: style.at("stroke"), // 線のスタイルを適用
        fill: style.at("fill"), // 塗りつぶしスタイルを適用
    )
}

// --- 正立方体描画関数 ---
// 一辺の長さから正立方体を描画
#let cube(size, ..style) = {
    cuboid(
        (x: size, y: size, z: size), // 各軸のサイズを統一
        ..style, // スタイルを継承
    )
} 

