//---------------------------------------------------------------------
= Method <ch:method>
//---------------------------------------------------------------------

In this chapter, after the @ch:data chapter we're actually using some code!

#figure(
  ```python
  x = 1
  if x == 1:
    # indented four spaces
    print("x is 1.")
  ```,
  caption: [This is an example of inline listing],
) <lst:code0>

You can also include listings from a file directly:

#figure(
  raw(read("../code/example.py"), lang: "python", block: true),
  caption: [This is an example of included listing],
) <lst:code1>
