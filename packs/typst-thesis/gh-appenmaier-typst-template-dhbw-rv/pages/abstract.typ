/// Renders the abstract page.
/// - labels (dict): UI label dictionary from labels.typ
/// - body (content): Abstract text supplied by the user
/// -> none
#let abstract-page(
  labels: (:),
  body: [],
) = {
  import "common.typ": centered-declaration-heading
  set page(header: none)

  centered-declaration-heading(labels.abstract-title)

  v(1cm)
  body

  pagebreak()
}
