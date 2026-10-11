#import "../theme/components.typ": er-diagram, note, tip, warning

= サンプル：データベース設計 <chap-sample-design>

この章では、データベース設計を題材に、本文、表、E-R図、数式、
コールアウトの表示を確認する。

== テーブル定義

@tab-sample-users に、`users`テーブルの定義を示す。

#figure(
  table(
    columns: (1fr, 1fr, 2fr),
    table.header([列名], [型], [説明]),
    [id], [BIGINT], [主キー],
    [name], [VARCHAR(100)], [ユーザー名],
    [created_at], [TIMESTAMP], [作成日時],
  ),
  caption: [`users`テーブルの定義],
) <tab-sample-users>

== E-R図

#er-diagram(
  read("../diagrams/users-orders.pintora"),
  width: 80%,
  caption: [`users`と`orders`の関係],
  alt: "usersテーブルとordersテーブルの関係を示すE-R図",
) <fig-sample-users-orders>

@fig-sample-users-orders は、1人のユーザーが複数の注文を持つ関係を示している。

== 関数従属性

関係 $R(A, B, C)$ において、属性$A$が属性$B$を一意に決定するとき、
関数従属性 $A -> B$ が成立する。

#note[
  `NULL`と空文字列は異なる値である。データベース設計では、
  両者をどのように扱うか明確にする必要がある。
]

#tip[
  テーブルを設計するときは、代表的な検索条件と更新処理も合わせて検討する。
]

#warning[
  本番環境でスキーマ変更を実行する前に、バックアップと復旧手順を確認すること。
]

