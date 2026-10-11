= Introduction
<chapter:example>

#import "../config.typ": logo-faculty
#import "@preview/glossarium:0.5.10": gls

#emph[General instructions:] You should make use of our outline for
structuring your thesis. The specific outline is determined by your
thesis type. Please refer to the outlines at
#link("https://oss.cs.fau.de/theses/structure-content/");.

#emph[LaTeX~instructions:] Here is an example citation
@riehle:2011:controlling. #cite(<riehle:2007:economic>, form: "prose")
gave another example citation.

#figure(
  image("../" + logo-faculty, width: 50%),
  caption: [Example of a Figure]
) <fig:example>

== Example subchapter
This is an example of a subchapter. You can refer to the figure.

= Another Example Chapter
<cahpter:another-example>
All chapters shall start on a right page!

For more convenient creation of latex tables we recommend:

#link("https://www.tablesgenerator.com/")

#block[
#figure(
  align(center)[#table(
    columns: 2,
    align: (left,left,),
    table.header([Nice column], [Very nice column],),
    table.hline(),
    [some content], [some more content],
    [some information], [some ... (you guess what)],
  )]
  , caption: [Example of a Table]
  , kind: table
  )

] <tab:example>
I am using the #gls("FACR") here. The second usage of #gls("FACR") will only display
the acronym itself.
#pagebreak()
Some more text.
#pagebreak()
Even more text on next site.
