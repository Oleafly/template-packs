#import "@preview/cap-able:0.0.1": *
#import "../style/default_set.typ": *

#figure(
  image("../images/figure_1.png", width: 100%),
  caption: [
    Example of caption.It is set in Roman so that mathematics (always set in Roman: $B sin A = A sin B$) may be included without an ugly clash.
  ],
  // scope: "parent",
  placement: top,
)<fig:1>


= Formatting your paper
<sec:formatting>
All text must be in two-column format.
The total allowable size of the text area is $6 frac(7, 8)$ inches (17.46 cm) wide by $8 frac(7, 8)$ inches (22.54 cm) high.
The columns should be $3 frac(1, 4)$ inches (8.25 cm) wide, with a $frac(5, 16)$ inch (0.8 cm) space between them.
The main title (on the first page) should begin 1 inch (2.54 cm) from the top edge of the page.
The second and following pages should begin 1 inch (2.54 cm) from the top edge.
On all pages, the bottom margin should be $1frac(1, 8)$ inches (2.86 cm) from the bottom edge of the page for $8.5 times 11$-inch paper;
for A4 paper, approximately $1 frac(5, 8)$ inches (4.13 cm) from the bottom edge of the
page.

== Margins and page numbering

All printed material, including text, illustrations, and charts, must be kept
within a print area $6 frac(7, 8)$ inches (17.46 cm) wide by $8 frac(7, 8)$ inches (22.54 cm)
high.
%
Page numbers should be in the footer, centered, and $frac(3, 4)$ inches from the bottom of the page.
The review version should have page numbers, yet the final version submitted as camera ready should not show any page numbers.
The LaTeX template takes care of this when used properly.

#place(auto, scope: "parent", float: true)[
  #capsubfig(
    (
      (
        content: image("../images/image_2-1.png", width: 100%),
        subcaption: [An example of a subfigure.],
        label: <fig:2:a>,
      ),
      (
        content: image("../images/image_2-2.png", width: 45%),
        label: <fig:2:b>,
      ),
    ),
    columns: 2,
    show-subcaption: false,
    caption: [Example of a short caption, which should be centered.Example of a short caption, which should be centered.],
    label: <fig:2>,
    label-mode: "overlay",
    label-size: confFontSize.small,
    label-bg: blue.transparentize(80%),
    align: center,
  )
]
== Type style and fonts
Wherever Times is specified, Times Roman may also be used.
If neither is available on your word processor, please use the font closest in
appearance to Times to which you have access.

MAIN TITLE.
Center the title $1 frac(3, 8)$ inches (3.49 cm) from the top edge of the first page.
The title should be in Times 14-point, boldface type.
Capitalize the first letter of nouns, pronouns, verbs, adjectives, and adverbs;
do not capitalize articles, coordinate conjunctions, or prepositions (unless the title begins with such a word).
Leave two blank lines after the title.

AUTHOR NAME(s) and AFFILIATION(s) are to be centered beneath the title
and printed in Times 12-point, non-boldface type.
This information is to be followed by two blank lines.

The ABSTRACT and MAIN TEXT are to be in a two-column format.

MAIN TEXT.
Type main text in 10-point Times, single-spaced.
Do NOT use double-spacing.
All paragraphs should be indented 1 pica (approx.~$frac(1, 6)$ inch or 0.422 cm).
Make sure your text is fully justified---that is, flush left and flush right.
Please do not place any additional blank lines between paragraphs.

The captions of the figures and tables should be in 9-point Roman type as in @fig:1 and @fig:2.
Short captions should be centered.  Table captions should be above tables, while figure captions should be below figures.

Callouts should be 9-point Helvetica, non-boldface type.
Initially capitalize only the first word of section titles and first-, second-, and third-order headings.

FIRST-ORDER HEADINGS.
(For example, #text(size: confFontSize.large)[*1. Introduction*]) should be Times 12-point boldface, initially capitalized, flush left, with one blank line before and one blank line after.

SECOND-ORDER HEADINGS.
(For example, #text(size: confFontSize.normal)[*1.1. Database elements*]) should be Times 11-point boldface, initially capitalized, flush left, with one blank line before and one after.
If you require a third-order heading (we discourage it), use 10-point Times, boldface, initially capitalized, flush left, preceded by one blank line, followed by a period, and your text on the same line.

== Footnotes

Please use the footnotes#footnote[This is what a footnote looks like.
  It often distracts the reader from the main flow of the argument.] sparingly.
Indeed, try to avoid footnotes altogether and include necessary peripheral observations in the text (within parentheses, if you prefer, as in this sentence).
If you wish to use a footnote, place it at the bottom of the column on the page on which it is referenced.
Use Times 8-point type, single-spaced.

== Cross-references
For the benefit of author(s) and readers, please use the
#[
  #set math.equation(numbering: none)
  $ "\cref{...}" $
]
command for cross-referencing to figures, tables, equations, or sections.This will automatically insert the appropriate label alongside the cross-reference as in this example:
#block(spacing: 1em, inset: (left: 2em))[
  To see how our method outperforms previous work, see @fig:1 and @tab:example[Tab.].
  It is also possible to refer to multiple targets as once, #eg to @fig:1[Figs.] and @fig:2:a[].
  You may also return to @sec:formatting[Sec.] or look at @eq:also-important[Eq.].
]
If you do not wish to abbreviate the label, for example, at the beginning of the sentence, you can use
$ "\Cref{...}" $
command. Here is an example:
#block(spacing: 1em, inset: (left: 2em))[
  @fig:1 is also quite important.
]
#captab(
  caption: [Results. Ours is better],
  label: <tab:example>,
)[

  |Method|Forbnability|
  |---|---|
  |Theirs|Frumpy|
  |Yours|Fabulous|
  |Ours|Makes one's heart Frob|
]

== References

List and number all bibliographical references in 9-point Times, single-spaced, at the end of your paper.
When referenced in the text, include the citation number in square brackets, for
example@Authors14.
Where appropriate, include page numbers and the name(s) of editors of referenced books.
When citing multiple papers at once, make sure that you cite them in numerical order such as this @Alpher02@Alpher03@Alpher05@Authors14b@Authors14}.
If you use the template as advised, this will be taken care of automatically.

== Illustrations, graphs, and photographs
All graphics should be centered.
In LaTeX, avoid using the #textlink[center] environment for this purpose, as this adds potentially unwanted whitespace.
Instead, use
#[
  #set math.equation(numbering: none)
  $ "\centering" $
]
at the beginning of your figure.
Please ensure that any point you wish to make is resolvable in a printed copy of the paper.
Resize fonts in figures to match the font in the body text, and choose line widths that render effectively in print.
Readers (and reviewers), even of an electronic copy, may choose to print your paper in order to read it.
You cannot insist that they do otherwise and, therefore, must not assume that they can zoom in to see tiny details on a graphic.

When placing figures in LaTeX, it is almost always best to use #textlink[\\includegraphics], and to specify the figure width as a multiple of the line width as in the example below
#linebreak()
#textlink[
  \usepackage{graphicx} ... \
  \includegraphics[width=0.8\linewidth]\
  #h(9em){myfile.pdf}
]

== Color
Please refer to the author guidelines on the #confName #confYear web page for a discussion of the use of color in your document.

If you use color in your plots, please keep in mind that a significant subset of reviewers and readers may have a color vision deficiency; red-green blindness is the most frequent kind.
Hence, avoid relying only on color as the discriminative feature in plots (such as red #vs green lines), but add a second discriminative feature to ease disambiguation.