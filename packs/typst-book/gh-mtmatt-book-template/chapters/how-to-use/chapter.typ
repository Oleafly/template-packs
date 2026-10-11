#import "../../template.typ": *

== Chapter

如果要建立一個章節。可以在 `chapter` 底下開一個資料夾。結構長這樣：

#file-tree()[
  ```
  chapters
  ├── how-to-use
  │   ├── block.typ
  │   ├── ch.typ
  │   ├── chapter.typ
  │   └── code.typ
  ├── <chapter name>
  │   ├── ch.typ             // This is the entry point of a chapter.
  │   └── <section name>.typ // If you want to seperate chapter into sections.
  ├── acknowledgement.typ
  └── template.typ
  ```
]

接著，在 `main.typ` 裡面新增一行。

#code(title: [節錄 `main.typ`])[
  ```typ
  #title()

  #outline(depth: 2, title: auto)

  #include "chapters/how-to-use/ch.typ"
  // Add here vvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  #include "chapters/<chapter name>/ch.typ"
  // ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  #include "chapters/acknowledgement.typ"

  #bibliography("ref.bib", style: "ieee", full: true)
  ```
]

最後，在 `ch.ty` 最上面填上：

#code(title: [新的 `ch.typ`])[
  ```typ
  #import "../../template.typ": *
  #show: conf // Don't add this if you are in a section

  = <Chapter name>
  ```
]

就可以開始你的創作了。