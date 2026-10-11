// A simple Typst template for Offensive Security Exam Reports
// Author: https://gitlab.com/daniele_m

// Inspired by:
// - https://github.com/noraj/OSCP-Exam-Report-Template-Markdown
// - https://github.com/Wandmalfarbe/pandoc-latex-template

//--- Variables --------------------------------------------

//Font families
#let FONT_NAME = "Open Sans"
#let HEADING_FONT_NAME = "Open Sans"
#let CODE_FONT_NAME = "Liberation Mono"

//Default font color and size
#let FONT_COLOR = rgb("#000000") 
#let FONT_SIZE = 10pt

//Raw font size
#let CODE_FONT_SIZE = 9pt

//Titlepage heading sizes
#let TITLEPAGE_SIZE_1 = 24pt
#let TITLEPAGE_SIZE_2 = 16pt
#let TITLEPAGE_SIZE_3 = 14pt

//Header and footer font
#let HEADER_FOOTER_SIZE = 8.5pt

//Codebox background color and theme
#let CODEBLOCK_BACKGROUND = rgb("#f6f6f6") //rgb("#1f1f1f")
#let CODEBLOCK_THEME = none //Can be used to load custom syntax highlighting styles in .tmTheme format

//--- Functions ---------------------------------------------

//Extra big heading (not really a heading) that has no numbering. It does not show up in ToC unless you pass a real heading to it
#let extra_big(extra_big) = {
    text(
        font: HEADING_FONT_NAME,
        size: TITLEPAGE_SIZE_2,
        weight: "black"
    )[
        #extra_big
    ]
}

//A little shortcut used to create a figure with image + caption
#let picture(path, caption) = {
    figure(
        image("/" + path),
        caption: caption,
    )
    // v(10pt)
}

//Custom-colored codeblock. Todo: need to add dark theme here and in `raw`
#let codeblock(font_name: CODE_FONT_NAME, font_size: CODE_FONT_SIZE, code) = {
    
    set text(
        font: font_name,
        size: font_size,
    )
    set par(
        justify: false
    )
    
    block(
        clip: true,
        radius: 4pt,
        fill: CODEBLOCK_BACKGROUND,
        inset: 5pt,
        width: 100%,
        code
    )
}

// Colored severity box
#let severity(sev) = {
    let sev = lower(sev)

    let severity_box(t, color) = box(
        baseline: 4pt,
        block(
            inset: 3.7pt,
            radius: 4pt,
            fill: rgb(color),
            text(fill: white, size: 9pt, strong(t))
        )
    )

    let title_case(x) = upper(x.at(0)) + x.slice(1, x.len())

    severity_colors = (
        "critical": "#733381",
        "high": "#8b0000",
        "medium": "#F58024",
        "low": "#008100",
        "informational": "#808080"
    )

    if sev in severity_colors.keys() {
        severity_box(title_case(sev), severity_colors.at(sev))
    }
}

//Colored titlepage with custom logo in the bottom left
#let titlepage(title, subtitle, osid, email, date, titlepage_color, link_color, logo, text_alignment, logo_alignment, logo_size) = {
    set page(
        fill: gradient.linear(
            angle: 90deg,
            (titlepage_color.darken(10%), 0%),
            (titlepage_color.darken(20%), 20%),
            (titlepage_color.darken(30%), 40%),
            (titlepage_color.darken(40%), 60%),
            (titlepage_color.darken(50%), 80%),
            (titlepage_color.darken(60%), 100%),
        ),
        header: none,
        footer: none,
        numbering: none,
    )

    set text(
        size: TITLEPAGE_SIZE_3,
        font: FONT_NAME,
        fill: rgb("#ffffff")
    )
    
    //Main title
    show heading.where(level: 1): set text(
        font: HEADING_FONT_NAME,
        size: TITLEPAGE_SIZE_1,
        weight: "bold",
    )

    //Subtitle
    show heading.where(level: 2): set text(
        font: HEADING_FONT_NAME,
        size: TITLEPAGE_SIZE_2,
        weight: "semibold"
    )

    //Alignment on horizon + `text_alignment` parameter
    align(horizon + text_alignment, {
        heading(outlined: false, level: 1, title)
        v(.1em)
        heading(outlined: false, level: 2, subtitle)
        v(.1em)        
        [#email, OS\-#osid]
        align(
            bottom + logo_alignment,
            box(
                align(center, {
                        image("/" + logo, width: logo_size)
                        date.display("[day]-[month]-[year]")
                    }
                )
            )
        )
    })
}

// Convert content to to_string
#let to_string(c) = {
  if c.has("text") {
    c.text
  } else if c.has("children") {
    c.children.map(to_string).join("")
  } else if c.has("body") {
    to_string(c.body)
  } else if c == [ ] {
    " "
  }
}

// Terminal window copied from https://gitlab.com/LostPy/lostpy-typst-templates/-/blob/master/components/window-box.typ
#let terminal_window(
    code,
    icon_alignment: right,
    header_fill: luma(50),
    fill: luma(40),
    inset: .8em,
    outset: 0em
) = {
    let radius = 5pt
    set block(spacing: 1.5em)

    pad(y: outset, 
        pad(x: outset,
            stack(dir: ttb, spacing: -0.4pt,
                // Icon bar
                rect(
                    width: 100%,
                    height: 16pt,
                    fill: header_fill,
                    radius: (top: radius),
                    inset: 0pt, 
                        pad(x: 4.5pt, y: 4.5pt, 
                            align(icon_alignment, 
                                stack(
                                    dir: ltr,
                                    spacing: 7pt,
                                    circle(width: 8pt, fill: red),
                                    circle(width: 8pt, fill: orange),
                                    circle(width: 8pt, fill: green),
                                )
                            )
                        )
                    
                ),
                // Window body
                rect(
                    width: 100%,
                    fill: fill,
                    radius: (bottom: radius),
                    inset: inset,
                    par(justify: false, {
                        set text(fill: white)
                        raw(to_string(code))
                    })
                )
            )
        )
        
    )
}

//Wrapper around outline that includes an extra_big title that does not count as a heading
#let table_of_contents() = {

    extra_big("Contents")
    
    show outline.entry.where(level: 1): set text(
        weight: "bold",
    )

    outline(
        title: none,
        depth: 4,
        indent: auto
    )
}

//The actual template that puts functions together
//Starts with a titlepage, followed by a table_of_contents and then the document body
#let offsec_exam_report(
    title: "OffSec Certified Professional",
    subtitle: "Exam Report",
    header_title: "OSCP Exam Report",
    osid: "12345",
    email: "student@offsec.com",
    date: datetime(month: 1, day: 1, year: 2024),
    titlepage_color: rgb("#e66124"),
    link_color: rgb("#e66124"),
    logo: "./logos/PEN-200_Fill.svg",
    text_alignment: center,
    logo_alignment: left,
    logo_size: 80pt,
    body: "",
) = {
    
    //Titlepage as first page
    titlepage(title, subtitle, osid, email, date, titlepage_color, link_color, logo, text_alignment, logo_alignment, logo_size)
    pagebreak()

    //Apply style configuration
    set page(
        margin: auto,
        fill: rgb("#ffffff"),
        header-ascent: 30%,
        header: align(
            right,
            text(size: HEADER_FOOTER_SIZE, weight: "thin",
                box(header_title)
            )
        ),
        footer: { 
            grid(
                columns: (1fr, 1fr),
                align(
                    left,
                    text(
                        size: HEADER_FOOTER_SIZE,
                        weight: "thin",
                        date.display("[day]-[month]-[year]")
                    )
                ),
                align(
                    right,
                    text(
                        size: HEADER_FOOTER_SIZE,
                        weight: "thin",
                        context counter(page).display()
                    )
                )
            )
         }            
    )

    //Set spacing
    show heading: set block(spacing: 1em, above: 2em)
    
    //Apply fonts
    set text(
        size: FONT_SIZE,
        font: FONT_NAME,
        fill: FONT_COLOR
    )

    //Add space between paragraph lines and use justify
    set par(
        justify: true,
        leading: .75em,
        
    )

    // Striped table
    set table(
        fill: (_, row) => if calc.odd(row) {
            luma(240)
        } else {
            white
        }
    )

    //Set size + weight for primry headings
    show heading.where(level: 1): set text(
        weight: "black",
        size: 15pt
    )

    //Set link color
    show link: underline
    show link: set text(size: FONT_SIZE, fill: link_color)

    //Set caption size and color
    show figure: set text(
        size: 8pt,
        fill: rgb("#808080")
    )

    //Customize bullet list and numbered list
    set list(tight: false, indent: 10pt)
    set enum(tight: false, indent: 10pt)

    //Apply custom tmTheme to codeblock if present
    if CODEBLOCK_THEME != none {
        show raw: set raw(
            theme: CODEBLOCK_THEME
        )
    }

    set heading(numbering: "1.1")

    show table.cell.where(y: 0): strong

    //Show table of contents as second page
    table_of_contents()
    pagebreak()

    body
}

