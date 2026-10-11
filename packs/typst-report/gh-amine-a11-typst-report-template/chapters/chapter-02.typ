#import "../config.typ": *
#import "../style.typ":heading_without_numbering,heading_without_numbering_smallcaps


#v(2.5cm)
#grid(
  columns:(1fr, 0.5fr, 1fr),
  align(center+horizon)[
    #rect(
      height: 2pt,
      width: 100%,
      fill: rgb(0, 0, 0, 1),
      stroke: 3pt+black,
    )
  ],
  align(center+horizon)[
    #heading_without_numbering("Chapter 2")
  ],
  align(center+horizon)[
    #rect(
      height: 2pt,
      width: 100%,
      fill: rgb(0, 0, 0, 1),
      stroke: 3pt+black,
    )
  ],
)

#block(
  width: 100%,
  stroke: (y: 1pt),
  inset: 1em,
  align(center)[
    #show heading.where(level: 1): it => [
    #set text(font: heading_font, size: 24pt, weight: "bold")
    #it.body
  ]
  = Heatmap Optimization Through Vector Tiles
  ],
)
#show outline.entry.where(level: 2): it => link(
  it.element.location(),
  block(text[#it.prefix().text.split(".").at(1) #h(15pt) #it.inner()])
  // it.indented(it.prefix(), it.body())
)
#outline(
  title: [= Contents],
  target: selector(heading.where(level: 2)).after(<start-chap2>).before(<end-chap2>)
)

#metadata("start-chapter2") <start-chap2>

#pagebreak()

#heading_without_numbering_smallcaps("Introduction")

lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit

== lorem ipsum dolor sit amet, consectetur adipiscing elit.

lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.

=== lorem ipsum dolor sit amet.

lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

== Vector Tiles: Conceptual Foundation and Advantages

lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore.

=== Core Concepts of Vector Tiles

Unlike traditional raster tiles that contain pre-rendered images, vector tiles contain geometries and metadata such as road names, place names, and attribute values in a compact, structured format @mapbox_vector_tiles. They store geographic features (points, lines, and polygons) in Protocol Buffer (Protobuf) binary format, which is significantly more compact than text-based formats like GeoJSON. Vector tiles are rendered only when requested by the client (web browser or mobile app), allowing for dynamic styling and smooth interactions.

The world is divided into a pyramid of square tiles at multiple zoom levels. Each tile is uniquely identified by three parameters: $z$ (zoom level), $x$ (column index), and $y$ (row index). At zoom level 0, a single tile represents the entire world. At each subsequent zoom level, tiles subdivide into four child tiles, creating a quadtree structure. At zoom level $z$, there are $2^z times 2^z$ tiles covering the world. This hierarchical structure, illustrated in @fig:tile-pyramid, enables efficient spatial indexing and progressive detail loading.

#figure(
  image("../images/vector_tiles_pyramid_structure.png"),
  caption: [Tile pyramid structure showing quadtree subdivision from zoom level 1 to higher zoom levels, with z/x/y addressing scheme.]
) <fig:tile-pyramid>

Each tile contains only features intersecting its geographic bounds, with features clipped at tile boundaries to avoid duplication. The specification supports multiple zoom levels with progressively detailed representations at low zoom levels, features are simplified or clustered, while at high zoom levels, more detailed geometries are included.

== Results and Performance Improvements

lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.

#figure(
  table(
    columns: 3,
    align: (left, center, center),
    table.header([*Metric*], [*GeoJSON*], [*Vector Tiles*]),
    [Load Time (Low Zoom)], [8-12 seconds], [1-2 seconds],
    [Load Time (High Zoom)], [2-4 seconds], [< 1 second],
    [Data Transfer (Low Zoom)], [5-15 MB], [200-500 KB],
    [Server CPU Utilization], [High (100%)], [Low (20-40%)],
    [Frame Rate], [10-20 fps], [60 fps],
    [Cache Hit Rate], [0%], [70-80%],
  ),
  caption: [Performance comparison between GeoJSON and vector tile approaches.]
) <tbl:performance-comparison>


#heading_without_numbering_smallcaps("Conclusion")
lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.

#metadata("end-chapter2") <end-chap2>
