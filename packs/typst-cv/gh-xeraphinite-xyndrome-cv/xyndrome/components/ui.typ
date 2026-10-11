/// Reusable UI components and icon/link helpers.

/// Global toggle for icon rendering.
#let icons-enabled = state("icons-enabled", true)
#let current-lang = state("current-lang", "en")

/// Render one icon from icon function or content for a resolved mode.
#let render-icon-with-mode(
  icon,
  enabled,
  height: 1em,
  baseline: 15%,
  outset: (left: 0pt, right: 0pt, top: 0pt, bottom: 0pt),
) = {
  if enabled == false or icon == none {
    none
  } else if type(icon) == function {
    icon(height: height, baseline: baseline)
  } else {
    box(height: height, baseline: baseline, outset: outset)[#icon]
  }
}

/// Render one icon using the current global icon mode.
#let render-icon(
  icon,
  height: 1em,
  baseline: 15%,
  outset: (left: 0pt, right: 0pt, top: 0pt, bottom: 0pt),
) = context {
  render-icon-with-mode(
    icon,
    icons-enabled.get(),
    height: height,
    baseline: baseline,
    outset: outset,
  )
}

/// Generic icon + content + link composer.
#let content-with-icon(
  content,
  icon: none,
  url: "",
  height: 1em,
  baseline: 0%,
  gap: -0.2em,
  outset: (left: 0pt, right: 1pt, top: 0pt, bottom: 0pt),
  trailing: none,
  enabled: none,
) = {
  let compose = active => {
    let rendered-icon = render-icon-with-mode(
      icon,
      active,
      height: height,
      baseline: baseline,
      outset: outset,
    )
    let main-content = if rendered-icon == none {
      if active == false and icon != none {
        [#box(width: 0pt, height: height, baseline: baseline)[]#content]
      } else {
        content
      }
    } else {
      [#rendered-icon#h(gap)#content]
    }
    let final-content = if trailing == none { main-content } else { [#main-content#h(gap)#trailing] }
    if url == "" { final-content } else { link(url)[#final-content] }
  }
  if enabled == none {
    context { compose(icons-enabled.get()) }
  } else {
    compose(enabled)
  }
}

#let contact(
  icon: none,
  label: "",
  url: "",
  height: 0.85em,
  baseline: 15%,
  gap: 0.1em,
  enabled: none,
) = content-with-icon(
  label,
  icon: icon,
  url: url,
  height: height,
  baseline: baseline,
  gap: gap,
  enabled: enabled,
)

#let link-with-icon(
  icon: none,
  url: "",
  text: "",
  height: 1em,
  baseline: 15%,
  gap: 0.15em,
) = content-with-icon(
  text,
  icon: icon,
  url: url,
  height: height,
  baseline: baseline,
  gap: gap,
)

#let icon-with-link(
  icon: none,
  url: "",
  text: "",
  height: 1em,
  baseline: 15%,
  gap: 0.15em,
  trailing: none,
) = content-with-icon(
  text,
  icon: icon,
  url: url,
  height: height,
  baseline: baseline,
  gap: gap,
  trailing: trailing,
)

#let render-icons(
  icons,
  icon-gap: 0.5em,
  height: 1em,
  baseline: 15%,
) = context {
  let enabled = icons-enabled.get()
  if icons == none {
    []
  } else if type(icons) == array {
    let rendered = icons
      .filter(icon => icon != none)
      .map(icon => render-icon-with-mode(icon, enabled, height: height, baseline: baseline))
      .filter(icon => icon != none)
    if rendered.len() == 0 { [] } else { rendered.join(h(icon-gap)) }
  } else {
    let single = render-icon-with-mode(icons, enabled, height: height, baseline: baseline)
    if single == none { [] } else { single }
  }
}

#let short-name(full-name) = {
  let parts = full-name.split(" ")
  if parts.len() >= 2 {
    let first-initial = parts.at(0).at(0).upper()
    let last-name = parts.at(-1)
    smallcaps([#first-initial #last-name])
  } else {
    smallcaps(full-name)
  }
}

#let is-et-al(author) = {
  if type(author) != str {
    false
  } else {
    let normalized = author.trim()
    (
      "et al.",
      "et al",
      "Et al.",
      "Et al",
      "ET AL.",
      "ET AL",
      "et. al.",
      "et. al",
      "Et. al.",
      "Et. al",
      "ET. AL.",
      "ET. AL",
      "等",
    ).contains(normalized)
  }
}

#let localized-et-al() = context {
  let lang = current-lang.get()
  if lang == "zh" or lang == "zh-cn" or lang == "zh-hk" {
    [等]
  } else if lang == "ja" {
    [ほか]
  } else if lang == "ko" {
    [외]
  } else {
    [et al.]
  }
}

#let et-al-prefix() = context {
  let lang = current-lang.get()
  if lang == "zh" or lang == "zh-cn" or lang == "zh-hk" or lang == "ja" or lang == "ko" {
    []
  } else {
    [#h(0.15em)]
  }
}

#let render-author(author, format: "full", custom-formatter: none) = {
  if is-et-al(author) {
    localized-et-al()
  } else if format == "short" {
    short-name(author)
  } else if format == "custom" and custom-formatter != none {
    custom-formatter(author)
  } else {
    smallcaps(author)
  }
}

#let authors-component(
  authors: (),
  format: "full",
  separator: ", ",
  custom-formatter: none,
) = {
  if type(authors) == array {
    let pieces = ()
    for (index, author) in authors.enumerate() {
      let rendered = render-author(author, format: format, custom-formatter: custom-formatter)
      if index == 0 {
        pieces.push(rendered)
      } else if is-et-al(author) {
        pieces.push([#et-al-prefix()#rendered])
      } else {
        pieces.push([#separator#rendered])
      }
    }
    pieces.join()
  } else {
    render-author(authors, format: format, custom-formatter: custom-formatter)
  }
}

#let badge(
  label: "",
  icon: none,
  fill: luma(96%),
  stroke: luma(70%),
  text-color: luma(25%),
  radius: 0.25em,
  padding: (x: 0.4em, y: 0.4em),
  text-size: 0.9em,
  icon-height: 0.6em,
  icon-baseline: 15%,
  icon-gap: 0.1em,
) = {
  let badge-content = content-with-icon(
    label,
    icon: icon,
    height: icon-height,
    baseline: icon-baseline,
    gap: icon-gap,
  )
  box(
    stroke: stroke,
    fill: fill,
    inset: padding,
    radius: radius,
  )[
    #text(size: text-size, fill: text-color, weight: "medium")[#badge-content]
  ]
}

/// Alias used in TOML eval scope.
#let link_with_icon = link-with-icon
