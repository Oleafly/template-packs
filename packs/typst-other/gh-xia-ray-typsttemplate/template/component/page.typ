#let themed_page(
  theme,
  body,
  header-align: center,
  header-content: auto,
  footer-content: auto,
) = {
  set page(
    paper: theme.page.paper,
    margin: theme.page.margin,
    header: context {
      if counter(page).get().first() > 1 {
        let header_title = text(
          document.title,
          size: theme.sizes.small,
          font: theme.type.accent.font,
          weight: theme.type.accent.weight,
          style: theme.type.accent.style,
        )
        align(
          header-align,
          if header-content == auto {
            if theme.title.small-caps {
              smallcaps(header_title)
            } else {
              header_title
            }
          } else {
            header-content
          },
        )
      }
    },
    footer: context {
      if counter(page).get().first() > 1 {
        set text(
          size: theme.sizes.small,
          font: theme.type.accent.font,
          weight: theme.type.accent.weight,
          style: theme.type.accent.style,
        )
        if footer-content == auto {
          align(center, text(
            counter(page).display(
              "1 / 1",
              both: true,
            ),
          ))
        } else {
          footer-content
        }
      }
    },
  )
  body
}
