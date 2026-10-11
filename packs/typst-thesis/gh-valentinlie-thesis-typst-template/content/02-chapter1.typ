#import "../settings/wi-thesis.typ": *

= Template Manual <ch02:manual>

#sectionquestions[
  - What is the research question?
  - Which assumptions are made?
]

In the following, you will find some general information on how to use this
template as well as some tips on how to apply some features of Typst to write
not only a conclusive but also well-structured thesis. This is not meant as a
general manual on how to learn Typst, but to remind you of certain features and
to guide you.

One general hint: try to avoid a situation in which only 1 or 1 1/2 lines of a
paragraph are printed on the next page. These snippets can easily be missed by
your reader and it is no nice way of typesetting.

Typst hyphenates words automatically based on the language of your document.
Sometimes, words which are not known by Typst are separated wrongly or are
written on the margins of the page. You can insert a soft hyphen with `-?`
inside a word to show Typst where it may be separated properly, or disable
hyphenation for a single word with `#text(hyphenate: false)[word]`.

== Text Structure <ch02:sec1:structure>

When structuring an academic work in particular the criterion _completeness_
has to be observed. This, however, should be achieved without any redundancies
and overlap. The entire work should follow a common theme and each section, even
each argument, should logically follow this theme. Furthermore, the theme has to
be evident to readers, who should be able to know at any time whilst reading at
which point of the argument they are. In order to achieve this, it may be handy
to develop a continuous example throughout the writing.

In this thesis, the usual structures can be used: `=` starts a chapter, `==` a
section, `===` a subsection, and so forth. Depending on the length of your
thesis, it is not recommended to use more than these three subdivisions. In
order to refer to chapters, attach a label in angle brackets to them, e.g.
`= Template Manual <ch02:manual>`, and reference it with an `@` reference,
e.g., write `see @ch02:manual` to produce "see @ch02:manual". Typst
automatically inserts the capitalized name of the referenced thing (Chapter,
Figure, Table, ...) together with a non-breaking space for you. The same holds
for tables, figures, and equations.

In Typst, several markup shorthands and functions like `_text_` for _italic_,
`*text*` for *bold* text, `#smallcaps[text]` for #smallcaps[small caps],
`#underline[text]` for #underline[underlined text], or even `` `text` `` for
`typewriter text` can be used to highlight information. Please use only a
limited number of highlights and stick to one type of highlight for a specific
purpose!

Texts can further be structured by using lists. Bulleted lists (lines starting
with `-`), numbered lists (lines starting with `+` or an explicit number), and
term lists (lines starting with `/ term:`) also work in this template.

== Colours <ch02:sec2:color>

This template comes with the colors defined in the Corporate Design of the
University of Münster, ERCIS, and the Research Group CSSSA. @ch02:tab:colors
lists the color names and shows the resulting color. They are available in the
`wi-colors` dictionary, and you can apply them to text by using the
`#text(fill: wi-colors.wi-green1)[text]` command. If you want to use them in
other images or graphics, you will also find the hexadecimal codes below.

#let color-row(name) = (
  raw(name),
  text(fill: wi-colors.at(name), size: 14pt, sym.circle.filled),
  raw(wi-colors.at(name).to-hex().slice(1)),
)

#figure(
  table(
    columns: 6,
    stroke: none,
    align: (left, center, left, left, center, left),
    column-gutter: (auto, auto, 1cm, auto, auto),
    table.hline(stroke: 1pt),
    table.header(
      [*Color Name*], [*Result*], [*Hex Code*],
      [*Color Name*], [*Result*], [*Hex Code*],
    ),
    table.hline(stroke: 1pt),
    ..color-row("wi-green1"), ..color-row("wi-mud"),
    ..color-row("wi-iceblue"), ..color-row("wi-grey"),
    ..color-row("wi-darkblue"), ..color-row("wwu-black"),
    ..color-row("wi-purple"), ..color-row("wwu-lightgreen"),
    ..color-row("wi-pink"), ..color-row("wwu-green"),
    ..color-row("wi-coral"), ..color-row("wwu-lightblue"),
    ..color-row("wi-rose"), ..color-row("wwu-blue"),
    ..color-row("wi-ocher"), ..color-row("ercis-red"),
    table.hline(stroke: 1pt),
  ),
  caption: [Representation of color codes defined in this template.],
) <ch02:tab:colors>

== Floats <ch02:sec3:floats>

In order to include float objects, the `#figure` function is used for tables,
images, and code listings alike---the kind of float and its numbering is
determined by its content. For figures, tables as well as code, proper captions
and labels should be set. Similar to chapters and sections, labels can be set
to refer to the floating object. Captions should help the reader understand
what kind of information is displayed as well as why it is displayed. This
template does not include a list of figures or a list of tables. Again, please
keep in mind that these missing lists are missing on purpose and should only be
included in this template if your supervisor asks for it.

Additionally, you can determine where images and tables should be placed on the
page. In scientific publications, it is the state-of-the-art to place them on
top of the page. If it fits in your case, you should also stick to this rule of
thumb. Use the `placement` argument of the `#figure` function: `none` places
the float exactly where it is written, `top` at the top of the page, `bottom`
at the bottom of the page, and `auto` lets Typst choose whichever is closer.

Tables are created with the `#table` function inside a `#figure`. Please make
sure that all information is structured properly so that the reader can
directly see and understand the displayed information. Typst draws a full grid
by default; for publication-quality tables, disable it with `stroke: none` and
add only horizontal lines via `table.hline` as shown in @tab:my_label. This
follows the rules defined in the well-known LaTeX package `booktabs`
@Fear2020booktabs.

#figure(
  table(
    columns: 3,
    stroke: none,
    align: (left, left, right),
    table.hline(stroke: 1pt),
    table.cell(colspan: 2, align: center)[Article], [],
    table.hline(stroke: 0.5pt, end: 2),
    [Number], [Item], [Price (€)],
    table.hline(stroke: 0.5pt),
    [1], [Cheese], [3.50],
    [3], [Steaks], [25.00],
    [2], [Mangos], [4.00],
    table.hline(stroke: 1pt),
  ),
  caption: [An exemplary table following the rules defined in the `booktabs`
    package @Fear2020booktabs.],
) <tab:my_label>

For included images, make sure to use high-resolution (vector) images or that
you generate images by using the built-in drawing functions of Typst (or the
CeTZ package), the `ggplot` package in `R` or the `plotly` package in `python`.
They can be included by placing an `#image("file", width: ...)` call inside a
`#figure`, which can handle many formats. SVG and PDF files are preferable for
vector graphics. PNG files are the best way of including pixel graphics, such
as graphs or diagrams not available in vector format. JPEG files may be used to
include photographic or artistic images.

#figure(
  placement: top,
  image("../figures/dummy_figure.png", width: 60%),
  caption: [Always choose a proper label and caption which describes what the
    reader can see. You should write complete sentences and not only keywords.
    This nice image was generated by using the `ggplot`-package of `R`.],
) <fig:my_label>

The last type of float which can be included are code snippets. You can either
include pseudocode to outline the mechanisms of algorithms or real source code.

Pseudocode should be created by using the `#algorithm` function provided by
this template, together with the `#pseudocode` helper which numbers the lines.
Indent nested lines with the `#ind` helper and add comments with
`#pseudocomment[...]`, as demonstrated in @ch02:code:pseudo-euclid.

#algorithm(
  caption: [Euclid's algorithm in pseudo-code],
  pseudocode(
    [*procedure* #smallcaps[Euclid]$(a, b)$ #pseudocomment[required $b > a$]],
    [#ind $r arrow.l a mod b$],
    [#ind *while* $r eq.not 0$ *do*],
    [#ind#ind $a arrow.l b$],
    [#ind#ind $b arrow.l r$],
    [#ind#ind $r arrow.l a mod b$],
    [#ind *end while* <euclidendwhile>],
    [#ind *return* $b$],
    [*end procedure*],
  ),
) <ch02:code:pseudo-euclid>

For source code, syntax highlighting for several programming languages is
already built into Typst---no external package such as `minted` is required
@Poore2020minted. Simply include code files via
`#raw(read("code/file.py"), lang: "python", block: true)` inside a `#figure`,
as demonstrated in @ch02:code:python-euclid. If it is just one single line, use
inline raw text with a language tag, like `` `print("hello")` ``. Code blocks
written directly in your document are fenced with triple backticks and the
language name.

#figure(
  raw(read("../code/euclid.py"), lang: "python", block: true),
  caption: [Euclid's algorithm in python-code],
) <ch02:code:python-euclid>

== Subfloats

Sometimes it makes sense to place figures side by side. Use the `#subfigure`
helper of this template inside a `#grid` within a regular `#figure` if you want
to caption and reference the images separately. If not, you can also place two
plain `#image` calls in the grid and adjust the width so that the images are
placed side by side, e.g., both with `width: 49%`.

#figure(
  grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    [#subfigure(
      image("../figures/dummy-subfigure1.png", width: 80%),
      caption: [The caption of the first image.],
    ) <ch02:fig:fig1a>],
    [#subfigure(
      image("../figures/dummy-subfigure2.png", width: 80%),
      caption: [The caption of the second image.],
    ) <ch02:fig:fig1b>],
  ),
  caption: [Two interesting figures side by side which can be referenced
    independently. These images were generated by using the `plotly` extension
    for `R`.],
) <ch02:fig:fig1>

== Bibliography and Citations

Bibliographies are an important part of any piece of academic writing. On the
one hand they enable readers to easily extend research on the given work. On
the other hand they help writers to correctly address their sources as well as
keeping track of them. With Typst, bibliographic information is managed in
`.bib` or `.yaml` files (e.g., see `library.bib` coming with this template).

Typst provides several commands to reference sources, which are then included
in the bibliography at the end of the document. The style of references and
bibliography depends on your setting of `chair` in the beginning of the main
document. Please make sure to set that option first. Then, different variants
of citation commands may look as follows (others exist as well):

- Use authors as subject in proper English sentence. For instance, using the
  command `#cite(<Goodfellow2016deep>, form: "prose")` define ... you can
  produce: #cite(<Goodfellow2016deep>, form: "prose") define ...
- Note how more than three authors are automatically replaced with "et al.".
  `#cite(<Goodfellow2014gan>, form: "prose")` define ... produces:
  #cite(<Goodfellow2014gan>, form: "prose") define ...
- Use reference at end of sentence or as object:
  - ... `@Goodfellow2014gan`. produces: ... @Goodfellow2014gan.
  - as stated in `@Goodfellow2014gan`, ... produces: as stated
    in @Goodfellow2014gan, ...
- Include page numbers, e.g., `@Codd1970relational[p.~2]` produces:
  @Codd1970relational[p. 2]
- Produce just author names, e.g., `#cite(<Goodfellow2016deep>, form: "author")`
  produces: #cite(<Goodfellow2016deep>, form: "author")

Generally, each source has to be named. How this can be done varies between
institutions and departments. Relevant literature can be included in the
`library.bib` file in the main folder of this template. Inside, you will also
find some examples on which information is needed for which type of literature.

If authors or book titles are mentioned by name, the source should be cited
right after them, e.g.: The book _Artificial Intelligence: A Modern
Approach_ @Rusell2003artificial has been written by S. J. Russel and
P. Norving.

Note that sources should _not_ just be listed at the end of a paragraph.
Instead, sources should be cited when they are used. For instance, the
following sentence might be the first one in a paragraph on Generative
Adversarial Networks: According to @Goodfellow2014gan, Generative Adversarial
Networks share the following major advantages (followed by text based on that
source).

== Quotes

The following example shows two things at once. Firstly, how to change the
language environment, secondly, how to quote directly.

Direct quotes are produced by using the `#quote` function, as shown in the
example below.

#quote[
  Future users of large data banks must be protected from having to know how
  the data is organized in the machine (the internal
  representation). @Codd1970relational[p. 2]
]

Of course, copied text should be kept at a minimum and needs to be cited
properly. Next to the `#quote` function just shown, quotation marks can be
used: "Future users of large data banks ..." @Codd1970relational[p. 2].
Importantly, Typst knows language dependent opening and closing quotation
marks. In source files, you can simply type straight double quotes `"..."` and
Typst will automatically convert them into the correct, language-specific
quotation marks (e.g., "..." in English and „...“ in German).

Quotes in a different language are set using the `#text(lang: "..")` function,
as illustrated below.

#quote[
  #text(lang: "de")[
    Aus logischer Sicht besitzt ein Von-Neumann-Rechner neben der CPU einen
    _Speicher_, welcher begrifflich zusammengesetzt ist aus einem ROM- und
    einem RAM-Teil. @OberschelpVossen[p. 230]
  ]
]

== Licensing <sub:licensing>

When you create an own work, reuse of your work is restricted by copyright
laws. E.g., if you write a good or excellent thesis, not even your supervisors
are allowed to create copies of your work for classroom use. To enable reuse of
(academic and other) works, Creative Commons (CC) provides a set of licenses.
For Open Educational Resources (OER), the license variants CC BY-SA, CC BY, and
CC0 are particularly useful. Please consult CC's web page
#link("https://creativecommons.org/licenses/") to learn more about different
license variants.

The `license` option in the introductory `#show: wi-thesis.with(...)` rule
allows you to publish your work under such a free and open license. This will
create a short license statement towards the end of your thesis (on the page
with your declaration of authorship): "Unless explicitly specified otherwise,
this work is licensed under the license Your-Chosen-Variant."

Recall that you must always cite your sources. This is particularly relevant if
you want to publish your work under a CC license and you include resources that
you did not create yourself (e.g., figures): You _must_ indicate (and, of
course, respect) license terms for included resources so that others know which
license terms apply where.

== Headings

As mentioned above, if a section is broken further down, at least two
subheadings shall follow.

=== Subheadings

This means a structure like this is _NOT_ appreciated for this is the only
subheading. Therefore, there is no need to have it in the first place.

== Blacklist of commands

You can add additional definitions in `main_thesis.typ` before the `#show`
rule if you need more than already defined in this template. But below you will
also find a list of rules which should not be overridden in this document.
All settings and commands which alter the design of the thesis, margins,
indents or any other spaces are especially forbidden.

Disallowed settings:

/ `#set page(...)`: You are not allowed to change any margins, headers,
  footers, or other page styles.
/ `#set par(leading: ..., spacing: ...)`: You are not allowed to change the
  line spacing or the spacing between paragraphs.
/ `#set text(size: ...)`: Do not change the font size of the body text; tiny
  font sizes are not acceptable.
/ `#v(...)` with negative values: No negative value may be used to alter
  spacing above or below a caption, figure, table, or heading.
/ `#wrap-content`, floating text: Text is not allowed to float around figures.
