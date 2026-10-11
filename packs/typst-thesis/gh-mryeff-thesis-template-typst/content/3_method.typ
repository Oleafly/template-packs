#import "../prelude.typ": *


= Method <ch:method>
In this chapter, we're actually using some code!
As shown in @lst:inline-example, listings can be referenced directly in the text.

#listing(caption: [This is an example of inline listing])[
  ```python
  x = 1
  if x == 1:
    print("x is 1.")
  ```
] <lst:inline-example>

You can also include listings from a file directly:

#listing(caption: [This is an example of included listing])[
  #raw(read("../listings/example.py"), lang: "python")
]
