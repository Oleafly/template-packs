// components/codeblock.typ
// Elegant code blocks, terminal consoles, and inline code with SFMono Nerd Font support

#import "theme.typ": resolve-palette

/// Default monospace font using the bundled SFMono Nerd Font
#let code-font = ("SF Mono", "DejaVu Sans Mono")

/// Styled code block with header bar, language badge, line numbers, and left accent border
/// - code: string of code or raw block (can be passed positionally or via `code: ...`)\
/// - lang: language name (e.g. "python", "typst", "rust", "latex", "c")\
/// - title: optional filename or description (e.g. "main.py", "Algorithm 1")\
/// - line-numbers: boolean (default: true)\
/// - theme: optional theme override ("light" or "dark")
#let codeblock(
  ..args,
) = {
  let pos = args.pos()
  let named = args.named()

  let code = if pos.len() > 0 {
    pos.first()
  } else if "code" in named {
    named.at("code")
  } else {
    ""
  }

  let lang = named.at("lang", default: none)
  let title = named.at("title", default: none)
  let line-numbers = named.at("line-numbers", default: true)
  let bar-color = named.at("bar-color", default: auto)
  let bg-color = named.at("bg-color", default: auto)
  let theme = named.at("theme", default: none)

  context {
    let p = resolve-palette(theme-override: theme)
    let c-bg = if bg-color == auto { p.code.bg } else { bg-color }
    let c-gutter = p.code.gutter
    let c-border = p.code.border
    let c-bar = if bar-color == auto { p.code.bar } else { bar-color }
    let c-line-num = p.code.line-num
    let c-title = p.code.title
    let c-lang = p.code.lang
    let c-text = p.code.text

    // If code is already a raw block, extract its text and lang if not provided
    let content-str = code
    let detected-lang = lang
    if type(code) == content and code.has("text") {
      content-str = code.text
      if detected-lang == none and code.has("lang") {
        detected-lang = code.lang
      }
    }

    v(8pt)
    block(
      width: 100%,
      stroke: (left: 2.2pt + c-bar, rest: 0.75pt + c-border),
      fill: c-bg,
      radius: (right: 3.5pt),
      clip: true,
      breakable: true,
      {
        if title != none or detected-lang != none {
          block(
            width: 100%,
            fill: c-gutter,
            inset: (x: 10pt, y: 5.5pt),
            stroke: (bottom: 0.75pt + c-border),
            grid(
              columns: (1fr, auto),
              align: (left + horizon, right + horizon),
              if title != none {
                text(
                  weight: "bold",
                  size: 8.5pt,
                  fill: c-title,
                  font: code-font,
                  title
                )
              } else { [] },
              if detected-lang != none {
                box(
                  fill: if p.mode == "dark" { rgb("#24273a") } else { rgb(255, 255, 255, 80%) },
                  stroke: 0.5pt + c-border,
                  radius: 2pt,
                  inset: (x: 5pt, y: 1.5pt),
                  text(
                    weight: "bold",
                    size: 7.5pt,
                    fill: c-lang,
                    font: code-font,
                    detected-lang
                  )
                )
              } else { [] }
            )
          )
        }

        block(
          inset: (x: 10pt, top: 7pt, bottom: 8pt),
          {
            set text(
              font: code-font,
              size: 8.5pt,
              fill: c-text
            )
            if line-numbers {
              show raw.line: it => {
                box(
                  width: 2.2em,
                  align(right, text(fill: c-line-num, size: 7.5pt, str(it.number) + "  "))
                )
                it.body
              }
              if type(content-str) == str {
                raw(content-str, lang: detected-lang, block: true)
              } else {
                content-str
              }
            } else {
              if type(content-str) == str {
                raw(content-str, lang: detected-lang, block: true)
              } else {
                content-str
              }
            }
          }
        )
      }
    )
  }
}

/// Plain code block without line numbers (Charlie's \plaincodeblock)
#let plaincodeblock(..args) = {
  let named = args.named()
  named.insert("line-numbers", false)
  codeblock(..args.pos(), ..named)
}

/// LaTeX code block (Charlie's \latexcodeblock)
#let latexcodeblock(..args) = {
  let named = args.named()
  if "lang" not in named { named.insert("lang", "latex") }
  if "title" not in named { named.insert("title", "LaTeX") }
  codeblock(..args.pos(), ..named)
}

/// Styled console / terminal block with prompt and output (Charlie's \consoleblock)
/// - cmd: the shell command or lines to execute (can be passed positionally or via `cmd: ...`)\
/// - output: optional command output\
/// - title: header title (default: "Terminal")\
/// - prompt: shell prompt symbol (default: "$ ")
#let consoleblock(
  ..args,
) = {
  let pos = args.pos()
  let named = args.named()

  let cmd = if pos.len() > 0 {
    pos.first()
  } else if "cmd" in named {
    named.at("cmd")
  } else {
    ""
  }

  let output = named.at("output", default: none)
  let title = named.at("title", default: "Terminal")
  let prompt = named.at("prompt", default: "$ ")
  let theme = named.at("theme", default: none)

  context {
    let p = resolve-palette(theme-override: theme)
    let c-bg = if p.mode == "dark" { rgb("#10121a") } else { rgb("#1e293b") }
    let c-fg = if p.mode == "dark" { rgb("#e2e8f0") } else { rgb("#f8fafc") }
    let c-prompt = rgb("#38bdf8")
    let c-header = if p.mode == "dark" { rgb("#161922") } else { rgb("#0f172a") }
    let c-border = if p.mode == "dark" { rgb("#2d3548") } else { rgb("#334155") }

    v(8pt)
    block(
      width: 100%,
      stroke: 0.75pt + c-border,
      fill: c-bg,
      radius: 3.5pt,
      clip: true,
      breakable: true,
      {
        block(
          width: 100%,
          fill: c-header,
          inset: (x: 10pt, y: 5pt),
          stroke: (bottom: 0.75pt + c-border),
          grid(
            columns: (auto, 1fr),
            gutter: 8pt,
            align: (left + horizon, left + horizon),
            stack(
              dir: ltr,
              spacing: 4pt,
              circle(radius: 3pt, fill: rgb("#ef4444")),
              circle(radius: 3pt, fill: rgb("#f59e0b")),
              circle(radius: 3pt, fill: rgb("#10b981")),
            ),
            text(
              fill: rgb("#94a3b8"),
              size: 8pt,
              weight: "bold",
              font: code-font,
              title
            )
          )
        )

        block(
          inset: (x: 12pt, y: 8pt),
          {
            set text(
              font: code-font,
              size: 8.5pt,
              fill: c-fg
            )
            if type(cmd) == str {
              let lines = cmd.split("\n")
              for (i, line-str) in lines.enumerate() {
                if i > 0 { v(2pt) }
                text(fill: c-prompt, weight: "bold", prompt)
                text(line-str)
              }
            } else {
              cmd
            }

            if output != none {
              v(6pt)
              line(length: 100%, stroke: 0.5pt + rgb("#334155"))
              v(4pt)
              text(fill: rgb("#cbd5e1"), output)
            }
          }
        )
      }
    )
  }
}

/// Clean inline code badge using SFMono Nerd Font
#let codeinline(body, theme: none) = {
  context {
    let p = resolve-palette(theme-override: theme)
    box(
      fill: p.code.bg,
      stroke: 0.5pt + p.code.border,
      radius: 2pt,
      inset: (x: 4pt, y: 1.5pt),
      baseline: 0%,
      text(
        font: code-font,
        size: 8pt,
        fill: p.code.title,
        body
      )
    )
  }
}
