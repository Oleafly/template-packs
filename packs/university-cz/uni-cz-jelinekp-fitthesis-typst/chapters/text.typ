#import "../ctufit-thesis.typ": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

= Introduction
<chap:intro>

#chapter-abstract[
  Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut purus elit, ve-
  stibulum ut, placerat ac, adipiscing vitae, felis. Curabitur dictum gravida
  mauris. Nam arcu libero, nonummy eget, consectetuer id, vulputate a, ma-
  gna. Donec vehicula augue eu neque. Pellentesque habitant morbi tristique
  senectus et netus et malesuada fames ac turpis egestas. Mauris ut leo. Cras
  viverra metus rhoncus sem. Nulla et lectus vestibulum urna fringilla ultri-
  ces. Phasellus eu tellus sit amet tortor gravida placerat. Integer sapien est,
  iaculis in, pretium quis, viverra ac, nunc. Praesent eget sem vel leo ultrices
  bibendum. Aenean faucibus. Morbi dolor nulla, malesuada eu, pulvinar at,
  mollis ac, nulla. Curabitur auctor semper nulla. Donec varius orci eget ri-
  sus. Duis nibh mi, congue eu, accumsan eleifend, sagittis quis, diam. Duis
  eget orci sit amet orci dignissim rutrum.
]

Donec odio tempus molestie, porttitor ut, iaculis quis, sem. Suspendisse
sagittis ultrices augue. Donec ipsum massa, ullamcorper in, auctor et,
scelerisque sed, est. In sem justo, commodo ut, suscipit at, pharetra vitae,
orci. Pellentesque pretium lectus id turpis @Crochemore2002.

Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sagittis
hendrerit ante. Class aptent taciti sociosqu ad litora torquent per conubia
nostra, per inceptos hymenaeos.

== Ut enim ad minim veniam

Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sagittis
hendrerit ante. Class aptent taciti sociosqu ad litora torquent per conubia
nostra, per inceptos hymenaeos. Cras pede libero, dapibus nec, pretium sit amet,
tempor quis. Sed vel lectus.

#figure(
  align(center, scale(reflow: true, x: 80%, y: 80%, diagram(
    spacing: (1.0em, 1em),
    node-stroke: 0.4pt,
    node-shape: circle,
    node-inset: 3pt,
    node((0, 0), $n$),
    node((-6, 1), $n/2$), node((6, 1), $n/2$),
    edge((0, 0), (-6, 1), stroke: 0.4pt), edge((0, 0), (6, 1), stroke: 0.4pt),
    node((0, 1), $+$, stroke: none, shape: rect, fill: white),
    node((-9, 2), $n/2^2$), node((-3, 2), $n/2^2$),
    node(( 3, 2), $n/2^2$), node(( 9, 2), $n/2^2$),
    edge((-6, 1), (-9, 2), stroke: 0.4pt), edge((-6, 1), (-3, 2), stroke: 0.4pt),
    edge(( 6, 1), ( 3, 2), stroke: 0.4pt), edge(( 6, 1), ( 9, 2), stroke: 0.4pt),
    node((-6, 2), $+$, stroke: none, shape: rect, fill: white),
    node(( 0, 2), $+$, stroke: none, shape: rect, fill: white),
    node(( 6, 2), $+$, stroke: none, shape: rect, fill: white),
    node((-9, 3), $dots.v$, stroke: none, shape: rect, fill: white),
    node((-3, 3), $dots.v$, stroke: none, shape: rect, fill: white),
    node(( 3, 3), $dots.v$, stroke: none, shape: rect, fill: white),
    node(( 9, 3), $dots.v$, stroke: none, shape: rect, fill: white),
    edge((-9, 2), (-9, 3), stroke: 0.4pt), edge((-3, 2), (-3, 3), stroke: 0.4pt),
    edge(( 3, 2), ( 3, 3), stroke: 0.4pt), edge(( 9, 2), ( 9, 3), stroke: 0.4pt),
    node((-10, 4), $n/2^k$), node((-8, 4), $n/2^k$),
    node((  8, 4), $n/2^k$), node((10, 4), $n/2^k$),
    edge((-9, 3), (-10, 4), stroke: 0.4pt), edge((-9, 3), (-8, 4), stroke: 0.4pt),
    edge(( 9, 3), (  8, 4), stroke: 0.4pt), edge(( 9, 3), (10, 4), stroke: 0.4pt),
    node(( -9, 4), $+$, stroke: none, shape: rect, fill: white),
    node((  9, 4), $+$, stroke: none, shape: rect, fill: white),
    node((  0, 4), $dots.h.c$, stroke: none, shape: rect, fill: white),
    node((14, 0), $O_0 (n)$,        stroke: none, shape: rect),
    node((14, 1), $O_1 (n)$,        stroke: none, shape: rect),
    node((14, 2), $O_2 (n)$,        stroke: none, shape: rect),
    node((14, 3), $dots.v$,         stroke: none, shape: rect),
    node((14, 4), $O_(k=lg n) (n)$, stroke: none, shape: rect),
    node((12, 0), $=$, stroke: none, shape: rect),
    node((12, 1), $=$, stroke: none, shape: rect),
    node((12, 2), $=$, stroke: none, shape: rect),
    node((12, 4), $=$, stroke: none, shape: rect),
    node((14, 0.5), $+$, stroke: none, shape: rect),
    node((14, 1.5), $+$, stroke: none, shape: rect),
    node((14, 2.5), $+$, stroke: none, shape: rect),
    node((14, 3.5), $+$, stroke: none, shape: rect),
    node((14, 4.5), $=$, stroke: none, shape: rect),
    node((14, 5), $O(n dot.c lg n)$, stroke: none, shape: rect),
  ))),
  caption: [Lorem ipsum dolor sit amet],
) <fig-recursion-tree>

== Ut enim ad minim veniam — bis

Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sagittis
hendrerit ante. Class aptent taciti sociosqu ad litora torquent per conubia
nostra, per inceptos hymenaeos.

=== Ut enim ad minim veniam

Curabitur ligula sapien, pulvinar a vestibulum quis, facilisis vel sapien.
Duis condimentum augue id magna semper rutrum. Aliquam ornare wisi eu metus.
Fusce aliquam vestibulum ipsum. Vivamus ac leo pretium faucibus.

- Ut enim ad minim veniam, quis nostrud
- Ut enim ad minim
- Ut enim ad minim veniam, quis
  - Ut enim ad
  - Ut enim ad
    - Ut enim
    - Ut enim
      - Ut enim
      - Ut enim

== Class aptent taciti

Even though dark mode can be very nice for websites and apps, it does not look
good when printed. Consider using white mode when print-screening dark-moded
content. The contrast with the white page is too big, as seen in
@fig-darkmode @darkMode.

#figure(
  image("../images/darkmode.png", width: 100%),
  caption: [White and dark mode comparison.],
) <fig-darkmode>

=== Class aptent taciti

Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sagittis
hendrerit ante. Class aptent taciti sociosqu ad litora torquent per conubia
nostra, per inceptos hymenaeos.

+ Ut enim ad minim veniam, quis nostrud
+ Ut enim ad minim
+ Ut enim ad minim veniam, quis
  + Ut enim ad
  + Ut enim ad
    + Ut enim
    + Ut enim
      + Ut enim
      + Ut enim

== Ut enim ad minim veniam, quis nostrud

Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut
aliquip ex ea commodo consequat. Nulla non arcu lacinia neque faucibus
fringilla. Vestibulum erat nulla, ullamcorper nec, rutrum non, nonummy ac,
erat.#footnote[Ut enim ad minim veniam, quis nostrud exercitation.]

#listing(
  caption: [Zbytečný kód],
  lang: "c",
  ```c
  #include <stdio.h>
  #include <iostream>
  // A comment
  int main(void)
  {
      printf("Hello World\n");
      return 0;
  }
  ```,
)

Nullam feugiat, turpis at pulvinar vulputate, erat libero tristique tellus,
nec bibendum odio risus sit amet ante @Motwani2014.

=== Ut enim ad minim veniam, quis nostrud

Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut
aliquip ex ea commodo consequat @Sestakova2018.

#figure(
  table(
    columns: 3,
    align: (left, center, left),
    stroke: 0.4pt,
    table.header([Typ], [Syntaxe], [Příklad]),
    [Inline], [`$...$`],   [`$x^2 + y^2 = z^2$`],
    [Block],  [`$ ... $`], [`$ x^2 + y^2 = z^2 $`],
  ),
  caption: [Zadávání matematiky v Typstu],
) <tab-matematika>

==== Class aptent taciti

#definition(label-name: "Optional label")[
  Class aptent taciti sociosqu ad litora torquent per conubia nostra, per
  inceptos hymenaeos. Fusce suscipit libero eget elit.
]

#example[
  Class aptent taciti sociosqu ad litora torquent per conubia nostra, per
  inceptos hymenaeos. Fusce suscipit libero eget elit.
]

===== Nadpis 5. úrovně

#theorem[
  Class aptent taciti sociosqu ad litora torquent per conubia nostra, per
  inceptos hymenaeos. Fusce suscipit libero eget elit.
]

#proof[
  Fusce suscipit libero eget elit. Etiam dui sem, fermentum vitae, sagittis
  id, malesuada in, quam. Aliquam id dolor.
]

===== Level 5 heading

#corollary[
  Fusce suscipit libero eget elit. Etiam dui sem, fermentum vitae, sagittis
  id, malesuada in, quam.
]

#proposition[
  Fusce suscipit libero eget elit.
]

#note[
  Fusce suscipit libero eget elit.
]

#remark[
  Fusce suscipit libero eget elit.
]

#lemma[
  Class aptent taciti sociosqu ad litora torquent per conubia nostra.
]

= Lorem ipsum

#chapter-abstract[
  Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sagittis
  hendrerit ante. Class aptent taciti sociosqu ad litora torquent per conubia
  nostra, per inceptos hymenaeos.
]

Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sagittis
hendrerit ante. Class aptent taciti sociosqu ad litora torquent per conubia
nostra @Kopka2004.

== Donec odio tempus molestie

Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sagittis
hendrerit ante @def:1 @def:2.

=== Class aptent taciti

Lorem ipsum dolor sit amet. Blah blah blah.

Mulla malesuada porttitor diam. Donec felis erat, congue non, volutpat at,
tincidunt tristique, libero. Vivamus viverra fermentum felis. Donec nonummy
pellentesque ante. Phasellus adipiscing semper elit. Proin fermentum massa
ac quam. Sed diam turpis, molestie vitae, placerat a, molestie nec, leo. Mae-
cenas lacinia. Nam ipsum ligula, eleifend at, accumsan nec, suscipit a, ipsum.
Morbi blandit ligula feugiat magna. Nunc eleifend consequat lorem. Sed lacinia
nulla vitae enim. Pellentesque tincidunt purus vel magna. Integer non enim.
Praesent euismod nunc eu purus. Donec bibendum quam in tellus. Nullam cur-
sus pulvinar lectus. Donec et mi. Nam vulputate metus eu enim. Vestibulum
pellentesque felis eu massa. @jakZiskatAcko

== Lorem ipsum dolor sit amet

ulla malesuada porttitor diam. Donec felis erat, congue non, volutpat at,
tincidunt tristique, libero. Vivamus viverra fermentum felis. Donec nonummy
pellentesque ante. Phasellus adipiscing semper elit. Proin fermentum massa
ac quam. Sed diam turpis, molestie vitae, placerat a, molestie nec, leo. Mae-
cenas lacinia. Nam ipsum ligula, eleifend at, accumsan nec, suscipit a, ipsum.
Morbi blandit ligula feugiat magna. Nunc eleifend consequat lorem. Sed lacinia
nulla vitae enim. Pellentesque tincidunt purus vel magna. Integer non enim.
Praesent euismod nunc eu purus. Donec bibendum quam in tellus. Nullam cur-
sus pulvinar lectus. Donec et mi. Nam vulputate metus eu enim. Vestibulum
pellentesque felis eu massa.

Quisque ullamcorper placerat ipsum. Cras nibh. Morbi vel justo vitae lacus
tincidunt ultrices. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. In
hac habitasse platea dictumst. Integer tempus convallis augue. Etiam facilisis.
Nunc elementum fermentum wisi. Aenean placerat. Ut imperdiet, enim sed
gravida sollicitudin, felis odio placerat quam, ac pulvinar elit purus eget enim.
Nunc vitae tortor. Proin tempus nibh sit amet nisl. Vivamus quis tortor vitae
risus porta vehicula.

Fusce mauris. Vestibulum luctus nibh at lectus. Sed bibendum, nulla a
faucibus semper, leo velit ultricies tellus, ac venenatis arcu wisi vel nisl. Vesti-
bulum diam. Aliquam pellentesque, augue quis sagittis posuere, turpis lacus
congue quam, in hendrerit risus eros eget felis. Maecenas eget erat in sapien
mattis porttitor. Vestibulum porttitor. Nulla facilisi. Sed a turpis eu lacus com-
modo facilisis. Morbi fringilla, wisi in dignissim interdum, justo lectus sagittis
dui, et vehicula libero dui cursus dui. Mauris tempor ligula sed lacus. Duis
cursus enim ut augue. Cras ac magna. Cras nulla. Nulla egestas. Curabitur
a leo. Quisque egestas wisi eget nunc. Nam feugiat lacus vel est. Curabitur
consectetuer.
