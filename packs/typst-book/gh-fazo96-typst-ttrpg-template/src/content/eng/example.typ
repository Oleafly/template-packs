#import "../../utils.typ": table_d66_double, info-box, table_d66, rpg_table

= Introduction

Hello! This is an example of the Typst TTRPG Template.

You can add some formatting like bullet point lists:

+ Item 1
+ Item 2
+ Item 3

#info-box[
  This is an info box.
]

= Tables

Here you can see how the various table functions look like.

== RPG Table

This is the base table function, where you control the number of columns and the content of the table.

#rpg_table(
  columns: (auto, 1fr),
  [D6],
  [Second Column],
  [1],
  [Option 1],
  [2],
  [Option 2],
  [3],
  [Option 3],
  [4],
  [Option 4],
  [5],
  [Option 5],
  [6],
  [Option 6],
)

Even though there is space on this page, the next section begins on a new page due to the pagebreak function being used.

#pagebreak()

== Table D66

This is the d66 table function, where you control the title and the content of the table. There must be exactly 36 elements in the list. The elements are displayed one per row, making it ideal for oracle tables that have long text such as quest starters.

#table_d66(
  "Title",
  (
  [Element 1],
  [Element 2],
  [Element 3],
  [Element 4],
  [Element 5],
  [Element 6],
  [Element 7],
  [Element 8],
  [Element 9],
  [Element 10],
  [Element 11],
  [Element 12],
  [Element 13],
  [Element 14],
  [Element 15],
  [Element 16],
  [Element 17],
  [Element 18],
  [Element 19],
  [Element 20],
  [Element 21],
  [Element 22],
  [Element 23],
  [Element 24],
  [Element 25],
  [Element 26],
  [Element 27],
  [Element 28],
  [Element 29],
  [Element 30],
  [Element 31],
  [Element 32],
  [Element 33],
  [Element 34],
  [Element 35],
  [Element 36],
)
)

#pagebreak()

== Table D66 Double

This is like the d66 table function, but with two side-by-side columns, which can save space if the options are short.

#table_d66_double(
  "Title",
  (
  [Element 1],
  [Element 2],
  [Element 3],
  [Element 4],
  [Element 5],
  [Element 6],
  [Element 7],
  [Element 8],
  [Element 9],
  [Element 10],
  [Element 11],
  [Element 12],
  [Element 13],
  [Element 14],
  [Element 15],
  [Element 16],
  [Element 17],
  [Element 18],
  [Element 19],
  [Element 20],
  [Element 21],
  [Element 22],
  [Element 23],
  [Element 24],
  [Element 25],
  [Element 26],
  [Element 27],
  [Element 28],
  [Element 29],
  [Element 30],
  [Element 31],
  [Element 32],
  [Element 33],
  [Element 34],
  [Element 35],
  [Element 36],
)
)