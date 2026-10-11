// components/callouts.typ
// Universal callout and admonition components supporting various visual box styles

#import "boxes.typ": badge-box, frame-box, left-bar-box, ribbon-box, rivet-box
#import "theme.typ": resolve-palette

/// Universal callout box
/// - type: semantic type ("info", "tip", "warning", "caution", "success", "note")
/// - style: visual appearance ("left-bar", "badge", "rivet", "ribbon", "frame")
/// - title: custom header title (defaults to capitalized type name)
/// - tag: optional secondary tag or subtitle
/// - theme: optional theme override ("light" or "dark")
#let callout(
  type: "info",
  style: "left-bar",
  title: none,
  tag: none,
  body,
  bar-color: auto,
  bg-color: auto,
  border-color: auto,
  theme: none,
) = {
  context {
    let p = resolve-palette(theme-override: theme)
    let callout-dict = p.callouts

    let cfg = if type in callout-dict {
      callout-dict.at(type)
    } else {
      callout-dict.info
    }

    let default-title = if title != none {
      title
    } else if type == "info" {
      "Info"
    } else if type == "tip" {
      "Tip"
    } else if type == "warning" {
      "Warning"
    } else if type == "caution" {
      "Caution"
    } else if type == "success" {
      "Success"
    } else {
      "Note"
    }

    let c-bar = if bar-color == auto { cfg.bar } else { bar-color }
    let c-bg = if bg-color == auto { cfg.bg } else { bg-color }
    let c-border = if border-color == auto { cfg.bar } else { border-color }
    let c-text = if "text" in cfg { cfg.text } else { p.text }

    if style == "left-bar" {
      left-bar-box(
        title: default-title,
        tag: tag,
        body,
        bar-color: c-bar,
        bg-color: c-bg,
        title-color: cfg.title,
        text-color: c-text,
        theme: theme,
      )
    } else if style == "badge" {
      badge-box(
        title: default-title,
        tag: tag,
        body,
        tab-fill: c-bar,
        tab-fg: rgb("#ffffff"),
        stroke: c-border,
        fill: c-bg,
        text-color: c-text,
        theme: theme,
      )
    } else if style == "rivet" {
      rivet-box(
        title: default-title,
        body,
        fill: c-bg,
        stroke: c-border,
        badge-fill: if p.mode == "dark" { rgb("#24273a") } else { rgb("#ffffff") },
        badge-stroke: c-border,
        badge-fg: cfg.title,
        dot-color: c-bar,
        text-color: c-text,
        theme: theme,
      )
    } else if style == "ribbon" {
      ribbon-box(
        title: default-title,
        tag: tag,
        body,
        ribbon-color: c-bar,
        border-color: c-border,
        bg-color: c-bg,
        text-color: c-text,
        theme: theme,
      )
    } else if style == "frame" {
      frame-box(
        title: default-title,
        tag: tag,
        body,
        border-color: c-border,
        bg-color: c-bg,
        title-color: cfg.title,
        text-color: c-text,
        theme: theme,
      )
    }
  }
}
