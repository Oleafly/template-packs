#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#import "@preview/subpar:0.2.2"
#show: codly-init.with()

#import "latemplate.typ": latemplate
#import "lalib.typ": emphasis_text, hidden_heading, insert_titled_page, place_at

#set par(
  first-line-indent: 1em,
  spacing: 1.2em,
  justify: true,
)

#set text(size: 12pt)

// Enable equation numbering for subfigure references
#set math.equation(numbering: "1.")

// ==== Body ====

#show: latemplate.with(
  title: [_LaTemplate_: Report template],
  title_size: 21pt,
  authors_flat: (
    (name: "lgabp1", contribution_symbol: "†"),
    (name: "filler"),
  ),
  header_content: (
    left: [*LaTemplate* Report],
    right: [
      #image("assets/Tux.svg.png", height: 0.8cm)
    ], // Tux image
  ),
  page_numbering: "1/1",
  heading_numbering: "I.A.1",
  column_count: 2,
)

#place_at(top)[
  #hidden_heading[Abstract]
  #emphasis_text("Abstract—")
  #text(fill: color.rgb("444444"), weight: "bold")[
    #lorem(40)
  ]
  #v(1em)
]

= Introduction
#lorem(40)

= Section 2
== Section 2.1

@tux_a and @tux_b, @berry1997flying

#place_at(bottom + center)[
  #subpar.grid(
    figure(
      image("assets/Tux.svg.png", height: 4cm),
      caption: [Tux, png version],
    ),
    <tux_a>,

    figure(
      image("assets/Tux.svg", height: 4cm),
      caption: [Tux, svg version],
    ),
    <tux_b>,

    columns: (1fr, 1fr),
    caption: [Principle of the opensurbot platform],
    label: <opensurgbot_principle>,
  )
]

#lorem(10)

#lorem(20)

#lorem(280)

#figure(
  [
    #codly(languages: codly-languages)
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
    //	y  = y * ( threehalfs - ( x2 * y * y ) );   // 2nd iteration, this can be removed

    	return y;
    }
    ```
  ],
  kind: image,
  caption: "Original implementation of the fast inverse square root",
) <fastinversesqrt>
#v(1em)


#place_at(bottom)[
  #hidden_heading[Conclusion]
  #text(fill: color.rgb("444444"), [
    #emphasis_text("Conclusion — ")
    #lorem(40)

  ])
  #v(20em)
]

#insert_titled_page(
  column_count: 2,
  content_align: left + top,
  show_in_toc: true,
  title: "Bibliography",
  gap_under_header: 0em,
)[
  #set text(size: 10pt)
  #bibliography("refs.bib", style: "ieee", title: none)
]




