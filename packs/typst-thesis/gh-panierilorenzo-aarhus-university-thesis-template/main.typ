// Copyright (c) 2025 Lorenzo Panieri <lorenzo.panieri@pm.me>
// See LICENSE file for details

#import "style.typ": appendix, body_numbering, intro_numbering, template
#import "imports.typ": ac, codly-init, init-acronyms, print-index

#show: codly-init

#show: doc => template(
  draft: true,
  bibliography_path: "bibliography.bib",
  doc,
)

#show: intro_numbering

#outline()
#pagebreak()

#heading([Acronyms], numbering: none)

#init-acronyms((
  // put your acronyms here, as a dictionary like:
  "AU": "Aarhus University",
))
#print-index(title: "", sorted: "up", used-only: true, row-gutter: 5pt)

#pagebreak()

#heading([Abstract], numbering: none)

This is a Typst template~@panieri-typst-template for a Master's thesis at #ac("AU"). It's original author is Lorenzo Panieri. It is especially suited for engineering programmes.

The template is self-documenting, see the short tutorial section below (@sec-tutorial) and the comments in the source code.

#pagebreak()
#show: body_numbering

= License

The source code of this template is protected under the terms of the MIT license, see `LICENSE.md`. You don't need to credit me in the generated PDF file of your thesis, but you must credit me and include a copy of the original license if you intend to distribute the source code of your thesis.

All fonts used in this template are protected by the OFL lincese, and the original license is given alongside the font files. If you copy the fonts from this repository you must also include the correspodning OFL license.

= How to Use This Template<sec-tutorial>

== The `template` Function

You can customize this template by setting some of the optional arguments of the template function at the top of this file. For instance:

```typst
#show: doc => template(
  draft: true,
  bibliography_path: "bibliography.bib",
  doc,
)
```

See the comments in the `style.typ` file for documentation of what each field does.

== University Logo

Remember to add the logo of your university, e.g. Aarhus University, as it is copyrighted and I can't distribute it with this template. Just replace `logo.svg` with the logo of your university, or set `logo_path` on the `template` function to point to your chosen logo.

== Page and Section Numbering

The main numbering of the pages should start on your first section, e.g. the introduction section. The pages before that are numbered using roman numerals.

`#show: intro_numbering` marks the start of the front matter, after the title page. Front matter pages are numbered with roman numerals.

`#show: body_numbering` marks the start of the main body of your thesis, and starts page numbering from 1 with arabic numerals. You should write all the front matter before calling this show rule.

`#show: appendix` marks the start of the appendix of your thesis, and the end of the main body of your thesis. It changes how section numbers are displayed, for example see @apx-some-appendix.

== Acronyms

Acronyms are managed using the `acrostiche` package, it allows you to automatically generate a glossary of acronyms like the one seen at the top of the page.

You can then insert acronyms in the text by using the `ac` and `acp` acronyms for singular and plural forms respectively.

== Code Blocks

Code blocks are automatically formatted using the `codly` package, you can import custom syntaxes through the template by setting the `syntaxes` field. You can reference listings by putting them in a figure, like @list-some-rust. Typst can automatically determine that this is a "Listing" and not a "Figure" and displays the reference text correctly.

#figure(caption: [This is a code block with some sample Rust code])[
  ```rust
  fn main() {
      for i in 1..=100 {
          match (i % 3, i % 5) {
              (0, 0) => println!("fizzbuzz"),
              (0, _) => println!("fizz"),
              (_, 0) => println!("buzz"),
              (_, _) => println!("{}", i),
          }
      }
  }
  ```
]<list-some-rust>

== Colors

The `style.typ` file also exposes a `palette` dictionary with some colors that are used across the template. You can freely edit these if you want a different look, for instance you could change the blue to the official Aarhus University blue. You should also use these colors in your figures instead of explicitly giving the color codes to make it possible to change the colors globally.

#pagebreak()

#show: appendix

= Some Appendix<apx-some-appendix>

#lorem(50)

#lorem(70)
