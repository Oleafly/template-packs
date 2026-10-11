/// variables
#let university_name = [Nombre de la universidad]
#let title = [Título del documento]
#let assignment = [Tarea X]
#let semester = [202X-X]
#let subject_name = [Nombre del ramo]
#let subject_acronym = [Sigla del ramo]
#let author = [Autor]
#let role = [Identificador del autor]

/// function for create a coverpage
///
/// -> none
#let coverpage(
  /// name of the university
  /// content
  university_name: university_name,
  /// document title
  /// content
  title: title,
  /// type of assignment
  /// content
  assignment: assignment,
  /// assigment semester
  /// content
  semester: semester,
  /// name of the subject
  /// content
  subject_name: subject_name,
  /// acronym of the subject
  /// content
  subject_acronym: subject_acronym,
  /// author name
  /// content
  author: author,
  /// role of author (like an identifier)
  /// content
  role: role
) = {
  place(
    center + top
  )[
    #image("img/logo_col.pdf", width: 40%)

    #let spacing = 25pt

    #text(
      size: 18pt, 
      weight: "semibold")[
        #university_name
      ]

    #v(spacing)

    #text(
      size: 16pt
    )[
      #subject_acronym \
      #semester
    ]

    #v(spacing)

    #text(
      size: 18pt,
      weight: "semibold"
    )[
      #assignment \
      #title
    ]

    #v(spacing)

    #text(
      size: 16pt,
    )[
      #author \
      #role
    ]
  ]
}

