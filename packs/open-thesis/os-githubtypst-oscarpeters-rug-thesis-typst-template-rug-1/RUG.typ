#let translations = (
  en: (
    contents: "Contents",
    figure: "Figure",
    table: "Table",
    listing: "Listing",
    list_of_figures: "Figures",
    list_of_tables: "Tables",
    list_of_listings: "Listings",
    consisting_of: "consisting of",
    and_: "and",
    in_: "in",
    university: "University of Groningen",
    references: "References",
  ),
  nl: (
    contents: "Inhoud",
    figure: "Figuur",
    table: "Tabel",
    listing: "Hoofdstuk",
    list_of_figures: "Hoofdstuknummers",
    list_of_tables: "Tabellen",
    list_of_listings: "Vermeldingen",
    consisting_of: "Bestaande uit",
    and_: "en",
    in_: "in",
    university: "Rijksuniversiteit Groningen",
    references: "Referenties",
  )
)
// Primary color palette
#let RUG-red = cmyk(
  0%,
  100%,
  80%,
  0%,
)

#let RUG-White = cmyk(
  0%,
  0%,
  0%,
  0%,
)

#let RUG-Black = cmyk(
  0%,
  0%,
  0%,
  100%,
)

// Secondary color palette 
#let RUG-Cyan = cmyk(
  100%,
  35%,
  0%,
  6%,
)

#let RUG-Purple = cmyk(
  0%,
  62%,
  13%,
  53%,
)


#let RUG-Green = cmyk(
  47%,
  0%,
  42%,
  29%,
)


#let RUG-Pink = cmyk(
  0%,
  57%,
  45%,
  7%,
)

#let RUG-Aqua = cmyk(
  71%,
  0%,
  1%,
  29%,
)

#let RUG-Yellow = cmyk(
  0%,
  14%,
  61%,
  0%,
)

#let RUG-FONT = "Egyptienne"

#let report(
  title: none,
  group: none,
  authors: none,
  group_name: none,
  course_code: none,
  course_name: none,
  date: none,
  lang: "en",
  faculty: none,
  facultyname: none,
  location: "Groningen", 
  intro-text: "",
  pagenumber-placement: center,
  references: "references.yml", // in case user wants to use their own file
  body 
) = {
  set document(title: [#title - #group_name], author: authors)
  set text(font: "Roboto Slab", lang: lang)
  set par(justify: true) // blocky paragraphs
  show link: underline
  show heading: set block(above: 18pt, below: 18pt)

  if group == false {
    set document(title: [#title], author: authors)
  }

  if lang == "nl" or lang == "NL" {
    lang = "nl"
  }

  if faculty == "engineering" {
    facultyname = "Faculty of Engeering and Science"
  } else if faculty == "economics"{
    facultyname = "Faculty of Economics and Business"
  }  
  
  assert(lang in translations.keys(), message: "Unsupported language code: " + lang + ". Supported codes are: " + translations.keys().join(", "))
    
  let t = translations.at(lang)

  // to have language-specific figure namings (and correct targeted outlines)
  show figure.where(kind: image): set figure(supplement: t.figure)
  show figure.where(kind: table): set figure(supplement: t.table)
  show figure.where(kind: raw): set figure(supplement: t.listing)

  let format_authors(authors, and_word) = {
    if authors.len() == 1 {
      authors.first()
    } else {
      authors.slice(0, -1).join(", ") + " " + and_word + " " + authors.last()
    }
  }


  
if faculty == "engineering" {
    block(
        place(top + left,
            image("media/RUG_engineering.svg", width: 79%)
        )
    )
} else if faculty == "None" {
    block(
        place(top + left,
            image("media/RUG-" + lang + ".svg", width: 50%)
        )
    )
} else if faculty == "economics" {
    block(
        place(top + left,
            image("media/RUG_economics.svg", width: 80%)
        )
    )
} else {
    block(
        place(top + left,
            image("media/RUG-en.svg", width: 50%)  // A fallback image if needed
        )
    )
}
    
  set align(center)
  
  v(4cm)
  text(25pt, weight: "bold", title)
  linebreak()
  
  if group == true {
    v(3mm)
    text(18pt, group_name) 
    v(3mm)
    text(12pt, t.consisting_of)
    v(3mm)
    text(18pt, format_authors(authors, t.and_))
    v(3mm)
    text(12pt, t.in_)
    v(3mm)
    text(18pt)[
    #course_code
    #linebreak()
    #course_name
  ]
  } else{
    v(2cm)
    text(18pt, format_authors(authors, t.and_))
  }


  v(1fr) // to bottom
  text(12pt)[
    #facultyname
    #linebreak()
    #t.university
  ]
   /////////////////// END FIRST PAGE ////////////////////////
  pagebreak()
  //////////////////// SECOND PAGE //////////////////////////
  set align(left)
  
  if faculty == "engineering" {
    block(
        place(top + left,
            image("media/RUG_engineering.svg", width: 79%)
        )
      )
  } else if faculty == "None" {
      block(
          place(top + left,
              image("media/RUG-" + lang + ".svg", width: 50%)
          )
      )
  }
  else if faculty == "economics" {
    block(
        place(top + left,
            image("media/RUG_economics.svg", width: 80%)
        )
    )
  } else {
      block(
          place(top + left,
              image("media/RUG-en.svg", width: 50%)  // A fallback image if needed
          )
      )
  }
  
  set align(center)

  v(5cm)
    text(18pt , weight: "bold")[
    #t.university
  ]
  linebreak()
  v(1cm)
  
  text(14pt, weight: "bold")[#title]
  linebreak()
  v(1cm)

  text(12pt)[#intro-text]
  linebreak()

  set align(bottom)
  pad(y:100pt,text(12pt)[#date, #location])
  
   /////////////////// END SECOND PAGE ////////////////////////
  pagebreak()
  ////////////////////   THIRD PAGE   ////////////////////////

  // contents page
  set align(left + top)
  set heading(numbering: "1.")
  outline(indent:auto, title: t.contents)

  pagebreak()

  // Page with lists of figures, tables and listings. Each list, or potentially the entire page, will be hidden if there's no matching elements
  context {
    let has_type(type) = query(figure.where(kind: type)).len() > 0
    let show_this_page = false
    
    if has_type(image) {
      show_this_page = true
      [ #outline(title: t.list_of_figures, target: figure.where(kind: image)) ]
    }

    if has_type(table) {
      show_this_page = true
      [ #outline(title: t.list_of_tables, target: figure.where(kind: table)) ]
    }

    if has_type(raw) {
      show_this_page = true
      [ #outline(title: t.list_of_listings, target: figure.where(kind: raw)) ]
    }
    
    if show_this_page {
      pagebreak()
    }
  }
  
  // after the front page and content things
  set page(numbering: "1", number-align: pagenumber-placement)

  // main.typ

  body

  pagebreak()

  // https://github.com/typst/hayagriva/blob/main/docs/file-format.md
  bibliography("references.yaml", title: t.references)
}