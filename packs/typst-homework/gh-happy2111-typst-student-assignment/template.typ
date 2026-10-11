#set page(
  paper: "a4",
  margin: (
    left: 3.0cm,
    right: 1.5cm,
    top: 2.0cm,
    bottom: 2.0cm,
  ),
  numbering: "1",
  number-align: right,
)

#set text(
  font: "Times New Roman",
  size: 14pt,
  lang: "uzb",
)

#set par(
  justify: true,
  leading: 0.6em,
  first-line-indent: 1.25cm,
)

#import "config.typ": *
#import "components/cover-page.typ": cover-page as cover-page-base
#import "components/assessment-declaration.typ": assessment-declaration as assessment-declaration-base
#import "components/start-body.typ": start-body

// config.typ dagi qiymatlar bilan oldindan to'ldirilgan muqova (OCP: .with() orqali qayta yozish mumkin)
#let cover-page = cover-page-base.with(
  title: subject_title,
  author: author_cover_name,
  section-lbl: section_label,
  section-title: section_name,
  teacher: teacher_name,
  group: student_group,
  talaba-id: student_id,
  submitted: date,
)

#let assessment-declaration = assessment-declaration-base.with(
  student-id: student_id,
  assessor: teacher_name,
  unit: unit_full,
  assignment: assignment_name,
  submitted: date,
  signature: signature,
  date: date,
)

// --- Namuna hujjat (faqat template.typ ni to'g'ridan-to'g'ri kompilyatsiya qilganda ko'rinadi) ---

#cover-page()
#assessment-declaration()
#pagebreak()

= Kirish

Mazmun...
