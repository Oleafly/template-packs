#import "../utils.typ": duallang

#let setup-page(
    print-mode: "oneside",
    subject: "",
    lang: "en",
    body,
) = {
    // Header and Footer
    let header-content = context {
        let align-dir = if print-mode == "twoside" {
            if calc.even(here().page()) { left } else { right }
        } else {
            right
        }
        align(align-dir)[
            #text(size: 10pt)[#subject]
            #v(-8pt)
            #line(length: 100%, stroke: 0.4pt)
        ]
    }

    let footer-content = context {
        let page-str = duallang(lang, "Page", "Trang")
        let current = counter(page).display()
        let total = counter(page).final().first()

        align(center)[
            #line(length: 100%, stroke: 0.4pt)
            #v(5pt)
            #text(size: 10pt)[#page-str #current/#total]
        ]
    }

    // Background
    let background-content = context {
        let binding-width = 20mm
        let box = rect(
            width: binding-width,
            height: 100%,
            fill: luma(240),
            stroke: none,
        )

        if print-mode == "twoside" {
            // If even page, binding is on the right
            // If odd page, binding is on the left
            if calc.even(here().page()) {
                place(right, box)
            } else {
                place(left, box)
            }
        } else {
            place(left, box)
        }
    }

    // Margins
    let inside-margin = 35mm
    let outside-margin = 15mm
    let margin-dict = if print-mode == "twoside" {
        (inside: inside-margin, outside: outside-margin, y: 25mm)
    } else {
        (left: inside-margin, right: outside-margin, y: 25mm)
    }

    // Apply settings
    set page(
        paper: "a4",
        margin: margin-dict,
        header: header-content,
        footer: footer-content,
        //background: background-content,
    )

    body
}
