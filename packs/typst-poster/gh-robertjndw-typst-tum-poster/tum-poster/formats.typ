// Layout metrics of the official TUM LaTeX poster templates
// (TUM LaTeX-Vorlagenpaket 2020-08-05, Ressourcen/Plakat/A*.tex).
//
// Lengths the LaTeX sources set directly are copied as-is. The baseline gaps
// between the title lines and the body were measured from the example PDFs
// that ship with the package, because the LaTeX macros only produce them
// indirectly through `\\[...]` skips and font leadings.
//
// The layout sits on a grid derived from the page margin `m`: the logo is
// `m` tall and hangs from the top margin, the last header line sits on `2m`
// and the first title starts at `3m`.

#let orientations = ("portrait", "landscape")

#let formats = (
  a0: (
    margin: 46mm,
    logo-width: 87.2mm,
    gutter: 18mm,
    list-indent: 0.6em,
    body: (size: 25pt, leading: 32pt),
    header: (size: 42pt, leading: 50pt),
    caption: (size: 14pt, leading: 18pt),
    titles: (
      (size: 94pt, leading: 113pt),
      (size: 67pt, leading: 80pt),
      (size: 44pt, leading: 53pt),
    ),
    title-gaps: (52.7mm, 27.4mm),
    body-gap: 34.5mm,
    portrait: (
      columns: 3,
      bottom: 84mm,
      footer: (size: 14pt, leading: 18pt, columns: 5),
    ),
    landscape: (
      columns: 4,
      bottom: 80mm,
      footer: (size: 12pt, leading: 14pt, columns: 10),
    ),
  ),
  a1: (
    margin: 35mm,
    logo-width: 66.5mm,
    gutter: 14mm,
    list-indent: 0.7em,
    body: (size: 22pt, leading: 27pt),
    header: (size: 30pt, leading: 39pt),
    caption: (size: 14pt, leading: 18pt),
    titles: (
      (size: 67pt, leading: 80pt),
      (size: 49pt, leading: 53pt),
      // The LaTeX source sets a 10pt leading here, which is a typo that only
      // goes unnoticed because the title never wraps in the examples.
      (size: 39pt, leading: 47pt),
    ),
    title-gaps: (34.6mm, 23.3mm),
    body-gap: 26.1mm,
    portrait: (
      columns: 3,
      bottom: 66mm,
      footer: (size: 11pt, leading: 13.2pt, columns: 5),
    ),
    landscape: (
      columns: 3,
      bottom: 64mm,
      footer: (size: 11pt, leading: 13.2pt, columns: 6),
    ),
  ),
  a2: (
    margin: 27mm,
    logo-width: 50.9mm,
    gutter: 10mm,
    list-indent: 0.75em,
    body: (size: 18pt, leading: 22pt),
    header: (size: 24.5pt, leading: 30pt),
    caption: (size: 10pt, leading: 12pt),
    titles: (
      (size: 48pt, leading: 60pt),
      (size: 35pt, leading: 40pt),
      // Same leading typo as in A1 (20pt for a 28pt font).
      (size: 28pt, leading: 34pt),
    ),
    title-gaps: (28mm, 18.9mm),
    body-gap: 21.1mm,
    portrait: (
      columns: 2,
      bottom: 53mm,
      footer: (size: 10pt, leading: 12pt, columns: 4),
    ),
    landscape: (
      columns: 3,
      bottom: 50mm,
      footer: (size: 10pt, leading: 12pt, columns: 6),
    ),
  ),
  a3: (
    margin: 18mm,
    logo-width: 34mm,
    gutter: 7mm,
    list-indent: 0.82em,
    body: (size: 16pt, leading: 20pt),
    header: (size: 16pt, leading: 20pt),
    caption: (size: 10pt, leading: 12pt),
    titles: (
      (size: 34pt, leading: 41pt),
      (size: 25pt, leading: 30pt),
      (size: 20pt, leading: 24pt),
    ),
    title-gaps: (25mm, 16.4mm),
    body-gap: 21.7mm,
    portrait: (
      columns: 2,
      bottom: 38mm,
      footer: (size: 9pt, leading: 10.8pt, columns: 3),
    ),
    landscape: (
      columns: 3,
      bottom: 40mm,
      footer: (size: 9pt, leading: 10.8pt, columns: 5),
    ),
  ),
  a4: (
    margin: 10mm,
    logo-width: 19mm,
    gutter: 7mm,
    list-indent: 0.9em,
    body: (size: 11pt, leading: 15pt),
    header: (size: 9pt, leading: 11pt),
    caption: (size: 10pt, leading: 12pt),
    titles: (
      (size: 24pt, leading: 29pt),
      (size: 18pt, leading: 20pt),
      (size: 14pt, leading: 16pt),
    ),
    title-gaps: (17.8mm, 11.5mm),
    body-gap: 15.8mm,
    portrait: (
      columns: 2,
      bottom: 28mm,
      footer: (size: 9pt, leading: 10.8pt, columns: 3),
    ),
    landscape: (
      columns: 2,
      bottom: 30mm,
      footer: (size: 9pt, leading: 10.8pt, columns: 4),
    ),
  ),
)

/// Returns the layout metrics for one of the official TUM poster formats,
/// with the orientation-specific values merged into the top level.
///
/// Fails with a readable message for formats TUM has no template for.
///
/// - size (str): Paper size, one of `"a0"` to `"a4"` (case-insensitive).
/// - orientation (str): `"portrait"` or `"landscape"`.
/// -> dictionary
#let poster-format(size, orientation) = {
  assert(
    type(size) == str,
    message: "tum-poster: `size` must be a string like \"a0\", got " + repr(size) + ".",
  )
  let key = lower(size)
  assert(
    key in formats,
    message: "tum-poster: there is no official TUM poster template for size "
      + repr(size) + ". Supported sizes: "
      + formats.keys().map(upper).join(", ") + ".",
  )
  assert(
    orientation in orientations,
    message: "tum-poster: `orientation` must be one of "
      + orientations.map(repr).join(" or ") + ", got " + repr(orientation) + ".",
  )

  let format = formats.at(key)
  let specific = format.at(orientation)
  for o in orientations { let _ = format.remove(o) }
  format + specific + (paper: key, orientation: orientation)
}
