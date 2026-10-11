// An ordinary appendix chapter. Because main.typ applied `#show: appendix`
// before including this file, the chapter is lettered (A, B, C ...) and its
// figures, tables and equations carry that letter (E.1, E.2, ... in this one).

= Supplementary Information <app:si>

Everything that supports the argument but would interrupt it goes here:
additional measurements, derivations, instrument settings, parameter tables.

== A derivation moved out of the main text

$ integral_0^oo e^(-a x^2) dif x = 1 / 2 sqrt(pi / a) $ <eq:gauss>

@eq:gauss carries the letter of the appendix chapter it sits in. That
numbering is switched on by the single line `#show: appendix` in main.typ.

== A supplementary figure

#figure(
  image("../figures/example-plot.svg", width: 70%),
  caption: [Supplementary figures are numbered per appendix chapter and are
    listed in the List of Figures together with the others.],
) <fig:si-profiles>

== Declaration

Many faculties require a signed declaration (_Eidesstattliche Erklärung_) that
you wrote the thesis yourself. Ask your examination office for the current
wording — it is usually a fixed text that you must not paraphrase.

If you were given a PDF to include, drop it into `assets/` and embed its pages:

```typ
#set page(footer: none, header: none, margin: 0cm)

#for page in range(1, 2) {
  image("../assets/declaration.pdf", page: page, width: 100%, height: 100%)
}
```
