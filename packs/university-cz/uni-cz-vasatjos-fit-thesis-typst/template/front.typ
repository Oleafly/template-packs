#let title-page(
    print,
    title: "",
    author: (
        name: "",
        email: "",
        url: "",
    ),
    submission-date: datetime.today(),
    bachelor: true,
    faculty: "",
    department: "",
    programme: "",
    specialization: "",
    supervisor: "",
    font: "Libertinus Serif",
) = {
    // render as a separate page
    // margins taken from "new" fit-ctu template

    show: page.with(margin: (top: 40mm, bottom: 40mm, left: 50mm, right: 35mm))

    // faculty logo
    image("res/logo-fit-en-black.svg", width: 200pt)
    v(25mm)

    set align(left)
    set place(left)
    set text(font: font)

    {
        if bachelor [
            Bachelor's Thesis
        ] else [
            Master's Thesis
        ]
    }

    v(10mm)

    {
        set text(size: 25pt, weight: "regular")
        [
            #upper(title)
        ]
    }

    v(5mm)
    {
        set text(size: 12.5pt, weight: "regular")
        [
            #author.name
        ]
    }

    v(3fr)
    {
        // set text(size: 10pt, weight: "regular")
        [
            Czech Technical University in Prague\
            Faculty of #faculty\
            Department of #department\
            Study programme: #programme\
            Specialization: #specialization\
            Supervisor: #supervisor\
            \
            #submission-date.display("[day padding:none] [month repr:long] [year]")
        ]
    }
}

#let imprint-page(
    print,
    title: "",
    author: (
        name: "",
        email: "",
        url: "",
    ),
    submission-date: datetime.today(),
    bachelor: false,
    faculty: "",
    department: "",
    programme: "",
    specialization: "",
    supervisor: "",
) = {
    show: page.with(margin: (bottom: 40mm, top: 46mm, left: 39.5mm, right: 40mm))
    //  show: page.with(margin: (bottom: 40mm, top:46mm, inside:47mm, outside:32.5mm))

    set text(weight: "extralight")
    set par(justify: true)
    set align(bottom)

    [
        Czech Technical University in Prague\
        Faculty of #faculty\
        #sym.copyright
        #submission-date.display("[year]")
        #author.name. All rights reserved. \
        #[
            #set text(style: "italic")
            This thesis is school work as defined by Copyright Act of the Czech Republic. It has been
            submitted at Czech Technical University in Prague, Faculty of Information Technology. The
            thesis is protected by the Copyright Act and its usage without author's permission is prohibited
            (with exceptions defined by the Copyright Act).
        ]

        #v(1em)
        Citation of this thesis:
        #author.name.
        #{
            set text(style: "italic")
            title
        }.
        #if bachelor [
            Bachelor's Thesis.
        ] else [
            Master's Thesis.
        ]
        Czech Technical University in Prague,
        Faculty of #faculty,
        #submission-date.display("[year]").
    ]
}
