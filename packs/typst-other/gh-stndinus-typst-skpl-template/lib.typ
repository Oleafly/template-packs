// variables
#let application_name = "Nama Perangkat Lunak"
#let team_members = (
  "Ketua Tim",
  "Anggota Tim...",
)
#let document_no = "001"
#let document_revision = "-"
#let client = "Nama Klien"
#let client_address = "Alamat Klien"
#let revision_data = (
  "-": (
    description: [],
    author: [],
    reviewer: [],
    approver: [],
  ),
  "A": (
    description: [],
    author: [],
    reviewer: [],
    approver: [],
  ),
  "B": (
    description: [],
    author: [],
    reviewer: [],
    approver: [],
  ),
  "C": (
    description: [],
    author: [],
    reviewer: [],
    approver: [],
  ),
  "D": (
    description: [],
    author: [],
    reviewer: [],
    approver: [],
  ),
  "E": (
    description: [],
    author: [],
    reviewer: [],
    approver: [],
  ),
  "F": (
    description: [],
    author: [],
    reviewer: [],
    approver: [],
  ),
  "G": (
    description: [],
    author: [],
    reviewer: [],
    approver: [],
  ),
)
#let font = (
  serif: "Libertinus Serif",
  sans: "Tex Gyre Heros",
)

// elements
#let figtbl(..tp) = {
  set table(fill: (_, y) => if y == 0 {
    gray.lighten(40%)
  })
  show table.cell.where(y: 0): strong
  table(..tp)
}

#let pre_heading(title) = align(center)[#heading(
    outlined: false,
    numbering: none,
  )[#title]]
