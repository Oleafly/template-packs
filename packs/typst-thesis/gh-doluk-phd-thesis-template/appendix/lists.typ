// The List of Figures and the List of Tables are generated from the captions
// of every `#figure` in the thesis. There is no reason to touch this file.
//
// Some faculties want these lists directly after the table of contents
// instead. To move them, cut the two `#outline(...)` calls below into a file
// in frontmatter/ and include that from the `frontmatter:` block of main.typ.

= List of Figures <app:figures>

#outline(title: none, target: figure.where(kind: image))

= List of Tables <app:tables>

#outline(title: none, target: figure.where(kind: table))
