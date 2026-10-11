#import "../../metadata.typ": meta

#grid(
  columns: (auto, 1fr, auto),
  align: (left, center, right),

  image("../../img/bulme.png", height: 3.0cm),

  align(center)[
    #text()[#meta.school]
    #linebreak()
    #text()[#meta.department]
  ],

  image("../../img/htl.png", height: 1.5cm),
)

#v(2cm)

#align(center)[
  #text(size: 24pt, weight: "bold")[DIPLOMARBEIT]

  #text(size: 16pt, weight: "bold")[#meta.title]
]

#v(2cm)

#for c in meta.candidates {
  [
    #text(weight: "bold")[#(str(c.task))]
    #linebreak()

    #grid(
      columns: (1fr, 1fr),
      c.name, c.class,
    )
  ]
  v(0.5cm)
}

#v(3cm)

#text()[ausgeführt im Schuljahr  #meta.year]

#v(0.3cm)

#text()[Betreut von:  #meta.supervisor.name]

#v(2cm)

#grid(
  columns: (1fr, 1fr),
  gutter: 3pt,
  text()[Abgabevermerk:], linebreak(),
  datetime.today().display(), text()[übernommen von:],
)

#line(length: 100%)
