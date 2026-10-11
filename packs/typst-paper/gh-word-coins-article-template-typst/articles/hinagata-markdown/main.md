# Markdownによる執筆

Typstの知識を必要とせずに、Markdownを用いて簡単に記事を書くための雛形を用意しています。
複雑なデザイン・組版を必要とする場合はTypst記法を使用してください。

リポジトリをGitで手元にCloneしたのちにフォルダ名と同じブランチを作成して移動します。

```
$ git switch -c articles/my-article-md
```

とした場合には`articles/hinagata-markdown`フォルダをコピーしたのちにフォルダ名を変更し、`articles/my-article-md`フォルダとします。
ブランチ名が異なる場合はフォルダ名も当然異なります。
このとき、ブランチ名は必ず`articles/*`という形式にしてください。

`articles/my-article-md`フォルダ内の`main.typ`ファイルに各種記事の情報を、`main.md`ファイル内に記事の本文を書きます。

`main.typ`ファイルを開き、以下の該当箇所のタイトルと著者名を適宜変更してください。

```
#show: article.with(
  title: "記事を執筆しよう",
  author: "情報 太郎"
)
```

`main.md`に記事の本文の内容を書きます。

さて、今度はリポジトリルートに`main.typ`ファイルの末尾に以下のような行を追加します。

```
#include "articles/my-article-md/main.typ"
```

このとき、`include` の引数には記事のあるフォルダまでのパスを与えてください。

記事の執筆が終わったらcommitをしてpushしましょう。

```
$ git add articles/my-article-md
$ git commit -m "add article"
$ git push
```

# サポート記法

## 小節

### 深さ3

## 段落

空白行を入れると段落が変わり、
単なる改行だとそのまま続けて表示される

段落2\
これは強制改行

## 箇条書き

- 順序無し箇条書き
  - 深くできる
- 普通の深さ

1. 順序有り箇条書き
1. 順序2

## 脚注

脚注[^footnote]を入れられる。

[^footnote]: 脚注

## 引用

引用できる。

> 被引用文

## 打ち消し線

発言を打ち消せる

~~打ち消される文~~

## コード

インラインにコードを入れることも`code`のようにできる。

```python
print("hello")
```

## 画像

![画像のテスト（jpeg）](./wordlogo.jpg)

このように画像を付けることができます。

画像の横幅や縦幅を指定したい場合は `img` タグを使って書く必要があります：

<img alt="画像のテスト" src="./wordlogo.jpg" width="50%"/>

## 数式

簡単な数式は$マークの間に書くことで実現できます。

$$x + y = \frac{y}{x}$$

行の中に入れることもできます。：$a + b = c$

## 改ページ

```
<pagebreak />
```

を挿入すればその時点で強制的に改ページすることができます。

## スペーシング

縦・横のスペースを pt 単位で空けることができます。
例えば20ptの横の空白を設けたい場合は<h value="20" />このようにします。

```
<h value="20" />
<v value="20" />
```

## raw-typst コマンド

コマンドを文中に書くことができます。

```
<!--raw-typst
// ... ここに Typst のコードを書く
-->
```

とすれば、Typst のコードを直接埋め込むことができます。

# その他情報

Markdownで執筆できる環境の整備をしたのは@Ryoga-exe[^ryoga]なので、何か聞きたい場合は連絡を。

[^ryoga]: https://github.com/Ryoga-exe
