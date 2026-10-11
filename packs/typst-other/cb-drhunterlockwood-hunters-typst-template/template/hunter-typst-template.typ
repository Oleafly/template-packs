/* 2024-03-27
This is an attempt to create a personal template for Typst documents. Following the docs and my heart. 

2025-10-25 Small adjustments to improve my workflow and fix issues I didn't notice at first.
*/

#import "@preview/ascii-ipa:2.0.0": *
#import "@preview/leipzig-glossing:0.5.0": *
#import abbreviations: *
#import "@preview/typpuccino:0.1.0": latte
//#import "@preview/catppuccin:1.0.1": catppuccin, flavors // Check the docs!!
#import "@preview/droplet:0.3.1": dropcap

// The `htl` function will establish a basic template for my typical documents. All of the relevant styling is defined here, and then in the documents using the template, you use a `show` rule to pass any parameters and bring the rest in.
#let htl(doc, draft: true, title: none, author) = {
  

  // Overall metadata
  set page(
    paper: "us-letter", // Defaults to A4
    margin: (x: 1in, y: 1in),
    footer: context [
      From _Hunter's Florilegium_
      #h(1fr)
      #counter(page).display("\u{2766} 1 of 1 \u{2766}", both:true)
      #h(3fr)
    ],
    header: [#smallcaps[#title] #h(1fr) #if draft {
      [*Cite Only If Permitted*]
    }],
  )
  set document(
    title: title,
    author: author,
  )

  // Style and design
  show link: underline

  // Supplemented with additional fields from `easy-typography`

  //show heading: set text(font: "Noto Sans")
  set text(
    //font: "Noto Serif",
    style: "normal",
    weight: "light",
    stretch: 100%,
    tracking: 0pt,
    spacing: 100% + 0pt,
    baseline: 0pt,
    overhang: true,
    hyphenate: true, // Might need to set to `false` for certain glossing tasks
    kerning: true,
    ligatures: true,
    number-width: "proportional",
  )

  // Entirely borrowed from `easy-typography`
  let line-spacing      = 1.30
  let paragraph-spacing = 1.70
  set par(
    leading: line-spacing * 0.5em,
    spacing: paragraph-spacing * 0.5em,
    justify: false,
    linebreaks: "optimized",
  )

// compute heading size and spacing
let heading-above-max = 1.25em // above H1
let heading-below-max = 0.65em // below H1
let heading-size-max  = 1.10em // font for H1

let heading-above-min = 0.80em // above H5
let heading-below-min = 0.55em // below H5
let heading-size-min  = 1.00em // font for H5
  let compute-size(max, min, level) = {
    if level <= 1 {
      max
    } else if level >= 5 {
      min
    } else {
      let t = (level - 1) / 4
      max - (max - min) * calc.sqrt(t)
    }
  }
    let compute-weight(level) = {
    if level <= 1 {
      "bold"
    } else if level == 2 {
      "semibold"
    } else if level == 3 {
      "medium"
    } else {
      "regular"
    }
  }
  show heading: it => block(
    breakable: false,
    sticky: true,
    above: compute-size(heading-above-max, heading-above-min, it.level),
    below: compute-size(heading-below-max, heading-below-min, it.level),
    text(
      size: compute-size(heading-size-max, heading-size-min, it.level),
      weight: compute-weight(it.level),
      it
    )
  )

  show table: set text(number-width: "tabular")
  
  doc // If you don't call this variable at the end, nothing shows up!
}

/********************************************
********************************************/

// Adapted from the `ilm` template to replace the existing blockquote functionality
#let blockquote(body) = {
  align(center, block(
    width: 75%,
    fill: latte.base,
    inset: 1em,
    stroke: (left: 4pt + latte.lavender),
    align(left, body),
  )
  )
}

// A function to have a nice looking abstract and title.
#let abstract(title, author, abs) = {
    align(center, heading(outlined: false)[#title])
    align(center, text[#author])
    align(center, block(
    width: 90%,
    fill: latte.mantle,
    inset: 1em,
    align(left, abs),
  )
  )
}

// A function for a nice looking title.
#let no_abstract(title, author) = {
    align(center, heading(outlined: false)[#title])
    align(center, text[#author])
}


// Some standard Algonquianist abbreviations
#let obv = abbreviations.emit-abbreviation("OBV") // Obviative
#let ic = abbreviations.emit-abbreviation("IC") // Initial Change
#let rr = abbreviations.emit-abbreviation("RR") // Relative Root
#let dir = abbreviations.emit-abbreviation("DIR") // Direct
#let inv = abbreviations.emit-abbreviation("INV") // Inverse
#let p0 = abbreviations.emit-abbreviation("0") // Inanimate
#let excl = abbreviations.emit-abbreviation("EXCL") // Exclusive
#let incl = abbreviations.emit-abbreviation("INCL") // Inclusive
#let x = abbreviations.emit-abbreviation("X") // Indefinite person or whatever
#let anim = abbreviations.emit-abbreviation("ANIM") // Animate
#let inan = abbreviations.emit-abbreviation("INAN") // Inanimate
#let init = abbreviations.emit-abbreviation("INIT") // Initial
#let med = abbreviations.emit-abbreviation("MED") // Medial
#let fin = abbreviations.emit-abbreviation("FIN") // Final
#let vta = abbreviations.emit-abbreviation("VTA") // Transitive Animate
#let vti = abbreviations.emit-abbreviation("VTI") // Transitive Inanimate
#let vai = abbreviations.emit-abbreviation("VAI") // Animate Intransitive
#let vii = abbreviations.emit-abbreviation("VII") // Inanimate Intransitive
#let emph = abbreviations.emit-abbreviation("EMPH") // Emphatic
#let dep = abbreviations.emit-abbreviation("DEP") // Dependent
#let indep = abbreviations.emit-abbreviation("INDEP") // Independent
#let conj = abbreviations.emit-abbreviation("CONJ") // Conjunct
#let inj = abbreviations.emit-abbreviation("INJUNC") // Injunctive

// When building tables of abbreviations, `leipzig-gloss` fills in definitions from a dictionary.
#let algonquian-abbreviations = (
  "OBV": "obviative",
  "IC": "initial change",
  "RR": "relative root",
  "DIR": "direct",
  "INV": "inverse",
  "0": "inanimate",
  "INCL": "inclusive",
  "EXCL": "exclusive",
  "X": "indefinite",
  "ANIM": "animate",
  "INAN": "inanimate",
  "INIT": "initial",
  "MED": "medial",
  "FIN": "final",
  "VTA": "transitive animate",
  "VTI": "transitive inanimate",
  "VAI": "animate intransitive",
  "VII": "inanimate intransitive",
  "EMPH": "emphatic",
  "DEP": "dependent",
  "INDEP": "independent",
  "CONJ": "conjunct",
  "INJUNC": "injunctive",
)


// Borrowed from the docs; uses the baked-in `with-used-abbreviations` function.
#let print_usage_fn = abbreviations.with-used-abbreviations(final-used-abbreviations => {

    show terms: t => (   
      for t in t.children [
      #t.term: #t.description\;
      ]
   )

    let print-abbrevs(abbrv_list) = {
      for abbrv in abbrv_list {
        let explanation = if abbrv in abbreviations.standard-abbreviations {
            abbreviations.standard-abbreviations.at(abbrv)
          } else {
            algonquian-abbreviations.at(abbrv)
          }

        terms((smallcaps(lower(abbrv)), explanation))
      }
    }
    
    let sorted-abbreviations = final-used-abbreviations.keys().sorted()

    [Abbreviations Used: #print-abbrevs(sorted-abbreviations)]
})

// I would much rather this be a table; this imports a csv but i can reuse the logic
//#table(
//  columns: 2,
//  ..for (.., year, count) in moore {
//    (year, count)
//  }
//)

// The `ascii-ipa` package quite cleverly defines very simple functions that wrap your text in a set of delimiters. In Algonquian linguistics, I don't tend to wrap orthographic representations in angle brackets; instead, I use that for transliteration (when a standard orthography was not used) and denote orthographic representations in bold. According to wiki, following Americanist notation I could also use ‹...›? 
//
// #let orthographic(text) = "⟨" + text + "⟩"
//#let orth = orthographic
//#let transliterated(text) = "⟪" + text + "⟫"
//#let trlt = transliterated

#let spelling(text) = {strong(text)}
//The myaamia greeting #spelling("aya ceeki") 'hello all' is an awesome substitute for #spelling[hello world]!
