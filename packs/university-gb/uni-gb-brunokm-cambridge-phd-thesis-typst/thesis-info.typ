// Editable thesis metadata.
#let info = (
  title: [Writing your PhD thesis in \ Typst],
  pdf-title: "A Typst PhD Thesis Template",
  subtitle: [A thesis template],
  author: "Bruno Kacper Mlodozeniec",
  university: [University of Cambridge],
  crest: image("figures/university-crest.pdf", width: 30.75mm, alt: "University of Cambridge coat of arms"),
  college: [Emmanuel College],
  supervisor: none,
  advisor: none,
  submission-text: [This dissertation is submitted for the degree of],
  degree: [Doctor of Philosophy],
  // Set --input date="September 2026" to pin the date for a submission/build.
  date: sys.inputs.at("date", default: datetime.today().display("[month repr:long] [year]")),
  subject: "PhD thesis template",
  keywords: ("Typst", "PhD Thesis", "University of Cambridge"),
)
