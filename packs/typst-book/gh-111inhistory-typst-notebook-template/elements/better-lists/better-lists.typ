/// An enhanced list/enum styling module for Typst, providing more accurate numbering alignment, flexible connector rendering, and improved support for loose lists.
/// Currently, cross-page alignment between the numbering and body text is not supported.
#import "/utils/numbly-utils.typ": partial-display
#import "/utils/common.typ": merge-dict, modify-dict
#import "./renderers.typ": renderers

/// Default connector settings for block-indent rendering.
/// `position` is measured from the body-side edge of the indent area.
/// A value of `0pt` places the connector right next to the body column.
/// A value equal to `indentation` places it at the far left edge.
#let default-connector-settings = (
  enabled: false,
  position: 0.9em,
  stroke: (paint: luma(65%), thickness: 0.75pt, dash: (array: (4pt, 5pt), phase: 4pt)),
)


/// Global default settings for list styling.
#let default-list-settings = (
  enum: (
    numbering: partial-display("{1}.{2}.{3}.{4}."),
    post-numbering: none,
    full: false,
    tight: (
      type: "block-indent",
      spacing: 0.65em,
      indentation: 2em,
      body-indent: 0.5em,
      numbering-align: "right",
      connector: default-connector-settings,
    ),
    loose: (
      type: "first-line-indent",
      spacing: 1em,
      indentation: 2em,
      body-indent: 0.5em,
      numbering-align: "right",
    ),
  ),
  list: (
    marker: ([•], [‣], [–]),
    tight: (
      type: "block-indent",
      spacing: 0.65em,
      indentation: 2em,
      body-indent: 0.5em,
      marker-align: "right",
      connector: default-connector-settings,
    ),
    loose: (
      type: "first-line-indent",
      spacing: 1em,
      indentation: 2em,
      body-indent: 0.5em,
      marker-align: "right",
    ),
  ),
)

/// Extract the settings shape consumed by Typst `set list` / `set enum`.
/// - resolved (dictionary): Fully merged list settings.
/// -> dictionary
#let build-set-settings(resolved) = (
  enum: (
    base: (
      numbering: resolved.enum.at("numbering"),
      full: resolved.enum.at("full"),
    ),
    tight: (
      indent: resolved.enum.tight.at("indentation"),
      spacing: resolved.enum.tight.at("spacing"),
      body-indent: resolved.enum.tight.at("body-indent"),
    ),
    loose: (
      indent: resolved.enum.loose.at("indentation"),
      spacing: resolved.enum.loose.at("spacing"),
      body-indent: resolved.enum.loose.at("body-indent"),
    ),
  ),
  list: (
    base: (
      marker: resolved.list.at("marker"),
    ),
    tight: (
      indent: resolved.list.tight.at("indentation"),
      spacing: resolved.list.tight.at("spacing"),
      body-indent: resolved.list.tight.at("body-indent"),
    ),
    loose: (
      indent: resolved.list.loose.at("indentation"),
      spacing: resolved.list.loose.at("spacing"),
      body-indent: resolved.list.loose.at("body-indent"),
    ),
  ),
)

/// Extract the minimal settings shape required by renderers.
/// - resolved (dictionary): Fully merged list settings.
/// -> dictionary
#let normalize-connector(connector) = {
  if connector == none {
    return none
  }
  merge-dict(default-connector-settings, connector)
}

/// Extract the minimal settings shape required by renderers.
/// - resolved (dictionary): Fully merged list settings.
/// -> dictionary
#let build-render-settings(resolved) = (
  enum: (
    tight: (
      type: resolved.enum.tight.at("type"),
      numbering-align: resolved.enum.tight.at("numbering-align"),
      connector: normalize-connector(resolved.enum.tight.at("connector", default: none)),
      post-numbering: resolved.enum.at("post-numbering"),
    ),
    loose: (
      type: resolved.enum.loose.at("type"),
      numbering-align: resolved.enum.loose.at("numbering-align"),
      connector: normalize-connector(resolved.enum.loose.at("connector", default: none)),
      post-numbering: resolved.enum.at("post-numbering"),
    ),
  ),
  list: (
    tight: (
      type: resolved.list.tight.at("type"),
      marker-align: resolved.list.tight.at("marker-align"),
      connector: normalize-connector(resolved.list.tight.at("connector", default: none)),
    ),
    loose: (
      type: resolved.list.loose.at("type"),
      marker-align: resolved.list.loose.at("marker-align"),
      connector: normalize-connector(resolved.list.loose.at("connector", default: none)),
    ),
  ),
)


/// Apply renderer rules for `enum`.
/// - settings (dictionary): Renderer-facing enum settings.
/// -> function
#let apply-enum-settings(settings) = doc => {
  show enum.where(tight: true): renderers.at(settings.tight.at("type")).at("enum")(settings.tight)
  show enum.where(tight: false): renderers.at(settings.loose.at("type")).at("enum")(settings.loose)
  doc
}

/// Apply renderer rules for `list`.
/// - settings (dictionary): Renderer-facing list settings.
/// -> function
#let apply-list-settings(settings) = doc => {
  show list.where(tight: true): renderers.at(settings.tight.at("type")).at("list")(settings.tight)
  show list.where(tight: false): renderers.at(settings.loose.at("type")).at("list")(settings.loose)
  doc
}

/// Public entry point for the lists module.
/// - settings (dictionary): Fully merged list settings.
/// -> function
#let better-lists(settings) = doc => {
  let resolved = modify-dict(default-list-settings, settings)
  assert(
    resolved.enum.at("post-numbering") == none
      or type(resolved.enum.at("post-numbering")) == function,
    message: "`enum.post-numbering` must be a function or none.",
  )

  let set-settings = build-set-settings(resolved)
  let render-settings = build-render-settings(resolved)

  set enum(..set-settings.enum.base)
  set list(..set-settings.list.base)

  show list.where(tight: true): set list(..set-settings.list.tight)
  show list.where(tight: false): set list(..set-settings.list.loose)
  show enum.where(tight: true): set enum(..set-settings.enum.tight)
  show enum.where(tight: false): set enum(..set-settings.enum.loose)

  show: apply-list-settings(render-settings.list)
  show: apply-enum-settings(render-settings.enum)
  doc
}
