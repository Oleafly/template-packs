#import "../oist_thesis.typ": unnumbered-chapter, thesis-title, thesis-author, thesis-submission-date

#unnumbered-chapter("Declaration of Original and Sole Authorship")

#context {
  let title = thesis-title.get()
  let author = thesis-author.get()
  let submission_date = thesis-submission-date.get()

  // Match LaTeX formatting for this page
  set par(
    justify: true,
    first-line-indent: 0em,  // No indentation for declaration page
    // Inherit line spacing from document settings (don't override)
  )

  [
    I, #author, declare that this thesis entitled #emph[#title] and the data presented in it are original and my own work.

    // Space between paragraphs should match line spacing

    I confirm that:

    #list(
      tight: false,  // Ensure proper spacing between list items
      [No part of this work has previously been submitted for a degree at this or any other university.],
      [References to the work of others have been clearly acknowledged. Quotations from the work of others have been clearly indicated and attributed to them.],
      [In cases where others have contributed to part of this work, such contribution has been clearly acknowledged and distinguished from my own work.],
      // List every publication and preprint that overlaps with this thesis, with
      // your own contribution stated. Delete the nested list (and adjust the
      // sentence) if none of this work has appeared elsewhere.
      //
      // If the work of any co-authors appears in this thesis, authorization such
      // as a release or signed waiver from all affected co-authors must be
      // obtained prior to publishing the thesis. Attach copies of that
      // authorization to your initial and final submitted versions as a separate
      // document for retention by the Graduate School, and state here that it
      // has been obtained.
      [None of this work has been previously published or pre-printed elsewhere, with the exception of the following:

        #list(
          tight: false,
          [#underline[#strong[Author, A.]], Coauthor, B., & Supervisor, C. (2025). Title of the first journal article that overlaps with this thesis. _Journal Name_, _12_(3), 123456. https://doi.org/10.0000/example.2025.123456 #linebreak() #h(1em) #strong[Contribution:] #emph[Conceptualization, Investigation, Formal analysis, Writing -- original draft]],
          [#underline[#strong[Author, A.]], & Supervisor, C. (2025). Title of the second journal article. _Another Journal_, _7_(1), 42. https://doi.org/10.0000/example.2025.000042 #linebreak() #h(1em) #strong[Contribution:] #emph[Methodology, Investigation, Formal analysis, Writing -- review & editing]],
        )]
    )

    Date: #submission_date

    #v(0.2em)

    // Replace images/signature.svg with a scan of your own signature.
    // Any image format Typst supports works here (SVG, PNG, JPG, PDF).
    // `baseline` pushes the image below the text baseline so it sits on the
    // "Signature:" line; raise `height` only if the page still has room, since
    // this whole block has to fit under the publication list above.
    Signature: #h(0.5em)#box(image("../images/signature.svg", height: 1.4cm), baseline: 55%)
  ]
}
