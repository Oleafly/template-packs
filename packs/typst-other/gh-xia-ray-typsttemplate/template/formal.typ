#import "component/code.typ": themed_code
#import "component/heading.typ": themed_heading
#import "component/math.typ": themed_math
#import "component/page.typ": themed_page
#import "component/table.typ": themed_table
#import "component/terms.typ": themed_terms
#import "component/text.typ": themed_text
#import "component/title.typ": themed_title
#import "theme.typ": formal_theme

#let theme = formal_theme

#let formal_text(body) = themed_text(theme, body)
#let formal_page(body) = themed_page(
  theme,
  body,
  header-align: center,
)

#let formal_title(body) = themed_title(
  theme,
  body,
  title-align: center,
  title-layout: "stacked",
  title-include-first: true,
  after-title: 1em,
  after-meta: 1.5em,
)

#let formal_heading(body) = themed_heading(
  theme,
  body,
  numbering: "1.1",
  width: 100%,
  inset: it => (
    bottom: 7pt,
    left: -10pt,
  ),
  align-position: center,
)

#let formal_math(body) = themed_math(theme, body)
#let formal_code(body) = themed_code(theme, body)
#let formal_table(body) = themed_table(theme, body)
#let formal_terms(body) = themed_terms(theme, body)

#let formal(body) = {
  show: formal_text
  show: formal_page
  show: formal_heading
  show: formal_math
  show: formal_code
  show: formal_table
  show: formal_terms
  show: formal_title
  body
}
