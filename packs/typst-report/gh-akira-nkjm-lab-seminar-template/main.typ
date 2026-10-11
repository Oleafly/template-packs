// ========================================
// 輪講資料サンプル
// ========================================

#import "template.typ": rinko, emphasis-box, warning-box, bordered-box

#show: rinko.with(
  title: "小型衛星の姿勢決定制御システムの設計と評価",
  author: "発表者名",
  // date: (2025, 10, 19), // 指定しない場合は今日の日付
)

= はじめに

本資料では,小型衛星における姿勢決定制御システム(ADCS: Attitude Determination and Control System)の設計手法と性能評価について説明する @wertz2011space .

== 研究背景

近年,CubeSatをはじめとする小型衛星の開発が盛んに行われている.小型衛星は限られたリソースの中で高精度な姿勢制御を実現する必要があり,効率的なADCSの設計が重要である.

== 目的

本研究の目的は以下の通りである:

+ 小型衛星向けADCSの設計手法の確立
+ センサーとアクチュエータの最適な組み合わせの検討
+ シミュレーションによる性能評価

= ADCSの構成要素

== センサー系

姿勢決定に用いられる主なセンサーは以下の通り:

- *太陽センサー*: 太陽方向を検出
- *地磁気センサー*: 地球磁場ベクトルを測定
- *ジャイロセンサー*: 角速度を測定
- *スタートラッカー*: 恒星の位置から高精度な姿勢を決定

#emphasis-box[
  *重要:* センサーの組み合わせにより,姿勢決定精度とコストのトレードオフが生じる.
]

== アクチュエータ系

姿勢制御に用いられる主なアクチュエータ:

- *リアクションホイール*: 角運動量交換による姿勢制御
- *磁気トルカ*: 地球磁場との相互作用によるトルク生成
- *推進器*: 直接的な力・トルクの生成

== 姿勢決定アルゴリズム

代表的な姿勢決定手法として,TRIAD法やカルマンフィルタがある.観測ベクトル$bold(v)_i$と参照ベクトル$bold(w)_i$から姿勢行列$bold(A)$を求める:

$
bold(v)_i = bold(A) bold(w)_i + bold(epsilon)_i
$

ここで,$bold(epsilon)_i$は観測誤差である.

= 設計手法

== システム設計プロセス

#bordered-box(title: "設計手順")[
  1. ミッション要求の定義
  2. センサー・アクチュエータの選定
  3. 制御アルゴリズムの設計
  4. シミュレーションによる検証
]

CubeSatプロジェクトでは,限られた予算と開発期間の中で効果的なADCSを実現する必要がある.先行研究 @hils で報告されているように,Hardware-in-the-Loop Simulation (HILS)を用いた事前検証が有効である.

== 制御手法の検討

姿勢制御に用いられる代表的な制御手法:

=== PD制御

- *メリット*: 実装が簡単,計算負荷が小さい
- *デメリット*: 外乱に対する応答性が低い

=== LQR制御

- *メリット*: 最適制御理論に基づく,性能保証
- *デメリット*: モデル化誤差に敏感

=== スライディングモード制御

- *メリット*: ロバスト性が高い,外乱に強い
- *デメリット*: チャタリングが発生する可能性

#warning-box[
  制御系設計では,センサーノイズやアクチュエータの飽和を考慮する必要がある.
]

= 図表の例

== 図の挿入方法

図を挿入する場合は,`#figure()`関数を使用します:

#bordered-box(title: "画像の配置例")[
```typst
#figure(
  image("images/example.png", width: 70%),
  caption: [図の説明文をここに書く]
)
```
]

実際の画像ファイルを使った例:

#figure(
  image("Figures/typst.svg", width: 30%),
  caption: [Typstのロゴ]
)

#emphasis-box[
*注意:* 画像ファイルは相対パスで指定します。`Figures/`ディレクトリに画像を配置してから参照してください。
]

画像がない場合は,プレースホルダーを使用できます:

#figure(
  rect(
    width: 60%,
    height: 150pt,
    stroke: 1pt + gray,
    fill: rgb("#f0f0f0"),
  )[
    #align(center + horizon)[
      #text(size: 14pt, fill: gray)[
        ここに画像が入ります\
        (例: 衛星システム構成図)
      ]
    ]
  ],
  caption: [衛星システム構成図（プレースホルダー）]
)

== 複数の画像を並べる

複数の画像を横に並べる場合:

#figure(
  grid(
    columns: 2,
    gutter: 1em,
    rect(width: 100%, height: 100pt, stroke: 1pt, fill: rgb("#f0f0f0"))[
      #align(center + horizon)[
        画像A
      ]
    ],
    rect(width: 100%, height: 100pt, stroke: 1pt, fill: rgb("#f0f0f0"))[
      #align(center + horizon)[
        画像B
      ]
    ],
  ),
  caption: [2つの画像を並べた例]
)

= シミュレーション例

== 姿勢制御シミュレーション

以下は,Pythonでの簡単な姿勢制御シミュレーションの実装例である:

```python
import numpy as np
from scipy.spatial.transform import Rotation

class AttitudeController:
    """簡易的なPD制御器"""

    def __init__(self, kp=0.1, kd=0.05):
        """
        Parameters:
        -----------
        kp : float
            比例ゲイン
        kd : float
            微分ゲイン
        """
        self.kp = kp
        self.kd = kd

    def compute_torque(self, q_current, q_target, omega):
        """
        制御トルクを計算

        Parameters:
        -----------
        q_current : ndarray
            現在のクォータニオン
        q_target : ndarray
            目標クォータニオン
        omega : ndarray
            角速度ベクトル

        Returns:
        --------
        torque : ndarray
            制御トルク
        """
        # 姿勢誤差の計算
        q_error = self.quaternion_error(q_current, q_target)

        # PD制御則
        torque = -self.kp * q_error[1:4] - self.kd * omega

        return torque

    @staticmethod
    def quaternion_error(q1, q2):
        """クォータニオン誤差を計算"""
        r1 = Rotation.from_quat(q1)
        r2 = Rotation.from_quat(q2)
        r_error = r2 * r1.inv()
        return r_error.as_quat()

# 使用例
controller = AttitudeController(kp=0.1, kd=0.05)
q_current = np.array([0, 0, 0, 1])  # 現在姿勢
q_target = np.array([0.1, 0, 0, 0.995])  # 目標姿勢
omega = np.array([0.01, 0.02, 0.01])  # 角速度

torque = controller.compute_torque(q_current, q_target, omega)
print(f"制御トルク: {torque}")
```

= シミュレーション結果

== 姿勢制御性能

ステップ応答シミュレーションの結果:

#figure(
  table(
    columns: 4,
    stroke: 0.5pt,
    [制御手法], [整定時間 (s)], [オーバーシュート (%)], [定常偏差 (deg)],
    [PD制御], [45.2], [8.5], [0.12],
    [LQR制御], [38.7], [3.2], [0.05],
    [SMC], [32.1], [12.8], [0.02],
  ),
  caption: [各制御手法の性能比較]
)

シミュレーション結果から,LQR制御が最もバランスの取れた性能を示すことが確認された.

== 考察

=== 制御性能について

制御性能は以下の要因に影響される:

+ センサーノイズの大きさ
+ アクチュエータの性能限界
+ 外乱トルクの大きさ

今後,実機試験による検証を行う予定である.

= まとめ

本研究では,小型衛星向けADCSの設計手法とシミュレーションによる性能評価を行った.主な成果は以下の通り:

- ADCSの構成要素とセンサー・アクチュエータの選定基準を整理
- 複数の制御手法の特徴と適用範囲を比較
- シミュレーションによる性能評価でLQR制御の有効性を確認

今後は実機を用いたHardware-in-the-Loop試験により,設計の妥当性を検証する予定である.

#pagebreak()

= 参考文献 <bibliography-section>

#bibliography("references.bib", title: none, style: "ieee")
