#import "/lib/lib.typ": *

// Passe sempre `author:` — sem ele os metadados do PDF saem como "SAPIANS".
#show: sapians-slides.with(
  title: "Presentation Title",
  author: "Author Name",
)

// 01 Cover
#slide-cover(
  title: "YOUR TALK",
  subtitle: "A Clear, One-Line Statement\nof What This Deck Argues",
  author: "Author Name",
  affiliation: "Your Team or Institution",
  dark: true,
  // `note:` vira nota de apresentador no sidecar pdfpc.
  note: "Welcome the audience and state the one thing they should remember.",
)

// 02 Problem
#slide-problem(
  title: "TOPIC",
  section: "DIAGNOSIS",
  counter: "02 / 10",
  hero: "State the problem\nin one strong sentence.",
  subtext: "One supporting sentence explaining why the problem matters and what it costs.",
  question-label: "THE QUESTION",
  question: "What is the single question\nthis deck answers?",
  visual: block(
    fill: sapians-white,
    stroke: stroke-light,
    radius: radius-sm,
    inset: 4mm,
    [
      #kicker("KEY DIRECTIVE")
      #v(1.5mm)
      #text(
        size: 7.5pt,
        weight: "bold",
        fill: sapians-text-dark,
      )[A short, memorable statement that frames the argument.]
    ],
  ),
)

// 03 Definition blocks
#slide-definition(
  title: "TOPIC",
  section: "ARCHITECTURE",
  counter: "03 / 10",
  hero: "Name the core idea\nin one line.",
  explanation: "One sentence expanding the idea: what it is made of and why it is structured this way.",
  definitions: (
    ("PART ONE", "What it does"),
    ("PART TWO", "What it does"),
    // `pause` splits the slide into steps: the entries below it keep their box
    // but stay hidden until you advance. Delete it for a static slide.
    pause,
    ("PART THREE", "What it does"),
    ("PART FOUR", "What it does"),
  ),
  note: "Walk through the first two parts, pause for questions, then reveal the rest.",
)

// 04 Equation
#slide-equation(
  title: "TOPIC",
  section: "THE OBJECTIVE",
  counter: "04 / 10",
  hero: "State what the formula asks for,\nin plain words.",
  equation: $ f(x) = sum_(i=1)^n w_i dot phi_i (x) $,
  // Uma anotacao por linha. Aceita matematica inline entre $...$.
  steps: (
    [$w_i$ — the weight the model gives to each part],
    [$phi_i$ — the part itself, in a form a person can read],
    pause,
    [$n$ — how many parts you allow: the budget for simplicity],
  ),
  note: "Read the formula left to right, one symbol at a time.",
)

// 05 Three columns (Model | Code | Idea)
#slide-three-column(
  title: "TOPIC",
  section: "MECHANISM",
  counter: "05 / 10",
  column1-title: "THE CONCEPT",
  column1-content: block(
    fill: sapians-white,
    stroke: stroke-light,
    radius: radius-sm,
    inset: 3.5mm,
    height: 100%,
    [
      #text(size: 7.5pt, weight: "bold")[Concept headline]
      #v(1.5mm)
      #small-text(
        "One or two sentences describing the concept shown in this column.",
      )
    ],
  ),
  column1-caption: "One-line caption.",
  column2-title: "THE CODE",
  column2-code: [
    ```typst
    #import "/lib/lib.typ": *

    #show: sapians-slides.with(
      title: "Project Alpha",
    )

    #slide-cover(
      title: "YOUR TALK",
      subtitle: "Deep Intelligence",
    )
    ```
  ],
  column3-title: "THE TAKEAWAY",
  column3-hero: "The point, in 3 words.",
  column3-sub: "One sentence connecting the concept and the code to the takeaway.",
  column3-footer: "Footer annotation.",
)

// 06 Evidence: hero + graphic
#slide-evidence(
  title: "TOPIC",
  section: "EVIDENCE",
  counter: "06 / 10",
  hero: "Show the one chart\nthat carries the claim.",
  subtext: "Say out loud what the reader should notice before you explain why.",
  // `graphic:` aceita qualquer conteudo: image("assets/fig.png"), uma
  // tabela, um diagrama. Troque o rect abaixo pela sua figura.
  graphic: rect(
    width: 62mm,
    height: 40mm,
    fill: sapians-card-bg,
    stroke: stroke-light,
    radius: radius-md,
  ),
)

// 07 Limitation
#slide-limitation(
  title: "TOPIC",
  section: "LIMITATIONS",
  counter: "07 / 10",
  hero: "Name the limits\nbefore anyone asks.",
  visual1: rect(width: 38mm, height: 26mm, fill: sapians-card-bg, stroke: stroke-light, radius: radius-sm),
  visual2: rect(width: 38mm, height: 26mm, fill: sapians-card-bg, stroke: stroke-light, radius: radius-sm),
  points: (
    "Where the method stops being trustworthy.",
    "What it silently assumes about your data.",
    pause,
    "The cost you pay for the simplification.",
  ),
  label1: "NARROW",
  sub1: "too little context",
  label2: "WIDE",
  sub2: "too much noise",
  conclusion-title: "Neither extreme is the answer.",
  conclusion-sub: "Say what you actually recommend, and under which condition.",
)

// 08 Contrast: Not This vs This
#slide-contrast(
  title: "GUIDELINES",
  section: "DECISION",
  counter: "08 / 10",
  hero: "What do we optimize for?",
  not-this-content: ["A common but wrong interpretation, quoted the way people say it."],
  this-content: ["The correct interpretation, stated just as concretely."],
  not-this-label: "NOT THIS",
  this-label: "THIS",
  this-sub: "CLARITY > NOISE",
)

// 09 Dark takeaway
#slide-takeaway(
  title: "TOPIC",
  section: "NEXT STEPS",
  counter: "09 / 10",
  hero: "Close with the single\nsentence they should remember.",
  subtext: "One line about what happens next or what you are asking the audience to do.",
  takeaway-title: "START NOW",
  takeaway-text: "TYPE: make watch",
)

// 10 Index: 2x2 cards
#slide-index(
  title: "TOPIC",
  section: "ROADMAP",
  counter: "10 / 10",
  // Cada card e (kicker, titulo) ou (kicker, titulo, descricao).
  items: (
    ("01", "First thing", "What it does"),
    ("02", "Second thing", "What it does"),
    pause,
    ("03", "Third thing", "What it does"),
    ("04", "Fourth thing", "What it does"),
  ),
)
