// Frontiers-style Typst template (converted from the provided LaTeX sample).
// Edit the metadata block below to populate the cover, abstract, and headings.

#let config = (
  title: "Article Title",
  running-title: "Running Title",
  authors: (
    (name: "First Author", affiliations: (1,), corresponding: true, email: "email@uni.edu"),
    (name: "Co-Author", affiliations: (2,), corresponding: false, email: ""),
    (name: "Co-Author", affiliations: (1, 2), corresponding: false, email: ""),
  ),
  affiliations: (
    "Laboratory X, Institute X, Department X, Organization X, City X, State XX (only USA, Canada and Australia), Country X",
    "Laboratory X, Institute X, Department X, Organization X, City X, State XX (only USA, Canada and Australia), Country X",
  ),
  abstract: [
    For full guidelines regarding your manuscript please refer to
    link("Author Guidelines", "http://www.frontiersin.org/about/AuthorGuidelines").
    As a primary goal, the abstract should render the general significance and
    conceptual advance of the work clearly accessible to a broad readership.
    References should not be cited in the abstract. Leave the abstract empty if
    your article does not require one; see the summary table for details
    according to article type.
  ],
  keywords: ("keyword", "keyword", "keyword", "keyword", "keyword", "keyword", "keyword", "keyword"),
  show-logo: true,
)

#set page(
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
)
#set text(font: "Helvetica", size: 11pt)
#set par(leading: 1.35em, spacing: 0.8em)
#set heading(numbering: "1.")

#let keyword-block(keywords) = text(size: 8pt)[*Keywords:* #keywords.join(", ")]

#if config.show-logo {
  align(center)[
    image("logo1.pdf", width: 5cm)
  ]
  v(0.6cm)
}
#align(center)[
  text(size: 10pt)[Running Title: #config.running-title]
  v(0.3cm)
  text(size: 18pt, weight: "bold")[#config.title]
  v(0.35cm)
  #for (i, a) in config.authors.enumerate() {
    a.name
    if a.affiliations.len() > 0 {
      let affs = a.affiliations.map(n => repr(n)).join(", ")
      super(affs)
    }
    if a.corresponding { super("*") }
    if i < config.authors.len() - 1 {", "}
  }
]
v(0.5cm)
#for (i, aff) in config.affiliations.enumerate() {
  super(repr(i + 1)) + " " + aff
  linebreak()
}
v(0.3cm)
#let corr = config.authors.filter(a => a.corresponding)
#if corr.len() > 0 {
  [
    *Correspondence*:
    #for (i, a) in corr.enumerate() {
      a.name
      if a.email != "" { " (" + a.email + ")" }
      if i < corr.len() - 1 {"; "}
    }
  ]
}
pagebreak()

#heading(level: 1, numbering: none)[Abstract]
#config.abstract
#v(0.4cm)
#keyword-block(config.keywords)

#heading("Introduction")
For Original Research Articles @conference, Clinical Trial Articles @article, and
Technology Reports @patent, the introduction should be succinct, with no
subheadings @book. For Case Reports the introduction should include symptoms at
presentation @chapter, physical exams and lab results @dataset.

#heading("Article types")
For requirements for a specific article type please refer to the Article Types
on any Frontiers journal page. Please also refer to
link("Author Guidelines", "http://home.frontiersin.org/about/author-guidelines#Sections")
for further information on how to organize your manuscript in the required
sections or their equivalents for your field.

// For Original Research articles, the Materials and Methods section can be
// placed before Results, before Discussion, or after Discussion.

#heading("Manuscript Formatting")

#heading(level: 2)[Heading Levels]
There are five heading levels.

#heading(level: 3)[Level 2]
#heading(level: 4)[Level 3]
#heading(level: 5)[Level 4]
#heading(level: 6)[Level 5]

#heading(level: 2)[Equations]
Equations should be inserted in editable format from the equation editor.

#math.display($ sum x + y = Z $)

#heading(level: 2)[Figures]
Frontiers requires figures to be submitted individually, in the same order as
they are referred to in the manuscript. Figures will then be automatically
embedded at the bottom of the submitted manuscript. Kindly ensure that each
table and figure is mentioned in the text and in numerical order. Figures must
be of sufficient resolution for publication
link("see here for examples and minimum requirements", "https://www.frontiersin.org/about/author-guidelines#ImageSizeRequirements").
Figures which are not according to the guidelines will cause substantial delay
during the production process. Please see
link("the figure guidelines", "https://www.frontiersin.org/about/author-guidelines#FigureRequirementsStyleGuidelines")
for full figure guidance. Cite figures with subfigures using (A) and (B).

#heading(level: 3)[Permission to Reuse and Copyright]
Figures, tables, and images will be published under a Creative Commons CC-BY
license and permission must be obtained for use of copyrighted material from
other sources (including re-published/adapted/modified/partial figures and
images from the internet). It is the responsibility of the authors to acquire
the licenses, to follow any citation instructions requested by third-party
rights holders, and cover any supplementary charges.

#heading(level: 2)[Tables]
Tables should be inserted at the end of the manuscript. Please build your table
directly in Typst. Very large tables (covering several pages) cannot be
included in the final PDF for reasons of space. These tables can be published
as supplementary material on the online article page at the time of acceptance.

#heading(level: 2)[International Phonetic Alphabet]
To include international phonetic alphabet (IPA) symbols, load the `tipa` font
on your system and wrap the desired glyphs in a `text` element that uses it,
for example `text(font: "Charis SIL")[ɣ]`.

#heading("Nomenclature")

#heading(level: 2)[Resource Identification Initiative]
To take part in the Resource Identification Initiative, please use the
corresponding catalog number and RRID in your current manuscript. For more
information about the project and for steps on how to search for an RRID, please
click link("here", "http://www.frontiersin.org/files/pdf/letter_to_author.pdf").

#heading(level: 2)[Life Science Identifiers]
Life Science Identifiers (LSIDs) for ZOOBANK registered names or nomenclatural
acts should be listed in the manuscript before the keywords. For more
information on LSIDs please see
link("Inclusion of Zoological Nomenclature",
"https://www.frontiersin.org/about/author-guidelines#Nomenclature").

#heading("Additional Requirements")
For additional requirements for specific article types and further information
please refer to
link("Author Guidelines – Additional Requirements",
"http://www.frontiersin.org/about/AuthorGuidelines#AdditionalRequirements").

#heading(numbering: none)[Conflict of Interest Statement]
The authors declare that the research was conducted in the absence of any
commercial or financial relationships that could be construed as a potential
conflict of interest.

#heading(numbering: none)[Author Contributions]
The Author Contributions section is mandatory for all articles, including
articles by sole authors. If an appropriate statement is not provided on
submission, a standard one will be inserted during the production process. The
Author Contributions statement must describe the contributions of individual
authors referred to by their initials and, in doing so, all authors agree to be
accountable for the content of the work. Please see
link("full authorship criteria",
"https://www.frontiersin.org/about/policies-and-publication-ethics#AuthorshipAuthorResponsibilities")
for details.

#heading(numbering: none)[Funding]
Details of all funding sources should be provided, including grant numbers if
applicable. Please ensure to add all necessary funding information, as after
publication this is no longer possible.

#heading(numbering: none)[Acknowledgments]
This is a short text to acknowledge the contributions of specific colleagues,
institutions, or agencies that aided the efforts of the authors.

#heading(numbering: none)[Supplemental Data]
Supplementary material should be uploaded separately on submission. If there are
supplementary figures, please include the caption in the same file as the
figure.

#heading(numbering: none)[Data Availability Statement]
The datasets [generated/analyzed] for this study can be found in the [NAME OF
REPOSITORY] [LINK].

#bibliography("sample.bib")

#heading(numbering: none)[Figure captions]
// Please upload figures individually when submitting the article. Use the
// figure blocks below to keep captions aligned with their references.

#figure(
  caption: [Enter the caption for your figure here. Repeat as necessary for each of your figures.],
  image("logo1.pdf", width: 10cm),
)

#figure(
  caption: [
    Enter the caption for your subfigure here. *(A)* This is the caption for
    Subfigure 1. *(B)* This is the caption for Subfigure 2.
  ],
)[
  #grid(
    columns: 2,
    gutter: 12pt,
  )[
    #figure(
      caption: [This is Subfigure 1.],
      image("logo1.pdf", width: 6cm),
    )
    #figure(
      caption: [This is Subfigure 2.],
      image("logo2.pdf", width: 6cm),
    )
  ]
]
