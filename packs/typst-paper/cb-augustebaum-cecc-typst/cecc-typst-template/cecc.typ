// Define custom elements for authors and institutes
#let author(name, institutes: (), emails: (), orcid: none) = {
  (name: name, institutes: institutes, emails: (), orcid: orcid)
}

#let institute(name, email: none) = {
  (name: name, email: email)
}

// Basic listing style (approximation of lstset)
#let listing(body) = {
  block(
    fill: luma(240),
    inset: 0.5em,
    radius: 4pt,
    text(font: "Libertinus Mono", size: 0.9em)[#body],
  )
}

// Approximation of \email and \emails
#let cecc_email(email_address) = {
  link("mailto:" + email_address)[#email_address]
}

#let cecc_emails(domain, local_parts) = {
  let linked_lps = local_parts.map(lp => link("mailto:" + lp + "@" + domain)[#lp])
  text(font: "Libertinus Mono")[{#linked_lps.join(",")}@#domain]
}

#let cecc(
  title: "",
  subtitle: none,
  authors: (),
  institutes: (),
  keywords: (),
  running_authors: none,
  running_title: none,
  check-page-number: true,
  body,
) = {
  // Set document metadata
  set document(
    title: title,
    author: authors.map(a => a.name).join(", "),
    keywords: keywords.join(", "),
    // subject: "24th Central European Conference on Cryptology", // Removed due to error
  )

  // Set page geometry
  set page(
    paper: "a4",
    margin: (x: 17.5%, y: 12.5%), // hscale=0.65, vscale=0.75, marginratio=1:1
    // marginparwidth is not directly translatable to a global setting, might need custom layout
  )

  // Set fonts
  set text(font: "Libertinus Serif", size: 10pt)

  // Approximation of \sffamily\boldmath
  show heading: set text(font: "Libertinus Sans", weight: "bold")
  set heading(numbering: "1.1")
  // show heading: it => [#it.numbering #h(1em) #it.body #repr(it)]
  show heading: it => block({
    v(0.25em)
    if it.numbering != none {
      numbering(it.numbering, ..counter(heading).get())
      h(1em)
    }
    it.body
  })

  show link: set text(font: "Libertinus Mono", fill: rgb("#0000ff"))
  show raw: set text(font: "Libertinus Mono")

  // Custom title page layout
  // Need to replicate the LaTeX \maketitle logic
  // This is a simplified version and may need adjustments
  // Approximation of \LARGE \bfseries\sffamily\boldmath
  align(center)[
    #block(
      text(
        font: "Libertinus Sans",
        size: 1em * 1.2 * 1.2 * 1.2,
        weight: "bold",
      )[#title],
    )

    #if subtitle != none {
      // Approximation of \large\sffamily\bfseries
      text(font: "Libertinus Sans", size: 1em * 1.2, weight: "bold")[#subtitle]
    }

    // #v(0.75em)
    // #line(length: 100%)
    #v(0.5em)

    #text(size: 1em * 1.2)[
      #for (i, author) in authors.enumerate() {
        author.name
        super[#author.institutes.map(str).join(",")]
        [ ]
        if author.orcid != none {
          link("https://orcid.org/" + author.orcid)[#box(
              image(
                "orcid-logo.svg",
                height: 0.75em,
              ),
            )]
        }
        if authors.len() == 1 {
          ""
        } else if i < authors.len() - 2 {
          ", "
        } else if i == authors.len() - 2 {
          " and "
        } else {
          ""
        }
      }
    ]

    #v(0.5em)

    #[
      // #let leading = context {
      //   par.leading
      // }
      #set par(spacing: 0.65em)
      #for (i, institute) in institutes.enumerate() {
        super[#{
            i + 1
          }]
        institute.name
        if institute.email != none {
          ", "
          if type(institute.email) == "string" {
            cecc_email(institute.email)
          } else {
            institute.email // Assumes this is already formatted content from cecc_emails
          }
        }
        if i < institutes.len() - 1 {
          parbreak()
        }
      }
    ]
  ]

  v(0.5em)
  line(length: 100%, stroke: 0.5pt)
  v(0.5em)

  // Keywords section
  block(
    text(size: 0.9em)[
      #set par(leading: 0.5em)
      *Keywords:* #keywords.join(" \u{00B7} ") // Using middle dot for separator
    ],
  )

  v(0.5em)
  line(length: 100%, stroke: 0.5pt)

  // Main body content
  body

  // Header and Footer
  set page(
    header: [
      #set text(size: 9pt)
      #grid(
        columns: (1fr, auto, 1fr),
        align: (left, center, right),
        [#if running_authors != none {running_authors} else {authors.map(a => a.name).join(", ")}], // Simplified running authors
        [], // Center is empty in LaTeX
        [#if running_title != none {running_title} else {}], // Simplified running title
      )
      #line(length: 100%)
    ],
    footer: [
      #set text(size: 9pt)
      #grid(
        columns: (1fr, auto, 1fr),
        align: (left, center, right),
        [CECC 2024], [#counter(page)], [],
      )
      // line(length: 100%) // The LaTeX version doesn't have a line under the footer page number
    ],
  )

  // Assert page limit (max 4 pages)
  if check-page-number {
    context {
      let total_pages = counter(page).at(here()).last()
      assert(
        total_pages <= 4,
        message: "Extended abstract cannot exceed 4 pages (found " + repr(total_pages) + ")",
      )
    }
  }
}
