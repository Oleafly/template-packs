// This template was built based on 'pretty-hdm-thesis' template by Mia Rose Winter 
// Most script was generated helped by Gemini 3.0 (GPT was not good at this programming language), but always supervised by the author.

// Author: Alicia Franco-Martínez

#import "@preview/glossarium:0.5.9": make-glossary, register-glossary, print-glossary, gls, glspl
#import "@preview/showybox:2.0.1": showybox
#import "content/0_titlepage.typ": titlepage

// --- 1. UTILITY FUNCTIONS ---

// --- Empty Page Helper ---
#let empty-page() = {
  page(header: none, footer: none)[]
  pagebreak(weak: false)
}

/// QUOTE
/// Generates a dedicated page for a quote in two languages
#let quote-page(
  indentation, 
  spanish-text, 
  english-text, 
  spanish-author, 
  english-author, 
  spanish-context, 
  english-context) = {
  page(
    header: none
  )[
    #v(100pt)
    #block(inset: (left: indentation))[
      #align(right)[
        #text(style: "italic", size: 18pt)[
          #quote[#spanish-text]
        ] \ \
        *#spanish-author* #spanish-context
        
        #v(50pt)
        
        #text(fill: gray)[
          #text(style: "italic", size: 16pt)[ 
            #quote[#english-text]
          ] \ \
          *#english-author* #english-context
          
        ]
      ]
    ]
  ]
}


// Citation Settings
#set cite(style: "apa")
#set bibliography(style: "apa-no-ampersand.csl")

/// Prose citations: Author (Year)
#let prose(..keys, supp: none, paren: true, year: true, ese: false) = {
  show "&": "and"
  let citations = keys.pos()
  
  if citations.len() > 0 {
    let first-key = citations.at(0)
    
    // 1. Get author names and remove initials
    {
      show regex("\b[A-Z]\.\s?"): ""
      cite(first-key, form: "author")
    }
    
    // 2. Add possessive 's if requested
    // for example: "Gambarota et al.'s (2020) meta-analysis"
    if ese [’s]
    
    // 3. If 'year' is false, put the year after a comma
    if year {
      // Determine separator and brackets
      let (sep, start, end) = if paren {
        (" ", "(", ")")
      } else {
        (", ", "", "")
      }

      [#sep#start]

      // 4. Handle multiple years
      for (i, k) in citations.enumerate() {
        let label-str = str(k)
        let year-match = label-str.match(regex("\d{4}[a-z]?"))
        let current-year = if year-match != none { year-match.text } else { "" }
        
        if i > 0 [, ] 
        [#current-year]
      }
      
      if supp != none [; #supp]
      [#end]
    }
  }
}

/// Parentheses citations (Author, Year)
#let paren-cite(prefix: "", suffix: "", ..keys) = {
  let citations = keys.pos()
  if citations.len() > 0 [
    (#prefix#{
      // Remove initials
      show regex("\b[A-Z]\.\s?"): ""
      
      let last-author-key = ""
      
      for (i, k) in citations.enumerate() {
        let current-label = str(k)
        let current-author-key = current-label.replace(regex("\d+.*"), "")
        let year-match = current-label.match(regex("\d{4}"))
        let current-year = if year-match != none { year-match.text } else { "" }
        let letter-match = current-label.match(regex("\d{4}([a-z])"))
        let current-letter = if letter-match != none { letter-match.captures.at(0) } else { "" }

        if current-author-key == last-author-key {
          [, #current-year#current-letter]
        } else {
          if i > 0 [; ]
          cite(k, form: "author")
          [, #current-year#current-letter]
          
          last-author-key = current-author-key
        }
      }
    }#suffix)]
}

// LETTINE
/// Displays a large drop-cap letter at the start of a paragraph
#let lettrine(term) = text(size: 30pt, weight: "black", box[#term], font: "EB Garamond")

/// Converts content to a plain string
#let to-string(it) = {
  if type(it) == str { it }
  else if type(it) != content { str(it) }
  else if it.has("text") { it.text }
  else if it.has("children") { it.children.map(to-string).join() }
  else if it.has("body") { to-string(it.body) }
  else if it == [ ] { " " }
  else { "" }
}

// NOTE-BOX
/// Creates a stylized box for notes or sidebars
#let note-box(title: none, body) = {
  align(center)[
    #block(
      stroke: (left: 3pt + rgb("#735F9B"), rest: 0.5pt + rgb("#E0E0E0")), 
      radius: 2pt, 
      width: 90%, 
      fill: rgb("#FAFAFA"), 
      inset: (x: 15pt, y: 12pt),
      spacing: 1.5em
    )[
      #set align(left)
      #set par(first-line-indent: 0pt)
      
      #if title != none {
        text(fill: rgb("#735F9B"), weight: "bold", size: 1.1em)[#title]
        v(0.2em)
      }
      
      #body
    ]
  ]
}

// --- 2. THESIS FIGURE HELPER ---
#let thesis-figure(it, title: none, note: none, ..args) = {
  figure(it, caption: title, ..args)
}

// --- 3. MAIN TEMPLATE ---

#let typthesisAFM(
    metadata, 
    date, 
    // We remove specific content arguments (abstracts, bib, etc.)
    // to allow the Main file to control the flow via includes.
    content 
) = {
    let data = metadata.data
    let layout = metadata.layout

    // --- GLOBAL TEXT SETTINGS ---
    set text(lang: metadata.lang, font: layout.fonts.body, size: 12pt)
    set par(leading: 0.8em, spacing: 1.5em, justify: true, first-line-indent: 2em)
    show link: set text(fill: blue)
    show link: underline

    // --- FIGURE NUMBERING RULE ---
    show figure: it => {
      set align(center)
      v(3em, weak: true)
      block(width: 100%, breakable: false)[
        #if it.has("caption") {
          set align(left)
          context {
            // 1. Get current chapter number
            let chap-counter = counter(heading).at(it.location())
            let chap = if chap-counter.len() > 0 { chap-counter.at(0) } else { 0 }
            
            // 2. Count ONLY figures that are strictly BEFORE this location
            let all-figs-before = query(figure.where(kind: it.kind).before(it.location(), inclusive: false))
            
            let figs-in-this-chap = all-figs-before.filter(f => {
              let f-chap = counter(heading).at(f.location()).at(0, default: 0)
              f-chap == chap
            })
            
            // Now, if it's the first one, figs-in-this-chap.len() will be 0, so 0 + 1 = 1.
            let fig-idx = figs-in-this-chap.len() + 1
            text(weight: "bold")[#it.supplement #chap.#fig-idx]
          }
          linebreak()
          emph(it.caption.body)
        }
        #it.body
      ]
      v(3em, weak: true)
    }

    // --- EQUATION NUMBERING RULE ---
    show math.equation.where(block: true): it => {
      context {
        let loc = it.location()
        let chap = counter(heading).at(loc).at(0, default: 0)
        
        // Query equations before this one in the same chapter
        let all-prev = query(selector(math.equation.where(block: true)).before(loc, inclusive: true))
        let in-chap = all-prev.filter(e => counter(heading).at(e.location()).at(0, default: 0) == chap)
        let eq-idx = in-chap.len()
        
        let num = [(#chap.#eq-idx)]
        
        // We use a grid to layout, but we must disable the show rule 
        // for the equation body inside to avoid recursion.
        grid(
          columns: (1fr, auto),
          align: (center, bottom + right),
          {
            set math.equation(numbering: none) // Prevents recursion
            it.body
          },
          num
        )
      }
    }

    // --- FOOTNOTE RULES ---
    // Label in the text (the superscript)
    show footnote: it => {
      context {
        let loc = it.location()
        let chap = counter(heading).at(loc).at(0, default: 0)
        let all-prev = query(selector(footnote).before(loc, inclusive: true))
        let in-chap = all-prev.filter(f => counter(heading).at(f.location()).at(0, default: 0) == chap)
        
        let fn-idx = in-chap.len()
        super[#chap.#fn-idx]
      }
    }
    
    // Entry at the bottom
    show footnote.entry: it => {
      context {
        let loc = it.location()
        let chap = counter(heading).at(loc).at(0, default: 0)
        let all-prev = query(selector(footnote).before(loc, inclusive: true))
        let in-chap = all-prev.filter(f => counter(heading).at(f.location()).at(0, default: 0) == chap)
        
        let fn-idx = in-chap.len()
        
        // Wrap in a block to ensure it respects the parent width (margins)
        block(width: 96%)[
          // Reset indentation so the footnote text doesn't start with a 2em gap
          #set par(first-line-indent: 0pt, hanging-indent: 0em) 
          #stack(dir: ltr, spacing: 0em,
            [#chap.#fn-idx.], 
            it.note.body
          )
        ]
      }
    }

    // --- REF NUMBERING RULE ---
    show ref: it => {
      let eq = it.element
      if eq != none and eq.func() == figure {
        context {
          // 1. Get the chapter number of the referenced element
          let chap-counter = counter(heading).at(eq.location())
          let chap = if chap-counter.len() > 0 { chap-counter.at(0) } else { 0 }
          
          // 2. Get the figure index within that specific chapter
          let all-figs-before = query(figure.where(kind: eq.kind).before(eq.location(), inclusive: true))
          let figs-in-this-chap = all-figs-before.filter(f => {
            let f-chap = counter(heading).at(f.location()).at(0, default: 0)
            f-chap == chap
          })
          
          let fig-idx = figs-in-this-chap.len()
          
          // 3. Return the formatted reference
          // We wrap the link and explicitly disable underlining for this specific instance
          show link: set underline(stroke: 0pt)
          link(eq.location())[#eq.supplement #chap.#fig-idx]
        }
      } else {
        it // For non-figure references, keep default behavior
      }
    }

    // --- HEADING STYLES ---
    show heading.where(level: 1): it => {
      // RESET COUNTERS FOR EACH CHAPTER
      counter(figure.where(kind: image)).update(0)
      counter(figure.where(kind: table)).update(0)
      counter(math.equation).update(0)
      counter(footnote).update(0) 
      
      if it.numbering == none {
        set text(font: "EB Garamond", size: 24pt, weight: "bold")
        v(2em)
        it.body
        v(1em)
      } else {
        let raw = to-string(it.body)
        let parts = raw.split(":")
        let title = parts.at(0, default: raw)
        let subtitle = parts.at(1, default: "")
        pagebreak(weak: true)
        v(1em)
        align(right)[
          #box(inset: (y: 25pt, x: 15pt), fill: rgb("#333333"), radius: 1pt)[
            #scale(y: 150%)[ 
              #text(font: "EB Garamond", size: 40pt, weight: "bold", fill: white)[
                #context counter(heading).display() 
              ]
            ]
          ]
          #v(-40pt)
          #text(font: "EB Garamond", fill: rgb("#333333"), size: 45pt, tracking: -1pt)[#title]
          #if subtitle != "" {
            v(-50pt)
            text(font: "EB Garamond", fill: rgb("#333333"), size: 26pt, tracking: -1pt)[#subtitle]
          }
        ]
        v(-1em)
      }
    }
    
    // --- BOLD LEVEL 1 IN OUTLINE ---
    show outline.entry.where(level: 1): it => {
      v(2em, weak: true)
      strong(it)
    }

    // Level 2 (Acts like APA Level 1): Centered, Bold
    show heading.where(level: 2): it => {
      set align(center)
      set text(font: "EB Garamond", size: 20pt, weight: "bold")
      v(1.5em, weak: true)
      it.body
      v(1em, weak: true)
    }

    // Level 3 (Acts like APA Level 2): Flush Left, Bold
    show heading.where(level: 3): it => {
      set align(left)
      set text(font: "EB Garamond", size: 15pt, weight: "bold")
      v(1.2em, weak: true)
      it.body
      v(0.8em, weak: true)
    }

    // Level 4 (Acts like APA Level 3): Flush Left, Bold Italic
    show heading.where(level: 4): it => {
      set align(left)
      set text(font: "EB Garamond", size: 14pt, weight: "bold", style: "italic")
      v(1em, weak: true)
      it.body
      v(0.6em, weak: true)
    }
    show heading: set par(first-line-indent: 0pt)
    
    // --- FRONT MATTER (REQUIRED) ---
    // We only force the title page and metadata here.
    // All other content (Declarations, Acknowledgements, etc.) 
    // should be included in 'main.typ' to allow custom ordering.
   
    set document(title: data.title, author: data.authors.map(a => a.Name).join(", "), date: date)
    titlepage(metadata)

    // --- PAGE HEADERS & FOOTERS ---
    set page(header: context {
      let current-page = here().page()
      // Skip headers on the first two pages (Title page, etc.)
      if current-page > 2 {
        set text(10pt, fill: rgb("#888888"))
        
        // Find the current Level 1 heading for this page
        let h-on-pg = query(heading.where(level: 1)).filter(h => h.location().page() == current-page)
        let h-before = query(heading.where(level: 1).before(here()))
        let target = if h-on-pg.len() > 0 { h-on-pg.first() } else if h-before.len() > 0 { h-before.last() } else { none }

        if target != none {
          let num = counter(heading).at(target.location()).first()
          let title = to-string(target.body).split(":").at(0)
          let is-outline = (title == "Contents")
          
          // --- HEADER LOGIC ---
          // If the heading has numbering enabled (e.g., Chapter 1, 2...), show "Chapter #"
          if target.numbering != none and num > 0 {
            [Chapter #num: #title]
          } else {
            // For unnumbered headings (References, Glossary, etc.), show only the page number
            []
          }
          
          // Align page number to the right
          h(1fr)
          if not is-outline { counter(page).display("1") }
          
          // Decorative line
          v(-4pt)
          line(length: 100%, stroke: 0.5pt + rgb("#AAAAAA"))
        }
      }
    },
    footer: context {
      let current-page = here().page()
      if current-page > 2 {
        line(length: 100%, stroke: 0.5pt + rgb("#AAAAAA"))
        // You can add footer text here if needed
      }
    })

    // --- SETUP COUNTERS ---
    counter(page).update(1)
    set heading(numbering: "1.1")
    set figure(numbering: "1.1")
    set footnote(numbering: "1.1")
    set math.equation(numbering: "(1.1)") 

    // --- RENDER MAIN CONTENT ---
    // This is where all your #includes from main.typ will appear
    content

}