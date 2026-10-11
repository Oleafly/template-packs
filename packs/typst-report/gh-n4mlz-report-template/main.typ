#import "template.typ": project
#import "@preview/codly:1.3.0":

#show: project.with(
  subject: "科目名の例",
  title: "課題名の例",
  student-id: "12345678",
  department: "情報科学類",
  author: "筑波 太郎",
)

= 見出しの例 abc ひらがな漢字

本文の例です。This is a sample text. これはサンプルテキストです。

== 小見出しの例

*これは太字の例。以下はコードブロックの例です。*

```rust
pub fn main() {
    println!("Hello, world!");
}
```

=== 小小見出しの例

以下は数式の例です。

$ E = m c^2 $
