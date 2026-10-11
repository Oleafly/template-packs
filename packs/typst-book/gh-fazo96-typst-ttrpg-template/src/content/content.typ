// This file contains the main content of your book.
// From this file you will include all the content files for your book.

#import "@preview/markly:0.3.0"
#import "../variables.typ": title, author, subtitle, version, download, url, title-font, body-font
#import "../template.typ": ttrpg-template
#import "../utils.typ": page_illustration

#let ttrpg-book(language, markly-context, contents, pagetext) = {
  let src = "./" + language + "/"
  show: markly.page-setup.with(markly-context)

  show: ttrpg-template(
    markly-context,
    contents,
    pagetext,
    [
      // Include all chapters in order
      // Note that some illustrations are shown conditionally because
      // different languages or POD vs Digital can skew the page count
      // so to have the illustration on the left of a new chapter, sometimes
      // we need to add or remove illustrations.

      #include src + "example.typ"
    ],
  )
}
