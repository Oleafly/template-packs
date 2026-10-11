// For 12pt font size
#let tiny(body) = text(6pt, body)
#let scriptsize(body) = text(8pt, body)
#let footnotesize(body) = text(10pt, body)
#let small(body) = text(10.95pt, body)
#let normalsize(body) = text(12pt, body)
#let large(body) = text(size: 14.4pt, body)
#let Large(body) = text(size: 17.28pt, body)
#let LARGE(body) = text(size: 20.74pt, body)
#let huge(body) = text(size: 24.88pt, body)
#let HUGE(body) = text(size: 24.88pt, body)

#let inline(body, ..opts) = box(inset: 0pt, body, ..opts)

#let underwrite(title, content) = {
  layout(size => {
    stack(
      dir: ttb,
      content,
      block(
        inset: (y: 2pt),
        line(
          length: measure(content).width,
          stroke: 0.5pt
        )
      ),
      scriptsize[#title]
    )
  })
}
