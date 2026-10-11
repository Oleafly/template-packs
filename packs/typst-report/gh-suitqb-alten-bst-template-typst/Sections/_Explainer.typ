// Explainer Section

#import "../Utilities/style.typ": attention-box, example-box

Welcome to ALTEN's Innovation Department (DIN) Typst BST (Bilan Scientifique et Technique) Template.

== What is a BST?

A BST, which translates to _Scientifical and Technical Report_, is a report that thoroughly documents the activities carried out within the scope of a R&D project at ALTEN.

Indeed, within your project, the documentation of the work will be an ongoing concern. Each phase of the study must be documented and will be the subject of deliverables, the number of which will vary according to the phase.

All the _relevant_ work carried out must be summarized and presented in the research report, which is the subject of this document.

The research report will be structured around a description of:
- the context of your research (industrial, technical, economic, regulatory, etc.), and the associated issues;
- the problem and associated scientific and technical uncertainties;
- the state of the art and its critique;
- the proposed approach to solve the identified limitations of the state of the art;
- a description of the work carried out, the solutions considered and chosen;
- the results of the work carried out (performance achieved in particular).

For more details on what a BST is and why it is important within the DIN, don't hesitate to ask to your Innovation Pilot or Valorisation Pilot.

=== Description of the Sections
You will find a description of the different sections directly within the document as introduction paragraphs.

== Important Notes

=== Writing Style
This report is an ALTEN R&D document, and must not be intended as a personal report. As such, its writing style must remain corporate and rigorous. Hence:

- In the text, use the 1st person plural (_we_).
- Avoid quoting ALTEN, which is generally implicit.
- No reference should be made to:
  - The name of the author;
  - Its role within the company;
  - The context in which the project was developed (internship, etc.);
  - More generally, to all considerations relating to the author.

Briefly, *don't* use _I_ statements: the document shall provide an objective (hence, not subjective) overview of a R&D operation. Consider that, whilst this kind of reports might be assigned within the context of an internship, reformatting and further modifications of the document will occur. For example, experiments from other labs / teams might be included in a further version of the document. This is why there's no single author on the cover page and an impersonal writing style is to be used.

=== Scope of the Research Report
The research report will contain only technical information and no managerial information on the project (planning, human resources, difficulties linked to lack of experience, etc.).

=== Bibliography and Citations

In general, when producing a scientific report, proper citations and bibliography management are a fundamental pillar for its production.

In the context of this BST, the section that will draw on a large number of documentary references is the State of the Art (i.e. too few sources makes the quality of this state of the art report suspect). You take precise information from these sources, and use them to both describe the current state of the art and support your analysis. These sources *must appear without exception in your bibliography*. To do so, a citation must be included within your text that references the original source.

#attention-box[
  *Plagiarism*: avoiding to cite original work is plagiarism, which is a criminal offense. Consider that, more than the moral implications of such choice, while within ALTEN no automated analysis of your work is done to check for plagiarism, the same cannot be said for your school report #link("https://example.com")[Mon site web]. Therefore, consider that:

  - All external work you base your analysis upon MUST be cited.
  - The sentence or paragraph containing the sourced information *cannot* (!) be a simple quote. It must be a synthesis, summary or reformulation of the passage or information presented in the source.
  - The only exception can be for definitions, where the text can be reported without modification if used as is through your document (but still, requires citation of the source).
]


#example-box[
  *Examples*
  - As clarified by @bozdag2018, the right to *data portability* is a digital right enforced by GDPR that requires...
  - Several studies focused on the topic of the right to data portability @bozdag2018 @wang2019.
]

*Citation Style:* For this document, we use an APA-like standard for citations. The style of citation is defined in the `main.typ` file.

*Bibliography Management:* Zotero can be used to manage bibliographic references and integrate them into the document. This tool allows you to:
- Collect all your sources within folders.
- Export your collection of sources in a `bib` format. This export should be placed in the `Utilities/Bibliography.bib` so that your Typst document can reference such resources accordingly.

=== ALTEN Research Report vs School Report

This research report is *not* meant to replace your internship report/thesis, although they might share many elements. Any constraints defined by the School on the formalization of the internship report (page limits, exclusion of certain information, etc.) generally don't apply to the research report, as the intended audience and scope is different.

Yet, consider that the latter is generally obtained easily from the research report:
- By adding a _Chapter 0_ (Presentation of the internship) describing:
  - the environment (ALTEN and R&D management);
  - context (program, sub-program);
  - progress: Alten R&D methodology, approach/planning;
- By synthesizing/complementing the research report, if necessary, to adapt to school constraints.

#attention-box[
  See this report as an *opportunity* to produce most of the parts required by your internship report / thesis _within_ working hours, rather than during your personal time.
]

== Typst

This template has to be intended as is: a template. If this is your first experience with Typst, there are plenty of great resources that might help you get up to speed:

- #link("https://typst.app/docs")[Typst Documentation] - Official comprehensive documentation
- #link("https://typst.app/docs/tutorial/")[Typst Tutorial] - Great tutorial for beginners
- #link("https://github.com/qjcg/awesome-typst")[Awesome Typst] - Curated list of Typst resources

=== Installing Typst

*Requirements:* To use Typst locally, you need to install it on your computer.

- Download and install Typst from the #link("https://github.com/typst/typst/releases")[official GitHub releases page]
- Or use a package manager:
  - Windows: `winget install --id Typst.Typst`
  - macOS: `brew install typst`
  - Linux: Check your distribution's package manager

=== Editors

*VSCode:* You can use VSCode with the Typst LSP extension for a great editing experience with syntax highlighting, autocompletion, and live preview.

*Typst Web App:* For quick editing, you can use #link("https://typst.app")[typst.app], though note that company confidential information should not be stored on external servers.

*Other editors:* Typst also works well with various text editors. Check the official documentation for setup guides.

=== How to use this Typst template

The template is structured as follows:
- `main.typ` file: the main document file that imports all sections and defines the document structure
- `Utilities/` folder: contains utility files:
  - `style.typ`: document styling and custom functions
  - `cover.typ`: cover page template
  - `Bibliography.bib`: bibliography file in BibTeX format
  - `Glossary.typ`: glossary definitions
- `Sections/` folder: contains all document sections as separate files
- `Images/` folder: contains all images used in the document

=== Typst Best Practices

*References and Labels:*
- Use the `label` function to create references: `== My Section <sec:my-section>`
- Reference sections with `@sec:my-section`

*Images:*
- All images should have captions using the `caption` parameter
- Example: `#figure(image("path.png"), caption: [Your caption])`

*Tables:*
- Typst makes tables much easier than LaTeX
- Use `#table()` for simple tables

*Citations:*
- Use `@key` syntax for citations
- Keys are defined in your `Bibliography.bib` file
- Example: As expressed in @bozdag2018, ...

*Code Blocks:*
- Inline code: `` `code` ``
- Code blocks: use triple backticks with language specification
