#import "../lib.typ": ieee

#show : ieee.with(title: [Project title],
  abstract: [
    This template provides instructions for your final PBL report. The abstract must be a concise yet comprehensive reflection of what your project is about. In particular, the abstract must be self-contained, without abbreviations, footnotes, or references. It should be a microcosm of the full report, describing the problem, solution, technical summary of the prototype and how it was tested.
    \ The abstract should be below 1000 characters. Ensure that your abstract reads well and is grammatically correct.
  ],
  authors: (
    (
      firstname: "A",
      lastname: "Author",
      description: "was born in Lodz in 1999 and since 2020 has been enrolled at University XXX, majoring in XXX. If he/she has some job experience you can put it in here as well.
The second paragraph should summarize the author’s contributions to the project. Was he/she primarily involved in research? Prototype design? Coding? Managed/organized meetings? Prepared what sections of the report? You can write out longer description of what the author did, spreading to below the photo. The description should be between 500 and 1000 characters long. The photos should be 3,26  cm x 2,56 cm and either all colored or all greyscale.  ",
      image: "template/media/image4.png",
      from: "Lodz University of Technology, International Faculty of Engineering, Lodz, Poland"
    ),
    (
      firstname: "B",
      lastname: "Author",
      description: "as above...",
      image: "template/media/image5.png",
      from: "Erasmus University of Erasmus, City, COUNTRY"
    ),
    (
      firstname: "C",
      lastname: "Author",
      description: "etc..",
      image: "template/media/image6.png",
      from: "Lodz University of Technology, International Faculty of Engineering, Lodz, Poland"
      )
  ),
  bibliography: bibliography("refs.yaml"),
  figure-supplement: [Figure ],
  supervisor: (name : "A. Boss", email: "a.boss@p.lodz.pl"),
  index-terms: ("keywords", "here"),
)

#title("Project title")

= Introduction
This document is a template for Microsoft Word versions 6.0 or later. When uploading your solution please upload both a DOCX file and a PDF file.
Headers for different sections can be named differently, but all the required content must be included.
Do not change the font sizes or line spacing. Try to use the Format Painter to keep the formatting of text and headers consistent (copy-paste the formatting from existing elements of the template).

== Background information
Analytical description of the problem situation presented at the beginning of the project work. Scale of the problem.

== Problem finding
Describe the path from the starting point stated above, through detailed research on the general problem to the narrowed specific problem description

= Idea finding
This section will describe the process of finding your solution.

== State of the art
Research on existing knowledge and solutions in relation to the specific problem defined above. This section will contain the most links to scientific articles or websites of commercial solutions. Include the references in square brackets: @first_citation.  For a complete discussion of references and their formats, see the IEEE style manual at www.ieee.org/authortools.

== Innovative ideas
Ideas developed by your team, adding new value to better address the stated problem, possibly leading to more effective solutions.

== Main idea selection and justification
Which of the above ideas your team finds the most worth developing and why?

#figure(
  image("media/image3.png"),
  caption: [Prepare good resolution of images (at least 300dpi, preferably 600dpi) and max 88mm wide. If the figure comes from external reference, cite it here @second_citation]
)

= Solution Implementation
Summarize your solution before discussing the technical details of the prototyping process.

== Technical details
Details of putting the selected idea into life e.g. in form of a material or virtual prototype. Reference figures using phrases such as “…as seen in Fig. 1 and Table I”

= Ways of verification
How your team plans to verify (or has already verified) if your solution effectively solves the problem?

#figure(
  table(columns: 3,
    [Symbol], [Quantity], [Conversion from Gaussian and CGS EMU to SI a],
    [$Phi$], [magnetic flux], [1 Mx $-> 10^-8$ Wb = $10^-8 V dot s$],
    [$B$], [magnetic flux density, magnetic induction], [1 G $-> 10^-4$ T = $10^4$ Wb/m2],
    [$H$], [magnetic field strength], [1 Oe $-> 10^3$/($4 pi$ A/m],
    [$m$], [magnetic moment], [1 erg/G = 1 emu $-> 10^-3$ A·m2 = $10^-3$ J/T],
    [$M$], [magnetization], [1 erg/(G·cm3) = 1 emu/cm3 $-> 10^3$ A/m],
    [$4 pi M$], [magnetization], [1 G $-> 10^3$ /($4 pi$) A/m],
    [$delta$], [specific magnetization], [1 erg/(G·g) = 1 emu/g $->$ 1 A·m^2/kg],
  ),
  caption: [Common units for magnetic properties #footnote([Typically scientific articles do not use vertical lines in tables. Short footnotes under the table can provide some additional information, or a source for the data @third_citation])]
)

= Conclusions and perspectives
Summarize your work, highlighting strengths and weaknesses of its results. How do you see a potential follow-up of the project?

= Appendix
Appendixes, if needed, appear before the acknowledgment. This is a good place to place a link to code or data repositories online. Possibly a youtube clip of a demonstration of your prototype solution.

= Acknowledgment
A place to thank the supervisor, experts, organization and/or sponsors that helped with your project. .
