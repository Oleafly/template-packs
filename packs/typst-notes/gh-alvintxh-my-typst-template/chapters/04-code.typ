#import "../lib/lib.typ": *

= 代码

代码块由 `codly` 负责：自动行号、右上角语言标签、语法高亮。
直接用 Markdown 那种三反引号围起来就行。

== 基本用法

````typ
```python
import numpy as np

def boltzmann(E, T, k=1.380649e-23):
    return np.exp(-E / (k * T))
```
````

出来是：

```python
import numpy as np

def boltzmann(E, T, k=1.380649e-23):
    """玻尔兹曼因子"""
    return np.exp(-E / (k * T))
```

换个语言只要改反引号后面的标记：

```cpp
#include <cmath>

double kinetic(double m, double v) {
    return 0.5 * m * v * v;
}
```

```julia
using DifferentialEquations

f(u, p, t) = -p * u          # 指数衰减
prob = ODEProblem(f, 1.0, (0.0, 5.0), 0.3)
sol = solve(prob)
```

== 高亮某几行

在代码块前面调一次 `#codly(highlights: ...)`，只对紧跟着的那个块生效。

#codly(highlights: (
  (line: 4, start: 5, end: none, fill: palette.danger, tag: [边界条件在这], label: none),
))
```python
def solve(n=100):
    psi = np.zeros(n)
    psi[0] = 0.0
    psi[-1] = 0.0          # 无穷深势阱：两端为零
    return psi
```

`line` 是行号，`start`/`end` 是列范围（`end: none` 表示到行尾），
`tag` 是右边那句注释。

== 给代码块加题注和引用

代码块套进 `#figure()` 就有编号了，`kind: raw` 让它归到「代码」那一类：

#figure(
  ```python
  def leapfrog(x, v, a, dt, steps):
      for _ in range(steps):
          v += 0.5 * a(x) * dt
          x += v * dt
          v += 0.5 * a(x) * dt
      return x, v
  ```,
  caption: [蛙跳积分器],
  kind: raw,
) <code:leapfrog>

引用写 `@code:leapfrog`，显示成 @code:leapfrog。

== 行内代码

行内写 `` `numpy.fft` `` 得到 `numpy.fft`，适合提函数名、文件名、命令。
带语言的行内代码写 `` `#let x = 1`typ `` → `#let x = 1`。

== 伪代码

算法用 `lovelace` 写，不绑定具体语言：

#figure(
  kind: raw,
  caption: [Verlet 积分],
  pseudocode-list(booktabs: true, title: smallcaps[Velocity Verlet])[
    + *输入*: 初始位置 $x_0$、速度 $v_0$、步长 $Delta t$、步数 $N$
    + $x <- x_0$, $v <- v_0$
    + *for* $i = 1$ *to* $N$ *do*
      + $v <- v + 1/2 a(x) Delta t$
      + $x <- x + v Delta t$
      + $v <- v + 1/2 a(x) Delta t$
    + *end for*
    + *返回* $(x, v)$
  ],
)

== 关掉花哨样式

某些块想要朴素的样子（比如贴一段终端输出），前面加 `#codly-disable()`，
之后再 `#codly-enable()` 恢复：

#codly-disable()
```
$ typst watch main.typ
watching main.typ
writing to main.pdf
```
#codly-enable()

#info[
  代码块的配色、行号样式、边框在 `lib/template.typ` 里 `codly(...)` 那一段，
  支持的语言列表来自 `codly-languages` 包。
]
