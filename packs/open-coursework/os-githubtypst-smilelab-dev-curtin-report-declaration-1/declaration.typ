#let declaration(
  title: [],
  author: (),
  project: [],
  project-type: [],
  place-of-authorship: [],
  date: [],
  lang: [],
  human-ethics-approval: none,
  animal-ethics-approval: none,
) = {
  set page(numbering: none, header: none)
  set align(left)

  let authors_list = if type(author) == array { author } else if type(author) == str { (author,) } else { () }

  let doc_type_str = if project-type != [] and project-type != none {
    if type(project-type) == str { lower(project-type) }
    else { "thesis" }
  } else { "thesis" }

  set text(lang: "en")
  [
    #text(size: 16pt, weight: "bold")[Declaration]
    #set par(justify: true)

    #v(1em)

    To the best of my knowledge and belief this #doc_type_str contains no material previously published by any other person except where due acknowledgment has been made.

    This #doc_type_str contains no material which has been accepted for the award of any other degree or diploma in any university.
  ]

  if human-ethics-approval != none and human-ethics-approval != [] [
    #v(2em)
    *Human Ethics*

    The research presented and reported in this #doc_type_str was conducted in accordance with the National Health and Medical Research Council National Statement on Ethical Conduct in Human Research (2007) – updated March 2014. The proposed research study received human research ethics approval from the Curtin University Human Research Ethics Committee (EC00262), Approval Number #human-ethics-approval
  ]

  if animal-ethics-approval != none and animal-ethics-approval != [] [
    #v(2em)
    *Animal Ethics*

    The research presented and reported in this #doc_type_str was conducted in compliance with the National Health and Medical Research Council Australian code for the care and use of animals for scientific purposes 8th edition (2013). The proposed research study received animal ethics approval from the Curtin University Animal Ethics Committee, Approval Number #animal-ethics-approval
  ]

  v(6em)

  if authors_list.len() > 1 [
    *Signatures:*
    #v(1em)
    #block(width: 90%)[
      #grid(
        columns: (auto, auto),
        column-gutter: 2em,
        row-gutter: 3em,
        ..authors_list.map(name => (
          [#name:], [#line(length: 15em, stroke: 0.5pt)]
        )).flatten()
      )
    ]
    #v(3em)
    Date: #if type(date) == datetime { date.display("[day] [month repr:long] [year]") } else { date }
  ] else [
    #grid(
      columns: (1fr),
      row-gutter: 3em,
      [
        Signature: #line(length: 40%, stroke: 0.5pt)
      ],
      [
        Name: #if authors_list.len() > 0 { authors_list.at(0) } else { author }
      ],
      [
        Date: #if type(date) == datetime { date.display("[day] [month repr:long] [year]") } else { date }
      ]
    )
  ]
}
