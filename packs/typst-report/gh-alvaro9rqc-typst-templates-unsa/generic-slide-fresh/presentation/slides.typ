// --- HIGH-LEVEL SLIDE PRESETS ---
#import "config.typ" as config
#import "style.typ" as style
#import "components.typ" as comp
#import "icons.typ" as icons

/// Base slide page wrapper defining size, margins, and background.
///
/// - body (content): Slide contents.
/// -> content
#let slide-page(body) = {
  page(
    width: style.theme.width,
    height: style.theme.height,
    margin: 0pt,
    fill: style.theme.bg,
    body
  )
}

/// 1. COVER SLIDE
///
/// - title-top (string, content): Small intro text above the title. Default is `"Presentation"`.
/// - title (string, content): The main presentation title. Default is `"BUSINESS PROPOSAL"`.
/// - subtitle (string, content): The subtitle or targeted entity. Default is `"FOR ENSIGNA STORE"`.
/// - members (array): Optional list of team members. Default is `none`.
/// - organization (string): Optional organization name. Default is `none`.
/// - date (string): Optional presentation date. Default is `none`.
/// - image (content): Optional image to show in the right arch. Default is `none`.
/// - image-label (string): Label to show in placeholder if image is none. Default is `"Main Image"`.
/// - show-decorations (bool): Toggle background graphic elements. Default is `true`.
/// -> content
#let slide-cover(
  title-top: "Presentation",
  title: "BUSINESS PROPOSAL",
  subtitle: "FOR ENSIGNA STORE",
  members: none,
  organization: none,
  date: none,
  image: none,
  image-label: "Main Image",
  show-decorations: true,
) = {
  slide-page[
    #if show-decorations {
      comp.bottom-left-decoration()
      comp.decorative-circle(1324.57pt, 652.56pt, 76.43pt, fill-color: style.theme.secondary)
      comp.dot-grid(693.52pt, 36.24pt, 212.25pt, 212.25pt, cols: 9, rows: 9, dot-radius: 2.2pt, dot-color: rgb("#333333"))
    }
    
    #comp.arch-image-container(
      847.67pt,
      -60pt,
      511.33pt,
      790pt,
      stroke-color: style.theme.primary,
      image: image,
      label: image-label
    )
    
    #place(
      top + left,
      dx: 81pt,
      dy: 220pt,
      [
        #stack(
          spacing: 0pt,
          text(size: 29pt, weight: "regular", fill: style.theme.text-muted)[#title-top],
          v(36pt),
          text(size: 108pt, weight: "bold", fill: style.theme.text-dark)[
            #set par(leading: 0.18em)
            #title
          ],
          v(44pt),
          text(size: 41pt, weight: "bold", fill: style.theme.primary)[#subtitle],
          
          // Metadata below subtitle (optional, same size scale as top title text)
          if (members != none and members.len() > 0) or organization != none or date != none {
            v(40pt)
            box(width: 720pt)[
              #stack(
                spacing: 12pt,
                if members != none and members.len() > 0 {
                  text(size: 24pt, weight: "regular", fill: style.theme.text-muted)[
                    #members.join(", ")
                  ]
                },
                if organization != none or date != none {
                  text(size: 20pt, weight: "regular", fill: style.theme.text-muted)[
                    #if organization != none { organization }
                    #if organization != none and date != none [ | ]
                    #if date != none { date }
                  ]
                }
              )
            ]
          }
        )
      ]
    )
  ]
}

/// 2. SECTION / INTRODUCTION SLIDE
///
/// - title (string, content): Left main heading. Default is `"INTRODUCTION"`.
/// - body (content): Main paragraph below title. Default is `[]`.
/// - card-title (string, content): Title inside the right-hand highlight card.
/// - card-body (content): Description inside the highlight card.
/// - show-decorations (bool): Toggle background elements. Default is `true`.
/// -> content
#let slide-section(
  title: "INTRODUCTION",
  body: [],
  card-title: "OUR GOAL IS CLEAR",
  card-body: [],
  show-decorations: true,
) = {
  slide-page[
    #if show-decorations {
      comp.bottom-left-decoration()
    }
    
    #place(
      top + left,
      dx: 913.20pt,
      dy: -40pt,
      rect(
        width: 567.30pt,
        height: 1000pt,
        fill: style.theme.primary,
        stroke: none
      )
    )
    
    #if show-decorations {
      comp.dot-grid(1232.61pt, 33.58pt, 222.39pt, 121.71pt, cols: 10, rows: 5, dot-radius: 2.2pt, dot-color: style.theme.secondary)
    }
    
    #comp.placed-black-card(
      801pt,
      279.82pt,
      504.79pt,
      265.35pt,
      radius: 28pt,
      fill: style.theme.secondary,
      text-color: white,
      [
        #stack(
          spacing: 16pt,
          text(size: 30.6pt, weight: "bold")[
            #set par(leading: 0.3em)
            #card-title
          ],
          text(size: 15.5pt, weight: "bold", style: "italic")[
            #set par(leading: 0.5em)
            #card-body
          ]
        )
      ]
    )
    
    #place(
      top + left,
      dx: 81pt,
      dy: 240pt,
      [
        #stack(
          spacing: 36pt,
          text(size: 72.9pt, weight: "bold", fill: style.theme.text-dark)[#title],
          box(width: 540pt)[
            #set par(leading: 0.8em)
            #text(size: 20.8pt, weight: "regular", fill: style.theme.text-muted)[#body]
          ]
        )
      ]
    )
  ]
}

// 3. IMAGE STICKY TEXT SLIDE
///
/// - title (string, content): Sticky note heading. Default is `"THE PROBLEM TO SOLVE"`.
/// - body (content): Right side descriptive body content. Default is `[]`.
/// - image (content): Left half image. Default is `none`.
/// - image-label (string): Left image label if image is none. Default is `"Left Image"`.
/// - show-decorations (bool): Toggle background decoration elements. Default is `true`.
/// -> content
#let slide-split-sticky(
  title: "THE PROBLEM TO SOLVE",
  body: [],
  image: none,
  image-label: "Left Image",
  show-decorations: true,
) = {
  slide-page[
    #if show-decorations {
      comp.ring-decoration(989.34pt, -71.47pt, 222.14pt)
      comp.dot-grid(1189.99pt, 640.99pt, 250.01pt, 169.01pt, cols: 9, rows: 6, dot-radius: 2.2pt, dot-color: rgb("#333333"))
    }
    
    #place(
      top + left,
      dx: 0pt,
      dy: 0pt,
      block(
        width: 720pt,
        height: 810pt,
        stroke: none,
        if image != none { image } else { comp.image-placeholder(image-label) }
      )
    )
    
    #place(
      top + left,
      dx: 511.31pt,
      dy: 228.67pt,
      comp.sticky-note(
        width: 418.01pt,
        height: 340.80pt,
        fill: style.theme.primary,
        text-color: style.theme.text-dark,
        radius: 0pt,
        inset: 32pt,
        [
          #text(size: 40.5pt, weight: "bold")[
            #set par(leading: 0.4em)
            #title
          ]
        ]
      )
    )
    
    #place(
      top + left,
      dx: 980pt,
      dy: 245pt,
      box(width: 380pt)[
        #set par(leading: 0.8em)
        #text(size: 20.8pt, weight: "regular", fill: style.theme.text-muted)[#body]
      ]
    )
  ]
}

// 4. GRID LIST SLIDE
///
/// - title (string, content): Title inside left sidebar. Default is `"POSSIBLE SOLUTION"`.
/// - body (content): Descriptive text below sidebar title. Default is `[]`.
/// - items (array): Grid items list. Each item is an array `(num, title, body)`.
/// - columns (int, array): Column counts or widths. Default is `2`.
/// - column-gutter (length): Horizontal spacing. Default is `48pt`.
/// - row-gutter (length): Vertical spacing. Default is `50pt`.
/// -> content
#let slide-grid-list(
  title: "POSSIBLE SOLUTION",
  body: [],
  items: (),
  columns: 2,
  column-gutter: 48pt,
  row-gutter: 50pt,
) = {
  slide-page[
    #place(
      top + left,
      dx: 0pt,
      dy: 0pt,
      rect(
        width: 557.50pt,
        height: 810pt,
        fill: style.theme.primary,
        stroke: none
      )
    )
    
    #place(
      top + left,
      dx: 81pt,
      dy: 240pt,
      [
        #stack(
          spacing: 36pt,
          text(size: 80pt, weight: "bold", fill: style.theme.text-dark)[
            #set par(leading: 0.25em)
            #title
          ],
          box(width: 390pt)[
            #set par(leading: 0.8em)
            #text(size: 20.8pt, weight: "regular", fill: style.theme.text-dark)[#body]
          ]
        )
      ]
    )
    
    #place(
      top + left,
      dx: 654.26pt,
      dy: 120pt,
      block(
        width: 704.74pt,
        comp.circle-grid-list(
          items,
          columns: columns,
          column-gutter: column-gutter,
          row-gutter: row-gutter,
          circle-fill: style.theme.primary,
          circle-text-color: white,
          title-color: style.theme.text-dark,
          body-color: style.theme.text-muted
        )
      )
    )
  ]
}

// 5. PILLS LIST SLIDE
///
/// - title (string, content): Header inside the yellow card. Default is `"OUR TARGET AUDIENCE"`.
/// - body (content): Description inside the yellow card. Default is `[]`.
/// - pills (array): List of text items for the checkmark pills.
/// - image (content): Left-hand side image. Default is `none`.
/// - image-label (string): Image label if image is none. Default is `"Target Audience"`.
/// - show-decorations (bool): Toggle background dot grid decorations. Default is `true`.
/// -> content
#let slide-pills-list(
  title: "OUR TARGET AUDIENCE",
  body: [],
  pills: (),
  image: none,
  image-label: "Target Audience",
  show-decorations: true,
) = {
  slide-page[
    #if show-decorations {
      comp.dot-grid(1143.49pt, -124.22pt, 226.93pt, 226.93pt, cols: 9, rows: 9, dot-radius: 2.2pt, dot-color: rgb("#333333"))
      comp.dot-grid(81.00pt, 699.00pt, 264.75pt, 111.00pt, cols: 11, rows: 5, dot-radius: 2.2pt, dot-color: rgb("#333333"))
    }
    
    #place(
      top + left,
      dx: 81pt,
      dy: 180.71pt,
      block(
        width: 639pt,
        height: 455.85pt,
        stroke: none,
        if image != none { image } else { comp.image-placeholder(image-label) }
      )
    )
    
    #place(
      top + left,
      dx: 720pt,
      dy: 180.71pt,
      block(
        width: 639.26pt,
        height: 455.85pt,
        fill: style.theme.primary,
        inset: (top: 48pt, left: 44pt, right: 44pt),
        [
          #stack(
            spacing: 20pt,
            text(size: 40.5pt, weight: "bold", fill: style.theme.text-dark)[#title],
            box(width: 550pt)[
              #set par(leading: 0.6em)
              #text(size: 20.8pt, weight: "regular", fill: style.theme.text-dark)[#body]
            ],
            v(10pt),
            comp.pill-list(
              pills,
              width: 550.27pt,
              height: 44.54pt,
              radius: 6pt,
              fill: style.theme.secondary,
              text-color: white,
              icon: "✓",
              icon-fill: white,
              icon-text-color: style.theme.secondary
            )
          )
        ]
      )
    )
  ]
}

// 6. ACTION PLAN COLUMNS SLIDE
///
/// - title (string, content): Sidebar heading. Default is `"ACTION PLAN"`.
/// - body (content): Sidebar body text. Default is `[]`.
/// - items (array): Columns configuration `(num, title, description, image)`.
/// - show-decorations (bool): Toggle top-right dot grid. Default is `true`.
/// -> content
#let slide-action-plan(
  title: "ACTION PLAN",
  body: [],
  items: (),
  show-decorations: true,
) = {
  slide-page[
    #if show-decorations {
      comp.dot-grid(888.51pt, -104.28pt, 444.29pt, 222.14pt, cols: 15, rows: 7, dot-radius: 2.2pt, dot-color: rgb("#333333"))
    }
    
    #place(
      top + left,
      dx: 0pt,
      dy: 0pt,
      rect(
        width: 344.24pt,
        height: 810pt,
        fill: style.theme.primary,
        stroke: none
      )
    )
    
    #place(
      top + left,
      dx: 60pt,
      dy: 260pt,
      [
        #stack(
          spacing: 32pt,
          text(size: 40.5pt, weight: "bold", fill: style.theme.text-dark)[
            #set par(leading: 0.3em)
            #title
          ],
          box(width: 220pt)[
            #set par(leading: 0.65em)
            #text(size: 18pt, weight: "regular", fill: style.theme.text-dark)[#body]
          ]
        )
      ]
    )
    
    #place(
      top + left,
      dx: 418.38pt,
      dy: 130pt,
      block(
        width: 940.58pt,
        comp.image-column-list(
          items,
          columns: items.len(),
          column-gutter: 47pt,
          circle-fill: style.theme.primary,
          circle-text-color: white,
          title-color: style.theme.text-dark,
          body-color: style.theme.text-muted,
          img-width: 282.16pt,
          img-height: 326.25pt,
          img-radius: 16pt
        )
      )
    )
  ]
}

// 7. TIMELINE H SLIDE
///
/// - title (string, content): Top-left slide heading. Default is `"GROWTH STRATEGY"`.
/// - card-title (string, content): Header inside the top-right black card. Default is `"IT IS INTEGRAL"`.
/// - card-body (content): Description inside the black card. Default is `[]`.
/// - items (array): Steps configuration `(num, title, body)` for the timeline.
/// -> content
#let slide-timeline(
  title: "GROWTH STRATEGY",
  card-title: "IT IS INTEGRAL",
  card-body: [],
  items: (),
) = {
  slide-page[
    #place(
      top + left,
      dx: 81pt,
      dy: 160pt,
      [
        #text(size: 72.9pt, weight: "bold", fill: style.theme.text-dark)[
          #set par(leading: 0.25em)
          #title
        ]
      ]
    )
    
    #comp.placed-black-card(
      841.36pt,
      146.02pt,
      466.31pt,
      236.39pt,
      radius: 20pt,
      fill: style.theme.secondary,
      text-color: white,
      [
        #stack(
          spacing: 14pt,
          text(size: 27.3pt, weight: "bold")[#card-title],
          text(size: 13.8pt, style: "italic")[
            #set par(leading: 0.5em)
            #card-body
          ]
        )
      ]
    )
    
    #place(
      top + left,
      dx: 81.00pt,
      dy: 456.58pt,
      block(
        width: 1278pt,
        comp.horizontal-timeline(
          items,
          line-color: style.theme.secondary,
          line-stroke: 4.5pt,
          circle-radius: 42.79pt,
          circle-fill: style.theme.primary,
          circle-text-color: white,
          title-size: 20pt,
          body-size: 14pt,
          title-color: style.theme.text-dark,
          body-color: style.theme.text-muted,
          column-gutter: 20pt,
          align-text: left
        )
      )
    )
  ]
}

// 8. STACKED CARDS SLIDE
///
/// - title (string, content): Left side main heading. Default is `"THE PROPOSAL"`.
/// - subtitle (string, content): Sub-heading text. Default is `"With your help we can"`.
/// - body (content): Left side descriptive paragraph. Default is `[]`.
/// - cards (array): Titles for the 3 black cards on the right yellow panel.
/// - show-decorations (bool): Toggle background details. Default is `true`.
/// -> content
#let slide-stacked-cards(
  title: "THE PROPOSAL",
  subtitle: "With your help we can",
  body: [],
  cards: (),
  show-decorations: true,
) = {
  slide-page[
    #if show-decorations {
      comp.dot-grid(44.15pt, -90.07pt, 444.29pt, 222.14pt, cols: 15, rows: 7, dot-radius: 2.2pt, dot-color: rgb("#333333"))
      comp.decorative-circle(601.14pt, 861.81pt, 235.26pt, fill-color: style.theme.secondary)
    }
    
    #place(
      top + left,
      dx: 1003.40pt,
      dy: -40pt,
      rect(
        width: 477.10pt,
        height: 1000pt,
        fill: style.theme.primary,
        stroke: none
      )
    )
    
    #place(
      top + left,
      dx: 81pt,
      dy: 240pt,
      [
        #stack(
          spacing: 36pt,
          text(size: 72.9pt, weight: "bold", fill: style.theme.text-dark)[#title],
          box(width: 520pt)[
            #set par(leading: 0.8em)
            #text(size: 20.8pt, weight: "regular", fill: style.theme.text-muted)[#body]
          ],
          v(12pt),
          text(size: 29pt, weight: "bold", fill: style.theme.text-dark)[#subtitle]
        )
      ]
    )
    
    #let card-y-coords = (84.75pt, 305.44pt, 527.12pt)
    #for i in range(cards.len()) {
      let y = card-y-coords.at(i, default: 84.75pt + i * 220pt)
      comp.placed-black-card(
        889pt,
        y,
        422.69pt,
        197.46pt,
        radius: 20pt,
        fill: style.theme.secondary,
        text-color: white,
        [
          #text(size: 23.9pt, weight: "bold")[
            #set par(leading: 0.4em)
            #cards.at(i)
          ]
        ]
      )
    }
  ]
}

// 9. TIMELINE PHASES SLIDE
///
/// - title (string, content): Title inside the top yellow banner. Default is `"WHAT WE HOPE TO ACHIEVE"`.
/// - items (array): Steps configuration `(num, title, body)` for the phases.
/// -> content
#let slide-timeline-phases(
  title: "WHAT WE HOPE TO ACHIEVE",
  items: (),
) = {
  slide-page[
    #place(
      top + left,
      dx: 0pt,
      dy: 0pt,
      rect(
        width: 1440pt,
        height: 296.98pt,
        fill: style.theme.primary,
        stroke: none
      )
    )
    
    #place(
      top + left,
      dx: 0pt,
      dy: 110pt,
      block(
        width: 1440pt,
        align(center)[
          #text(size: 72.9pt, weight: "bold", fill: style.theme.text-dark)[#title]
        ]
      )
    )
    
    #place(
      top + left,
      dx: 81pt,
      dy: 366.23pt,
      block(
        width: 1278pt,
        comp.horizontal-timeline(
          items,
          line-color: style.theme.secondary,
          line-stroke: 3pt,
          circle-radius: 74.21pt,
          circle-fill: style.theme.primary,
          circle-text-color: white,
          title-size: 26pt,
          body-size: 15pt,
          title-color: style.theme.text-dark,
          body-color: style.theme.text-muted,
          column-gutter: 20pt,
          dot-radius: 8pt,
          dot-fill: style.theme.secondary,
          align-text: center
        )
      )
    )
  ]
}

// 10. CONTACT SLIDE
///
/// - title (string, content): Closing/contact message. Default is `"WE WOULD LOVE TO HAVE YOUR BRAND JOIN US ON THIS PATH."`.
/// - image (content): Right side image. Default is `none`.
/// - image-label (string): Right image label if image is none. Default is `"Right Image"`.
/// - phone (string): Phone contact detail. Default is `""`.
/// - email (string): Email contact detail. Default is `""`.
/// - web (string): Website URL contact detail. Default is `""`.
/// - show-decorations (bool): Toggle top dot grid. Default is `true`.
/// -> content
#let slide-contact(
  title: "WE WOULD LOVE TO HAVE YOUR BRAND JOIN US ON THIS PATH.",
  image: none,
  image-label: "Right Image",
  phone: "",
  email: "",
  web: "",
  show-decorations: true,
) = {
  slide-page[
    #if show-decorations {
      comp.dot-grid(591.49pt, 25.29pt, 212.25pt, 212.25pt, cols: 9, rows: 9, dot-radius: 2.2pt, dot-color: rgb("#333333"))
    }
    
    #place(
      top + left,
      dx: 0pt,
      dy: 729pt,
      rect(
        width: 1440pt,
        height: 81pt,
        fill: style.theme.primary,
        stroke: none
      )
    )
    
    #place(
      top + left,
      dx: 720pt,
      dy: 0pt,
      block(
        width: 720pt,
        height: 729pt,
        stroke: none,
        if image != none { image } else { comp.image-placeholder(image-label) }
      )
    )
    
    #place(
      top + left,
      dx: 81pt,
      dy: 190pt,
      [
        #stack(
          spacing: 50pt,
          text(size: 45.8pt, weight: "bold", fill: style.theme.text-dark)[
            #set par(leading: 0.3em)
            #title
          ],
          stack(
            spacing: 16pt,
            if phone != "" {
              comp.contact-row(icons.icon-phone(style.theme.text-dark), phone)
            },
            if email != "" {
              comp.contact-row(icons.icon-email(style.theme.text-dark), email)
            },
            if web != "" {
              comp.contact-row(icons.icon-globe(style.theme.text-dark), web)
            }
          )
        )
      ]
    )
  ]
}
