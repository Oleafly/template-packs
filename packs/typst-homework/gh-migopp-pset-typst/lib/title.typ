// title.typ

#let title(
    title: "",
    author: "",
    class: "",
    semester: "",
) = {
    set text(font: "New Computer Modern Math")
    align(center)[
        *#title*
        // e.g., `Assignment X`

        #class - #semester
        // e.g., `CS 331H - Spring 2025`

        #author
        // e.g., `Michael Goppert`
    ]
}
