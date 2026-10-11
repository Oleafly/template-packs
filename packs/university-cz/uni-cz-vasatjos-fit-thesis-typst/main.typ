#import "./template/template.typ": *
#import "@preview/glossarium:0.5.10": Gls, Glspl, gls, glspl, make-glossary, print-glossary, register-glossary
#import "@preview/algo:0.3.6": algo, code, comment, d, i
#import "./acronyms.typ": entry-list


#show: template.with(
    meta: (
        title: "My Very Amazing Thesis Title",
        author: (
            name: "Matěj Novák",
        ),
        // WARN: Make sure the date is the same on the submitted and printed version
        submission-date: datetime.today(),
        // true for bachelor's thesis, false for master's thesis
        bachelor: true,
        faculty: "Information Technology",
        department: "Applied Mathematics",
        programme: "Informatics",
        specialization: "Artificial Intelligence 2021",
        supervisor: "Ing. Jan Novotný, Ph.D.",
    ),
    font: "New Computer Modern",

    // set to true if generating a PDF for print (shifts page layout, correctly aligns odd/even pages,...)
    two-sided: false,

    // change based on abstract length or your preference
    two-page-abstract: false,

    // change based on your assignment.pdf length
    two-page-assignment: false,

    // assignment before title page, make sure to call compile_thesis.sh with the correct flags
    title-first: false,

    abstract-en: [
        #lorem(100)
    ],

    abstract-cz: [
        #lorem(100)
    ],

    keywords-en: [
        #lorem(20)
    ],
    keywords-cz: [
        #lorem(20)
    ],

    acknowledgement: [
        #lorem(50)
    ],

    // https://courses.fit.cvut.cz/SZZ/dokumenty/index.html#_dokumenty
    declaration: [
        #lorem(100) // Insert correct license text

        #lorem(100) // Insert AI useage declaration
    ],
)

#show: make-glossary
#register-glossary(entry-list)


#heading([Introduction], numbering: none)

Here, you can use shortcuts like #gls("ai") or plural shortcuts like #glspl("nn").

Once a shortcut such as #gls("nn") is used again, the glossary engine
will correctly handle how they get displayed for you. Note that shortcuts
can't be used in figure captions. If you want to do something more advanced,
read the `glossarium` docs.

Another thing you can do is reference future chapters, like @chapter:template-intro, where
we discuss how to use the template further.
You can also reference literature this way:  @Adam @python.
This is the end of the introduction, only placeholder text follows.

#lorem(100)

#heading([Goals], depth: 2, numbering: none)

#lorem(100)


= Template Features <chapter:template-intro>

In this chapter, we'll introduce more features of the template with code snippets,
figures, tables, and more.

== Using figures <chapter:rl-intro>

You can use 3 default figure types: `image`, `table` and `raw`. A custom
pseudocode type `algo` is also available, but needs to be specified in the figure
function.

You can place a figure exactly where you want with `placement: none`, like so:
#figure(
    image("images/kings.jpg", width: 80%),
    caption: [Manually placed figure],
    placement: none,
)

#start-par You can also use automatic placement, which puts the figures either
on top or on the bottom of a page. That is how @alg:auto-placed is shown.
#figure(
    algo(
        title: [Example algorithm],
        parameters: ([some_parameter], $alpha$),
        line-numbers: false,
    )[
        for k in 1..10:#i\
        print($alpha$ $dot$ some_parameter)
    ],
    caption: flex-caption(
        [A short algorithm caption],
        [A very very very very very very very long algorithm caption],
    ),
    kind: "algo",
    supplement: "Algorithm",
) <alg:auto-placed>

=== Short And Long Captions

You may have noticed the `flex-caption` function in the @alg:auto-placed
definition. A thing that Typst doesn't handle by itself are short and long captions.
If you want the text shown in the document to be different than the one in
the outline, you can use this function to define 2 different captions for
a figure.

=== Tables and code listings

Just for the sake of completeness, this section simply shows what code listings
and tables look like in @tab:weight and @code:hello.
#figure(
    table(
        columns: 2,
        align: (left, center),
        [ *Person* ], [ *Weight* ],
        [ Me ], [ 85 kilograms],
        [ Your mother ], [ 100 000 tons ],
    ),
    caption: [Scientific findings],
    placement: none,
) <tab:weight>

#figure(
    ```cpp
    unsigned long fibonacci(const long n) {
        if (n == 0)
            return 0;
        if (n == 1)
            return 1;
        return fibonacci(n - 1) + fibonacci(n - 2);
    }
    ```,
    caption: [Very slow code, AG1 team would cry],
    placement: none,
) <code:hello>

You can also see that each figure type has its own numbering
and that the numbers are inherited from the level 1 headings.

== Other Bonuses And Tips

Another part of the template is the `#start-par` variable. This can be useful
if you want to indent the start of a paragraph manually, which is sometimes needed,
for example when you want to end your paragraph with a list.
- Item 1
- Item 2

There is no way to get this line indented without doing it manually as this
sentence shows.

With math blocks, you can get a paragraph indent by using a backslash.
$
    bold(theta)_(t+1) = bold(theta)_t + alpha nabla J(bold(theta)_t)
$

This is text without a backslash after a math block. #lorem(10)

$
    bold(theta)_(t+1) = bold(theta)_t + alpha nabla J(bold(theta)_t)
$\

This is text with a backslash after the math block. That is all, enjoy using
a superior typesetting system.


= Placeholder Chapter

#lorem(200)

== Placeholder Section

#lorem(60)

#lorem(140)

== Another Placeholder Section

#lorem(100)

#lorem(40)


#heading([Conclusion], numbering: none)

#lorem(400)


#bibliography("bibliography.bib")


// all h1 headings from here on are appendices
#show: start-appendix

= Acronyms

#print-glossary(
    entry-list,
    show-all: false,
    user-print-glossary: acronym-table,
    disable-back-references: true,
)

= Contents of attachments

#[
    #import "@preview/treet:0.1.1": *

    #set text(font: "DejaVu Sans Mono", size: 9pt)
    #let dots() = box(width: 1fr, repeat[.])

    // project structure
    #tree-list[
        - file #dots() a description of the file
        - dir/ #dots() a description of the directory
            - file-in-dir #dots() another description
        - another-dir/ #dots() another description
    ]

]
