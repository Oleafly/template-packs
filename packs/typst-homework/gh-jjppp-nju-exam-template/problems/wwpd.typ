#import "../template/common.typ": *

#let Error = [*`Error`*]
#let Function = [*`Function`*]
#let Iterator = [*`Iterator`*]
#let Forever = [*`Forever`*]

= Is it too difficult?

For each of the expressions in the table below, write the output displayed by the interactive Python interpreter when the expression is evaluated.
The output may have multiple lines.
Each expression has at least one line of output.

- If an error occurs, write #Error, but include all output displayed before the error.
- To display a function value, write #Function. To display an iterator value, write #Iterator.
- If an expression would take forever to evaluate, write #Forever.

The interactive interpreter displays the value of a successfully evaluated expression, unless it is `None`.

Assume that you have first started #python and executed the statements on the left.

#table(
  align: (left, left),
  columns: (auto, 1fr),
  stroke: 0pt,
  code_block(
    compact: true,
    ```python
    def learner(ScLst):
        def check(day):
            get_score = iter(ScLst)
            disappoint, oh_no = 0, False
            for i in range(day):
                score = next(get_score)
                if score < 40: disappoint += 1
                else: disappoint = 0
                if disappoint >= 3:
                    oh_no = True
            if oh_no: print('Oh no!')
            elif score >= 90: print('Play!')
            else: print('Work!')
        return check

    scoreLst1 = [47, 34, 21, 23, 91]
    scoreLst2 = [38, 14, 63, 35, 95]
    ```,
  ),
  table(
    columns: (auto, 1fr),
    table.header(
      [*Expression*],
      [*Interactive Output*],
    ),

    [```python pow(2, 11) - 24```], [`2024`],
    [```python print(4, 5) + 1```], [`4, 5` \ #Error],
    [```python print(print(6), 9)```], [#answer([`6`], 1) \ #answer([`None 9`], 1)],
  ),
)

#pagebreak()
