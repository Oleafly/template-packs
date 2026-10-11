#set document(title: "Typst Template", author: "Safwan")

#set text(font: "New Computer Modern")
#show raw: set text(font: "New Computer Modern")
#show math.equation: set text(font: "New Computer Modern")

#set page(
  paper: "a4",
  header: align(center)[12.02.2026],
  footer: context align(center)[#counter(page).display()],
)

#set par(justify: true)
#set heading(numbering: "1.")

#show title: set text(size: 16pt)
#show title: set align(center)

#title[Safwan's Typst Template]

#align(center)[
  #link("https://github.com/sfwnsft")[GitHub] |
  #link("https://linkedin.com/in/sfwnsft")[LinkedIn] |
  #link("mailto:safwansafatinfo@gmail.com")[E-mail]
]

= Level 1 Heading

== Level 2 Heading

+ Quia rerum adipisci culpa qui ratione expedita aut sunt aut vel.
+ Aut optio illum quia aut non.
  - Magni numquam pariatur enim quasi neque vel.
  - Cumque enim ducimus aut sed eaque ex placeat repudiandae enim.
    + Reprehenderit enim aut magnam nihil eius architecto dolores quis.

=== Level 3 Heading

+ A c program,
#align(center)[
```c 
#include<stdio.h>
int main () {
  printf("Typst\n");
  return 0;
}
```]

Write whatever you want.

#pagebreak()

#align(center)[
  #underline[Example of underlined text.]
]

#figure(
    image("Typst.png", width: 70%),
      caption:[This is _Typst_.],
    )

Equation: 

$ a^2 = b^2 + c^2 + "Variable" $
