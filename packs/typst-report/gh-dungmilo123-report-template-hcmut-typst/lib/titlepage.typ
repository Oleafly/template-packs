#import "utils.typ": duallang

#let titlepage(
    project: "",
    subject: "",
    instructors: (),
    implementers: (),
    university_0: "VIETNAM NATIONAL UNIVERSITY - HO CHI MINH CITY",
    university_1: "HO CHI MINH CITY UNIVERSITY OF TECHNOLOGY",
    faculty: "FACULTY OF COMPUTER SCIENCE AND ENGINEERING",
    logo-path: "../lib/template/logo.png",
    location: "Ho Chi Minh City",
    lang: "en",
) = {
    set page(
        header: none,
        footer: none,
        margin: (y: 2cm, x: 2cm),
    )

    align(center)[
        #set text(weight: "bold", size: 14pt)
            #par(leading: 0.5em)[
                #upper(university_0) \
                #upper(university_1) \
            ]
        #text(weight: "bold", size: 12pt)[
            #upper(faculty)
        ]

        #v(64pt)

        #image(logo-path, height: 5cm)

        #v(64pt)

        #text(weight: "bold", size: 12pt)[
            #if subject != "" {
                upper(subject)
            } else {
                duallang(lang, "Subject: ..............................", "Môn học: ..............................")
            }
        ]

        #v(1em)
        #line(length: 100%, stroke: 0.5pt)
        #v(1em)

        #text(weight: "bold", size: 16pt, style: "italic")[
            #if project != "" {
                upper(project)
            } else {
                duallang(lang, "Project: ..............................", "Bài tập lớn: ..............................")
            }
        ]

        #v(1em)
        #line(length: 100%, stroke: 0.5pt)
        #v(2em)

        // Info section
        #set text(weight: "regular", size: 11pt)
        #align(left)[
            #let label-col = 35%
            #grid(
                columns: (label-col, 1fr),
                row-gutter: 1.5em,

                // Instructors:
                strong(duallang(lang, "Instructor(s):", "GV Hướng dẫn:")),
                if instructors.len() > 0 {
                    instructors.join(" \ ")
                } else {
                    dots
                },

                // Implementers:
                strong(duallang(lang, "Implementer(s):", "SV Thực hiện:")),
                if implementers.len() > 0 {
                    grid(
                        columns: (2fr, 1fr),
                        gutter: 1em,
                        ..implementers.map(s => (s.at(0), s.at(1))).flatten()
                    )
                } else {
                    dots
                },
            )
        ]

        #v(1fr)

        // Date & Location
        #text(size: 11pt)[
            #location, 
            #duallang(
                lang,
                datetime.today().display("[month repr:numerical]-[year]"),
                [tháng #datetime.today().month() năm #datetime.today().year()],
            )
        ]
    ]
    pagebreak()
}