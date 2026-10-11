#import "component/code.typ": themed_code
#import "component/heading.typ": themed_heading
#import "component/math.typ": themed_math
#import "component/page.typ": themed_page
#import "component/table.typ": themed_table
#import "component/terms.typ": themed_terms
#import "component/text.typ": themed_text
#import "component/title.typ": themed_title
#import "theme.typ": casual_theme

#let theme = casual_theme

#let casual_text(body) = themed_text(theme, body)
#let casual_page(body) = themed_page(
  theme,
  body,
  header-align: right,
  footer-content: grid(
    columns: (1fr, 1fr, 1fr),
    text(
      size: theme.sizes.small,
      font: theme.type.secondary.font,
      weight: theme.type.secondary.weight,
      style: theme.type.secondary.style,
      context document.author.join(" & "),
    ),
    align(
      center,
      text(
        size: theme.sizes.small,
        font: theme.type.secondary.font,
        weight: theme.type.secondary.weight,
        style: theme.type.secondary.style,
        context counter(page).display(
          "1 - 1",
          both: true,
        ),
      ),
    ),
    align(right, text(
      size: theme.sizes.small,
      font: theme.type.secondary.font,
      weight: theme.type.secondary.weight,
      style: theme.type.secondary.style,
      context document.date.display(),
    )),
  ),
)

#let casual_title(body) = themed_title(
  theme,
  body,
  title-align: left,
  meta-content: (
    h(1em)
      + text(
        size: theme.sizes.regular,
        font: theme.type.secondary.font,
        weight: theme.type.secondary.weight,
        style: theme.type.secondary.style,
        context document.author.join(" & "),
      )
      + h(1fr)
      + text(
        size: theme.sizes.regular,
        font: theme.type.secondary.font,
        weight: theme.type.secondary.weight,
        style: theme.type.secondary.style,
        context document.date.display(),
      )
      + h(1em)
  ),
  after-title: 0.7em,
  after-meta: 1em,
)

#let casual_heading(body) = themed_heading(
  theme,
  body,
  numbering: "1.1",
  width: 100%,
  inset: it => (
    bottom: 7pt,
    left: -10pt,
  ),
  align-position: left,
)

#let casual_math(body) = themed_math(theme, body)
#let casual_code(body) = themed_code(theme, body)
#let casual_table(body) = themed_table(theme, body)
#let casual_terms(body) = themed_terms(theme, body)

#let casual(body) = {
  show: casual_text
  show: casual_page
  show: casual_heading
  show: casual_math
  show: casual_code
  show: casual_table
  show: casual_terms
  show: casual_title
  body
}
