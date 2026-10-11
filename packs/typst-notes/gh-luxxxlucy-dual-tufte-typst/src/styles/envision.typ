// envision: rstudio/tufte's envisioned variant (rstudio.github.io/tufte/envisioned/).

#let envision = (
    colors: (bg: "#fefefe", fg: "#2B2B2B", link: "#222222"),
    // envisioned.css has no dark-mode rules.
    html: (
        color-scheme: "light",
        sheets: ("https://cdn.jsdelivr.net/gh/rstudio/tufte@main/inst/rmarkdown/templates/tufte_html/resources/envisioned.css",),
        overlay: "links",
    ),
    typography: (
        print: (
            // fetch.sh renames the family to "RobotoCondensed"; Typst reads
            // "Roboto Condensed" as "Roboto".
            body:    (font: ("RobotoCondensed", "Roboto", "Helvetica Neue", "Helvetica", "Arial"), size: 9.6pt, line: 13pt, par: 1.40),
            note:    (line: 0.65),
            caption: (size: 0.78, line: 0.69),
            quote:   (size: 0.95, line: 0.80, before: 2.92, after: 2.40, left: 1.7),
            code:    (font: ("Roboto Mono", "Menlo", "Monaco", "Courier New"), size: 0.90, line: 0.86, before: 1.57, after: 1.65, left: 1.28, inline: 1.0),
            h1:      (before: 2.92, after: 1.84),
            h2:      (before: 1.87, after: 1.65),
            h3:      (before: 1.70, after: 1.48),
            title:   (size: 1.32, after: 1.62),
            meta:    (style: "normal", size: 0.80, after: 2.14),
            marks:   (anchor: 0.79em, margin: 0.96em),
            newthought: (lower: 0.91),
        ),
    ),
)
