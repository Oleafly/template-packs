#import "template.typ": *
#set par(justify: true,first-line-indent: 2em) // 两端对齐，段前缩进2字符
#show heading: it =>  {
    it
    par()[#text()[#h(0.0em)]]
}
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: project.with(
  title: "Projects 1: ???",
  date: "20xx/xx/xx",
  authors: (
    "xxx",
  ),
  id: 123456789
)

= *Chapter 1*: Introduction

Problem description and (if any) background of the algorithms.

= *Chapter 2*: Algorithm Specification

Description (pseudo-code preferred) of all the algorithms involved for solving the problem, including specifications of main data structures.

== Step One
== Step Two
== Step Three // Auto-numbering is supported

= *Chapter 3*: Testing Results

Table of test cases. Each test case usually consists of a brief description of the purpose of this case, the expected result, the actual behavior of your program, the possible cause of a bug if your program does not function as expected, and the current status ("pass", or
"corrected", or "pending").

#table(
  columns: (1fr, 1fr),
  [`Sample Input`], [`Sample Output`],
  [
    #importCode("../code/sample.in", lang: "txt")
  ],
  [
    #importCode("../code/sample.out", lang: "txt")
  ]
)

= *Chapter 4*: Analysis and Comments

Analysis of the time and space complexities of the algorithms. Comments on further possible improvements.

= *Appendix*: Source Code (in C)

At least 30% of the lines must be commented. Otherwise the code will NOT be evaluated.

File sol.c:

#importCode("../code/sol.c")
// use `importCode` function to read code from a file

= *Declaration*

I hereby declare that all the work done in this project titled "XXX" is of my independent effort.

Please keep in mind that these are the "minimum" requirements. Other requirements will be specified according to each project assignment.
