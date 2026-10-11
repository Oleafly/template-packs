#let cover-title-width = 145mm
#let cover-title-spacing = 6mm
#let cover-footer-spacing = 2.5mm
#let cover-divider-length = 28pt
#let cover-divider-stroke = 0.9pt
#let cover-study-course-label = "in the study course"
#let cover-faculty-label = "at the Faculty of"
#let cover-supervising-examiner-label = "Supervising examiner"
#let cover-second-examiner-label = "Second examiner"
#let cover-submitted-on-label = "Submitted on"
#let cover-submission-date-format = date => date.display("[month repr:long] [day], [year]")

#let cover_page(
  is-thesis: true,
  thesis: "Master Thesis",
  cover-logo-left: "../assets/logos/UPlogo.png",
  cover-logo-left-width: 90pt,
  cover-logo-right: "../assets/logos/HHIlogo.png",
  cover-logo-right-width: 170pt,
  cover-page-margin: (left: 22mm, right: 22mm, top: 18mm, bottom: 20mm),
  cover-main-text-size: 23pt,
  university-name: "University of Potsdam",
  cover-institute-line: "Thesis conducted at the Fraunhofer Heinrich Hertz Institute (Fraunhofer HHI), Berlin",
  title: "",
  author: "",
  faculty: "",
  study-course: "",
  supervisors: (),
  submission-date: none,
) = {
  set page(
    margin: cover-page-margin,
    numbering: none,
    number-align: center,
  )

  stack(
    grid(
      columns: (1fr, 1fr),
      align(horizon + left, image(cover-logo-left, width: cover-logo-left-width)),
      align(horizon + right, image(cover-logo-right, width: cover-logo-right-width)),
    ),

    v(58mm),

    align(
      center,
      block(
        width: cover-title-width,
        stack(
          spacing: cover-title-spacing,
          upper(text(thesis, size: 12pt, weight: "bold")),
          text(author, size: 11pt),
          v(10mm),
          par(leading: 1.15em, text(title, size: cover-main-text-size, weight: 500)),
        ),
      ),
    ),

    v(1fr),

    align(
      center,
      block(
        width: cover-title-width,
        stack(
          spacing: cover-footer-spacing,
          text(cover-study-course-label + " " + text(study-course, style: "italic")),
          text(cover-faculty-label + " " + faculty),
          text("Student at the " + university-name),
          text(cover-institute-line),

          v(2mm),
          align(center, line(length: cover-divider-length, stroke: cover-divider-stroke)),
          v(1mm),

          if supervisors.len() > 0 {
            if type(supervisors) != array {
              text(cover-supervising-examiner-label + ": " + text(supervisors, weight: "bold"), size: 10pt)
            } else {
              stack(
                spacing: 1.5mm,
                text(cover-supervising-examiner-label + ": " + text(supervisors.first(), weight: "bold"), size: 10pt),
                if supervisors.len() > 1 {
                  text(cover-second-examiner-label + ": " + text(supervisors.at(1), weight: "bold"), size: 10pt)
                },
              )
            }
          },

          if submission-date != none {
            text(
              cover-submitted-on-label + ": " + cover-submission-date-format(submission-date),
              size: 10pt,
            )
          },
        ),
      ),
    ),
  )
}
