#show figure: set block(breakable: true)

= Patterns

\
#lorem(150)

\
== Bild Beispiel

\
#figure(
  image("../public/pictures/battle.jpg", width: 80%),
  caption: [ Darth Vader vs Obi Wan Kenobi ]
)

\ \
== Tabllenbeispiel

\
#figure(
  table(
  columns: (1fr, 2fr, 2fr, 3fr),
  inset: 10pt,
  align: (col, row) => if row == 0 { center + horizon } else { left + horizon },
  stroke: (x, y) => if y == 0 { (bottom: 2pt + black) } else { 0.5pt + gray },
  fill: (col, row) => if row == 0 { rgb("e0e0e0") } else if calc.even(row) { rgb("f9f9f9") } else { none },
  
  // Header
  [*Episode*], [*Duellanten*], [*Ort*], [*Ausgang / Besonderheit*],

  // Episode I
  [Ep. I], [Qui-Gon Jinn vs. Darth Maul], [Tatooine (Wüste)], [Unentschieden. Kurzzeitiges Scharmützel; Maul entkommt.],
  [Ep. I], [Qui-Gon Jinn & Obi-Wan Kenobi vs. Darth Maul], [Naboo (Theed-Palast)], [Sieg für Obi-Wan. Qui-Gon wird von Maul getötet; Obi-Wan spaltet Maul anschließend in zwei Hälften.],

  // Episode II
  [Ep. II], [Obi-Wan Kenobi & Anakin Skywalker vs. Count Dooku], [Geonosis (Hangar)], [Sieg für Dooku. Obi-Wan wird verletzt; Anakin verliert seinen rechten Unterarm.],
  [Ep. II], [Yoda vs. Count Dooku], [Geonosis (Hangar)], [Unentschieden. Dooku flieht, indem er die verletzten Jedi bedroht und Yoda ablenkt.],

  // Episode III
  [Ep. III], [Anakin Skywalker & Obi-Wan Kenobi vs. Count Dooku], [Invisible Hand (Orbit über Coruscant)], [Sieg für Anakin. Obi-Wan wird bewusstlos geschlagen; Anakin schlägt Dooku die Hände ab und enthauptet ihn auf Palpatines Befehl.],
  [Ep. III], [Obi-Wan Kenobi vs. General Grievous], [Utapau], [Sieg für Obi-Wan. Grievous nutzt vier Lichtschwerter; Obi-Wan zerstört zwei davon und tötet ihn schließlich mit einem Blaster.],
  [Ep. III], [Mace Windu (mit Agen Kolar, Saesee Tiin & Kit Fisto) vs. Darth Sidious], [Coruscant (Kanzlerbüro)], [Sieg für Sidious. Die drei Begleiter sterben sofort. Windu entwaffnet Sidious, wird aber durch den eingreifenden Anakin verraten und von Sidious getötet.],
  [Ep. III], [Yoda vs. Darth Sidious], [Coruscant (Senatsarena)], [Unentschieden / Flucht von Yoda. Nach einem verheerenden Macht-Duell muss Yoda einsehen, dass er Sidious nicht besiegen kann, und flieht ins Exil.],
  [Ep. III], [Obi-Wan Kenobi vs. Darth Vader (Anakin)], [Mustafar], [Sieg für Obi-Wan. Emotionales Duell auf Leben und Tod. Obi-Wan nutzt den "High Ground" und trennt Vaders verbliebene Gliedmaßen ab.],

  // Episode IV
  [Ep. IV], [Obi-Wan Kenobi vs. Darth Vader], [Todesstern I], [Sieg für Vader. Obi-Wan opfert sich absichtlich und wird eins mit der Macht, um Luke die Flucht zu ermöglichen.],

  // Episode V
  [Ep. V], [Luke Skywalker vs. Darth Vader], [Wolkenstadt (Bespin)], [Sieg für Vader. Vader dominiert den Kampf physisch und psychisch, schlägt Lukes Hand ab und enthüllt, dass er sein Vater ist.],

  // Episode VI
  [Ep. VI], [Luke Skywalker vs. Darth Vader], [Todesstern II (Thronsaal)], [Sieg für Luke. Luke besiegt Vader im Zorn, weigert sich aber, ihn zu töten. Vader bekehrt sich und wirft den Imperator in den Reaktorschacht.]
),
caption: [Lichtschwertduelle in Star Wars]
)

#pagebreak()
