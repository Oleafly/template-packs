#import "@preview/drafting:0.2.2"
#import "@preview/acrostiche:0.7.0"

// This file contains common utilities for use in this thesis template

/// Creates an in-text citation for prose-style references.
///
/// Displays as `Author et al. (2026)`.
///
/// - label (label): bibliography entry to cite
/// - supplement (none | content): optional citation supplement, e.g. page numbers
#let tc(label, supplement: none) = {
  cite(label, form: "prose", supplement: supplement)
}

/// Renders and labels a research question block.
///
/// Define using `#forschungsfrage[Meine Forschungsfrage]` and reference it with
/// `#ff("1")`. Supports nested numbering via `level`, e.g.
/// `#forschungsfrage(level: 2)[...]`.
///
/// - body (content): research question text
/// - level (int): counter level to step
#let forschungsfrage(body, level: 1) = {
  let ffcounter = counter("forschungsfrage")
  ffcounter.step(level: level)
  context [
    #block(breakable: false, stack(
      dir: ltr,
      spacing: 8pt,
      [*F#ffcounter.display()*],
      line(angle: 90deg, length: 11pt),
      block(width: 93%, body),
    )) #label("ff-" + ffcounter.display())
  ]
}

/// Creates a link to a research question.
///
/// Reference research questions using `#ff("1")` or `#ff("1.1")`.
///
/// - num (str): displayed research question number
#let ff(num) = {
  link(label("ff-" + num))[F#num]
}

/// Places a hidden figure label at an arbitrary position in the document.
///
/// - name (str): label name to create
/// - supplement (content): optional figure supplement
#let x-label(
  name,
  supplement: [],
) = place[#figure(supplement: supplement, kind: "hidden")[]#label(name)]

// --- Acronyms ---

/// Returns an acronym defined in `acronyms.typ`.
///
/// The first mention of the acronym will include its fully qualified form.
///
/// - label (str): label of the acronym
///
/// acrostiche package: https://typst.app/universe/package/acrostiche/
#let ac(label) = {
  acrostiche.ac(label)
}

/// Returns the short form of an acronym.
///
/// - label (str): label of the acronym
#let acs(label) = {
  acrostiche.acs(label)
}

/// Returns the plural short form of an acronym.
///
/// - label (str): label of the acronym
#let acp(label) = {
  acrostiche.acp(label)
}

/// Returns the long form of an acronym.
///
/// - label (str): label of the acronym
#let acl(label) = {
  acrostiche.acl(label)
}

/// Returns the plural long form of an acronym.
///
/// - label (str): label of the acronym
#let aclp(label) = {
  acrostiche.aclp(label)
}

/// Returns the full acronym form.
///
/// - label (str): label of the acronym
#let acf(label) = {
  acrostiche.acf(label)
}

/// Returns the plural full acronym form.
///
/// - label (str): label of the acronym
#let acfp(label) = {
  acrostiche.acrfp(label)
}

/// --- Notes ---

/// Renders a small icon image and adds spacing after it.
///
/// - codepoint (str): image path or codepoint image to display
#let icon(codepoint) = {
  box(
    height: 1em,
    baseline: 0.15em,
    image(codepoint),
  )
  h(0.25em)
}

/// Adds a side-note in the page margin.
///
/// - body (content): note content
/// - ..kwargs (dictionary): accepts all margin-note options of the drafting package
#let side-note(body, ..kwargs) = {
  set text(size: 10pt, font: "New Computer Modern")
  drafting.margin-note(body, ..kwargs)
}

/// Renders a highlighted note badge, either inline or as a block.
///
/// - body (content): note content
/// - title (str): label shown in the badge
/// - tone (color): base color used for the badge and background
/// - inline (bool): whether to render as an inline badge instead of a block
#let note(body, title: "NOTE", tone: yellow, inline: true) = {
  set text(font: "New Computer Modern", weight: "regular", size: 0.8em)

  let fg = tone.lighten(20%)
  let bg = tone.lighten(80%)
  let pad = 0.35em

  if inline {
    set text(size: 0.9em)
    box(
      text(title, weight: "extrabold", fill: white),
      fill: fg,
      stroke: fg + 1pt,
      outset: (y: pad),
      inset: (x: pad),
      radius: if body == [] {
        0.25em
      } else {
        (left: 0.25em)
      },
    )
    if body != [] {
      box(
        body,
        fill: bg,
        stroke: fg + 1pt,
        outset: (y: pad),
        inset: (x: pad),
        radius: (right: 0.25em),
      )
    }
  } else {
    context {
      let note-text = text(title, weight: "extrabold", fill: white)
      let note-rect = rect(
        note-text,
        fill: fg,
        stroke: fg + 1pt,
        radius: (left: 0.25em),
      )
      block(
        [
          #place(
            note-rect,
            dx: -5pt - measure(note-rect).width,
            dy: -5pt,
          )
          #body
        ],
        fill: bg,
        stroke: fg + 1pt,
        inset: 5pt,
        radius: (top-left: 0em, rest: 0.25em),
        width: 100%,
      )
    }
  }
}

// --- Text Status Tools (WIP, ToDo, etc.) ---

/// Marks a location where a citation is still needed.
#let needs-citation = {
  note([], title: "CITATION", tone: red)
}

/// Renders an inline or block To-Do note.
///
/// - body (content): note content
/// - inline (bool): whether to render as an inline badge instead of a block
#let todo(body, inline: true) = {
  note(body, title: "To-Do", tone: orange, inline: inline)
}

/// Renders a block To-Do note.
///
/// - body (content): note content
#let todo-b(body) = {
  todo(body, inline: false)
}

/// Renders an inline or block work-in-progress note.
///
/// - body (content): note content
/// - inline (bool): whether to render as an inline badge instead of a block
#let wip(body, inline: true) = {
  note(body, title: "WIP", tone: blue, inline: inline)
}

/// Renders a block work-in-progress note.
///
/// - body (content): note content
#let wip-b(body) = {
  wip(body, inline: false)
}

/// Renders a block question note.
///
/// - body (content): question content
#let question(body) = {
  note(body, title: "Question", tone: purple, inline: false)
}

/// Renders a block answer note.
///
/// - body (content): answer content
#let answer(body) = {
  note(body, title: "Answer", tone: green, inline: false)
}

/// Renders an inline done note.
///
/// - body (content): note content
#let done(body) = {
  note(body, title: "Done", tone: green, inline: true)
}

