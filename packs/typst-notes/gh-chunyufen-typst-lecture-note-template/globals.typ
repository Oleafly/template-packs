// globals.typ
#import "@preview/touying:0.6.1": *
#import "@preview/numbly:0.1.0": numbly
#import "@preview/showybox:2.0.4": showybox

#import "@preview/wrap-it:0.1.1": wrap-content

// as well as some utility functions

//-----------  set quote function ----------- 
#set quote(block: true, quotes: true)

//-----------  Configure "Title", etc. ----------- 

#let title = [
  Title
  ]

#let subtitle = [
  Subtitle
]

#let affiliation = [
  University
]

#let author = [
  Name#super[\*]
]

#let send-email = [
  #link("mailto: your email address")[$#emoji.tray.mail$]
  // #link("mailto: check@check.edu")
]

#let date = [
  #datetime.today().display().
]

#let ref_number =[
  Reference Number
]

//----------- Paragraph indent & justify -----------

#set par(
  justify: true,
  first-line-indent: (
    amount: 0.85em,
    all: true
  )
)

//----------- Text -----------

// --------------------
// lang: "zh" means chinese
// region: "cn" means simplified
// region: "tw" means traditional
// --------------------

#set text(
  font: ("Libertinus Serif", "STFangsong"), // "SimSun" "STsong"  "Songti TC" "Libertinus Serif", "Times New Roman"
  // lang: "zh",
  // region: "tw",
  lang: "en",
  region: "uk",
  size: 22pt, // default size is 20 pt?
  hyphenate: true,
)

