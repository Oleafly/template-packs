// BOXES - Semantic content boxes
//
// Provides styled boxes for different content types.
// All boxes support customization via optional parameters.
//
// CUSTOMIZATION OPTIONS (all boxes support these):
// - title:     Override the box title
// - icon:      Override the icon (set to `none` to hide)
// - color:     Override the box color
// - breakable: Allow page breaks inside the box
//

#import "../colors.typ": colors, box-colors
#import "../config.typ": icons, titles, question-format, format-question-num

// QUESTION COUNTER

/// Counter for auto-numbered questions.
/// Use `reset-questions()` to reset or set to a specific value.
#let question-counter = counter("question")

/// Reset the question counter to a specific value.
/// The next `#question` will be numbered `value + 1`.
///
/// ```example
/// #reset-questions(0)
/// #question[This will be Question 1]
///
/// #reset-questions(9)
/// #question[This will be Question 10]
/// ```
///
/// - value (int): The value to set the counter to.
#let reset-questions(value) = {
  question-counter.update(value)
}

// CORE BOX BUILDER

/// Internal function to create styled boxes.
/// All public box functions use this as their base.
///
/// - color (color): The accent color for the box.
/// - title (content, none): Title shown in the header bar.
/// - icon (content, none): Icon shown before the title.
/// - breakable (bool): Whether the box can break across pages.
/// - body (content): The box content.
/// -> content
#let styled-box(
  color: colors.question,
  title: none,
  icon: none,
  breakable: false,
  body,
) = {
  let scheme = box-colors(color)

  block(
    width: 100%,
    above: 0.6em,
    below: 0.6em,
    breakable: breakable,
    stroke: (paint: scheme.border, thickness: 0.8pt),
    radius: 3pt,
    clip: true,
    grid(
      columns: (100%,),
      rows: auto,
      gutter: 0pt,
      // Title bar
      if title != none {
        block(
          width: 100%,
          fill: scheme.title-bg,
          inset: (x: 10pt, y: 6pt),
          below: 0pt,
          {
            set text(weight: "bold", size: 0.95em)
            if icon != none { [#icon ] }
            title
          }
        )
      },
      // Content
      block(
        width: 100%,
        fill: scheme.bg,
        inset: 10pt,
        above: 0pt,
        body
      )
    )
  )
}

// QUESTION BOXES

/// Auto-numbered question box.
/// Each call increments the question counter.
///
/// ```example
/// #question[What is Typst?]
/// #question[How does it compare to LaTeX?]
/// ```
///
/// - title (auto, content): Override the title. Use `auto` for numbered title.
/// - icon (auto, content, none): Override the icon. Use `none` to hide.
/// - color (color): Override the box color.
/// - format (str): Question number format string with `{num}` placeholder.
/// - breakable (bool): Allow page breaks inside the box.
/// - body (content): The question content.
/// -> content
#let question(
  title: auto,
  icon: auto,
  color: colors.question,
  format: question-format,
  breakable: false,
  body,
) = {
  question-counter.step()
  context {
    let num = question-counter.get().first()
    let actual-title = if title == auto {
      format-question-num(num, format: format)
    } else { title }
    let actual-icon = if icon == auto { icons.question } else { icon }

    styled-box(
      color: color,
      title: actual-title,
      icon: actual-icon,
      breakable: breakable,
      body
    )
  }
}

/// Question box with explicit number.
/// Does not affect the auto-numbering counter.
///
/// ```example
/// #question-num(42)[The answer to everything]
/// #question-num(1, format: "Ex. {num}")[Exercise format]
/// ```
///
/// - num (int): The question number to display.
/// - title (auto, content): Override entire title (ignores `num` if set).
/// - icon (auto, content, none): Override the icon.
/// - color (color): Override the box color.
/// - format (str): Question number format string.
/// - breakable (bool): Allow page breaks inside the box.
/// - body (content): The question content.
/// -> content
#let question-num(
  num,
  title: auto,
  icon: auto,
  color: colors.question,
  format: question-format,
  breakable: false,
  body,
) = {
  let actual-title = if title == auto {
    format-question-num(num, format: format)
  } else { title }
  let actual-icon = if icon == auto { icons.question } else { icon }

  styled-box(
    color: color,
    title: actual-title,
    icon: actual-icon,
    breakable: breakable,
    body
  )
}

// RESPONSE BOXES

/// Response/answer box with title bar.
///
/// ```example
/// #response[
///   The answer is 42.
/// ]
/// ```
///
/// - title (auto, content): Override the title.
/// - icon (auto, content, none): Override the icon.
/// - color (color): Override the box color.
/// - breakable (bool): Allow page breaks inside the box.
/// - body (content): The response content.
/// -> content
#let response(
  title: auto,
  icon: auto,
  color: colors.response,
  breakable: false,
  body,
) = {
  let actual-title = if title == auto { titles.response } else { title }
  let actual-icon = if icon == auto { icons.response } else { icon }

  styled-box(
    color: color,
    title: actual-title,
    icon: actual-icon,
    breakable: breakable,
    body
  )
}

/// Response box without title bar (inline style).
/// Useful for brief answers or inline content.
///
/// - color (color): Override the box color.
/// - breakable (bool): Allow page breaks inside the box.
/// - body (content): The response content.
/// -> content
#let response-inline(
  color: colors.response,
  breakable: false,
  body,
) = {
  styled-box(color: color, breakable: breakable, body)
}

// COMMAND BOX

/// Terminal/command box for shell commands or code snippets.
///
/// ```example
/// #cmd[
///   ```bash
///   typst compile main.typ
///   ```
/// ]
/// ```
///
/// - title (auto, content): Override the title.
/// - icon (auto, content, none): Override the icon.
/// - color (color): Override the box color.
/// - breakable (bool): Allow page breaks inside the box.
/// - body (content): The command content.
/// -> content
#let cmd(
  title: auto,
  icon: auto,
  color: colors.command,
  breakable: false,
  body,
) = {
  let actual-title = if title == auto { titles.command } else { title }
  let actual-icon = if icon == auto { icons.command } else { icon }

  styled-box(
    color: color,
    title: actual-title,
    icon: actual-icon,
    breakable: breakable,
    body
  )
}

// CALLOUT BOXES

/// Important/warning notice box.
/// Use for critical information the reader must not miss.
///
/// ```example
/// #important[
///   Do not forget to save your work!
/// ]
/// ```
///
/// - title (auto, content): Override the title.
/// - icon (auto, content, none): Override the icon.
/// - color (color): Override the box color.
/// - breakable (bool): Allow page breaks inside the box.
/// - body (content): The important content.
/// -> content
#let important(
  title: auto,
  icon: auto,
  color: colors.warning,
  breakable: false,
  body,
) = {
  let actual-title = if title == auto { titles.important } else { title }
  let actual-icon = if icon == auto { icons.important } else { icon }

  styled-box(
    color: color,
    title: actual-title,
    icon: actual-icon,
    breakable: breakable,
    body
  )
}

/// Tip/hint box.
/// Use for helpful suggestions or shortcuts.
///
/// ```example
/// #tip[
///   Use `typst watch` for live preview!
/// ]
/// ```
///
/// - title (auto, content): Override the title.
/// - icon (auto, content, none): Override the icon.
/// - color (color): Override the box color.
/// - breakable (bool): Allow page breaks inside the box.
/// - body (content): The tip content.
/// -> content
#let tip(
  title: auto,
  icon: auto,
  color: colors.response,
  breakable: false,
  body,
) = {
  let actual-title = if title == auto { titles.tip } else { title }
  let actual-icon = if icon == auto { icons.tip } else { icon }

  styled-box(
    color: color,
    title: actual-title,
    icon: actual-icon,
    breakable: breakable,
    body
  )
}

/// Information box.
/// Use for neutral supplementary information.
///
/// ```example
/// #info[
///   See the official docs at typst.app/docs
/// ]
/// ```
///
/// - title (auto, content): Override the title.
/// - icon (auto, content, none): Override the icon.
/// - color (color): Override the box color.
/// - breakable (bool): Allow page breaks inside the box.
/// - body (content): The info content.
/// -> content
#let info(
  title: auto,
  icon: auto,
  color: colors.metadata,
  breakable: false,
  body,
) = {
  let actual-title = if title == auto { titles.info } else { title }
  let actual-icon = if icon == auto { icons.info } else { icon }

  styled-box(
    color: color,
    title: actual-title,
    icon: actual-icon,
    breakable: breakable,
    body
  )
}

// STATUS BOXES

/// Prerequisites/requirements box.
/// Use to list what readers need before starting.
///
/// ```example
/// #requirement[
///   - Basic programming knowledge
///   - Typst installed
/// ]
/// ```
///
/// - title (auto, content): Override the title.
/// - icon (auto, content, none): Override the icon.
/// - color (color): Override the box color.
/// - breakable (bool): Allow page breaks inside the box.
/// - body (content): The requirements content.
/// -> content
#let requirement(
  title: auto,
  icon: auto,
  color: colors.requirement,
  breakable: false,
  body,
) = {
  let actual-title = if title == auto { titles.requirement } else { title }
  let actual-icon = if icon == auto { icons.requirement } else { icon }

  styled-box(
    color: color,
    title: actual-title,
    icon: actual-icon,
    breakable: breakable,
    body
  )
}

/// Result/output box.
/// Use to display expected output or results.
///
/// ```example
/// #result[
///   Output: Hello, World!
/// ]
/// ```
///
/// - title (auto, content): Override the title.
/// - icon (auto, content, none): Override the icon.
/// - color (color): Override the box color.
/// - breakable (bool): Allow page breaks inside the box.
/// - body (content): The result content.
/// -> content
#let result(
  title: auto,
  icon: auto,
  color: colors.response,
  breakable: false,
  body,
) = {
  let actual-title = if title == auto { titles.result } else { title }
  let actual-icon = if icon == auto { icons.result } else { icon }

  styled-box(
    color: color,
    title: actual-title,
    icon: actual-icon,
    breakable: breakable,
    body
  )
}

// CONTEXT BOXES

/// Scope/boundaries box.
/// Use to define what is covered or evaluated.
///
/// ```example
/// #scope[
///   This exam covers chapters 1-5.
/// ]
/// ```
///
/// - title (auto, content): Override the title.
/// - icon (auto, content, none): Override the icon.
/// - color (color): Override the box color.
/// - breakable (bool): Allow page breaks inside the box.
/// - body (content): The scope content.
/// -> content
#let scope(
  title: auto,
  icon: auto,
  color: colors.scope,
  breakable: false,
  body,
) = {
  let actual-title = if title == auto { titles.scope } else { title }
  let actual-icon = if icon == auto { icons.scope } else { icon }

  styled-box(
    color: color,
    title: actual-title,
    icon: actual-icon,
    breakable: breakable,
    body
  )
}

/// Example box.
/// Use for demonstrations or sample content.
///
/// ```example
/// #example[
///   Here's how to write a function:
///   ```typst
///   #let greet(name) = [Hello, #name!]
///   ```
/// ]
/// ```
///
/// - title (auto, content): Override the title.
/// - icon (auto, content, none): Override the icon.
/// - color (color): Override the box color.
/// - breakable (bool): Allow page breaks inside the box.
/// - body (content): The example content.
/// -> content
#let example(
  title: auto,
  icon: auto,
  color: colors.timeline,
  breakable: false,
  body,
) = {
  let actual-title = if title == auto { titles.example } else { title }
  let actual-icon = if icon == auto { icons.example } else { icon }

  styled-box(
    color: color,
    title: actual-title,
    icon: actual-icon,
    breakable: breakable,
    body
  )
}

// GENERIC / CUSTOM BOX

/// Create a fully custom box with any title, icon, and color.
/// Use this when the predefined boxes don't fit your needs.
///
/// ```example
/// #custom-box(
///   title: "Note",
///   icon: sym.note,
///   color: colors.metadata,
/// )[
///   A custom note box.
/// ]
/// ```
///
/// - title (content, none): Box title (omit for no header).
/// - icon (content, none): Icon shown before the title.
/// - color (color): Box accent color.
/// - breakable (bool): Allow page breaks inside the box.
/// - body (content): The box content.
/// -> content
#let custom-box(
  title: none,
  icon: none,
  color: colors.question,
  breakable: false,
  body,
) = {
  styled-box(
    color: color,
    title: title,
    icon: icon,
    breakable: breakable,
    body
  )
}

/// Simple colored box without header.
/// Use for basic highlighted content.
///
/// - color (color): Box accent color.
/// - breakable (bool): Allow page breaks inside the box.
/// - body (content): The box content.
/// -> content
#let colorbox(
  color: colors.question,
  breakable: false,
  body,
) = {
  styled-box(color: color, breakable: breakable, body)
}

// FRENCH ALIASES

/// Alias for `question`.
#let que = question

/// Alias for `response`.
#let res = response

/// Alias for `response` (French spelling).
#let reponse = response

/// Alias for `cmd`.
#let commande = cmd

/// Alias for `tip`.
#let astuce = tip

/// Alias for `requirement`.
#let prerequis = requirement

/// Alias for `result`.
#let resultat = result

/// Alias for `scope`.
#let perimetre = scope

/// Alias for `example`.
#let exemple = example
