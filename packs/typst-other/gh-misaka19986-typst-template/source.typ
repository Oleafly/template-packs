/* set page */
#set page(
  header: align(right, text(9pt,
  weight: "thin",
  )[A template created by ririka]),

  width: 21cm,
  height: 29.7cm,
  numbering: "-1-"
)

/* set heading */
#set heading(numbering: "1.")

/* set body font */
#set text(14pt, font: ("Noto Serif CJK SC", "JetBrains Mono"))

/* set retraction */
#set par(justify: true, first-line-indent: 2em)

#show heading: it =>  {
  it
  par()[#text(size:0.5em)[#h(0.0em)]]
}

/* set figure */
#show figure.caption: set text(12pt, style: "italic")

/* title */
#align(center, text(
  32pt,
  weight: "bold",
)[A useful and important research for the title])

#align(center, text(
  16pt,
  weight: "thin",
)[ririka, unknown university])

#line(length: 100%)


/* text body */
= Expression
  This is a math expression.

#align(center, $F_n = F_(n - 1) + F_(n - 2)$)

= Table

This is a table.

#let col = 10

#let nums = range(1, col + 1)

#let fib(n) = {
  if n <= 1 {return n}

  let a = 0
  let b = 1

  for i in range(2, n + 1){
    let temp = a + b
    a = b
    b = temp
  }

  return b
}

#align(center, figure(table(
  columns: col,
  ..nums.map(n => $F_#n$),
  ..nums.map(n => str(fib(n)))
),caption: "Fib"))

= Grid

This is a grid with rect

#set rect(
  inset: 8pt,
  fill: rgb("e4e5ea"),
  width: auto
)

#align(center, grid(
  columns: 3,
  rows: (auto, 60pt),
  gutter: 3pt,
  rect[this is a grid],
  rect[1/3 remains],
  rect[2/3 remains],
  rect(height: 100%)[fixed height]
))

= Code block
*Style 1*

#align(center, text(
  
  [```C
    /* A C program sample */
    #include <stdio.h>
    int main(){
      int a = 1;
      int b = 2;
      printf("res:%d\n", a+b);
      return 0;
    }
  ```]
))\

Use the block directly, but the statement which right follows the block will lose it's retraction.

So use a '\\' to fix that.

*Style 2*

#align(center, table(
  columns: 1,
)[
    ```c
    /* A C program sample */
    #include <stdio.h>
    int main(){
      int a = 1;
      int b = 2;
      printf("res:%d\n", a+b);
      return 0;
    }
    ```])\

Use the 'table' to add a frame for the code.

*Style 3*

#show raw: it => block(
  fill: rgb("#1d2433"),
  inset: 10pt,
  radius: 5pt,
  text(fill: rgb("#a2aabc"), it),
)

#align(center, text(
)[```c
    /* A C program sample */
    #include <stdio.h>
    int main(){
      int a = 1;
      int b = 2;
      printf("res:%d\n", a+b);
      return 0;
    }
    ```])\

Use 'show' to change the style.