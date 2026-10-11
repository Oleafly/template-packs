// components/note.typ
// Charlie's signature Note box with rivet/screw badge and semantic variants

#import "boxes.typ": rivet-box
#import "theme.typ": resolve-palette

/// Charlie's signature Note box
/// Displays an attached floating badge with two circular screw/rivet dots on the top border.
/// Can take any custom title, e.g. "Note:-", "Note:- Why is it the smallest?", or "Custom Note".
#let note(
  title: "Note:-",
  body,
  fill: auto,
  stroke: auto,
  badge-fill: auto,
  badge-stroke: auto,
  badge-fg: auto,
  dot-color: auto,
  text-color: auto,
  theme: none,
) = {
  rivet-box(
    title: title,
    body,
    fill: fill,
    stroke: stroke,
    badge-fill: badge-fill,
    badge-stroke: badge-stroke,
    badge-fg: badge-fg,
    dot-color: dot-color,
    text-color: text-color,
    theme: theme,
  )
}

/// Shorthand for Charlie's \nt{...} command
#let nt(
  title: "Note:-",
  body,
  theme: none,
) = {
  note(title: title, body, theme: theme)
}

/// Tip variant of the rivet box
#let tip(
  title: "Tip:-",
  body,
  theme: none,
) = {
  context {
    let p = resolve-palette(theme-override: theme)
    let callout = p.callouts.tip
    rivet-box(
      title: title,
      body,
      fill: callout.bg,
      stroke: callout.bar,
      badge-fill: if p.mode == "dark" { rgb("#0d2e24") } else { rgb("#ffffff") },
      badge-stroke: callout.bar,
      badge-fg: callout.title,
      dot-color: callout.bar,
      theme: theme,
    )
  }
}

/// Info variant of the rivet box
#let info(
  title: "Info:-",
  body,
  theme: none,
) = {
  context {
    let p = resolve-palette(theme-override: theme)
    let callout = p.callouts.info
    rivet-box(
      title: title,
      body,
      fill: callout.bg,
      stroke: callout.bar,
      badge-fill: if p.mode == "dark" { rgb("#172554") } else { rgb("#ffffff") },
      badge-stroke: callout.bar,
      badge-fg: callout.title,
      dot-color: callout.bar,
      theme: theme,
    )
  }
}

/// Warning variant of the rivet box
#let warning(
  title: "Warning:-",
  body,
  theme: none,
) = {
  context {
    let p = resolve-palette(theme-override: theme)
    let callout = p.callouts.warning
    rivet-box(
      title: title,
      body,
      fill: callout.bg,
      stroke: callout.bar,
      badge-fill: if p.mode == "dark" { rgb("#3b1803") } else { rgb("#ffffff") },
      badge-stroke: callout.bar,
      badge-fg: callout.title,
      dot-color: callout.bar,
      theme: theme,
    )
  }
}

/// Caution / Danger variant of the rivet box
#let caution(
  title: "Caution:-",
  body,
  theme: none,
) = {
  context {
    let p = resolve-palette(theme-override: theme)
    let callout = p.callouts.caution
    rivet-box(
      title: title,
      body,
      fill: callout.bg,
      stroke: callout.bar,
      badge-fill: if p.mode == "dark" { rgb("#380614") } else { rgb("#ffffff") },
      badge-stroke: callout.bar,
      badge-fg: callout.title,
      dot-color: callout.bar,
      theme: theme,
    )
  }
}
