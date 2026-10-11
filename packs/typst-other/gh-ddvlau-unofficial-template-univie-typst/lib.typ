// Template - University of Vienna | Universität Wien - Typst version
// Author: Xiaowei Liu
// Built based on #link("https://www.overleaf.com/latex/templates/template-university-of-vienna/brhjgbvnzfmn")[UniVie's official Overleaf template]. This Overleaf repo is under CC BY 4.0.

#let custom-blue = rgb(0, 99, 166)
#let buffer-space = 25pt  // Define the buffer space as a variable

// Template function to apply all settings
#let template-univie(
  body,
  author-name: "Jamie Doe",
  author-email: "jamie.doe@univie.ac.at",
) = {
  // Page settings
  set page(
    paper: "a4",
    margin: (top: 2.5cm + buffer-space, bottom: 2.5cm, left: 2cm, right: 2cm),
    header: context if here().page() != 1 [
      #block(height: 30pt)[
        #align(bottom)[
          #grid(
            columns: (auto, 1fr, auto),
            align: (bottom, center + horizon, bottom),
            [
              #image("logo.pdf", width: 3cm)
            ],
            [],
            [
              #text(size: 11pt)[University of Vienna]
            ],
          )
          #line(length: 100%, stroke: 0.5pt)
        ]
      ]
      #v(buffer-space) // buffer in margin to avoid overlap with text
    ],
    header-ascent: 0%,
    footer: context if here().page() == 1 {
      align(center + horizon)[
        #counter(page).display()
      ]
    } else [
      #align(center + horizon)[
      #line(length: 100%, stroke: 0.5pt)
        #grid(
          columns: (1fr, 1fr, 1fr),
          align: (left, center, right),
          [©#author-name],
          [],
          [#counter(page).display()/#counter(page).final().first()],
        )
      ]
    ],
  )

  // Font: Source Sans Pro 11pt regular
  set text(
    font: "Source Sans Pro",
    size: 11pt,
    lang: "en",
    weight: 400,
  )

  // Paragraph settings matching LaTeX 11pt article:
  //   \normalsize = 11pt/13.6pt baselineskip → leading = 2.6pt
  //   \parindent = 17pt
  //   \parskip = 0pt (but natural spacing due to baselineskip)
  set par(
    leading: 0.6em,
    first-line-indent: 17pt,
    spacing: 0.5em,
    justify: true,
  )

  // Heading numbering
  set heading(numbering: "1.1")

  // Heading formatting matching article.cls:
  //   \section:    \Large\bfseries = 14pt, before 3.5ex, after 2.3ex
  //   \subsection: \large\bfseries = 12pt, before 3.25ex, after 1.5ex
  //   \@seccntformat: \quad = 1em gap
  show heading: it => {
    let size = if it.level == 1 { 14pt } else if it.level == 2 { 12pt } else { 11pt }
    // Approximate ex for the heading font size
    let ex = if it.level == 1 { 7pt } else if it.level == 2 { 6pt } else { 5.5pt }
    let above = if it.level == 1 { 3.5 * ex } else { 3.25 * ex }  // Spacing before headings
    let below = if it.level == 1 { 2.3 * ex } else { 1.5 * ex }  // Spacing after headings
    set par(first-line-indent: 0pt)
    block(above: above, below: below, text(size: size, weight: 900, {
      if it.numbering != none {
        counter(heading).display(it.numbering)
        h(1em)
      }
      it.body
    }))
  }

  // Link color
  show link: set text(fill: custom-blue)

  // TOC: \tableofcontents uses \section*{\contentsname} = \Large\bfseries = 14pt bold
  // The outline title is rendered as a heading internally, so we style it via set rules.
  show outline: set heading(numbering: none)
  show outline: set par(first-line-indent: 0pt, spacing: 0pt)

  // TOC entry formatting.
  // \l@section: \bfseries, no dot fill, \addvspace{1.0em}, number indent 1.5em
  //   hyperref: text is blue link, page number is black (not a link)
  // \l@subsection: \@dottedtocline{2}{1.5em}{2.3em} — regular weight, dot leaders
  show outline.entry: it => {
    let el = it.element
    let loc = el.location()
    let num = if el.numbering != none {
      numbering(el.numbering, ..counter(heading).at(loc))
    }
    let page-num = counter(page).at(loc).first()

    let num-str = if num != none { str(num) } else { "" }

    if it.level == 1 {
      // \l@section: \addvspace{1.0em} above, \bfseries, no dot fill
      block(above: 1.5em, below: 0em, {
        set text(weight: 900)
        grid(
          columns: (1.5em, 1fr, auto),
          link(loc, text(fill: custom-blue, num-str)),
          link(loc, text(fill: custom-blue, el.body)),
          text(fill: black, str(page-num)),
        )
      })
    } else if it.level == 2 {
      // \l@subsection: each line at normal \baselineskip (13.6pt)
      // \@dottedtocline has \vskip \z@ = no extra space, just baselineskip
      block(above: 0.5em, below: 0em, {
        grid(
          columns: (1.5em, 2.3em, 1fr, auto),
          [],
          link(loc, text(fill: custom-blue, num-str)),
          {
            link(loc, text(fill: custom-blue, el.body))
            box(width: 1fr, repeat[.#h(4.5pt)])
          },
          text(fill: black, [#h(4pt)#str(page-num)]),
        )
      })
    }
  }

  body
}

// Title page logo
#let title-logo = align(left)[
  #v(1em-buffer-space)
  #image("logo.pdf", width: 40%)
  // LaTeX: \textfloatsep (20pt) + \null line (13.6pt) + \vskip 2em (22pt) ≈ 55.6pt
  #v(55.6pt)
]

// Title block matching LaTeX \@maketitle:
//   {\LARGE \@title \par}  → 17pt/22pt baselineskip = leading 5pt, REGULAR weight
//   \vskip 1.5em
//   {\large \@author}      → 12pt/14pt
//   \vskip 1em
//   {\large \@date}        → 12pt/14pt
//   \vskip 1.5em
#let title-block(
  title,
  author: "Jamie Doe",
  email: "jamie.doe@univie.ac.at",
) = {
  set par(first-line-indent: 0pt)
  align(center)[
    #text(size: 17.28pt, weight: 400)[ // default \LARGE is 17.28pt
      #set par(
        // leading: 9pt, 
        // leading: 0.5em,
        justify: false
      )
      #title
    ]

    #v(1.2em)

    #text(size: 12pt)[
      #author - #email
    ]

    #v(1em)

    #text(size: 12pt)[
      #datetime.today().display("[month repr:long] [day], [year]"), Vienna
    ]

    #v(1.8em)
  ]
}

// Custom bibliography entry formatting to include full author names
show bibliog.entry: it => {
  // Display the entry with full author names
  let authors = it.authors.map(a => a.name.display())
  authors.join(", ") - it.title
  #v(0.5em)
  it.body
  #v(1.5em)  // Spacing between entries
}