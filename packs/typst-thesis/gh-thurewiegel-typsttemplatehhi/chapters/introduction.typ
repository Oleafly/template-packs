#import "../dependencies.typ": *
#import "@preview/algorithmic:1.0.7"
#import algorithmic: style-algorithm, algorithm-figure
#show: style-algorithm

= The HHI Template

This template is structured so that all project-specific values live in `overview.typ`, while `main.typ` wires the document flow and includes chapter files.

Also check out `introduction.typ`, to see how the following chapter was implemented

= Basic functionality

== Compile The Thesis

Use the following command for a one-time PDF build:

```bash
typst compile main.typ thesis.pdf
```

Use watch mode during writing so the PDF updates automatically after each save:

```bash
typst watch main.typ thesis.pdf
```

== Create And Add Chapters

Create a new chapter file in the `chapters` folder
Add them to `main.typ` in the desired order with `#include "chapters/XX_chapter-name.typ"`.

== Use Abbreviations

Abbreviations are defined and registered in `abbreviations.typ`.

Example entry (already present):

```typ
	(
		key: "ngl",
		short: "NGU",
		long: "Not gonna lie",
	),
```

Reference an abbreviation in text with `@key`, e.g. `@ngl`.

== Use References <references>

Bibliography entries are stored in `bibliography.bib` and rendered automatically at the end of the thesis from `main.typ`.

To cite in text, use the citation key with `@key`, e.g. `@Upper1974`.

== Minimal In-Text Example

This sentence demonstrates both systems together: @ngl can be referenced like a glossary entry, and literature can be cited directly with @Upper1974.

== Cross references

Almost all elements in typst can be cross referenced using the `@key` syntax, just add a `<name>` to the element in question and reference it with `@name`. For example: @references and @imgsmiley

  

== Other things

Of course, this template allows for images, which can be added to the `graphics` folder and in cluded in chapters with `figure("graphics/image.png")`. For tables, use the `table` environment. For code listings, use the `raw` environment with the appropriate language for syntax highlighting, e.g. `raw("python")`.

#figure(
  image("../graphics/smiley.jpg", width: 100%),
  caption: [Cool smiley I found in "../graphics/" !],
) <imgsmiley>

Dont forget to save often and have fun!