#import "kit-template.typ": *



#show: doc => thesis(
  title: "A thesis example",
  abstract: (german: [Dies ist die Zusammenfassung in Deutsch. Weiter geht es, um den Platz zu füllen, mit #lorem(200)], english: [This is the english abstract. To fill further space, we'll continue with #lorem(200)]),
  institute: (department: "Informatics", institute: "KASTEL – Institute of Information Security and Dependability"),
  author: (firstname: "My", lastname: "Name"),
  examiners: ("Prof. A", "Prof. B"),
  advisors: ("Prof. C", "Dr. D"),
  time: (from: "XX. Month 20XX", to: "XX. Month 20XX"),
  sign: (loc: "My city", date: "XX. Month 20XX"),
  doc
)
= Introduction
This is the nonofficial typst template for Bachelor’s and Master’s theses at SDQ. For more information
on the formatting of theses at SDQ, please refer to #link("https://sdq.kastel.kit.edu/wiki/", "Ausarbeitungshinweise") or to your advisor.

== Spacing and indentation
To separate parts of text in Typst, please use two line breaks in your source code.
They will be set with correct indentation.
You are also encouraged to put only one sentence per line for easier comparison with diff tools. Do not use
- `#v()`

TODO: figure out, how typst behaves with `\`, `#par`

== Citation <sec:cite>
Typst can use BibTeX bibliography. 
Simply import your bibliography file using `#bibliography("references.bib")`
To cite some entry from your references, use 
- `@name`
- `#cite(<name>)`
- for multiple sources, use `@name1 @name2`

To provide an example, Palladio @becker2008a is referenced.

== Figures <sec:fig>
#figure(
  image("logos/sdqlogo.svg", width: 50%),
  caption: [The SDQ logo.]
) <fig:logo>
One can embed image files using the `image` function.
To add a caption and reference it, wrap the image in a `figure`.
An example is @fig:logo
== Tables <sec:tab>
Tables can be written using the table function.
Here is a small example, but refer to #underline[#link("https://typst.app/docs/reference/model/table/", "the documentation")] for more details.
#figure(table(columns: 2, 
[*Name*], [*Age*],
[John Doe], [42],
[Johanna Doe], [69]

),caption:[Some random names with random ages])<tab:ages>

== Formulas <sec:formula>
Formulas are surrounded by \$ signs.
A single dollar sign starts an inline math block, which can come in handy for referencing the variable $x in X$.
For larger math blocks, like formulas, use a single dollar sign followed by a whitespace character to start it and in inverse order to end it. An example is @calc:gauss
$
sum_(i=1)^100 i &= (100 dot 101)/2\
&=5050
$ <calc:gauss>

== Referencing
Referencing works similar to Citations (@sec:cite).
To reference some element, it first needs a label, which can be set by appending it to any element.
The syntax uses `<>`, e.g. 
```
= A heading <sec:heading>
In @sec:heading we see ...
```
One can reference sections (@sec:fig), Images (@fig:logo), Equations (@calc:gauss) and Tables (@tab:ages).
If defined as a figure kind, other things can be referenced as well.
The `tab:???`,`sec:???` is only a suggestion to easily see what type of figure one references.



= First Content Chapter
The content chapters of your thesis should of course be renamed. How many chapters you.

need to write depends on your thesis and cannot be said in general.
Check out the examples theses in the SDQ Wiki:

#underline[https://sdq.kastel.kit.edu/wiki/Abschlussarbeit/Studienarbeit"]

Of course, you can split this _.typ_ file into several files if you prefer.
== Some example content
#lorem(150)

#lorem(200)
=== More example content
#lorem(2000)

= Long Content Chapter
Introduction: #lorem(50)
== Long subchapter
#lorem(5000)
= Conclusion

#show: doc => appendix(doc)

= Appendix
== First Appendix section
#figure(image("logos/kitlogo_de_cmyk.svg"),caption:[A Figure])
...