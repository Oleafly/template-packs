#heading(numbering: none, outlined: false)[Symbolverzeichnis] <sec:symbole>

// TODO: Eigene Formelzeichen ergaenzen. Falls die Arbeit ohne nennenswerte
// Formeln auskommt, kann dieser Abschnitt entfallen. Dann in main.typ die
// zugehoerige #include-Zeile auskommentieren.
//
// Die Gruppenueberschriften werden ueber die Hilfsfunktion sym-gruppe gesetzt.

#let sym-gruppe(titel) = table.cell(colspan: 3)[
  #v(0.6em)
  #text(weight: "bold")[#titel]
]

#table(
  columns: (2.6cm, 1fr, 2.6cm),
  inset: (x: 0pt, y: 4pt),
  column-gutter: 8pt,
  stroke: none,
  align: (left, left, left),

  table.header(
    [*Symbol*], [*Bedeutung*], [*Einheit*],
  ),

  sym-gruppe[Lateinische Formelzeichen],

  [$a$], [Beschleunigung], [m/s#super[2]],
  [$F$], [Kraft], [N],
  [$m$], [Masse], [kg],
  [$t$], [Zeit], [s],

  sym-gruppe[Griechische Formelzeichen],

  [$alpha$], [Winkel], [deg],
  [$omega$], [Kreisfrequenz], [rad/s],

  sym-gruppe[Indizes, Operatoren und Mengen],

  [$dot(x)$], [Erste Ableitung von $x$ nach der Zeit], [--],
  [$hat(x)$], [Geschätzter Wert der Größe $x$], [--],
  [$bb(R)$], [Menge der reellen Zahlen], [--],
)
