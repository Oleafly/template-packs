/// Renders the confidentiality notice (Sperrvermerk) page.
/// - labels (dict): UI label dictionary from labels.typ
/// - margin (dict): Page margins, must match the global margin setting
/// -> none
#let confidentiality-notice(
  labels: (:),
  margin: (:),
) = {
  import "common.typ": signature-grid, centered-declaration-heading
  set page(header: none, margin: margin)

  centered-declaration-heading(labels.confidentiality-title)

  align(center)[
    #v(1cm)
    #set par(leading: 0.65em)
    #labels.confidentiality-law

    #v(1cm)
    #labels.confidentiality-body

    #v(7cm)

    #signature-grid(
      [#labels.place-date],
      [#labels.signature],
    )
  ]

  pagebreak()
}
