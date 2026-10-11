// Inline and block components. Neutral colors are constants from tokens. The
// accent is the one runtime value: the theme's `init` mirrors
// `self.colors.primary` into `accent-state`, and components read it inside a
// `context` that wraps a leaf only, never a user-supplied body.

#import "tokens.typ": *

#let accent-state = state("brownbag-accent", accents.blue)

/// De-emphasised text: a slide subtitle, a caveat, a side remark.
#let muted(body) = text(fill: ink-muted, body)

/// The one sentence the audience should remember from a slide.
#let keypoint(body) = block(
  width: 100%,
  above: 1.4em,
  breakable: false,
  grid(
    columns: (auto, 1fr),
    column-gutter: 0.6em,
    context text(fill: accent-state.get(), weight: 600, sym.arrow.r),
    text(weight: 600, body),
  ),
)

/// Link to a backup slide: `#goto(<robust>)[Robustness]`, where the target is
/// a labelled slide heading, `== Robustness checks <robust>`. The target slide
/// gets a "Back" link in its footer automatically (see `_footer`), which is why
/// a marker recording the target is left next to the link.
#let goto(target, body) = box({
  [#metadata(str(target))<brownbag-goto>]
  link(target, text(size: 0.8em, weight: 500, sym.arrow.r + sym.space.nobreak + body))
})

/// Source line at the bottom of the slide body. Put it last on the slide. It
/// is in the flow (not `place`d) so that an overfull slide still triggers
/// Touying's overflow warning instead of printing the source over the text.
#let source(body) = {
  // Fractional spacing swallows the usual gap between blocks, so on a full
  // slide the line would touch the content above it without this.
  v(0.7em)
  v(1fr)
  block(text(size: size.note, fill: ink-subtle, [Source: ] + body))
}
