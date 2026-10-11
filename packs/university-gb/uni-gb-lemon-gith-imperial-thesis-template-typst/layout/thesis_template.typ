#import "/layout/titlepage.typ": titlepage
#import "/content/preamble/disclaimers.typ": (
  copyright_declaration, originality_declaration
)
#import "/layout/basic_section.typ": section_layout
#import "/style/colours.typ": imperial_blue
#import "/utils/print_pagebreak.typ": print_pagebreak

#import "/layout/basic_formatting.typ": basic_formatting
#import "/layout/content_formatting.typ": content_formatting


#let thesis(
  sections,
  appendices,
  abstract_body: none,
  acknowledgements_body: none,
  conc_body: none,
  acronyms: (),
  figure_list: true,
  table_list: true,
  is_print: false,
  main-font: "New Computer Modern"
) = [  // Titlepage section
  #titlepage(main-font: main-font)

  #print_pagebreak(print: is_print, to: "odd")
] + [  // Preamble section
  // start page counter here
  #counter(page).update(1)
  // --- page settings ---
  #set page(
    margin: (left: 30mm, right: 30mm, top: 40mm, bottom: 40mm),
    numbering: "i"
  )

  // --- outline configurations ---
  #show outline.entry.where(
    level: 1
  ): it => {
    set block(spacing: 2em)
    text(weight: "bold", it)
  }

  #show outline.entry.where(
    level: 1
  ): set outline.entry(fill: none)

  // set section formatting style
  #show: basic_formatting.with(
    main-font: main-font, font-size: 10pt, header-chapter_name: false
  )

  // --- content start ---

  #section_layout("Abstract", abstract_body)

  #print_pagebreak(print: is_print, to: "odd")

  #originality_declaration()

  #print_pagebreak(print: is_print, to: "odd")

  #copyright_declaration()

  #print_pagebreak(print: is_print, to: "odd")
  
  #section_layout("Acknowledgements", acknowledgements_body)

  #print_pagebreak(print: is_print, to: "odd")

  // Table of Contents
  #outline(title: "Contents", indent: auto)

  #print_pagebreak(print: is_print, to: "odd")

  #if acronyms != () [
    = List of Acronyms
    #grid(
      align: left,
      columns: 2,
      row-gutter: 5mm,
      column-gutter: 5mm,
      ..for pair in acronyms {(
        [#text(pair.first(), weight: "extrabold")],
        [#pair.last()]
      )}
    )
  ]

  #print_pagebreak(print: is_print, to: "odd")

  #if figure_list [
    = List of Figures
    #outline(title: "", target: figure.where(kind: image))
  ]

  #print_pagebreak(print: is_print, to: "odd")

  #if table_list [
    = List of Tables
    #outline(title: "", target: figure.where(kind: table))
  ]

  #print_pagebreak(print: is_print, to: "odd")
] + [  // Sections section
  // reset page numbering
  #set page(numbering: "1")
  #counter(page).update(1)

  // reset heading numbering
  #counter(heading).update(0)
  #set heading(numbering: "1.1.1")

  // set section formatting style
  #show: content_formatting.with(
    is_print: is_print, main-font: main-font,
    header_section_prefix: [CHAPTER], thumb_label_num_format: "1"
  )

  // Main body
  #for content_section in sections {
    content_section
  }

  #print_pagebreak(print: is_print, to: "odd")
] + [  // Conclusions sections
  // set section formatting style
  #show: basic_formatting.with(main-font: main-font, font-size: 11pt)
  // include conclusions body
  #conc_body
  #print_pagebreak(print: is_print, to: "odd")
] + [  // Appendices sections
  // Appendix
  #counter(heading).update(0)
  #set heading(numbering: "A")

  // set section formatting style
  #show: content_formatting.with(
    is_print: is_print, main-font: main-font,
    header_section_prefix: [APPENDIX], thumb_label_num_format: "A",
    par-fl_indent: 0mm
  )

  // workaround for skipping print_pagebreak on final appendix
  #let last_appendix = appendices.last()
  #for appendix in appendices {
    appendix
    if appendix == last_appendix {
      print_pagebreak(print: is_print, to: "odd")
    }
  }
] + [  // Bibliography section
  // set section formatting style
  #show: basic_formatting.with(
    main-font: main-font, font-size: 10pt
  )
  #bibliography("/thesis.bib", style: "ieee")
]
