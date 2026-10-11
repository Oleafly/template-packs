#import "../rochelimit/drift-en.typ": *

#show: rl-content.with(
  title: [RocheLimit (Drift) Template: An English Typesetting Example],
  authors: (
    (
      name: "Limity'roChen",
      department: [Core Dev],
      organization: [Project Hazelita],
      location: [LyRiverse],
      email: "LyCecilion@outlook.com",
    ),
  ),
  date: datetime(year: 2024, month: 2, day: 15),
  version: [0.1.0],
  rl-header: [
    #smallcaps[May All The Beauty Be Blessed.]
    #line(length: 100%)
  ],
)

RocheLimit is a collection of typst templates created by Limity'roChen for their everyday typesetting needs. RocheLimit comes in 2 versions—Drift and Surge. This "RocheLimit (Drift) Template: An English Typesetting Example" (hereinafter "the example") is typeset with Drift.

RocheLimit follows the style of documents typeset with #m-jaxon.render("\Large \LaTeX", inline: true): it adopts serif fonts such as TeX Gyre Schola and Source Han Serif, and fine-tunes page margins, line spacing, paragraph spacing, and more, so as to meet everyday or formal typesetting needs. The 2 versions of RocheLimit serve respectively the typesetting of formal documents of short / long length. Drift implements neither a cover for the document nor covers for sections, ensuring that typesetting short pieces does not come across as bloated.

The example demonstrates the basic features of typst as well as those extended by RocheLimit.

#figure(
  placement: none,
  image("../assets/perlica.jpg", width: 80%),
  caption: [*Perlica* is the Supervisor of Endfield Industries, a position she created. In this role, she oversees all company operations and serves as the official spokesperson. She is also a leading expert of Techno-Protocol and the development and application of Protocol-Originium technology, which makes her indispensible to the overall operations of the OMV Dijiang.],
) <perlica>

Both the templates and this example are open-sourced under the MIT License at #link("https://github.com/LyCecilion/RocheLimit")[GitHub: LyCecilion/RocheLimit].

The typst version used to compile this document is #sys.version, and the compilation arguments are #sys.inputs.

#pagebreak()

= Template Feature Demonstration <template-presentation>

== Typst Basics

Typst has three modes: markup, math, and code. Different modes come with different syntaxes. Most of them resemble those of #m-jaxon.render("\Large \LaTeX", inline: true) and Markdown, making them easy to pick up.

=== Markup Mode

In markup mode, you can give text *strong emphasis* or _emphasis_, print `raw text`, inline code blocks ```sh printf "TGltaXR5J3JvQ2hlbg==" | base64 -d```, or inline math such as $D(x_0) = {d in RR | f(x_0 + d) > f(x_0)}$. You can also insert links (for example, see #link("https://typst.app/docs/reference/syntax/")[Syntax - Typst Documentation] in the official documentation for the syntax of the three modes) or reference labels (for example, refer to @perlica).

You can #highlight[highlight] a passage of text, add an #overline[overline] or an #underline[underline] to it, or attach a #super[superscript] or a #sub[subscript].

Typst supports the following three kinds of lists: bullet lists, numbered lists, and term lists.

#columns(3)[
  - You can
  - enter
  - a bullet list
  #colbreak()
  + You can
  + also enter
  + a numbered list
  #colbreak()
  / Or: you can also
  / like this: enter
  / a: term list
]

=== Math Mode

Math mode is a special markup mode. Typst wraps mathematical formulas in `$`: to type inline math, place `$` snugly against the formula (e.g., `$1$`); to type display math, leave one space between `$` and the formula (e.g., `$ 1 $`). Below is an example of math mode, which contains both inline and display math.

#box(stroke: black, inset: 0.8em, width: 100%)[
  #set par(first-line-indent: 0em)
  Let $bold(A)$ be a $20,000 times 20,000$ matrix. All entries of the matrix are $0$ except at the following two places:

  - The entries on the main diagonal are the first $20,000$ primes: $2, 3, 5, 7, ..., 224737$;
  - All entries at positions $a_(i j)$ satisfying
    $ |i - j| = 1, 2, 4, 8, ..., 16384 $
    are equal to $1$.

  Let the value of the $(1, 1)$ entry of $bold(A)^(-1)$ be $h_3$. Find the values of $h_3$ and $3009 h_3 - 58 e$.
]

#strike[The answer to this problem#footnote[In fact, $3009 h_3 - 58 e approx 2024.1004$, which is the date Project Hazelita was initiated (October 4, 2024).] is obvious and left as an exercise.]

=== Code Mode

Code mode of typst is feature-rich; see the #link("https://typst.app/docs/reference/syntax/#code")[Code mode] section of the official typst documentation.

== Bibliography

Typst manages bibliographies through the `bibliography` function: once a bibliography database in BibTeX (`.bib`) or Hayagriva (`.yml`) format is prepared, you can cite its entries in the body text and generate a reference list in a suitable place.

Here, the example uses `bibliography.bib` in the same directory as its database. The simplest way to cite an entry is to write `@key` directly (`key` being the entry's identifier); for instance, `@fedora-debugging` cites the article @fedora-debugging. For more control, use the `cite` function instead—for example, the prose form (`#cite(<typst-bibliography>, form: "prose", supplement: [official documentation])`) outputs #cite(<typst-bibliography>, form: "prose", supplement: [official documentation]), with supplementary notes attached via the `supplement` argument.

In a suitable place, the reference list can be generated with the ```typst #bibliography()``` function. For example, with

```typst
#bibliography("bibliography.bib")
```

we obtain:

#box(stroke: black, inset: 0.8em, width: 100%)[
  #bibliography("bibliography.bib")
]

== Footnotes

The `footnote` function produces footnotes: enclose the content in square brackets, and typst numbers it automatically and sets it in the footer of the current page, just like this#footnote[The numbering format can be adjusted via the `numbering` argument.]. To point to the same footnote again later, attach a label to the first footnote and reuse it as `#footnote(<label>)`; the reuse displays the same number:

```typ
// Attach a label to the footnote
typst numbers footnotes#footnote[This is a reusable footnote.] <fn-demo>

// Reusing keeps the original number
Pointing to this footnote again#footnote(<fn-demo>)
```

Actual effect: here is the labeled footnote#footnote[This is a reusable footnote.] <fn-demo>, while this spot#footnote(<fn-demo>) reuses its number. The footnotes of each page can be seen at the end of that page.

== Tables

Typst supports tables. RocheLimit configures table defaults: the inset defaults to `7pt`, and tables are horizontally centered by default (`horizon`). RocheLimit does not apply excessive styling to tables.

#figure(
  caption: [Fonts used in the example],
  table(
    columns: 3,
    table.header([Usage], [Font], [Description]),
    [Body], [TeX Gyre Schola], [Primary Latin font],
    [Body], [Noto Serif CJK SC], [CJK font],
    [Code], [Latin Modern Mono 8], [Latin font inside code blocks],
    [Code], [LXGW WenKai Mono], [CJK font inside code blocks],
  ),
)

== RocheLimit Extensions

=== Flag

RocheLimit provides the Flag block to accommodate CTF scenarios. For example,

```typst
#flag[`hzlt{4ND_1N_7H47_116H7-1_F1ND_D311V3r4NC3}`]
```

yields:

#flag[`hzlt{4ND_1N_7H47_116H7-1_F1ND_D311V3r4NC3}`]

=== Callout

RocheLimit provides the Callout block, reproducing common Markdown usage. The `callout` function takes two arguments, `title` and `body`, where the `title` block is optional. For example, the following sample provides both `title` and `body`:

```typst
#callout[Note][hzlt!Game 2027 starts on December 25, 2026.]
```

which renders:

#callout[Note][hzlt!Game 2027 starts on December 25, 2026.]

While the following sample leaves `title` empty:

```typst
#callout[][
  Let my heart bravely spread the wings /
  Soaring past the night /
  To trace the bright moonlight \
  Let the clouds heal me of the stings /
  Gently wipe the sorrow off my life /
  I dream
  #align(right)[— _If I Can Stop One Heart From Breaking_]
]
```

which yields:

#callout[][
  Let my heart bravely spread the wings /
  Soaring past the night /
  To trace the bright moonlight \
  Let the clouds heal me of the stings /
  Gently wipe the sorrow off my life /
  I dream
  #align(right)[— _If I Can Stop One Heart From Breaking_]
]

=== Table of Contents

RocheLimit rewrites the `outline` block. For example, at the top of a page, you can directly use

```typst
outline()
```

to obtain a table of contents:

#outline()
