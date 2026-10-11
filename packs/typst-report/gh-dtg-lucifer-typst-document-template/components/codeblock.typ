// components/codeblock.typ
// Monospace code blocks with line numbering, left accent bars, and terminal consoles.
// Uses SFMono Nerd Font embedded in assets/fonts.

#import "theme.typ": resolve-palette, current-theme

#let mono-fonts = ("SF Mono", "IBM Plex Mono", "DejaVu Sans Mono")

// Inline Code Snippet
#let codeinline(body) = context {
  let p = resolve-palette(theme-override: current-theme.get())
  box(
    fill: p.code.inline-bg,
    stroke: 0.4pt + p.code.inline-border,
    radius: 3pt,
    inset: (x: 3.5pt, y: 0pt),
    outset: (y: 2.5pt),
    baseline: 0%,
    text(font: mono-fonts, size: 8.5pt, fill: p.code.text)[#body]
  )
}

// Full-featured Code Block with optional title/filename tab and line numbers
#let codeblock(
  lang: none,
  filename: none,
  line-numbers: true,
  body
) = context {
  let p = resolve-palette(theme-override: current-theme.get())

  block(
    width: 100%,
    radius: (right: 4pt, left: 0pt),
    clip: true,
    stroke: (left: 3.5pt + p.code.bar, rest: 0.6pt + p.code.border),
    fill: p.code.bg,
    inset: 0pt,
    breakable: false,
    [
      #if filename != none or lang != none [
        #block(
          width: 100%,
          fill: if p.mode == "dark" { rgb("#141d30") } else { rgb("#f1f5f9") },
          inset: (x: 10pt, y: 5pt),
          stroke: (bottom: 0.5pt + p.code.border),
          [
            #grid(
              columns: (1fr, auto),
              align: (left + horizon, right + horizon),
              if filename != none [
                #text(font: mono-fonts, size: 8pt, weight: "bold", fill: p.text)[#filename]
              ] else [ ],
              if lang != none [
                #text(font: mono-fonts, size: 7.5pt, fill: p.text-muted)[#upper(lang)]
              ] else [ ]
            )
          ]
        )
      ]
      #block(
        width: 100%,
        inset: (x: 10pt, y: 8pt),
        [
          #set text(font: mono-fonts, size: 8.5pt, fill: p.code.text)
          #show raw.where(block: true): it => {
            if line-numbers and it.lines.len() > 0 {
              grid(
                columns: (auto, 1fr),
                column-gutter: 10pt,
                row-gutter: 3.5pt,
                ..it.lines.map(line => (
                  align(right, text(fill: p.code.line-number, font: mono-fonts, size: 7.5pt, str(line.number))),
                  line
                )).flatten()
              )
            } else if it.lines.len() > 0 {
              grid(
                columns: (1fr,),
                row-gutter: 3.5pt,
                ..it.lines
              )
            } else {
              it
            }
          }
          #body
        ]
      )
    ]
  )
}

// Plain Code Block (no line numbers, clean formatting)
#let plaincodeblock(body) = context {
  let p = resolve-palette(theme-override: current-theme.get())

  block(
    width: 100%,
    fill: p.code.bg,
    stroke: (left: 3pt + p.code.bar, rest: 0.6pt + p.code.border),
    radius: (right: 4pt, left: 0pt),
    inset: (x: 10pt, y: 8pt),
    [
      #set text(font: mono-fonts, size: 8.5pt, fill: p.code.text)
      #show raw.where(block: true): it => {
        if it.lines.len() > 0 {
          grid(
            columns: (1fr,),
            row-gutter: 3.5pt,
            ..it.lines
          )
        } else {
          it
        }
      }
      #body
    ]
  )
}

// Interactive Terminal / Console Block
#let consoleblock(body, prompt: "$") = context {
  let p = resolve-palette(theme-override: current-theme.get())
  let is-dark = p.mode == "dark"

  block(
    width: 100%,
    fill: if is-dark { rgb("#070b14") } else { rgb("#0f172a") },
    stroke: 0.6pt + if is-dark { rgb("#1e293b") } else { rgb("#334155") },
    radius: 4pt,
    inset: 0pt,
    clip: true,
    [
      // macOS / Linux style terminal header buttons
      #block(
        width: 100%,
        fill: if is-dark { rgb("#0d1322") } else { rgb("#1e293b") },
        inset: (x: 10pt, y: 5pt),
        [
          #grid(
            columns: (auto, 1fr),
            align: (left + horizon, right + horizon),
            [
              #box(circle(radius: 3pt, fill: rgb("#ef4444")))
              #h(3pt)
              #box(circle(radius: 3pt, fill: rgb("#f59e0b")))
              #h(3pt)
              #box(circle(radius: 3pt, fill: rgb("#10b981")))
            ],
            [
              #text(font: mono-fonts, size: 7.5pt, fill: rgb("#94a3b8"))[terminal]
            ]
          )
        ]
      )
      #block(
        width: 100%,
        inset: (x: 12pt, y: 9pt),
        [
          #set text(font: mono-fonts, size: 8.5pt, fill: rgb("#f8fafc"))
          #body
        ]
      )
    ]
  )
}
