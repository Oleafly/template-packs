// For example, styles like font and font size can be set like this.
#set text(size: 10pt, font: ("TeX Gyre Termes", "Nimbus Roman", "Times New Roman", "Noto Serif CJK SC"))
#set page(paper: "a4", margin: 10mm)
// When actually submitting, do not include any style settings. But if you forget to remove them it's not a big deal — the editors will take care of it.



= Abstract
Abstract is the primary public description of the article; it is not pumping elephant.

Use an empty line to separate multiple paragraphs.



#show: columns.with(2)
#set heading(numbering: "1.1.1.1.1.1     ")


= Table of Contents
== Main text
The main text is named `manuscript.typ`.

== Metadata
Refer to `info.toml` to provide the editors with author, affiliation, and other information.

== Attachments
If building the PDF requires any attachments (for example images), place them in the `assets` directory. Nested directories are allowed.




= Writing with Typst

Writing an article in Typst is easy. If you need a WYSIWYG editor, you can use its official web app#footnote[https://typst.app/].



== Code Block



```sh
for img in example_typst/assets/*.jpg; do
  magick "$img" -resize x500 "$img"
done
```

== Images


#figure(image("assets/gokhan-1-unsplash.jpg"), caption: [
  Photo by
  _Gökhan E._
  on Unsplash
])
#figure(image("assets/harshil-2-unsplash.jpg"), caption: [
  Photo by
  _Harshil Gudka_
  on Unsplash
])
#figure(image("assets/jason-3-unsplash.jpg"), caption: [
  Photo by
  _Jason Hawke_
  on Unsplash
])
