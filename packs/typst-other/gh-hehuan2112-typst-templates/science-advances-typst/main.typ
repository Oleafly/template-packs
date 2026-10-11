#import "science-advances.typ": manuscript

#let paper-title = [A Typst-Based Science Advances Manuscript Template]
#let short-title = [Typst Science Advances Template]

#show: manuscript.with(
  title: paper-title,
  short-title: short-title,
  bibliography-file: "references.bib",
)
= Title

#paper-title \
#short-title


= Authors

Firstname M. Lastname, #super[1] Firstname I. Lastname,^1,2^ Firstname I. Lastname3†

Authors should be listed in order of contribution to the paper, by first name, then middle initial (if any), followed by last name and separated by commas. The author list should be one single paragraph with no line breaks. Failure to spell out first names will introduce errors when the paper is deposited in PubMed. The author list should match information cataloged in the author paperwork in CTS.

= Affiliations

Use superscript numbers (1, 2, 3) to designate author affiliations. 
- Each affiliation should be preceded by superscript numbers corresponding to the author list, and each affiliation should end with a period.
- Each affiliation should be a separate paragraph.
- You can include group authors, but please include a list of the actual authors (the group members) in the Supplementary Materials.

*Identify the corresponding author with an asterisk (\*) and be sure to include that person’s e-mail address.*

Use symbols (in this order: †, ‡, §, ||, ¶, \#, ††, ‡‡, etc.) for author notes such as present addresses, “These authors contributed equally to this work” notations, and similar information.


= Abstract

The abstract should be a single paragraph *(less than 160 words)* written in plain language that a general reader can understand. Do not include citations. The abstract should provide: 
- An opening sentence that states the question/problem addressed by the research
- Enough background content to give context to the study 
- A brief statement of primary results 
- A short concluding sentence


= Teaser

This one-sentence summary (\<130 characters with period) provides a pithy snapshot of your research for non-specialist readers and should complement rather than repeat the title. Do not use “We” to start the teaser.

= MAIN TEXT

= Main Text

This example shows the intended writing workflow. The page geometry, serif body text, sans-serif title block, and footer are configured by the template. You can write normally in Typst and cite references such as @knuth1984 and @lamport1994.

= Results

Body paragraphs are set in a Times-like style at 9 point with a fixed leading close to the Word template. Section headings are intentionally conservative because the original Word file uses editorial styles that are awkward to reproduce exactly outside Word.

= Figures and Tables

You may include up to *a total of 10 figures and/or tables (combined)* throughout the manuscript. You should embed your figures within the Word file. A detailed description for figure preparation can be found on the topical style sheet for your field. For revised papers, include the captions at the end of the document and upload figures to CTS.

#figure(
  caption: [*Short title of the first figure.* The figure legend should begin with a title (an overall description of the figure, in boldface) followed by additional text. Each legend should be placed immediately after its corresponding figure. ],
  rect(width: 100%, height: 3.2cm, fill: luma(235)),
)

#table(
  columns: 3,
  align: center + horizon,
  table.header([Condition], [Value], [Unit]),
  [Control], [12.4], [ms],
  [Treatment], [15.1], [ms],
)

#figure(
  kind: table,
  caption: [*Short title of the first table.* Start table legends with a title (short description of the table). Format tables using the Word Table commands and structures. Do not use spaces, tabs or hard returns to create tables. Every vertical column should have a heading, followed by a unit of measure (if any) in parentheses. Units should not change within a column. Centered headings of the body of the table can be used to break the entries into groups. Footnotes should contain information relevant to specific cells of the table; use the following symbols in order, as needed:\*, †, ‡, §, ||, ¶, \#, \*\*, ††, etc. (Don’t use footnotes in column heads; include any such details in sentence form after the table itself.)],
  supplement: [Table],
  placement: none,
)[]

= Discussion

Inline mathematics such as $a^2 + b^2 = c^2$ and display equations are supported.

$ integral_0^1 x^2 dif x = 1 / 3 $

= Materials and Methods

Add any manuscript sections here as normal headings. Supplementary information can be placed in a second Typst file if you want a separate PDF.

= Acknowledgments

Acknowledgments follow the references and notes section but are not numbered. They should include the following information in the order listed below. Each section must be a *separate paragraph* and the heading in bold. Please use the subhead and boldface layout as shown below.).

If applicable, begin the section with text that acknowledges non-author contributions. (Note this section does not have a general heading).

*Funding*: Include all funding sources, including grant numbers, complete funding agency names, and recipient’s initials. Each funding source should be listed in a separate paragraph such as:
National Institutes of Health grant U12AV123456 (PV, CHO)
National Institutes of Health grant R01AB123456 (PV, GS)
William K. Bowes Jr Foundation (PV)
German Research Foundation grant AB 1234/1-1
Office of Biological and Environmental Research of the U.S. Department of Energy Atmospheric System Research Program Interagency Agreement grant DE-SC0000001
National Institute of Health Researh UK

*Author contributions*: Each author’s contribution(s) to the paper should be listed (we suggest following the CRediT model with each CRediT role given its own line. No punctuation in the initials.

Examples: \
Conceptualization: SBB, DLA, MPW \
Methodology: HP, FTGS, CW, JRK \
Investigation: SBB, DLA, MPW \
Visualization: SFB \
Supervision: SJE, JLS, EH \
Writing—original draft: SBB, DLA \
Writing—review & editing: SBB, DLA, PRB, EH \

Competing interests: Include any financial interests of the authors that could be perceived as being a conflict of interest (including but not limited to financial holdings, professional affiliations, advisory positions, and board memberships). Also include any awarded or filed patents pertaining to the results presented in the paper. If the entire group of authors has no competing interests, the authors should declare this (e.g., “Authors declare that they have no competing interests.”) In cases where some authors have competing interests and others do not, note the competing interests and then use the following, “All other authors declare they have no competing interests.”

Data and materials availability: All data, code, and materials used in the analyses must be available in some form to any researcher for purposes of reproducing or extending the analyses. Include a note explaining any restrictions on materials, such as materials transfer agreements (MTAs). Include accession numbers to any data relevant to the paper and deposited in a public database; include a brief description of the dataset or model with the number.  The DMA statement should include the following: “All data are available in the main text or the supplementary materials.”

