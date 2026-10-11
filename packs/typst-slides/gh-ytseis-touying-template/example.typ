#import "@preview/polylux:0.4.0": *
#import "@preview/touying:0.6.1"
#import "theme.typ": *

#show: mytheme.with(
  aspect-ratio: "16-9",
  font-en: "Noto Sans",
  font-ja: "BIZ UDPGothic",
  font-math: "Noto Sans Math",
  config-info(
    title: [Title],
    subtitle: [Subtitle],
    author: [Author],
    institution: [Institution],
    header: [Conference\@Location (Date)]
  )
)

#title-slide()

= First Section

== Usage

```typst
#import "@preview/touying:0.6.1"
#import "theme.typ": *

#show: mytheme.with(
  aspect-ratio: "16-9",
  font-en: "Noto Sans",
  font-ja: "BIZ UDPGothic",
  font-math: "Noto Sans Math",
  config-info(
    title: [Title],
    subtitle: [Subtitle],
    author: [Author],
    institution: [Institution],
    header: [Conference\@Location (Date)]
  )
)
```
Note that `*text*` is modified to *underline with the secondary color*, not #text(weight: "bold")[bold].

== Example

Here is an example of a displayed equation:
$
  a x^2 + b x + c = 0,
$
$
  x = (-b plus.minus sqrt(b^2 - 4 a c)) / (2 a), quad x != 0
$ <eq:2>

@eq:2 is the *quadratic formula*.

```typst
Here is an example of a displayed equation:
$
  a x^2 + b x + c = 0,
$
$
  x = (-b plus.minus sqrt(b^2 - 4 a c)) / (2 a), quad x != 0
$ <eq:1>

@eq:1 is the *quadratic formula*.
```

== Speaker notes with pdfpc

You can add speaker notes using `#pdfpc.speaker-note()`.

```typst
== Speaker notes with pdfpc

You can add speaker notes using `#pdfpc.speaker-note()`.

#pdfpc.speaker-note("This is a speaker note.")
```

The `polylux2pdfpc` command generates a `.pdfpc` file.

```bash
typst compile example.typ # create example.pdf
polylux2pdfpc example.typ # create example.pdfpc
pdfpc example.pdf -w both # start a presentation with speaker and main windows
```

=== Notes:
- pdfpc v4.5.0 did not display speaker notes, possibly because of `pdfpcFormat: 2`.
- Installing pdfpc v4.7.0 from #link("https://github.com/pdfpc/pdfpc/releases", text(fill: blue, underline([GitHub Releases]))) solved this issue.

#pdfpc.speaker-note("This is a speaker note.")

---

Example of the speaker view and the main presentation:

#align(horizon)[
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 1em,
    [
      #figure(
        image("figure/speaker-view.png"),
        caption: "Speaker view",
        numbering: none,
      )
    ], [
      #figure(
        image("figure/main-presentation.png"),
        caption: "Main presentation",
        numbering: none,
      )
    ]
  )
]

#show: appendix

= Appendix

== Appendix 1

Note that appendix is *not counted* in the total page count.

#lorem(30)

#lorem(30)
