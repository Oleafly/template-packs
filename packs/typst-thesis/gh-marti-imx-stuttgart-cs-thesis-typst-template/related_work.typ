#import "utils/global-imports.typ": * 


= Related Work

#blindtext(paragraphs: 15, length: "medium", lang: "en")

#show table.cell.where(y: 0): strong
#show table: set par(justify: false)
#figure(
  table(
    align: left,
    table.header([Function Names], [Description], [Arguments], [Returns]),
    columns: 4,
    inset: (x: 2mm),
    [*`detect_objects`*], [Extracts contiguous segments per color and orientation], [grid ssp], [dictionary  \ of lists],
    [*`get_grid_orientation`*], [Determines pattern orientation based on length of longest object], [grid ssp], [orientation],
    [*`delete_area`*], [Removes specified regions or colors from the SSP representation], [grid ssp,\ position, size, \ filter list], [grid ssp],
    [*`get_all_colors`*], [Identifies and ranks colors in the grid by their prominence in the SSP], [grid ssp], [sorted list],
    [*`encode_rect_shape`*], [Encodes a rectangular border of a given color into an existing SSP], [ssp, position,\ dimensions, \ color], [grid ssp]
  ),
  caption: [Overview of all functions reused across task solvers.] + [These functions are referred to as modules throughout the text.],
  placement: top
)




