#import "cambridge.typ": *
//#show: appendix

= Supplementary tables<supplementary-tables>
#pagebreak()

#figure(
  table-format(
    columns: (1fr,1fr,1fr,1fr,1fr,1fr,1fr,1fr,1fr,1fr,), rows: 2, 
    [*Key*], [*Value*], [*Value*], [*Value*], [*Value*], [*Value*], [*Value*], [*Value*], [*Value*], [*Value*],
    [1],[2],[3],[4],[5],[6],[7],[8],[9],[10],
    [1],[2],[3],[4],[5],[6],[7],[8],[9],[10],
    [1],[2],[3],[4],[5],[6],[7],[8],[9],[10],
    [1],[2],[3],[4],[5],[6],[7],[8],[9],[10],
    ),
    caption: [Formatted Table],
    kind: "Supplementary Table",
    supplement: "Supplementary Table"
  )

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
    kind: "Supplementary Table",
    [This is a supplementary table.]
  )