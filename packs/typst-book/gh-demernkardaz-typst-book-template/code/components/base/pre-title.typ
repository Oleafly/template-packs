#import "../../plugin/lib.typ": *

#let pre-title(
	logo-width: 128pt + 32pt,
	logo-name: "Логотип серии",
	space-between-text: 1em,
	space-after-logo: 4em,
	entries: ()
) = {
	pagebreak()

	place(
		center + horizon,
		stack(
			dir: ttb,
			spacing: 1em,
			image(meta.get-asset(logo-name), width: logo-width),
      v(space-after-logo),

      ..entries.map(entry => {
        if type(entry) == dictionary and "text" in entry {
          let text-cfg = entry.text
          let condition = text-cfg.at("if", default: true)

          if condition {
            let raw-content = text-cfg.at("content", default: [])
            let content = if type(raw-content) == function { raw-content() } else { raw-content }

            text(
              size: text-cfg.at("size", default: 12pt),
              content
            )
            v(space-between-text)
          } else {
            none
          }
        } else {
          entry
        }
      })
    )
  )

  pagebreak()
}
