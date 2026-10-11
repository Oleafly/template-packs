= Templates 1 : Tableaux

== Des tableaux simples

#table(columns: 3*(1fr,), align:center,
    [*Bonjour*], [*Bonjour*], [*Bonjour*], 
    [_Je suis ici_], [_Je suis ici_], [_Je suis ici_],
)

#v(5em)

#figure(
  table(columns: 3*(1fr,), align:center,
      [*Bonjour*], [*Bonjour*], [*Bonjour*], 
      [_Je suis ici_], [_Je suis ici_], [_Je suis ici_],
  ),
  caption: [Ici avec un titre]
)

#v(5em)

#figure(
  table(columns: 3*(1fr,), align:(left, center, left),
      [*Bonjour*], [*Bonjour*], [*Bonjour*], 
      [_Je suis ici_], [_Je suis ici_], [_Je suis ici_],
  ),
  caption: [Ici avec les textes alignés différemment]
)

#v(5em)

#figure(
  table(
    columns: (auto, auto, auto),
    inset: 10pt,
    align: horizon,
    table.header(
      [], [*Volume*], [*Parameters*],
    ),
    image("Photos/Folder1/cylindre.jpg", height: 4em),
    $ pi h (D^2 - d^2) / 4 $,
    [
      $h$: height \
      $D$: outer radius \
      $d$: inner radius
    ],
    image("Photos/Folder1/tetrahedron.jpg", height: 4em),
    $ sqrt(2) / 12 a^3 $,
    [$a$: edge length]
  ),
  caption: [Ici un exemple avec des images, plusieurs lignes et des formules mathématiques]
)

#v(5em)

//Cette ligne autorise tout les blocks de type figure, déclarés après de pouvoir s'afficher sur 2 pages si elles sont trop grandes
#[
  #show figure: set block(breakable: true)

  #figure(
    table(columns: 3*(1fr,), align:(left, center, left), 
        [*Bonjour*], [*Bonjour*], [*Bonjour*], 
        [_Je suis ici_], [_Je suis ici_], [_Je suis ici_],
        [_Je suis ici_], [_Je suis ici_], [_Je suis ici_],
        [_Je suis ici_], [_Je suis ici_], [_Je suis ici_],
        [_Je suis ici_], [_Je suis ici_], [_Je suis ici_],
        [_Je suis ici_], [_Je suis ici_], [_Je suis ici_],
        [_Je suis ici_], [_Je suis ici_], [_Je suis ici_],
        [_Je suis ici_], [_Je suis ici_], [_Je suis ici_],
    ),
    caption: [Ici un tableau qui déborde sur 2 pages]
  )
]

== Des tableaux plus complexes

#v(2em)

// Pour faire un tableau avec de la couleur, et des automatisations sur les valeurs vides
#[
  #set table(
    stroke: none,
    gutter: 0.2em,
    fill: (x, y) =>
      if x == 0 or y == 0 { gray },
    inset: (right: 1.5em),
  )

  #show table.cell: it => {
    if it.x == 0 or it.y == 0 {
      set text(white)
      strong(it)
    } else if it.body == [] {
      // Replace empty cells with 'N/A'
      pad(..it.inset)[_N/A_]
    } else {
      it
    }
  }

  #let a = table.cell(
    fill: green.lighten(60%),
  )[A]
  #let b = table.cell(
    fill: aqua.lighten(60%),
  )[B]
    #figure(
      table(
        columns: 4,
        [], [Exam 1], [Exam 2], [Exam 3],

        [John], [], a, [],
        [Mary], [], a, a,
        [Robert], b, a, b,
      ),
      caption: [Un tableau coloré et automatisé]
    )
]

#v(5em)

// Pour faire un tableau avec de la couleur, et des automatisations sur les valeurs vides
#[
  #show table.cell.where(y: 0): strong
  #set table(
    stroke: (x, y) => if y == 0 {
      (bottom: 0.7pt + black)
    },
    align: (x, y) => (
      if x > 0 { center }
      else { left }
    )
  )
  #show figure: it => align(right)[
    #it.body
    #v(10pt, weak: true) #it.caption 
  ]
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
    caption: [*Un tableau de chimie*]
  )
]

#v(5em)

// Pour faire un tableau avec des espaces entre les lignes
#[
  #show table.cell.where(x: 0): strong
  #show figure: it => align(left)[
    #it.body
    #v(10pt, weak: true) 
    #it.caption 
  ]
  #figure(
    table(
      columns: 3,
      gutter: 3pt,
      [Name], [Age], [Strength],
      [Hannes], [36], [Grace],
      [Irma], [50], [Resourcefulness],
      [Vikram], [49], [Perseverance],
    ),
    caption: [Un tableau "aéré"]
  )
]

#v(5em)

// Par exemple, un petit planning
#[
  #set table(
    fill: (x, y) =>
      if x == 0 or y == 0 {
        gray.lighten(40%)
      },
    align: right,
  )

  #show table.cell.where(x: 0): strong
  #show table.cell.where(y: 0): strong
  #show figure: set block(breakable: true)
  #figure(
    table(
      columns: 4,
      table.header(
        [], [Blue chip],
        [Fresh IPO], [Penny st'k],
      ),
      table.cell(
        rowspan: 6,
        align: horizon,
        rotate(-90deg, reflow: true)[
          *USD / day*
        ],
      ),
      [0.20], [104], [5],
      [3.17], [108], [4],
      [1.59], [84],  [1],
      [0.26], [98],  [15],
      [0.01], [195], [4],
      [7.34], [57],  [2],
    ),
    caption: [Un tableau un peu plus complexe, sur 2 pages]
  )
]

#v(5em)

// Par exemple, un petit planning
#[
  #set table.hline(stroke: .6pt)
  #figure(
    table(
      stroke: none,
      columns: (auto, 1fr),
      [09:00], [Badge pick up],
      [09:45], [Opening Keynote],
      [10:30], [Talk: Typst's Future],
      [11:15], [Session: Good PRs],
      table.hline(start: 1),
      [Noon], [_Lunch break_],
      table.hline(start: 1),
      [14:00], [Talk: Tracked Layout],
      [15:00], [Talk: Automations],
      [16:00], [Workshop: Tables],
      table.hline(),
      [19:00], [Day 1 Attendee Mixer],
    ),
    caption: [_Un planning de la journée_]
  )
]

== Un exemple concret

#[
  #set table(
    fill: (x, y) =>
      if x == 0 or y == 0 {
        gray.lighten(40%)
      } else if x == 1 and y!= 0 {
        gray.lighten(60%)
      },
    align: right,
  )
  #show table.cell: it => {
    if it.y == 0 {
      set text(black)
      strong(it)
    } else if it.x <= 1 and it.y != 0 and it.y <= 6  {
      set text(red)
      strong(it)
    } else if it.x <= 1 and it.y >= 7 and it.y <= 10  {
      set text(blue)
      strong(it)
    } else if it.body == [1] {
      // Replace empty cells with 'N/A'
      strong(it)
    } else {
      it
    }
  }
  #figure(
    table(
      columns: (auto,auto,) + 6*(1fr,),
      table.header(
        [], 
        align(horizon)[*Signaux d'entrée*], 
        align(center+bottom)[#rotate(-70deg, reflow: true)[reset_i]],
        align(center+bottom)[#rotate(-70deg, reflow: true)[select_mux_data_s]],
        align(center+bottom)[#rotate(-70deg, reflow: true)[enable_reg_data_s]],
        align(center+bottom)[#rotate(-70deg, reflow: true)[enable_reg_tag_s]],
        align(center+bottom)[#rotate(-70deg, reflow: true)[enable_reg_state_s]],
        align(center+bottom)[#rotate(-70deg, reflow: true)[enable_bypass_s]],
      ),
      table.cell(
        rowspan: 6,
        align: horizon,
        rotate(-90deg, reflow: true)[*Etats FSM init*],
      ),
      [init_init], [0], [0], [0], [0], [0], [0], 
      [begin_init], [0], [0], [0], [0], [1], [0],
      [process1_init], [0], [0], [0], [0], [0], [0], 
      [wait_init], [0], [1], [0], [0], [0], [0], 
      [process2_init], [0], [0], [0], [1], [0], [0], 
      [finalize_init], [0], [1], [0], [0], [0], [0], 
      table.cell(
        rowspan: 4,
        align: horizon,
        rotate(-90deg, reflow: true)[*Etats FSM data*],
      ),
      [init_data], [1], [0], [0], [0], [0], [0], 
      [begin_data], [1], [0], [0], [1], [0], [0],
      [loop_process_data], [0], [0], [0], [0], [0], [0], 
      [loop_wait_data], [0], [1], [0], [0], [0], [1],
    ),
    caption: [Un grand tableau, avec pas mal de fonctionnalitées intéressantes]
  )
]


