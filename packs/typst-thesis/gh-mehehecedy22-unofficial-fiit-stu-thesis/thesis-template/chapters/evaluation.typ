= Evaluation

#lorem(10)

#text(blue)[
  @fig:example_image_3_1 shows example image.
]
#lorem(20)

#figure(image("../assets/Test.svg", width: 50%), caption: [Test image 1 (chapter 3)]) <fig:example_image_3_1>

#figure(image("../assets/Test.svg", width: 25%), caption: [Test image 2 (chapter 3)]) <fig:example_image_3_2>

#text(blue)[
  Referencing image @fig:example_image_3_2.
]

#text(blue)[
  @tab:example_table_3_1 shows example of table in this template.
]
#lorem(10)

#figure(
  table(
    columns: 3,
    [], [*Col 1*], [*Col 2*],
    [Row 1], [Content], [Content],
    [Row 2], [Content], [Content],
  ),
  caption: [Example of a Table 1 (chapter 3)],
) <tab:example_table_3_1>

#lorem(100)
