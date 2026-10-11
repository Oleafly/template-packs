// CSCS slides — Typst port of example.tex
#import "cscs.typ": *

#show: cscs-presentation.with(
  title: "Presentation Title",
  subtitle: "Event",
  author: "Author, CSCS",
  date: "August 13, 2023",
  footer: "Insert_Footer",
)

// 1. TITLE SLIDE
#cscs-title(
  picture: images + "/image3.pdf",
  title: "Presentation Title",
  subtitle: "Event",
  author: "Author, CSCS",
  date: "August 13, 2023",
)

// 2. EMPTY SLIDE — force an extra blank page that won't be absorbed by weak breaks.
#page[#hide[.]]

// 3. TABLE OF CONTENT SLIDE
#cscs-toc(title: "Title")[
  #cscs-list[
    - Section1
      - Subsection1
        - Subsubsection1
    - Section2
      - Subsection2
        - Subsubsection2
  ]
]

// 4. CHAPTER SLIDE
#cscs-chapter("Chapter Title")

// 5. CITATIONS SLIDE
#cscs-slide(title: "Citations")[
  CSCS website #cite(<cscs_website>)
]

// 6. QUICK STYLES SLIDE — 7 colors x 3 variants
#cscs-slide(title: "Quick Styles")[
  #v(2mm)
  #let abc-cell(make) = make(align(center)[Abc], [])
  #grid(
    columns: (1fr,) * 7,
    column-gutter: 3mm,
    row-gutter: 3mm,
    abc-cell(black0block),  abc-cell(green0block), abc-cell(blue0block),
    abc-cell(brown0block),  abc-cell(purple0block), abc-cell(yellow0block),
    abc-cell(red0block),
    abc-cell(black1block),  abc-cell(green1block), abc-cell(blue1block),
    abc-cell(brown1block),  abc-cell(purple1block), abc-cell(yellow1block),
    abc-cell(red1block),
    abc-cell(black2block),  abc-cell(green2block), abc-cell(blue2block),
    abc-cell(brown2block),  abc-cell(purple2block), abc-cell(yellow2block),
    abc-cell(red2block),
  )
]

// 7. FORMULA SLIDE
#cscs-slide(title: "Formula")[
  My formula is $E = m times c^2$
  #v(1mm)
  #blue2block("Are examples in a blue block?")[
    #cscs-list[
      - My example
        - for a formula
          - rocks!
    ]
  ]
  #v(1mm)
  #red2block("Alert an error in the formula!")[
    #cscs-enum[
      + First enumerated item
        + First first enumerated item
          + First first first enumerated item
      + just joking...
    ]
  ]
]

// 8. CODE LISTING SLIDE
#cscs-slide(title: "Code listing")[
  #cscs-listing(language: "C/C++", title: "My code title with some openmp",
"int main (int argc, char *argv[]) {
    int nthreads, tid;
    #pragma omp parallel private(nthreads, tid) {
        tid = omp_get_thread_num();
        printf(\"Hello World from thread = %d\\n\", tid);
        if (tid == 0) {
            nthreads = omp_get_num_threads();
            printf(\"Number of threads = %d\\n\", nthreads);
        }
    }  /* All threads join master thread and disband */
    return 0;
}")
  #v(1mm)
  #cscs-listing(language: "Rust", title: "My Rust code here",
"fn main() {
    // Compute a value and print it.
    let x: f32 = 23.6 * (4.2_f32).ln() / (3.0 + 2.1);
    println!(\"The value of x is {}\", x);
}")
  #v(2mm)
  #text(size: 6pt)[
    Here some cpp code in the text: #cscs-inline-code("int main(int args, char *argv[])") \

    Here some rust code in the text: #cscs-inline-code("let y: [i32; 5] = [0; 5];", language: "Rust")
  ]
]

// 9. THANK YOU SLIDE
#cscs-thankyou(message: "Thank you for your attention.")

// 10. REFERENCES SLIDE — Typst's native bibliography uses ref.bib.
#cscs-slide[
  // CSCS blue for URLs, matching the brand palette.
  #show link: set text(fill: cscs-blue)
  #bibliography("ref.bib", title: [References #text(fill: cscs-blue)[I]],
                style: "cscs.csl")
]
