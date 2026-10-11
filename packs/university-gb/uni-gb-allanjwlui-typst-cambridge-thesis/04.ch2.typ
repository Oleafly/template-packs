#import "cambridge.typ": *
//#show: chapter
//#bibliography("Thesis.20250819.bib",style: "nature-no-et-al.csl")

= Figures / Tables
== Default figures
Default figures are generally center aligned to the page by default, with left aligned captions. 

Note how the caption alignment only applies within the width of the listing/table, which works for short captions:
#figure(
  ```python
print("Hello, world!")
```,
  caption: [Test listing]
)

#figure(table(columns: 4, rows: 2, 
        [*Key*], [*Value*],[Col3],[Col4]
        ),
        caption: [Test Table])


Image captions are aligned to the page by default in this template to accommodate long captions and to standardise caption placement for images of different sizes:
#figure(image("./CollegeShields/CUni.svg"), caption: [Test figure caption. #lorem(20)])

#figure(image("./CollegeShields/CUni.svg", width: 100%), caption: [Test figure caption.])

\
You can change this like so:
//set caption alignment to center of page
#show figure.caption: it => {caption-style(it, leading: 0.75em, alignment: center)}
#figure(image("./CollegeShields/CUni.svg", width: 100%), caption: [Test figure caption #lorem(2)])

#show figure.caption: it => {caption-style(it, leading: 0.75em, alignment: left)}


== Default figures with descriptions
This template introduces a function for including detailed descriptions with figures: ```typst #figure-with-description```.\
Default text are all left aligned and justified by default to accommodate full-width figures and tables:


#figure-with-description(
  table(columns: (1fr,1fr,1fr,1fr,1fr,1fr,1fr,1fr,1fr,1fr,), rows: 2, 
        [*Key*], [*Value*], [*Value*], [*Value*], [*Value*], [*Value*], [*Value*], [*Value*], [*Value*], [*Value*]
        ),
        caption: [Test Table],
        [This is a table. #lorem(50)])

#figure-with-description(image("./CollegeShields/CUni.svg", width: 100%), 
  caption: [Test figure image 2], [This is a description. #lorem(50)])

#pagebreak()
== Formatted tables
This template also introduces a function for formatting tables: ```typst #table-format```:

#figure-with-description(
  table-format(
    columns: (1fr,1fr,1fr,1fr,1fr,1fr,1fr,1fr,1fr,1fr,), rows: 2, 
    [*Key*], [*Value*], [*Value*], [*Value*], [*Value*], [*Value*], [*Value*], [*Value*], [*Value*], [*Value*],
    [1],[2],[3],[4],[5],[6],[7],[8],[9],[10],
    [1],[2],[3],[4],[5],[6],[7],[8],[9],[10],
    [1],[2],[3],[4],[5],[6],[7],[8],[9],[10],
    [1],[2],[3],[4],[5],[6],[7],[8],[9],[10],
    ),
    caption: [Formatted Table],
    [This is a table. #lorem(10)]
  )

The number of header rows can be set with the  ```typst header``` argument. \
```typst #table-format(header: 2)``` yields the following table:
#figure-with-description(
  table-format(
    header: 2,
    columns: (1fr,1fr,1fr,1fr,1fr,1fr,1fr,1fr,1fr,1fr,), rows: 2, 
    [*Key*], [*Value*], [*Value*], [*Value*], [*Value*], [*Value*], [*Value*], [*Value*], [*Value*], [*Value*],
    [1],[2],[3],[4],[5],[6],[7],[8],[9],[10],
    [1],[2],[3],[4],[5],[6],[7],[8],[9],[10],
    [1],[2],[3],[4],[5],[6],[7],[8],[9],[10],
    [1],[2],[3],[4],[5],[6],[7],[8],[9],[10],
    ),
    caption: [Formatted Table with 2 header rows],
    [This is a table. #lorem(10)]
  )