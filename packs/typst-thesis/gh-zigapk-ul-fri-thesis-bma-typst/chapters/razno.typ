= Razno <ch:razno>

== Notacije <sec:notacije>

Za notacijo spremenljivk ter skalarjev uporabimo običajno notacijo, t.j., spremenljivka $x$ in skalar $a$. Pri notaciji matrik ter vektorjev pa se poslužujemo krepega fonta. Torej, matrika $bold(A)$ ter vektor $bold(v)$,

$
  bold(A) = mat(delim: "[",
    a_(11), a_(12), dots, a_(1 q);
    a_(21), a_(22), dots, a_(2 q);
    dots.v, , , dots.v;
    a_(p 1), a_(p 2), dots, a_(p q);
  ), quad
  bold(v) = vec(x_1, x_2, dots.v, x_q).
$

== Lepe tabele in psevdokoda <sec:psevdokoda>

Psevdokoda @alg:primer prikazuje primer delovanja genetskega algoritma, medtem ko Tabela @tab:params prikazuje primer lepe tabele brez vertikalnih črt.

#figure(
  kind: "algorithm",
  supplement: [Algoritem],
  block(
    width: 100%,
    inset: 10pt,
    stroke: 0.5pt,
    align(left, text(size: 9pt)[
      1: $t <- 0$ \
      2: $italic("InitPopulation")[P(t)] <-$ inicializiraj populacijo \
      3: $italic("EvalPopulation")[P(t)] <-$ evaluiraj populacijo \
      4: *repeat* \
      5: #h(1em) $P'(t) <- italic("Variation")[P(t)] <-$ generiraj novo populacijo \
      6: #h(1em) $italic("EvalPopulation")[P'(t)] <-$ evaluiraj novo populacijo \
      7: #h(1em) $P(t+1) <- italic("ApplyGeneticOperators")[P'(t) in Q]$ \
      8: #h(1em) $t <- t + 1$ \
      9: *until* prekinitev \
      10: *if* rezultat dovolj dober *then* \
      11: #h(1em) shrani rezultat \
      12: *end if*
    ])
  ),
  caption: [Psevdokoda genetskega algoritma],
) <alg:primer>

#figure(
  table(
    columns: 3,
    stroke: none,
    inset: (x: 8pt, y: 4pt),
    align: center,
    table.header(
      table.hline(stroke: 1.5pt),
      [Ime], [Vrednost], [Opis],
      table.hline(stroke: 0.75pt),
    ),
    [_$a$_], [0.03], [skalar],
    [_$x$_], [$-1$], [spremenljivka],
    table.hline(stroke: 1.5pt),
  ),
  caption: [Primer enostavne tabele.],
) <tab:params>
