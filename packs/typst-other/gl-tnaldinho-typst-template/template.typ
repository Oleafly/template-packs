// Define document-wide styles and fonts
#let project(body) = {
  // Set the document's base font and size

  set text(
    font: "IBM Plex Serif",
    size: 10pt,
    fallback: true,
    hyphenate: true,
    costs: (hyphenation: 20%, runt: 100%, widow: 100%, orphan: 1000%),
  )
  set par(justify: true)

  // Set raw (code) text to use IBM Plex Mono
  show raw: text.with(font: "IBM Plex Mono", size: 10pt, fallback: true)

  // Initialize level 2 heading counter
  counter("l2").update(0)

  // Style headings
  show heading: it => {
    if it.level == 1 {
      // Reset counter when level 1 heading is encountered
      counter("l2").update(1)

      text(
        font: "IBM Plex Sans",
        weight: "bold",
        style: "normal",
        it.body,
      )
    } else if it.level == 2 {
      // Increment counter and add numbering for level 2 headings
      counter("l2").step()

      text(
        font: "IBM Plex Sans",
        weight: "bold",
        style: "normal",
        [#counter("l2").display(). #it.body],
      )
    } else {
      // Other heading levels remain unchanged
      text(
        font: "IBM Plex Sans",
        weight: "bold",
        style: "normal",
        it.body,
      )
    }

    // Add spacing after heading
    v(-5pt)
  }

  // Return the document body
  body
}

// Define the title function that creates a table with the specified fields
#let title(
  author: "Tomás Naldinho",
  title: "",
  subtitle: "",
  info: "",
  email: "naldinho@kth.se",
  date: datetime.today().display("[month repr:long] [day], [year]"),
) = {
  table(
    columns: (2fr, 1fr),
    align: (left + bottom, right + bottom),
    stroke: none,
    inset: 0pt,
    [
      #text(font: "IBM Plex Sans", size: 2em, weight: "bold", title)\
      #text(font: "IBM Plex Sans", subtitle)\
      #text(font: "IBM Plex Sans", style: "italic", info)\
    ],
    [
      #text(font: "IBM Plex Sans", date)\
      #text(font: "IBM Plex Sans", author)\
      #text(font: "IBM Plex Mono", email)\
    ],
    v(0.5em),
    table.hline(),
  )
}
