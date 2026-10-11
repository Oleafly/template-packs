= Methodology

Detailed explanation of methodology used.

#figure(
  [
    #import "@preview/cetz:0.4.1"
    #cetz.canvas({
      import cetz.draw: *

      // Set default arrow style
      set-style(mark: (end: ">"))

      // Define box dimensions for easy adjustment
      let box-width = 4.3
      let box-height = 1
      let v-spacing = 1 // vertical spacing between boxes
      let h-spacing = 1 // horizontal spacing between columns

      // Column 1 - Main workflow
      // Requirement Gathering
      rect((0, 0), (box-width, -box-height), name: "req-gather")
      content("req-gather", box(fill: white, [Requirement Gathering]))

      // Design
      let design-y = -box-height - v-spacing
      rect((0, design-y), (box-width, design-y - box-height), name: "design")
      content("design", box(fill: white, [Design]))

      // Prototype
      let prototype-y = design-y - box-height - v-spacing
      rect((0, prototype-y), (box-width, prototype-y - box-height), name: "prototype")
      content("prototype", box(fill: white, [Prototype]))

      // Testing
      let testing-y = prototype-y - box-height - v-spacing
      rect((0, testing-y), (box-width, testing-y - box-height), name: "testing")
      content("testing", box(fill: white, [Testing]))

      // Column 2 - Refined workflow
      let col2-x = box-width + h-spacing

      // Refined Prototype (aligned with Design)
      rect((col2-x, design-y), (col2-x + box-width, design-y - box-height), name: "refined")
      content("refined", box(fill: white, [Refined Prototype]))

      // Evaluation (aligned with Testing)
      rect((col2-x, testing-y), (col2-x + box-width, testing-y - box-height), name: "evaluation")
      content("evaluation", box(fill: white, [Evaluation]))

      // Column 3 - Final Product
      let col3-x = col2-x + box-width + h-spacing

      // Final Product (aligned with Design/Refined)
      rect((col3-x, design-y), (col3-x + box-width, design-y - box-height), name: "final")
      content("final", box(fill: white, [Final Product]))

      // Dynamic connections using anchors
      // Requirement -> Design
      line("req-gather.south", "design.north")

      // Design -> Prototype
      line("design.south", "prototype.north")

      // Prototype -> Testing
      line("prototype.south", "testing.north")

      // Testing -> Evaluation
      line("testing.east", "evaluation.west")

      // Evaluation -> Refined Prototype
      line("evaluation.north", "refined.south")

      // Refined -> Design (feedback loop)
      line("refined.west", "design.east")

      // Refined -> Final Product
      line("refined.east", "final.west")
    })
  ],
  caption: [
    Prototype Model
  ],
)


== Development Approach

Iterative Approach / The approach you used.
