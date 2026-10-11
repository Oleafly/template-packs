#import "drafting-rtl.typ": *

#let fullwidth = state("fullwidth", false)
#let dark-state = state("dark-state", false)


#let headerIcon(dx: 1.5em,dy: -0.85em, icon_color: rgb(220,20,60,65%).to-hex()) = context {
  let icon_color = if dark-state.get() {
    rgb(255, 107, 139, 65%).to-hex()
  } else {
    icon_color
  }
  let image_raw = read("heading.svg")
  image_raw = image_raw.replace("currentColor", icon_color)
  image_raw = bytes(image_raw)
  let icon_image = image(image_raw, width: 1.3em)
  box(
    place(
        dy: dy,
      dx: dx,
      icon_image,
    ),
  )
}

#let template(
  title: none,
  toc: false,
  full: false,
  dark: false,
  header: true,
  footer: true,
  header-content: none,
  footer-content: none,
  bib: none,
  doc,
) = {
  // Body margin vs. the wide margin that holds sidenotes.
  let body-margin = 0.7in
  let note-margin = if full { 0.7in } else { 3in }

  let left-margin = note-margin
  let right-margin = body-margin
  let margin-diff = left-margin - right-margin

  let wideblock(content) = block(width: 100% + margin-diff, content)

  let tufte-bg = if dark { rgb("#111111") } else { rgb("#ffffff") }
  let tufte-fg = if dark { rgb("#fffff8") } else { rgb("#111111") }
  let tufte-light = rgb("#aaaaaa")

  let body-fonts = ("NT Panorama Naskh", "Asal Arabic ITF", "Scheherazade New", "EB Garamond")
  let heading-font =("PanoramaNaskh","thmanyah serif display")

  fullwidth.update(full)
  dark-state.update(dark)

  // Functions
  let titleblock(title) = {
    wideblock([
      #set align(right)
      #if title != none {
        v(-1em)
        [#text(font: heading-font, 28pt, weight: "bold", [*#title*]) \ \ ]
        v(-1em)
        line(length: 100%, stroke: 0.4pt + tufte-light)
      }
      #if toc { [\ #outline(indent: 1em, title: none, depth: 2) ] }
    ])
  }

  let headerblock(title, header-content) = if (
    header and header-content != none
  ) {
    header-content
  } else if header {
    set text(size: 8pt)
    wideblock({
      set align(right)
      if counter(page).get().first() > 1 [
        #emph[#title]
      ]
    })
  } else { none }

  let footerblock(footer-content) = if footer and footer-content != none {
    footer-content
  } else if footer {
    set text(size: 8pt)
    wideblock({
      set align(left)
        emph(counter(page).display("1/1", both: true))
    })
  } else { none }

  set document(title: title)

    set text(font: body-fonts, fill: tufte-fg, dir: rtl, lang: "ar", spacing: +1.1pt, features:(liga: 0, calt: 1, ss02: 1) )
// Target 'ل' followed by 'ج/ح/خ' and any following Arabic character
    show regex("\b\p{Arabic}*[رزو]ي[بتثنيئى]\p{Arabic}*\b"): it => text(features: (calt: 0))[#it]
    show regex("\b\p{Arabic}*[اأإ][تثئ][بتثنيئى]\p{Arabic}*\b"): it => text(features: (calt: 0))[#it]
    show heading: set text(
    font: heading-font,
    features: (
        ccmp: 1,
        curs: 1,
        rlig: 1,
        swsh: 1,
        calt: 1,
    )
    )

    // show regex("[\d٠-٩+=*/%<>-]"): set text(font: "Scheherazade New")
    // 1. Convert isolated English digits to Arabic digits
// Catch any combination of English letters and numbers
  show regex("[a-zA-Z0-9]+"): it => {
    // Check if the matched text contains at least one English letter
    if it.text.find(regex("[a-zA-Z]")) != none {
      // It is a mixed English word (like "mp3" or "H2O").
      // Force it to use the Latin font so the missing numbers appear!
      text(font: "EB Garamond", it.text)
    } else {
      // It is purely numbers. Convert them to Arabic digits.
      let ascii-digits = "0123456789"

      // Note: I put standard Arabic digits here. If your specific font
      // requires you to use the blank spaces from your previous code,
      // simply paste your spaces back into this string!
      let arabic-digits = "٠١٢٣٤٥٦٧٨٩"

      it.text.clusters().map(c => {
        let idx = ascii-digits.clusters().position(x => x == c)
        if idx != none {
          arabic-digits.clusters().at(idx)
        } else {
          c
        }
      }).join()
    }
  }

    // show "(": it => text(lang: "ar", font: "IBM Plex Sans Arabic")[⧼]
    show "(": it => text(lang: "ar", font: "NT Panorama Naskh")[‹]
    show ")": it => text(lang: "ar", font: "NT Panorama Naskh")[›]
    show "«": it => text(lang: "ar", font: "NT Panorama Naskh")[»]
    show "»": it => text(lang: "ar", font: "NT Panorama Naskh")[«]

  show math.equation: set text(lang: "ar", font: "Scheherazade New")
  show ref: set text(blue)
  show link: set text(blue)


  set par(justify: true, spacing: 1.5em)

  set cite(style: "american-physics-society")
  show bibliography: set par(spacing: 1em)

  set enum(indent: 0em)
  set list(indent: 0em)
  show enum: set par(spacing: 1.25em)
  show list: set par(spacing: 1.25em)
    set enum(
    numbering: n => text(fill: rgb(220, 20, 60, 65%), weight: "bold")[#str(n).]
    )

  // Table styling
  show table: it => {
    set par(justify: false)
    set text(size: 9pt)
    block(stroke: (y: 0.7pt), width: 100%, it)
  }
  show table.cell.where(y: 0): strong
  set table(
    stroke: (x, y) => if y == 0 { (bottom: 0.7pt) } else { none },
    align: (right + top),
  )

  set math.equation(numbering: "(1)", supplement: none, number-align: bottom)

  show raw.where(block: false): box.with(
    fill: luma(95%),
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,
  )
  show raw.where(block: true): block.with(
    fill: luma(95%),
    inset: 5pt,
    radius: 4pt,
    width: 100%,
  )
  show math.equation: set text(lang: "ar", font: body-fonts)

  show ref: it => {
    if it.element != none and it.element.func() == math.equation {
      link(it.target)[(#it)]
    } else {
      it
    }
  }

  show ref.where(
    form: "normal",
  ): set ref(supplement: it => {
    if it.func() == figure { none }
  })

  show heading: set par(justify: false)
  show heading.where(level: 1): it => {
    set text(size: 22pt, weight: "bold")
      [#headerIcon(dx: .3em, dy: -1em,icon_color: rgb("#9e2a2bb3").to-hex()) #it.body]
    v(-0.6em, weak: false)
  }
  show heading.where(level: 2): it => {
    set text(size: 14pt, weight: "semibold")
      [#headerIcon(dx: .3em, icon_color: rgb("#ef233c99").to-hex()) #it.body]
    v(-0.4em)
  }
  show heading.where(level: 3): it => {
    set text(size: 12pt, weight: "bold")
      [#headerIcon(dx: .3em, icon_color: rgb("#ffb4a2").to-hex()) #it.body]
    v(-0.6em, weak: false)
  }

  set page(
    paper: "a4",
    fill: tufte-bg,
    margin: (
      left: left-margin,
      right: right-margin,
      top: 1in,
      bottom: 0.75in,
    ),
    header: context { headerblock(title, header-content) },
    // footer: context { footerblock(footer-content) },
    footer-descent: 55%,
  )

  titleblock(title)

  // FIX: Properly calculate note width so it doesn't push off the page edge
  set-page-properties(
    margin-left: left-margin,
    margin-right: right-margin * 1.2,
  )
  set-margin-note-defaults(
    stroke: none,
    side: left,
  )

  doc

  if bib != none { wideblock(bib) }
}

#let bulb = context {
  let image_raw = read("astrisk.svg")
  let badge_color = if dark-state.get() {
    rgb(255, 224, 130, 65%).to-hex()
  } else {
    rgb(255, 0, 110).to-hex()
  }
  image_raw = image_raw.replace("currentColor", badge_color)
  image_raw = bytes(image_raw)
  rotate(-22deg)[#image(image_raw, width: 2em)]
}

#let bulb-framed(
  body,
  icon-w: 1.8em,
  inset: 0.6em,
  stroke-w: 0.8pt,
  radius: 2pt,
) = context {
  let line-color = if dark-state.get() {
    rgb(255, 224, 130, 65%)
  } else {
    rgb(255, 0, 110, 50%)
  }

  layout(avail => {
    let w = avail.width

    // FIX: More padding on the right to clear the line/icons, explicit right alignment
    let inner-content = pad(right: 1em, bottom: 0.3em, {
      set align(right)
      set par(justify: true)
      body
    })

    let content-height = measure(block(width: w, inner-content)).height

    box(width: w)[
      #inner-content

      #place(top + right)[
        #line(
          stroke: stroke-w + line-color,
          start: (0pt, 2pt),
          end: (0pt, content-height - 2pt),
        )
      ]

      #place(top + right, dx: icon-w * 0.55, dy: -icon-w * 1)[#bulb]
      #place(bottom + right, dx: icon-w * 0.55, dy: icon-w * 1)[#bulb]
    ]
  })
}

#let meq = context {
  let image_raw = read("Asterisk.svg")
  let badge_color = if dark-state.get() {
    rgb(255, 107, 139, 65%).to-hex()
  } else {
    rgb(220, 20, 60, 65%).to-hex()
  }
  image_raw = image_raw.replace("currentColor", badge_color)
  image_raw = bytes(image_raw)
  let icon_image = image(image_raw, width: 1.6em)
  box(
    place(
      dy: -1.2em,
      dx: 0.7em,
      icon_image,
    ),
  )
}

#let notecounter = counter("notecounter")

// FIX 3: Change default dy to auto so collision detection works
// or leave it at -2em if you want to manually adjust them like the English Tufte template.
#let sidenote(dy: auto, numbered: true, def: false, in-caption: false, standalone: false, body) = context {
  let is-figure = (type(body) == content and (body.func() == figure or body.func() == figure.caption))
  let numbered = numbered and not is-figure and not def and not standalone
    let body = if type(body) == content and body.func() == figure {
        [
        #show figure.caption: it => context {
            let badge_color = if dark-state.get() { rgb(255, 107, 139, 65%) } else { rgb(220, 20, 60, 65%) }

            let is-arabic = repr(it.body).find(regex("\p{Arabic}")) != none
            let current-dir = if is-arabic { rtl } else { ltr }

            set text(dir: current-dir, size: 8pt)
            set par(justify: false, leading: 0.45em)

            grid(
            columns: (auto, 1fr),
            column-gutter: 0.3em,
            align: top + (if is-arabic { right } else { left }),

            // FIX: Added move(dy: ...) for absolute vertical control.
            // Change dy to a larger negative number (e.g., -0.4em) to move the icon higher.
            // Change dy to a positive number (e.g., 0.1em) to move it lower.
            move(dy: -0.2em, box(height: 1em, baseline: 5%)[
                #text(size: 1.5em, fill: badge_color)[\u{2055}]
            ]),

            [#it.body]
            )
        }
        #figure(body.body, caption: body.at("caption", default: none), kind: body.at("kind", default: auto), supplement: none, numbering: none)
        ]
    } else { body }
  if fullwidth.get() and not numbered {
    footnote(body, numbering: _ => [])
    counter(footnote).update(n => n-1)
  } else if fullwidth.get() {
    footnote(body)
  } else {
    if numbered {
      notecounter.step()
        [\u{2060}] + context box(move(
                dx: 0.1em,
                dy: -0.4em,
                text(fill: rgb(220, 20, 60), size: 5pt, notecounter.display())
            ))
    }

    // 1. Force RTL block and align(right) so it hugs the main text
    // 2. Adjust dx here to increase/decrease the gap (positive = closer to text)
    let note-body = pad(left: 0.5in, right: 2em, block(width: 100%, {
      set align(right)
      set text(dir: rtl, size: 8pt)
      set par(justify: true)

      if numbered {
        pad(right: -0.4em, {
            box(place(dx: .6em, dy: -0.5em, text(fill: rgb(220,20,60),size: 7pt, context super(notecounter.display()))))
          body
        })
      } else if is-figure or in-caption {
        body
      } else if def {
        bulb-framed(body)
      } else {
        meq + body
      }
    }))

    let note = box(width: 0pt, margin-note(note-body, dy: dy))

    if standalone {
      place(note)
    } else {
      note
    }
  }
}

#let sidecite(
  dy: auto,
  form: "normal",
  style: auto,
  supplement: none,
  key,
) = context {
  show cite: it => {
    show regex("\[\d\]"): set text(blue)
    it
  }
  let elems = query(bibliography)
  if elems.len() > 0 {
    cite(key, form: form, style: style, supplement: supplement)
    sidenote(
      cite(key, form: "full"),
      dy: dy,
      numbered: false,
    )
  }
}

#let figure_with_sidenote(path, caption_text) = {
  set figure.caption(position: top)
  show figure.caption.where(position: top): sidenote.with(
    dy: auto,
    numbered: false,
  )
  set figure.caption(position: top)
  figure(
    image(path),
    alt: none,
    caption: [#caption_text],
  )
  set figure.caption(position: bottom)
}

#let wideblock(content) = context {
  if fullwidth.get() {
    block(width: 100%, content)
  } else {
    block(width: 100% + 2.3in, content)
  }
}

#let hi(body) = {
  highlight(
    fill: aqua.desaturate(50%),
    radius: 1pt,
  )[#body]
}


#let badge(dx: 2em) = context {
  let badge_color = if dark-state.get() {
    rgb(255, 107, 139, 65%).to-hex()
  } else {
    rgb(220, 20, 60, 65%).to-hex()
  }
  let image_raw = read("hashnode.svg")
  image_raw = image_raw.replace("currentColor", badge_color)
  image_raw = bytes(image_raw)
  let icon_image = image(image_raw, width: 1.7em)
  box(
    place(
      dy: -1.0em,
      dx: dx,
      icon_image,
    ),
  )
}

#let list_badge(dx: -0.45em) = context {
  let badge_color = if dark-state.get() {
    rgb(255, 107, 139, 65%).to-hex()
  } else {
    rgb(220, 20, 60, 65%).to-hex()
  }
  let image_raw = read("hashnode.svg")
  image_raw = image_raw.replace("currentColor", badge_color)
  image_raw = bytes(image_raw)
  let icon_image = image(image_raw, width: 0.55em)
    move(dx: dx, dy: 0.2em, box(baseline: 30%, icon_image))
}

#let hash_badge(number) = {
  let image_raw = read("assets/hashnode.svg")
  image_raw = image_raw.replace("currentColor", rgb(45, 45, 45, 30%).to-hex())
  image_raw = bytes(image_raw)
  let icon_image = image(image_raw, width: 1.7em)
  box(
    place(
      dy: -1.0em,
      dx: 0.5em,
      icon_image,
    )
      + place(
        dy: -1.2em,
        dx: -0.1em,
        text(
          font: "Bookerly Display",
          size: 2.2em,
          weight: "bold",
          fill: rgb(220, 20, 60, 65%),
          str(number),
        ),
      ),
  )
}
