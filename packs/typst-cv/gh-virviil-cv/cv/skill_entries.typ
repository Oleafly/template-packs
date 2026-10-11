#let skill_entry(
    skill
) = {
    block(spacing: 7pt)[
        #text(
            font: "PT Sans",
            size: 9pt, 
            weight: "extrabold",
            // stretch: 80%,
        )[#skill.skill]
    ]
    if skill.at("description", default: none) != none [
        #block(spacing: 7pt)[#text(
                size: 9pt, 
                weight: "light",
            )[#skill.description]
        ]
    ]
    block(spacing: 7pt)[#text(
            size: 7pt,
            weight: "extrabold",
        )[#skill.tags.join(", ")]
    ]
    
}

#let skill_entries(
    skills,
    hack_font: "FiraCode Nerd Font Mono",
    curvy_font: "Rockwell",
    main_color: eastern
) = {
    let skills_block = skills.map(skill_entry)
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
            )[Skills]
        ]
        #skills_block.join(line(length: 100%, stroke: (
            thickness: 3pt,
            paint: main_color.lighten(90%),
            cap: "butt",
            dash: "dashed"
        )))
    ]
}
