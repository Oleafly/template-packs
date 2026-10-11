#import "../template_report_ECAM.typ": report

#show: report.with(
  title: [Report Title],
  course-name: [Course Name],
  authors: (
    (
      first-name: "John",
      last-name: "Doe",
      matricule: "12345",
    ),
    (
      first-name: "Jane",
      last-name: "Doe",
      matricule: "67890",
    ),
  ),
  logo: image("ECAM_logo.jpg"),
  language: "en",
)

= Section
This is an example document to demonstrate the ECAM report template.

== Subsection
Here is some sample content for the subsection.
