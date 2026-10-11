#let preface(
    english_title: "",
    dutch_title: "",
    cover_info: "",
    degree: "",
    supervisor: "",
    defense_date: "",
    author: "",
    author_birth: "",
    author_funding: "",
) = {
    set page(
        width: 170mm,
        height: 240mm,
    )

    set text(
        font: "Libertinus Serif",
        size: 10pt,
        lang: "en",
    )

    set par(justify: true, leading: 1em)

    v(30%)

    align(center, text(size: 25pt, weight: "bold", english_title))
    align(center, line(length: 70%))

    pagebreak()

    [*Cover:* #h(0.5em) #cover_info]

    v(1fr)

    [
        #degree Thesis, Utrecht University, The Netherlands, 2025 \
        ISBN: 978-90-123456-0-3 \
        Printed by: PrinterName, City, Country \
        A digital version of this thesis is available at: http://www.example.com/thesis.pdf
    ]

    pagebreak()

    set par(leading: 0.65em)

    v(3em)

    align(center, text(size: 20pt, weight: "bold", english_title))
    align(center, line(length: 40%))
    align(center, text(size: 20pt, lang: "nl", dutch_title))
    align(center, [(met een samenvatting in het Nederlands)])

    v(1fr)

    align(center, text(size: 14pt, [Proefschrift]))

    v(1em)

    align(
      center,
      text(
        lang: "nl",
        [ter verkrijging van de graad van doctor aan de Universiteit Utrecht op gezag van de rector magnificus, prof. dr. ir. Wilco Hazeleger, ingevolge het besluit van het college voor promoties in het openbaar te verdedigen op #defense_date],
      ),
    )
    align(center, [door])

    v(1em, weak: true)

    align(center, text(size: 14pt, author))
    align(center, [geboren op #author_birth])

    pagebreak()

    [*Promotor:* #h(0.5em) #supervisor]

    v(1fr)

    [This research was supported by #author_funding.]
}
