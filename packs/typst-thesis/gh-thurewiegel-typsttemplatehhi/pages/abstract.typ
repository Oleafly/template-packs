#let abstract_page(
  author: "",
  title: "",
  keywords: (),
  abstract: "",
) = {
  let custom_title(title) = {
    text(title, weight: "bold")
  }

  set par(justify: true)

  stack(
    custom_title(author),

    v(9mm),

    custom_title("Title of thesis"),
    v(6mm),
    text(title),

    v(9mm),

    if (keywords != none or (type(keywords) == array and keywords.len > 0)) {
      stack(
        custom_title("Keywords"),
        v(6mm),
        if type(keywords) == array {
          text(keywords.join(", "))
        } else {
          text(keywords)
        },

        v(9mm),
      )
    },

    custom_title("Abstract"),
    v(6mm),
    text(abstract),
  )
}
