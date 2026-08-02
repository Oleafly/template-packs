#let heading_size = 16pt
#let heading_font = "Futura"
#let body_font = "Lora"
// #let body_font = "Linux Libertine"

#let cv(
    name: "Name",
    email: "Email",
    date: "",
    body,
) = {
    set document(author: name, title: "CV Title Placeholder")
    set page(paper: "us-letter", numbering: "1", number-align: center)
    set text(font: body_font, lang: "en", size: 12pt)

    show heading.where(level: 1): set text(font: heading_font, style: "normal", weight: "regular", size: heading_size)

    show link: set text(blue)
    show link: underline

    align(
        [#text(name, font: heading_font, style: "normal", weight: "regular", size: heading_size) \
        #email \
        Last updated: #date]
        , center)
    
    // v(-12pt)
    // line(length: 100%)
    // v(-6pt)
    body
}

#let experience(
    description: "Experience description",
    date: "Date",
    body
) = {
    stack(dir: ltr,
    {
        [#description]
    },
    {
        set align(right)
        date
    }
    )
}