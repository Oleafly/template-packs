#import "@preview/lovelace:0.3.0": * // This is a library for pseudocode

#show figure.caption: set align(start); // The caption alignment of the figure is set to the start/left (the default position is center).
#show figure.caption: set text(8pt) // Figure text size
#show heading: set text(18pt) // Heading text size
#show heading: set block(spacing: 1.5em) // spacing after and before heading
#set list(indent: 1em) // list indent
#set text(font: "New Computer Modern Sans") // text font
#show cite: set text(style: "italic") // cites are italic
#set par(justify: true) // block letter
// #set page(paper: "a4") // a4 is default

// Use this for cite color (in this case blue)
#show cite: it => {
  // color everthing except brackets
  show regex("[a-zA-Zöü&\d.,.-]"): set text(fill: blue)
  // or regex("[\p{L}\d+]+") when using the alpha-numerical style
  it
}

// Use this for ref color (in this case blue)
#show ref: it => {
  if it.element == none {
    // This is a citation, which is handled above.
    return it
  }
  show regex("[a-zA-Zöü&\d.,.-]"): set text(fill: blue)
  it
}

// Table of contents main cheapters are strong/bold 
#show outline.entry.where(
  level: 1,
): it => {
  v(12pt, weak: true)
  strong(it)
}

// ---------------------------------  TITLE/COVER PAGE -----------------------------------------------------

// use this variables:
#let bachelor_or_Master = "b" // "b" or "m" for bachelor or master
#let your_name = "Your Name"
#let science_type = "science" // of Science or of Arts? (Science or arts)
#let matriculation_number = "123456"
#let faculty = "digital media"
#let degree_course = "Computer Science in media" // e.g Computer Science in Media
#let university_supervisor= "Prof. Dr. Uwe Hahne"
#let second_supervisior = "Not Prof. Patrick Kaserer"
#let external_thesis = true // Are you writing this thesis in a company? (true, false)
#let submitted = "30.11.2024"
#let thesis_title_line_1 = "Here are some cool title" 
#let thesis_title_line_2 = "for your amazing thesis"

#let degree = ""
#let d_short = ""

#if (bachelor_or_Master == "b" or bachelor_or_Master == "B") {
  d_short = "B"
  degree = "Bachelor"
} else if (bachelor_or_Master == "m" or bachelor_or_Master == "M"){
  d_short = "M"
  degree = "Master"
}

#let science_short = ""

#if (science_type == "science" or science_type == "Science") {
  science_short = "Sc."
} else if (bachelor_or_Master == "Arts" or bachelor_or_Master == "arts"){
  science_short = "A."
}

#let first_supervisor_form = ""
#let second_supervisior_form = ""

#if (external_thesis) {
  first_supervisor_form = "University supervisor"
  second_supervisior_form = "External supervisor"
} else {
  first_supervisor_form = "First supervisor"
  second_supervisior_form = "Second supervisor"
}

// HFU logo
#place(
  dx: (100% - 180pt),
  image("images/Hochschule_Furtwangen_HFU_logo.svg", width: 200pt)
)

// second logo if necessary
#place(
  dy: 7pt,
  dx: 0pt,
  image("images/placeholder.png", width: 150pt, height: 70pt)
)

#v(100pt) // vertical space
#strong(text([#degree Thesis], size: 45pt, baseline: 20pt)) //use strong for bold

#text([by], size: 15pt, baseline: 8pt) \ // this "/" is a linebreak

#strong(text([#your_name], size: 20pt))

#text([This thesis submitted for the degree of], size: 15pt, baseline: 17pt) \

#strong(text([#degree of #science_type (#d_short. #science_short)], size: 20pt, baseline: 10pt))

#text([on the faculty of #faculty], size: 15pt) \
#v(35pt)
#strong(text([#thesis_title_line_1], size: 25pt, spacing: 18pt)) \

#strong(text([#thesis_title_line_2], size: 25pt, spacing: 18pt)) \

#v(40pt)

#let title_size = 15pt
#place(
  dy: 25pt,
      table(
          columns: 2,
          stroke: none,
          align: left,
          inset: 6pt,
          text([Degree course:], size: title_size), text([#degree_course, #degree], size: title_size),
          text([Matriculation number:], size: title_size), text([#matriculation_number], size: title_size),
          [],[],
          [],[],
          [],[],
          text([#first_supervisor_form:], size: title_size), text([#university_supervisor], size: title_size),
          text([#second_supervisior_form:], size: title_size), text([#second_supervisior], size: title_size),
          text([submitted], size: title_size), text([#submitted], size: title_size),
))

#pagebreak()
 

= Abstract
cite:\
@hahne_real-time_2012.\ 
#cite(<hahne_real-time_2012>, supplement: [p.~11]).\
#cite(<hahne_real-time_2012>, form: "year").\
#cite(<hahne_real-time_2012>, form: "author").\
#cite(<hahne_real-time_2012>, style: "alphanumeric") \
#cite(<hahne_real-time_2012>, style: "vancouver") \
#cite(<hahne_real-time_2012>, style: "american-physics-society")

multiple cites:\
#cite(<hahne_real-time_2012>, style: "american-physics-society") #cite(<fake_cite1>, style: "american-physics-society") #cite(<fake_cite2>, style: "american-physics-society") \
#cite(<hahne_real-time_2012>) #cite(<fake_cite1>) #cite(<fake_cite2>)

#emph[Emph text]\ 
#strong([Bold text]) \
#text([Text size], size: 7pt) \
#text([Text size], size: 10pt)\

#let text_size = 15pt
#text([Text size], size: text_size)\

math:\

When it comes to math, you use \$ you math \$:
$ mat(
  delim: "[",
  r_11, r_12, r_13, p_x;r_21, r_22, r_23, p_y;r_31, r_32, r_33, p_z;0, 0, 0, 1,
) $ \

$ X , theta , phi.alt arrow.r R G B , sigma $ \

some inline examble:

$ T(t) = exp(- integral_(t_n)^t sigma (r (s)) d s) $ Where $sigma (r(s))$ is the volume density along the ray depending on the position $r(s)$ on ray $r(t) = o + t d$. \"The Function $T(t)$ denotes the accumulated transmittance along the ray from $t n$ to $t$, i.e., the probability that the ray travels from $t n$ to $t$ without hitting any other particle." \
product:
#align(center,$T_n = product^n_(i=1) exp(-sigma_i ⋅ Delta_(s_i))$)

scripting:
#let num1 = 1
#let num2 = 2

#num1 + #num2 = #{num1 + num2}

#{
  let num3 = 1
  let num4 = 2

  let result = num1 + num2
  [#num3 + #num4 = #result]
}

#for letter in "abc nope" {
  if letter == " " {
    break
  }
  letter
}

#text([This], fill: red) #text([text], fill: gradient.radial(..color.map.rainbow)) #text([has], fill: cmyk(100%, 0%, 33%, 0%)) some #text([color], fill: rgb(255, 0%, 255))

- List1
- List2
- List3

#figure(image("images/placeholder.png", width: 20%), caption: [This Image has 20% width. You can also use other types like mm, cm, em, pt]) <fig:placeholder>
#figure(image("images/placeholder.png", width: 20em), caption: [with 20em]) 

This is a reference to the placeholder image: @fig:placeholder \
This is a reference to the implementation: @implementation \
This is a reference to the implementation with name: #ref(<implementation>, supplement: [Implementation])

#pagebreak()
table with alignment:
#align(
  figure(
    table(
        columns: 3,
        stroke: none,
        inset: 6pt,
        [#strong[Title 1]],
        [#strong[Title 1]],
        [#strong[Title 1]],
        [Column 1], [A 24324], [B 20.3412],
        [Column 2], [A 00498], [B 58.9121],
        [Column 4], [A 04195], [#highlight(fill: rgb(122, 205, 255), "B 389.1807")],
        [Column 5], [A 18757], [194.9974],
        [Column 6], [A 14663], [#highlight(fill: rgb(255, 174, 122), "B 1.6392")],

      ),
  )) <tab:my_table>

grid with variables:
#let width = 35pt
#let height = 35pt
#let text_size = 9pt

#grid(
  columns: 11,     // 2 means 2 auto-sized columns
  rows: 2,
  gutter: 2mm,    // space between columns
  image("images/placeholder.png", width: width, height: height),
  image("images/placeholder.png", width: width, height: height),
  image("images/placeholder.png", width: width, height: height),
  image("images/placeholder.png", width: width, height: height),
  image("images/placeholder.png", width: width, height: height),
  image("images/placeholder.png", width: width, height: height),
  image("images/placeholder.png", width: width, height: height),
  image("images/placeholder.png", width: width, height: height),
  image("images/placeholder.png", width: width, height: height),
  image("images/placeholder.png", width: width, height: height),
  image("images/placeholder.png", width: width, height: height),
  [Image 1], [Image 2], [Image 3],[Image 4],[Image 5],[Image 5],[Image 7],[Image 8],[Image 9],[#text([Image, 10], size: text_size)], [#text([Image, 11], size: text_size)]
)

Some Pseudocode. You need to import Lovelace for this. Typst has more libraries for pseudocode and other things.

#pseudocode-list()[
  + *Function* compute_some_stuff(a, b, list, threshold):
    + Set scale to 2.0
    + result = 0
    + *For* x in list:
      + sum list with x
      + *If* result*scale > threshold
        + return: result
      + *End If*
    + *End For*
    + return: max value from list
  + *End*
  ]

#pagebreak()

= Zusammenfassung
#lorem(500)
#pagebreak()

#set heading(numbering: "1.") // start heading numbering
#outline(depth: 4, indent: 2em) // include table of context.
#set page(numbering: "1")
#counter(page).update(1)

= Introduction <introduction>
== Depth1
=== Depth2
==== Depth3
#lorem(200)
#pagebreak()

= Related Work <related-work>
#lorem(200)
#pagebreak()

= Method <Validation>
#lorem(200)
#pagebreak()

= Implementation <implementation>
#lorem(200)
#pagebreak()

= Conclusion <conclusion>
#lorem(200)
#pagebreak()

= Discussion <discussion>
#lorem(200)
#pagebreak()

= Use of AI in this thesis <use-of-ai-in-this-thesis>
#pagebreak()

// inser bibliography is necessary.
#bibliography("references.bib", full: false, style:"apa")