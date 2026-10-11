#import "education.typ": education_entry
#import "skill_entries.typ": skill_entries
#import "pubcontrib.typ": public_contributions_entries

#let cv_header(
    name: "Golovach Lena",
    title: "Senior Pomidor",
    agenda: "I'm super passionate developer with Web3 intentions",
    color: eastern,
) = {
    set par(leading: 0.3em, justify: true, linebreaks: auto)
    let nname = block(text(font: "Podkova", size: 25pt, weight: "extrabold", )[
        #name
    ])
    let ntitle = block(
            text(
                font: "PT Sans",
                size: 12pt,
                style: "italic",
                weight: "bold",
                fill: color.lighten(0%)
            )[#title]
        )
    let nagenda = block(text(size: 8pt, weight: "light")[#agenda])

    block()[
        #nname
        #ntitle
        #nagenda
    ]
}

#let job_entry(
    job,
    hack_font,
    curvy_font: "Podkova",
    main_color: eastern,
    show_separator: true,
) = {
    let place = if job.at("company_url", default: none) != none {
        link(job.company_url)[
            #text(
                font: curvy_font,
                weight: "extrabold",
                size: 12pt,
                style: "italic",
            )[#job.company]
        ]
    } else {
        text(
            font: curvy_font,
            size: 12pt,
            style: "italic",
            // fill: main_color.lighten(30%)
        )[#job.company]
    }

    let period = block(width: 100%)[
        #align(
            end,
            text(
                font: hack_font, size: 8pt, weight: "bold"
            )[
                #job.start_date.display("[month repr:long] [year repr:full]")
                #raw("-")
                #if job.at("end_date", default: none) != none [
                    #job.end_date.display("[month repr:long] [year repr:full]")
                ] else [Present]
            ]
        )
    ]

    block(
        width: 100%,
        below: 10pt,
    )[
        #set par(leading: 0.3em, justify: true, linebreaks: "optimized")
        #block(below: 0.3em)[#grid(
            columns: 2,
            rows: 1,
            place,
            period,
        )]
        #block(below: 0.3em)[#text(
            font: hack_font,
            size: 9pt,
            style: "italic",
            fill: main_color.lighten(0%),
            weight: "extrabold"
        )[#job.title]]
        #show list: set list(tight: true, spacing: 0.3em)
        #if job.at("summary", default: none) != none [
            #text(size: 8pt, weight: "light")[#job.summary]
        ]
        #for highlight in job.highlights [
            - #text(size: 8pt, weight: "light")[#highlight]
        ]
        #if show_separator [
            #line(length: 100%, stroke: (
                thickness: 2pt,
                paint: main_color.lighten(85%),
                cap: "butt",
                dash: "dashed"
            ))
        ]
    ]
}

#let jobs_entry(
    jobs: (),
    hack_font,
) = {
    let color = eastern
    let jobs_blocks = jobs.enumerate().map(((idx, job)) => job_entry(
        job,
        hack_font,
        show_separator: idx < jobs.len() - 1,
    )).join()

    block(
        width: 100%,
        height: 100%,
        radius: 3pt,
        outset: 8pt,
        inset: 0pt,
        fill: color.lighten(90%),
    )[
        #pad(x: 0.25pt, y: 2pt)[
            #block(
                width: 100%,
                radius: 3pt,
                inset: (x: 10pt, y: 10pt),
                fill: white,
            )[
                #block(below: 20pt)[
                    #text(
                        font: hack_font,
                        size: 11pt,
                        weight: "bold",
                        fill: color.darken(15%)
                    )[Experience]
                ]
                #jobs_blocks
            ]
        ]
    ]
}

#let cv_contact(
    email: none,
    mobile: none,
    linkedin: none,
    github: none,
    website: none,
    location: none,
    color: eastern,
) = {
    let spacing = 7pt
    let font = "PT Sans"
    show link: underline
    block(
        radius: 3pt,
        outset: 8pt,
        inset: 0pt,
        fill: color.lighten(90%),
        width: 100%,
        height: 100%
    )[
        #align(left + horizon)[
            #if email != none {
                block(spacing: spacing)[
                    #text(font: font, size: 8pt, weight: "bold")[Email: ]
                    #text(size: 9pt, weight: "light", stretch: 100%)[#link("mailto:"+email)]
                ]

            }
            #if mobile != none {
                block(spacing: spacing)[
                    #text(font: font, size: 8pt, weight: "bold")[Phone: ]
                    #text(size: 9pt, weight: "light", stretch: 100%)[#link("tel:"+mobile)]
                ]

            }
            #if linkedin != none {
                block(spacing: spacing)[
                    #text(font: font, size: 8pt, weight: "bold")[LinkedIn: ]
                    #text(size: 9pt, weight: "light", stretch: 100%)[#link("https://linkedin.com/in/"+linkedin)[#linkedin]]
                ]

            }
            #if github != none {
                block(spacing: spacing)[
                    #text(font: font, size: 8pt, weight: "bold")[GitHub: ]
                    #text(size: 9pt, weight: "light", stretch: 100%)[#link("https://github.com/"+github)[#github]]
                ]
            }
            #if website != none {
                block(spacing: spacing)[
                    #text(font: font, size: 8pt, weight: "bold")[Website: ]
                    #text(size: 8pt, weight: "light", stretch: 100%)[#link(website)]
                ]
            }
            #if location != none {
                block(spacing: spacing)[
                    #text(font: font, size: 8pt, weight: "bold")[Location: ]
                    #text(size: 9pt, weight: "light", stretch: 100%)[#location]
                ]
            }
        ]
    ]
}

#let cv(
    name: "Golovach Lena",
    title: "Senior Pomidor",
    summary: "I am actively seeking perfect opportunities to apply my knowledge in ML-backed and high-load/Big Data projects.",
    jobs: (),
    skills: (),
    education: (),
    public_contributions: (),
    hack_font: "PT Sans",
    curvy_font: "Podkova",
    main_color: eastern
) = {
    set page(paper: "a4", margin: (x: 20pt, y: 20pt))
    set par(justify: true, linebreaks: "simple")
    set text(font: "PT Sans", stretch: 100%)
    layout(size => {
        let gutter = 16pt
        let right-width = (size.width - gutter) / 3
        let left-width = right-width * 2

        let header = cv_header(
            name: name,
            title: title,
            agenda: summary,
        )
        let contact = cv_contact(
            email: "rubinsteindb@gmail.com",
            mobile: "+972(54)-357-69-69",
            linkedin: "virviil",
            github: "virviil",
            // website: "https://ilhub.io",
            location: "Ramat Gan, Israel",
            color: main_color,
        )

        let header-height = measure(header, width: left-width).height
        let contact-height = measure(contact, width: right-width).height
        let top-height = if header-height > contact-height { header-height } else { contact-height }

        grid(
            columns: (2fr, 1fr),
            rows: (auto, 1fr),
            column-gutter: gutter,
            row-gutter: 16pt,
            block(height: top-height)[#header],
            block(height: top-height)[#contact],
            jobs_entry(jobs: jobs, hack_font),
            block(
                width: 100%,
                height: 100%,
                radius: 3pt,
                outset: 8pt,
                inset: 4pt,
            )[
                #skill_entries(skills)
                #education_entry(education, hack_font)
                #public_contributions_entries(public_contributions)
            ],
        )
    })
}
