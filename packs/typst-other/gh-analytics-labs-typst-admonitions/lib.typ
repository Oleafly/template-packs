#let admonition(
  type: none, // the admonition type, e.g. Tip, Info, Note, Warning, ...
  title: none, // bold title in first line
  icon: none, // admonition icon
  align-icon: center + horizon, // how to align the admonition icon
  icon-color: luma(0%), // admonition icon for textual icons
  bar: none, // right-side bar of the icon
  background-color: none, // the background color of the entire admonition block
  border: (:), // border around the entire admonition block
  radius: (:), // border radius
  inset: (:), // inset of the entire admonition block
  breakable: true, // whether the admonition block is breakable
  text-color: luma(0%), // main body text color
  text-spacing: 1.2em, // spacing between paragraphs in content
  body // actual admonition content
) = {
  // admonitions that are not colored can have inset = 0em
  if background-color != none or border != (:) { inset = 1em }
  block(fill: background-color, radius: radius, stroke: border, inset: inset, breakable: breakable,
    grid(
      columns: (5.2em, 1fr),
      grid.cell(
        stroke: (right: bar),
        inset: (left: -0.25em), 
        align(align-icon, text(bottom-edge: "descender", fill: icon-color, size: 3.3em, icon))
      ),
      grid.cell(
        inset: (left: 1em),
        text(fill: text-color, [
          #set par(spacing: text-spacing)
          #strong(smallcaps(type))#if title != none and type != none [:] #title

          #body
        ])
      )
    )
  )
}