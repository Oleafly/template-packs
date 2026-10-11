#import "ieee.typ": conf, maketitle


#show: conf.with(title: [My article], abstract: lorem(100))


= First section
#lorem(100)

#lorem(100)

== Subsection
#lorem(200)

#lorem(100)

== Another subsection
#lorem(50)

=== Subsubsection
#lorem(300)

#figure(
  image("multiplexer.png", width: 100%),
  caption: [A multiplexer],
) <glacier>

=== Another subsubsection
#lorem(50)

#figure(
  table(
  columns: 3,
  table.header(
    [Substance],
    [Subcritical °C],
    [Supercritical °C],
  ),
  [Hydrochloric Acid],
  [12.0], [92.1],
  [Sodium Myreth Sulfate],
  [16.6], [104],
  [Potassium Hydroxide],
  table.cell(colspan: 2)[24.7],
),
caption: [This is a table]
)


==== Deeply nested heading
#lorem(100)

==== Second deeply nested heading
#lorem(100)

===== An even deeper section
#lorem(50)

= Another section

#lorem(300)

#lorem(200)

#lorem(100)