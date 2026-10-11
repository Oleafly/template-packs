#import "@preview/codelst:2.0.2": sourcecode

= typst の環境構築

typsは環境構築がとても簡単です。

== リポジトリのクローン

まずはこのGitHubリポジトリをテンプレートとして、自分のリポジトリを作成してください。

#figure(
  image("./img/fork_as_template.png", width: 80%),
  caption: [テンプレートからリポジトリを作成する],
)

作成したリポジトリをローカルにクローンしてください。

#sourcecode[```bash
  $ git clone <your-repository-url>
  $ cd <your-repository-name>
  ```]

== cargo のインストール

　typstはRustで作られてるので、Rustのパッケージマネージャ「Cargo」を使ってインストールするのがおすすめです。

公式ドキュメント #footnote[https://doc.rust-lang.org/cargo/getting-started/installation.html] のインストール手順に従ってください。

基本的に次のコマンドを実行するだけです。

#sourcecode[```bash
  $ curl https://sh.rustup.rs -sSf | sh
  ```]

=== typst のインストール

Cargoがインストールされたら、次にtypstをインストールします。

#sourcecode[```bash
  $ cargo install typst
  ```]

== フォントをインストール

Google font から `.ttf` ファイルをダウンロードしてください。Windows の場合はシステムにフォントをインストール、Linux の場合はフォントファイルを `~/.fonts` 以下に配置してください。次のコマンドで使用可能なフォント一覧が見れます。

#sourcecode[```bash
  $ typst fonts
  ```]

== コンパイル

次のコマンド一発でコンパイルできます。

#sourcecode[```bash
  $ typst compile main.typ
  ```]

次のコマンドでホットリロードができます。

#sourcecode[```bash
  $ typst watch main.typ
  ```]

次のコマンドでpngエクスポートもできます。

#sourcecode[```bash
  $ typst compile main.typ png/main-{p}.png
  ```]
