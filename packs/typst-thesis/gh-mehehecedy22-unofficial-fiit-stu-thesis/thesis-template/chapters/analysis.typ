= Analysis

#lorem(250)

#figure(image("../assets/Test.svg", width: 50%), caption: [Test image 1 (chapter 2)]) <fig:example_image_2_1>

#figure(image("../assets/Test.svg", width: 50%), caption: [Test image 2 (chapter 2)]) <fig:example_image_2_2>

#text(blue)[
  Referencing images @fig:example_image_2_1 and @fig:example_image_2_2.
]

#lorem(250)


#figure(
  table(
    columns: 3,
    [], [*Col 1*], [*Col 2*],
    [Row 1], [Content], [Content],
    [Row 2], [Content], [Content],
  ),
  caption: [Example of a Table 1 (chapter 2)],
) <tab:example_table_2_1>

#figure(
  table(
    columns: 3,
    [], [*Col 1*], [*Col 2*],
    [Row 1], [Content], [Content],
    [Row 2], [Content], [Content],
  ),
  caption: [Example of a Table 2 (chapter 2)],
) <tab:example_table_2_2>

#figure(
  table(
    columns: 3,
    [], [*Col 1*], [*Col 2*],
    [Row 1], [Content], [Content],
    [Row 2], [Content], [Content],
  ),
  caption: [Example of a Table 3 (chapter 2)],
) <tab:example_table_2_3>

#text(blue)[
  Referencing tables @tab:example_table_2_1, @tab:example_table_2_2, and @tab:example_table_2_3.
]