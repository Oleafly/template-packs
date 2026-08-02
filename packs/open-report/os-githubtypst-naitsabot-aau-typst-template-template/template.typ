/* 
 * AAU Typst Template v3.0 - Single File Bundle
 * All modules combined for easy web usage
 * 
 * Made by Naitsa (Sebastian H. Lorenzen)
 */

// **** IMPORTS ****
#import "@preview/mitex:0.2.6": *
#import "@preview/cetz:0.4.1" // Advanced diagram creation
#import "@preview/hydra:0.6.2": hydra
#import "@preview/codly:1.3.0": *  // Add codly import. Cool code blocks / listings

// ========================================
// CONFIG MODULE
// ========================================

#let body-font = "Barlow"
#let sans-font = "Source Sans Pro"
#let par_spacing = 1.2em
#let par_text_spacing = 0.65em

#let theme_aau = (
    aau_blue: rgb(33, 26, 82),
    aau_blue_opaque: rgb(33, 26, 82, 20),
    aau_light_blue: rgb(153, 143, 220),
    aau_light_blue_opaque: rgb(153, 143, 220, 20),
    blue: rgb(33, 26, 82),
    blue_opaque: rgb(33, 26, 82, 20),
    light_blue: rgb(153, 143, 220),
    light_blue_opaque: rgb(153, 143, 220, 20),
)

#let default_meta = (
    title: "Document Title",
    subtitle: "Document Subtitle",
    theme: none,
    project_type: "Project Type",
    project_period: none,
    project_group: none,
    participants: (),
    supervisors: (),
    university: "Aalborg University",
    university_link: link("https://www.aau.dk"),
    faculty: none,
    faculty_link: none,
    department: none,
    department_link: none,
    link_name: none,
    link: none,
    date: datetime.today(),
    copyright_holder: "Aalborg University",
    copyright_text: none,
    colophon: "",
    abstract: "",
    preface: "",
)

#let default_settings = (
    bibs: ("//sources.bib"),
    appendix: "//assets/appendix.typ",
    qcover: true,
    qcovertype2: false,
    qcolophon: true,
    qabstract: true,
    qsignature: true,
    qpreface: true,
    qtableofcontents: true,
    qappendix: true,
    signature_columns: auto,
    signature_line_length: 100%,
    signature_spacing: 5em,
    logo_path: "//assets/AAU/aau_logo_en.svg",
    logo_width: 50%,
    availability_notice: "The content of this report is freely available, but publication (with reference) may only be pursued after agreement with the author.",
    show_page_numbers: true,
)

// ========================================
// HELPERS MODULE
// ========================================

// Configure codly for a specific code block
#let code-block(
    lang: none,
    caption: none,
    label: none,
    code
) = {
    figure(
        code,
        caption: caption,
        kind: raw,
        supplement: [Listing]
    )
}

// Helper to create info field
#let info_field(label, value, label_font: sans-font, value_font: body-font) = {
    if value != none and value != "" [
        #text(font: label_font, 1em, weight: "extrabold")[#label:]\
        #text(font: value_font, 1em, weight: "regular")[#value]
    ]
}

// For large documents - reference placeholder
#let no-ref(it) = {
    show ref: _ => [[?]]
    it
}

// Function to get page count for body content
#let get-body-page-count() = context {
    let body-start = query(selector(<body-start>))
    let body-end = query(selector(<body-end>))
    
    if body-start.len() > 0 and body-end.len() > 0 {
        let start-page = body-start.first().location().page()
        let end-page = body-end.first().location().page()
        str(end-page - start-page)
    } else {
        "0"
    }
}

// Bit field table helper
#let bit_field_table(bit_group_length: array, descriptions: array) = {
    let description_cells = ()
    
    if type(bit_group_length) == "integer" {
        description_cells.push(table.cell(colspan: bit_group_length)[#descriptions])
    } else {
        for k in range(bit_group_length.len()) {
            description_cells.push(table.cell(colspan: bit_group_length.at(k))[#descriptions.at(k)])
        }
    }
    
    figure(
        table(
            columns: (70pt, auto, auto, auto, auto, auto, auto, auto, auto),
            table.cell(align: left, colspan: 1, fill: luma(80%))[*Bit*], 
            [*7*], [*6*], [*5*], [*4*], [*3*], [*2*], [*1*], [*0*],
            table.cell(align: left, colspan: 1, fill: luma(80%))[*Description*],
            ..description_cells
        )
    )
}

// Trimmed image helper
#let trimmed-image = (path, trim: (:), alt: none) => context {
    let img = image(path)
    let dims = measure(img)

    layout(size => {
        let left = trim.at("left", default: 0.0%)
        let right = trim.at("right", default: 0.0%)
        let top = trim.at("top", default: 0.0%)
        let bottom = trim.at("bottom", default: 0.0%)

        let width-rel-trimmed = 100.0% - left - right
        let height-rel-trimmed = 100.0% - top - bottom

        let width-source-trimmed = dims.width * width-rel-trimmed
        let height-source-trimmed = dims.height * height-rel-trimmed

        let aspect-height-layout = size.height / size.width
        let aspect-height-trimmed = height-source-trimmed / width-source-trimmed

        let width-final-trimmed = none
        let height-final-trimmed = none

        if aspect-height-layout >= aspect-height-trimmed {
            width-final-trimmed = size.width
            height-final-trimmed = aspect-height-trimmed * width-final-trimmed
        } else {
            height-final-trimmed = size.height
            width-final-trimmed = size.height / aspect-height-trimmed
        }

        let width-final-untrimmed = width-final-trimmed / float(width-rel-trimmed)
        let height-final-untrimmed = height-final-trimmed / float(height-rel-trimmed)

        box(
            clip: true, 
            inset: (
                top: -(top * height-final-untrimmed), 
                bottom: -(bottom * height-final-untrimmed),
                left: -(left * width-final-untrimmed),
                right: -(right * width-final-untrimmed)
            ), 
            image(path, width: width-final-untrimmed, height: height-final-untrimmed, alt: alt)
        )
    })
}

// TeX logo
#let TeX = {
  set text(font: "New Computer Modern", weight: "regular")
  box(width: 1.7em, {
    [T]
    place(top, dx: 0.56em, dy: 0.22em)[E]
    place(top, dx: 1.1em)[X]
  })
}

// LaTeX logo
#let LaTeX = {
  set text(font: "New Computer Modern", weight: "regular")
  box(width: 2.55em, {
    [L]
    place(top, dx: 0.3em, text(size: 0.7em)[A])
    place(top, dx: 0.7em)[#TeX]
  })
}

// ========================================
// STYLES MODULE
// ========================================

// Apply all document-wide styles
#let apply_styles(localisation, meta) = it => {
    // **** BASIC TEXT SETTINGS ****
    set text(font: body-font, lang: localisation.lang, region: localisation.region)
    show heading: set text(font: sans-font, fill: theme_aau.blue)

    // **** LINKS STYLING ****
    show link: it => {
        if type(it.dest) == str {
            text(weight: "medium", fill: theme_aau.light_blue, underline(stroke: theme_aau.blue, it))
        } else {
            text(weight: "regular", fill: black, it)
        }
    }

    // **** REFERENCES STYLING ****
    show ref: it => {
        let el = it.element
        if el != none and el.func() == figure and el.kind == "glossarium_entry" {
            text(it) // if glossary item
        } else {
            text(weight: "medium", it) // if not glossary item
        }
    }

    // **** FOOTNOTES ****
    show footnote.entry: it => {
        let loc = it.note.location()
        numbering("1: ", ..counter(footnote).at(loc))
        it.note.body
    }

    set footnote.entry(
        separator: line(length: 35% + 0pt, stroke: 1pt + theme_aau.blue),
        clearance: 1em,
    )

    // **** MATH EQUATIONS ****
    set math.equation(numbering: "(1)")
    show math.equation: set text(weight: "regular")

    // **** CODE BLOCKS ****
    // ! Codly handles block code styling, only style inline code
    show raw.where(block: false): box.with(
        fill: luma(240),
        inset: (x: 3pt, y: 0pt),
        outset: (y: 3pt),
        radius: 2pt,
    )

    // **** PARAGRAPH SETTINGS ****
    set par(justify: true)
    set pagebreak(weak: true)

    // **** TABLES ****
    set table(stroke: theme_aau.blue)

    // **** LISTS ****
    set list(
        marker: ([❖], [◈], [◇], [⋄]),
        tight: true, 
        body-indent: 0.5em, 
        indent: 0.5em, 
        spacing: 0.40cm
    )

    // **** CITATIONS ****
    set cite(style: "council-of-science-editors")

    // **** QUOTATIONS ****
    set quote(block: true)
    show quote: set align(left)
    show quote: set pad(x: 2em)
    show quote: set block(spacing: 1em)

    // **** FIGURES ****
    set figure(numbering: (..nums) => 
        [#counter(heading).display((..heading_nums) => heading_nums.pos().at(0))\.#nums.pos().at(0)]
    )

    show figure: figure => block[
        #v(.75em)
        #figure
    ]
    
    it  // ← Return the content with styles applied
}

// Apply body-specific heading styles
#let apply_body_heading_styles() = it => {
  // Enable heading numbering for body content
    set heading(numbering: "1.1")

    // Heading supplements
    show heading.where(level: 1): set heading(supplement: "Chapter")
    show heading.where(level: 2): set heading(supplement: "Section")
    show heading.where(level: 3): set heading(supplement: "Subsection")
    show heading.where(level: 4): set heading(supplement: "Subsubsection")
  
    // Chapter heading styling
    show heading.where(level: 1): it => {
        pagebreak(weak: true)
        v(0pt)
        place(left, dx: .5em, text(
            font: sans-font, 
            4em, 
            weight: "extrabold", 
            fill: theme_aau.blue, 
            counter(heading).display()
        ))
        place(right, dy: 1.75em, dx: -.5em, text(
            font: sans-font, 
            1.5em, 
            weight: "extrabold", 
            fill: theme_aau.blue, 
            it.body
        ))
        v(4em)

        // Reset figure counters
        counter(figure.where(kind: table)).update(0)
        counter(figure.where(kind: image)).update(0)
        counter(figure.where(kind: raw)).update(0)       
    }

    // Section heading styling
    show heading.where(level: 2): it => {
        v(par_spacing, weak: true)
        set text(1.25em, font: sans-font, weight: "bold", fill: theme_aau.blue)
        text(counter(heading).display())
        text(" - ")
        text(fill: theme_aau.blue, it.body)
        v(par_text_spacing, weak: true)
    }

    // Subsection heading styling
    show heading.where(level: 3): it => {
        v(par_spacing, weak: true)
        set text(1.125em, font: sans-font, weight: "bold", fill: theme_aau.blue)
        text(counter(heading).display())
        text(" - ")
        text(fill: theme_aau.blue, it.body)
        v(par_text_spacing, weak: true)
    }

    // Subsubsection heading styling
    show heading.where(level: 4): it => {
        v(par_spacing, weak: true)
        set text(1.125em, font: sans-font, weight: "semibold", fill: theme_aau.blue)
        text(fill: theme_aau.blue, it.body)
        v(par_text_spacing, weak: true)
    }
    
    it  // Return the content with styles applied
}

// Apply appendix-specific styles
#let apply_appendix_styles() = it => {
  // Set appendix numbering
    set heading(numbering: "A.1")

    // Figure formatting for appendix
    show heading.where(level: 1): it => {
        counter(heading).step(level: 1)  // Step counter first
        counter(figure.where(kind: table)).update(0)
        counter(figure.where(kind: image)).update(0)
        counter(figure.where(kind: raw)).update(0)
        it
    }
    
    // Custom figure numbering for appendix
    set figure(numbering: (..nums) => {
        let fig_num = nums.pos().at(0)
        let app_letter = counter(heading).display("A").first()
        
        if nums.pos().len() > 0 {
            [Apx. #app_letter\.#fig_num]
        }
    })
    
    // Custom figure supplements for appendix
    show figure.where(kind: table): set figure(supplement: "Table")
    show figure.where(kind: image): set figure(supplement: "Figure") 
    show figure.where(kind: raw): set figure(supplement: "Listing")

    // Set supplement for appendix headings
    show heading.where(level: 1): set heading(supplement: [Appendix])
    show heading.where(level: 2): set heading(supplement: [Appendix])
    show heading.where(level: 3): set heading(supplement: [Appendix])
    show heading.where(level: 4): set heading(supplement: [Appendix])

    // Appendix heading styles
    show heading.where(level: 1): h => {
        v(par_spacing, weak: true)
        set text(1.50em, font: sans-font, weight: "bold", fill: theme_aau.blue)
        text(counter(heading).display())
        text(" - ")
        text(fill: theme_aau.blue, h.body)
        v(par_text_spacing, weak: true)
    }

    show heading.where(level: 2): h => {
        v(par_spacing, weak: true)
        set text(1.25em, font: sans-font, weight: "bold", fill: theme_aau.blue)
        text(counter(heading).display())
        text(" - ")
        text(fill: theme_aau.blue, h.body)
        v(par_text_spacing, weak: true)
    }

    show heading.where(level: 3): h => {
        v(par_spacing, weak: true)
        set text(1.125em, font: sans-font, weight: "bold", fill: theme_aau.blue)
        text(counter(heading).display())
        text(" - ")
        text(fill: theme_aau.blue, h.body)
        v(par_text_spacing, weak: true)
    }

    show heading.where(level: 4): h => {
        v(par_spacing, weak: true)
        set text(1.125em, font: sans-font, weight: "semibold", fill: theme_aau.blue)
        text(counter(heading).display())
        text(" - ")
        text(fill: theme_aau.blue, h.body)
        v(par_text_spacing, weak: true)
    }
    
    it  // Return the content with styles applied
}

// ========================================
// PAGES MODULE
// ========================================

#let page_cover(meta) = {
    page(
        background: image("//assets/AAU/aau_waves.svg", width: 100%, height: 100%), 
        numbering: none,
    )[
        #grid(
            columns: (100%), 
            rows: (50%, 25%, 25%),
            
            // Title box
            align(center + bottom)[
                #box(
                    fill: theme_aau.blue, 
                    inset: 18pt, 
                    radius: 1pt, 
                    width: 100%,
                )[
                    #set par(justify: false)
                    #set text(fill: white, 12pt)
                    #set align(center)
                    
                    #text(font: sans-font, 3em, weight: "extrabold")[#meta.title]\
                    
                    #if meta.subtitle != none and meta.subtitle != "" [
                        #text(font: body-font, 1.5em, weight: "regular")[#meta.subtitle]\ \
                    ] else [
                        \
                    ]
                    
                    #if meta.department != none and meta.department != "" [
                        #text(font: sans-font, 1.5em, weight: "extrabold")[Department of ]
                        #text(font: sans-font, 1.5em, weight: "extrabold")[#meta.department]\
                    ]
                    
                    #if (meta.project_group != none and meta.project_group != "") or (meta.project_period != none and meta.project_period != "") [
                        #let parts = ()
                        #if meta.project_group != none and meta.project_group != "" {
                            parts.push(meta.project_group)
                        }
                        #if meta.project_period != none and meta.project_period != "" {
                            parts.push(meta.project_period)
                        }
                        #text(font: body-font, 1.5em, weight: "regular")[#parts.join(" | ")]\
                    ]
                    
                    #text(font: sans-font, 1.5em, weight: "extrabold")[#meta.project_type]
                ]
            ],
            
            // Spacer
            [],
            
            // Logo
            align(center)[
                #image("//assets/AAU/aau_logo_circle_en.svg", width: 25%)
            ]
        )
    ]
}

// Cover page with image
#let page_cover_image(meta) = {
    page(
        background: image("//assets/AAU/aau_waves.svg", width: 100%, height: 100%, fit: "cover"), 
        margin: 0em,
        numbering: none,
    )[
        #image("//assets/AAU/frontpageImage.jpg", width: 100%, height: 37%)
        #v(-2%)
        
        #align(center + top)[
            #box(
                fill: white, 
                inset: 18pt, 
                radius: 1pt, 
                width: 100%,
            )[
                #set par(justify: false)
                #set text(fill: theme_aau.blue, 12pt)
                #set align(center)
                
                #text(font: sans-font, 3em, weight: "extrabold")[#meta.title]\
                
                #if meta.subtitle != none and meta.subtitle != "" [
                    #text(font: body-font, 1.5em, weight: "regular")[#meta.subtitle]\ \
                ] else [
                    \
                ]
                
                #if meta.department != none and meta.department != "" [
                    #text(font: sans-font, 1.5em, weight: "extrabold")[Department of ]
                    #text(font: sans-font, 1.5em, weight: "extrabold")[#meta.department]\
                ]
                
                #if (meta.project_group != none and meta.project_group != "") or (meta.project_period != none and meta.project_period != "") [
                    #let parts = ()
                    #if meta.project_group != none and meta.project_group != "" {
                        parts.push(meta.project_group)
                    }
                    #if meta.project_period != none and meta.project_period != "" {
                        parts.push(meta.project_period)
                    }
                    #text(font: body-font, 1.5em, weight: "regular")[#parts.join(" | ")]\
                ]
                
                #text(font: sans-font, 1.5em, weight: "extrabold")[#meta.project_type]
            ]
        ]
        
        #align(bottom + center)[
            #image("//assets/AAU/aau_logo_circle_en.svg", width: 25%)
        ]
        #v(10%)
    ]
}

// Colophon page
#let page_colophon(meta) = {
    page[
        #set align(bottom)
        #set par(justify: true)
        #set text(font: body-font)
        
        // Copyright section
        #if meta.copyright_text != none [
            #meta.copyright_text
        ] else if meta.copyright_holder != none [
            #let year = meta.date.display("[year]")
            #let holder = meta.copyright_holder
            Copyright © #holder #year
        ]
        
        // Additional colophon text
        #if meta.colophon != none and meta.colophon != "" [
            #meta.colophon
        ]
        
        #v(5em)
    ]
}

// Abstract and information page
#let page_abstract(meta, settings) = {
    page[
        #grid(
            columns: (100%),
            rows: (60%, 37.5%, 2.5%),
            
            // Main content grid
            grid(
                columns: (49%, 2%, 49%),
                rows: (100%),
                
                // Left column - Project information
                box(width: 100%, height: 100%)[
                    #info_field("Title", meta.title)

                    #info_field("Theme", meta.theme) 

                    #info_field("Project Period", meta.project_period)
                    
                    #info_field("Project Group", meta.project_group)
                    
                    #if meta.participants.len() > 0 [
                        #info_field("Participant(s)", meta.participants.map(e => e.name).join("\n"))
                    ]
                    
                    #if meta.supervisors.len() > 0 [
                        #info_field("Supervisor(s)", meta.supervisors.map(e => e.name).join("\n"))
                    ]
                    
                    #if meta.link_name != none and meta.link != none [
                        #info_field(meta.link_name, meta.link)
                    ]
                    
                    #if settings.at("show_page_numbers", default: true) [
                        #info_field("Page Numbers", get-body-page-count())
                    ]
                    
                    #info_field("Date of Completion", meta.date.display())

                    #info_field(meta.faculty, meta.faculty_link)
                ],
                
                // Spacer column
                [],
                
                // Right column - Department info and abstract
                box(width: 100%, height: 100%)[
                    #if meta.department != none and meta.department != "" [
                        #text(font: sans-font, 1em, weight: "extrabold")[Department of ]
                        #info_field(meta.department, meta.department_link)
                    ]
                    
                    // Abstract
                    #text(font: sans-font, 1em, weight: "extrabold")[Abstract:]
                    #set par(justify: true)
                    #meta.abstract
                ]
            ),
            
            // Logo
            {
                let logo_path = settings.at("logo_path", default: "//assets/AAU/aau_logo_en.svg")
                let logo_width = settings.at("logo_width", default: 50%)
                align(center + horizon, image(logo_path, width: logo_width))
            },
            
            // Availability notice
            {
                let notice = settings.at("availability_notice", default: none)
                if notice != none [
                    #align(center)[
                        #set text(font: body-font, .75em, style: "italic", weight: "regular")
                        #notice
                    ]
                ]
            }
        )
    ]
}

// Preface page
#let page_preface(meta, settings) = {
    page[
        #set text(font: body-font)
        #set par(justify: true)
        
        // Preface heading
        #align(center)[
            #text(font: sans-font, 3em, weight: "extrabold", fill: theme_aau.blue)[Preface]
        ]
        
        // Preface content
        #meta.preface
        
        // Signature section (if enabled)
        #if settings.qsignature and meta.participants.len() > 0 {
            let cols = if settings.at("signature_columns", default: auto) == auto {
                calc.min(meta.participants.len(), 3)
            } else {
                settings.signature_columns
            }
            
            [
                #v(1fr)
                #align(center)[
                    #grid(
                        columns: (auto,) * cols,
                        row-gutter: settings.at("signature_spacing", default: 5em),
                        column-gutter: 2em,
                        ..meta.participants.map(participant => [
                            #v(1em)
                            #line(length: settings.at("signature_line_length", default: 100%))
                            #text(font: sans-font, 12pt, participant.name)\
                            #text(font: sans-font, 10pt, participant.email)
                        ])
                    )
                ]
            ]
        }
    ]
}

// ========================================
// COMPONENTS MODULE
// ========================================

// Page header component
#let page_header(meta) = context {
    align(left, text(
        font: body-font, 
        1em, 
        weight: 400, 
        emph(hydra(2) + if meta.university != none {h(1fr) + meta.university})
    ))
    line(length: 100%, stroke: .1em + theme_aau.blue)
}

// Table of contents component
#let table_of_contents(settings) = {
    pagebreak()
    
    show outline.entry.where(level: 1): it => {
        v(12pt, weak: true)
        strong(it)
    }

    align(center, text(font: sans-font, 3em, weight: "extrabold", theme_aau.blue)[Table of Contents])
    v(1em)
    
    outline(
        title: text(font: sans-font, 1em, theme_aau.blue, "Chapters"), 
        depth: 2, 
        indent: auto,
        target: heading.where(numbering: "1.1")
    )

    v(.5em)

    context {
        outline(
            title: none,
            indent: auto,
            target: heading.where(numbering: none)
        ) 
    }
    
    if settings.qappendix {
        outline(
            title: text(font: sans-font, 1em, theme_aau.blue, "Appendices"), 
            depth: 1, 
            indent: auto,
            target: heading.where(numbering: "A.1")
        )
    }
}

// ========================================
// MAIN TEMPLATE FUNCTION
// ========================================

// **** MAIN DOCUMENT FUNCTION ****
#let doc(
    meta: default_meta,
    localisation: (lang: "en", region: "gb"),
    settings: default_settings,
    body,
) = {
    // **** BASIC DOCUMENT SETTINGS ****
    set document(
        author: meta.participants.map(a => a.name), 
        title: meta.title, 
        keywords: (
            if meta.university != none {meta.university} else {""}, 
            if meta.faculty != none {meta.faculty} else {""}, 
            if meta.department != none {meta.department} else {""}, 
            if meta.project_group != none {meta.project_group} else {""}
        )
    )

    // **** APPLY GLOBAL STYLES ****
    show: apply_styles(localisation, meta)  // Now wraps all content below

    // **** INITIALIZE CODLY ****
    show: codly-init.with()
    
    // Configure codly styling to match AAU theme
    codly(
        languages: (
            python: (name: "Python", color: theme_aau.blue),
            rust: (name: "Rust", color: theme_aau.blue),
            javascript: (name: "JavaScript", color: theme_aau.blue),
            typescript: (name: "TypeScript", color: theme_aau.blue),
            java: (name: "Java", color: theme_aau.blue),
            c: (name: "C", color: theme_aau.blue),
            cpp: (name: "C++", color: theme_aau.blue),
            csharp: (name: "C#", color: theme_aau.blue),
            bash: (name: "Bash", color: theme_aau.blue),
            sql: (name: "SQL", color: theme_aau.blue),
        ),
    )
    
    // Set codly appearance
    codly(
        number-format: (number) => text(fill: theme_aau.blue, str(number)),
        zebra-fill: theme_aau.light_blue_opaque,
        stroke: 1pt + theme_aau.blue,
    )

    // **** FRONT MATTER ****
    set page(numbering: "I", number-align: center)

    if settings.qcover {
        if settings.qcovertype2 { 
            page_cover_image(meta) 
        } else { 
            page_cover(meta) 
        }
    }
    if settings.qcolophon { page_colophon(meta) }
    if settings.qabstract { page_abstract(meta, settings) }
    if settings.qpreface { page_preface(meta, settings) }

    // **** TABLE OF CONTENTS ****
    if settings.qtableofcontents {
        table_of_contents(settings)
    }

    // **** MAIN BODY ****
    place(hide[#heading(level: 2, outlined: false, bookmarked: false, numbering: none)[] <body-start>])
    
    set page(
        numbering: "1", 
        number-align: center,
        header: page_header(meta)
    )
    counter(page).update(1)

    // Apply body heading styles
    show: apply_body_heading_styles()
    
    body

    place(hide[#heading(level: 2, outlined: false, bookmarked: false, numbering: none)[] <body-end>])

    // **** BIBLIOGRAPHY ****
    show bibliography: body => {
        counter(heading).step()
        body
    }
    
    pagebreak(weak: true)
    
    show heading.where(level: 1): h => {
        v(par_spacing, weak: true)
        align(center, text(font: sans-font, 3em, weight: "extrabold", fill: theme_aau.blue)[References])
        v(1em)
        v(par_text_spacing, weak: true)
    }
    
    bibliography(settings.bibs, title: "References", style: "springer-vancouver")

    // **** APPENDIX ****
    if settings.qappendix {
        show: apply_appendix_styles()
        
        set page(numbering: "A", number-align: center)
        counter(page).update(1)

        set heading(numbering: "A.1")
        counter(heading).update(0)

        pagebreak(weak: true)
        align(center, text(font: sans-font, 3em, weight: "extrabold", fill: theme_aau.blue)[Appendices])
        v(0em)
        include settings.appendix
    }
}