#let liu(
  // The paper's title.
  title: [Paper Title],

  // The paper's subtitle (optional).
  subtitle: none,

  // The paper's swedish title (optional).
  titleSwedish: none,

  // The paper's swedish subtitle (optional).
  subtitleSwedish: none,

  // An array of authors names.
  authors: (),

  // The paper's abstract. Can be omitted if you don't have one.
  abstract: none,

  // The path to a bibliography file if you want to cite some external
  // works.
  bibliography-file: none,

  // The supervisor's name.
  supervisor: none,

  // The examiner's name.
  examiner: none,

  // The paper's content.
  body
) = {
  // Set document metadata.
  set document(title: title, author: authors)

  // Configure the page.
  set page(
    paper: "a4",
    margin: 30mm
  )

  // Display the front page cover.
  set text(font: "FreeSans")
  page(
    header-ascent: 0%,
    header: align(
      right,
      {
        [
          Linköping University | Department of Computer and Information Science \
          Master's thesis, 30 ECTS | Datavetenskap \
          2024 | LIU-IDA/LITH-EX-A--24/001--SE
        ]
      }
    ),
    footer-descent: 0%,
    footer: pad(bottom: 20mm, table(
      columns: (60%, 1fr, 40%),
      align: (x, y) => (left + bottom, center, right + bottom).at(x),
      inset: 0pt, 
      stroke: none,
      // The negative padding is a workaround to remove the padding
      // around the logo
      pad(-20pt, image(height: 90pt, "resources/liu_logo.svg")),
      [],
      text(10pt)[
        Linköpings universitet \
        SE-581 83 Linköping \
        +46 13 28 10 00, www.liu.se
      ]
    )),
    align(
      horizon + left,
      pad(left: 40mm, {
        // Display the paper's title.
        stack(
          spacing: 1.5em,
          text(20pt, title),
          if (subtitle != none) {
            text(12pt)[\- #subtitle]
          }
        )

        v(8.35mm, weak: true)

        line(length: 100%)

        text(
          size: 12pt,
          {
            emph(stack(
              spacing: 1em,
              if (titleSwedish != none) {
                titleSwedish
              },
              if (subtitleSwedish != none) {
                [\- #subtitleSwedish]
              }
            ))
        })

        v(1em)

        // Display the authors list.
        for author in authors {
          [*#author*]
          parbreak()
        }

        v(1em)

        // Display the supervisor.
        text(size: 10pt)[
          Supervisor: #supervisor \
          Examiner: #examiner
        ]
      })
    )
  )

  // Set the body font.
  set text(font: "Free Serif", size: 11pt)

  // Paragraph properties.
  set par(justify: true, first-line-indent: 1em)
  show par: set block(spacing: 0.65em)

  // Configure lists.
  set enum(indent: 10pt, body-indent: 9pt)
  set list(indent: 10pt, body-indent: 9pt)

  // Display copyright notice.
  heading(level: 2, numbering: none, outlined: false, "Upphovsrätt")
  [
    Detta dokument hålls tillgängligt på Internet -- eller dess framtida
    ersättare -- under 25 år från publiceringsdatum under förutsättning att
    inga extraordinära omständigheter uppstår.

    Tillgång till dokumentet innebär tillstånd för var och en att läsa, ladda
    ner, skriva ut enstaka kopior för enskilt bruk och att använda det
    oförändrat för ickekommersiell forskning och för undervisning. Överföring
    av upphovsrätten vid en senare tidpunkt kan inte upphäva detta tillstånd.
    All annan användning av dokumentet kräver upphovsmannens medgivande. För
    att garantera äktheten, säkerheten och tillgängligheten finns lösningar av
    teknisk och administrativ art.

    Upphovsmannens ideella rätt innefattar rätt att bli nämnd som upphovsman i
    den omfattning som god sed kräver vid användning av dokumentet på ovan
    beskrivna sätt samt skydd mot att dokumentet ändras eller presenteras i
    sådan form eller i sådant sammanhang som är kränkande för upphovsmannens
    litterära eller konstnärliga anseende eller egenart.

    För ytterligare information om Linköping University Electronic Press, se
    förlagets hemsida #link("http://www.ep.liu.se/")[`http://www.ep.liu.se/`].
  ]

  heading(level: 2, numbering: none, outlined: false, "Copyright")
  [
    The publishers will keep this document online on the Internet - or its
    possible replacement - for a period of 25 years starting from the date of
    publication barring exceptional circumstances.

    The online availability of the document implies permanent permission for
    anyone to read, to download, or to print out single copies for his/hers own
    use and to use it unchanged for non-commercial research and educational
    purpose. Subsequent transfers of copyright cannot revoke this permission.
    All other uses of the document are conditional upon the consent of the
    copyright owner. The publisher has taken technical and administrative
    measures to assure authenticity, security and accessibility.

    According to intellectual property law the author has the right to be
    mentioned when his/her work is accessed as described above and to be
    protected against infringement.

    For additional information about the Linköping University Electronic Press
    and its procedures for publication and for assurance of document integrity,
    please refer to its www home page:
    #link("http://www.ep.liu.se/")[`http://www.ep.liu.se/`].
  ]

  pad(left: 1em, top: 4em)[
    $copyright$
    #for author in authors {
      author
      parbreak()
    }
  ]

  pagebreak(weak: true)

  // Display abstract and index terms.
  if abstract != none {
    align(center, [*Abstract*])
    v(1em)

    h(1em)
    abstract
    pagebreak(weak: true)
  }

  // Display outline
  {
    set par(first-line-indent: 0pt)
    show outline.entry.where(
      level: 1
    ): it => {
      let heading_page = counter(page).at(it.element.location()).first()

      v(0.8em)
      text(13pt, strong({
        link(it.element.location())[#it.body]
        h(1fr)
        [#heading_page]
      }))
    }
    outline(depth: 2, indent: auto, title: { 
      heading("Contents")
      v(2em)
    })
  }

  // Configure equation numbering and spacing.
  set math.equation(numbering: "(1)")
  show math.equation: set block(spacing: 0.65em)

  // Configure appearance of equation references
  show ref: it => {
    if it.element != none and it.element.func() == math.equation {
      // Override equation references.
      link(it.element.location(), numbering(
        it.element.numbering,
        ..counter(math.equation).at(it.element.location())
      ))
    } else {
      // Other references as usual.
      it
    }
  }

  // Configure headings.
  set heading(numbering: "1.1.1.")
  show heading: it => locate(loc => {
    if (it.level == 1) {
      // Always start top-level headings on a new page
      pagebreak(weak: true)

      // Draw in the style of Latex VZ43
      set text(size: 20pt)
      box(
        height: 6.5cm,
        stack(
          // Vertical lines
          for i in range(7) {
            place(line(start: (i * 4pt, 0pt), angle: 90deg, length: 5cm))
          },
          // Chapter numbering
          if it.numbering != none {
            place(
              dx: 0.25cm,
              dy: 2.5cm,
              rect(
                fill: black,
                inset: 8pt,
                text(fill: white, counter(heading).display()),
              )
            )
          },
          // Chapter title
          place(
            dx: 1.5cm,
            dy: 2.5cm,
            rect(
              inset: 8pt,
              stroke: none,
              it.body,
            )
          )
        )
      )

      return
    }

    v(0.65em)

    // Show numbering for at most 3 levels
    if (it.numbering != none and it.level <= 3) {
      // Add horizontal spacing between numbering and title
      block({
        counter(heading).display()
        h(10pt)
        it.body
      })
    } else {
      block({ it.body })
    }

    v(0.65em)
  })

  set page(numbering: "1")
  counter(page).update(1)

  // Display the paper's contents.
  body

  // Display bibliography.
  if bibliography-file != none {
    bibliography(bibliography-file, title: [Bibliography], style: "ieee")
  }
}
