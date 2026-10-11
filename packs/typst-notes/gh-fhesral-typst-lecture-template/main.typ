//+++ imports +++\\

// conf.typ has the template configuration with conf being the typesetting config, chapter being the level-zero headings, theorem-envs the function used to generate custom theorem environments (boxes) new-lecture is a function to organise your writing and showing the date from when the lecture was, and endcol is just a wrapper for an invisible box with height as argument to end a column for styling purposes (prevent breaking)
#import "conf.typ": chapter, conf, endcol, new-lecture, theorem-env

// in cover.typ the coverpage is created as a function
// `cover` with whatever arguments to be inserted in the
// document. Ofc it can also be defined in this doc
#import "cover.typ": cover

// Equate is used to have a better labeling experience with
// block equations :)
#import "@preview/equate:0.3.2": equate
#show: equate.with(
  breakable: true,
  sub-numbering: false,
  number-mode: "label",
)//also works without equate but I like it better this way

// defining colors for environments and links
#let theorem-color = rgb(180, 220, 250)
#let theorem-link-color = rgb("#0091ff")

#let example_color = rgb("#61cb73")
#let example-link-color = rgb("#4be469")

#let remark-color = rgb("#fd2e2e")
#let remark-link-color = rgb("#fd2e2e")

#let image-link-color = rgb("#5a0071")
#let table-link-color = rgb("#710048")
#let eq-link-color = rgb("#00133e")

// chapter colors
#let chapter-color = rgb(7, 16, 73)
#let chapter-number-color = rgb("#80808097")


// setting up the wanted kinds of theorem-envs
#let theorem(title, content, extra: "") = {
  theorem-env(
    title,
    content,
    theorem-color,
    kind: "theorem",
    supp: "Theorem",
    extra: extra,
  )
}
#let example(title, content, extra: "") = {
  theorem-env(
    title,
    content,
    example_color,
    kind: "example",
    supp: "Example",
    extra: extra,
  )
}
#let remark(title, content, extra: "") = {
  theorem-env(
    title,
    content,
    remark-color,
    kind: "remark",
    supp: "Remark",
    extra: extra,
  )
}
// for each kind the name must be added in the dict "theorem-config" in the conf.with() function. Also the other keywords (link-color, show-in-outline, abbreviation) need to be paired.
#let theoremr(title, content, extra) = {
  theorem-env(
    title,
    content,
    theorem-color,
    kind: "theorem",
    supp: "Theorem",
    extra: extra,
  )
}

#show: conf.with(
  cols: 2,
  lecture-name: [Lecture Name],
  author-name: [fhesral],
  theorem-config: (
    theorem: (
      link-color: theorem-link-color,
      show-in-outline: true,
      abbreviation: "thrm.",
    ),
    example: (
      link-color: example-link-color,
      show-in-outline: true,
      abbreviation: "ex.",
    ),
    remark: (
      link-color: remark-link-color,
      show-in-outline: true,
      abbreviation: "rmk.",
    ),
  ),
  img-tab-eq-link-color: (green, orange, blue),
  show-dates: true,
  abbreviate-links: true,
  chapter-color: rgb(7, 16, 73),
  chapter-number-color: rgb("#80808097"),
  shadow-color: rgb(0, 0, 0, int(255 * 0.3)),
  coverfunc: cover.with(
    lecture-name: "Example Lecture",
  ),
)
#show raw.where(lang: "typ"): set block(
  breakable: true,
  fill: rgb(10, 10, 10, 10),
  radius: (top-left: 5pt, rest: 5pt),
  inset: 5pt,
  width: 100%,
)

// start of actual lecture content
#new-lecture(26, 8)[
  #chapter[A general overview]
  This template offers the possibility to create theorem environments with colored boxes and titles.

  = Example <sec1>

  In this case I created the three environments 'theorem', 'example' and 'remark'. In the 'constructor' (theorem-env) I gave each environment an unique body color. In the config I gave each environment a link-color, abbreviation and a bool for which environments I want to see in the outline. The environments look like this:
  #theorem[The theorem's title][
    The content of the theorem. This can also be a formula, like
    $
      E = m c^2
    $ <einstein>
    or a figure like
    #figure(
      image("image.svg", width: 40%),
      caption: [A black hole.],
    )<fig1>
  ]<thm1>
  #example[An example][
    Here you could give an example of something. \
    #lorem(10)
  ]<ex1>
  #remark[Warning][_Be careful_]<rmk1>
  I also added a fourth one as a shortcut for a box with an extra box at the bottom. Usually you would do
  #theorem(
    extra: [This is a usually hidden box for remarks or proofs in a theorem environment.],
  )[Some Theorem with Proof][This would be some kind of theorem that needs to be proven:
    $
      a + b = c
    $]<thm2>
  #theoremr[A shortcut][But to make it a little bit faster when wanting to write live at a lecture I created `theoremr()`:][Remark/Proof,...]
  All of these boxes are breakable too, if you want!
  #example()[][
    #lorem(200)
  ]
  = Setup
  I created this because I was bored but mostly because I wanted to have a nice template I can use for taking notes in lectures. In typst it is much easier to write live during the lecture due to on-the-fly compilation and the much easier commands in math mode etc.

  == How to start
  To start just download the `conf.typ` file and create a new file (maybe `main.typ`) in the same folder. Then write
  ```typ
    #import "conf.typ": conf, theorem-env, chapter, new-lecture, endcol
  ```
  at the very top. I also suggest using the #link("https://typst.app/universe/package/equate/", text(blue, [`equate`])) package with the following settings:
  ```typ
    #import "@preview/equate:0.3.2": equate
    #show: equate.with(
      breakable: true,
      sub-numbering: false,
      number-mode: "label",
    )
  ```
  Then you can already create your first theorem environment with the imported `theorem-env` function:
  ```typ
  #let theorem(title, content, extra: "") = {
    theorem-env(
      title,
      content,
      rgb(180, 220, 250),
      kind: "theorem",
      supp: "Theorem",
      extra: extra,
    )
  }
  ```
  When creating new environments dont forget about changing the parameter `kind` since it controls the counter.
  #theorem[This is what you just created][
    This box (called with `#theorem[title][content]`) is the result. You can write what ever you want in here. Calling it with the optional argument `extra` like this:\
    ```typ
    #theorem(extra: [This is a remark])[Title][Body]
    ```
    adds another, darker, box at the bottom (see @thm2).
  ]
  You can also create another box environment with the same counter but where the bottom box is mandatory:
  ```typ
  #let theoremr(title, content, extra) = {
    theorem-env(
      title,
      content,
      theorem-color,
      kind: "theorem",
      supp: "Theorem",
      extra: extra,
    )
  }
  ```
  The content prodiced by:
  ```typ
  #theoremr[Title][Body][Extra]
  ```
  is:
  #theoremr[Title][Body][Extra]

  == The Template

  Adding
  #box(radius: 5pt, fill: rgb("#f0f0f0"), stroke: rgb("#f0f0f0"), inset: (x: 4pt), ```typ #show: conf```)
  to the preamble after importing it, already gives a much nicer result. A lot has happened now, because all default values and settings of the template were loaded. You must change one of these settings urgently:\
  The parameter ```typ theorem-config``` controls the numbering, styling and more of all created environments. In our case it should look like this:
  ```typ
  #show: conf.with(
    theorem-config: (
      theorem: (
        link-color: theorem-link-color,
        show-in-outline: true,
        abbreviation: "thrm.",
      ),
    ),
  )
  ```
  Since `theorem` and `theoremr` share the same `kind` there dont need to be more environments listed.

  #chapter[Configuring the template]

  You can configure a lot more. If you have created three environments called `theorem`, `example` and `remark` your config could look like this:

  ```typ
  #show: conf.with(
    cols: 2,
    lecture-name: [Lecture Name],
    author-name: [author name],
    theorem-config: (
      theorem: (
        link-color: rgb("#0091ff"),
        show-in-outline: true,
        abbreviation: "thrm.",
      ),
      example: (
        link-color: rgb("#4be469"),
        show-in-outline: true,
        abbreviation: "ex.",
      ),
      remark: (
        link-color: rgb("#fd2e2e"),
        show-in-outline: true,
        abbreviation: "rmk.",
      ),
    ),
    img-tab-eq-link-color: (green, orange, blue),
    show-dates: true,
    abbreviate-links: true,
    breakable-thrms:true,
    chapter-color: rgb(7, 16, 73),
    chapter-number-color: rgb("#80808097"),
    shadow-color: rgb(0, 0, 0, int(255 * 0.3)),
  )
  ```
  The final argument is: `coverfunc`. If you want to create a cover,
  use a function which returns the coverpage (e.g. ```typ #cover(args)```). Then you can include it in the template config with:
  ```typ
  #show: config.with(
    ...
    cover-func: cover.with(
      arg1: ...,
      arg2: ...,
      ...,
    )
    ...
  )
  ```
  The default cover is no cover at all. The very basic cover of this document is found in `cover.typ`
]
#new-lecture(28, 8)[
  By now you are probably wondering what that date on the #context { if here().position().x > measure(box(width: 100%)).width / 2 { [right] } else { [left] } } side means. As this is meant for notetaking I added a function \ ```typ #new-lecture(day, month)[content]```. \
  This shows the given date in the page margin if the toggle argument `show-dates` is set to `true` in the config.
]
#new-lecture(29, 8)[
  #chapter[Styling]
  Also: I tried to configure this in a way that the lecture can be printed in book-format afterwards. This is the reason why there are different margins and headers for even/odd pages and why there are some "unnecessary" pagebreaks. Feel free to explore the template and to criticize it as much as you want. This is my first project and I hope you like it. I am sorry for the not-very-well-written code. This is my first typst-project and I used it to learn writing with typst.
]
