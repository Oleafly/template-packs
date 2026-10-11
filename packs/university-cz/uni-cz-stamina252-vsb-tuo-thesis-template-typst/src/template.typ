#import "translations.typ": tran
#import "../meta.typ": *


// User input verifcation
#assert(
  thesis_type in ("bachelor", "master"),
  message: "Type must be \"bachelor\" or \"master\".",
)  

#assert(
  thesis_lang in ("cs", "sk", "en"),
  message: "Type must be \"cs\" or \"sk\" or \"en\".",
)



#let thesis(
  assignment: none,
  abstracts_keywords: none,
  acknowledgment: none,
  acronyms_symbols: none,
  chapters: none,
  references: none,
  appendices: none,
  show_figure_contents: false,
  show_table_contents: false,
  show_listing_contents: false,
) = {

  set page(
    supplement: none,
  )


  
  set document(
    title: thesis_title,
    author: thesis_student,
  )


  
  set text(
    lang: thesis_lang,
    font: "Latin Modern Roman", //https://www.gust.org.pl/projects/e-foundry/latin-modern,
    hyphenate: true,
    top-edge: "ascender", // Necessary for line spacing to be performed as a multiple of the row
    bottom-edge: "descender", // Necessary for line spacing to be performed as a multiple of the row
  )
  show smallcaps: set text(font: "Latin Modern Roman Caps")
  show math.equation: set text(font: "Latin Modern Math")
  
  
  set par(
    justify: true,
    first-line-indent: 1.5em,
    leading: 0.2em, // Line spacing 120%
    spacing: 1em,
  )
  
  show link: it => {
    if type(it.dest) == str { underline(it) } else { it } 
  }
  
  //show figure.caption: emph
  show figure.where(kind: image): set figure(supplement: tran.figure)
  show figure.where(kind: raw): set figure(supplement: tran.listing)
  show figure.where(kind: table): set figure(supplement: tran.table)
  show figure.where(kind: table): set figure.caption(position: top)

  // Equation library so we can reference each equation in multiline equation or chose not to.
  import "@preview/equate:0.3.2": equate
  show: equate.with()

  // Fix the gap after comma in a equation
  show math.equation: it => {
    show ",": math.class.with("normal")
    it
  }
  
  // Set the size of inline math to display
  //show math.equation: math.display


  set table(
    stroke: none,
    inset: 0.2em,
    column-gutter: 1em,
  )
  
  set table.hline(stroke: 0.5pt)

  
  /*
  set raw(
    tab-size: 2,
  )
  //show raw: set par(leading: 0.2em)
  //show raw: set text(size: 1em)
  */


  
  // Adding line at the beginning and at the end of raw in figure and making sure it sticks to the code/caption.
  show figure.where(kind: raw): it =>{
    block()[
      #block(sticky: true)[#line(length: 100%, stroke: 0.5pt)]  
      #align(left)[#it.body]
      #block(sticky: true)[#line(length: 100%, stroke: 0.5pt)]
      #it.caption
    ]
  }



  // Custom style of enumerated list.
  // Style can be set using variable styles.
  set enum(
    full: true,
    numbering: (..nums) => {
      let position = nums.pos()
      let level = position.len()
  
      let styles = ("1.", "(a)", "i.", "A.")
      let style = styles.at(calc.rem(level, styles.len()) - 1)
      
      numbering(style, position.at(level - 1))
    }, 
  )

  

  let heading_size = 24pt
  let chapter_appendix_size = 20pt
  let sub_heading_size = 15pt
  let others_heading_size = 13pt


  show heading: set text(others_heading_size, font: "Latin Modern Sans")
  show heading.where(level: 1): set text(size: heading_size)
  show heading.where(level: 2): set text(size: sub_heading_size)

  show heading: set block(above: 2em, below: 1em)
  show heading.where(level: 1): it => {
    v(3em)
    set block(below: 2em)
    it
  }

  
  // Custom style of chapter headings
  let chapter_headings(body) = {
    show heading.where(depth: 1): it =>{
      counter(figure.where(kind: table)).update(0) 
      counter(figure.where(kind: image)).update(0) 
      counter(figure.where(kind: raw)).update(0) 
      counter(math.equation).update(0) 
      
      pagebreak(weak: true)
      
      block(spacing: 0pt, above: 0pt, below: 2em)[
        #set par(
          first-line-indent: 0pt,
          spacing: 0pt, 
          leading: 0pt,
        )
        
        #set text(chapter_appendix_size)
        #v(3em)
        #it.supplement #numbering(it.numbering, counter(heading).at(it.location()).first())
        #v(1.5em)
        #text(heading_size, it.body)
      ]
    }    
    body
  }
 
  
  { // Title page
    let logo = "img/" + "VSB-TUO-FEI-logo_" + if thesis_lang == "en" {"en"} else {"cs"} + ".svg"
    
    set text(20pt, font: "Latin Modern Sans")
    set par(spacing: 0pt, first-line-indent: 0pt, leading: 0pt)
    
    place(
      image(logo, height: 30mm),
      dx: -7.9639988mm, dy: -8.9252768mm,
    )
    v(30mm - 8.9252768mm - 8.0045023mm)
    
    v(3em)
    
    text(weight: "bold", thesis_title)

    v(1.5em)
    
    text(14pt, thesis_subtitle)

    v(2em)
    
    thesis_student

    

    v(1fr)

    
    
    set text(14pt)
    
    tran.type
    
    v(1em)

    tran.supervisor_label + thesis_supervisor
    
    v(1em)
    
    "Ostrava, " + thesis_date
    pagebreak(weak: true)
  } // Title page

  
  
  { // Assignement
    for list in assignment {
      page(
        margin: 0mm,
        image(list, width: 100%),
      )
      pagebreak(weak: true)
    }
  } // Assignement

  
  
  { // Abstract Keywords and acknowledgment
    show link: underline
    set heading(outlined: false, bookmarked: false)

    // Abstract
    if abstracts_keywords != none {
      include abstracts_keywords
      pagebreak(weak: true)
    }
    
    // acknowledgment
    if acknowledgment != none {
      include acknowledgment
      pagebreak(weak: true)
    }
  } // Abstract Keywords and acknowledgment
  
  
  
  // Begin page numbering on Contest page
  set page(numbering: "1", number-align: center)
  
  { // Contents
    show outline.entry.where(level: 1): set text(weight: "bold")
    show outline.entry.where(level: 1): set block(spacing: 1.5em)
    show outline.entry.where(level: 1): set outline.entry(fill: none)
    set outline.entry(fill: pad(left: 0.2em, right: 1em, repeat(gap: 0.5em, [.])))

    show outline.entry.where(level: 1): it => {
      if it.element.func() == heading and it.element.numbering == "A.1" {
        block(
          link(
            it.element.location(),
            [#tran.appendix #it.prefix() #it.body() #h(1fr) #it.page()]
          )
        )
      } else {
        it
      }
    }

    
    outline(title: tran.contents)
    
    pagebreak(weak: true)
  } // Contents
  

  
  { // Symbols and acronyms
    if acronyms_symbols != none {
      include acronyms_symbols
      pagebreak(weak: true)
    }
  } // Symbols and acronyms
  
  
  
  { // Listings
    set outline.entry(fill: pad(left: 0.2em, right: 1em, repeat(gap: 0.5em, [.])))
    
    show outline.entry: it => {
      let prefix = it.prefix().fields().at("children").last()
      link(it.element.location(), it.indented([/*#h(1.5em)*/ #prefix], it.inner()))
    }
  
    
    context {
      let has-type(type) = query(figure.where(kind: type)).len() > 0

      if has-type(image) and show_figure_contents {
        heading(tran.list_of_figures)
        outline(title: none, target: figure.where(kind: image))
        pagebreak(weak: true)
      }

      if has-type(table) and show_table_contents {
        heading(tran.list_of_tables)
        outline(title: none, target: figure.where(kind: table))
        pagebreak(weak: true)
      }

      if has-type(raw) and show_listing_contents {
        heading(tran.list_of_listings)
        outline(title: none, target: figure.where(kind: raw))
        pagebreak(weak: true)
      }
    }
  } // Listings
  
  
  
  { // Chapters
    if chapters != none {
      let chapters_numbering = "1.1"
      set heading(numbering: chapters_numbering)
      show heading.where(depth: 1): set heading(supplement: tran.chapter)
      
      // Set the figure caption so that it contains the chapter number
      set figure(numbering: it => { 
          let count = counter(heading).get()
          numbering(chapters_numbering, count.first(), it)
        }
      )
      
      // Set the equation numbering so that it contains the chapter number
      set math.equation(
        numbering: n => numbering("(" + chapters_numbering +")", counter(heading.where(level: 1)).at(here()).first(), n)
      )

      
      chapter_headings()[
        #for chapter in chapters {
          include chapter
        }
      ]
      pagebreak(weak: true)
    }
  } // Chapters
  

  
  { // Bibliography
    if references != none {
      context {
        if query(ref).len() > 0 { 
          bibliography(references, title: tran.references, style: "iso690-numeric-brackets-cs.csl")
          //https://www.zotero.org/styles?q=iso-690
          pagebreak(weak: true)
        }
      }
    }
  } // Bibliography
  
  

  { // Appendices
    if appendices != none {
      counter(page).update(1)
      counter(heading).update(0)
      
      set page(numbering: "I")

      let appendices_numbering = "A.1"
    
      set heading(numbering: appendices_numbering)
      show heading.where(depth: 1): set heading(supplement: tran.appendix)
      
      // Set the figure caption so that it contains the chapter number
      set figure(numbering: it => { 
          let count = counter(heading).get()
          numbering(appendices_numbering, count.first(), it)
        }
      )
      
      // Set the equation numbering so that it contains the chapter number
      set math.equation(
        numbering: n => numbering("(" + appendices_numbering +")", counter(heading.where(level: 1)).at(here()).first(), n)
      )
      
      chapter_headings()[
        #for appendix in appendices {
          include appendix
        }
      ]
    }
  } // Appendices
  
}
