#set page(margin: 1in)
#set text(font: "Noto Sans", size: 11pt)

= New Typst Project

This is the starting point. Run `typst compile main.typ` to build a PDF,
or `tinymist preview main.typ` for a live-reloading preview.

== Notes

- Fonts available by default: the Noto family (installed in the container).
  Add more via the Dockerfile's `apt-get install` line if you need a
  specific typeface.
- `typst watch main.typ` rebuilds on save without needing tinymist.
