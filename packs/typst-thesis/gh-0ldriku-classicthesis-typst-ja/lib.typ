// V0.0.1
// --- Marginalia Package ---
#import "config.typ": *
#import "@preview/marginalia:0.3.0" as marginalia: notefigure as _notefigure, wideblock
#import "@preview/marginalia:0.3.0": note as _note // margin note
#import "@preview/zero:0.5.0": * // Advanced scientific number formatting.
#import "@preview/gentle-clues:1.2.0": * // text box
#import "@preview/glossarium:0.5.9": gls, glspl, Gls, Glspl // abbreviations
#import "@preview/codly:1.3.0": * // code block
#import "@preview/codly-languages:0.1.1": * // code block
#import "@preview/cjk-unbreak:0.2.1": remove-cjk-break-space// 改行すると半角スペース入ってしまう問題を解決するため。Maybe this will be solved in future. See https://github.com/typst/typst/pull/7350 for more information.


// =========================================================================
// CITATION & BIBLIOGRAPHY SETTINGS
// =========================================================================

// --- Option A: Default (APA 7th + JPA 2022) ---
// This uses the customized local version located in the 'src' folder.
// If you want to use IEEE or SIST 02, COMMENT OUT the following two lines:
#import "src/biblib.typ": *
#import bib-setting-apa: *


// --- Option B: Standard Styles (IEEE or SIST 02) ---
// To use these, comment out the Option A lines above, and UNCOMMENT the 
// lines below. You must also comment out the 'src' import above.

// 1. Import the standard package
// #import "@preview/enja-bib:0.1.0": *

// 2. Choose your style (Uncomment ONE):
// #import bib-setting-plain: * // IEEE-like style
// #import bib-setting-jsme: * // SIST 02 style
// See https://github.com/tkrhsmt/enja-bib for more information.
// =========================================================================


  //font-math: "New Computer Modern Math",
// --- Fonts ---
//Use this if you want the latin word also in Noto.
//#let font_serif = ("nserif","Noto Serif CJK JP")
//#let font_sans = ("nsans", "Noto Sans CJK JP")
//=========================================================================
#let font_serif = ("New Computer Modern","Noto Serif CJK JP")
#let font_sans = ("New Computer Modern Sans", "Noto Sans CJK JP")
#let font_mono = ("Cascadia Mono", "Noto Sans Mono CJK JP")
#let font_num = "TeX Gyre Pagella"
#let font_math = "New Computer Modern Math"
#let font_serif_jp = ("Noto Serif CJK JP")
#let font_sans_jp = ("Noto Sans CJK JP")


// Helper to extract text from content
#let get-text(content) = {
  if type(content) == str {
    content
  } else if content.has("text") {
    content.text
  } else if content.has("children") {
    content.children.map(get-text).join("")
  } else if content.has("body") {
    get-text(content.body)
  } else {
    ""
  }
}

// Helper to summarize text (max 50 chars)
#let summarize(content) = {
  let s = get-text(content).trim()
  // Use clusters() to handle Unicode (CJK) characters correctly
  // slicing string directly checks byte boundaries which fails for wide chars
  let chars = s.clusters()
  if chars.len() > 50 {
    chars.slice(0, 50).join() + "..."
  } else {
    s
  }
}

// Customize note styling (9pt, sans, no indent)
#let note(body, ..args) = {
  let summary = summarize(body)
  if summary == "" { summary = "Note" }
  [#metadata((kind: "note", summary: summary)) <todo_item>]
  _note(
    text-style: (size: 9pt, font: font_sans, weight:"light"),
    par-style: (first-line-indent: 0pt),
    ..args,
    body
  )
}
#let notefigure = _notefigure.with(
  text-style: (size: 9pt, font: font_sans, weight:"light"),
  par-style: (first-line-indent: 0pt)
)

#let todo(body, done: false) = {
  let summary = summarize(body)
  if summary == "" { summary = "Item" }
  [#metadata((kind: "todo", summary: summary, done: done)) <todo_item>]

  if not done {
    _note(
      text-style: (size: 9pt, font: font_sans, weight: "light", fill: black),
      par-style: (first-line-indent: 0pt),
      block(
        fill: todo_fill,
        stroke: todo_stroke,
        inset: 0.5em,
        radius: 4pt,
        [ToDo:#h(0.25em)] + body
      )
    )
  }
}

// --- Global Counters (NEW) ---
#let part_counter = counter("part")
#let in_appendix = state("in_appendix", false)

// --- Content marker for blank page detection ---
#let content_marker() = [#metadata("page-has-content") <page-content>]

// --- Appendix Init ---
#let appendix_init(body) = {
  in_appendix.update(true)
  counter(heading).update(0)
  set heading(numbering: "A.1")
  // Exclude all appendix headings level 2+ from ToC
  show heading.where(level: 2): set heading(outlined: false)
  show heading.where(level: 3): set heading(outlined: false)
  show heading.where(level: 4): set heading(outlined: false)
  body
}

// --- equation ---
#let equation(body) = {
  set heading(numbering: "1.1")
  
  set math.equation(numbering: n => {
    let chapter = counter(heading).get().first()
    numbering("(1.1)", chapter, n)
  })
  
  show heading.where(level: 1): it => {
    counter(math.equation).update(0)
    it
  }
  
  show ref: it => {
    let el = it.element
    if el != none and el.func() == math.equation {
      let loc = el.location()
      let chapter = counter(heading).at(loc).first()
      let eq = counter(math.equation).at(loc).first()
      [式 #link(loc)[#numbering("1.1", chapter, eq)]]
    } else {
      it
    }
  }
  
  body
}

// --- Custom Outline (No Forced Page Break) ---
#let nof_break_outline(target: figure, title: "List of Figures") = {
  context {
    let elems = query(target)
    if elems.len() > 0 {
      // Manually place a heading that looks like Level 1 but doesn't trigger the pagebreak rule
      block([
        #content_marker()
        #set text(font: font_serif_jp, weight: "bold", size: 20pt)
        #title
      ])
      v(0.3em)
      line(length: 100%, stroke: 0.4pt)
      v(10mm)
      
      outline(target: target, title: none)
    }
  }
}

// --- Clear Double Page (Blank Page with No Header) ---
#let cleardoublepage() = {
  pagebreak(weak: true, to: "odd")
}


// Custom gloss function for table-like display with back-references

#import "@preview/glossarium:0.5.9": get-entry-back-references


#let custom-print-gloss(entry, show-all: false, disable-back-references: false, user-print-back-references: none, ..args) = context {
  let back-refs = get-entry-back-references(entry)
  
  // Deduplicate page references (same page shows only once)
  let seen-pages = ()
  let unique-refs = ()
  for ref in back-refs {
    let page-num = if ref.has("body") { 
      if ref.body.has("text") { ref.body.text } else { repr(ref.body) }
    } else { repr(ref) }
    if page-num not in seen-pages {
      seen-pages.push(page-num)
      unique-refs.push(ref)
    }
  }
  
  let refs-str = if unique-refs.len() > 0 { unique-refs.join(", ") } else { [] }
  
  // Two column layout: abbreviation (fixed), then long + refs flowing together
  grid(
    columns: (6em, 1fr),
    column-gutter: 1em,
    row-gutter: leadingvalue,  // Match ToC spacing
    [#entry.short],
    // Long form followed by page refs, with hanging indent for wrapped lines
    // Ensure at least 2em space between long form and page refs
    par(hanging-indent: 2em, first-line-indent: 0em)[
      #entry.long #h(2em) #h(1fr) #refs-str
    ]
  )
}


// --- Custom Main Outline ---

// --- PART FUNCTION ---
// Usage in document: #part("Foundations")
#let part(title) = {
  
  // 2. Create a scoped page just for the Part title
  page(margin: 30mm, header: none, footer: none)[
    
    // Center alignment
    #set align(center + horizon)
    
    // 3. Increment Counter
    #part_counter.step()
    
    // 4. Visual Styles
    // CHANGED: font_sans -> font_serif
    #set text(font: font_serif_jp, weight: "medium", fill: black)
    
    // "Part I" (Size 20pt)
    // ADDED: weight: "medium" here protects "Part I" from your global regex
    #text(font: font_serif_jp, size: 16pt, weight: "bold")[第 #context part_counter.display("I")部]
    
    #v(2em)
    #set text(font: font_serif_jp, weight: "bold", fill: cmyk(100%, 82%, 8%, 16%))

    // "Title" (Size 34pt)
    // "Title" (Size 34pt)
    #text(size: 24pt)[#title]

    // 5. Inject into Outline (Table of Contents)
    // Moved inside page to prevent spilling to next page
    #show heading: it => it.body 
    #context {
      let p_num = part_counter.get().first()
      let p_str = numbering("I", p_num)
      place(hide([#heading(level: 1, numbering: none, outlined: true)[ #p_str  #title] <part-entry>]))
    }
  ]
}
// --- Header/Footer Logic ---

#let fancy_header = context {
  let physical_page = here().page()
  
  // Check for content (Headings or Markers)
  let has_heading = query(heading).filter(h => h.location().page() == physical_page).len() > 0
  let has_marker = query(<page-content>).filter(m => m.location().page() == physical_page).len() > 0
  let has_entry = query(outline.entry).filter(e => e.location().page() == physical_page).len() > 0
  
  if not has_heading and not has_marker and not has_entry {
    return none
  }

  let page_num = counter(page).get().first()
  let is_odd = calc.odd(physical_page)
  
  set text(font: font_serif_jp, size: 9pt)

  // Check if this is a chapter title page
  let h1_on_page = query(heading.where(level: 1))
    .filter(h => h.location().page() == physical_page)
  
  if h1_on_page.len() > 0 {
    none
  } else {
    // Get the current chapter heading
    let h1 = heading.where(level: 1)
    let h1last = query(h1.before(here())).at(-1, default: none)
    let h1next = query(h1.after(here())).at(0, default: none)
    if h1next != none and h1next.location().page() == physical_page { h1last = h1next }
    
    let chapter_title = if h1last != none { h1last.body } else { "" }
    
    // Check if this is an unnumbered chapter (bibliography, etc.)
    let is_unnumbered = h1last != none and h1last.numbering == none
    
    // Check if this is an appendix (A.1 numbering)
    let is_appendix_chapter = h1last != none and h1last.numbering == "A.1"
    
    if is_unnumbered {
      // Unnumbered chapters (Bibliography, etc.): Show title only on BOTH odd and even pages
      if is_odd {
        align(right)[
          #chapter_title
          #box(width: 0pt)[#move(dx: 2em)[#page_num]] 
        ]
      } else {
        align(left)[
          #box(width: 0pt)[#move(dx: -2em)[#page_num]]
          #chapter_title
        ]
      }
    } else if is_odd {
      // Odd Page (Right): [Section Title] [Number hanging right]
      let h2 = heading.where(level: 2)
      let h2last = query(h2.before(here())).at(-1, default: none)
      let h2next = query(h2.after(here())).at(0, default: none)
      if h2next != none and h2next.location().page() == physical_page { h2last = h2next }

      // Check if the section belongs to the current chapter
      // Get chapter number at this section's location and compare to current chapter
      let h2_belongs_to_current_chapter = if h2last != none and h1last != none {
        let h2_chap_num = counter(heading).at(h2last.location()).at(0, default: -1)
        let h1_chap_num = counter(heading).at(h1last.location()).at(0, default: -2)
        h2_chap_num == h1_chap_num
      } else {
        false
      }

      let section_info = if h2last != none and h2_belongs_to_current_chapter {
         if is_appendix_chapter {
           // Appendix sections: Use A.1 format
           let num = counter(heading).at(h2last.location())
           if num.len() >= 2 {
             let chap_letter = numbering("A", num.at(0))
             let sec_num = num.at(1)
             [#chap_letter.#sec_num #h(0.5em) #h2last.body]
           } else {
             h2last.body
           }
         } else {
           let num = counter(heading).at(h2last.location())
           if num.len() > 0 {
             [#num.map(str).join(".") #h(0.5em) #h2last.body]
           } else {
             h2last.body
           }
         }
      } else if h1last != none {
         // No section in current chapter - show chapter title instead
         if is_appendix_chapter {
           let num = counter(heading).at(h1last.location())
           if num.len() > 0 {
             let chap_letter = numbering("A", num.first())
             [#chap_letter. #h(0.5em) #chapter_title]
           } else {
             chapter_title
           }
         } else {
           let num = counter(heading).at(h1last.location())
           if num.len() > 0 {
             [#num.first(). #h(0.5em) #chapter_title]
           } else {
             chapter_title
           }
         }
      } else {
         ""
      }
      
      // Align Right
      align(right)[
        #section_info
        #box(width: 0pt)[#move(dx: 2em)[#page_num]] 
      ]

    } else {
      // Even Page (Left): [Number hanging left] [Chapter Title]
      
      // Align Left
      align(left)[
        #box(width: 0pt)[#move(dx: -2em)[#page_num]]
        #if h1last != none {
           let num = counter(heading).at(h1last.location())
           if num.len() > 0 {
             if is_appendix_chapter {
               // Appendix: Use letter numbering (A. B. C.)
               let chap_letter = numbering("A", num.first())
               [#chap_letter. #h(0.5em) #chapter_title]
             } else {
               [#num.first(). #h(0.5em) #chapter_title]
             }
           } else {
             chapter_title
           }
        } else {
           chapter_title
        }
      ]
    }
  }
}

#let fancy_footer = context {
  let physical_page = here().page()
  
  // Check for content (Headings or Markers)
  let has_heading = query(heading).filter(h => h.location().page() == physical_page).len() > 0
  let has_marker = query(<page-content>).filter(m => m.location().page() == physical_page).len() > 0
  let has_entry = query(outline.entry).filter(e => e.location().page() == physical_page).len() > 0
  
  if not has_heading and not has_marker and not has_entry {
    return none
  }

  let page_num = counter(page).get().first()
  let is_odd = calc.odd(physical_page)
  
  let h1_on_page = query(heading.where(level: 1))
    .filter(h => h.location().page() == physical_page)
  
  if h1_on_page.len() > 0 {
    set text(font: font_serif_jp, size: 9pt)
    // Odd -> Right, Even -> Left
    if is_odd {
      align(right)[#page_num]
    } else {
      align(left)[#page_num]
    }
  } else {
    none
  }
}

#let plain_footer = context {
  let physical_page = here().page()
  let is_odd = calc.odd(physical_page)
  
  let has_heading = query(heading).filter(h => h.location().page() == physical_page).len() > 0
  let has_marker = query(<page-content>).filter(m => m.location().page() == physical_page).len() > 0
  let has_entry = query(outline.entry).filter(e => e.location().page() == physical_page).len() > 0
  
  if not has_heading and not has_marker and not has_entry {
    return none
  }
  
  set text(font: font_serif_jp, size: 9pt)
  // Odd -> Right, Even -> Left
  if is_odd {
    align(right)[#counter(page).display()]
  } else {
    align(left)[#counter(page).display()]
  }
}


// --- Helpers ---


#let noteil(title: "Note", icon: emoji.lightbulb, done: false, ..args) = {
  let body = args.pos().at(0, default: none)
  let summary_content = if body != none { body } else { title }
  let summary = summarize(summary_content)
  [#metadata((kind: "noteil", summary: summary, done: done)) <todo_item>]
  if not done {
    clue(
      // Define default values.
      accent-color: rgb("FFD700"),
      title: title,
      icon: icon,
      // Pass along all other arguments
      ..args
    )
  }
}


#let todoil(title: "Todo", icon: emoji.page.pencil, done: false, ..args) = {
  let body = args.pos().at(0, default: none)
  let summary_content = if body != none { body } else { title }
  let summary = summarize(summary_content)
  [#metadata((kind: "todoil", summary: summary, done: done)) <todo_item>]
  if not done {
    clue(
      // Define default values.
      accent-color: orange,
      title: title,
      icon: icon,
      // Pass along all other arguments
      ..args
    )
  }
}




#let feedback(body, done: false, ..args) = {
  let response = args.pos().at(0, default: none)
  counter("feedback").step()
  context {
     let t = counter("feedback").get().first()
     let summary = summarize(body)
     [#metadata((kind: "feedback", summary: summary, done: done)) <todo_item>]
  }
  if not done {
    clue(
      accent-color: rgb("#FF5555"),
      title: context (counter("feedback").display() + ". Feedback"),
      icon: emoji.quest,
    )[
      #body
      #if response != none {
        line(length: 100%, stroke: 0.5pt + rgb("#FF5555"))
        [Response: #response]
      }
    ]
  }
}

#let unnumbered_chapter(title) = {
  heading(level: 1, numbering: none, outlined: false, title)
}

// no-leading zero
#let no-lead(val) = {
  let s = str(val)
  if s.starts-with("0.") { s = s.slice(1) }
  math.equation(s) 
}

// --- Subfigure Helper ---
#let subfigure(body, label) = {
  stack(
    body,
    v(1em),
    align(center)[#text(font: font_sans, weight: "light")[#label]]
  )
}

// --- Main Project Function ---

#let project(
  title: "",
  author: "",
  body,
) = {
  let ct_title = cmyk(100%, 82%, 8%, 16%)
  let ct_citation = rgb(0, 128, 0)
  let ct_url = cmyk(100%, 82%, 8%, 16%)
  let ct_link = cmyk(100%, 50%, 0%, 0%)

  set document(author: author, title: title)
  
  set text(
    font: font_serif, 
    size: 11pt,
    lang: "ja",
    fill: black,
    hyphenate: true,
    overhang: true,
  )

  // English hyphenation for Latin script text.
  // Rarely needed — template is designed for Japanese.
  // WARNING: Enabling breaks PDF click-to-source navigation.
  //show regex("[A-Za-z\u0080-\u00FF\u0100-\u017F''\-]+(\s+[A-Za-z\u0080-\u00FF\u0100-\u017F''\-]+)*"): set text(lang: "en", hyphenate: true)

  show link: set text(fill: ct_link)
  show raw: set text(font: font_mono)
  show math.equation: set text(font: font_math)
  // --- Codly Code Block Styling ---
  show: codly-init.with()
  codly(languages: codly-languages)
  // Do not hyphenate headings
  show heading: set text(hyphenate: false)

  show ref: it => {
    if it.element != none {
      if it.element.func() == figure {
        let loc = it.element.location()
        let is_table = it.element.kind == table
        let supplement = if it.supplement != auto { it.supplement } else { if is_table { "表" } else { "図" } }
        
        let chap = counter(heading).at(loc).first()
        let fig_num = it.element.counter.at(loc).first()
        let num = str(chap) + "." + str(fig_num)
        
        link(it.target)[#text(fill: black)[#supplement]#text(fill: ct_link)[#num]]
      } else if it.element.func() == heading {
        let loc = it.element.location()
        if it.element.level == 1 {
           let num = counter(heading).at(loc).first()
           link(it.target)[#text(fill: black)[第]#text(fill: ct_link)[#str(num)]#text(fill: black)[章]]
        } else {
           if it.element.numbering != none {
             let num = numbering(it.element.numbering, ..counter(heading).at(loc))
             link(it.target)[
               #text(fill: black)[§]~#text(fill: ct_link)[#num]
             ]
           } else {
             it
           }
        }
      } else {
        it
      }
    } else {
      it
    }
  }

  // --- Content Marker Injection ---
  show par: it => { content_marker(); it }
  show figure: it => {
    content_marker()
    if it.kind == "bib" {
      return it
    }
    
    context {
      // Determine prefix and number
      let is_table = it.kind == table
      let prefix = if is_table { "表" } else { "図" }
      
      let num = if it.numbering != none {
        numbering(it.numbering, ..it.counter.at(here()))
      } else {
        none
      }
      
      // Construct Caption
      let caption_content = if it.has("caption") and it.caption != none {
         set text(font: font_sans_jp, size: 11pt)
         let caption_body = if it.caption.has("body") { it.caption.body } else { it.caption }
         grid(
           columns: (auto, auto),
           gutter: 1em,
           text(weight: "medium")[#prefix#num],
           text(weight: "light")[#caption_body]
         )
      } else { none }
  
      // Layout
      if is_table {
         // Table: Caption Top
         v(1em) // Space before table caption
         block(breakable: false)[
           #set align(center)
           #if caption_content != none {
             block(caption_content)
             v(0.5em)
           }
           #it.body
         ]
         v(1em) // Space after table
      } else {
         // Figure: Caption Bottom
         block(breakable: false)[
           #set align(center)
           #it.body
           #if caption_content != none {
             v(0.5em)
             block(caption_content)
           }
         ]
         v(1em) // Space after figure
      }
    }
  }
  show list: it => { content_marker(); it }
  show enum: it => { content_marker(); it }
  show table: it => { content_marker(); it }
  
  // --- Equation Spacing (LaTeX-like) ---
  // Similar to LaTeX's abovedisplayskip and belowdisplayskip
  show math.equation.where(block: true): it => {
    v(leadingvalue)
    it
    v(leadingvalue)
  }
  

  // --- ToC Customization ---
  // Tighter line spacing for ToC
  show outline: set par(leading: leadingvalue, spacing: spacingvalue)
  
  show outline.entry: it => {
    let ct_title = cmyk(100%, 82%, 8%, 16%)

    // Helper to get linked page number
    let page_link = {
      let loc = it.element.location()
      let p_num = counter(page).at(loc).first()
      link(loc, str(p_num))
    }

    if it.element.func() == heading {
      if it.level == 1 {
        // --- Level 1 (Part or Chapter) ---
        
        // Check if it's a Part (based on label)
        let is_part = it.element.has("label") and it.element.label == <part-entry>
        
        if is_part {
           // PART Style
           v(1.5em) // Larger space before
           set align(left)
           set text(font: font_serif, weight: "bold", size: 12pt, fill: ct_title)
           
           // Ensure -1em indent
           h(-1em)
           it.element.body
           
           // Check if this is an Appendix Part (付録)
           let body_text = if it.element.body.has("text") { it.element.body.text } else { repr(it.element.body) }
           let is_appendix_part = body_text.contains("付録") or body_text.contains("Appendix")
           
           if is_appendix_part {
              v(-0.5em)  // Less space after appendix Part (brings first appendix closer)
           } else {
              v(-leadingvalue) // Normal space after regular Parts
           }
           
           // No page number for Parts
        } else {
           // CHAPTER Style
           v(1em)
           
           let is_appendix = it.element.numbering == "A.1"
           
           if is_appendix {
              // Appendix Style
              set text(font: font_serif_jp, weight: "bold", size: 12pt, fill: black)
              h(-1em)
              let count = counter(heading).at(it.element.location()).first()
              let num_str = numbering("A", count)
              box(width: 1.5em)[#num_str]
              it.element.body
              h(1em)
              page_link
              v(-0.8em)  // Space after appendix chapter (adjust as needed)
           } else if it.element.numbering != none {
              // Main Chapter Style (Numbered)
              set text(font: font_serif_jp, weight: "bold", size: 12pt, fill: black)
              
              let num_str = counter(heading).at(it.element.location()).first()
              
              // Line 1: Label
              block([
                #text(size: 9pt)[第]
                #box(move(dy: 2pt)[#text(font: font_num, size: 18pt, fill: ct_title)[#num_str]])
                #text(size: 9pt)[章]
              ])
              
              // Line 2: Title + Page
              block(width: 100%)[
                #it.element.body
                #h(1em)
                #page_link
              ]
           } else {
              // Unnumbered Chapter Style (e.g. Bibliography, Preface)
              // Check if this is a bibliography entry for extra spacing
              let body_text = if it.element.body.has("text") { it.element.body.text } else { repr(it.element.body) }
              let is_bib = body_text.contains("文献") or body_text.contains("Bibliography") or body_text.contains("References")
              
              if is_bib {
                v(1.1em) // Extra space before bibliography in ToC
              }
              
              set text(font: font_serif_jp, weight: "bold", size: 12pt, fill: black)
              block(width: 100%)[
                #it.element.body
                #h(1em)
                #page_link
              ]
           }
        }
      } else {
        // --- Level > 1 (Section, Subsection) ---
        // Section (Level 2): Indent 0, Label 3em
        // Subsection (Level 3): Indent 3em, Label 3.5em
        
        let indent_val = if it.level == 2 { -1em } else { 2em }
        let label_width = if it.level == 2 { 3em } else { 3.5em }
        
        set text(font: font_sans_jp, size: 11pt)
        
        if it.level == 2 { v(2pt) } else { v(1pt) }
        
        h(indent_val)
        
        let num = if it.element.numbering != none {
           numbering(it.element.numbering, ..counter(heading).at(it.element.location()))
        } else { none }
        
        if num != none {
           box(width: label_width)[#num]
        }
        
        it.element.body
        h(1em)
        page_link
      }
    } else if it.element.func() == figure {
       // --- Figure / Table ---
       let is_table = it.element.kind == table
       let prefix = if is_table { "表" } else { "図" }
       
       // Explicitly construct number from location to ensure Chapter.Figure format
       // This avoids issues with context in outline vs body
       // No need for 'num' variable calculation here as we do it inline below

       grid(
         columns: (4.5em, 1fr, auto),
         gutter: 1em,
         text(font: font_sans_jp, weight: "regular")[#prefix#str(counter(heading).at(it.element.location()).first()).#str(it.element.counter.at(it.element.location()).first())],
         text(font: font_sans_jp, weight: "regular")[
           #if it.element.caption != none {
             if it.element.caption.has("body") { it.element.caption.body } else { it.element.caption }
           }
         ],
         text(font: font_sans_jp)[#page_link]
       )
       v(leadingvalue, weak: true)  // Match ToC spacing
    } else {
      it
    }
  }

  // --- Page Setup ---
  set page(
    paper: "a4",
    //use below if you do not use marginalia.
    //margin: (inside: 30mm, outside: 30mm, top: 30mm, bottom: 30mm),
    header: fancy_header,
    footer: fancy_footer,
  )

  set heading(numbering: "1.1")
  set figure(numbering: num => {
    let chap = counter(heading).get().first()
    str(chap) + "." + str(num)
  })

  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    block(below: 10mm)[
       // Ensure marker is present on chapter title pages (though heading check covers this)
       #content_marker()
    ]
    
    let is_appendix = in_appendix.get()
    
    if is_appendix {
       // ... (rest of logic)
       // --- Appendix Style ---
       // Header:
       // 付録 A
       // Title
       // Line
       
       if it.numbering != none {
          let number_str = counter(heading).display(it.numbering)
          let chapter_num = number_str.split(".").at(0)
          block([
            #set text(font: font_serif_jp, weight: "bold", size: 14pt)
            付録
            #box(move(dy: 2.8pt)[#text(font: font_num, weight: "bold", size: 26pt, fill: ct_title)[#chapter_num]])
          ])
          v(-0.1em)
       }
       
       block([
         #set text(font: font_serif_jp, weight: "bold", size: 20pt)
         #it.body
       ])
       v(0.3em)
       block(below: 10mm, line(length: 100%, stroke: 0.4pt))
       
    } else {
       // --- Normal Chapter Style ---
       let number_str = if it.numbering != none {
         counter(heading).display(it.numbering)
       } else {
         none
       }
  
       if number_str != none {
          let chapter_num = number_str.split(".").at(0)
          block([
            #set text(font: font_serif_jp, weight: "bold", size: 14pt)
            第
            #box(move(dy: 2.8pt)[#text(font: font_num, weight: "bold", size: 26pt, fill: ct_title)[#chapter_num]])
            章
          ])
          v(-0.1em)
       }
       
       block([
         #set text(font: font_serif_jp, weight: "bold", size: 20pt)
         #it.body
       ])
       v(0.3em)
       block(below: 10mm, line(length: 100%, stroke: 0.4pt))
       counter(figure).update(0)
       counter(figure.where(kind: table)).update(0)
       counter(footnote).update(0)
    }
  }

  // --- Heading Styles (Level 2+) ---
  // heading_above: space before heading (separates from previous section)
  // heading_below: space after heading (keeps heading close to its content)
  show heading.where(level: 2): it => {
    set text(font: font_sans_jp, weight: "medium", size: 14pt)
    block(above: heading_above, below: heading_below, breakable: false, sticky: true)[
      #if it.numbering != none {
        text(weight: "medium")[#counter(heading).display()]
        h(1em)
      }
      #it.body
    ]
  }

  show heading.where(level: 3): it => {
    set text(font: font_sans_jp, weight: "medium", size: 12pt)
    block(above: heading_above, below: heading_below, breakable: false, sticky: true)[
      #if it.numbering != none {
        text(weight: "medium")[#counter(heading).display()]
        h(1em)
      }
      #it.body
    ]
  }

  show heading.where(level: 4): it => {
    set text(font: font_sans_jp, weight: "medium", size: 11pt)
    block(above: heading_above, below: heading_below, breakable: false, sticky: true)[
      #if it.numbering != none {
        text(weight: "medium")[#counter(heading).display()]
        h(1em)
      }
      #it.body
    ]
  }

  show heading.where(level: 5): it => {
    set text(font: font_sans_jp, weight: "medium", size: 11pt)
    block(above: heading_above, below: heading_below, breakable: false, sticky: true)[
      #if it.numbering != none {
        text(weight: "medium")[#counter(heading).display()]
        h(1em)
      }
      #it.body
    ]
  }

  // --- Paragraph Settings ---

  set par(
    first-line-indent: (amount: 1em, all: true),
    justify: true,
    leading: leadingvalue,      
    spacing: leadingvalue,     // Space between paragraphs
    linebreaks: "optimized",
  )

  set list(indent: 1em)
  set enum(indent: 1em)

  // Footnote styling: normal size, normal position, space after number
  show footnote.entry: it => {
    let num = numbering(it.note.numbering, ..counter(footnote).at(it.note.location()))
    grid(
      columns: (auto, 1fr),
      gutter: 0.5em,
      [#num],
      it.note.body
    )
  }

  body
}