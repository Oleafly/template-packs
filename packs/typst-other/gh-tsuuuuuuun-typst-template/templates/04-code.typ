#import "../lib.typ": code

= コード

== 文中のコード

変数 `x` に値を代入し、`println!` マクロで出力します。
コマンドは `cargo build --release` のように書きます。

== コードブロック

```rust
fn main() {
    // 日本語のコメントを含む行
    let message = "こんにちは、世界";
    println!("{}", message);
}
```

== 別の言語

```python
def greet(name: str) -> str:
    """挨拶を返す"""
    return f"こんにちは、{name}さん"
```

```sh
$ typst compile main.typ
$ typst watch main.typ
```

== 和文の桁揃え

```
# あいうえお
# abcdefghij
```

== 長い行

```rust
let very_long_variable_name = some_function_with_a_long_name(first_argument, second_argument, third_argument);
```

== ファイル名を添える

どのファイルの話かを示したいときは `code` で包みます。
見出し帯が言語名からファイル名に変わります。

#code(file: "src/main.rs")[
```rust
fn main() {
    println!("hello");
}
```
]

#pagebreak()
