#let render-bibliography(meta) = {
  set heading(numbering: none)

  [= Literaturverzeichnis]

  bibliography(
    meta.bibliography-file,
    style: "../template/styles/ieee.csl",
    title: none,
  )
  pagebreak()
}