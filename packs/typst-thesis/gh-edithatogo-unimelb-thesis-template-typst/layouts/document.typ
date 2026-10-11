// =================================
// Document Layout Configuration
// =================================

#import "../utils/style.typ": thesis-style

#let resolve-style(ctx) = {
  if ctx != none {
    let candidate = ctx.at("style", default: none)
    let profile = ctx.at("profile", default: "default")
    if candidate != none {
      candidate
    } else {
      make-thesis-style(profile: profile)
    }
  } else {
    thesis-style
  }
}

#let resolve-locale(ctx) = {
  if ctx != none {
    let candidate = ctx.at("locale", default: none)
    if candidate != none {
      candidate
    } else {
      "en"
    }
  } else {
    "en"
  }
}

#let resolve-profile(ctx) = {
  if ctx != none {
    let candidate = ctx.at("profile", default: none)
    if candidate != none {
      candidate
    } else {
      "default"
    }
  } else {
    "default"
  }
}

// =================================
// Front Matter Layout
// =================================

#let front-matter-layout(ctx, body) = {
  let style = resolve-style(ctx)
  let locale = resolve-locale(ctx)
  let profile = resolve-profile(ctx)

  set page(
    paper: "a4",
    margin: (
      top: 2.5cm,
      bottom: 2.5cm,
      left: 3cm,
      right: 3cm,
    ),
    numbering: "i",
    number-align: center,
  )

  // Profile-specific text rendering optimizations
  let text-rendering = if profile == "draft" {
    // Faster rendering for draft mode
    (font: style.fonts.serif, size: 12pt, lang: locale)
  } else if profile == "screen" {
    // Optimized for screen reading
    (font: style.fonts.serif, size: 12pt, lang: locale, hyphenate: true)
  } else {
    // High quality for print
    (font: style.fonts.serif, size: 12pt, lang: locale)
  }

  set text(..text-rendering)

  // Add draft watermark for draft profile
  if profile == "draft" {
    set page(
      background: {
        // Semi-transparent overlay
        rect(width: 100%, height: 100%, fill: rgb(255, 255, 255, 95%))
        // Diagonal watermark text
        place(center, rotate(24deg, text(
          size: 72pt,
          fill: rgb(255, 0, 0, 8%),
          weight: "bold",
          font: style.fonts.sans,
        )[DRAFT]))
        // Corner timestamp for draft tracking
        place(bottom + right, dx: -1cm, dy: -0.5cm, text(
          size: 8pt,
          fill: rgb(150, 150, 150),
          font: style.fonts.mono,
        )[
          Draft - #(datetime.today().display())
        ])
      },
      foreground: none,
    )
  }

  // Add screen watermark for screen profile
  if profile == "screen" {
    set page(
      background: {
        // Subtle screen indicator
        place(top + right, dx: -1cm, dy: 0.5cm, text(
          size: 10pt,
          fill: rgb(0, 100, 255, 60%),
          font: style.fonts.sans,
          style: "italic",
        )[Screen View])
      },
      foreground: none,
    )
  }

  show heading: it => {
    set text(weight: "bold", fill: style.colors.primary)
    if it.level == 1 {
      v(2em)
      text(size: 16pt, it)
      v(1em)
    } else if it.level == 2 {
      v(1.5em)
      text(size: 14pt, it)
      v(0.8em)
    } else {
      v(1em)
      text(size: 12pt, it)
      v(0.5em)
    }
  }

  set par(
    leading: style.spacing.paragraph-leading,
    first-line-indent: 1.5em,
    justify: true,
  )

  body
}

// =================================
// Main Matter Layout
// =================================

#let main-matter-layout(ctx, title: none, double-sided: false, body) = {
  let style = resolve-style(ctx)
  let locale = resolve-locale(ctx)
  let profile = resolve-profile(ctx)

  // Profile-specific page settings
  let is-double-sided = if profile == "print" { true } else { false }
  let page-margins = if profile == "screen" {
    // Optimized margins for screen reading
    (
      top: 2cm,
      bottom: 2cm,
      left: 2.5cm,
      right: 2.5cm,
    )
  } else if is-double-sided {
    (
      top: 2.5cm,
      bottom: 2.5cm,
      inside: 3cm,
      outside: 3cm,
    )
  } else {
    (
      top: 2.5cm,
      bottom: 2.5cm,
      left: 3cm,
      right: 3cm,
    )
  }

  // Profile-specific text rendering optimizations
  let text-rendering = if profile == "draft" {
    // Faster rendering for draft mode
    (font: style.fonts.serif, size: 12pt, lang: locale)
  } else if profile == "screen" {
    // Optimized for screen reading
    (font: style.fonts.serif, size: 12pt, lang: locale, hyphenate: true)
  } else {
    // High quality for print
    (font: style.fonts.serif, size: 12pt, lang: locale)
  }

  set page(
    paper: "a4",
    margin: page-margins,
    numbering: "1",
    number-align: center,
    background: if profile == "draft" {
      // Enhanced draft watermark
      {
        // Semi-transparent overlay
        rect(width: 100%, height: 100%, fill: rgb(255, 255, 255, 95%))
        // Diagonal watermark text
        place(center, rotate(24deg, text(
          size: 72pt,
          fill: rgb(255, 0, 0, 8%),
          weight: "bold",
          font: style.fonts.sans,
        )[DRAFT]))
        // Corner timestamp for draft tracking
        place(bottom + right, dx: -1cm, dy: -0.5cm, text(
          size: 8pt,
          fill: rgb(150, 150, 150),
          font: style.fonts.mono,
        )[
          Draft - #(datetime.today().display())
        ])
      }
    } else if profile == "screen" {
      // Subtle screen indicator
      {
        place(top + right, dx: -1cm, dy: 0.5cm, text(
          size: 10pt,
          fill: rgb(0, 100, 255, 60%),
          font: style.fonts.sans,
          style: "italic",
        )[Screen View])
      }
    } else { none },
  )

  set text(..text-rendering)

  set heading(numbering: "1.1.1")

  show heading: it => {
    set text(weight: "bold", fill: style.colors.primary)
    if it.level == 1 {
      if is-double-sided {
        pagebreak(to: "odd")
      } else {
        pagebreak(weak: true)
      }
      v(style.spacing.heading-above.at("1", default: 2em))
      text(size: 16pt, it)
      v(style.spacing.heading-below.at("1", default: 1em))
    } else if it.level == 2 {
      v(style.spacing.heading-above.at("2", default: 1.5em))
      text(size: 14pt, it)
      v(style.spacing.heading-below.at("2", default: 0.8em))
    } else {
      v(style.spacing.heading-above.at("3", default: 1em))
      text(size: 12pt, it)
      v(style.spacing.heading-below.at("3", default: 0.5em))
    }
  }

  set par(
    leading: style.spacing.paragraph-leading,
    first-line-indent: 1.5em,
    justify: true,
  )

  set list(indent: 1.5em)
  set enum(indent: 1.5em)
  show figure: set block(breakable: true)
  show raw: set text(font: style.fonts.mono)
  show link: set text(fill: style.colors.primary)
  show math.equation: set block(spacing: 1.5em)

  set page(
    header: context {
      // Robustly coerce the title to a plain string to ensure the
      // header emits only visible text (no serialized layout nodes).
      let header_title = title
      let current = counter(page).get().first()
      if current > 1 {
        // Compute a safe string for the header. Some callers may pass
        // nodes or structured content for `title`; convert those to a
        // plain string.
        let header_text = if type(header_title) == str {
          header_title
        } else if header_title == none {
          ""
        } else {
          str(header_title)
        }

        // Emit only a single plain text node. Avoid `set text(...)` and
        // other layout commands here which may be serialized in some
        // contexts and leak into the PDF text layer.
        text(header_text + " — " + counter(page).display())
      }
    },
    footer: context {
      let current = counter(page).get().first()
      if current > 1 {
        line(length: 100%, stroke: 0.5pt)
      }
    },
  )

  counter(page).update(1)

  body
}

// =================================
// Appendix Layout
// =================================

#let appendix-layout(ctx, body) = {
  let style = resolve-style(ctx)
  let locale = resolve-locale(ctx)
  let profile = resolve-profile(ctx)

  counter(heading).update(0)
  set heading(numbering: "A.1.1")

  // Profile-specific page settings for appendix
  let page-margins = if profile == "screen" {
    // Optimized margins for screen reading
    (
      top: 2cm,
      bottom: 2cm,
      left: 2.5cm,
      right: 2.5cm,
    )
  } else {
    (
      top: 2.5cm,
      bottom: 2.5cm,
      left: 3cm,
      right: 3cm,
    )
  }

  set page(
    paper: "a4",
    margin: page-margins,
    background: if profile == "draft" {
      // Enhanced draft watermark
      {
        // Semi-transparent overlay
        rect(width: 100%, height: 100%, fill: rgb(255, 255, 255, 95%))
        // Diagonal watermark text
        place(center, rotate(24deg, text(
          size: 72pt,
          fill: rgb(255, 0, 0, 8%),
          weight: "bold",
          font: style.fonts.sans,
        )[DRAFT]))
        // Corner timestamp for draft tracking
        place(bottom + right, dx: -1cm, dy: -0.5cm, text(
          size: 8pt,
          fill: rgb(150, 150, 150),
          font: style.fonts.mono,
        )[
          Draft - #(datetime.today().display())
        ])
      }
    } else if profile == "screen" {
      // Subtle screen indicator
      {
        place(top + right, dx: -1cm, dy: 0.5cm, text(
          size: 10pt,
          fill: rgb(0, 100, 255, 60%),
          font: style.fonts.sans,
          style: "italic",
        )[Screen View])
      }
    } else { none },
  )

  show heading: it => {
    let bookmarked = heading(it.body, level: it.level, bookmark: true)
    set text(weight: "bold", fill: style.colors.primary)
    if it.level == 1 {
      pagebreak(weak: true)
      v(style.spacing.heading-above.at(1, default: 2em))
      // Build a safe plain string for the appendix heading to avoid
      // passing complex nodes/arrays into `text()` which can sometimes
      // serialize into the PDF text layer in edge cases.
      let appendix_label = "Appendix " + counter(heading).display()
      let appendix_title = if it.body != none { str(it.body) } else { "" }
      let heading_text = if appendix_title != "" {
        appendix_label + ": " + appendix_title
      } else { appendix_label }
      // The bookmarked heading is created above, so the bookmark will be generated
      text(size: 16pt, heading_text)
      v(style.spacing.heading-below.at(1, default: 1em))
    } else if it.level == 2 {
      v(style.spacing.heading-above.at(2, default: 1.5em))
      text(size: 14pt, bookmarked)
      v(style.spacing.heading-below.at(2, default: 0.8em))
    } else {
      v(style.spacing.heading-above.at(3, default: 1em))
      text(size: 12pt, bookmarked)
      v(style.spacing.heading-below.at(3, default: 0.5em))
    }
  }

  // Profile-specific text rendering optimizations
  let text-rendering = if profile == "draft" {
    // Faster rendering for draft mode
    (font: style.fonts.serif, size: 12pt, lang: locale)
  } else if profile == "screen" {
    // Optimized for screen reading
    (font: style.fonts.serif, size: 12pt, lang: locale, hyphenate: true)
  } else {
    // High quality for print
    (font: style.fonts.serif, size: 12pt, lang: locale)
  }

  set text(..text-rendering)

  set par(
    leading: style.spacing.paragraph-leading,
    first-line-indent: 1.5em,
    justify: true,
  )

  body
}
