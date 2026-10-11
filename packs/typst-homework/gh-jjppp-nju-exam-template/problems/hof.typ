#import "../template/common.typ": *

= Higher-Order Functions

Implement `curry`. `curry` takes a binary function `f`, returns a new function `g` such that `g(a)(b) = f(a, b)`.

#code_block(```python
def curry(f):
    """ Returns a function g, such that g(a)(b) = f(a, b).
    >>> curried_add = curry(lambda a, b: a + b)
    >>> curried_add(3)(5)
    8
    """
    return #{{lambda a: lambda b: f(a, b)@3}}
```)

Implement `flip`. `flip` takes a *curried* binary function `g`, returns a new function `h` that swaps `g`'s arguments.

For example, if `g` is ```py(lambda a: lambda b: a + b)```, then `h` should be ```py(lambda b: lambda a: a + b)```.

#code_block(```python
def flip(g):
    """ Returns a function h, such that h(a)(b) = g(b)(a).
    >>> g = curry(lambda a, b: a - b)
    >>> g(2)(1), flip(g)(2)(1), flip(flip(g))(2)(1)
    (1, -1, 1)
    """
    return #{{lambda a: lambda b: g(b)(a)@3}}
```)

Implement `fold`.
`fold` takes a *curried* binary function `g` and a 3-tuple `t=(a,b,c)`. It transforms the 3-tuple to a value. For example, `fold(lambda x: lambda y: x + y, (1, 2, 3))` is `(1 + 2) + 3`.

#code_block(```python
def fold(g, t):
    """ Folds a 3-tuple to a value.
    >>> fold(lambda x: lambda y: x + y, (1, 2, 3)) # (1 + 2) + 3
    6
    >>> fold(lambda x: lambda y: x - y, (2, 3, 4)) # (2 - 3) - 4
    -5
    """
    (x, y, z) = t
    return #{{g(g(x)(y))(z)@3}}
```)

Finally, suppose you have implemented `flip` and `fold` correctly, what would python display? Fill in the blanks.

#code_block(```python
>>> flip(lambda x:x)(1)(lambda x: x + 1)
#{{2@1}}
>>> fold(flip(lambda x:x), (1, lambda x: x + 1, lambda x: x * 2))
#{{4@2}}
```)

#pagebreak()
