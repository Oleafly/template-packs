// ======================================================================
// content.typ — ★ここだけ書き換えればポスターが完成します
// ======================================================================
#import "template/tml-poster.typ": highlight-box, reference-list
#import "template/colors.typ": tml-gray, tml-accent, tml-blue, tml-light

// ── メタ情報（必ず書き換えてください） ────────────────────────────────

#let poster-title    = [雑音・無雑音バイナリ分類器に基づく誤り訂正出力符号化の性能評価]
#let poster-subtitle = [Performance Evaluation of ECOC Based on Noisy and Noiseless Binary Classifiers]
#let poster-authors  = [雲居 玄道¹, 八木 秀樹², 小林 学³, 後藤 正幸³, 平澤 茂一³]
#let poster-affil    = [¹長岡技術科学大学　²電気通信大学　³早稲田大学]
#let poster-conf     = [Int. J. Neural Systems, Vol. 33, No. 5 (2023)]
#let poster-contact  = [kumoi\@vos.nagaokaut.ac.jp]
#let poster-funding  = [科研費 基盤研究(B) 18H01436]

// ── セクション内容（書き換えてください） ─────────────────────────────

#let sec-background = [
  多クラス分類問題（クラス数 $M$）に対して，
  *誤り訂正出力符号化*（ECOC）は $n$ 個のバイナリ分類器の出力を組み合わせる
  アンサンブル学習の枠組みである [1]．
  各クラス $c_j$ に符号語 $bold(m)_j in {-1,+1}^n$ を割り当てる．

  #figure(
    image("assets/ecoc-codeword.svg", width: 68%),
    caption: [ECOC の符号行列（$M=4$, $n=6$ の例）],
  )

  バイナリ分類器 $h_k(bold(x))$ の出力とクラス $c_j$ の符号語を比較し，
  ハミング距離が最小のクラスに分類する．

  #highlight-box[
    *問題意識:* バイナリ分類器が確率スコア $Pr{c_i | tilde(bold(x))}$ を出力する場合，
    確率スコアを直接利用した最適デコーディングの理論的性能評価が未解決であった．
  ]
]

#let sec-method = [
  *確率的デコーディングの定式化*

  バイナリ分類器の出力を確率スコア $Pr{c_i | tilde(bold(x))_i}$ でモデル化し，
  *評価関数*（対数尤度比）を定義する：

  $ r(c_i, c_k | tilde(bold(x))_i)
    = log frac(Pr{c_i | tilde(bold(x))_i},
               Pr{c_k | tilde(bold(x))_i}) $

  *分類則:*
  $ hat(c) = arg max_j sum_(k=1)^n r(c_j^k | tilde(bold(x))_k) $

  ガウス雑音 $eta ~ cal(N)(0, sigma^2 bold(I))$ のモデルを仮定：
  $tilde(bold(x)) = bold(x) + eta$

  #figure(
    image("assets/ecoc-r8.svg", width: 90%),
    caption: [評価関数 $r(c_i, c_k | tilde(bold(x))_i)$ の特性（$M=8$，各コード設計）],
  )

  $r$ は確率スコアの単調増加関数であり，
  $d_"min"$ が大きいほど誤り耐性が高い [2]．
]

#let sec-experiment = [
  *データセット*

  - *20 Newsgroups*：20 クラス文書分類，18,846 件
  - バイナリ分類器：Logistic Regression (LR)，DNN
  - 評価指標：AUC（Area Under Curve）

  *ECOC コード設計の比較（$M = 8$ クラス）*

  #table(
    columns: (2.1fr, 1fr, 1.5fr),
    inset: (x: 10pt, y: 8pt),
    stroke: (paint: tml-blue, thickness: 0.8pt),
    fill: (col, row) =>
      if row == 0 { tml-blue }
      else if calc.odd(row) { tml-light }
      else { white },
    table.header(
      text(fill: white, weight: "bold", size: 23pt)[符号設計],
      text(fill: white, weight: "bold", size: 23pt)[符号長 $n$],
      text(fill: white, weight: "bold", size: 23pt)[最小距離 $d_"min"$],
    ),
    text(size: 23pt)[1-vs-Rest],    text(size: 23pt)[8],   text(size: 23pt)[2],
    text(size: 23pt)[2-vs-Rest],    text(size: 23pt)[56],  text(size: 23pt)[12],
    text(size: 23pt)[3-vs-Rest],    text(size: 23pt)[168], text(size: 23pt)[30],
    text(size: 23pt)[Exhaustive],   text(size: 23pt)[128], text(size: 23pt)[64],
  )

  #v(0.3cm)
  実験パラメータ：$sigma^2 = 5.80$（最大雑音強度）を採用．
  全コード設計で10回クロスバリデーションを実施した．
]

#let sec-results = [
  *20 Newsgroups での実験結果（Logistic Regression）*

  #figure(
    image("assets/ecoc-20news-lr.svg", width: 98%),
    caption: [AUC の比較（LR，20 クラス，95% 信頼区間）],
  )

  - *Exhaustive*（$d_"min"=64$）が全条件で最高 AUC を達成
  - $d_"min"$ の増加とともに AUC が単調改善
  - 提案の確率的デコーディングはハミング復号より AUC を*最大 +2.3 pt* 向上

  #highlight-box[
    *主要結果:* $d_"min"$ を大きくするほど高精度——理論解析と実験が一致．
  ]
]

#let sec-conclusion = [
  #grid(
    columns: (2fr, 1fr, 9.5cm),
    column-gutter: 1.5cm,
    align: (left + top, left + top, center + top),
    [
      *まとめ*

      - ECOC の確率的デコーディングを理論的に定式化し，
        ガウス雑音下での誤り確率の上界を導出した．
      - 最小ハミング距離 $d_"min"$ が大きいコード設計ほど
        誤り確率が低下することを理論・実験の両面から確認した．
      - 20 Newsgroups（$M=20$）での実験により
        Exhaustive コードの優位性を実証した．

      *今後の課題*

      - 非ガウス雑音モデルへの拡張（ラプラス分布，混合ガウス）
      - 最適コード設計の自動探索アルゴリズム
      - 大規模多クラス問題（$M > 100$）への適用
    ],
    [
      #figure(
        image("assets/ecoc-p8.svg", height: 13cm, fit: "contain"),
        caption: [AUC vs. 雑音強度 $sigma^2$（$M=8$, LR）],
      )
    ],
    [
      #v(0.3cm)
      #image("assets/sample-figure.png", width: 8cm)
      #v(0.3cm)
      #text(size: 21pt, fill: tml-gray)[研究室サイト]
      #v(0.1cm)
      #text(size: 19pt, fill: tml-gray)[https://tml.nagaokaut.ac.jp]
      #v(0.4cm)
      #text(size: 18pt, fill: tml-gray)[Paper DOI:]
      #v(0.05cm)
      #text(size: 17pt, fill: tml-gray)[10.1142/S0129065723500156]
    ],
  )
]

// ── 参考文献 ────────────────────────────────────────────────────────────
// reference-list[ + 文献1  + 文献2 ... ] で番号 [1],[2]... が自動採番されます。
// 本文中の引用は [1] のように手書きし、リストの並び順に合わせてください。

#let sec-references = reference-list[
  + T. G. Dietterich and G. Bakiri, ``Solving multiclass learning problems
    via error-correcting output codes,'' _J. Artif. Intell. Res._, vol. 2,
    pp. 263–286, 1995.
  + 雲居 玄道, 八木 秀樹, 小林 学, 後藤 正幸, 平澤 茂一, ``雑音・無雑音
    バイナリ分類器に基づく誤り訂正出力符号化の性能評価,''
    _Int. J. Neural Syst._, vol. 33, no. 5, 2023.
]
