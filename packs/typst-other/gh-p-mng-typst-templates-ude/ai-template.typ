#import "ai-template/ai-template.typ": ai_template

#show: ai_template.with(
  // see `ai-template/ai-template.typ` for possible values
  // ...
)

= Introduction

The introduction *must* contain the following:

#list(
  marker: "-",
  "Motivation and importance of the research topic",
  "360 degree overview of related literature",
  "Derivation of research gap(s)",
  "Derivation of research approach",
  "Formulation of the research question(s)",
  "Own contribution (theoretical and practical)",
  "Structure of the thesis (the structure of the thesis should only be described very briefly)",
)

It is *not* usual to subdivide the introduction, so please do *not* subdivide the introduction into subsections.

It has proven helpful to compare the introduction with the abstract and the conclusion sections. This ensures that their content matches in terms of objectives and motivation. The scope of the introduction should be approx. 5 % of the entire thesis.

= Foundations

Directly below each main section, there is space for a brief introduction to the content.

In the foundation's section, important terms, concepts, frameworks, etc., are introduced and defined.

== Outline

The heading structure is hierarchical. The section headings are defined in the style sheets by name as heading 1, heading 2, etc.

Please do *not* use a fourth-level heading.

== Figures and Tables

Figures are *always* inserted centered, with a name and, if applicable, a source.

#figure(caption: "Figure name (Source if applicable)", image("ai-template/figures/ude_figure_example.png")) <ude>

It is important to always *explain* figures in the text and to refer to the figures in the text (see @ude). This also applies to tables. In the case of third-party figures and tables, the original source must also be indicated (e.g., in brackets at the end of the title). Tables should also be centered and labeled (see @some-table).

Please ensure that the font, color and style of figures and tables are *consistent*.

#pagebreak()

#figure(caption: "Table name (Source if applicable)", table(
  columns: (1fr, 1fr, 1fr, 1fr, 1fr),
  rows: 2,
  " ", " ", " ", " ", " ",
  " ", " ", " ", " ", " ",
))<some-table>

Format template for listings and numbering with multiple levels:

- First level
  - Second level
    - third level

== Content

Your text should be divided into paragraphs using figures and tables. It should be noted that a paragraph captures a thematic idea, whereby the core statement is usually found at the beginning of the paragraph and, from this, is structured by further discussions within the paragraph.

= Related Work

This section summarizes the results of other research related to your work. In addition to the textual description, please also use tables for this purpose.

*Note*: The identified research results should be discussed in the discussion section with the results of the thesis.

The Chair of Information Systems and Artificial Intelligence in Marketing uses the *7#super[th] edition of the citation style of the American Psychological Association (APA)*.

In order to give you an insight into how to cite appropriately in your thesis, the following lines serve as an orientation guideline for the citation system. Adhering to the subsequent citation rules is vital to crafting a successful and adequate paper. For clarification purposes, several examples are shown in the further procedure.

== Indirect Citations at the end of a sentence

If you write a statement or argument in your thesis which is based on the idea or result from another author, you will have to state the author at the end of the sentence. The style of a reference to other scientific work is often not dependent on the type of publication but rather determined by the number of authors.

=== Single author

Theory of mind enables the prediction of others' behavior beyond familiar patterns, especially in cases involving unfamiliar or mistaken actions (Liszkowski, 2013).

=== Two authors

Support for the universality thesis requires that facial expressions of basic emotions are consistently recognized across cultures with high accuracy rates (Nelson & Russell, 2013).

=== More than two authors

Young children's early prosocial behavior may stem from their innate interest in others, early imitative tendencies, or emerging capacity to understand others' emotional states (Svetlova et al., 2010).

== (Indirect) Inline citation style

If you highlight a result or an idea of some other authors, you can also use inline citations. Make sure that the reference is positioned close to the actual idea of the author(s).

=== Single author

Tallon (2008) reports also that the primary locus of alignment within the firm (the process where alignment is highest) varies based on differences in strategic foci and so alignment is rarely the same in any two firms.

=== Two authors

Based on the results of our pilot study and comments from a panel of three IS academics, we adapted 12 of the 20 survey items used by Byrd and Turner (2000) to assess IT infrastructure flexibility: four items per construct.

=== More than two authors

As noted by Chin et al. (1996), moderation can then be modeled using a main and interaction effect; the main effect linking IT flexibility to agility need not be interpreted directly.

== Direct Citations

In addition, for direct citations for which you cite a complete thought you have to indicate this by using quotation marks. For those cases, you also have to specify page numbers. These rules must be applied no matter what you cite (e.g., journals, conferences, books). The style for direct citations is demonstrated by the following examples:

=== Direct citation of entire sentences

"The recipe comprises necessary conditions and probabilistic processes in the following sequence: organizations spend on IT and, subject to the varying degrees of effectiveness during the IT management process, obtain IT assets. […] Favorable IT impacts, if not adversely affected during the competitive process, lead to improved organizational performance." (Soh & Markus 1995, p. 39).

Note: With "[…]" you highlight that you left out information originally contained in the citation but less relevant for your thesis. The meaning must not be changed by using this technique.

=== Direct citation of single information in a sentence

The improvement of organizational performance can be achieved by creating "favorable IT impacts" (Soh & Markus 1995, p. 39).

= Research Method

== Section 4.1

=== Section 4.1.1

For Bachelor's and Master's theses, a subdivision up to the third level makes sense. A fourth level (e.g., 4.1.1.1) must be omitted in order to maintain the clarity of the structure. Use subheadings instead.

#heading(numbering: none, level: 3, outlined: false, "Subheading")

=== Section 4.1.2

Important: If you also structure 4.1.1 under 4.1, a subheading 4.1.2 is automatically required, as a subheading alone is not permitted.

== Section 4.2

=== Section 4.2.1

=== Section 4.2.2

= Results

It is of major importance to present the results of your research in detail. Therefore, this section should be the main part of your thesis.

= Discussion

Your results must not only be presented, but also discussed. Emphasize the (theoretical
and practical) impact of your work on the research area in question (also in relation to the
results mentioned in the related work section). At the end, do not forget to discuss the
opportunities for future work and the limitations of your work.

== Theoretical Implications

== Practical Implications

== Future Work

== Limitations

= Conclusion

The conclusion is where you wrap up your ideas and leave the reader with a strong final impression. It has several key goals:

- Restate the problem statement addressed in the thesis
- Summarize your overall arguments or findings
- Suggest the key takeaways from your paper

The conclusion should be compared with the abstract (if applicable) and the introduction. Similar to the introduction, the conclusion should make up about 5% of the entire thesis. Please do not forget to check the spelling of the entire thesis. You need to write your thesis in English. Please use “American English”.

#cite(<brownell2016>, form: none) #cite(<brownell2013>, form: none)

#bibliography("ai-refs.bib", title: "References", style: "apa")
