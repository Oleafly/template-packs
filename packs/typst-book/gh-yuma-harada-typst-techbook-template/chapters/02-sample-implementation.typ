#import "../theme/components.typ": code-block

= サンプル：実装例 <chap-sample-implementation>

この章では、@fig-sample-users-orders のデータモデルを題材に、
複数言語のコードブロックを確認する。

== SQL

#code-block(
  read("../examples/sql/user-orders.sql"),
  lang: "sql",
  caption: [ユーザーごとの注文数を取得するSQL],
) <code-sample-user-orders-sql>

== TypeScript

#code-block(
  read("../examples/typescript/find-user.ts"),
  lang: "typescript",
  caption: [リポジトリからユーザーを取得するTypeScriptコード],
) <code-sample-find-user-typescript>

== Python

#code-block(
  read("../examples/python/user.py"),
  lang: "python",
  caption: [ユーザーを表すPythonのデータクラス],
) <code-sample-user-python>

== Prisma

#code-block(
  read("../examples/prisma/schema.prisma"),
  lang: "prisma",
  caption: [`users`と`orders`を表すPrismaスキーマ],
) <code-sample-prisma-schema>

== SQLAlchemy

#code-block(
  read("../examples/sqlalchemy/models.py"),
  lang: "python",
  caption: [`users`と`orders`を表すSQLAlchemyモデル],
) <code-sample-sqlalchemy-models>
