= Introduction <Introduction>

In @Introduction you should explain
the motivation behind your work,
its broad context,
and your inspirations.
Explain the problem
and the path that you took
to solve it.

A good introduction
is usually written
quite late in the thesis' development,
because throughout your work process
some important details may be subject to change.

Between chapters and sections (or subsections)
always introduce few lines worth of a paragraph
to introduce the reader
to the new topic.
Avoid "gluing"
higher-level and lower-level headings.
Always separate them
using some text.

== Goals <Goals>

Introduce the goals of the work.
What kind of research and/or tool
this work is supposed to produce.

What business or academic value
has or will your work
produce?

== Conventions

Explain the conventions used
in your work.
For example,
describe how do you deal with
inline code
or with code listings
that contain lines
which are too long to be rendered
as a single one
in this document.

Another example would be
a description of
your very own notation
you developed
in your pioneering work.

An example of a convention
would be
that in this document,
chapters that contain
the #sym.dagger symbol
are "this-document-specific",
and should _not_ appear
in your thesis.
The rest of them
(without #sym.dagger)
should be included
in your document.

=== Glossary of terms

If you are using
niche terms
(or ones that you either invented
or adapted in a non-standard way),
this is the place
to explain their meaning.
In other words,
here you provide definitions.

== Results

Briefly introduce
the results of your work.
What was accomplished
and what was not.

== Document structure

Explain how is your document structured
by briefly summarizing
all the chapters.
This section is usually filled in last.

== Example: Chapters, sections, and subsections #sym.dagger <chapters>

Together, they are called _headings_.
Use appropriate commands to introduce them.
Use enumerations or itemizations when it makes sense---it elevates the readability of your work.
For example, here is how we introduce specific types of sections:
+ Top-level---_chapters_.
  Use `= Chapter Name` to introduce them.
+ Lower-level---_sections_.
  Use `== Section Name` to introduce them.
  For example,
  this very paragraph is a part of a section.
  Namely---@chapters.
+ Lowest-level---_subsections_.
  Use `=== Subsection Name` to introduce them.

Headings are not titles,
so Do Not Use Title Case.

== Styling #sym.dagger

Here,
we will briefly explain
the appropriate styling for theses.
For starters,
let us explain the difference between
different dashes.

=== Dashes #sym.dagger

- Hyphens (-) are inputted
  by using a single `-` character.
  They are used
  to form interconnected words
  such as _low-level_ or _first-person_.
- En dashes (--) are inputted
  by using `--`.
  They are very rarely used.
  Mainly for specifying ranges, e.g.:
    - pages 10--26
    - we are open 6:00 a.m.--9:00 p.m.
    - saying such things
      was illegal in 1670--1680
- Em dashes (---) are inputted
  by using `---`.
  They sometimes replace commas
  or changes of text direction, e.g.:
    - This is very difficult---we are going to need to step down.
    - My good friend---John Doe---turned out very successful.

=== Form and style #sym.dagger <Form>

It is preferable
to use infinitives
to describe
the work done.
For example:

#quote(attribution: "Some source")[
    #set text(fill: green)
    Sample Typst template
    has been prepared
    to make it easier for PJAIT's students
    to write their theses documentations.
]

First-person pronouns
should be avoided:

#quote(attribution: "Some other source")[
    #set text(fill: red)
    I created a simple Typst template
    to make it easier for PJAIT's students
    to write their theses documentations.
]

On rare occasions,
the author may wish
to introduce a personal opinion.
In such cases,
a third-person form
should be used:

#quote[
    #set text(fill: green)
    Author of this Typst template
    is certain that this document
    will be of much help
    for PJAIT's students.
]

Contractions
(_aren't_, _can't_, _wouldn't_)
should be avoided.
They are considered informal.
If you cannot force yourself
to not use them,
use a `'[^ s]` regex
to locate them in your project
and replace them one by one.

=== Quoting #sym.dagger

In @Form,
the colored sections were _quoted_.
Styles of such quotations
are automatically handled
by using
the appropriate `#quote` function.

=== Colors #sym.dagger

The usage of colored text
should usually be avoided
(except for code listings and inline code)
unless there is a very strong reason
to make an exception.
Consistency matters,
and it is usually better
to use _`_the standard tool for emphasis_`_
rather than colors.

For example,
you should not be using colors
like they were used
in @Form.

=== Emphasis #sym.dagger

Since this document uses
(and thus so should your thesis)
serif font,
use _italics_ for gentle emphasis
and *bold* for heavier emphasis.

Do #underline[not] underline the text.
Pretty much at all. @PracticalTypography

In addition to that,
try to avoid combining
said styles.
#strong(emph[It may be surprising,
but this style,
instead of engaging the reader’s attention,
tends to make them weary
and inclined to skip this section altogether.
Do yourself a favor
and answer this question---which part stands out more:
This one?])

#v(0.5in)

Or this one?

#v(0.5in)

=== Blocks of text #sym.dagger

Do not introduce overly lengthy paragraphs.
If it exceeds a third of a page,
break it down.
Use enumerations, itemizations, figures, inline code, code listings, etc.,
which make the text more attractive.
Do not overdo it though.

If a given chapter or (sub)section takes more than 3 pages,
it is appropriate to divide it
into couple of lower-level sections.
Each chapter (top-level) starts on a new page
(preferably oddly-numbered
#footnote[So that when you physically read the printed thesis,
new chapter is always on the right-hand side.
This is handled automatically.]
).
This does not concern lower-level sections.
An exception can be made
if a significant number of figures, listings, etc. are present.

=== Typos #sym.dagger

Pay attention to the quality of your text---both in terms of substantive value
and form of the text.
Use correct punctuation and a spell checker to detect typos.

=== Customizing the style #sym.dagger

Want to change the font?
Maybe the font size?
Letter spacing?
Margins?
Table styles?
Fine, but consult your supervisor first.
Some things are subject to personal taste,
while others are a non-negotiable standard.
Between those,
there lies a grey area
of things that _may appear "cool"_,
but could possibly be detrimental
to good typography.

=== Bibliography details #sym.dagger

Bibliography items must be correctly referenced.
Use the appropriate template and a `.bib` file.
Pay attention to
how those files are structured.
Use appropriate types,
and supply necessary details.

Use a standardized package for bibliography
and cite when appropriate. @TypstDocs
Each bibliography position must be referenced
in the text.
It is unacceptable to list works in the bibliography
that are not mentioned in your work.
You must show how exactly the given cited position
was impactful for this work.

Notice that both the first citation
and the chapter references
are clickable and automatically generated.
We use `@thingToReferenceOrCite` syntax for that.
