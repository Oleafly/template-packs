= Another content which is not part of the thesis

#lorem(100)

#text(blue)[
  There are a testing image in appendix.
]

#figure(image("../assets/Test.svg", width: 30%), caption: [Test image 1 (appendix)]) <fig:example_image1_appendix>

#figure(image("../assets/Test.svg", width: 45%), caption: [Test image 2 (appendix)]) <fig:example_image2_appendix>


#text(blue)[
  Referencing images @fig:example_image1_appendix and @fig:example_image2_appendix.
]

#figure(
  table(
    columns: 3,
    [], [*Col 1*], [*Col 2*],
    [Row 1], [Content], [Content],
    [Row 2], [Content], [Content],
  ),
  caption: [Example of a Table 1 (appendix)],
) <tab:example_table1_appendix>

#figure(
  table(
    columns: 3,
    [], [*Col 1*], [*Col 2*],
    [Row 1], [Content], [Content],
    [Row 2], [Content], [Content],
  ),
  caption: [Example of a Table 2 (appendix)],
) <tab:example_table2_appendix>

#figure(
  table(
    columns: 3,
    [], [*Col 1*], [*Col 2*],
    [Row 1], [Content], [Content],
    [Row 2], [Content], [Content],
  ),
  caption: [Example of a Table 3 (appendix)],
) <tab:example_table3_appendix>

#text(blue)[
  Referencing tables @tab:example_table1_appendix, @tab:example_table2_appendix, and @tab:example_table3_appendix.
]