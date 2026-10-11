= Introduction <chap-intro>

// The upstream LaTeX sample includes a commented-out figure here:
// `main/graphics/a_blowup.pdf`, captioned "This is a caption".

Here you can introduce the field, survey past results, give context, use
citations of course... (e.g. @CLR). It is probably worthwhile to clarify the
goals or targets of the research and describe the process, unless this is done
later.

You can also introduce _a key concept_ (or rather, several) without formally
defining them until later on.

#heading(level: 2, numbering: none, outlined: false)[An unnumbered subsection]

You may want to break up the intro into parts with titles. Subsectioning
without numbering is an option you might want to consider.

Some people include a specific section overviewing the results ("In Chapter
so-and-so, we will see how etc.") which is also a way of describing the
structure of the thesis. But this is not necessary.

#heading(level: 2, numbering: none, outlined: false)[Thesis options and appearance]

Please note that the Technion Typst template has several options when you use it,
such as:

- `draft: true` to avoid the margins necessary for proper binding when you make
  the final print.
- `defense: "before"` makes the personal acknowledgements invisible; use this to
  print the copies you submit initially to the grad school for sending to the
  opponent panel, i.e. thesis readers (who shouldn't see those parts). For the
  final submission, after having successfully defended, use `defense: "after"`.
- `abbreviations: false` means no notation and abbreviations list will be
  included in the thesis.

#heading(level: 2, numbering: none, outlined: false)[Hebrew font]

The Typst template uses a Hebrew-capable font stack for Hebrew text, including
the David CLM font family.
CLM is a shorthand for "Culmus" (#text(font: "David CLM", lang: "he", dir: rtl)[קולמוס])
-- the name of a freely-available Hebrew font package. This repository vendors
the required Hebrew fonts under `fonts/vendor`, and the build script passes
that directory to Typst. If you compile manually, pass the same directory with
Typst's `--font-path` option, or install the fonts as system fonts.

#heading(level: 2, numbering: none, outlined: false)[Setting thesis meta-data and publication information]

The template call used to generate this document accepts several fields you can
use to set information regarding your thesis, which is used in the title pages
and elsewhere in the front matter. Most fields have an English and a Hebrew
variant stored under `english` and `hebrew` keys. Examples:

- `title: (english: ..., hebrew: ...)`
- `author: (english: ..., hebrew: ...)`
- `dates: (jewish-english: ..., jewish-hebrew: ...)`
- `dates: (gregorian-english: ..., gregorian-hebrew: ...)`
- `publication-info: (english: ..., hebrew: ...)`

The file `thesis.typ` contains the template invocation with these fields and
some additional information about them.
