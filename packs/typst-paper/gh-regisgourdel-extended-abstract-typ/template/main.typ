#import "../extended_abstract.typ": article

#show: article.with(
  title: [The article title],
  subtitle: [Some subtitle added to it],
  short-title: [Article Title],
  header: [Submission to conference XXX --- Extended abstract],
  disclaimer: [This document represents the view of the authors alone. Or any other disclaimer you have to make here.],
  authors: (
    (name: "First Author", affiliations: (1, 2), corresponding: true, email: "iauthor@pm.me"),
    (name: "Second Author", affiliations: (2, 3), equal-contrib: "These authors contributed equally to this work."),
    (name: "Third Author", affiliations: (1, 2)),
  ),
  affiliations: (
    (id: 1, department: "Department", institution: "Organization", address: "Street, City 100190, State, Country"),
    (id: 2, department: "Department", institution: "Organization", address: "Street, City 10587, State, Country"),
    (id: 3, department: "Department", institution: "Organization", address: "Street, City 610101, State, Country"),
  ),
  summary: [The summary is the very short version of the abstract, which sometimes is required as part of the extended abstract.
  The target length is typically 100-150 words.],
  keywords: ("keyword1", "Keyword2", "Keyword3", "Keyword4"),
  show_counts: true,
  jel: [J45, V73, A90]
)

= Introduction <sec1>

The Introduction section, of referenced text #cite(<bib1>) expands on the background of the work (some overlap with the Abstract is acceptable).
The introduction should not include subheadings.
For an extended abstract, not having any section is also a possibility.

#lorem(30)

= Results <sec2>

#lorem(50)

For display equations (with auto generated equation numbers):

$ norm(tilde(X)(k))^2 <= (sum_(i=1)^p norm(tilde(Y)_i (k))^2 + sum_(j=1)^q norm(tilde(Z)_j (k))^2) / (p + q) $ <eq1>

where,

$ D_mu &= partial_mu - i g (lambda^a) / 2 A^a_mu \
  F^a_(mu nu) &= partial_mu A^a_nu - partial_nu A^a_mu + g f^(a b c) A^b_mu A^a_nu $ <eq2>

#lorem(50)

#bibliography("refs.bib", title: "References")
