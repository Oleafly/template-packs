#import "cecc.typ": cecc, author, institute, listing, cecc_email, cecc_emails

#let confnameshort = "CECC 2024"

#show: cecc.with(
  title: [24th Central European Conference on Cryptology --- Extended Abstract],
  subtitle: [Template class for submissions],
  authors: (
    author(
      "Piotr Jankowski",
      institutes: (1, 2),
      emails: ("pjankowski@pwr.edu.pl", "pjankowski@wat.edu.pl"),
      orcid: "1234-1234-1234-1234",
    ),
    author(
      "Maciej Wieszczyński",
      institutes: (2,),
      emails: ("mwieszczynski@wat.edu.pl",),
      orcid: "3333-3333-3333-3333",
    ),
    author(
      "Jan Kowalski",
      institutes: (2,),
      emails: ("jkowalski@wat.edu.pl",),
      orcid: "2222-2222-2222-2222",
    ),
    author(
      "Andrzej Jaworski",
      institutes: (3,),
      emails: ("ajaworski@nask.pl",),
    ),
  ),
  institutes: (
    institute(
      "Politechnika Wrocławska, Wrocław, Poland",
      email: "pjankowski@pwr.edu.pl",
    ),
    institute(
      [Wojskowa Akademia Techniczna#footnote[Sponsored by XYZ.], Warsaw, Poland],
      email: cecc_emails(
        "wat.edu.pl",
        ("pjankowski", "mwieszczynski", "jkowalski"),
      ),
    ),
    institute(
      "Naukowa i Akademicka Sieć Komputerowa, Warsaw, Poland",
      email: "ajaworski@nask.pl",
    ),
  ),
  keywords: (confnameshort, "Cryptography", "Template", "Abstract"),
  running_authors: "Piotr Jankowski et Al.",
  running_title: "Extended Abstract Template",
  check-page-number: false,
)

#heading(numbering: none)[Introduction] // Like `\section*`

This is the official template for submitting extended abstracts to 24th Central European Conference on Cryptology (#text(style: "italic")[CECC] 24). You can download it and use it locally or clone and use it directly on the Typst web app.

== Title and keywords

Provide the title of the submission using the `title: ...` parameter in the `#ceccsub` function. Optionally, also provide a subtitle using the `subtitle: [...]` parameter. Provide a list of keywords using the `keywords: (...)` parameter with elements separated by commas. In case of macro keywords or keywords that are not showing in the PDF metadata section, this template uses the same list for both display and metadata.

== Authors and institutions/affiliations

To provide a list of authors use the `authors: (...)` parameter, with authors defined using the `author(...)` function and separated by commas. To link an author with an institution/affiliation use the `institutes: (...)` parameter within the `author` function, where the numbers are the indices of the institutions in the `institutes` list (multiple comma-separated affiliations can be added). To create a clickable *orcid* ID link, use the `orcid: "..."` parameter within the `author` function. Please note that the `institutes` parameter should proceed the `orcid` parameter. Example:

```typst
#ceccsub(
  // ...
  authors: (
    author(
      "Piotr Jankowski", institutes: (1, 2), orcid: "..."
    ),
    author(
      "Maciej Wieszczyński", institutes: (2), orcid: "..."
    ),
    author(
      "Jan Kowalski", institutes: (2), orcid: "..."
    ),
    author(
      "Andrzej Jaworski", institutes: (3)
    )
  ),
  // ...
)
```

To add institutions/affiliations, use the `institutes: (...)` parameter with institutions defined using the `institute(...)` function and separated by commas. To provide more than one institution/affiliation use commas to separate the list entries. For each affiliation you can provide an email address using the `email: cecc_email(...)` parameter. In case of multiple email addresses (e.g. multiple authors from one institution) use the `email: cecc_emails("domain", ("local-part_1", ..., "local-part_n"))` parameter. Example:

```typst
#institute(
  "Inst 1, City, Country", email: cecc_email("pjankowski@inst1.pl")
),
#institute(
  "Inst 2, City, Country", email: cecc_emails("inst2.de", ("pjankowski", "mwieszczynski", "jkowalski"))
),
#institute(
  "Inst 3, City, Country", email: cecc_email("ajaworski@inst3.com")
)
```

== Headers

By default, the left header shows all of the authors and the right header shows nothing to accommodate the author list. To change the left header, use the `running_authors: "..."` parameter and provide a short author list. To change the right header, use the `running_title: "..."` parameter and provide a short title of the submission.

== Other information

Bibliography/citation style is not enforced but the *plain* `bibtex` style is preferred. The compilation will fail if the submission is longer than 4 pages.
Please start the submission with a non-numbered _Introduction_ section `#heading(numbering: none)[Introduction]`.

= Section...

#bibliography(
  "bibliography.bib",
  title: "References",
  style: "association-for-computing-machinery",
  full: true,
)
