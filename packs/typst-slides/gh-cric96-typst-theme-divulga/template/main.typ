// Example deck for the divulga theme: one slide per building block.
// Compile from the repository root:
//   typst compile --root . --font-path fonts template/main.typ
#import "../lib.typ": *

#show: divulga-theme.with(
  lang: "en",
  config-info(title: [Divulga], author: [Your Name]),
)

#title-slide(
  title: [Big ideas,\ few words],
  subtitle: [A Touying theme for popular-science talks],
  author: [Your Name],
  affiliation: [Your Institution],
  date: datetime.today().display("[day] [month repr:long] [year]"),
  image: image("images/library.jpg"),
)

#statement-slide(dark: true, kicker: [The idea], attribution: [a design rule])[
  Slides *anchor* the talk. \ The talk carries the content.
]
#speaker-note[Speaker notes go here: `make notes` exports them for pdfpc.]

// ---------------------------------------------------------------------------
#part-slide(number: "01", title: [Words], subtitle: [Definitions, lists, quotes], color: palette.blue)

#slide(kicker: [Start from words])[
  #definition([intelligence], pron: [in·tel·li·gence], kind: [n.])[
    The ability to *solve problems never seen before*.
  ]
]

#slide(title: [Three senses, numbered])[
  #senses(
    [*Compress*: describe many data with few rules.],
    [*Understand*: that short description is a _model_ of the world.],
    [*Predict*: the model works on cases never seen.],
  )
  #v(0.8em)
  #pause
  #quote-block(size: 1.3em, who: [a slogan from algorithmic information theory])[
    Compression is comprehension.
  ]
]

#slide(title: [Cards with a rule on top])[
  #grid(
    columns: (1fr, 1fr, 1fr, 1fr),
    column-gutter: 1em,
    align: top,
    card(tag: [01], number: true, title: [Methods])[Deep networks.],
    card(tag: [02], number: true, title: [Architectures])[The Transformer.],
    card(tag: [03], number: true, title: [Data])[The whole web.],
    card(tag: [04], number: true, title: [Hardware])[Gaming GPUs.],
  )
  #v(0.6em)
  #pause
  No single ingredient is enough: it is the *combination*.
]

#slide(title: [Big numbers])[
  #grid(
    columns: (1fr, 1fr, 1fr),
    column-gutter: 1em,
    big-number([16.4%], [of companies use AI]),
    big-number([×2], [in one year], color: palette.ink),
    big-number([60%], [blame missing skills], color: palette.coral),
  )
  #source[Source: put it here]
]

// ---------------------------------------------------------------------------
#part-slide(number: "02", title: [Pictures], subtitle: [Photos and native diagrams], color: palette.green)

#image-slide(
  image("images/campus.jpg"),
  kicker: [1956 · Dartmouth],
  caption: [Where the name *artificial intelligence* was born.],
  credit: [Photo: Daderot, CC0],
)

#split-slide(image("images/library.jpg"), title: [Image on one side], side: right, ratio: 40%, credit: [Gary Todd, CC0])[
  #senses(
    [Text on the other side.],
    [`side: left` or `right`.],
    [`ratio` sets the image width.],
  )
]

#slide(title: [Timeline])[
  #timeline((
    ([1950], [Turing's question], palette.violet),
    ([1958], [Perceptron], palette.blue),
    (year: [1970s], label: [First winter], color: palette.muted, hollow: true),
    ([1997], [Deep Blue], palette.violet),
    ([2012], [AlexNet], palette.coral),
    ([2017], [Transformer], palette.coral),
    ([2022], [ChatGPT], palette.coral),
  ), height: 8em)
]

#slide(title: [Inside a neural network], repeat: 2, self => [
  #let (uncover,) = utils.methods(self)
  #grid(
    columns: (1fr, 1fr),
    rows: (auto, 7.4em, auto),
    column-gutter: 1.4em,
    row-gutter: 0.5em,
    pill([one neuron], fill: palette.blue),
    uncover("2-", pill([many neurons, in layers], fill: palette.coral)),
    align(center + horizon, perceptron(([fever], [cough], [aches]), (0.8, 0.5, 0.2), [flu?], size: 0.95em)),
    uncover("2-", align(center + horizon, network((3, 5, 5, 2)))),
    text(size: 0.8em)[Weighs the clues and adds them up.],
    uncover("2-", text(size: 0.8em)[*Learning* = adjusting the weights.]),
  )
])

#slide(title: [How a machine learns])[
  #let lab(icon, l) = stack(spacing: 0.12em, icon, text(font: fonts.mono, size: 0.42em, fill: palette.muted, l))
  #let grey = palette.muted.lighten(30%)
  #let group(body, col) = box(stroke: (bottom: 3pt + col), inset: (x: 0.15em, bottom: 0.2em), body)
  #learning-flow(
    [supervised], [examples _with_ answers],
    panel(grid(columns: 4, column-gutter: 0.35em,
      lab(cat(size: 1.55em), [cat]), lab(dog(size: 1.55em), [dog]),
      lab(dog(size: 1.55em), [dog]), lab(cat(size: 1.55em), [cat]))),
    panel(grid(columns: 3, column-gutter: 0.3em, align: horizon,
      cat(size: 2em, fill: grey), text(fill: palette.muted, sym.arrow.r),
      text(font: fonts.display, size: 1.3em, weight: "bold", fill: palette.blue)[cat])),
    color: palette.blue,
  )
  #v(-0.1em)
  #pause
  #learning-flow(
    [unsupervised], [data _without_ answers],
    panel(grid(columns: 3, column-gutter: 0.6em, row-gutter: 0.1em,
      cat(size: 1.55em, fill: grey), dog(size: 1.55em, fill: grey), cat(size: 1.55em, fill: grey),
      dog(size: 1.55em, fill: grey), cat(size: 1.55em, fill: grey), dog(size: 1.55em, fill: grey))),
    panel(grid(columns: 2, column-gutter: 1.2em,
      group(grid(columns: 2, gutter: 0.1em, ..range(3).map(_ => cat(size: 1.2em, fill: palette.blue))), palette.blue),
      group(grid(columns: 2, gutter: 0.1em, ..range(3).map(_ => dog(size: 1.2em, fill: palette.coral))), palette.coral))),
    color: palette.violet,
  )
  #v(-0.1em)
  #pause
  #learning-flow(
    [reinforcement], [try, reward,\ retry],
    panel(grid(columns: 4, column-gutter: 0.15em, align: horizon,
      robot-fallen(size: 1.9em), text(font: fonts.display, weight: "bold", fill: palette.coral)[−1],
      robot-standing(size: 1.9em), text(font: fonts.display, weight: "bold", fill: palette.green)[+1])),
    panel(grid(columns: (auto, 1fr), column-gutter: 0.2em, align: horizon,
      robot-standing(size: 2.1em, fill: palette.green), text(size: 0.66em)[learns to \ *stay up*])),
    color: palette.coral,
  )
]

#slide(title: [Attention])[
  #text(fill: palette.muted)[Each word looks at all the others.]
  #v(1.4em)
  #attention(
    ("The", "cat", "did", "not", "jump", "because", "it", "was", "tired"),
    8,
    (0.05, 1.0, 0.1, 0.25, 0.45, 0.35, 0.6, 0.3, 0.0),
    size: 0.95em,
  )
]

#slide(title: [Chevrons])[
  #let inside(k, t) = [
    #text(font: fonts.mono, size: 0.55em, fill: white.transparentize(25%), upper(k)) \
    #box(text(font: fonts.display, size: 0.92em, weight: "bold", t))
  ]
  #let below(how, col, body) = [#pill(how, fill: col) #v(0.1em) #text(size: 0.8em, body)]
  #chevrons((
    (inside([the library], [Pre-training]), below([self-supervised], palette.violet)[Reads half the web.]),
    (inside([the school], [Fine-tuning]), below([supervised], palette.blue)[Learns from good answers.]),
    (inside([the internship], [Human feedback]), below([reinforcement], palette.coral)[People reward the best.]),
  ), colors: (palette.violet, palette.blue, palette.coral))
]

#slide(title: [Flow on a rule])[
  #flow(([*Idea* \ someone has a problem], [*Words* \ they describe it], [*Software* \ it gets built]), colors: (palette.muted, palette.green, palette.green))
]

#slide(title: [From model to agent])[
  #grid(
    columns: (1.15fr, 1fr),
    column-gutter: 1.4em,
    align: horizon,
    [
      #text(size: 1.5em, font: fonts.display, weight: "bold")[A model *answers*.]
      #v(-0.3em)
      #text(size: 1.5em, font: fonts.display, weight: "bold")[An agent *acts*.]
    ],
    agent-loop(),
  )
]

#slide(title: [An agent at work], repeat: 4, self => [
  #let on(icon) = active => icon(size: 2.6em, fill: if active { palette.ink } else { palette.muted.lighten(30%) })
  #agent-diagram(
    self.subslide,
    person(size: 2.6em),
    box(width: 2.6em, height: 2.6em, align(center + horizon, network((3, 4, 3), width: 2.6em, height: 2.2em, r: 0.17em))),
    (
      (icon: on(magnifier), label: [search trains]),
      (icon: on(train), label: [tickets]),
      (icon: on(calendar), label: [calendar]),
    ),
  )
])

// ---------------------------------------------------------------------------
#part-slide(number: "03", title: [Closing], color: palette.coral)

#statement-slide(dark: true, kicker: [To close], size: 2.6em)[
  What do we choose to keep doing *with our own heads*?
]

#statement-slide(fill: palette.blue, kicker: [Thanks!], size: 2.4em)[
  Questions?
  #v(0.6em)
  #text(font: fonts.mono, weight: "regular", size: 0.35em)[you\@example.org]
]
