#import "flow-book.typ" as book

// Remove the timestamp to ensure reproducible builds of the PDF.
#set document(date: none)

#set text(font: "Palatino")
#show math.equation: set text(font: "STIX Two Math")
#show raw.where(block: false): set text(fill: fuchsia)

#show: book.setup.with(
  title: "The Flow Book Template",
  subtitle: text(style: "italic")[Featuring side notes and more],
  title-head: "Typst Template for Books",
  author: "Leedehai",
  publisher: "The Typst Community",
  versioning: (build-date: none /*"[year]-[month]-[day]"*/, version: "v0.1.0"),
  paper-size: "us-letter",
  copyright-page: [#align(bottom)[© 2026 Leedehai.]],
  dedication-page: [#include "example-dedication.typ"],
  preface: [#lorem(200)],
  show-table-of-contents: true,
  appendices: (
    title-page: [#align(left + horizon, text(size: 3em)[Appendix])],
    chapters: (
      [#include "example-appendix.typ"],
      [
        = Another added article
        #lorem(500)
      ],
    ),
  ),
  show-index: true,
)

= Introduction
Welcome to the main body of the book. As you can see, the page numbering has restarted at 1.

We can easily drop a side note into the alternating margin reserved by our package#footnote[This is a footnote.] layout #book.note[This is a side note].

If you want to index a specific term, like Typst, you just call it like this #book.index[Typst] #book.index[$Omega$-vibration]. It will automatically appear in the Term Index at the back of#footnote[This is a footnote #lorem(20)] the book#book.note[This is a side note. #lorem(20)].

== Welcome

#lorem(200)#book.note(dy: -2em)[This is a side note. You see, you can move me higher than my anchor with `dy`.]

#lorem(200)#footnote[This is a footnote #lorem(20)]

Don't confuse DOG#book.index[DOG] and DoG#book.index[DoG].
This is a *laptop computer*#book.index("computer!laptop"), and
this is a _desktop computer_#book.index("computer!desktop").
Again #book.index("computer!desktop").
We have $integral x^2 dif x$ #book.index("Math!integral_of_x2", display: $integral x^2 dif x$)

== Further words and words and words

A#book.note[This is a side note. #lorem(20)] #lorem(200)

#lorem(200)

= Discussion But With A Very Long Title. I Mean, Really _Long_. How Long Is It? Don't Bother To Meansure, But Trust Me It Is Long

This chapter talks about Typst#book.index(index-type: "Start")[Typst]
== Image

#lorem(200)#footnote[This is a footnote #lorem(20)]

=== Figure

#lorem(200)#footnote[This is a footnote #lorem(20)]

== CeTZ

#lorem(200)#footnote[This is a footnote #lorem(20)]

== Table

#lorem(200)#footnote[This is a footnote #lorem(20)]
This wraps out discussion on Typst#book.index(index-type: "End")[Typst]

= More Discussion Without Subsections

#lorem(500)
Dog#book.index[dog] here.

= Conclusion

#lorem(200)#book.note[This is a side note. #lorem(20)]#footnote[This is a footnote.]

Desktop computer here#book.index("computer!desktop"). Also a dog#book.index[dog] here.

== Practical implications

#lorem(200)

== Futher works

#book.quote[#lorem(20)]

#lorem(200)#book.note[This is a side note. #lorem(20)]#footnote[This is a footnote.]

#book.quote(attribution: [Newton])[#lorem(20)]
