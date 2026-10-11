// Bibliography shared by a main file and its chapters.
// - The main file calls chapter-bib(source, main: true), registering the bibliography under <main-bib>.
// - Each chapter calls chapter-bib(source); it adds a bibliography only when no <main-bib> exists,
//   so a chapter opened alone in an editor still resolves its citations.
// `source` must be a `path(...)` (or bytes) created in the project: a path string would be
// resolved inside this package instead of the project.

#let chapter-bib(source, main: false, style: "chicago-author-date") = {
  context if main {
    [#bibliography(source, style: style) <main-bib>]
  } else if query(<main-bib>) == () {
    bibliography(source, style: style)
  }
}
