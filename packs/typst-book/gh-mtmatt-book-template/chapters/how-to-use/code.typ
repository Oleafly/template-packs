#import "../../template.typ": *

== Code

你可以使用 `#code` 來將程式碼放進一個區塊中。

#code(title: "一個 Rust 範例")[
  ```rs
  fn main() {
    for i in 0..10 {
      println!("{i}")
    }
  }
  ```
]

或是使用 `#code-ref`，他有三個參數可以用，分別是 `caption`，`lang`，以及 `path`。

- Caption 是上面的標題
- Lang 是語言，用來做 syntax highlighting
- Path 是該檔案的路徑

#code-ref(caption: [使用路徑的範例(`path: "chapters/how-to-use/ch.typ"`)], lang: "typst", path: "chapters/how-to-use/ch.typ")