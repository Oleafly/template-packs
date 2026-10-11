= How to use the templates <ch-2>

This is a practical guide into how to use this template, by explaining the role of the different folders, and an option of `thesis(...mode)` property, which accepts either `draft` or `submission`.

#heading(level: 2, "Folders") // you can also write here "== Folders"

The main folder contains three folders detailed here:

- *images.* This folder should contain all the images that you will use in your thesis. It can contain subfolders, for example one for each chapter. To include an image from the main text, you can use the command `#figure(image("path/to/image.jpg", width: 30%))`. The path is relative to the main folder, so if you want to include an image from the images folder, you can write:
```typ
#figure(
  image("../images/chap3/emblem.jpg", width: 30%),
  caption: [Full caption with all the details here.font size has to be 10pt, and sentences has to be left side.],
) <fig-example>
```

- *chapters.* This folder contains a series of #raw("LaTeX") files that form the main text: introduction, chapters, conclusion, appendices and published articles. The introduction and conclusion as they are now are not numbered, which creates a few difficulties with the headers of the thesis. If you want the introduction and conclusion to be numbered, re-write and treat them as regular chapters. These text files are included in the main text of the thesis with the command `#include "chapters/filename.typ"` in the `./main.typ`. 
```typ
// main.typ
// Main chapters
#include "chapters/introduction.typ"
#include "chapters/chapter1.typ"
#include "chapters/chapter2.typ"
#include "chapters/chapter3.typ"
#include "chapters/conclusion.typ"
```

- *preamble.* This folder contains a series of typst files with the pages that will appear before the main text. Please write (or copy and paste) your own text in those files and delete the dummy text when appropriate. The files are:
  - `abbreviations.typ` --- List of abbreviations. If the list goes over one page, continue it as a new list on the next page.
  - `abstract.typ` --- Abstract. Follow directions in the file.
  - `acknowledgments.typ` --- Acknowledgments. Follow directions in the file.
  - `declaration.typ` --- Declaration of Original and Sole Authorship. Only modify the last item and the signature. See @sec-declaration.
  - `declaration_ai_tools.typ` --- Declaration on the Use of AI Tools. State which generative AI tools you used and for what. Delete the file and its `#include` line if you used none.
  - `dedication.typ` --- Dedication (optional). Should only be a very few lines.
  - `glossary.typ` --- Glossary (optional). If the list goes over one page, continue it as a new list on the next page.
  - `nomenclature.typ` --- Nomenclature (optional). If the list goes over one page, continue it as a new list on the next page.
  - `publications.typ` --- List of Publications and Presentations (optional). Each entry can carry a `#contrib[...]` line stating your own contribution, and conference entries can be tagged with `#entry_type("Oral")` or `#entry_type("Poster")`. All spacing knobs are defined at the top of the file.

== main.typ file

This is #strong[the main file], the only one that needs to be compiled to build the thesis. The thesis function is executed at the top of this file. When submitting to a graduate school, compile with the `mode` parameter set to `"draft"`.
```typ
#show: doc => thesis(
  title: "Typst Dissertation Template",
  author: "Kazuma takada",
  supervisor: "S. Upervisor",
  cosupervisor: "C. O'Supervisor",
  submission_date: "August 2025",
  mode: "draft",
  colored_refs: false,
  doc,
)
```
When you submit a temporary version to the graduate school, compile with `"submission"` parameter.

`colored_refs` controls the colour of citations and cross-references. It is `false` (black) by default, which is what you want for the printed and submitted versions. Set it to `true` while writing to get blue, clickable citations and cross-references, which makes it much easier to navigate a long draft on screen.

== Declaration page and signature <sec-declaration>

The declaration page pulls the title, author, and submission date straight from `thesis(...)`, so you never retype them. Two things do need editing:

- The last confirmation item lists every publication or preprint that overlaps with the thesis, together with a `Contribution:` line for each. If none of your work has appeared elsewhere, delete the nested list and shorten the sentence. If a co-author's work appears in the thesis, obtain a signed release from every affected co-author, attach it to both submitted versions as a separate document, and state here that authorization has been obtained.
- The signature. The template ships a placeholder at `images/signature.svg`. Replace it with a scan of your own signature --- any format Typst reads (SVG, PNG, JPG, PDF) works --- and adjust `height` in `preamble/declaration.typ` if needed. Note that the whole block has to fit under the publication list, so a taller signature may push it onto a second page.

=== Page size, Margins, Spacing, Justification, and Pagination

These settings are all defined in `./oist_thesis.typ`. They should not be changed.

#set quote(block: true)
#quote(attribution: [OIST, Graduate School Policies#footnote[#link("https://www.oist.jp/education/policies-regulations/gs-policies")]])[
  _*Page size*: Theses are to be formatted to A4 page size._

  _*Margins*: The left margin should be 3 cm.  Top, right, and bottom margins should be 2.5 cm._

  _*Spacing*: Spacing should be 1.5 line spaced for examination and single spacing for final submission._

  _*Justification*: The main body of text left-right justified.  Titles should be left-justified.  Equation numbers should be right justified._

  _*Pagination*: Preliminary pages, ending before the main body of text, may be numbered sequentially using roman numerals.  The main body of text, beginning with the first page of the introduction, must be numbered sequentially, including figure pages and blank pages, starting at page number 1 for the first page of the introduction.  Arabic numerals are to be used._
]

#heading(level: 3, "Table of Contents, List of Figures, List of Tables") // you can also write here "=== Packages and other document configurations"

These settings are for displaying the outline of the chapters, tables, and figures that will appear in the paper. Basically, there is no need to change them.

=== Title Page

The title page is defined by the `#let title_page()` function in `./oist_thesis.typ`. Basically, there is no need to change it.

=== Preamble Pages

The page numbering settings are specified at the end of the `thesis()` function in `./oist_thesis.typ`. No changes are necessary.

=== Thesis Main Text

The main text is *Times New Roman 12pt*. This definition is specified as `set text(font: "Times New Roman", lang: "en", size: 12pt)` in the `thesis` function of `./oist_thesis.typ.` This is strictly defined in OIST policy as following.

#set quote(block: true)
#quote(attribution: [OIST, Graduate School Policies#footnote[#link("https://www.oist.jp/education/policies-regulations/gs-policies")]])[
  _*Font*: Times New Roman, 12-point font should be used for all main body text.  For graph legends, titles, image annotations, etc., Arial, Helvetica or Calibri, 10-point font, should be used for presentation clarity.  For headings, any font or size may be used for presentation and design considerations._
  
  ...
  
  _*Spelling*: American spelling._
]

=== Bibliography

References should be listed in bibliography.bib. Paste them in bibtex format. Please see the example below. When referencing literature in typst, write it as shown in `@Lee98`. This template uses APA style, but if you want to use another style such as IEEE, please change it in `./oist_thesis.typ`. If you want to cite multiple references side by side, please write them as shown in `@Heald2021-el @Wen2022-ga @Takada2023-du`. result will be a single reference @Shimizu2023-ox, multile references will be shown as @Heald2021-el @Wen2022-ga @Takada2023-du.

```bibtex
@article{Lee98,
	Author = {Lee, Hwang and Scully, Marlan},
	Issn = {0015-9018},
	Issue = {4},
	Journal = {Found. Phys.},
	Pages = {585-600},
	Publisher = {Springer Netherlands},
	Title = {The Physics of EIT and LWI in V-Type Configurations},
	Url = {http://dx.doi.org/10.1023/A:1018709621908},
	Volume = {28},
	Year = {1998}}
```
There are various citation styles, such as APA, Chicago, and IEEE. This template uses APA. If you want to change the citation style, change the `set bibliography(style: "apa", title: "Bibliography")` style parameter in `./oist_thesis.typ`.

#heading(level: 3, "Appendices") // you can also write here "=== Appendices"

Structures the style for the appendices and builds them. The appendices are numbered with letters but are structured like regular chapters.

Wrap the body of every appendix file in `#appendix("<letter>")[...]`. The letter drives all the numbering inside the block: sections become `A.1`, `A.1.1`, and figures and tables become `Figure A.1`, `Table A.1`. Every counter restarts for each appendix, so Appendix B starts again at `B.1`. All figures and tables of an appendix must sit inside the block for this to apply.

```typ
#import "../oist_thesis.typ": appendix, custom_figure

#appendix("A")[
#heading(level: 1, numbering: none, "Appendix A: First Appendix") <appendix-a>

== A Section Inside an Appendix
...
]
```

=== Published Articles

This last section add the PDF files of your previously published articles (or about to be published) to the thesis. You should only include PDF files provided by the publishing journal (*including preprint*). This is strictly for the examiners' convenience in the temporary bound thesis, as for copyright reasons these files may not be published in the final version of the thesis.

Use `#embed_pdf("path/to/article.pdf", 15)` to drop all 15 pages of an article into the thesis full-bleed, with no margins or header. Precede it with `#published_article_cover(...)` to generate a cover page carrying the article number, its title, the full citation rendered from `bibliography.bib`, a pointer to the corresponding chapter, and the publisher's copyright notice.

```typ
#published_article_cover(
  number: "1",
  title: "Title of the published article",
  bib_key: <Lee98>,
  related_chapter: <ch-2>,
  license: "Reproduced with permission from ...",
)
#embed_pdf("published_pdf/study1.pdf", 15)
```

PDFs are large, so keep them out of git (the shipped `.gitignore` already excludes `*.pdf`) and guard the calls with a build flag in `main.typ` so the thesis still compiles on a machine that does not have them:

```typ
#let embed_published_pdfs = false
...
#if embed_published_pdfs {
  embed_pdf("published_pdf/study1.pdf", 15)
}
```

=== Differences between draft and submission modes

The `thesis(...mode)` property accepts either `draft` or `submission`. The `draft` mode is used for review, while the `submission` mode is used for the final version of the thesis.

The main difference is the spacing between lines. Therefore, it is likely that the appearance will differ from draft mode, so adjustments may be necessary before submission.

#set quote(block: true)
#quote(attribution: [OIST, Graduate School Policies#footnote[#link("https://www.oist.jp/education/policies-regulations/gs-policies")]])[
  _*Spacing*_ : Spacing should be 1.5 line spaced for examination and single spacing for final submission.
]
