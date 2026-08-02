#let page-size = (width: 8.5in, height: 11in)
#let margins = (x: 1.25in, top: 1.12in, bottom: 1in)
#let text-size = 12pt
#let lines-per-page = 28
#let line-height = (page-size.height - margins.top - margins.bottom) / lines-per-page
#let line-gap = line-height - text-size
#let short-gap = 0.4em
#let indentation = 0.45in

#let is-exhibit = state("is-exhibit", false)

#let libertinus-serif = (
  family: "Libertinus Serif",
  has-small-caps-tracking: false,
  continuation-size: 12pt,
  lg-size: 15pt,
)
#let equity-ot-a = (
  family: "Equity OT A",
  has-small-caps-tracking: true,
  continuation-size: 10pt,
  lg-size: 14pt,
)
#let equity-ot-b = (
  ..equity-ot-a,
  family: "Equity OT B"
)

#let exhibit-font-settings = state("font-settings", libertinus-serif)

#let point-numbering = (_, ..nums) => {
  if nums.pos().len() > 0 {
    box(
      // Cursed: 0.3em is default SPACING_TO_NUMBERING
      width: indentation - 0.3em,
      baseline: 20%,
      text(
        number-type: "lining",
        nums.pos().map(str).join(".") + "."
      )
    )
  }
}

#let indent = body => pad(left: indentation, body)

#let proper-upper = body => text(
  features: (
    case: 1 // Uppercase forms
  ),
  smallcaps(upper(body))
)

#let nobr = body => text(hyphenate: false, body)
  
#let pleading(
  body,
  contact-info: none,
  county: none,
  court: none,
  caption: none,
  case-number: "",
  long-title: "",
  short-title: "",
  additional-documents: (),
  hearing: none,
  judge: none,
  department: none,
  action-filed: none,
  trial: none,
  bonus-info: none,
  font-settings: libertinus-serif
) = [
  #exhibit-font-settings.update(font-settings)

  #if court == none {
    court = [
      Superior Court of the State of California\
      County of #county
    ]
  }

  #[
    #show heading: none
    = Start of Document
  ]

  #set text(
    font: font-settings.family,
    size: 12pt,
    top-edge: text-size * 0.8,
    bottom-edge: text-size * -0.2,
    number-type: "old-style",
    fallback: false
  )

  #set par(
    leading: line-gap,
    spacing: line-gap
  )

  #set document(title: short-title)

  #set page(
    paper: "us-letter",
    
    margin: (
      x: margins.x,
      top: margins.top,
      bottom: margins.bottom,
    ),

    footer: context if is-exhibit.get() {
      rect(
        width: 100%,
        stroke: none,
        inset: (top: 0.35in),
      )[
        #set align(center)
        
        #set text(
          size: 10pt,
          fill: color.rgb(0, 0, 255)
        )

        #text(
          number-type: "lining",
          tracking: 1pt,
        )[— #counter(page).display("1 of 1", both: true) —]
      ]
    } else {
      rect(
        width: 100%,
        stroke: (top: 0.5pt),
        inset: (top: -0.03in),
        outset: (top: 0.2in)
      )[
        #set align(center)
        #set text(
          size: 10pt,
          tracking: if font-settings.has-small-caps-tracking {
            0pt
          } else {
            1pt
          },
        )
        #set par(spacing: 0.75em)

        #text(
          number-type: "lining",
          tracking: 1pt,
        )[— #counter(page).display("1 of 1", both: true) —]

        #proper-upper(short-title)
      ]
    },

    background: context {
      // Line numbers
      place(
        top + left,
        dx: margins.x - 0.5in,
        dy: margins.top,
        align(
          right,
          text(
            number-type: "lining",
            number-width: "tabular",
            range(1, lines-per-page + 1).map(str).join([\ ])
          )
        )
      )

      // Continuation slashes
      let current-page = here().page()
      
      let markers = query(<continuation>)
        .filter(marker => marker.location().page() == current-page)

      for marker in markers {
        let pos = marker.location().position()

        let current-line = int((pos.y - margins.top) / line-height) + 1
        let remaining-lines = lines-per-page - current-line

        if remaining-lines > 0 {
          pdf.artifact(
            text(
              size: font-settings.continuation-size,
              place(
                top + left,
                dx: margins.x,
                dy: margins.top + current-line * line-height, 
                stack(
                  dir: ttb, 
                  spacing: line-gap, 
                  ..array.range(remaining-lines).map(_ => [\/ \/ \/ ])
                )
              )
            )
          )
        }
      }
    }
  )

  #block(
    height: 7 * line-height,
    below: 0pt,
    par(
      leading: short-gap,
      spacing: short-gap,
      contact-info
    )
  )

  #context assert(
    here().position().y > 3.333333in,
    message: "line 8 is above 3 1/3 inches"
  )

  #{
    set text(
      size: font-settings.lg-size,
      weight: "regular",
      tracking: if font-settings.has-small-caps-tracking {
        0pt
      } else {
        0.75pt
      }
    )
    set align(center)
    box(proper-upper(court))
  }

  \

  #block(
    below: line-gap * 1,
    inset: (
      top: line-height * -0.5,
      bottom: line-height * 0.25
    ),
    grid(
      columns: (1fr, 1fr),

      grid.cell(
        stroke: (
          right: 0.5pt,
          bottom: 0.5pt
        ),
        inset: (
          top: line-height * 0.5,
          bottom: line-height * 0.75,
          right: 0.25in,
        ),
        caption
      ),

      grid.cell(
        inset: (
          top: line-height * 0.5,
          bottom: line-height * 0.75,
          left: 0.25in,
        )
      )[
        Case No. #text(number-type: "lining", case-number)
        \
        \
        #text(13pt)[
          *#long-title*#{
            if additional-documents.len() > 0 [*;*
              #additional-documents.join[; ]
            ]
          }
        ]
        #table(
          columns: (1.15in, auto),
          row-gutter: line-gap,
          stroke: none,
          inset: 0in,

          [#sym.zws], [],

          ..if hearing != none {(
            [Hearing Date:],
            [
              #hearing.display("[month repr:long] [day padding:none], [year]")
            ],
            [Hearing Time:],
            [
              #hearing.display("[hour repr:12 padding:none]:[minute]")
              #if hearing.hour() < 12 [a.m.] else [p.m.]
            ]
          )} else {()},

          ..if department != none {(
            [Department:],
            [#department]
          )} else {()},

          ..if judge != none {(
            [Judge:],
            [Hon. #judge]
          )} else {()},

          ..if action-filed != none {(
            [Action Filed:], 
            [
              #action-filed.display("[month repr:long] [day padding:none], [year]")
            ]
          )} else {()},

          ..if trial != none {(
            [Trial Date:],
            [
              #trial.display("[month repr:long] [day padding:none], [year]")
            ]
          )} else {()},
        )
        #bonus-info
      ]
    )
  )

  #set par(
    first-line-indent: indentation,
    justify: true
  )
  #set text(hyphenate: true)
  
  #show heading.where(level: 1): it => {
    set text(
      size: font-settings.lg-size,
      weight: "bold",
      hyphenate: false,
      tracking: if font-settings.has-small-caps-tracking {
        0pt
      } else {
        0.75pt
      }
    )
    set block(below: line-height + line-gap)
    set align(center)
    
    pagebreak(weak: true)
    proper-upper(it)
  }
  
  #show heading.where(level: 2): it => {
    set text(
      size: 14pt,
      weight: "bold",
    )

    set block(
      above: line-height + line-gap,
      below: line-gap
    )

    [#it]
  }

  #let has-heading-above = this => {
    let prev = query(selector(heading)
      .before(here()))
      .filter(prev => prev.level != 1 and prev.level < this.level)
      .last()

    if prev.location().page() != here().page() {
      return false
    }

    let diff = here().position().y - prev.location().position().y
    if diff > line-height + line-height + line-gap {
      return false
    }

    return true
  }
  
  #show heading.where(level: 3): it => context {
    set text(
      size: text-size,
      weight: "bold"
    )

    set block(
      above: if has-heading-above(it) {
        line-gap
      } else {
        line-height + line-gap
      },
      below: line-gap
    )

    it
  }
  
  #show heading.where(level: 4): it => {
    set text(
      size: text-size,
      weight: "bold"
    )

    set block(
      above: line-gap,
      below: line-gap
    )

    [\ #it]
  }

  #set heading(numbering: point-numbering)

  #set enum(
    body-indent: 0in,
    indent: indentation,
    full: true,
    numbering: (..nums) => place(
      top + left,
      dx: -indentation,
      text(
        number-type: "lining",
        numbering("1.", ..nums)
      )
    )
  )

  #show enum: it => {
    show enum: set enum(indent: 0in)
    indent(it)
  }

  #set list(
    body-indent: 0in,
    indent: indentation,
    marker: it => place(
      top + left,
      dx: -indentation,
      text(size: 14pt, sym.bullet)
    )
  )

  #show list: it => {
    show list: set list(indent: 0in)
    indent(it)
  }

  #v(line-height)

  #body

  // Reset to default
  #exhibit-font-settings.update(libertinus-serif)
]

#let continuation = box(width: 0pt, height: 0pt, baseline: 0pt)[
  #metadata(none)<continuation>
]

#let party = body => text(13pt)[*#body*]
#let sbn = no => text(size: 10pt)[State Bar \##no]
#let role = body => pad(left: 1.25in)[#body]
#let versus = pad(left: 0.625in, move(dy: -0.05in)[v.])

#let signature = (date: none, signatory) => {
  set par(first-line-indent: 0in)

  [\ ]

  block(
    breakable: false,
    grid(
      columns: (1fr, 1fr),

      [
        Dated:
        #if date != none [
          #date.display("[month repr:long] [day padding:none], [year]").
        ] else {
          box(baseline: 0.25em, line(length: 2in, stroke: 0.5pt))
        }
      ],

      [
        #sym.zws#box(baseline: 0.25em, line(length: 100%, stroke: 0.5pt))
        #par(
          leading: short-gap,
          spacing: short-gap,
          signatory
        )
      ]
    )
  )
}

#let cite-exhibit = {
  let _page = page

  (letter, page: 1, long: false) => context {
    let exp = query(<exhibit-page>)
      .find(exp => exp.value.letter == letter and exp.value.page-offset == page)

    assert(exp != none, message: "missing exhibit " + letter + " page " + str(page))

    let absolute-page = counter(_page).at(exp.location()).first()

    link(
      exp.location(),
      if long {
        [Exhibit~#exp.value.letter, page~#absolute-page]
      } else {
        [Ex.~#exp.value.letter, p.~#absolute-page]
      }
    )
  }
}

#let index-of-exhibits = context [
  = Index of Exhibits

  #table(
    columns: (1in, 0.75in, 1fr),
    row-gutter: line-height + line-gap,
    column-gutter: 0.25in,
    stroke: none,
    inset: 0in,

    ..for (i, exp) in query(<exhibit-page>).enumerate() {
      if exp.value.page-offset != 1 {
        continue
      }

      let absolute-page = counter(page).at(exp.location()).first()

      (
        link(exp.location())[*Exhibit #exp.value.letter*],
        link(exp.location())[Page #absolute-page],
        [#exp.value.description],
      )
    }
  )
]

#let exhibit = (letter: "X", description: "", ..images) => context {
  page(
    background: none,
    text(
      size: 40pt,
      weight: "bold"
    )[
      #v(2in)
      #set text(
        tracking: if exhibit-font-settings.get().has-small-caps-tracking {
          0pt
        } else {
          1.25pt
        }
      )
      #align(center, smallcaps[
        Exhibit #letter
      ])
    ]
  )

  is-exhibit.update(true)
  for (i, the-image) in images.pos().enumerate() {
    page(background: the-image)[
      #metadata((
        letter: letter,
        page-offset: i + 1,
        description: description
      ))<exhibit-page>

      #if i == 0 [
        #show heading: none
        = Exhibit #letter. #description
      ]
    ]
  }
  is-exhibit.update(false)
}