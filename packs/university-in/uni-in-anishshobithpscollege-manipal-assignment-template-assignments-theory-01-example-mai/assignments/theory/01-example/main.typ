#import "/template/lib.typ": *
#import "@preview/typed-dsa:0.6.0": bst

#show: assignment.with(
  title: "Template Feature Showcase",
  number: "Assignment 01",
  kind: "Theory",
  keywords: ("typst", "template", "assignment"),
)

= Headings and text

#lorem(45)

== A subsection

#lorem(25)

=== A sub-subsection

#lorem(15)

- First bullet point
- Second bullet point
- Third bullet point

+ First numbered step
+ Second numbered step
+ Third numbered step

An inline fact: #kv("Array length", "1024"). A #link("https://typst.app")[hyperlink] sits inline too.

= Mathematics

Inline math like $a^2 + b^2 = c^2$ flows with the text. Display math stands on its own line:

$ c = (a + b)^2 = a^2 + 2 a b + b^2 $

$ sum_(i = 1)^n i = (n (n + 1)) / 2 $

== Multi-letter identifiers

Typst treats adjacent letters in math as a product of single-letter variables,
so it sets a name like $N P V$ in spaced italics. Wrap multi-letter names in
quotes — $"NPV"$ — to keep them upright, and reach for the built-in operators:

$ "Var"(X) = E[X^2] - mu^2, quad gcd(a, b) = 1, quad a equiv b thick (mod n) $

= Definitions, theorems, proofs

#definition(title: "Binary search tree")[
  A binary tree in which every node's key is greater than all keys in its left
  subtree and less than all keys in its right subtree.
]

#theorem[
  A binary tree of height $h$ holds at most $2^(h + 1) - 1$ nodes.
]

#lemma[
  An in-order traversal of a binary search tree visits its keys in ascending order.
]

#proof[
  In-order traversal visits the left subtree, then the node, then the right
  subtree. By the search-tree property every left key precedes the node's key,
  which precedes every right key, so the keys emerge in increasing order.
]

= Problems and solutions

#problem(title: "Cost of binary search")[
  Give the worst-case running time of binary search on a sorted array of $n$ elements.
]

#solution[
  Each step halves the remaining range, so the worst case is $O(log n)$ comparisons.
]

#problem[
  Write the recurrence that defines the Fibonacci sequence.
]

#solution[
  $F_0 = 0$, $F_1 = 1$, and $F_n = F_(n - 1) + F_(n - 2)$ for $n >= 2$.
]

= Code

Fenced blocks render in the monospace font:

```python
def binary_search(xs, target):
    lo, hi = 0, len(xs) - 1
    while lo <= hi:
        mid = (lo + hi) // 2
        if xs[mid] == target:
            return mid
        lo, hi = (mid + 1, hi) if xs[mid] < target else (lo, mid - 1)
    return -1
```

= Diagrams

The #link("https://typst.app/universe/package/typed-dsa/")[typed-dsa] package draws
data structures from declarative calls — handy for algorithm labs and theory notes.
It is vendored into the build image, so compiles stay offline. Show a structure's
`.diagram` field:

#figure(
  bst(50, 30, 70, 20, 40, 60, 80).diagram,
  caption: [A binary search tree built by inserting the keys in order.],
)

= Figures

Wrap a graphic in a figure to caption and number it. Captioned figures show up in the
List of Figures on the contents page.

#figure(
  image("/template/assets/logo.png", alt: "The institution logo", width: 3cm),
  caption: [The institution logo, standing in as a sample figure.],
)

= Tables

A captioned table joins the List of Tables:

#figure(
  table(
    columns: 3,
    table.header([Parameter], [Value], [Unit]),
    [Alpha], [12.5], [ms],
    [Beta], [8.0], [ms],
    [Gamma], [21.3], [ms],
  ),
  caption: [Sample measurements for the example table.],
)

A plain table without a caption stays out of the list:

#table(
  columns: (auto, 1fr, 1fr, 1fr),
  table.header([Column A], [Column B], [Column C], [Column D]),
  [Row 1], [Lorem], [Ipsum], [Dolor],
  [Row 2], [Sit], [Amet], [Consectetur],
  [Row 3], [Adipiscing], [Elit], [Sed],
)
