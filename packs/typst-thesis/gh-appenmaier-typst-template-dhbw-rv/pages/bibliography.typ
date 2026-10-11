/// Renders the bibliography page.
/// - labels (dict): UI label dictionary
/// -> none
#let bibliography-page(labels: (:)) = {
  heading(level: 1, numbering: none)[#labels.bibliography]

  bibliography(
    "../user/sources.bib",
    title: none,
    style: "harvard-cite-them-right",
  )
}
