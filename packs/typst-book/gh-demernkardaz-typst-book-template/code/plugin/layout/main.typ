#import "../../utils/lib.typ": parse-parameters, parse-value, regex-rules

#let _data = yaml("../../../settings/layout.yml")
#let _mode = sys.inputs.at("layout-mode", default: _data.at("mode"))

#let get(key, section: _mode) = {
  let keys = key.split(".")

  let value = _data.at(section, default: _data.default)

  for k in keys {
    if type(value) == dictionary and k in value {
      value = value.at(k)
      if type(value) != dictionary {
        break
      }
    } else {
      value = none
      break
    }
  }

  if value == none {
    value = _data.default
    for k in keys {
      if type(value) == dictionary and k in value {
        value = value.at(k)
        if type(value) != dictionary {
          break
        }
      } else {
        value = none
        break
      }
    }
  }

  if value != none and type(value) == str {
    return parse-value(value)
  }

  return value
}

#let init(body) = {
  let page-paper = get("page.paper")
  let page-size = get("page.size")
  let page-width = get("page.width")
  let page-height = get("page.height")

  if page-width == none {
    page-width = page-size.at(0)
  }
  if page-height == none {
    page-height = page-size.at(1)
  }

  let page-params = if page-paper != "custom" {
    (paper: lower(page-paper))
  } else {
    (
      width: page-width,
      height: page-height,
    )
  }

  set page(
    ..page-params,
    margin: (
      top: get("page.margin.top"),
      bottom: get("page.margin.bottom"),
      inside: get("page.margin.inside"),
      outside: get("page.margin.outside"),
    ),
  )

	set page(
		footer: context {
			let start-nodes = query(selector(<start_count>))

			if start-nodes.len() > 0 {
				let start-page = start-nodes.first().location().page()
				let current-page = here().page()

				if current-page >= start-page {
					let p = counter(page).get().first()
					let total = counter(page).final().first()

					align(center, text(8pt, [
						#numbering("1", p) | #numbering("1", total)
					]))
				} else {
					none
				}
			}
		}
	)

  body
}
