// Import theme from the file.
#import "themes/iss.typ": *
#import "@preview/showybox:2.0.4": showybox
#import "@preview/cetz:0.5.2"
#import "@preview/cetz-plot:0.1.4"
#import "@preview/itemize:0.2.0" as el

// Define main colors of the theme.
#let mainColor = rgb(10,20,86)
#let enumColor = rgb(124,36,43)
#let alertColor = rgb(124,36,43)
#let enumColor = rgb(230,135,67)
#let otherColor = rgb(194,213,238)
#let otherColor2 = rgb(253,242,212)

// Option of the theme.
#show: iss-theme.with(
  left-footer: [Biesaga et al.],
  short-title: [Play again? Nowy paradygmat badający dynamikę błędu predykcji oraz zaangażowanie w działanie.],
  color: mainColor,
)

// Global settings.
#set text(font: "New Computer Modern", weight: "semibold", size: 20pt, hyphenate: false, lang: "pl")
#set strong(delta: 100)
#set par(justify: true)
#set enum(numbering: n => block(fill: enumColor, radius: 2pt, inset: .1em)[#text(fill: white, [#n.])])
#show highlight: set highlight(fill: alertColor)
#show highlight: it => [
  #set text(fill: white)
  #it
]
#show figure.caption: set text(size: 12pt)
#show figure: set figure.caption(separator: ".")
#show figure.where(kind: table): set figure.caption(position: top)
#show figure.where(kind: image): set figure(supplement: "Rycina")
#show smallcaps: it =>{
  set text(font: "New Computer Modern")
  set align(center)
  it
}
#show link: it => {
  set text(blue.darken(20%))
  underline(it)
}
#show footnote: it =>{}
#set footnote(numbering: it => {})
#show: el.default-enum-list.with(fill: (enumColor, alertColor))

// Graphics
#let heart6 = image("png/heart-6.png")
#let heart7 = image("png/heart-7.png")
#let spades6 = image("png/spades-6.png")
#let spades7 = image("png/spades-7.png")
#let grey_robot = image("png/grey_robot.png")
#let black_robot = image("png/black_robot.png")
#let orange_robot = image("png/orange_robot.png")
#let green_robot = image("png/green_robot.png")
#let metalic_robot = image("png/metalic_robot.png")
#let white_boy = image("png/mustache_white_boy.png")
#let brown_boy = image("png/brown_boy.png")
#let brown_girl = image("png/brown_girl.png")
#let white_girl = image("png/white_girl.png")
#let bun_white_girl = image("png/bun_white_girl.png")

#let procedure = layout(ly => cetz.canvas(length: ly.width * .047,{
    import cetz.draw: *
    rect((-4.5,-.5),(-2,.5), name: "predictions")
    content("predictions", [#smallcaps[Oczekiwania]])

    rect((-.75,-.5),(1.75,.5), name: "mask")
    content("mask", [#smallcaps[$2 times 3 - 1$]])

    content((3,0), [#box(width: .75cm)[#heart6]])
    content((3.75,0), [#box(width: .75cm)[#spades7]])
    content((3.375,-1), [#smallcaps[runda 1]])

    content((4.75,0), [#box(width: .75cm)[#heart6]])
    content((5.5,0), [#box(width: .75cm)[#heart7]])
    content((4.75 + .375,-1), [#smallcaps[runda 2]])

    content((6.5 + .375,-.4), [...])

    content((8.25,0), [#box(width: .75cm)[#spades6]])
    content((9,0), [#box(width: .75cm)[#spades7]])
    content((8.25 + .375,-1), [#smallcaps[runda 12]])

    rect((10.25,-.5),(12.75,.5), name: "perceived")
    content("perceived", [#box(width: 2cm)[#smallcaps[Zadowolenie z gry]]])

    rect((14,-.5),(16.5,.5), name: "again")
    content("again", [#box(width: 1cm)[#smallcaps[Grasz ponownie?]]])

    rect((14,-3.5),(16.5,-2.5), name: "end")
    content("end", [#box(width: 1cm)[#smallcaps[Koniec]]])

    line((15.25,.5),(15.25,1.5), (-3.25,1.5), (-3.25,.5), name: "repeat", mark: (end: ">"), stroke: (dash: "dashed"))

    line((15.25, -.5),(15.25,-2.5), name: "finish", mark: (end: ">"), stroke: (dash: "dashed"))
    set-style(content: (frame: "rect", stroke: none, fill: white, padding: .2))
    content("finish.mid", [#smallcaps[Nie]])
    content("repeat.mid", [#smallcaps[Tak]])

}))

#let game = grid(rows: (1fr, 1fr),
  align: (center, center),
  row-gutter: -5em,
  [
    #cetz.canvas({
      import cetz.draw: *
      content((2.75,.25), [#text(weight: "black", size: 11pt)[#smallcaps[Wygrywa osoba A]]], anchor: "south", padding: .6)
      content((-.25, 0), [#box(width: 1cm)[#heart6]], anchor: "center")
      content((-.25,-1), [#text(size: 10pt)[Osoba A]])
      content((1.5, 0), [#box(width: 1cm)[#heart7]], anchor: "center")
      content((1.5,-1), [#text(size: 10pt)[Osoba B]])
      content((4, 0), [#box(width: 1cm)[#spades6]], anchor: "center")
      content((4,-1), [#text(size: 10pt)[Osoba A]])
      content((5.75, 0), [#box(width: 1cm)[#spades7]], anchor: "center")
      content((5.75,-1), [#text(size: 10pt)[Osoba B]])
    })
  ],
  [
    #cetz.canvas({
      import cetz.draw: *
      content((2.75,.25), [#text(weight: "black", size: 11pt)[#smallcaps[Wygrywa osoba B]]], anchor: "south", padding: .6)
      content((-.25, 0), [#box(width: 1cm)[#heart6]], anchor: "center")
      content((-.25,-1), [#text(size: 10pt)[Osoba A]])
      content((1.5, 0), [#box(width: 1cm)[#spades7]], anchor: "center")
      content((1.5,-1), [#text(size: 10pt)[Osoba B]])
      content((4, 0), [#box(width: 1cm)[#spades6]], anchor: "center")
      content((4,-1), [#text(size: 10pt)[Osoba A]])
      content((5.75, 0), [#box(width: 1cm)[#heart7]], anchor: "center")
      content((5.75,-1), [#text(size: 10pt)[Osoba B]])
    })
  ])

#let conditions = grid(
    columns: (5em, auto, 3em, auto, auto, auto),
    column-gutter: 2em,
    align: (center + horizon, center, bottom, center, center, center),
    rows: 4,
    row-gutter: 1em,
    [#smallcaps[Człowiek]],
    [#box(width: 1.5cm)[#brown_girl]],
    [#set text(size: 18pt); ...],
    [#box(width: 1.5cm)[#brown_girl]],
    [#box(width: 1.5cm)[#brown_girl]],
    [#box(width: 1.5cm)[#brown_girl]],
    [#smallcaps[Komputer]],
    [#box(width: 1.25cm)[#orange_robot]],
    [#set text(size: 18pt); ...],
    [#box(width: 1.25cm)[#orange_robot]],
    [#box(width: 1.25cm)[#orange_robot]],
    [#box(width: 1.25cm)[#orange_robot]],
    [#smallcaps[Różni ludzie]],
    [#box(width: 1.5cm)[#brown_girl]],
    [#set text(size: 18pt); ...],
    [#box(width: 1.5cm)[#bun_white_girl]],
    [#box(width: 1.5cm)[#white_boy]],
    [#box(width: 1.5cm)[#brown_boy]],
    [#box(width: 1cm)[#smallcaps[Różne komputery]]],
    [#box(width: 1.25cm)[#orange_robot]],
    [#set text(size: 18pt); ...],
    [#box(width: 1.25cm)[#metalic_robot]],
    [#box(width: 1.25cm)[#grey_robot]],
    [#box(width: 1.25cm)[#green_robot]],
  )


// Title slide.
#title-slide(
  authors: [Mikołaj Biesaga, Ognjen Zakic, & Anna Kuźmińska],
  title: [Play again?],
  subtitle: [Nowy paradygmat badający dynamikę błędu predykcji oraz\ zaangażowanie w
działanie],
  date: [3 sierpnia 2026],// datetime.today().display("[day] [month repr:long] [year]"),
  funding: [#link("mailto:m.biesaga@uw.edu.pl")[m.biesaga\@uw.edu.pl]],
)

// Regular slide.
#slide(title: [Plan prezentacji])[
  #v(25%)
  + Dlaczego gramy w gry?

  + Procedura badawcza.

  + Dlaczego Living Lab?

  + Kwestie organizacyjne.

]

#slide(title: [Dlaczego gramy w gry?])[

  - Powszechnie uważa się, że dopamina ("hormon szczęścia") wydziela się gdy coś się nam uda, np. wygrana na loterii.

  - Jednak, ostatnie badania sugerują, że wydziela się tylko wtedy gdy nagroda przewyższa nasze oczekiwania (Schultz, 2016).
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 1em,
    [
      #showybox(
      frame: (
        border-color: blue.darken(50%),
        title-color: blue.lighten(60%),
        body-color: white//otherColor.lighten(80%)
      ),
      title-style: (
        color: black,
        weight: "bold",
        align: center
      ),
      shadow: (
        offset: 3pt,
      ),
      title: "Pozytywny błąd predykcji",
      [
        Nagroda (jej wartość oczekiwana) jest wyższa niż oczekiwana.
      ]
      )
      ],
      [
        #showybox(
        frame: (
          border-color: red.darken(50%),
          title-color: red.lighten(60%),
          body-color: white//otherColor2.lighten(80%)
        ),
        title-style: (
          color: black,
          weight: "bold",
          align: center
        ),
        shadow: (
          offset: 3pt,
        ),
        title: "Negatywny błąd predykcji",
        [
          Nagroda (jej wartość oczekiwana) jest niższa niż oczekiwana.
        ]
        )
      ]
  )
  - Zgodnie z Predictive Processing Framework (Deterding et al., 2022) ludzie dążą do minimalizacji niepewności, a co za tym idzie do maksymalizacji dokładności przewidywań.
]

#focus-slide(background: mainColor,
  [
    Motywacja by grać dalej wynika z #highlight[minimalizacji błędu predykcji,] a nie z pozytywnego błędu predykcji.
  ]
)

#slide(title: [Dlaczego kontynuujemy grę mimo że sukces jest niepewny?])[
#show: text.with(size: 12pt)
#show: align.with(center)
#v(15%)
#cetz.canvas({
  import cetz.draw: *
  import cetz-plot: *
  import calc.pow
  import calc.cos
  import calc: *

  set-style(axes: (stroke: 1.5pt, tick: (stroke: 0pt), label: (offset:10pt)))

  plot.plot(
  size: (12, 8),
  axis-style: "school-book",
  x-tick-step: none,
  y-tick-step: none,
  y-label: none,
  x-label: [Czas],
  stroke: 10pt,
  name: "plot",
  legend: auto,
  {
    let domains = ((0,.5), (1.5,2.5), (3.5, 4.5), (5.5,6.5), (7.5, 8.5), (9.5,10.5))
    for domain in domains {
      if domain == (0,.5) {
        plot.add(t => pow(.8,t) * cos(t * calc.pi), domain: domain,  style: (fill: white, stroke: blue), label: $text("Oczekiwania") - text("Nagroda") < 0$)
      }
      plot.add(t => pow(.8,t) * cos(t * calc.pi), domain: domain,  style: (fill: white, stroke: blue))
      
    }
    let domains = ((0.5,1.5), (2.5,3.5), (4.5, 5.5), (6.5,7.5), (8.5, 9.5))
    for domain in domains {
      if domain == (0.5,1.5) {
        plot.add(t => pow(.8,t) * cos(t * calc.pi), domain: domain,  style: (fill: white, stroke: red), label: $text("Oczekiwania") - text("Nagroda") > 0$)
      }
      plot.add(t => pow(.8,t) * cos(t * calc.pi), domain: domain,  style: (fill: white, stroke: red))
      
    }
  })
})
]

#slide(title: [Gra])[
      #grid(
        columns: (1fr, 1fr),
        column-gutter: 1em,
        align: (center+horizon, center + horizon),
        [
          #showybox(
          frame: (
            border-color: yellow.darken(50%),
            title-color: yellow.lighten(60%),
            body-color: white//otherColor.lighten(80%)
          ),
          title-style: (
            color: black,
            weight: "bold",
            align: center
          ),
          shadow: (
            offset: 3pt,
          ),
          title: "Matching Pennies",
          [
            Każda z osób ma do wyboru dwie karty: czerwoną i czarną. Wykładają je jednocześnie.
          ]
          )
        ],
        [
         #game 
        ])

]

#slide(title: [Procedura badawcza])[
  #show: set text(size: 12pt)
  #v(15%)
  #procedure
]

#slide(title: [Warunki eksperymentalne])[
  #show: set text(size: 12pt)
  #show: align.with(center)
  #v(15%)
  #conditions
]

#slide(title: [Warunki eksperymentalne - Dlaczego?])[

  - Spodziewamy się różnic w strategiach w zależności od przeciwnika (np. Ayton & Fisher, 2004; Boynton, 2003; Gronchi and Sloman, 2008).

  - W przypadku różnych przeciwników, a co za tym idzie różnych strategii, spodziewamy się mniejszego zaangażowania w grę (krótszej gry).
  #v(5%)

  #show: text.with(size: 12pt)
  #show: align.with(center)
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 1em,
  [
  #cetz.canvas({
    import cetz.draw: *
    import cetz-plot: *
    import calc.pow
    import calc.cos
    import calc: *

    set-style(axes: (stroke: 1.5pt, tick: (stroke: 0pt), label: (offset:10pt)))

    plot.plot(
    size: (8, 6),
    axis-style: "school-book",
    x-tick-step: none,
    y-tick-step: none,
    y-label: none,
    x-label: [Czas],
    stroke: 10pt,
    name: "plot",
    legend: none,
    {
      let domains = ((0,.5), (1.5,2.5), (3.5, 4.5), (5.5,6.5), (7.5, 8.5), (9.5,10.5))
      for domain in domains {
        if domain == (0,.5) {
          plot.add(t => pow(.8,t) * cos(t * calc.pi), domain: domain,  style: (fill: white, stroke: blue), label: $text("Oczekiwania") - text("Nagroda") < 0$)
        }
        plot.add(t => pow(.8,t) * cos(t * calc.pi), domain: domain,  style: (fill: white, stroke: blue))
      
      }
      let domains = ((0.5,1.5), (2.5,3.5), (4.5, 5.5), (6.5,7.5), (8.5, 9.5))
      for domain in domains {
        if domain == (0.5,1.5) {
          plot.add(t => pow(.8,t) * cos(t * calc.pi), domain: domain,  style: (fill: white, stroke: red), label: $text("Oczekiwania") - text("Nagroda") < 0$)
        }
        plot.add(t => pow(.8,t) * cos(t * calc.pi), domain: domain,  style: (fill: white, stroke: red))
      
      }
    })
  })
  ],
  [
  #cetz.canvas({
    import cetz.draw: *
    import cetz-plot: *
    import calc.pow
    import calc.cos
    import calc: *

    set-style(axes: (stroke: 1.5pt, tick: (stroke: 0pt), label: (offset:10pt)))

    plot.plot(
    size: (8, 6),
    axis-style: "school-book",
    x-tick-step: none,
    y-tick-step: none,
    y-label: none,
    x-label: [Czas],
    stroke: 10pt,
    name: "plot",
    legend: none,
    {
      let domains = ((0,.5), (1.5,2.5), (3.5, 4.5), (5.5,6.5), (7.5, 8.5), (9.5,10.5))
      for domain in domains {
        if domain == (0,.5) {
          plot.add(t => cos(t * calc.pi), domain: domain,  style: (fill: white, stroke: blue), label: $text("Oczekiwania") - text("Nagroda") < 0$)
        }
        plot.add(t => cos(t * calc.pi), domain: domain,  style: (fill: white, stroke: blue))
      
      }
      let domains = ((0.5,1.5), (2.5,3.5), (4.5, 5.5), (6.5,7.5), (8.5, 9.5))
      for domain in domains {
        if domain == (0.5,1.5) {
          plot.add(t => cos(t * calc.pi), domain: domain,  style: (fill: white, stroke: red), label: $text("Oczekiwania") - text("Nagroda") < 0$)
        }
        plot.add(t => cos(t * calc.pi), domain: domain,  style: (fill: white, stroke: red))
      
      }
    })
  })
  ])
]

#new-section-slide()[
  Dlaczego Living Lab?
]

#focus-slide(background: mainColor,
  [
    Badanie w #highlight[Living Lab] pozwoli na zbadanie #highlight[motywacji w warunkach naturalnych] minimalizując efekt warunków laboratoryjnych.
  ]
)

#slide(title: [Kwestie organizacyjne])[
  #v(10%)

  + Na ile przeprowadzenie takiego badania jest możliwe? Co jest niemożliwe?

  + Jaki jest koszt przeprowadzenia takiego badania?

  + Jakie są możliwe terminy przeprowadzenia badania?

  + Jak wygąda praca nad przygotowaniem procedury?

  + Współautorstwo publikacji naukowej.

  + Umowy, faktury, KSeFy, itp.
]

#new-section-slide()[
  Dziękuję!
]

#slide(title: [Bibliografia])[
  #show: set text(size: 12pt)
  #v(15%)
  + Ayton, P., & Fischer, I. (2004). The hot hand fallacy and the gambler’s fallacy: Two faces of subjective randomness? _Memory & Cognition_, _32_(8), 1369–1378. https://doi.org/10.3758/BF03206327

  + Boynton, D. M. (2003). Superstitious responding and frequency matching in the positive bias and gambler’s fallacy eﬀects. _Organizational Behavior and Human Decision Processes_, _91_(2), 119–127. https://doi.org/10.1016/S0749-5978(03)00064-5

  + Gronchi, G., & Sloman, S. A. (2008). Do causal beliefs influence the hot-hand and the gambler’s fallacy? In _Proceedings of the 30th annual conference of the cognitive science society_, 1164–1168. Cognitive Science Society Austin, TX.

  + Schultz, W. (2016). Dopamine reward prediction error coding. _Dialogues in Clinical Neuroscience_, _18_(1), 23–32. https://doi.org/10.31887/DCNS.2016.18.1/wschultz

  + Deterding, S., Andersen, M. M., Kiverstein, J., & Miller, M. (2022). Mastering uncertainty: A predictive processing account of enjoying uncertain success in video game play. _Frontiers in Psychology_, _13_, 924953. https://doi.org/10.3389/fpsyg.2022.924953
]

#slide(title: [Plan działań])[
  #v(20%)

  + Finalizacja koncepcji badania i procedury badawczej.

  + Przygotowanie materiałów do badania (instrukcje, pytania, itp.).

  + Wniosek do komisji etycznej ISS UW.

  + Prerejestracja badania (IPA).

]
