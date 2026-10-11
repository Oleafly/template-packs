#let render-footer(
  en_name: "",
  updated: datetime.today(),
  footer_size: 8pt,
  footer_show_name: true,
  footer_text: none,
  footer_show_updated: true,
  footer_updated_prefix: "Last Updated:",
  footer_show_page: true,
  footer_page_format: "1 of 1",
) = [
  #align(center)[
    #text(
      size: footer_size,
      fill: luma(40%),
    )[
      #{
        let footer-items = ()
        if footer_show_name and en_name != none and en_name != "" {
          footer-items.push([*#en_name*])
        }
        if footer_text != none and footer_text != "" {
          footer-items.push([#footer_text])
        }
        if footer_show_updated {
          if footer_updated_prefix != none and footer_updated_prefix != "" {
            footer-items.push([#footer_updated_prefix #updated.display("[month repr:short] [year]")])
          } else {
            footer-items.push([#updated.display("[month repr:short] [year]")])
          }
        }
        if footer_show_page {
          footer-items.push([#context { counter(page).display(footer_page_format, both: true) }])
        }
        let separator = [#h(0.4em)-#h(0.4em)]
        footer-items.join(separator)
      }
    ]
  ]
]
