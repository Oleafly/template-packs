#import "ucl-thesis.typ": *

= DEMO
This section is meant to detail the features in this thesis template and necessary steps you should take. The thesis is inspired by #link("https://www.overleaf.com/latex/templates/ucl-phd-thesis-template/tcdxmjdxbfhh.pdf")["Pawel's LaTeX template"]. Like their template, this PhD thesis is geared towards PhDs in STEM fields.

+ This section is inside `main.typ` as `#include "demo.typ"`. This line should be deleted before submission. You can optionally delete this file afterwards or turn it into something useful.
+ After reading this document, please take some time to read through the comments littered around in `main.typ`, the project root file, and `ucl-thesis.typ` which contains the style code that makes up this thesis template. There are also a few convenience commands to mimic their LaTeX equivalent.
+ Please ensure to insert an image of your signature in the right section.
+ If you are editing locally, I recommend Visual Studio Code with the #link("https://github.com/Myriad-Dreamin/tinymist")[Tinymist] extension (or any editor with support for it) as well as #link("https://github.com/typstyle-rs/typstyle")[typstyle] linter to format your Typst code. Even if you have a potato device, Typst compiles _really_ quickly even for hundred+ page documents with many packages, which your thesis likely will be.
+ This template uses #link("https://typst.app/universe/package/pergamon/")[pergamon] to handle bibliographies, with an example bib file in `main.bib` - see also `main.typ` for how it's imported. The bib format is *biblatex*. It supports most of the biblatex keys and supports multiple bibliography management.
  - Since pergamon overrides citation management, it also overrides Typst's in-built `#cite` function. It now requires a string to the biblatex key. The following reference is called as `#cite("alvarezQuantumMechanicsClassical1989")` #cite("alvarezQuantumMechanicsClassical1989").
+ To include more `.typ` files, see files in various directories and also `main.typ` on how to use them.
+ The total wordcount is automatically handled by the #link("https://typst.app/universe/package/wordometer/")[wordometer] package. As per the RDF: "The maximum word lengths include footnotes, tables and figures but exclude bibliography, appendices and supporting data" and the template has excluded the appendices and bibliography.

== Features
This sub-section aims to demonstrate the default packages I have included.


Your thesis is a living document. It will contain your research over the years. It's easy to make a note on your phone, a different software, pen and paper etc but it's also hard to find that same information much later down the line, so why not note in the document!
#margin-note(side: left)[Cite this sentence]
This is achieved by the #link("https://typst.app/universe/package/drafting")[drafting] package.

As a thesis targeted towards STEM, there are a lot of STEM-related packages. As a computational physicist myself, I write a lot of math - the #link("https://typst.app/universe/package/physica")[physica] package makes writing derivatives and other stuff a lot more convenient:

$
  hat(H) = & -frac(hbar^2, 2m_e)sum_i grad^2_i - sum_(i,I) frac(Z_I e^2, abs(bold(r)_i - bold(R)_I)) + frac(1, 2) sum_(i != j) frac(e^2, abs(bold(r)_i - bold(r)_j)) \ & - sum_i frac(hbar^2, 2M_I)grad^2_I + frac(1, 2) sum_(I != J) frac(Z_I Z_J e^2, abs(bold(R)_I - bold(R)_J))
$ <eqn:fullschrodinger>
which is written:
#codly(languages: codly-languages)
```typst
$
  hat(H) = & -frac(hbar^2, 2m_e)sum_i grad^2_i - sum_(i,I) frac(Z_I e^2, abs(bold(r)_i - bold(R)_I)) + frac(1, 2) sum_(i != j) frac(e^2, abs(bold(r)_i - bold(r)_j)) \ & - sum_i frac(hbar^2, 2M_I)grad^2_I + frac(1, 2) sum_(I != J) frac(Z_I Z_J e^2, abs(bold(R)_I - bold(R)_J))
$ <eqn:fullschrodinger>

```
The `grad` command is part of `physica`, and this code block was beautifully displayed by #link("https://typst.app/universe/package/codly")[codly]!


#link("https://typst.app/universe/package/quill")[quill] provides the ability to draw quantum circuits!


#figure(
  quantum-circuit(
    lstick($|psi〉$),
    ctrl(1),
    gate($H$),
    1,
    ctrl(2),
    meter(),
    [\ ],
    lstick($|beta_00〉$, n: 2),
    targ(),
    1,
    ctrl(1),
    1,
    meter(),
    [\ ],
    3,
    gate($X$),
    gate($Z$),
    midstick($|psi〉$),
    setwire(0),
  ),
  caption: [Quantum teleportation circuit from the #link("github.com/Mc-Zen/quill/releases/download/v0.7.2/quill-guide.pdf")[Quill user manual].],
)
If you scroll up to the list of figures, you'll see this has automatically been included! Any figure considered an image (e.g. most things. Tables go in a separate section) will be automatically added! The same for tables, and the same for algorithms

#figure(
  table(
    columns: (auto, auto, auto, auto),
    inset: 8pt,
    align: horizon,
    table.header([*Quantity*], [*Atomic unit*], [*SI unit*], [*Conversion*]),
    [Energy], [Hartree, Ha], [Electronvolt, eV], [$1 "Ha" = 27.2114079527 "eV"$],
    [Distance], [Bohr, $a_0$], [#sym.angstrom], [$1 a_0 = 0.529177249 #sym.angstrom$],
  ),
  caption: [Unit conversion for common quantities in atomic physics.],
) <tab:units>

#algorithm-figure(
  "Steepest Descent",
  vstroke: .5pt + luma(200),
  {
    import algorithmic: *
    Procedure(
      "Steepest Descent",
      ($bold(R)_0$, $epsilon$),
      {
        Comment[Requires: $f$ differentiable, initial point $bold(R)_0 in bb(R)^n$, tolerance $epsilon > 0$]
        Assign[$k$][$0$]
        LineBreak
        While(
          $norm(nabla f(x_k)) > epsilon$,
          Assign[$x_(k+1)$][$x_k - alpha_k nabla f(x_k)$],
          Assign[$k$][$k + 1$],
        )
        Return[$x_k$]
      },
    )
  },
  caption: [Steepest descent with generic step-size rule.],
) <alg-gd>

And you can of course refer to @alg-gd or @tab:units.


Finally, here's the UCL logo as an example figure
#figure(
  image("title/logo.png", width: 80%),
  caption: [The UCL logo from the title page at 80% width.],
) <logo>
#load-bib()
