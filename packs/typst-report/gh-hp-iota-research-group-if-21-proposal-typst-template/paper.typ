#import "@preview/charged-ieee:0.1.3": ieee

#show: ieee.with(
  title: [A Typesetting System to Untangle the Scientific Writing Process],
  abstract: [
    The process of scientific writing is often tangled up with the intricacies of typesetting, leading to frustration and wasted time for researchers. In this paper, we introduce Typst, a new typesetting system designed specifically for scientific writing. Typst untangles the typesetting process, allowing researchers to compose papers faster. In a series of experiments we demonstrate that Typst offers several advantages, including faster document creation, simplified syntax, and increased ease-of-use.
  ],
  authors: (
    (
      name: "Martin Haug",
      department: [Co-Founder],
      organization: [Typst GmbH],
      location: [Berlin, Germany],
      email: "haug@typst.app"
    ),
    (
      name: "Laurenz Mädje",
      department: [Co-Founder],
      organization: [Typst GmbH],
      location: [Berlin, Germany],
      email: "maedje@typst.app"
    ),
  ),
  index-terms: ("Scientific writing", "Typesetting", "Document creation", "Syntax"),
  bibliography: bibliography("assets/bibs/references.bib"),
  figure-supplement: [Fig.],
  paper-size: "a4"
)

// || ------------------------------ MISC ------------------------------ ||
  // Source: GPT
  // | Conference                      | Page Limit                    |
  // | ------------------------------- | ----------------------------- |
  // | IEEE ICC / IEEE GLOBECOM        | 6 pages max                   |
  // | IEEE INFOCOM                    | 9 pages (all inclusive)       |
  // | IEEE ICSE (Software Eng.)       | 10 pages (excluding refs)     |
  // | IEEE ICBHI (Health Informatics) | 6 pages + 1 extra page (paid) |
  // | IEEE ISBI (Biomedical Imaging)  | 4 pages max (strict)          |
// || ------------------------------ MISC ------------------------------ ||

#include "src/paper/ch-1.typ"
#include "src/paper/ch-2.typ"
#include "src/paper/ch-3.typ"
#include "src/paper/ch-4.typ"
#include "src/paper/ch-5.typ"
#include "src/paper/ack.typ"
