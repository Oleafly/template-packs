#import "../template/common.typ": *

= Environment Diagram

Fill in the environment diagram that results from executing the code on the right until the entire program is finished, an error occurs, or all frames are filled.

#hint[You may not need to use all of the spaces or frames.]

#block(
  columns(
    2,
    [
      #block([A complete answer will:
        - Add missing names and parents to all local frames.
        - Add missing values created or referenced.
        - Show the return value for each local frame.
      ])
      #colbreak()
      #code_block(```python
      def a(a, x):
          return c(a + x(a))
      b = 5
      c = lambda x: x * 3 + 1

      v = a(b, c)
      ```)
    ],
  ),
)

#pagebreak()
