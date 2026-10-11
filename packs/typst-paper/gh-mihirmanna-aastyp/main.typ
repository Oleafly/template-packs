// This example manuscript is adapted from the AASTeXv7 template, available at
// https://www.overleaf.com/latex/templates/aastex-template-for-submissions-to-aas-journals-apj-aj-apjs-apjl-psj-rnaas/vwyggrqvhcgz.

#import "template.typ": template, appendix, facilities, software, doi

// The title may include special characters/symbols if desired.
#let title = [Template AASTyp Article with Examples]
#let short_title = [Template AASTyp Article] // Optional short title for page headers

// Authors are entered as an array of dictionaries.
// All non-empty dictionary fields must contain strings/content blocks, except for `affiliation`, which must be an array of content.
#let authors = (
  (
    first: "Tundra",
    last: "North America",
    affiliation: ("University of Saskatchewan",),
    alt-affiliation: "Kitt Peak National Observatory",
    email: "fakeemail1@google.com",
    orcid: "0000-0000-0000-0001",
  ),
  (
    first: "Forrest",
    last: "Sur América",
    affiliation: ("Universidad de Chile, Department of Astronomy",),
    alt-affiliation: "Las Campanas Observatory",
    email: "fakeemail2@google.com",
    orcid: "0000-0000-0000-0002",
  ),
  (
    first: "Savannah",
    last: "Africa",
    affiliation: ("South African Astronomical Observatory", "University of Cape Town, Department of Astronomy"),
    alt-affiliation: none,
    email: "fakeemail3@google.com",
    orcid: none,
  ),
  (
    first: "River",
    last: "Europe",
    affiliation: ("University of Heidelberg",),
    alt-affiliation: none,
    email: "fakeemail4@google.com",
    orcid: none,
  ),
  (
    first: "Asia",
    last: "Mountain",
    affiliation: ("Tata Institute of Fundamental Research, Department of Astronomy",),
    alt-affiliation: "Astrosat Post-Doctoral Fellow",
    email: "fakeemail5@google.com",
    orcid: "0000-0000-0000-0003",
  ),
  (
    first: "Coral",
    last: "Australia",
    affiliation: ("James Cook University, Department of Physics",),
    alt-affiliation: none,
    email: "fakeemail6@google.com",
    orcid: none,
  ),
  (
    first: "Penguin",
    last: "Antarctica",
    affiliation: ("Amundsen–Scott South Pole Station",),
    alt-affiliation: none,
    email: "fakeemail7@google.com",
    orcid: none,
  ),
)

#let collab = [Terra Mater] // Optional collaboration

#let abstract = [
  This example manuscript is intended to serve as a tutorial and template for authors to use when writing their own AAS Journal articles.
  The manuscript includes a brief overview of AASTyp and documents its capabilities, especially as compared to the equivalent LaTeX version, AASTeX.
  It includes several figure and table examples to illustrate these features.
  The content of this manuscript has either been taken directly or adapted from the official AASTeXv7 template.
  AASTyp is a work in progress and contributions from the community are always welcome.
]

// The list of UAT keywords should be copy-pasted directly from https://astrothesaurus.org/concept-select/.
// AASTyp will automatically generate links to the relevant UAT pages.
#let keywords = "Galaxies (573), Cosmology (343), High energy astrophysics (739), Interstellar medium (847), Stellar astronomy (1583), Solar physics (1476)"

#show: template.with(
  // These positional arguments are required:
  title,
  authors,
  abstract,
  keywords,

  // These keyword arguments are optional, shown here for tutorial purposes:
  line_numbers: false, // False by default
  two_column: false, // False by default
  collab: collab, // None by default (can be any content)
  short_title: short_title, // None by default (can be any content)
  watermark: none, // None by default (can be any content)
)

// This is where the main body of the manuscript begins.

= A Brief Introduction to AASTyp
Typst #footnote[#link("http://www.typst.app/")] is an open-source, markup-based typesetting language created as a alternative to traditional TeX-based systems #cite(<Mädje2022>) #cite(<Haug2022>).
It was initially written in 2019 by Laurenz Mädje and Martin Haug as a hobby project but has since been adopted by tens of thousands of users.
Although not as mature or well-established as LaTeX, Typst's user-friendly syntax, robust scripting capability, and quick compilation time make it a powerful tool for scientific writing.
In April 2025, the International Journal of Interactive Multimedia and Artificial Intelligence (IJIMAI) became the first journal to not only accept Typst submissions, but to also maintain an official template #footnote[#link("https://typst.app/universe/package/ijimai/")].
While larger journals (including the AAS Journals) might take more time to adopt Typst at scale alongside LaTeX, this example manuscript serves as a proof-of-concept for such future publications.

AASTyp's design was heavily inspired by the official AASTeX template #footnote[#link("https://journals.aas.org/aastex-package-for-manuscript-preparation/")] for LaTeX submissions to the AAS Journals, with additional guidance drawn from the AAS Style guide (#link("https://journals.aas.org/aas-style-guide/")) and from emulating publicly available articles.
It aims to replicate both the stylistic layout and utility features (table formatting, anonymization, toggleable line numbering, etc.) of the original version, while leveraging Typst's modern framework.
AASTeX has been in development since 1988 and the v7 class file (written by Aptara #footnote[#link("https://www.aptaracorp.com/")] in 2024) has almost 14,000 lines.
Therefore the goal of this project is not to translate AASTeX line-by-line, but rather to write a comparable edition from the ground up.
AASTyp does not depend on any third-party libraries or packages.

#figure(
  placement: top,
  scope: "parent",
  image("assets/AuthorChargeInfographic.png"),
  caption: [
    The AAS journals are operated as a nonprofit #footnote[Not the best business model] venture, and author charges fairly recapture costs for the services provided in the publishing process.
    The chart above breaks down the services that author charges go toward. The AAS Journals' Business Model is outlined in a #link("https://aas.org/posts/news/2023/08/aas-open-access-publishing-model-open-transparent-and-fair")[2023 post].
  ],
)
<author_charges>

The rest of this article provides information and examples on how to create your own AAS Journal manuscript with AASTyp.
The next section describes some of the different manuscript style options available.
@floats describes table and figure placement.
Specific examples of different tables are provided in @tables.
The last section, @cite, shows how to recognize software and external data as first class references in the manuscript bibliography.
An appendix is included for additional information readers might find useful.
Further documentation is embedded in the comments of this Typst file.

= Manuscript Styles <style>
The default style in AASTyp is a tight single column style, with an 11-point single-spaced font.
The single column style is very useful for articles with wide equations.
It is also the easiest style to work with since figures and tables (see @floats) will span the entire page, reducing the need to address float sizing.

To invoke a two column style similar to what is produced in
the published PDF copy, add this keyword argument to the template call:

```
two_column: true
```

// Here is an example of continuing a paragraph after a line break/equation:
#par(first-line-indent: 0em)[This option is set to `false` by default.]

All authors should have the `line_numbers` flag enabled so that the compiled PDF has each row numbered in the outer margin.
Line numbering is mandatory as it helps reviewers quickly identify locations in the text.

Multiple style options are allowed, e.g.

```
two_column: true
line_numbers: false
```

#par(first-line-indent: 0em)[See the Typst file for a complete list of style options.]

= Floats <floats>
Floats are non-text items that generally cannot be split over a page.
They also have captions and can be numbered for reference.
Primarily these are figures and tables but authors can define their own. Typst places these elements at the top or bottom of the parent container (i.e., the page), allowing them to span across all columns.

Authors are encouraged to embed their tables and figures within the text as they are mentioned.
Editors and the vast majority of referees find it much easier to read a manuscript with embedded figures and tables.

Depending on the number of floats and the particular amount of text and equations present in a manuscript the ultimate location of any specific float can be hard to predict prior to compilation.
It is recommended that authors *not* spend significant time trying to get float placement perfect for peer review.
In the case of AASTeX, the AAS Journal's publisher has sophisticated typesetting software that will produce the optimal layout during production.

Note that authors of Research Notes are only allowed one float, either one table or one figure.

== Tables <tables>
AASTyp does not currently support custom tables (similar to AASTeX's `deluxetable`), although they are a planned feature.
However, tables like @description_table can be constructed using Typst's standard table environment.

// TODO: A lot. Eventually want custom table similar to AASTeX's deluxetable
#let flux_unit = [$10^(-17)$ erg s#super[-1] cm#super[-2]]
#figure(
  placement: top,
  scope: "parent",
  caption: [
    Descriptive version of the "Measurements of Emission Lines" table
  ], // FIXME: Center-align caption
  table(
    columns: 4,
    rows: (2em, 1.25em),
    align: (x, y) => (
      horizon
        + {
          if y >= 1 {
            if x == 0 { right } else { left }
          } else { center }
        }
    ),
    stroke: (x, y) => {
      if y == 0 { (top: 1pt, bottom: 0.5pt) } // TODO: Replace 1pt line with double line
    },
    table.header([Number], [Units], [Label], [Explanation]),
    [1], [---], [Model], [Model identifier],
    [2], [---], [Component], [Component identifier],
    [3], [km s#super[-1]], [Shift], [Line shift],
    [4], [km s#super[-1]], [FWHM], [Line Full-Width at Half-Maximum],
    [5], [#flux_unit], [Ly$alpha$], [Ly$alpha$ line flux],
    [6], [#flux_unit], [N V], [N V line flux],
    [7], [#flux_unit], [Si IV], [Si IV line flux],
    [8], [#flux_unit], [C IV], [C IV line flux],
    [9], [#flux_unit], [Mg II], [Mg II line flux],
    [10], [#flux_unit], [H$gamma$], [H$gamma$ line flux],
    [11], [#flux_unit], [H$beta$], [H$beta$ line flux],
    [12], [#flux_unit], [H$alpha$], [H$alpha$ line flux],
    [13], [#flux_unit], [He I], [He I line flux],
    [14], [#flux_unit], [Pa$gamma$], [Pa$gamma$ line flux],
    // TODO: Increase spacing between last row and hline
    table.hline(stroke: 0.5pt)
  ),
)
<description_table>

== Figures <figures>
Authors can include a wide number of different graphics with their articles.
These range from general figures that all authors are familiar with to new enhanced graphics that can only be fully experienced in HTML.
The latter include figure sets, animations and interactive figures.
All enhanced graphics require a static two dimensional representation in the manuscript to serve as an example for the reader.
All figures should include detailed and descriptive captions.
These captions are absolutely critical for readers for whom the enhanced figure is inaccessible either due to a disability or offline access.
This portion of the article provides examples for setting up all these types in with the latest version of AASTyp.

=== General Figures <general>
// TODO: Document how figure floating works
@author_charges is an example which shows how AAS Publishing spends author publication charges.

=== Enhanced Graphics
Enhanced graphics have an example figure to serve as an example for the reader and the full graphical item available in the published HTML article.
These include figure sets, animations, and interactive figures.
The Astronomy Image Explorer (#link("http://www.astroexplorer.org/")) provides access to all the figures published in the AAS Journals since they first offered an electronic version in the mid-1990s.
You can filter image searches by specific terms, year, journal, or type.
The type filter is particularly useful for finding all published enhanced graphics.
As of August 2024, there are over 5600 videos, 2200 figure sets, and 200 interactive figures.

= Software and Third Party Data Repository Citations <cite>
The AAS Journals would like to encourage authors to change software and third party data repository references from the current standard of a footnote to a first class citation in the bibliography.
As a bibliographic citation, these important references will be more easily captured and credit given to the appropriate people.

The first step to making this happen is to have the data or software stored in a long-term repository that makes them available via a persistent identifier like a Digital Object Identifier (DOI).
A list of repositories that satisfy this criterion (including their pros and cons) is given at #link("https://github.com/AASJournals/Tutorials/tree/master/Repositories").

In the bibliography, the format for data or code looks like this:

\

#par(first-line-indent: 0em)[author year, title, version, publisher, prefix:identifier]

\

#cite(<Corrales2015>, form: "prose") provides an example of how the citation in an article references the external code at #doi("10.5281/zenodo.15991").
Unfortunately, BibTeX does not have specific entries for these types of references, so the "\@misc" type should be used.

Authors can also use the website #link("https://www.doi2bib.org") to create a BibTeX entry for any DOI.
Please check the output from this site carefully as its output is only as good as the DOI metadata.
Some DOI creators do not provide enough metadata to construct an adequate citation.

// TODO: anonomyize acknowledgement/contribution sections when the "anonymous" style option is used

#v(2em)

#heading(level: 1, numbering: none)[Acknowledgements]
AASTyp was made with Typst, an open-source typesetting language.

#v(2em)

// This section gives authors the space to recognize author contributions.
// Authors can use the Contributor Role Taxonomy (CRediT) at https://credit.niso.org for ideas on how write a good statement tailored to their needs.
#heading(level: 1, numbering: none)[Author Contributions]
All authors contributed equally to the #collab collaboration. // At minimum, this text is required.
// Further elaboration (as shown below) is also expected.
SC was responsible for writing and submitting the manuscript.
WWM came up with the initial research concept and edited the manuscript.
OTS obtained the funding and edited the manuscript.
EBF provided the formal analysis and validation. He also edited the manuscript.
GEH Supervised the undergraduates, wrote the software and administers the project GitHub and Zenodo repositories.

#v(1em)

// To help institutions obtain information on the effectiveness of their telescopes the AAS Journals has created a group of keywords for telescope facilities.
// Following the acknowledgments section, use the following syntax and the `#facilities()` function to list the keywords of facilities used in the research for the paper.
// Each keyword is checked against the master list during copy editing.
// Individual instruments can be provided in parentheses, after the keyword, but they are not verified.
#facilities(("HST (STIS)", "Swift (XRT and UVOT)", "AAVSO", "CTIO: 1.3m", "CTIO: 1.5m", "CXO"))

#v(1em)

// Similar to #facility(), there is the optional #software() command to allow authors a place to specify which programs were used during the creation of the manuscript.
// Authors should list each code and include either a citation or url to the code inside ()s when available.
#software((
  [astropy #cite(<Astropy2022>)],
  [Cloudy #cite(<Cloudy2013>)],
  [Source Extractor #cite(<Bertin1996>)],
))

// FIXME: Is there a way to avoid the pagebreak before the appendix? Especially in two column mode.

// Appendix material should be preceded with a single `#show: appendix` command.
// There should be a heading for each appendix.
// Mark appendix subsections with the same markup you use in the main body of the paper.
//
// Each Appendix will be lettered A, B, C, etc.
// The equation counter will reset when it encounters the `#show: appendix` command and will number appendix equations (A1), (A2), etc.
// The figure and table counters will not reset.
#show: appendix

#heading(level: 1, numbering: none)[Appendix]
#v(1em)

= Appendix Information
Appendices can be broken into separate sections just like in the main text.
The only difference is that each appendix section is indexed by a letter (A, B, C, etc.) instead of a number.
Likewise numbered equations have the section letter prepended.
Here is an equation as an example.

$
  E = sqrt(m c^2 + p^2 c^2)
$

Appendix tables and figures should not be numbered like equations.
Instead they should continue the sequence from the main article body.

= Author Publication Charges <pubcharge>
In April 2011 the traditional way of calculating author charges based on the number of printed pages was changed.
The reason for the change was due to a recognition of the growing number of article items that could not be represented in print.

Now author charges are determined by a number of digital "quanta".
A single quantum is defined as 350 words, one figure, one table, and one digital asset.
For the latter, this includes machine readable tables, data behind a figure, figure sets, animations, and interactive figures.
The current cost for the different quanta types is available at #link("https://journals.aas.org/article-charges-and-copyright/#author_publication_charges").
Authors may use the ApJL length calculator to get a `rough` estimate of the number of word and float quanta in their manuscript.
The calculator is located at #link("https://authortools.aas.org/ApJL/betacountwords.html").

// TODO: 2 column bibliography
#v(2em)
#bibliography("sources.bib", title: "References")
