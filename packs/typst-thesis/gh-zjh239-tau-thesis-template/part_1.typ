// part_1.typ

= Introduction

This template is supposed to help you finilizing your phd study. Compared to LaTex, it has much less dependences and is much easier to build, while remaining the same elegancy and quality. I hope you enjoy this period of your phd time, even more than I did.

Here are some personal advices about how to use this template:
1. The title information is included in the `main.typ` file.
2. Prematters have its own file `pre.typ`, remember to fill the supervising and copyright information in that file at some point after wrting the maintext.
3. `ref.bib` contains the references' entry information, it works the same way as in LaTex.
4. `uh-thesis.typ` is the class file. It defines font and the format of paper, titles, figures, _etc._ It is pretty short, minor modification can be done by yourself.
5. After everything, you can include the articles of yourself also in the `main.typ` file. Note that the page number of each file needs to be provided correctly.

= Purpose and structure


= A title suitable for the background of your study

For the main body part, you can split your main text by chapter or anything, put them into seperated files, just remember to include them in the main file, as `#include "file.typ"`.

== Angell plot

I will use this picture as example of figures and equations. It is about how different types of glasses are made.

The dependence of viscosity $eta$ on temperature exhibits an Arrhenius behavior, given as
    $ eta = A exp(E / (k_B T)), $
Angell introduced the Angell plot (@fig:angellplot) @Angell1988.
    $ m = lr((partial log (eta)) / (partial (T_g\/T)) |)_(T=T_g) $<eq:fragility>

#figure(
  image("figs/angell_replot.png", width: 70%),
  caption: [This is an example of how the figure would look like. Figure reprinted from Refs. @Angell1988.]
)<fig:angellplot>

Also, you can include more than one subfigures in one figure. They will be put into grids, which can be given multiple rows or columns.

#figure(
  grid(columns: 2,
    column-gutter: 1em,
    box[#image("figs/angell_replot.png", width: 100%)],
    box[#image("figs/angell_replot.png", width: 100%)]
), caption: [This is an example of ])<fig:tem>

Different from latex, the typst table is also an inherit type of figure. And also, you could put more than one sub elements into it.

#figure(
  caption: [Potential parameters of Coulomb-Buckingham potential for a$"-Al"_2"O"_3$ obtained using the parameter values and combination rules from Matsui.],
  grid(rows: 2, row-gutter: 1em,
  table(columns: 4,
    table.header[][A (eV)][$rho$ ($circle(A)$)][C (eV$circle(A)^6$)],
    [Al-Al],[31571310.74],[0.068],[14.05114560],
    [Al-O],[28477.25737],[0.172],[34.57833522],
    [O-O],[6462.75033],[0.276],[85.09350771]
  ),
  table(columns: 3,
    table.header[][Mass (u)][Charge (C)],
    [Al],[26.9815],[+1.4175],
    [O],[15.9994],[-0.9450]
  )))<tab:matsui_param>

