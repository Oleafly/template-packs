#import "../template/lib.typ": *

= Khối Code
<khoi-code>

Mẫu hỗ trợ code nội dòng và code block với syntax highlighting. Phông chữ
Fira Code được dùng cho tất cả các đoạn code.

== Code Nội Dòng

Sử dụng backtick để viết `code nội dòng`. Ví dụ: hàm `document()` nhận tham số
`doc-class: "thesis"`, phương thức `git cherry-pick`, hoặc lệnh shell `make thesis.pdf`.

== Code Block Đơn Ngôn Ngữ

#figure(
  ```typst
  // Cú pháp tối thiểu để sử dụng template
  #import "template/lib.typ": *
  #let data = yaml("config/metadata.yaml")

  #let acronyms = csv("content/acronyms.csv")

  #show: document.with(
    ..data,
    doc-class: "thesis",
    paper: "a4",
    font-size: 11pt,
    two-sided: false,
    output: "digital",
    lang: "vi",
    acronyms: acronyms,
  )

  #include "content/chapter01.typ"
  // ... thêm các chương khác

  #show: appendix-l10n.with("vi")
  #include "content/appendixA.typ"
  ```,
  caption: [Code Ví Dụ -- Typst],
)

== Code Python

Cách dùng:

```typst
#figure(
  raw(read("code/sample-code.py"), block: true, lang: "python"),
  caption: [Code Ví Dụ -- Python],
)
```

Kết quả:

#figure(
  raw(read("code/sample-code.py"), block: true, lang: "python"),
  caption: [Code Ví Dụ -- Python],
)

== Code SQL

```typst
#figure(
  raw(read("code/sample-code.sql"), block: true, lang: "sql"),
  caption: [Code Ví Dụ -- SQL],
)
```

Kết quả:

#figure(
  raw(read("code/sample-code.sql"), block: true, lang: "sql"),
  caption: [Code Ví Dụ -- SQL],
)

== Code Bash / Shell

```typst
#figure(
  raw(read("code/sample-code.sh"), block: true, lang: "bash"),
  caption: [Code Ví Dụ -- Bash],
)
```

Kết quả:

#figure(
  raw(read("code/sample-code.sh"), block: true, lang: "bash"),
  caption: [Code Ví Dụ -- Bash],
)

== Ghi Chú Về Code Block

#co-note[
  Kích thước chữ trong code block mặc định là `0.9em` so với văn bản thường,
  giúp tiết kiệm không gian khi đoạn code dài. Có thể ghi đè qua `thesis.typ`:
  `#show raw: set text(size: 0.8em)`
]
