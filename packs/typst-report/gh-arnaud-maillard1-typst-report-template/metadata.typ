#import "@preview/hei-synd-thesis:0.4.0": *
#import "@preview/hei-synd-report:0.4.0": *

//-------------------------------------
// Document options
//
#let option = (
  type : "final",    // [draft|final]
  lang : "fr",       // [en|fr|de]
)
//-------------------------------------
// Optional generate titlepage image
//
#import "@preview/fractusist:0.3.2":*  // only for the generated images
#let titlepage_logo= dragon-curve(
  12,
  step-size: 4,
  stroke: stroke(
    paint: gradient.radial(..color.map.rocket),
    thickness: 1pt, join: "round"
  ),
)

//-------------------------------------
// Metadata of the document
//
#let doc= (
  title    : [Your report name],
  abbr     : "Report abbr",
  subtitle : [Your subtitle],
  url      : "https://synd.hevs.io",
  logos: (
    tp_topleft  : image("resources/img/hesso.png", height: 1.5cm),
    tp_topright : image("resources/img/mse-full.svg", height: 1.7cm),
    tp_main     : titlepage_logo, // Replace by your report title image
    header      : image("resources/img/mse-full.svg", width: 5.0cm),
  ),
  authors: (
    (
      name        : "Arnaud Maillard",
      abbr        : "AMD",
      email       : "arnaud.maillard@master.hes-so.ch",
    ),
  ),
  school: (
    name            : "HES-SO Master",
    url             : "https://www.hes-so.ch/master",
    major           : "MSE",
    major_url       : none,
    orientation     : "Computer Science",
    orientation_url : none,
  ),
  course: (
    name     : "Course name",
    url      : none,
    prof     : "Professeur",
    email    : none,
    class    : none,
    semester : "Spring Semester 2026",
  ),
  keywords : ("Typst", "Template", "Report", "MSE", "HES-SO", "Computer Science"),
  version  : "v0.1.0",
)

#let date= datetime.today()

//-------------------------------------
// Settings
//
#let display = (
  gradient: false,
  titlepage: true,
)

#let tableof = (
  toc: true,
  tof: true,
  tot: true, // Table 
  tol: false, // Table of code listings
  toe: true, // Table of equations
  maxdepth: 3,
)

#let gloss    = true
#let appendix = true
#let bib = (
  display : true,
  path  : "/tail/bibliography.bib",
  style : "ieee", //"apa", "chicago-author-date", "chicago-notes", "mla"
)

#let fonts = (
  text: "Libertinus Serif",
  mono: "DejaVu Sans Mono",
  math: "New Computer Modern Math",
)
