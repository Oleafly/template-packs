#import "template.typ": *
#import "@preview/note-me:0.5.0": *


#show: apply_template.with(
  lab_num: 1,
  course: "COURSE",
  Department: "DEPARTMENT",
  professor: "PROFESSOR",
  assistant: "ASSISTANT",
  author: "AUTHOR",
  lab_title: "TITLE",
  date: "DD.MM.YYYY",
  classroom: "CLASSROOM",
)


// Titles
= #lorem(1)
== #lorem(2)
=== #lorem(2)
==== #lorem(2)
// Text
#lorem(30)

// Text bold
*#lorem(30)*

// Text italic
_#lorem(30)_

// Notes -> needs to be imported #import "@preview/note-me:<version>": *
#note[
  Note
]

#warning[
  Warning
]

// Code
`Lorem ipsum`


```cpp
int main() {
  printf("Hello, World!\n");
  return 0;
}
```

// Citations
#quote(attribution: [L. Ipsum 2024])[
  #lorem(50)
]

#pagebreak()

= #lorem(2)

#let my_table = table(
  columns: 2,
  align: (left, right),
  table.header(
    [Fruit], [Quantité],
  ),
  [Pommes], [10],
  [Bananes], [5],
  [Oranges], [20],
  [Poires], [5],
  [Cerises], [20],
)


*base typst table*
#my_table

*With `table_with_header()` function*
#table_with_header(my_table)

*Sum of column function*

Number of fruits : #sum_of_columns(table:my_table, col_index:2)
