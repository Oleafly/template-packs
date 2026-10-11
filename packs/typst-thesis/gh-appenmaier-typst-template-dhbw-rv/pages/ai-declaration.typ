/// Renders the AI declaration page (Erklärung und Nutzungsdokumentation KI-Werkzeuge).
/// - labels (dict): UI label dictionary from labels.typ
/// - margin (dict): Page margins, must match the global margin setting
/// -> none
#let ai-declaration(
  labels: (:),
  margin: (:),
) = {
  import "common.typ": signature-grid, centered-declaration-heading
  set page(header: none, margin: margin)

  centered-declaration-heading(labels.ai-declaration-title)

  v(1cm)
  set par(leading: 0.65em)
  labels.ai-declaration-intro
  v(1cm)

  set list(indent: 0pt, body-indent: 0.8em, spacing: 0.8em)
  list(..labels.ai-declaration-items)

  v(7cm)

  align(center)[
    #signature-grid(
      [#labels.place-date],
      [#labels.signature],
    )
  ]
}
