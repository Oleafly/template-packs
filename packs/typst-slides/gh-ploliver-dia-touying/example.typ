#import "@preview/touying:0.6.1": *
#import "theme.typ": *
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *

#show: codly-init.with()

#show: dia-touying.with(
  aspect-ratio: "16-9",
  handout: false, // Set to true to generate a handout pdf, with no animations
  footer: [Simple slides],
  neutral-lightest: rgb("#f0f0f0"),
  authors: "Autor Autorez",
  date: datetime.today().display("[month repr:long] [day], [year]"),
  logo: text(fill: rgb("#239DAC"), size: 2.5em, weight: "bold", font: "libertinus serif")[logO],
  logo-at: bottom + right,
  logo-dx: -1.5cm,
  logo-dy: -1.6cm,
  logo-size: 10cm,
  config-common(preamble: {
    codly(languages: codly-languages)
  }),
)

#title-slide(
  title: [Title of the presentation.],
  supertitle: [#smallcaps("Optional Supertitle")],
  authors: [Autor Autorez],
  institution: [University of Somewhere, \ Faculty of Something],
)

#outline-slide(title: [Contents])

== Introduction

This template provides a clean, minimal design for academic presentations, looking to mimic the looks of the Diatypst presentation template using `touying`. We support... #pause

- Simple and elegant styling #pause
- Animated slides with `#pause` #pause and every tool in `touying`
- Automatic extension for long slides #pause
- Different styles for different slides #pause

In general, everything that is possible in `touying` is possible in this theme, such as integrations with `codly` for syntax highlighting, or `CeTZ`.

== Equations and Notation

Mathematical expressions render beautifully. The Fourier transform of $f$ is:
$ hat(f)(xi) = integral_(-infinity)^(infinity) f(x) e^(-2 pi i x xi) thin d x. $

The Euler identity is _the most beautiful equation_ because it involves the most important constants in mathematics:
$ e^(i pi) + 1 = 0. $

#pause

This other equation is, therefore, even more beautiful:
$ 0 e^(pi i) gamma log_(phi)(sqrt(2)) = 0. $

== Theorem Environment

#defbox([Definition], [
  A *Fourier transform* decomposes a function into its constituent frequencies, transforming it to the frequency domain.
])

#pause

#theoremproofbox(
  [Cauchy-Schwarz Inequality],
  [For all vectors $u$ and $v$: $ |⟨ u, v ⟩|^2 <= ⟨ u, u ⟩ dot ⟨ v, v ⟩ $],
  [_Proof._ Apply the discriminant condition to $||u + t v||^2 >= 0$. $square$],
)

== Syntax Highlighting

The theme integrates with Codly for syntax highlighting:

```python
def fibonacci(n: int) -> int:
    """Calculate the nth Fibonacci number."""
    if n <= 1:
        return n
    return fibonacci(n - 1) + fibonacci(n - 2)
```

#pause

Multiple languages are supported out of the box if you use the `codly-languages` packages. #pause

#manicule() Moreover, there are *special slides* and the symbol `#manicule()` (#manicule())

#focus-slide[
  _Focus slides_ draw attention to key points.
]

= Title slides (level 1 headings)

== Automatic extension for long slides

The template handles overflowing content by adding automatic page breaks and updating the slide title with Roman numerals (i), (ii), etc.

#theoremproofbox(
  [Van Cittert-Zernike Theorem],
  [The complex degree of coherence $mu_(12)(tau)$ of light from an incoherent source is equal to the normalized Fourier transform of its intensity distribution:
    $
      mu_(12)(0) = (integral.double_Sigma I(xi, eta) e^(-i k (p xi + q eta)) thin d xi thin d eta) / (integral.double_Sigma I(xi, eta) thin d xi thin d eta)
    $
    where $p = (x_1 - x_2) / R$ and $q = (y_1 - y_2) / R$.],
  [Proof is left as an exercise to the reader. $square$],
)

As we can see, we have carried over to another slide where (ii) has been appended to the title.

- The only problem with this automatic handling is that it interacts badly with `touying` animations.
  - If one wants animations in a multi-page slide, one should use `#split-slide`.

#split-slide(title: [Multi-page animations])[
  Say we have a long slide, for instance, we want to talk about a very interesting theorem.

  #theoremproofbox(
    [Wiener-Khinchin Theorem],
    [The power spectral density $S(f)$ of a wide-sense stationary random process is the Fourier transform of its autocorrelation function:
      $ S(f) = integral_(-infinity)^(infinity) R(tau) e^(-2 pi i f tau) thin d tau $],
    [_Proof._ Obvious. $square$],
  )

  #pagebreak()

  - By introducing a page break, we can animate the content of the slide. #pause
  - In the following discussion of the theorem, we will use `#pause` to animate the content. #pause
  - The slide title still automatically updates with Roman numerals (i), (ii), etc. #pause
  - We can mention that the Wiener-Khinchin Theorem was stated by Wiener #pause and Khinchin.

]

#focus-slide[
  Thank you for your attention!

  #text(size: 0.6em)[Questions?]
]
