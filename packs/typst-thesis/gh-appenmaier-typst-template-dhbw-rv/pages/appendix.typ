/// Renders the appendix with the AI tools table.
/// - labels (dict): UI label dictionary
/// -> none
#let appendix(labels: (:)) = {
  import "../user/ai-tools.typ": ai-tools

  [
    #heading(level: 1, numbering: none)[#labels.appendix]
    #heading(level: 2, numbering: none)[#labels.appendix-ai-heading]
    #figure(
      kind: table,
      supplement: labels.supplement-table,
      caption: [#labels.appendix-ai-caption],
      table(
        columns: (3.8cm, 1fr),
        stroke: 0.5pt,
        inset: (x: 6pt, y: 5pt),
        align: (left + top, left + top),
        table.header(
          strong[#labels.appendix-ai-col1],
          strong[#labels.appendix-ai-col2],
        ),
        ..for (name, items) in ai-tools {
          (
            name,
            {
              set list(indent: 0pt, body-indent: 0.5em, spacing: 0.3em)
              set par(leading: 0.55em)
              list(..items)
            },
          )
        }
      ),
    ) <ai-tools>
  ]
}
