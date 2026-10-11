/// Renders the declaration of independent authorship (Selbständigkeitserklärung).
/// - labels (dict): UI label dictionary from labels.typ
/// - doc-type (str): Document type key; determines the document name shown in the text
/// - title (str): Document title
/// - subtitle (str): Document subtitle
/// - margin (dict): Page margins, must match the global margin setting
/// -> none
#let declaration(
  labels: (:),
  doc-type: "project",
  title: "",
  subtitle: "",
  margin: (:),
) = {
  import "common.typ": signature-grid, centered-declaration-heading
  set page(header: none, margin: margin)

  let doc-name = labels.doc-names.at(doc-type)

  centered-declaration-heading(labels.declaration-title)

  align(center)[
    #v(1cm)
    #set par(leading: 0.65em)
    #labels.declaration-intro #doc-name #labels.declaration-theme

    #v(1cm)
    #text(size: 12pt, weight: "bold")[#title] \
    #text(size: 12pt)[#subtitle]
    #v(1cm)

    #labels.declaration-body

    #v(7cm)

    #signature-grid(
      [#labels.place-date],
      [#labels.signature],
    )
  ]

  pagebreak()
}
