

#let cv_header(name, title, colors) = {
    text(name, font: "Noto Sans", size: 24pt, weight: "regular", fill: colors.dark)
    h(12pt)
    text(title, font: "Noto Sans", size: 18pt, weight: "regular", style: "italic", fill: colors.theme_color.lighten(40%))
}

#let section_header(section_title, colors) = {
    text(section_title, font: "Noto Sans", size: 18pt, weight: "light", fill: colors.dark)
}

#let personal_section(personal_data, colors) = {
    let fragments = ()
    for (key, value) in personal_data {
        fragments.push(
            text(key, font: "Noto Sans", size: 10pt, weight: "light", fill: colors.theme_color.lighten(40%))
            + v(4pt, weak: true)
            + text(value, font: "Noto Sans", size: 12pt, weight: "regular", fill: colors.dark)
        )
    }

    grid(
        ..fragments,
        columns: (31%, 32%, 33%),
        column-gutter: 10%,
        row-gutter: 16pt
    )
}

#let languages_section(section_title, languages, colors) = {
    box(
        section_header(section_title, colors)
        + v(14pt, weak: true)
        + for (lang, level) in languages {
            text(lang, font: "Noto Sans", size: 12pt, weight: "regular", fill: colors.dark)
            h(2pt)
            box(
                fill: colors.theme_color.lighten(95%),
                radius: 2pt,
                baseline: 2pt,
                pad(
                    4pt, 
                    text(level, font: "Noto Sans", size: 10pt, weight: "regular", fill: colors.dark)
                )
            )
            h(12pt)
        }
    )
}

#let skills_section(section_title, hint, skill_groups, colors) = {
    box(
        section_header(section_title, colors)
        + if hint != "" {
            v(10pt, weak: true)
            text(hint, font: "Noto Sans", size: 8pt, style: "italic", fill: colors.dark.lighten(30%))
        }
        + v(14pt, weak: true)
        + for group in skill_groups {
            if group.group_title != "" {
                box(
                    fill: colors.theme_color.lighten(95%),
                    radius: 2pt,
                    pad(
                        4pt, 
                        text(group.group_title, font: "Noto Sans", size: 10pt, weight: "regular", fill: colors.dark)
                    )
                )
                v(8pt, weak: true)
            }

            for (i, skill) in group.advanced_skills.enumerate() {
                if i != 0 {
                    h(6pt)
                    text("•", font: "Noto Sans", size: 12pt, fill: colors.theme_color.lighten(25%))
                }
                box(
                    pad(
                        1pt,
                        h(6pt)
                        + strong(text(skill, font: "Noto Sans", size: 12pt, fill: colors.dark))   
                    )
                )
            }

            let has_advanced_skills = group.advanced_skills.len() > 0
            for (i, skill) in group.skills.enumerate() {
                if i != 0 or has_advanced_skills {
                    h(6pt)
                    text("•", font: "Noto Sans", size: 12pt, fill: colors.theme_color.lighten(25%))
                }
                box(
                    pad(
                        1pt,
                        h(6pt)
                        + text(skill, font: "Noto Sans", size: 12pt, fill: colors.dark)
                    )
                )
            }

            v(14pt, weak: true)
        }
    )
}

#let timeline_section(section_title, timeline_data, colors) = {
    section_header(section_title, colors)
    v(18pt, weak: true)
    for value in timeline_data {
        pad(
            left: 2pt,
            box(
                inset: (left: 10pt, bottom: 4pt, top: 4pt, rest: 0pt),
                stroke: (left: 1pt + colors.theme_color.lighten(25%)),
                text(value.from + " - " + value.to, font: "Noto Sans", size: 10pt, weight: "light", fill: colors.dark)
                + v(10pt, weak: true)
                + text(value.place, font: "Noto Sans", size: 12pt, weight: "regular", fill: colors.dark)
                + h(12pt, weak: true)
                + text(value.address, font: "Noto Sans", size: 12pt, weight: "regular", fill: colors.dark.lighten(10%))
                + v(12pt, weak: true)
                + text(value.position, font: "Noto Sans", size: 14pt, weight: "regular", fill: colors.dark)     
            )
        )
        list(
            body-indent: 0.3em,
            marker: text("• ", font: "Noto Sans", size: 10pt, weight: "bold", fill: colors.theme_color.lighten(25%)),
            ..value.notes.map(
                note => { 
                    text(note, font: "Noto Sans", size: 10pt, weight: "light", fill: colors.dark) 
                }
            )
        )
        v(18pt, weak: true)
    }
}

#let cv(
    name: "",
    title: "",
    personal: (),
    languages: (),
    skills: (),
    timelines: (),
    theme_color: purple,
    dark: rgb("#404040"),
    languages_section_title: "Languages",
    skills_section_title: "Skills",
    advanced_skills_hint: "Advanced skills in " + strong("Bold"),
) = {
    let colors = (
        theme_color: theme_color,
        dark: dark
    )
    cv_header(name, title, colors)
    v(32pt, weak: true)
    personal_section(personal, colors)
    v(32pt, weak: true)
    languages_section(languages_section_title, languages, colors)
    v(32pt, weak: true)
    skills_section(skills_section_title, advanced_skills_hint, skills, colors)
    v(32pt, weak: true)
    for (timeline_title, data) in timelines {
        timeline_section(timeline_title, data, colors)
        v(32pt, weak: true)
    }
}

#let skills_group_struct(
    group_title: "",
    advanced_skills: (),
    skills: ()
) = {
    return (
        group_title: group_title,
        advanced_skills:advanced_skills,
        skills: skills
    )
}

#let timeline_struct(
    from: "",
    to: "",
    place: "",
    address: "",
    position: "",
    notes: ()
) = {
    return (
        from: from,
        to: to,
        place: place,
        address: address,
        position: position,
        notes: notes
    )
}
