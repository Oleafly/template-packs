#import "template.typ": *
#import "@preview/physica:0.9.5": *

#show: amznotes-typst.with(
  title: "Test Document Title",
  subtitle: "Project 2",
  author: ("Silvermilight"),
)

= Overview

== Sample

=== amzbox

Inspired by amznotes, we provide many types of colored boxes:

- `dfnbox` -- definition box
- `thmbox` -- theorem box
- `exbox` -- example box
- `enbox` -- exercise box
- `codebox` -- code snippet box
- `notebox` -- note box

Among them, `notebox` is unindexed, and the others are indexed.

To create an indexed box, you can use the following syntax:

```typst
#boxname(name: "box-name", refname: "box-refname")[
  #boxcontent
]
```


#dfnbox(name: "amznotes")[
  #dfntxt[amznotes-typst] is a typst template which imitates
  the style of latex template #dfntxt[amznotes]\.
]

#thmbox(name: "First Theorem")[
  This Typst template is cool.

  #proof[
    Here is what some math looks like:
    
    $
      forall (n in NN) [sum_(i=1)^n i = (n(n+1)) / 2]
    $

    Some more math:

    $
      floor(x) &= max {n in ZZ mid(:) x <= z} \
      ceil(x)  &= min {n in ZZ mid(:) x >= z}
    $

    The math is good.
  ]
]

#codebox(name: "Test Code", refname: "test-code")[
  Here is some Python code:

  ```python
  def test_func():
      print("Hello world!")
  ```
]

Indexed boxes can be referenced using the `nameref` and `boxref` functions. For example:

```typst
  As seen in #nameref(refname: "thm:first-theorem") 
    (Theorem #boxref(refname: "thm:first-theorem")), 
    this template is pretty cool.
  ```

#exbox(name: "Reference Example")[
  As seen in #nameref(refname: "thm:first-theorem") (Theorem #boxref(refname: "thm:first-theorem")), this template is pretty cool.
]


amzbox also supports nested boxes:

#notebox[
  #exbox(name: "Cool Example")[
    This is my example!
  ]
  #nameref(refname: "ex:cool-example") (example #boxref(refname: "ex:cool-example")) is pretty cool.
]


==== Subsubsection

== Section 2

Test Document

#link("https://www.google.com")[Google]

= Really really long chapter title that has to use more than one line because it is so long

#lorem(200)

#notebox[
  #lorem(100)
]

#lorem(200)
