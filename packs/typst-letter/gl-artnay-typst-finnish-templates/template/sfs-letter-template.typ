// ###########################
// # typst-finnish-templates #
// ###########################
//
// Project page:
// https://codeberg.org/artnay/typst-finnish-templates
//
// Template:
// Letter
//
// SPDX-License-Identifier:
// LGPL-3.0-or-later
//
// References:
// https://typst.app/docs/reference/
// https://sales.sfs.fi/en/index/tuotteet/SFS/SFS/ID2/2/1317703.html.stx#

#let sfs_letter(
  body,
  logo: none, // Add your logo file name, e.g. "logo.svg", in the letter file
  document_type: "Asiakirjatyyppi",
  date: "Valitse päivämäärä",
  document_id: "Asiakirjan yksilöivä tunnus",
  confidentiality: "Luottamuksellisuus",
  meta_1: "Lisämetatieto 1",
  meta_2: "Lisämetatieto 2",
  recipient_org: "Vastaanottajan organisaatio",
  recipient_name: "Vastaanottajan nimi",
  recipient_street: "Vastaanottajan osoite",
  recipient_postalcode: "00000",
  recipient_city: "Kaupunki",
  subject: "Asiakirjan aihe",
  title: "Asiakirjan sisältöä kuvaava pääotsikko",
  signer_1_name: "Maija Meikäläinen",
  signer_1_title: "asiantuntija",
  signer_1_email: "Sähköposti",
  signer_2_name: "Matti Meikäläinen",
  signer_2_title: "asiantuntija",
  signer_2_email: "Sähköposti",
  company_name: "Yhtiön nimi",
  company_email: "Sähköposti:",
  company_website: "www:",
  company_phone: "Puhelin: +358 9 123 456",
  company_office: "Toimipiste",
  company_street: "Katu",
  company_postalcode: "00000",
  company_city: "Kaupunki",
  company_id: "Y-tunnus:",
) = {
  // Set document properties
  set document(title: title, author: signer_1_name)

  // Set page properties
  // SFS specifies that left and bottom margins must be 2 cm. Other margins must be at least 1 cm.
  set page(
    paper: "a4",
    margin: (top: 1.0cm, left: 2.0cm, right: 1.5cm, bottom: 2.0cm),
    header: context {
      if counter(page).get().first() > 1 {
        // Show page number only on pages after the first
        // Spacing from top to maintain 1 cm margin
        v(0.5cm)
        align(right)[
          #counter(page).display() (#counter(page).final().first())
        ]
      }
    },
    header-ascent: 1pt, // Position page numbers
  )

  // Set text properties
  // SFS specifies that the font is usually 11-12 pt and line spacing 1,1-1,2
  set text(
    font: "Liberation Sans",
    size: 12pt,
    lang: "fi",
  )

  // Set paragraph properties
  set par(
    leading: 0.35em, // FIXME: With font size 12 pt this should provide approximately 1.2
    first-line-indent: 0pt,
    justify: false,
    spacing: 1em // FIXME: Check the SFS docs for this
  )

  // Set heading styles
  set heading(
    numbering: none,
    outlined: false
  )

  // Top section with logo, metadata, and page number
  // https://typst.app/docs/reference/layout/grid/
  // FIXME: Check the values in accordance with SFS
  grid(
    columns: (4cm, 5.2cm, 1fr),
    column-gutter: 0cm,

    // Left column - logo
    // FIXME: What should be the max dimensions?
    if logo != none {
      image(logo, width: 4cm)
    } else {
      // Logo placeholder when no logo provided
      rect(width: 4cm, height: 2cm, stroke: 0.5pt + gray)[
        #align(center + horizon)[LOGO]
      ]
    },

    // Middle column - metadata position should be at 9,2 cm
    place(
      left + top,
      dx: 4.7cm, // Metadata 4,7 cm to the right
      stack(
        dir: ttb,
        spacing: 0.5em,
        text(weight: "bold", document_type),
        date,
        document_id,
        confidentiality,
        if meta_1 != "" { meta_1 },
        if meta_2 != "" { meta_2 }
  )
),

    // Right column - page number
    align(right)[
      #context [
        #counter(page).display() (#counter(page).final().first())
      ]
    ]
  )

  // Spacing after header
  v(2em)

  // Recipient section (left side, under logo area)
  stack(
    dir: ttb,
    spacing: 0.5em,
    recipient_org,
    recipient_name,
    recipient_street,
    [#recipient_postalcode #recipient_city]
  )

  // Spacing before subject
  v(3em)

  // Subject line
  text(weight: "bold", subject)

  // Spacing before main title
  v(0.2em)

  // SFS does not specify title/heading text sizes
  // SFS recommends that the title is 2-4pt larger than the body text.
  //
  // Main title - 16pt (4pt larger than 12pt body text)
  text(size: 16pt, weight: "bold", title)

  // Spacing after title before body content
  v(1em)

  // SFS recommends to use at most three different heading levels
  // SFS recommends to use bold text that is larger than the body text in headings.
  show heading.where(level: 1): it => {
    set par(first-line-indent: 0pt, spacing: 0pt) // Override paragraph spacing for headings
    v(1pt)
    // Create a block that spans full width to override any padding
    block(width: 100%, inset: 0pt)[
      #text(size: 14pt, weight: "bold", it.body)
    ]
    v(1pt)
  }

  show heading.where(level: 2): it => {
    set par(first-line-indent: 0pt, spacing: 0pt) // Override paragraph spacing for headings
    v(1pt)
    // Create a block that spans full width to override any padding
    block(width: 100%, inset: 0pt)[
      #text(size: 13pt, weight: "bold", it.body)
    ]
    v(1pt)
  }

  show heading.where(level: 3): it => {
    set par(first-line-indent: 0pt, spacing: 0pt) // Override paragraph spacing for headings
    v(1pt)
    // Create a block that spans full width to override any padding
    block(width: 100%, inset: 0pt)[
      #text(size: 12pt, weight: "bold", it.body)
    ]
    v(1pt)
  }

  // List formatting
  show list: it => {
    set list(marker: "•")
    it
  }

  // Body content with selective indentation, SFS specifies 2,3 cm from the left margin
  // Use a custom show rule that applies padding only to paragraphs and lists
  // FIXME: Apply to all elements except headings
  show: doc => {
    show par: it => {
      // Only indent paragraphs that are not part of headings
      pad(left: 2.3cm, it)
    }
    show list: it => {
      // Indent lists more than paragraphs
      // SFS does not specify how much the indentation of lists should or must be
      pad(left: 2.75cm, it)
    }
    doc
  }

  body

  // Digital signature section
  v(2em)
  set par(first-line-indent: 0pt)


  [Tämä asiakirja on sähköisesti allekirjoitettu.]

  v(1.5em)

  // Manually pad only the signature grid
  pad(
    left: 2.3cm,
    // Two signers stacked vertically
    stack(
      dir: ttb,
      spacing: 1.5em,

      // First signer
      stack(
        dir: ttb,
        spacing: 0.3em,
        [#text(weight: "bold", signer_1_name), #signer_1_title],
        v(0.2em),
        signer_1_email
      ),

      // Second signer
      stack(
        dir: ttb,
        spacing: 0.3em,
        [#text(weight: "bold", signer_2_name), #signer_2_title],
        v(0.2em),
        signer_2_email
      )
    )
  )

  // Company information footer
  v(3em)

  // Horizontal line
  line(length: 100%, stroke: 0.5pt)

  v(0.8em)

  // Company details in three columns
  grid(
    columns: (1fr, 1fr, 1fr),
    column-gutter: 1.5em,

    // Left column - company name and contact
    stack(
      dir: ttb,
      spacing: 0.4em,
      text(weight: "bold", company_name),
      v(0.2em),
      company_email,
      v(0.2em),
      company_website,
      v(0.2em),
      company_phone
    ),

    // Middle column - address
    stack(
      dir: ttb,
      spacing: 0.4em,
      company_office,
      v(0.2em),
      company_street,
      v(0.2em),
      [#company_postalcode #company_city]
    ),

    // Right column - business ID
    align(right, company_id)
  )
}

// Example usage
#show: doc => sfs_letter(doc)
