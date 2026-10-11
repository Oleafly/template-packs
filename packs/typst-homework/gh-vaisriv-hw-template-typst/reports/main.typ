/////////////
// Imports //
/////////////
#import "@preview/adaptable-pset:0.2.0": *
#import "@preview/physica:0.9.8": *
#import "@preview/unify:0.8.1": *
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#show: codly-init.with()
#codly(languages: codly-languages)

/////////////////
// Maths Setup //
/////////////////

// upright vectors
#let vectorboldupright(a) = vb($upright(#a)$)
#let vbu = vectorboldupright
#let vectorunitupright(a) = vu($upright(#a)$)
#let vuu = vectorunitupright
#let vectorarrowupright(a) = va($upright(#a)$)
#let vau = vectorarrowupright

// automatically use square brackets for vectors and matricies
#set math.vec(delim: "[")
#set math.mat(delim: "[")
#let vecrowOld = vecrow
#let vecrow = vecrowOld.with(delim: "[")

////////////////////
// Document Setup //
////////////////////

// assignment info
#show: homework.with(
    title: "HW00",
    author: "Vai Srivastava",
    collaborators: [],
    course-id: "Course: Description",
    instructor: "Instructor",
    semester: "Fall 2026",
    due-time: datetime(
        // due date
        year: 2026,
        month: 01,
        day: 01,

        // due time
        hour: 23,
        minute: 59,
        second: 00,
    ).display("[month repr:long] [day padding:zero], [year] at [hour repr:24]:[minute padding:zero]:[second padding:zero]"),

    // (defaults to A4)
    paper-size: "us-letter",
)

// document settings
#set text(font: "New Computer Modern", size: 10pt)
#set enum(numbering: "a)")

// problem headings
#let probOld = prob
#let prob = prob.with(color: black)

////////////////////////////
// The Assignment Itself: //
// Problems and Solutions //
////////////////////////////

#prob(title: [Parts #emph[(\# pts)]])[
    1. Instructions
    <hwk:p01a>

    2. Instructions
    <hwk:p01b>
] <hwk:p01>

1. Answer

<hwk:s01a>

2. Answer

<hwk:s01b>

#pagebreak(weak: true)

#prob(title: [Code #emph[(\# pts)]])[
    Instructions
] <hwk:p02>

#figure(
    image("../outputs/figures/s02.png", width: 65%),
    caption: [Sine Wave on $x = [0 10]$]
) <fig:s02>

#raw(read("../outputs/text/s02.txt"), block: true) <code:s02>

See the #link("https://github.com/vaisriv/<HW_ASSIGNMENT>/blob/main/src/index.py#L1")[Python code] for this problem.

#pagebreak(weak: true)

== Code

#codly(header: [./src/index.py])
#raw(read("../src/index.py"), block: true, lang: "python") <code:index.py>
