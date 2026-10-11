// ═══════════════════════════════════════════════════════════════════════════
// CHAPTER 1 — Introduction
// ═══════════════════════════════════════════════════════════════════════════
//
// A chapter is an ordinary Typst file containing plain content. main.typ pulls
// it in with `#include "chapters/01-introduction.typ"`, which is why there is
// no boilerplate at the top: the styling, page setup and numbering all come
// from main.typ.
//
// The one thing that is NOT inherited are imports — those are per file. So if
// a chapter uses a helper such as `todo` or `note`, it imports it itself:

#import "../lib/blocks.typ": note, todo
#import "../lib/utils.typ": xref

// ─── The chapter heading. `<ch:introduction>` is a label; other chapters can
// point at it with @ch:introduction. ────────────────────────────────────────
= Introduction <ch:introduction>

This chapter tries to get you started in typst and this template. It explains the basic syntax, how to cite and more.

The typst documentation is very good, and you will find it helpful to read it alongside this template. The template itself is documented in the comments, and you can find a lot of information in the README.md file.

To start either delete the content of this file after reading it, or you create a new file in the `chapters` folder and point `preview.typ` at it.

== Text and headings

Typst markup is close to Markdown. You write `*bold*` for *bold*, `_italic_`
for _italic_, and `` `code` `` for `code`. A heading is one or more `=` signs
at the start of a line; the template numbers and styles them for you. Every
level-1 heading starts a new page.

A blank line starts a new paragraph. A single line break does not, which means you can keep one sentence per line in the source.
This is very pleasant when you are
comparing two drafts with `git diff`, and invisible in the output.

Lists work as you would expect:

- an unordered item, written with `-`
- another one
  - and a nested one, indented by two spaces

+ a numbered item, written with `+`
+ Typst counts these for you

Footnotes are written inline#footnote[Like this one. They are numbered
automatically and placed at the bottom of the page.] and need no further
bookkeeping.

== Citing literature

Citations come from `references.bib`. Write `@doe2020` to cite in text
@doe2020, or `#cite(<doe2020>, form: "prose")` to make the reference part of
the sentence: #cite(<doe2020>, form: "prose") showed the effect first. Several
sources at once are simply written one after another @doe2020 @mustermann2021
@knuth1984.

The bibliography at the end lists only the works you actually cited, sorted
and formatted according to the style set in `config.typ`.

== Acronyms

Acronyms are declared once in `lib/abbreviations.typ` and used with an `@`:
writing `@AUC` gives @AUC, and from the second use onwards it prints @AUC on
its own. Ask for a specific form when the sentence needs it — `@AUC:l` for the
long form (@AUC:l), `@AUC:s` for the short one (@AUC:s), `@BFE:pla` for the
plural (@BFE:pla). Only the acronyms you really used appear in the
List of Abbreviations at the end.

== Cross-references

Anything you label can be referenced. Labels are written in angle brackets (`<label>`)
right after the thing they name, and `@label` links to it: this is
@ch:introduction, the method is derived in #xref(<ch:theory>, [Theory Chapter]) and the numbers are in
#xref(<ch:results>, [Chapter 2]).

#note(title: "Referencing across chapters")[
  `@ch:results` fails to compile if that chapter is not part of the document, which is exactly what happens when you preview a single chapter with
  `preview.typ`. Use `#xref(<ch:results>, [Chapter 3])` instead where that
  matters: it links when the target exists — #xref(<ch:results>, [Chapter 3])
  — and prints the fallback text when it does not.

  To prevent any fallbacks from slipping into the final version, main.typ sets `#strict-xref.update(true)`.
  This makes a dangling `#xref` a compile error (as the normal `@label` would be).
  This prevents the compilation instead of silently printing the fallback. preview.typ leaves
  the switch off, and a single call can overrule it with
  `#xref(<x>, [text], strict: false)` — which is why the deliberately dangling
  #xref(<ch:nowhere>, [Chapter 9], strict: false) in this sentence still
  compiles.
]

== Notes to yourself

While writing you will want to leave reminders in the text. `#todo[...]`
renders them clearly:

#todo[
  Rewrite this section once the last measurement series is finished, and check
  whether @mustermann2021 is really the right reference here.
]

Two switches in main.typ decide what becomes of them.
`#show-todos.update(false)` removes every note from the PDF at once, which is
what you want for a clean draft to send to someone. And
`#strict-todos.update(true)` refuses to compile the thesis at all while a
single note is left, listing every one of them in one error messagee.
Hidden notes will still trigger the compile error, so you cannot forget them by accident.