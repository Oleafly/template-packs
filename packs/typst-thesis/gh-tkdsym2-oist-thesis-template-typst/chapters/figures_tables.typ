#import "../oist_thesis.typ": custom_figure

#heading(level: 1, "Figures, tables and images") <chap-3>

Here, we describe figures and tables with how to refer.

#heading(level: 2, "Figures")

Figures are defined by the `#figure(...)` function. The caption is written in the `caption:` parameter, and the figure itself is written in the first parameter. The caption should be short for the List of Figures, but you can write a full caption in the `caption:` parameter.
Refer to figure like this: `@fig-example`. It will be shown as @fig-example. If you want to display a shorter form, you can change the style by writing it as in `@fig-example[Fig.]`. It will be shown as @fig-example[Fig.].

```typ
#figure(
  image("../images/chap3/emblem.jpg", width: 50%),
  caption: [Full caption with all the details here.font size has to be 10pt, and sentences has to be left side.],
) <fig-example>
```

#figure(
  image("../images/chap3/emblem.jpg", width: 50%),
  caption: [Full caption with all the details here.font size has to be 10pt, and sentences has to be left side.],
) <fig-example>

The style of figures is defined based on GS Policies.

=== Short titles for LoF/LoT

If you want to show a short headline (summary) in the List of Figures/Table, use `#custom_figure(...)` and pass a `short:` argument in addition to the full `caption:`. In the body, the caption will appear as “Figure: Short Title Full caption …”, while the lists will display only the “Short Title”.

```typ
#custom_figure(
  image("../images/chap3/emblem.jpg", width: 50%),
  short: [Logo, short caption for LoF],
  caption: [Full caption with all the details here. Font size has to be 10pt, and sentences have to be left-aligned.],
) <fig-example-short>
```

#custom_figure(
  image("../images/chap3/emblem.jpg", width: 50%),
  short: [Logo, short caption for LoF.],
  caption: [Full caption with all the details here. Font size has to be 10pt, and sentences have to be left-aligned.],
) <fig-example-short>

#set quote(block: true)
#quote(attribution: [OIST, Graduate School Policies#footnote[#link("https://www.oist.jp/education/policies-regulations/gs-policies")]])[
  _*Spacing* : Figures should appear as close as possible to the first mention of them in the text.  All figures must be referred to in the text by either a parenthetical mark-up (Figure 1.2), or phrasing such as "Sequencing data, shown in Figure 1.2, shows that…".  A parenthetical mention, but not an in-text mention, may be abbreviated as (Fig. 1.2).  The number of the chapter should be part of the figure number._

  _Figures must be accompanied by a caption that describes the material cleanly and succinctly.  Figure captions may start with a brief title in bold, which can then be referenced in the list of figures._

  _As a general rule, figures should not have captions that run across pages.  If a figure and its caption will be larger than one page, rewriting should be considered, or a reorganization of the figure.  If this cannot be avoided, the figure caption should continue on the immediate next page, with a reference comment at the start of the text to the fact that it is a continuation.  No other main body text should then appear on that page._
]

== Tables

The table can be created as follows.

```typ
#figure(
  table(
    columns: (auto, auto),
    align: (center, center),
    [Parameter], [Value],
    line(length: 100%), line(length: 100%),
    $Delta$, "0, 150",
    $alpha$, "85",
    $epsilon$, "6",
    $kappa$, "6.8",
    $gamma$, "0.2",
  ),
  caption: [Short heading for the List of Tables.],
) <tab-values>
```

#custom_figure(
  table(
    columns: (auto, auto),
    align: (center, center),
    [Parameter], [Value],
    line(length: 100%), line(length: 100%),
    $Delta$, "0, 150",
    $alpha$, "85",
    $epsilon$, "6",
    $kappa$, "6.8",
    $gamma$, "0.2",
  ),
  short: [tables],
  caption: [Short heading for the List of Tables.],
) <tab-values>

You can also supply short titles for tables using `custom_figure`:

```typ
#custom_figure(
  table(
    columns: (auto, auto),
    align: (center, center),
    [Parameter], [Value],
    line(length: 100%), line(length: 100%),
    $Delta$, "0, 150",
    $alpha$, "85",
    $epsilon$, "6",
    $kappa$, "6.8",
    $gamma$, "0.2",
  ),
  short: [Parameter Summary],
  caption: [Full table caption with details.],
) <tab-values-short>
```

Refer to tables like this: `@tab-values`, which will be shown as @tab-values. Shorten form can be written as `@tab-values[Tab.]`, which will be shown as @tab-values[Tab.]. 

#set quote(block: true)
#quote(attribution: [OIST, Graduate School Policies#footnote[#link("https://www.oist.jp/education/policies-regulations/gs-policies")]])[
  _*Tables*: All tables should be referred to in the text by number (for example, “Table 3.1 describes all particles found in…”).  Tables may be printed in landscape rather than portrait orientation but must be printed on a separate page with continuing and sequential pagination.  Tables may extend for more than one page but should then have the table header row repeated on each page.  Arial, Helvetica or Calibri, 10-point font, should be used for tables.  Tables should have a heading and may have a caption.  The number of the chapter should be part of the table number._
]

Additional images are attached below (@fig-writing_thesis_by_hand[Fig.], @fig-tools_paradigm[Fig.]).

The first figure shows a Ph.D. candidate writing a thesis by hand. To avoid suspicion of using GPT, this university seems to have reverted to handwritten submissions.

#figure(
  image("../images/chap3/writing_thesis.svg", width: 100%),
  caption: [A Ph.D. candidate writing his dissertation. Holding a pen, but unable to start the first sentence. Created by Google Nano Banana.],
) <fig-writing_thesis_by_hand>

The second figure illustrates a paradigm shift in thesis writing. It evolves from handwriting to Virtual Reality (VR).

#custom_figure(
  image("../images/chap3/writing_thesis_paradigm.svg", width: 100%),
  short: [The process by which a Ph.D. candidate's tools for writing their dissertation change.],
  caption: [(A) Handwritten, (B) Typewriter, (C) Laptop, (D) VR space. The only thing GPT seems unlikely to interfere with is the typewriter. On the other hand, if our arms were driven by Electrical Muscle Stimulation, that might be a different story.],
) <fig-tools_paradigm>

These figures are examples of how to present data in a clear and concise manner.
