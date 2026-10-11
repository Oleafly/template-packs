/*
Touying template for academic presentation.

Note:
- Fonts can be changed by setting font-en, font-ja, and font-math in mytheme().
  Default is "BIZ UDPGothic" and "Noto Sans Mono".
- strong() is modified to underline with the secondary color, not bold.
*/

#import "@preview/touying:0.6.1": *

// font size
#let font-size-default = 20pt
#let font-size-heading = 1.5em
#let font-size-title = 1.8em
#let font-size-subtitle = 1.2em
#let font-size-author = 1.2em

// color
#let neutral = rgb("#ffffff")   // background
#let main = rgb("#333333")      // main text
#let primary = rgb("#000066")   // theme color
#let secondary = rgb("#cc6d2d") // emphasize
#let tertiary = rgb("#6495cf")  // others

// margin
#let margin-bottom = 1.25em
#let margin-side = 1em

#let slide(
	config: (:),
	repeat: auto,
	setting: body => body,
	composer: auto,
	..bodies,
) = touying-slide-wrapper(self => {
	let header(self) = {
		set align(top)
		rect(width: 100%, height: font-size-heading+.25em, fill: primary)[
			#grid(
				columns: (auto, 1fr),
				align: (left, right),
				[
					#text(size: font-size-heading, fill: white, weight: "bold")[#utils.call-or-display(self, self.store.header)]
				], [
					#text(size: font-size-heading, fill: white, weight: "bold")[#utils.call-or-display(self, self.store.header-right)]
				]
			)
		]
	}
	let self = utils.merge-dicts(
		self,
		config-page(
			header: header,
			footer: none,
			margin: (top: 2.25em, bottom: margin-bottom, x: margin-side)
		)
	)
	touying-slide(self: self, config: config, repeat: repeat, setting: setting, composer: composer, ..bodies)
	}
)

#let title-slide(
  config: (:),
  ..args,
) = touying-slide-wrapper(
  self => {
    let info = self.info

    let header(self) = {
      set align(top)
      rect(width: 100%, height: font-size-heading+.25em, fill: primary)[
        #text(fill: white, weight: "bold", size: font-size-heading, info.header)
      ]
    }

    let body = {
      set std.align(horizon)
			set text(fill: main)
      block(width: 100%, inset: 1em)[
				#align(center)[
					#v(1fr)
					#text(size: font-size-title, fill: primary, weight: "bold", info.title)

					#text(size: font-size-subtitle, info.subtitle)
					#v(1fr)
					#text(size: font-size-author, info.author)

          #text(size: font-size-author, info.institution)
          #v(.5fr)
				]
      ]
    }

    self = utils.merge-dicts(
      self,
      config-page(
        header: header
      ),
    )
    touying-slide(self: self, body)
  }
)

#let new-section-slide(level: 1, numbered: false, body) = {
	touying-slide-wrapper(self => {
		let slide-body = {
			set align(center+horizon)
			set text(size: font-size-title, fill: primary, weight: "bold")
			v(-2em)
			block(
				width: 80%,
				utils.display-current-heading(level: level, numbered: numbered)
			)
			body
		}
		self = utils.merge-dicts(
			self,
			config-page(fill: neutral)
		)
		touying-slide(self: self, slide-body)
	})
}

#let mytheme(
	aspect-ratio: "16-9",
	header: utils.display-current-heading(level: 2),
	header-right: self => context utils.slide-counter.display() + "/" + utils.last-slide-number,
	font-en: "BIZ UDPGothic",
	font-ja: "BIZ UDPGothic",
	font-math: "Noto Sans Math",
  ..args,
  body,
) = {
  set text(size: font-size-default, font: (font-en, font-ja))
  set par(
    justify: true,
    leading: .6em,
    spacing: 1em,
    linebreaks: auto,
  )

  // equation
  set math.equation(numbering: "(1)")
  show math.equation: it => {
    if it.block and not it.has("label") and it.numbering != none [
      #counter(math.equation).update(v => calc.max(0, v - 1))
      #math.equation(it.body, block: true, numbering: none)
    ] else {
      it
    }
  }
  show math.equation: set text(font: (font-math), size: 1em)
  // show equation number if referred
	// reference: https://forum.typst.app/t/how-to-conditionally-enable-equation-numbering-for-labeled-equations/977
  show ref: it => {
    let eq = math.equation
    let el = it.element
    if el != none and el.func() == eq {
      link(el.location(),numbering(
        el.numbering,
        ..counter(eq).at(el.location())
      ))
    } else {
      it
    }
  }

  // list
  let cycle_markers(markers) = {
    let marker_fn(markers, depth) = {
      let index = calc.rem(depth, markers.len())
      markers.at(index)
    }
    depth => marker_fn(markers, depth)
  }
  set list(
    marker: cycle_markers((text(size: .8em)[▶], [⦁], [◾]))
  )

	// misc
	show "、": "，"
	show "。": "．"
	show strong: it => text(fill: secondary, weight: "regular", underline(it.body))
  show link: set text(fill: blue)
  show link: underline

  // code block
  show raw.where(block: true): set block(
    fill: luma(240),
    inset: .5em,
    radius: 0.5em,
    width: 100%
  )

  show: touying-slides.with(
		config-page(
			paper: "presentation-" + aspect-ratio,
			margin: (top: 1.75em, bottom: 15pt, x: 15pt),
		),
    config-common(
      slide-fn: slide,
			new-section-slide-fn: new-section-slide,
    ),
		config-methods(
			init: (self: none, body) => {
				set text(fill: main, size: font-size-default)
				show heading: set text(fill: primary)

				body
			}
		),
		config-store(
			header: header,
			header-right: header-right,
		),
    ..args,
  )

  body
}
