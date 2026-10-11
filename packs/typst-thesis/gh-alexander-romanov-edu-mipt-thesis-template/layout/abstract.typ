#import "/layout/fonts.typ": *

#let abstract(title: "", author: "") = {
  set page(
    margin: (left: 30mm, right: 15mm, top: 20mm, bottom: 20mm), numbering: none, number-align: center, header: grid(
      columns: (1fr), align: (center), v(0.5mm), text(title, size: 12pt), v(1.6mm), grid.hline(),
    ),
  )

  set text(font: fonts.body, size: 10pt, lang: "ru")

  set par(leading: 0.5em)
  // Title and author
  v(10mm)
  align(center, text(font: fonts.sans, 1.5em, weight: 700, "Аннотация"))
  align(center, text(font: fonts.sans, 1.5em, weight: 100, title))
  align(
    center, text(font: fonts.sans, 1.5em, weight: 100, author, style: "italic"),
  )

  v(10mm)
  // Abstract text
  align(
    center, text(
      font: fonts.sans, 1.5em, weight: 100, [
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec placerat orci nec
        quam tristique, in congue ante iaculis. Aliquam mi velit, tristique at orci in,
        tincidunt semper tortor. Maecenas iaculis eleifend libero ut dignissim.
        Phasellus volutpat, urna nec scelerisque congue, dui est auctor erat, id gravida
        ante lorem eu leo. Fusce varius leo non vehicula tempor. Class aptent taciti
        sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Cras
        ultricies efficitur augue, at aliquet metus facilisis id. Nulla semper, ex vitae
        lobortis tristique, risus augue viverra neque, eget convallis sem massa eu est.
        Praesent ac mi sed dui porta posuere id id libero. Quisque vitae augue feugiat,
        blandit urna rhoncus, vestibulum leo. Duis iaculis, lectus sed scelerisque
        varius, lectus nisl semper quam, sit amet consequat sem ante eget ante. Nunc non
        malesuada leo. Aenean fermentum mauris nibh.
      ],
    ),
  )
}
