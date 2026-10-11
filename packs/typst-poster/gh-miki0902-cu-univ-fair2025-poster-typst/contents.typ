// =============================================================================
// JSTポスター テンプレート メインコンテンツファイル
// =============================================================================
// このファイルは、ポスターのメインコンテンツを統合・構成するファイルです。
// main.typの2カラムレイアウト内で表示される内容を定義しています。
//
// 構成:
// 1. グローバル設定のインポート
// 2. 研究背景・目的
// 3. 手法・アプローチ
// 4. 実験・結果
// 5. 結論・今後の課題
// 6. 参考文献

// =============================================================================
// グローバル設定のインポート
// =============================================================================
// globals.typから色設定、スタイル関数、数学記法等を読み込み
#import "/globals.typ": *

#let custom-par(content)={
    set par(leading:0.9em)
    content
}
#show: custom-par


// =============================================================================
// メインコンテンツの構成
// =============================================================================
//---Introduction---

= 枝刈りの目的・社会的貢献
#v(0.3em) 
#grid(
    columns:(1fr,1fr),gutter: 1em,
    [
        //左側
        #v(0.0em) 
        - 現状の課題：#linebreak()
            AIモデルの高性能化により，モデルのパラメータ数が増加
        - 高性能モデルは：#linebreak()
            大量のメモリと電力を消費 ⚡️ #linebreak()
            推論速度が遅い 🕐
        - 結果として，計算資源の限られたデバイスやリアルタイムな推論が求められる環境では活用が困難
        - 枝刈りによるモデル圧縮#linebreak() 
        + 冗長なパラメータを削除し，モデルを圧縮
        + 高い性能を維持しつつ，モデルサイズ削減・推論時間を短縮
    ],
    [
        //右側
        #v(0.0em) 
        
        #figure(
        image("image/Intro.png",width: 100%)
        )  
    ]
)
=== 枝刈りによって小型・低消費電力，リアルタイムが必要なデバイスへのAI導入が可能に

#v(0.3em) 
#align(center)[
    // 太い青い線
    #line(length: 100%, stroke: 5pt + mprg-blue_1.lighten(50%) )
]
= 枝刈りとは
#v(0.3em) 
#grid(
    columns:(1fr,1fr),gutter: 1em,
    [
        //左側：非構造枝刈り
        #v(0.0em) 
        == ▪︎ 非構造枝刈り（Unstructured Pruning）
        - パラメータを要素単位で削除する手法
        #v(0.3em) 
        == メリット
        - 高い圧縮率を実現可能
        - 元の性能を維持しやすい
        #v(0.3em) 
        == デメリット
        - 専用のハードウェアでないと推論速度の向上が限定的
        #v(0.0em)
        #figure(
            image("image/Unstructured_Pruning.png",width: 80%)
        )  
    ],
    [
        //右側：構造化枝刈り
        #v(0.0em) 
        == ▪︎ 構造化枝刈り（Structured Pruning）
        - パラメータを構造単位で削除する方ほ
        #v(0.3em) 
        == メリット
        - 標準的なハードウェアで高速推論
        #v(0.3em) 
        == デメリット
        - 圧縮率に制限がある
        - 性能劣化が大きい可能性
        #v(0.0em)
        #figure(
            image("image/Structured_Pruning.png",width: 80%)
        )  
    ]
)

#v(0.3em) 
#align(center)[
    // 太い青い線
    #line(length: 100%, stroke: 5pt + mprg-blue_1.lighten(50%) )
]
= MPRGの枝刈り手法
#grid(
    columns:(1fr,1fr),gutter: 1em,
    [
        //左側：説明
        == ▪︎ 事前学習で得た知識を維持する非構造枝刈り
        - 事前学習で得た知識をどのように評価するのか#linebreak()
            特異値分解（SVD）を用いて得られる特異値の平均値を事前学習で得た知識として評価
        - SVDの定義: 任意の $m times n$ 行列 $bold(A)$ を以下のように分解
            #v(-.5em)
            #align(center)[
                #stack(
                dir: ltr,
                spacing: .5em,
                align(horizon)[$
                        bold(A) = bold(U) bold(Sigma) bold(V)^T = sum_(i=1)^r sigma_i bold(u)_i bold(v)_i^T =
                    $],
                [#v(-.4em)#figure(image("image/svd.svg", width: 50%))],
                )
            ]
            #v(-.75em)
            ここで，$bold(U)$ ($m times m$) と $bold(V)$ ($n times n$) は直交行列 $bold(Sigma)$ ($m times n$) が特異値 $sigma_1 >= sigma_2 >= dots.h >= sigma_r > 0$  を対角成分に持つ広義対角行列
        - *特異値の意義*: $sigma_i$ は対応する特異ベクトルが捉える「方向」の重要度やエネルギーの大きさを示す
    ],
    [
        //右側：図
        #figure(
        image("image/AFR.png",width: 90%)
        )
        
    ]
)

#grid(
    columns:(1fr,1fr),gutter: 1em,
    [
        //左側：説明
        == ▪︎ VLMにおけるモーダル間の知識蒸留による構造化枝刈り
        - Vision-Language Model（VLM）#linebreak()
            画像とテキストを入力とするAIモデル
        - 知識蒸留#linebreak()
            大規模で性能の良いモデルの知識を小規模なモデルへ転移させるアプローチ
        - 手法の概要#linebreak()
            画像と言語を統合させる役割を持つ表現を，知識蒸留により維持しつつ枝刈り箇所を探索
        
    ],
    [
        //右側：図
        #figure(
        image("image/UPKD.png",width: 90%)
        )
        
    ]
)
