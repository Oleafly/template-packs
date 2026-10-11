//---------------------------------------------------------------------
= Data <ch:data>
//---------------------------------------------------------------------

#lorem(200)

#lorem(300)

#lorem(100)

#lorem(200)

Data are based in the repository#footnote[#link("https://github.com/th-nuernberg/thesis-template-typst")].
The data is stored in the `data` directory, and the code for processing the data is stored in the `code` directory.

@tab:example shows an example dataset that we will use for our experiments.

#figure(
    table(
    columns: 3,
    align: (left, center, right),
    table.hline(),
    table.header([*Name*], [*Value*], [*Unit*]),
    table.hline(),
    [Temperature], [23.5], [°C],
    [Pressure],    [1013], [hPa],
    [Humidity],    [45],   [%],
    table.hline(),
  ),
  caption: [Example Dataset],
) <tab:example>
