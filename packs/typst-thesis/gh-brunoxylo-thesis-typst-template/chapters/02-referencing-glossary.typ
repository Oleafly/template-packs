#import "@preview/glossarium:0.5.3": gls, glspl
#import "../thesis_typ/helper-functions.typ": *

= Referencing and Glossary Example
<ch:referencing:glossary>

#nameref(<ch:intro>) is referenced in the code with a custom nameref function to display its title instead of its number.
You can also reference chapters, figures or bib entries with typst built in reference feature to display them with their number  instead like here @ch:listings-graphics.
Additionally you can omit the default prefix (chapter or figure) when referencing like here @ch:listings-graphics[]. Alternatively you can replace it with a custom one like here @fig:bubble_sort[Custom prefix]. With the same method you can also reference literature entries like here @bruegge2004object.

\

== Glossary Usage
You can use the glossary function to reference glossary entries like here #gls("API"). \
On default it will display the long form for the first reference and the short form for all following references like here #gls("API"). \
You can also force the short form like here #gls("DRY", long: false) or the long form like here #gls("DRY", long: true). \

=== Plural Forms
You can also reference plural forms of glossary entries like here #glspl("UML", long: false) or the long form like here #glspl("UML", long: true). \
Keep in mind that to use these plural forms you have to define them in the glossary list explicitly. \
