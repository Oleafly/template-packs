#let public_contribution_entry(
    public_contribution
) = {
    if public_contribution.at("link", default: none) != none [
        #block(spacing: 7pt)[#text(
            font: "PT Sans",
            size: 9pt, 
            weight: "extrabold",
            // stretch: 80%,
        )[#link(public_contribution.link)[#public_contribution.title]]]
    ] else [
        #block(spacing: 7pt)[#text(
            font: "PT Sans",
            size: 9pt, 
            weight: "extrabold",
            // stretch: 80%,
        )[#public_contribution.title]]
    ]
    if public_contribution.at("description", default: none) != none [
        #block(spacing: 7pt)[#text(
                size: 7pt, 
                weight: "light",
            )[#public_contribution.description]
        ]
    ]
}

#let public_contributions_entries(
    public_contributions,
    hack_font: "FiraCode Nerd Font Mono",
    curvy_font: "Rockwell",
    main_color: eastern
) = {
    let public_contributions_block = public_contributions.map(public_contribution_entry)
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
            )[Public contributions]
        ]
        // #public_contributions_block.join()
        #public_contributions_block.join(line(length: 100%, stroke: (
            thickness: 3pt,
            paint: main_color.lighten(90%),
            cap: "butt",
            dash: "dashed"
        )))
    ]
}

