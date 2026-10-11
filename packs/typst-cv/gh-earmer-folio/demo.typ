// folio — demo document. Every name, link and fact below is fictional.
// Copy this file, replace the content, and drop your photos into assets/.

#import "lib.typ": *

#show: intro.with(
  name: [Ada Wren],
  name-zh: "温雅",
  role: "Engineer · writer · photographer",
  tagline: [On building quiet, durable things, and on the long habit of reading closely.],
  // portrait: image("assets/portrait.jpg"),
  epigraph: ([We shall not cease from exploration, and the end of all our exploring will be to arrive where we started and know the place for the first time.], "T. S. Eliot, Little Gidding"),
  facts: (
    "Based in": [Somewhere, Earth],
    "Currently": [Engineer],
    "Languages": [EN · 中文],
    "Reach me": [ada\@example.com],
  ),
  version: "I",
)

= Prologue

#epigraph(by: "Montaigne", source: "Essais")[I am myself the matter of my book.]

#lede[This is not a résumé. It is a longer letter, the kind you write when a list of job titles says too little.]

#opening[Open each chapter with `#opening[...]` for a teal drop capital. Body text is justified, indented, and set in a book serif, while the machinery around it (headers, footers, labels) speaks in monospace.]

Margin notes sit in the right column, numbered per chapter.#sidenote[Like this one. Use `#marginnote[...]` for an unnumbered note.] Pull-quotes, epigraphs and fleurons supply the literary furniture.

#stats(("12", "years shipping"), ("40+", "essays"), ("∞", "books unfinished"))

#pullquote(by: "a note to myself")[Good work, like good prose, is mostly the work of taking things out.]

== 致中文读者

#zh[
  用 `#zh[...]` 排中文段落：标点挤压、首行缩进两字、行距放宽。西文仍用 Hoefler Text，引号等标点则取自宋体。

  强调或引文可用#kai[楷体]；英文斜体中的汉字也会自动改用楷体，因为中文字体没有真正的斜体。#sidenote[边注同样支持中文。]
]

== What you'll find here

#manifest(
  file: "~/.config/ada/profile.toml",
  name: [Ada Wren],
  name-zh: [温雅 · Wēn Yǎ],
  timezone: [`UTC`],
  focus: [tooling, typesetting, writing],
  status: [open],
)

= A Short Biography

#opening[A timeline keeps dates in a narrow left column, with a rule and square markers in the house style.]

#timeline(
  ("2012", [First program], [A loop that printed a name forever, and the pleasure of making it stop.]),
  ("2016", [University], [Literature, with a formal-logic elective that changed everything.]),
  ("2020", [First real job], [Building the pipeline that turns manuscripts into books.]),
  ("Now", [Writing, again], [An essay series on craft and attention.]),
)

#plate(caption: [A numbered plate. Replace the placeholder with `image("assets/...")`.], credit: "photo: author")[
  #placeholder(label: "plate", height: 6cm)
]

#fleuron()

Section breaks use a fleuron between two hairlines.

= How I Work

#lede[Closely, and for myself first.]

== Principles

+ *Mind the details.* The gap between two lines, the grain in a shadow.
+ *Please yourself first.* If the market likes it too, good.
+ *Fewer special cases.* Turn the problem around until the exception disappears.

#terminal(
  title: "ada@folio — ~/introduction",
  ("whoami", "ada — engineer, reader, occasional typesetter"),
  ("cat values.txt", "detail\ntaste\nhonesty"),
)

== Toolbox

#tags("Typst", "Rust", "Python", "LaTeX", "Photoshop")

#skills(
  ("Writing", 5),
  ("Typography", 4),
  ("Photography", 3),
  ("Systems design", 2),
)

```c
// Code blocks get a pale teal panel.
void remove_entry(entry **head, entry *target) {
  entry **p = head;
  while (*p != target) p = &(*p)->next;
  *p = target->next;
}
```

= Selected Works

#opening[Media cards carry a QR code, so the printed page still links out.]

#media(kind: "talk", title: [The Quiet Machine], url: "https://example.com/talks/quiet-machine", duration: "38 min")[
  A talk on calm, observable systems.
]

#media(kind: "repo", title: [folio], url: "https://github.com/earmer/folio")[
  The Typst template you're reading now.
]

#gallery(
  columns: 3,
  (placeholder(label: "fig 01", height: 100%), [Workshop]),
  (placeholder(label: "fig 02", height: 100%), [Proofs]),
  (placeholder(label: "fig 03", height: 100%), [Dashboard]),
)

= Gallery

#lede[Things seen through a lens.]

#featured(
  none,
  title: [Untitled, No. 1],
  meta: ("2026", "35mm", "f/8"),
)[A featured photograph. Pass `image("assets/...")` instead of `none`.]

#mosaic(
  columns: 4,
  (img: none, caption: [Large tile], cols: 2, rows: 2),
  (img: none, caption: [Window]),
  (img: none, caption: [Rain]),
  (img: none, caption: [Night sky], cols: 2),
  (img: none, caption: [Wide], cols: 2),
  (img: none, caption: [Station]),
  (img: none, caption: [Paper]),
)

= Epilogue

#opening[Thank you for reading. Write to me; I answer every letter, though sometimes slowly.]

#contact(
  email: "ada@example.com",
  web: "example.com",
  github: "example",
  location: "Somewhere, Earth",
)

#signoff(name: [Ada Wren], name-zh: "温雅", place: "Somewhere", date: "Autumn 2026", note: "sent with care")

#resume[
  #contact(email: "ada@example.com", phone: "+00 000 000 000", web: "example.com", github: "example")

  #cv-heading[Experience]
  #entry(title: [Engineer], org: [Northwind Systems], when: "2022 — now", where: "Remote")[
    - Led developer tooling across several product teams.
  ]
  #entry(title: [Developer], org: [Lantern Press], when: "2020 — 2022", where: "Remote", tags: ("Python", "LaTeX"))[
    - Wrote the manuscript-to-print pipeline.
  ]

  #cv-heading[Education]
  #entry(title: [BA, Comparative Literature], org: [Example University], when: "2016 — 2020")[
    Minor in formal logic.
  ]

  #cv-heading[Writing & Talks]
  #publications(
    ([The Quiet Machine], [Talk, Example Conf], "2025", "https://example.com/talks/quiet-machine"),
    ([On Reading Code Aloud], [Essay], "2023"),
  )

  #colophon[Set in Hoefler Text and Didot, with Menlo for the machine voice. Composed in Typst with folio.]
]
