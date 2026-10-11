#import "ufal.typ": *

#show: ufal-theme.with(
  footer-content: "ÚFAL Typst Template",
)

#title-slide(
  title: "Example slide deck",
  name: "ÚFAL slides template",
  subtitle: "This time in Typst!",
  author: "Zdeněk Kasner",
  date: "16 Sep 2025",
  license-type: "cc-by-sa",
  langtech: false,
)[]

#section-slide("What is this?")

#slide[
  = What is this?

  #toolbox.side-by-side(columns: (3fr, 1.5fr))[
    - This slide deck is created with *#link("https://polylux.dev/book/polylux.html")[Typst]* -- a markup-based typesetting system
      - We use also *#link("https://polylux.dev/book/polylux.html")[Polylux]* for  slide-related commands.
    - The template `ufal.typ` is inspired by the #link("https://docs.google.com/presentation/d/1cE1fyaG9qWXJo5Upzi_i8mXMqUGbuYDgwqvHGYRgBSE/edit?usp=sharing")[ÚFAL Google Slides template] and Milan Straka's #link("https://github.com/ufal/slimd")[SliMD template].
    - It is different than the #link("https://github.com/kasnerz/marp-ufal")[ÚFAL Marp template]: see #link(label("comparison"))[the comparison slide.]
  ][
    #align(center + horizon)[
      #image("img/typst_logo.svg", width: 50%)
    ]
  ]
]

#slide[
  = ÚFAL Typst Theme

  === Main features

  #set list(marker: none, indent: -8pt)
  - 📝 *Easy editing*: Create slides in your favourite text editor with live preview.
  - #inline-image("img/github.svg") *Git-friendly*: You can version-control your presentations.
  - 🖲️ *Multiple export formats*: Export to PDF or PNG.
  - 🪧 *LaTeX support*: Mathematical typesetting with native Typst math.
  - ⚡️ *Advanced typography*: Use Typst's powerful layout system.
  - ✒️ *Consistency*: Everything is nice and aligned without too much effort.
  - 🦶 *Auto footer*: No more manual copying of the bottom orange bar 💪
  - 🚀 *Popular framework*: Typst has #link("https://typst.app/docs/")[excellent documentation] and many extensions.
]

#slide[
  = Typst vs Marp ⚔️
  <comparison>

  Should I use the *Typst template* (this one) or the #link("https://github.com/kasnerz/marp-ufal")[Marp template]?

  #set list(marker: none, indent: -8pt)

  #toolbox.side-by-side(gutter: 3mm)[
    === Typst
    - ✅ Nicer markup language.
    - ✅ More powerful layout handling.
    - ✅ Online collaboration.
    - ❌ PDF-only - no interactive content.
  ][
    === Marp
    - ✅ Simpler markup language.
    - ✅ Interactive content (video, audio).
    - ❌ Need to use HTML for advanced stuff.
  ]
]


#section-slide("How to use it?")

#slide[
  = Typst syntax 101

  See the code and the #link("https://typst.app/docs/tutorial/")[tutorial] on how to use the Typst markup syntax.

  === This is an H3 header.
  - This is a bulleted list.
    - With a nested item.
  + And this is a numbered list.

  You can also use *bold text*, _italic text_, #link("https://ufal.cz")[links], `monospace`, etc.

  ---

  #text(
    size: 15pt,
    fill: muted-color,
  )[With Typst, you can modify layout or text properties to your liking using functions such as `#text()` or `#align()`.]
]

#slide[
  = Slide layouts

  This template uses #link("https://polylux.dev/book/polylux.html")[Polylux], which provides various layout options:

  - Use `#slide[content]` for regular slides
  - Use `#title-slide`, `#section-slide`, and `#summary-slide` for special layouts.
  - Use `toolbox.side-by-side` for two-column layouts.

  #infobox(title: "Tip", icon: "💡")[
    You can also create info boxes with the helper function:
    - `#infobox(title: "Title", icon: "💡")[content]`

  ]
]

#slide[
  = Working with images

  #set align(center + horizon)

  == Image placement and sizing

  Use Typst's image syntax to include an image:
  ```typst
  #image("img/transformer.png", height: 3cm)
  ```

  #image("img/transformer.png", height: 3cm)
]

#blank-slide[
  #align(center + horizon)[
    == Math typesetting

    You can render both inline math: $E = m c^2$ and separate equations:

    $cal(L)(theta) = sum_(i=1)^n log p(y_i | x_i, theta) - lambda ||theta||_2^2$


    #v(20pt)

    #set align(left)
    #infobox(title: "Warning", icon: "⚠️")[

      #link("https://typst.app/docs/reference/math/")[Typst math syntax] is *different* from the LaTeX syntax.

      Use this #link("https://qwinsi.github.io/tex2typst-webapp/")[online convertor] to convert your equations between these two.

    ]

    #set align(center)

    #text(size: 15pt, fill: muted-color)[This slide uses the `#blank-slide` command.]
  ]
]

#slide[
  = Code blocks & columns

  #toolbox.side-by-side[
    === Python code

    Syntax highlighting is supported:

    ```python
    def factorial(n):
        if n == 0:
            return 1
        else:
            return n * factorial(n - 1)
    ```
  ][
    === Javascript code

    ```javascript
    function greet(name) {
        console.log(`Hello, ${name}!`);
    }
    ```
  ]

  #infobox(title: "Note", icon: "ℹ️")[ Use `toolbox.side-by-side` to display content in multiple columns.]
]


#slide[
  = Tables and links

  #align(center)[
    #table(
      columns: 4,
      align: (left, right, center, left),
      stroke: 0.5pt + gray,
      table.header[*Model*][*Metric 1*][*Metric 2*][*Rating*],
      [not LLM 1], [14.5], [🟠], [Mediocre],
      [not LLM 2], [5.5], [🔶], [Worst],
      [not LLM 3], [6.9], [🟧], [Even worse],
      [LLM], [*99.8*], [🧡], [Greatest thing ever!],
    )
  ]

  - Tables automatically get proper styling.
  - You can add source links using the `source-link` function.

  // Add a source link - small and right-aligned
  #source-slide("https://example.com/our-experiments", title: "Our experiments")
]

#slide[
  = Dynamic content & animations

  === Polylux Animation Features

  #toolbox.side-by-side(gutter: 3mm, columns: (1.2fr, 1fr))[
    ==== Item-by-item lists
    #item-by-item(start: 2)[
      - Basic bullet points
      - Appear one by one
    ]

    #one-by-one(start: 4)[
      ==== One-by-one content blocks
      First content block
    ][
      Second content block
    ]
  ][

    #infobox(title: "Animation Controls", icon: "🎬")[
      #set text(size: 18pt)
      Use `start: N` parameter to control when animations begin on specific subslides.
    ]

    See also other 👉️#link("https://polylux.dev/book/polylux.html#animations")[Polylux features].

  ]
  #v(10pt)

]

#section-slide("Practical tips")

#slide[
  = Development

  === Live preview
  Use any text editor with Typst support for *live preview*:
  - VS Code with the #link("https://marketplace.visualstudio.com/items?itemName=myriad-dreamin.tinymist")[Tinymist Typst extension]
  - Neovim with #link("https://github.com/kaarmu/typst.vim")[typst.vim]
  - Online #link("https://typst.app")[Typst web app] (useful also for collaboration)

  === Compilation CLI

  ```bash
  $ typst compile slides.typ slides.pdf
  $ typst watch slides.typ slides.pdf  # Auto-recompile
  ```

]

#slide[
  = Links

  - #link("https://typst.app/docs/")[Typst Documentation]
  - #link("https://sitandr.github.io/polylux/book/polylux.html")[Polylux: Presentation slides in Typst]
  - #link("https://github.com/touying-typ/touying")[Touying: Modern presentation framework for Typst]
  - #link("https://github.com/typst/packages")[Typst Packages Repository]
  - #link("https://discord.gg/2uDybryKPe")[Typst Community Discord]
  - #link("https://github.com/kasnerz/marp-ufal")[Original ÚFAL Marp Theme]
]

#summary-slide(
  title: "Summary",
  subtitle: "ÚFAL Typst Template",
  link: "https://github.com/kasnerz/typst-ufal",
)[
  This template is the *dark horse* of all the ÚFAL templates 🔥

  It is easy to use, extensible, and looks great.

  Don't be lazy, learn *Typst*!
]

