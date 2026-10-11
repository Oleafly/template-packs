#import "page.typ": *
#import "template.typ": *
#import "@preview/hidden-bib:0.1.1": hidden-bibliography
#let data = yaml("../data.yaml")
#let name = data.name
#let document_date = datetime.today()

// #let private = (sys.inputs.private == "true")
#let private = true
#show: doc => configuration(doc, name, document_date)
#header(name, document_date)

#if (data.home_address != none and private == false) {
  contact_info("Home Address", data.home_address.line1, data.home_address.line2)
}

#if data.office_address != none {
  contact_info(
    "Office Address",
    data.office_address.line1,
    data.office_address.line2,
    data.office_address.line3,
  )
}

#if data.education != none {
  [= Education and Training]
  education(..(
    data.education.map(item => (
      start: item.start,
      end: item.end,
      degree: item.degree,
      university: item.university,
    ))
  ))
}

#if data.postgraduate_training != none {
  [= Postgraduate Training and Fellowship Appointments]
  date-block(..(
    data.postgraduate_training.map(item => (
      years: (item.start, item.end),
      content: [#item.content],
    ))
  ))
}

#if data.keys().contains("military_service") {
  [= Military Service]
}
#if data.keys().contains("faculty_appointments") {
  [= Faculty Appointments]
}
#if data.keys().contains("administrative_appointments") {
  [= Hospital and Administrative Appointments]
}

#if data.keys().contains("special_certifications") {
  [= Special Certifications]
}

#if data.keys().contains("licensure") {
  [= Licensure]
    date-block(..(
        data.licensure.map(item => (
        years: [N/A],
        content: [#item.content],
        ))
    ))
}

#if data.keys().contains("awards") {
  [= Awards, Honors, and Membership in Honorary Societies]
  date-block(..(
    data.awards.map(item => (years: (item.year), content: [#item.content]))
  ))
}

#if data.keys().contains("memberships") {
  [= Memberships in Professional and Scientific Societies]
  if data.at("memberships").keys().contains("national") {
    [== National Societies]
    list(
      indent: 1in,
      marker: "",
      ..(data.memberships.national.map(item => [#item])),
    )
  }
  if data.at("memberships").keys().contains("local") {
    [== Local Societies]
    list(
      indent: 1in,
      marker: "",
      ..(data.memberships.local.map(item => [#item])),
    )
  }
}

#if data.keys().contains("editorial_positions") {
  [= Editorial Positions]
  date-block(
    ..data.editorial_positions.map(item => {
      (
        years: if item.keys().contains("end") and item.end != "" {
          (item.start, item.end)
        } else {
          (item.start,)
        },
        content: [#item.content],
      )
    })
  )
}

#if data.keys().contains("principal_investigator") {
  [= Principal Investigators of Grants]
}
#if data.keys().contains("academic_committees") {
  [= Academic Committees at the University of Pennsylvania]
}
#if data.keys().contains("lectures") {
  [= Lectures by Invitation]
}

= Bibliography
#bibliography_section(
  "Original papers",
  [@2024example1],
  [@2023example2],
  [@2022example3],
)

#bibliography_section(
  "Abstracts",
  [@2024abstract1],
  [@2023abstract2],
)

#bibliography_section(
  "Editorials, Reviews, Chapters",
  [@2024review1],
  [@2023chapter1],
  [@2024editorial1],
)

#bibliography_section(
  "Other Media",
  [@2024media1],
  [@2023media2],
)

#hidden-bibliography(bibliography("../publications.bib"))
