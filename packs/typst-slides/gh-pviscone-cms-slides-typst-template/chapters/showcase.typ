#import "/template/lib.typ": *
#import "/template/logos.typ": *
#import "/template/cms-macros.typ": *

// === Available slides ===
//
// #title-slide()
// #toc-slide()
// #blank-slide(title)
// #slide(title)
// #backup-cover()
//
// === Available macros ===
//
// #quote-block(body)
// #color-block(title, body)
//
// === Presenting with pdfpc ===
//
// Use #note("...") to add pdfpc presenter annotations on a specific slide
// Before presenting, export all notes to a pdfpc file:
// $ typst query slides.typ --field value --one "<pdfpc-file>" > slides.pdfpc
// $ pdfpc slides.pdf
//
// ------------------------------


//All the headings level 1 marked as outlined will appear in the TOC
#toc-slide()[]

//slide title is a heading level 2, you can change with head: 1
#slide(title: [Introduction], spacing: 0.5em)[
  #lorem(290)
]

//blank-slide title is a heading level 1, it will appear in the TOC
#blank-slide(title: [Layout showcase])[
  Show example and presets of multiple layouts.
]

#slide(title: [Two columns])[
  #cols(2)[
    //By default, content is top aligned
    //#put(left+horizon)[
    #lorem(100)
    //]
  ][
    #put(center + horizon)[
      #figure(
        image(cern_blue),
        caption: [CERN Logo],
      )]
  ]
]


#slide(title: [N columns])[
  //You can also specify relative widths for each column
  #cols((29%, 19%, 49%), gutter: 1%)[
    #bx(stroke: 3pt + rgb("2651a8"), height: 100%, width: 100%)[
      #put(center + horizon)[
        Column 1
      ]
    ]
  ][
    #bx(stroke: 3pt + red, height: 100%, width: 100%)[
      #put(center + horizon)[
        Column 2
      ]
    ]
  ][
    #bx(stroke: 3pt + green, height: 100%, width: 100%)[
      #put(center + horizon)[
        Column 3
      ]
    ]
  ]
]

#slide(title: [N rows])[
  //You can also specify relative widths for each column
  #rows((28%, 18%, 48%), gutter: 2%)[
    #bx(stroke: 3pt + rgb("2651a8"), height: 100%, width: 100%)[
      #put(center + horizon)[
        Row 1
      ]
    ]
  ][
    #bx(stroke: 3pt + red, height: 100%, width: 100%)[
      #put(center + horizon)[
        Row 2
      ]
    ]
  ][
    #bx(stroke: 3pt + green, height: 100%, width: 100%)[
      #put(center + horizon)[
        Row 3
      ]
    ]
  ]
]

#slide(title: [Rows + Columns])[
  #cols((29%, 19%, 49%), gutter: 1%)[
    #rows((49%, 49%), gutter: 2%)[
      #bx(stroke: 3pt + blue, height: 100%, width: 100%)[
        #put(center + horizon)[
          Region 1
        ]
      ]
    ][
      #bx(stroke: 3pt + gray, height: 100%, width: 100%)[
        #put(center + horizon)[
          Region 2
        ]
      ]
    ]
  ][
    #bx(stroke: 3pt + green, height: 100%, width: 100%)[
      #put(center + horizon)[
        Region 3
      ]
    ]
  ][
    #rows((32%, 32%, 32%), gutter: 1.5%)[
      #bx(stroke: 3pt + yellow, height: 100%, width: 100%)[
        #put(center + horizon)[
          Region 4
        ]
      ]
    ][
      #bx(stroke: 3pt + orange, height: 100%, width: 100%)[
        #put(center + horizon)[
          Region 5
        ]
      ]
      #bx(stroke: 3pt + purple, height: 100%, width: 100%)[
        #put(center + horizon)[
          Region 6
        ]
      ]
    ]
  ]
]

#blank-slide(title: [Functionalities])[]

#slide(title: [Listings])[
  #set align(center)
  #let height = 40%
  #cols((32%, 32%, 30%), gutter: 1%)[
    #put(horizon)[
      #bx(stroke: black, height: height)[
        *Bullet list*:
        - Item 1
        - Item 2
          - Subitem 1
          - Subitem 2
            - Subsubitem 1
        - Item 3
      ]
    ]
  ][
    #put(horizon)[
      #bx(stroke: black, height: height)[
        #set par(leading: 0.45em)
        *Enum list*:
        1. Item 1
        2. Item 2
        3. Subitem 1
          4. Subitem 2
            5. Subsubitem 1
        6. Item 3
      ]
    ]
  ][
    #put(horizon)[
      #bx(stroke: black, height: height)[
        #set par(leading: 0.45em)
        *Check boxes*:
        - [ ] Item 1
        - [x] Item 2
          - [-] Subitem 1
          - [-] Subitem 2
            - [-] Subsubitem 1
        - [?] Item 3

      ]
    ]
  ]
]


#slide(title: [Other blocks])[
  === Code blocks
  //if you want to change size of text in code blocks
  #show raw.where(block: true): set text(size: 12pt)


  #codly(
    highlights: (
      (line: 10, start: 2, end: none, fill: red),
    ),
    annotations: (
      (
        start: 10,
        end: 13,
        content: block(
          width: 4em,
          // Rotate the element to make it look nice
          rotate(
            -90deg,
            align(center, box(width: 100pt)[Black magic]),
          ),
        ),
      ),
    ),
  )
  ```c
  float Q_rsqrt( float number )
  {
  	long i;
  	float x2, y;
  	const float threehalfs = 1.5F;

  	x2 = number * 0.5F;
  	y  = number;
  	i  = * ( long * ) &y;                       // evil floating point bit level hacking
  	i  = 0x5f3759df - ( i >> 1 );               // what the fuck?
  	y  = * ( float * ) &i;
  	y  = y * ( threehalfs - ( x2 * y * y ) );   // 1st iteration
  //	y  = y * ( threehalfs - ( x2 * y * y ) );   // 2nd iteration, can be removed

  	return y;
  }
  ```
  === Inline code
  ```python import numpy```

]



#slide(title: [Other blocks])[
  === Bold
  *Bold text*

  === Emphatized text
  _Emph text_

  === Sub, super, overline, underline, smallcaps, strike
  A#sub[sub]#super[super] #overline[overline] #underline[underline] #smallcaps[smallcaps]
  #strike[This was wrong]

  === Quote blocks
  #quote-block(
    [Se l'acqua scarseggia, la papera non galleggia],
  )
  === Color block
  #color-block(title: [Color block], [This is a color block])
]


#slide(title: [Other functionalities])[
  #cols((65%, 35%))[
    === Footnotes
    #lorem(10) #footnote[This is a very dead language]

    === Links
    #link("https://github.com/pviscone/cms-slides-typst-template")[cms-slides-typst-template]

    === Citations
    Have you ever heard about Typst @typst

    === References
    You can find how to do it in backup (@backup)
  ][
    === Algo block
    #pseudocode-list(hooks: .5em)[
      + do something
      + *while* still something to do
        + do even more
        + *if* not done yet *then*
          + resume working
        + *else*
          + go home
    ]
  ]


]

#slide(title: [Math])[
  === Math
  $
    sum_(k=0)^n k & = 1 + ... + n & = (n(n+1)) / 2
  $

  === Inline math
  This is inline math: $E = m c^2$.

  === Enable numbered equations
  #set math.equation(numbering: "(1)")
  ```typst #set math.equation(numbering: "(1)")``` #footnote[Put it in main if you want it as a default]
  $ E = m c^2 $

  === Define Shortcuts
  #show: shorthands.with(
    ($+-$, $plus.minus$),
  )
  ```typst
  #show: shorthands.with(
    ($+-$, $plus.minus$),
  )
  $ mu = 1 +- 0.2 "cm" $
  ```
  $ mu = 1 +- 0.2 "cm" $



]



#slide(title: [Pinit])[

  === Pinit for equations
  #v(1cm)
  $ (#pin(1)q_T^* p_T#pin(2))/(#pin(3)p_E#pin(4))#pin(5)p_E^*#pin(6) >= (c + q_T^* p_T^*)(1+r^*)^(2N) $

  #pinit-highlight-equation-from((1, 2, 3, 4), (3, 4), height: 3.5em, pos: bottom, fill: rgb(0, 180, 255))[
    First term
  ]

  #pinit-highlight-equation-from((5, 6), (5, 6), height: 2.5em, pos: top, fill: rgb(150, 90, 170))[
    Second term
  ]
  === Pinit lines
  #pin("a")wrong#pin("b")
  #pinit-line(stroke: 3pt + red, start-dy: -0.25em, end-dy: -0.25em, "a", "b")

  === Point from
  A simple #pin("A")highlighted text#pin("B").
  #pinit-highlight("A", "B")
  #pinit-point-from(("A", "B"))[It is simple.]

  #v(2cm)
  === Absolute place
  #absolute-place(dx: 600pt, dy: 300pt, image(width: 25%, "/template/assets/backup_cover.png"))

]

#slide(title: [Diagrams])[
  #diagram(
    $
      e^- edge("rd", "-<|-") &                     && edge("ld", "-|>-") e^+ \
                             & edge(gamma, "wave") \
      e^+ edge("ru", "-|>-") &                     && edge("lu", "-<|-") e^- \
    $,
  )

  #import fletcher.shapes: hexagon, house
  #let blob(pos, label, tint: white, ..args) = node(
    pos,
    align(center, label),
    width: 28mm,
    fill: tint.lighten(60%),
    stroke: 1pt + tint.darken(20%),
    corner-radius: 5pt,
    ..args,
  )
  #diagram(
    spacing: 8pt,
    cell-size: (8mm, 10mm),
    edge-stroke: 1pt,
    edge-corner-radius: 5pt,
    mark-scale: 70%,

    blob((0, 1), [Add & Norm], tint: yellow, shape: hexagon),
    edge(),
    blob((0, 2), [Multi-Head\ Attention], tint: orange),
    blob((0, 4), [Input], shape: house.with(angle: 30deg), width: auto, tint: red),

    for x in (-.3, -.1, +.1, +.3) {
      edge((0, 2.8), (x, 2.8), (x, 2), "-|>")
    },
    edge((0, 2.8), (0, 4)),

    edge((0, 3), "l,uu,r", "--|>"),
    edge((0, 1), (0, 0.35), "r", (1, 3), "r,u", "-|>"),
    edge((1, 2), "d,rr,uu,l", "--|>"),

    blob((2, 0), [Softmax], tint: green),
    edge("<|-"),
    blob((2, 1), [Add & Norm], tint: yellow, shape: hexagon),
    edge(),
    blob((2, 2), [Feed\ Forward], tint: blue),
  )
  #set align(center)
  More info about Fletcher at #link("https://typst.app/universe/package/fletcher")[https://typst.app/universe/package/fletcher]

]

#slide(title: [CMS Macros])[
  Look in `template/cms-macros.typ` for available CMS specific macros. Remember to include it

  #ttbar #to #ll #bbbar #nunu
]

#slide(title: [Conclusions])[
  #put(center + horizon)[
    *If you are still using beamer you are a bad person*\
    \
    Also notice that the progress bar at the bottom will stop one slide before calling backup cover :)
  ]
]

// Backup-cover is where the progress bar finishes
#backup-cover()

#slide(title: [How to reference pages], tag: <backup>)[
  #put(center + horizon, height: 50%)[
    You can add references to specific slides in the presentation.
  ]
  #set align(center)
  To add a reference to a page, add ```typst tag: <reference_tag>``` in ```typst slide()``` and then call ```typst @reference_tag```
]

#slide(title: [Backup slide 2])[
  This is another backup slide.
]
