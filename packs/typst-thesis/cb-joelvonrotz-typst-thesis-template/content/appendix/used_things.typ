#import "/imports.typ": *

== Toolchain and Software <sec:appendix:toolchain-software>

A collection of all the tools used for this project and thesis. The exact versions are given if found.

#drafting.inline-note[Fill in the things and update respective info (paths, versions, system informations).]

#[
  // create scope for local changes

  #set terms(separator: sym.space, hanging-indent: 1.5em)

  #let entry(name, version, description, link) = {
    show grid: set block(below: 1.5em)
    grid(
      columns: (1fr, auto),
      [#name  #if version != none [(#version)]],
      text(
        0.8em, std.link(link, text(blue, font: "JetBrains Mono")[#link]),
      ),

      if description != none {
        grid.cell(
          colspan: 2,
          inset: (top: 0.75em, left: 1em),
          {
            set par(justify: true)
            description
          },
        )
      },
    )
  }


  === Operating System

  #let system-info-cells = ```
  Operating System: Penguin Operating System
  Graphics Platform: Ice
  none: none
  Processors: 25 brain cells
  Memory: 16 GiB of RAM bought before 2025
  Graphics Processor: Toaster
  Manufacturer: Snowplow Inc.
  Product Name: Snowbly 26120
  ```.text.matches(regex(`(.*):\s*(.*)`.text)).map(x => {
    if x.captures.first() == "none" {
      none
    } else {
      ([#x.captures.first()], [:], [#x.captures.last()])
    }
  }).flatten().split(none)

  #entry(
    strong[Penguin Operating System],
    none,
    [
      #show grid.cell.where(x: 0): emph
      #show grid.cell.where(x: 2): set text(font: "JetBrains Mono")
      #grid(
        columns: (auto, auto, auto),
        align: (right, right, left),
        row-gutter: 0.5em,
        inset: (x, y) => if x == 0 { (left: 1em) } else if x == 1 { (right: 0.75em) } else { 0pt },

        grid.cell(colspan: 3, align: left, strong[_Software_], inset: (left: 0pt)),
        ..system-info-cells.first(),

        grid.cell(colspan: 3, align: left, strong[_Hardware_], inset: (top: 0.75em, left: 0pt)),
        ..system-info-cells.last(),
      )
    ],
    "https://scar.org/",
  )


  === Writing

  #entry(
    strong[Typst],
    [Version #sys.version],
    [Open source markup-based typesetting system to create documents in similar vein to LaTeX. Developed by Typst GmbH.],
    "https://github.com/typst/typst/",
  )


  === Software

  #entry(strong[Visual Studio Codium], none, none, "https://vscodium.com/")

  === Hardware

  #entry(strong[KiCAD], [Version 10.0.0], [A Cross Platform and Open Source PCB Design Suite.], "https://www.kicad.org/")

  === Fonts

  Listing of all used fonts in this thesis.

  - #entry([Libertinus], [Version 7.051], none, "https://github.com/alerque/libertinus")
  - #entry([JetBrains Mono], [Version 2.304], none, "https://www.jetbrains.com/lp/mono/")
  - #entry([Cantarell], [Version 0.311], none, "https://gitlab.gnome.org/GNOME/cantarell-fonts")

]
