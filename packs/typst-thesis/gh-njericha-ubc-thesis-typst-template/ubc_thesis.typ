// UBC Thesis Document v1.0.0
//
// Please contribute improvements at https://github.com/njericha/ubc-thesis-typst-template
//
// Copyright 2026 Nicholas Joseph Emile Richardson
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "ubc_thesis_style.typ": *

// Page Setup //

#let font = "Libertinus Serif"
#let font-size = 12pt
#let paper-size = "us-letter"
#let table-of-contents-depth = 2

// Set the font for text within math mode
// italics/regular styles are handled automatically
#let mathtext =  mathtext.with(font: font)
#let number-unlabelled-equations = false //use true to number every block (display) equation

// Cover Page Info //

#let thesis-title = "My Thesis Title"
#let name = "Firstname Lastname"
#let degree = "Doctor of Philosophy"
#let past-degrees = [
  BMath, The University of Somewhere, 2020 \
  MMath, The University of Elsewhere, 2022
]
#let program = "My Program"
#let month = "April"
#let year = 2026

#let cover-page = [
  #strong(upper(thesis-title))

  by

  #upper(name)

  #past-degrees

  A DISSERTATION SUBMITTED IN PARTIAL FULFILLMENT OF \
  THE REQUIREMENTS FOR THE DEGREE OF

  #upper(degree)

  in

  THE FACULTY OF GRADUATE AND POSTDOCTORAL STUDIES

  #v(-1.5em) (#program)

  THE UNIVERSITY OF BRITISH COLUMBIA

  #v(-1.5em) (Vancouver)

  #month #year

  © #name, #year
]

// Committee Page //

#let examining-committee = (
  ("Supervisor", "My Supervisor's Name, Professor, Department of My Program, UBC"),
  ("Supervisory Committee Member", "Committee Member 1, Professor, Department of My Program, UBC"),
  ("Additional Examiner", "Committee Member 2, Assistant Professor, Department of Another Program, UBC"),
)

#let additional-members = (
  ("Supervisory Committee Member", "Committee Member 3, Professor, Department of My Program, UBC"),
  ("Supervisory Committee Member", "Committee Member 4, Associate Professor, Department of Another Program, UBC"),
)

#let abstract = [
  Your thesis abstract here. 350 words max.
]

#let lay-summary = [
  Your lay summary intended for the general public here. 150 words max.
]

#let preface = [
  This dissertation is original, unpublished, and independent work by Firstname Lastname with the following exceptions...

  ...

  (If applicable!) No generative artificial intelligence tools were used in the research process, development, or writing of the dissertation.

  (OR) The generative artificial intelligence tool \_\_ was used to \_\_...

  See https://www.grad.ubc.ca/current-students/dissertation-thesispreparation/resources-thesis-preparation-checking
]

// Custom operators here (just before List of Symbols)
#let argmin = math.op([arg #math.thin min #math.thin], limits: true)

// List of Symbols (Optional)
#let list-of-symbols = [
  This is an example list of mathematical symbols used. Examples assume $A in bb(R)^(I times J times K)$ is a third-order tensor, but notation and Julia code extends to any number of dimensions.

  #figure([#table(
    columns: (30%, 36%, 33%),
    align: (left,auto,auto,auto,),
    table.header([Name], [Notation], [Julia Syntax],),
    table.hline(),
    [First $N$ Integers], [$[N] = { 1 \, dots.h \, N }$], [`1:N`],
    [Array Element], [$A [i \, j \, k]$], [`A[i,j,k]`],
    [$(j \, k)$ 1-Fibre], [$A [: \, j \, k]$], [`A[:,j,k]`],
    [$i$th 1-Mode Slice], [$A [i \, : \, :]$], [`A[i,:,:]`],
    [Transpose], [$A^tack.b$], [`A'`],
    [Set of 1-Mode Slices], [${A [i \, : \, :] mid(|) i in [I]}$], [`eachslice(A; dims=1)`],
  )
  ],
  kind: list, // this is NOT a table because it is part of a front matter list. It should not be numbered
  supplement: [],
  )
]

// Abbreviations (Optional)
// See the abbr package https://typst.app/universe/package/abbr
#let abbreviations = (
  ("UBC", "The University of British Columbia"),
  ("IMF", "intrinsic mode function"),
  ("EMD", "empirical mode decomposition"),
  ("STFT", "short-time Fourier transform"),
  ("SVD", "singular value decomposition"),
) // note unused abbreviations will not appear in the document

// Acknowledgements (Optional)
#let acknowledgements = [
  I am grateful for the funding and grant support from The University of British Columbia's Four Year Doctoral Fellowship and The Natural Sciences and Engineering Research Council of Canada's Canada Graduate Research Scholarship---Doctoral program...

  I would like to thank my peer graduate students and postdoctorates...

  Finally, I would like to thank my supervisory committee members and my supervisor...
]

// Dedication (Optional)
#let dedication = [To someone special.]

// Begin the document
#show: thesis.with(
  font: font,
  paper-size: paper-size,
  font-size: font-size,
  table-of-contents-depth: table-of-contents-depth,
  number-unlabelled-equations: number-unlabelled-equations,
  thesis-title: thesis-title,
  name: name,
  degree: degree,
  program: program,
  cover-page: cover-page,
  examining-committee: examining-committee,
  additional-members: additional-members,
  abstract: abstract,
  lay-summary: lay-summary,
  preface: preface,
  list-of-symbols: list-of-symbols,
  abbreviations: abbreviations,
  acknowledgements: acknowledgements,
  dedication: dedication,
)

#[
#show: big-section-numbers.with() // Only want this applied to the main document

= Introduction
<sec-introduction>

We can have _italicised_ and *bolded* text by using \_underscores\_ and \*asterisks\*.

To type code, we can use \`single backticks\`. We can also specify the language with triple backticks like this \`\`\````typst typst #lorem(50)```\`\`\`. We'll use this lorem function for some filler text now.

#lorem(50)

This is a non-numbered list using hyphens ```typst -```.

- point 1
- next point
- something else

Here is a numbered list using plus signs ```typst +```.

+ point 1
+ next point
+ something else

Here's a block quote.

#quote(block: true)[
  "I am inside a block quote. You usually only use these for longer quotes that span longer than a single line, or to emphasize a particular point."
]

This text continues without the indentation from the quote.

This is a sentence with a footnote.#footnote[This text is in the footnote. They can include equations like this, $epsilon > 0$, among other things.]

Here is an inline equation $a^2 + b^2 = c^2$. And here is a display equation with some text using the function ```typst mathtext("the text")```

$ min_x f(x) quad mathtext("s.t.") quad x gt.eq 0. $ <eq-display-equation>

This ensures text is properly italicised when used in theorem environment like in @def-optimization-problem.

#definition("An Optimization Problem")[A general nonnegative optimization problem is written
$ min_x f(x) quad mathtext("s.t.") quad x gt.eq 0. $
] <def-optimization-problem>

Here's a link to a website. This one links to the GitHub repository for #link("https://github.com/MPF-Optimization-Laboratory/BlockTensorFactorization.jl")[BlockTensorFactorization.jl].

This is an abbreviation for @UBC. Every time it is used after the first, it will be short by default: @UBC. You can click it to see the list of abbreviations!

Now we reference multiple sections at once with ```typst #Cref[@ref1 @ref2 @ref]```: see #Cref[@sec-introduction @sec-background @sec-conclusion]. This function also works with tables and figures: #Cref[@fig-imf @fig-grid]. To reference multiple equations, use ```typst #eq_ref[@eq1 @eq2]```: (#eq_ref[@eq-display-equation @eq-simplex-projection]). Use ```typst #thm_ref[@thm1 @thm2 @thm3]``` to reference multiple theorems, lemmas, definitions, etc. as long as they are the same type: #thm_ref[@def-lipschitz @def-infinity-norm @def-optimization-problem]. We need custom functions to properly include the section number in equation and theorem references.

To end a line early, use a backslash ```typst \``` like this. \  Now this is on the next line. Note there is extra space at the end of the line, but we did not start a new paragraph.

== Contributions

In this thesis, we provide new ways to ...

Now we will force a page break with ```typst #pagebreak()```.

#pagebreak()

This text starts on the next page. Notice the running headers above only appear on pages after a new level 1 section.

== Roadmap

The high-level flow of this thesis starts with...

#lorem(300)

= Literature Review
<sec-background>
Beginning with our notation, we review the necessary background ...

== Some Definitions and Theorems
<sec-notation>

We state the usual definition for a convex function in @def-convex-function, and a standard result in @prp-differentiable-convex-function immediately afterward.

#definition([Convex Function])[
  A function $f : cal(D) subset.eq bb(R)^I arrow.r bb(R)$ is convex when
  $ f (lambda x + (1 - lambda) y) lt.eq lambda f (x) + (1 - lambda) f (y) \, $
  for all $0 lt.eq lambda lt.eq 1$ and $x \, y in cal(D)$.
] <def-convex-function>

#proposition([Differentiable Convex Functions @rockafellar_ConvexAnalysis_1970[Thm. 25.1]])[
  Let $f$ be differentiable. $ f mathtext("is convex") quad arrow.double.l.r.long quad f (y) gt.eq f (x) + ⟨nabla f (x) \, y - x⟩ quad forall x \, y in cal(D). $
] <prp-differentiable-convex-function>

We cite Rockafellar right in the name of @prp-differentiable-convex-function and reference the specific theorem it comes from.

Here are two more definitions shown in #thm_ref[@def-lipschitz @def-infinity-norm].

#definition("Lipschitz Function")[
  A function $f : cal(D) subset.eq bb(R)^(N) arrow.r bb(R)$ is #box[$L_f$-Lipschitz] when $ abs(f (a) - f (b)) lt.eq L_f norm(a - b)_2 , quad forall a , b in cal(D). $
  We call the smallest such $L_f$ _the_ Lipschitz constant of $f$.
] <def-lipschitz>

#definition("Functional Infinity Norm")[The infinity norm $norm(f)_oo$ of a function $f : cal(D) subset.eq bb(R)^(N) arrow.r bb(R)$ is the largest magnitude producible by $f$'s output, $ norm(f)_oo = sup_(A in cal(D)) abs(f (A)). $
We call a function _bounded_ if its infinity norm is a finite number.
] <def-infinity-norm>

Here is a lemma that is immediately followed by its proof.

#lemma("Product of Lipschitz Functions")[Let $f \, g : cal(D) subset.eq bb(R)^(N) arrow.r bb(R)$ be bounded and $L_f$- and $L_g$-Lipschitz functions respectively.

Then, the product function $(f g) (A) = f (A) g (A)$ is $L_(f g)$-Lipschitz with constant $ L_(f g) = L_f norm(g)_oo + L_g norm(f)_oo . $
] <lem-product-of-lipschitz-functions>

#proof([of @lem-product-of-lipschitz-functions])[Let $f \, g : cal(D) subset.eq bb(R)^(N) arrow.r bb(R)^(M)$, and $a , b in cal(D)$. Then $ abs(f (A) g (A) - f (B) g (B)) & = abs(f (A) g (A) - f (A) g (B) + f (A) g (B) - f (B) g (B))\
 & lt.eq abs(f (A)) abs(g (A) - g (B)) + abs(g (B)) abs(f (A) - f (B))\
 & lt.eq abs(f (A)) L_g norm(A - B)_F + abs(g (B)) L_f norm(A - B)_F\
 & lt.eq norm(f)_oo L_g norm(A - B)_F + norm(g)_oo L_f norm(A - B)_F\
 & = (norm(f)_oo L_g + norm(g)_oo L_f) norm(A - B)_F. $ #v(-2.25em) #qedhere
]

@thm-lipschitz-interpolation has its proof in the appendix under @sec-lipschitz-interpolation-proof. This theorem uses ```typst #box``` to force #box["$a , b in bb(R)^N$"] to be on the same line. We also add a label to @eq-lipschitz-interpolation-bound so we can reference it.

#theorem("Lipschitz Function Interpolation")[
  Let $f : bb(R)^N arrow.r bb(R)$ be $L_f$-Lipschitz. For all #box($a , b in bb(R)^N$) and $lambda_1 , lambda_2 gt.eq 0$, $lambda_1 + lambda_2 = 1$, the error between $f$ evaluated at a convex combination of $a$ and $b$ and the linear interpolation of $f (a)$ and $f (b)$ satisfies $ abs(f (lambda_1 a + lambda_2 b) - (lambda_1 f (a) + lambda_2 f (b))) lt.eq 2 L_f lambda_1 lambda_2 norm(a - b)_2 . $ <eq-lipschitz-interpolation-bound>
] <thm-lipschitz-interpolation>
#proof([of @thm-lipschitz-interpolation])[
  See @sec-lipschitz-interpolation-proof.
]

We also have corollaries, assumptions, and remarks. We can even reference @cor-obvious and @asm-world.

#corollary("Something Obvious")[This follows from @thm-lipschitz-interpolation] <cor-obvious>

#assumption[We live in a world.]<asm-world>

#remark[Just pointing this out.]

== Citations
<sec-seperating-signals>

We can string a bunch of citations that will be nicely collapsed automatically by our citation style. @Sircombe2000@Sundell2017@saylor_CharacterizingSedimentSources_2019@graham_tracing_2025. Some of them can include references to specific sections @saylor_CharacterizingSedimentSources_2019[Sec. 1]@graham_tracing_2025.

== More Literature Review with a Figure

One family of methods separating signals into @IMF:pll which are amplitude-frequency modulated sinusoids $s (t) = a (t) sin (phi.alt (t))$ (or their complex version, $a (t) e^(i phi.alt (t))$) with instantaneous amplitude $a (t) > 0$ and frequency $phi.alt' (t) > 0$. @fig-imf shows a sketch of three @IMF:pls. One tool in this category is @EMD:l @huang_empirical_1998.

#figure([#image("figures/imf_sketch.svg", width: 50.0%)
],
caption: figure.caption(position: bottom, flex-caption(
[Example sketch of a signal with three @IMF sources. This is a longer caption that only appears in the main body of the text.],
[Example sketch. Short caption only showing in the list of figures.]
)),
kind: image,
)
<fig-imf>

@EMD suffers from "mode mixing" and sensitivity to noise among other issues, so improvements have been proposed to combat these issues @wu_ensemble_2009@torres_complete_2011.

= Display items

== Tables

Here, @tbl-convergence-criteria shows the convergence criteria implemented in v0.4.0 of the tensor factorization package BlockTensorFactorization.jl @Richardson_BlockTensorFactorization_jl.

#figure([#table(
  columns: (auto, auto),
  align: (right,left,),
  table.header([Criteria], [Definition],),
  table.hline(),
  [`ObjectiveValue`], [$f (X^t)$],
  [`ObjectiveRatio`], [$f (X^(t - 1)) \/ f (X^t)$],
  [`IterateNormDiff`], [$lr(bar.v.double X^t - X^(t - 1) bar.v.double)_F$],
  [`IterateRelativeDiff`], [$lr(bar.v.double X^t - X^(t - 1) bar.v.double)_F \/ lr(bar.v.double X^(t - 1) bar.v.double)_F$],
  [`RelativeError`], [$lr(bar.v.double X^t - Y bar.v.double)_F \/ lr(bar.v.double Y bar.v.double)_F$],
  [`GradientNorm`], [$lr(bar.v.double nabla f (X^t) bar.v.double)_F$],
  [`GradientNNCone`], [$d (- nabla f (X^t) \, N_(gt.eq 0) (X^t))$],
)
], caption: figure.caption(
position: top,
flex-caption([Convergence criteria implemented in BlockTensorFactorization.jl.],
[Convergence criteria implemented in BlockTensorFactorization.jl.]
)),
kind: table,
supplement: "Table",
)
<tbl-convergence-criteria>

== A table with custom formatting

@tbl-blockupdate-randomization shows the behaviour of randomizing updates in BlockTensorFactorization.jl. We use the following typst code to colour `true` green and `false` red to make it easier to read.

```typst
#show raw: it => {
  if it.text == "true" {
    set text(fill: color.rgb("#3a8027"))
    it
  }
  else if it.text == "false" {
    set text(fill: color.rgb("#a42929"))
    it
  }
  else {
    it
  }
}
```


#[
#show raw: it => {
  if it.text == "true" {
    set text(fill: color.rgb("#3a8027"))
    it
  }
  else if it.text == "false" {
    set text(fill: color.rgb("#a42929"))
    it
  }
  else {
    it
  }
}

#figure([#table(
  columns: (12%, 13%, 13%, auto),
  align: (auto,auto,auto,auto,),
  table.header([Group], [Random], [Recursive], [Description],),
  table.hline(),
  [`false`], [`false`], [`false`], [In the order given],
  [`false`], [`false`], [`true`], [Randomize how existing blocks are ordered (recursively)],
  [`false`], [`true`], [`false`], [Randomize updates, but keep existing blocks in order],
  [`false`], [`true`], [`true`], [Fully random],
  [`true`], [`false`], [`false`], [In the order given],
  [`true`], [`false`], [`true`], [Updates for each factor are in a random order],
  [`true`], [`true`], [`false`], [Random order of factors, preserve updates in each factor],
  [`true`], [`true`], [`true`], [Random, except updates for each factor are done together],
)
], caption: figure.caption(
position: top,
flex-caption([Full description of randomizing the order of updates within a `BlockedUpdate`. The headers Group, Random, and Recursive stand for the keyword arguments `group_by_factor`, `random_order`, and `recursive_random_order`.],
[Full description of randomizing the order of updates within a BlockedUpdate.]
)),
kind: table
)
<tbl-blockupdate-randomization>
]

== Code blocks

To constrain a vector $v in bb(R)^J$ to the simplex

$ Delta_J = {v in bb(R)_(+)^J mid(bar.v) sum_(j = 1)^J v [j] = 1} \, $

we can apply a Euclidean projection

$ v arrow.l argmin_(u in Delta_J) lr(bar.v.double u - v bar.v.double)_2^2. $

The Euclidean simplex projection can be done with the following implementation of Chen and Ye's algorithm @chen_projection_2011 in BlockTensorFactorization.jl @Richardson_BlockTensorFactorization_jl. The essence of the algorithm is to efficiently compute the special $t in bb(R)$ so that

$ v arrow.l max (0 \, v - t bb(1)) in Delta_J . $ <eq-simplex-projection>

```julia
function projsplx!(v)
    n = length(v)
    y_sorted = sort(v[:]) # Vectorize and sort all entries
    total = y_sorted[n] # Initialize total
    i = n - 1
    t = zero(eltype(v)) # Ensure t has scope outside the while loop

    while true
        t = (total - 1) / (n-i)
        y_i = y_sorted[i]
        if t >= y_i
            break
        else
            total += y_i
            i -= 1
        end
        if i >= 1
            continue
        else # i == 0
            t = (total - 1) / n
            break
        end
    end

    @. v = ReLU(v - t)
    return v
end
```

== Grid of figures

@fig-grid shows an example grid of figures.

#figure(grid(columns: 2, gutter: 1fr, [#box(image("figures/singlescale-starting-iterates.svg", width: 49.0%))
#box(image("figures/singlescale-ending-iterates.svg", width: 49.0%))
#box(image("figures/multiscale-starting-iterates.svg", width: 49.0%))
#box(image("figures/multiscale-ending-iterates.svg", width: 49.0%))
]), caption: figure.caption(
position: bottom,
flex-caption([Here is an example grid of figures. These are taken from Richardson, Marusenko, and Friedlander @richardson_multiple_2025@Richardson_multiscale_paper_code.
],
[Example grid of figures.]
)),
kind: image)
<fig-grid>

== Algorithms

// code for a custom equation label
#let problem_tag(it) = [$P_s$]//#h(-0.5em)
#let problem_tag_brackets(it) = [(#problem_tag(it))]
#show ref: it => {
    if it.target == <eq-scale-s-discretized-problem> {
        link(it.target)[#problem_tag(it)]
    } else {it}
}

@alg-multiscale is taken from @richardson_multiple_2025. It references @eq-scale-s-discretized-problem which is the following equation with a custom label,

#math.equation(block: true, numbering: problem_tag_brackets)[$ min_(x_s) {tilde(cal(L))_s (x_s) mid(|) x_s in tilde(cal(C))_s}. $] #label("eq-scale-s-discretized-problem")

#import "@preview/algorithmic:1.0.7"

#import algorithmic: style-algorithm, algorithm-figure
#show: style-algorithm

#algorithm-figure(
  "The Multiscale Method. Line 6 specifies Greedy or Lazy versions.",
  vstroke: .5pt + luma(200),
  inset: .3em,
  {import algorithmic: *
      {
        Line[Randomly initialize $x_s^0$ at the coarsest scale $s=S$.]
        Line[Perform $K_s$ iterations of projected gradient descent on $x_s^0$ to approximately solve @eq-scale-s-discretized-problem at scale $s=S$ and obtain $x_s^(K_s)$.]
        For([scales $s = S-1, S-2, dots, 1$],
            Line[Interpolate $x_(s+1)^(K_(s+1))$ to obtain $underline(x)_(s+1)^(K_(s+1))$.],
            Line[Initialize the next finest scale $x_(s)^0=underline(x)_(s+1)^(K_(s+1))$ using the previous scale's interpolated solution.],
            Line[Perform $K_s$ iterations of projected gradient descent on $x_s^0$ (Greedy) or $x_((s))^0$ (Lazy) to approximately solve @eq-scale-s-discretized-problem at scale $s$ and obtain $x_s^(K_s)$.]
        )
        Return[Approximate solution $x_1^(K_1)$ for @eq-scale-s-discretized-problem at $s=1$ ]
      }
  }
) #label("alg-multiscale")

= Conclusion
<sec-conclusion>
This thesis explores... `some text`

== Discussion
<discussion-1>
Some things to say...

== Next Steps
<next-steps>

] // End of main document body

// Bibliography //

#set bibliography(style: "ieee-ubc-thesis.csl")
#[// set smaller paragraph spacing only for bibliography
#set par(spacing: 0.55em, leading: 0.55em)
#bibliography("example_references.bib")
]

// Appendices //

#show: appendices

= This is the First Appendix
<app-first-appendix>

#subsection_alt([This plain text is in the PDF headings for screen readers and the table of contents], [This text is rich and can include references to @sec-introduction and code `AbstractMatrix`], "sec-first-appendix-subsection")

We may want to use the above function to reference proofs of particular theorems like in @sec-lipschitz-interpolation-proof.

#subsection_alt([Proof of Lipschitz Interpolation], [Proof of @thm-lipschitz-interpolation (Lipschitz Interpolation)], "sec-lipschitz-interpolation-proof")

Let $f : bb(R)^N arrow.r bb(R)$ be $L_f$-Lipschitz, $a , b in bb(R)^N$ be vectors, and $lambda = lambda_1$ so that $1 - lambda = lambda_2$ for $ lambda in [0 \, 1]$. Our goal is to bound $ abs(((1 - lambda) f (a) + lambda f (b)) - f ((1 - lambda) a + lambda b)) $ according to @eq-lipschitz-interpolation-bound.

We separate $f ((1 - lambda) a + lambda b) = (1 - lambda) f ((1 - lambda) a + lambda b) + lambda f ((1 - lambda) a + lambda b)$ and use triangle inequality to get

$ & abs(((1 - lambda) f (a) + lambda f (b)) - f ((1 - lambda) a + lambda b))\
 & lt.eq abs((1 - lambda) f (a) - (1 - lambda) f ((1 - lambda) a + lambda b)) + abs(lambda f (b) - lambda f ((1 - lambda) a + lambda b))\
 & lt.eq (1 - lambda) L_f norm(a - ((1 - lambda) a + lambda b))_2 + lambda L_f norm(b - ((1 - lambda) a + lambda b))_2\
 & = 2 lambda (1 - lambda) L_f norm(a - b)_2 . $

This completes the proof.

#subsection_alt([Short Title],[A Very Loooooooooooooooooooooooooooong Title], "sec-long-title")

#lorem(50)

== Some Standard Subsection

#lorem(300)

= Something Else I Want to Include

#lorem(800)
