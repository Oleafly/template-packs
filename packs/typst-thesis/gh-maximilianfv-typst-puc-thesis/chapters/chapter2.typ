#import "../pucthesis.typ": flex-caption

== Figures and Tables <sec:figandtab>

In @fig:selfie1 we can see a selfie taken by a macaque.

#figure(
  image("../figures/selfie_monkey.jpg", width: 50%),
  caption: flex-caption([Monkey selfie], [This picture is not copyrighted]),
) <fig:selfie1>

Blandit incorrupte quaerendum in quo, nibh impedit id vis, vel no nullam semper audiam. Ei populo graeci consulatu mei, has ea stet modus phaedrum. Inani oblique ne has, duo et veritus detraxit. Tota ludus oratio ea mel, offendit persequeris ei vim. Eos dicat oratio partem ut, id cum ignota senserit intellegat. Sit inani ubique graecis ad, quando graecis liberavisse et cum, dicit option eruditi at duo. Homero salutatus suscipiantur eum id, tamquam voluptaria expetendis ad sed, nobis feugiat similique usu ex.

And now, @tab:apvalues shows some parameter for the Aliev-Panfilov model.

#figure(
  table(
    columns: 7,
    align: center,
    stroke: none,
    column-gutter: 1em,
    inset: (x: 6pt, y: 8.5pt), // tabular rows inherit 1.5 \baselinestretch

    table.hline(stroke: 0.08em),
    [$alpha$], [$c_1$], [$c_2$], [$mu_1$], [$mu_2$], [$b$], [$gamma$],
    table.hline(stroke: 0.05em),
    [0.05], [52], [8], [0.1], [0.3], [0.25], [0.002],
    table.hline(stroke: 0.08em),
  ),
  caption: flex-caption([Parameters Aliev-Panfilov],
    [Parameter values considered for the Aliev-Panfilov model of ionic
     current#text(fill: red)[.]]),
) <tab:apvalues>

There are 12 figures in order to show that the List of Figures works fine.

== Equations <sec:eq>

Finally, an equation
$ x^2 + 1 = 0 $ <eq:basiceq>

We can notice that $x = plus.minus i$ are the solutions of Equation @eq:basiceq.
