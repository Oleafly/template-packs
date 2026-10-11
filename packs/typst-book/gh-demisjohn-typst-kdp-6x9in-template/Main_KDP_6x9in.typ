#import "template_KDP_6x9in_en_v1.typ": *  // main template
#import "functions.typ": *  // utility functions

#show: book.with(
  title: "Book Title", 
  author: "First M. Surame",
  year: "2026",
  copyrightfile: none, // set to "Copyright.typ" if desired
  isbn: none, // set to ISBN if desired
)

/*
Options in this Template.
- copyrightfile: default `none`, accepts filepath to .typ file
  if set to `none`, a default copyright page is used.
  If set to a file such as "Copyright.typ", that will be used as the Copyright page.

- isbn: default `none`, accepts an ISBN string
  if set to `none`, no ISBN is displayed on the copyright page.
  If set to an ISBN such as "978-3-16-148410-0", that will be displayed on the copyright page.



*/


// Page numbering
#set page(numbering: "i")
#counter(page).update(1) 

//--- Table of Contents
#outline(
  title: block(below: 1em)[Contents]
)
#pagebreak()

#context {
  set par(leading: 1.5 * par.leading)
  outline(
    target: figure.where(kind: image)
      .or(figure.where(kind: table))
      .or(figure.where(kind: "nocaption")),
    title: block(below: 1em)[List of Figures and Tables]
  )
}

#pagebreak()

// ensure one right-side blank page
// wrap in new scope to remove header/footer:
#{  
  //set page(numbering: none)
  set page(header: none, footer: none)

  pagebreak(to: "odd") // makes sure next page is on right-side; adds blank page if needed.
  set page(header: none, footer: auto)
  [
  = Acknowledgments <unnumbered>

  Massive thanks to #link("https://typst.app")[Typst.app] and #link("https://pandoc.org")[pandoc] for saving me when my large #link("https://www.libreoffice.org")[LibreOffice] files started getting corrupt!

  ]
}


// Page numbering for main matter
#set page(numbering: "1")
#counter(page).update(1) // reset page numbering


/*  Optionally insert chapters as separate files like so:

// Chapter 1: Introduction:
#include "Chapter1-Intro.typ"
// Chapter 2: 
#include "Chapter2.typ"

Each file will need an 
  #import "functions.typ": * 
At the top if youre using this separate functions file.
*/



= What is This Book?
Insert chapter one text here... #lorem(200)

== Why Typst?
#lorem(150)

=== What about LaTeX
#lorem(150)

#figure(
  image("./media_demo/Otter.jpg", width: 80%),
  caption: flex-caption(
    [
      Otters float on their backs, being postively adorable when eating in this fashion. Note that this caption is too long to inlcude in the List of Figures. #footnote["_The golden years_" by Mark Fischer, licensed under CC BY 2.0 via Wikimedia Commons.]
    ],
    [Otter LOF entry]
  )
)

#lorem(50)


= Typst: The New LaTeX

#lorem(100)

#figure(
  table( //align: left, fill: gray,
    columns: (auto, auto, auto, auto),

    table.header( 
  [Phase], 
  [Parameters], 
  [Run 1], 
  [Run 2]),

[Preparation],
[Preheat system, 5~min],
[$sqrt("")$],
[$sqrt("")$],

[Primary Process\ 
  Equipment: System A],
[Material: Sample-A\ 
  Speed 1000~rpm\ 
  60~sec],
[$sqrt("")$],
[$sqrt("")$],

[Thermal Treatment\ 
  Equipment: Oven 1],
[100⁰C, 5~min],
[$sqrt("")$],
[$sqrt("")$],

[Optical Inspection\ 
  Equipment: Scanner X],
[
  Scan duration: 15~sec\
  Mode: Standard ],
[$sqrt("")$],
[_calibration error,\ signal low.\ On HOLD_],

[Final Clean\ 
  Equipment: Wash Station],
[
  Solution: Neutral\
  45~sec\
  Rinse 2~min\
  Air dry 1~min ],
[$sqrt("")$],
[],

  ),
  caption: flex-caption(
    [An example table of with a long-ish caption that you wouldn't want inserted into the List of Figures/Tables.
    ],
    [Example Table]
  ),
  kind: table,
)

#lorem(200)

#figure(
    grid(
        columns: 2,     // 2 means 2 auto-sized columns
        gutter: 2mm,    // space between columns
        image(
          "./media_demo/Rabbit.jpg", 
          height: 2in,
        ), 
        image(
          "./media_demo/Puffin.jpg", 
          height: 2in,
        ),
    ),
    caption: flex-caption(
      [
      A bunny (left) 
      #footnote[Domestic-rabbit-Lilly-washing-0a by JJ Harrison, licensed under CC BY-SA 3.0 via Wikimedia Commons.] 
      and a birdie (right) 
      #footnote[Image credit: "Puffin (Fratercula arctica)" by Charles J. Sharp, 2021, available on Wikimedia Commons, licensed under CC BY-SA 4.0.].
      If we didn't use `flex-caption` here, the footnotes would also appear in the List of Figures!
      ],
      [Bunnies and Birdies]
    ) 
)

#lorem(100)



/*-------------------------
   Back Matter
-------------------------*/


// -----------------------------
//  About the Author

#{  // wrap in new scope to remove header/footer
  set page(header: none, footer: none)

  pagebreak(to: "odd") // makes sure next page is on right-side; adds blank page if needed.
[
  = About the Author <unnumbered>

  #link("https://www.amazon.com/stores/Demis-D.-John-Ph.D/author/B0HFHQRR68?shoppingPortalEnabled=true&ccs_id=d5af568d-a7ef-469a-8040-4aa8a10bce3c")[*Demis D. John*] made this Typst template for the #link("https://a.co/d/06phvGge")[Amazon KDP printed softcover book _linked here_], using Gemini to generate the initial template, and subsequently many modifications to tailor it.  Major manual modifications included the functions.typ file containing utility functions, Table of Contents and List of Figures (with combined Tables) logic, copyright page, and tons of work to fix headings formatting, page numbering for front/back-matter, and allowing the List of Figures to include "short names" instead of the full caption going into the LOF.
  ]
}


