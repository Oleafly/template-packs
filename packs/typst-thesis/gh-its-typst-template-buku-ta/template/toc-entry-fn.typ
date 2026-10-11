// ============================================================
// AUTO — Formatter baris daftar isi (judul + titik-titik + nomor halaman)
// ============================================================

#let toc-entry-fn(it) = {
  let loc = it.element.location()
  let num = numbering(loc.page-numbering(), ..counter(page).at(loc))
  let body = it.body
  let children = body.at("children", default: ())
  if children.len() > 1 {
    body = children.slice(1).join()
  }
  link(loc, box(grid(
    columns: (auto, 1fr, auto),
    gutter: 0pt,
    {
      for _ in range(it.level - 1) { box(width: 1.5em) }
    },
    [#body#box(width: 1fr, repeat[.])],
    align(right)[#num],
  )))
}
