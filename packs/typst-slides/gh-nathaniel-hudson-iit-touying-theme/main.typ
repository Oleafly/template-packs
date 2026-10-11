#import "iit-theme.typ": *

#show: iit-theme.with(
  aspect-ratio: "16-9", 
  show-section-in-slide-titles: false,
  config-info(
    title: [Introduction to Object-Oriented Programming],
    subtitle: [CS XXX: Elementary Programming],
    author: [Bob Smith],
    date: datetime(day: 1, month: 1, year: 2026),
    institution: [Illinois Institute of Technology],
    contact: [nhudson5\@illinoistech.edu]
  ),
)

#title-slide()

#focus-slide([Objects])

== Color Demos

- This is an example of #hl-red([red]) text.
- This is an example of #hl-green([green]) text.
- This is an example of #hl-blue([blue]) text.
- This is an example of *bold* text

= Logistic Regression

== First Slide

A _slide_ with a title and an *important* information.

+ Hello world
+ Goodbye!

```python
class Person:
  def __init__(self, name: str, age: int):
    self.name = name 
    self.age = age
```

#pause

=== Federated Averaging

$ omega^(t+1) = sum_(k=1)^(K) n_k/n omega_(k)^(t+1) $

Hello, this is a function: $f(x)$.

== Theorem Slide 

#columns(2)[

  === Verbose

  #theorem(title: "Euclid's Theorem", supplement: "Theorem")[
    There are infinitely many prime numbers.
  ] <thm:euclid-verbose>

  We define @thm:euclid-verbose using the explicit form: 
  ```typst
  #theorem(title: "...", supplement: "...")[body]
  ```

  #colbreak()

  === Simple

  #theorem[Simple][
    There are infinitely many prime numbers.
  ]<thm:euclid-simple>

  We define @thm:euclid-simple using the explicit form: 
  ```typst
  #theorem[<name>][body]
  ```

]

== Other Theorem Types

#columns(3)[
  #set text(size: 14pt)

  #theorem[Name][#lorem(15)]

  #definition[Name][#lorem(15)]

  #corollary[Name][#lorem(15)]

  #property[Name][#lorem(15)]

  #example[Name][#lorem(15)]

  #lemma[Name][#lorem(15)]

  #assumption[Name][#lorem(15)]

  #conjecture[Name][#lorem(15)]

  #proof[Proof][#lorem(15) This concludes the proof.]
]

== Important Notes
#note-block[
  Remember that mathematical proofs should be both rigorous and clear.
  Clarity without rigor is insufficient, and rigor without clarity is ineffective.
]

#caution-block[
  When dealing with infinite series, always verify convergence before discussing other properties.
]

#quote-block[
  Mathematics is the queen of sciences, and number theory is the queen of mathematics.
  — Gauss
]

== Bullet Slide 

+ Hello
+ Goodbye!

== Edge Purpose and Definition

#lorem(30)

// - #lorem(17ß)
- #lorem(30)
- #lorem(15)

=== #lorem(12)

#slide(
  title: none,
  [
    An *title-free slide* can be created by the following:
    ```typst
    #slide(title: none, ...)
    ```
  ]
)
