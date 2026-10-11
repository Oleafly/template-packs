// Figure sizing. An unsized image is laid out at full width and overflows the
// slide, so a figure whose image has no explicit size instead takes the height
// left over by the rest of the slide, and the image scales to fit.

#import "@preview/touying:0.7.4": cols as _touying-cols, components
#import "@preview/uniwarn:0.1.1": warning
#import "tokens.typ": *

// Take the remaining height of the container, but report at least `min` to
// `measure`.
//
// Touying detects overfull slides by measuring the body at unbounded height,
// where a fraction counts as zero. A bare `1fr` block would make a figure-only
// slide look empty, and would let a figure be squeezed to nothing by too much
// text without any warning. So a strut of height `min` is measured, and at
// layout time the real content is moved up over it and made `min` taller, so
// the strut costs no space.
//
// The weight is 100fr so that a `#source` line (`v(1fr)`) on the same slide
// does not take half of the free space.
#let _fill(min, body) = {
  block(width: 100%, height: min, below: 0pt)
  block(width: 100%, height: 100fr, above: 0pt, move(
    dy: -min,
    block(width: 100%, height: 100% + min, body),
  ))
}

#let _is-auto-image(body) = (
  body.func() == image and not body.has("width") and not body.has("height")
)

// A grid of panels under one caption: `figure(grid(columns: 2, image(..), image(..)))`.
#let _is-auto-panel-grid(body) = body.func() == grid and not body.has("rows")

#let _is-auto-figure(it) = _is-auto-image(it.body) or _is-auto-panel-grid(it.body)

/// Show rule for `figure.where(kind: image)`.
#let fit-figure(it) = context {
  if not _is-auto-figure(it) { return it }
  let caption-position = if it.caption != none and it.caption.has("position") {
    it.caption.position
  } else {
    figure.caption.position
  }
  let caption-first = it.caption != none and caption-position == top
  let picture = {
    set image(height: 100%, fit: "contain")
    set grid(rows: 1fr)
    it.body
  }
  _fill(space.figure-min, grid(
    columns: 100%,
    rows: if it.caption == none { (1fr,) } else if caption-first { (auto, 1fr) } else { (1fr, auto) },
    row-gutter: it.gap,
    align: center + horizon,
    ..if caption-first { (it.caption, picture) } else if it.caption != none { (picture, it.caption) } else { (picture,) },
  ))
}

// Whether content holds a figure that `fit-figure` will stretch. Looks through
// sequences, styled content, and wrappers such as align, block, and pad.
#let _holds-auto-figure(body) = {
  if type(body) != content { return false }
  if body.func() == figure {
    _is-auto-figure(body)
  } else if body.has("children") {
    body.children.any(_holds-auto-figure)
  } else if body.has("child") {
    _holds-auto-figure(body.child)
  } else if body.has("body") {
    _holds-auto-figure(body.body)
  } else {
    false
  }
}

// Check the natural column heights after Touying has processed reveals. The
// fractional fill stays outside this layout callback, at slide flow level.
#let _check-columns(it) = layout(bounds => {
  let fields = it.fields()
  let _ = fields.remove("label", default: none)
  let children = fields.remove("children")
  fields.rows = (auto,)
  let minimum = measure(block(width: bounds.width, {
    show figure.where(kind: image): fig => {
      if _is-auto-figure(fig) { block(height: space.figure-min) } else { fig }
    }
    grid(..fields, ..children)
  })).height
  it
  [#metadata((minimum: minimum, available: bounds.height))<brownbag-column-size>]
  // Only the final layout's markers are queryable. Warning directly above
  // would also report the artificial 150pt region used by overflow measurement.
  context {
    let markers = query(selector(<brownbag-column-size>).before(here()))
    if markers.len() > 0 {
      let size = markers.last().value
      if size.minimum > size.available + 0.01pt {
        warning(namespace: "brownbag", prefix: "[brownbag] ",
          "detecting column content overflow at page " + str(here().page())
            + " (content height: " + repr(size.minimum)
            + ", available height: " + repr(size.available) + ").",
        )
      }
    }
  }
})

/// Columns. Touying's `cols`, except that when a column holds an auto-sized
/// figure the columns take the remaining slide height. Without that, the
/// figure's fractional height would claim the whole page inside an auto-height
/// row and push whatever follows the columns off the slide, unnoticed by the
/// overflow check. Extra named arguments go to `grid` (`align: horizon`, ..).
///
/// The fill has to happen at flow level (`_fill`), not with `rows: 1fr` alone:
/// a grid with a fractional row still claims the whole region for itself.
///
/// A separate check compares every column's natural height with its final
/// available height, so long text beside a figure also raises a warning.
#let cols(..args) = {
  let named = args.named()
  if "rows" in named or not args.pos().any(_holds-auto-figure) {
    return _touying-cols(..named, ..args.pos())
  }
  let lazy = named.remove("lazy-layout", default: false)
  let columns = named.remove("columns", default: auto)
  let gutter = named.remove("gutter", default: 1em)
  let body = {
    show <brownbag-columns>: _check-columns
    [#grid(
      // Lazy layout measures natural rows before assigning its own height.
      rows: if lazy { auto } else { 1fr },
      columns: if columns == auto { (1fr,) * args.pos().len() } else { columns },
      gutter: gutter,
      ..named,
      ..args.pos(),
    ) <brownbag-columns>]
  }
  _fill(space.figure-min, if lazy { components.lazy-layout(body) } else { body })
}
