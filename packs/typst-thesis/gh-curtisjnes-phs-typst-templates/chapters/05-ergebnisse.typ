// Kapitel 5: Ergebnisse
#import "../template.typ": *

= Ergebnisse

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Maecenas sed diam eget risus varius blandit sit amet non magna.

== Deskriptive Ergebnisse

Nullam quis risus eget urna mollis ornare vel eu leo. Cras mattis consectetur purus sit amet fermentum. Donec ullamcorper nulla non metus auctor fringilla.

#figure(
  table(
    columns: 5,
    stroke: 0.5pt,
    inset: 0.5em,
    [*Variable*], [*M*], [*SD*], [*Min*], [*Max*],
    [Variable A], [4.23], [1.12], [1], [7],
    [Variable B], [3.87], [0.98], [1], [7],
    [Variable C], [5.12], [1.34], [2], [7],
    [Variable D], [4.56], [1.21], [1], [7],
  ),
  caption: [Deskriptive Statistiken der Hauptvariablen],
) <tab:deskriptiv>

=== Verteilungen

Vestibulum id ligula porta felis euismod semper. Aenean lacinia bibendum nulla sed consectetur. Maecenas faucibus mollis interdum. Etiam porta sem malesuada magna mollis euismod.

=== Gruppenvergleiche

Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Duis mollis, est non commodo luctus, nisi erat porttitor ligula.

#figure(
  table(
    columns: 4,
    stroke: 0.5pt,
    inset: 0.5em,
    [*Gruppe*], [*M*], [*SD*], [*n*],
    [Gruppe A], [4.45], [1.23], [45],
    [Gruppe B], [4.12], [1.08], [42],
    [Gruppe C], [4.78], [0.95], [48],
  ),
  caption: [Mittelwertvergleich zwischen den Gruppen],
) <tab:gruppen>

== Inferenzstatistische Analyse

Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Sed posuere consectetur est at lobortis.

=== Hypothesenprüfung

Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam quis risus eget urna mollis ornare vel eu leo.

*Hypothese 1*: Lorem ipsum dolor sit amet, consectetur adipiscing elit.
- Ergebnis: $t(133) = 2.45$, $p < .05$
- Die Hypothese wurde bestätigt

*Hypothese 2*: Sed do eiusmod tempor incididunt ut labore.
- Ergebnis: $F(2, 132) = 3.87$, $p < .05$
- Die Hypothese wurde teilweise bestätigt

=== Korrelationsanalyse

Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor.

#figure(
  table(
    columns: 5,
    stroke: 0.5pt,
    inset: 0.5em,
    [], [*Var A*], [*Var B*], [*Var C*], [*Var D*],
    [*Var A*], [1.00], [], [], [],
    [*Var B*], [.42\*], [1.00], [], [],
    [*Var C*], [.31\*], [.28\*], [1.00], [],
    [*Var D*], [.18], [.45\*\*], [.33\*], [1.00],
  ),
  caption: [Korrelationsmatrix der Hauptvariablen. \*p<.05, \*\*p<.01],
)

== Interpretation der Ergebnisse

Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Cras mattis consectetur purus sit amet fermentum. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum.

=== Bezug zur Forschungsfrage

Nulla vitae elit libero, a pharetra augue. Donec sed odio dui. Maecenas faucibus mollis interdum. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.

=== Einordnung in den Forschungsstand

Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Vestibulum id ligula porta felis euismod semper.
