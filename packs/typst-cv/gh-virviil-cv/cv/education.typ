#let education_entry(
    education,
    hack_font,
    curvy_font: "Rockwell",
    main_color: eastern
) = {
    let color = eastern
    block(
        width: 100%,
        radius: 3pt, 
        outset: 8pt,
        inset: 0pt, 
        stroke: (
            thickness: 3pt,
            paint: main_color.lighten(90%),
            cap: "butt",
            dash: "dashed"
        ),
    )[
        #block(spacing: 7pt)[
            #text(
                font: hack_font, 
                size: 10pt, 
                weight: "bold", 
                fill: main_color
            )[Education]
        ]
        #block(spacing: 7pt)[#text(font: "PT Sans", size: 9pt, weight: "extrabold", stretch: 80%)[
            #education.institution
        ]]
        #block(spacing: 7pt)[#text(size: 9pt, weight: "light")[
            #education.major
        ]]

    ]
}
