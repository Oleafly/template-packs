#import "lib/hcmut-report.typ": report

#show: report.with(
    lang: "en",
    subject: "CO2039 - Advanced Operating Systems",
    project: "Assignment 1",
    author: "Nguyen Van A",
    instructors: ("Dr. Nguyen Van A",),
    implementers: (("Nguyen Van A", "2012345"),),
    // toc: false // Uncomment to hide TOC
)

= Introduction
This text belongs to Section 1.
```cpp
#include <iostream>
int main() {
    std::cout << "Hello, World!" << std::endl;
    return 0;
}
```
// table
== Tables
Here is a table demonstrating the styling.

#figure(
    table(
        columns: (1fr, 2fr, 1fr),
        align: (center, left, center),
        table.header([*ID*], [*Description*], [*Value*]),
        [1], [Initial Configuration Parametersdasdasdad], [0.5],
        [2], [Runtime Delta], [1.2],
        table.cell(rowspan: 2, [3]), [Merged Cell Test], [High],
                                        [Sub-test B], [Low],
    ),
    caption: [Experimental Results],
)<ExperimentalResults>

= Methodology
As seen in @ExperimentalResults, the values are consistent.
== Background
This text belongs to Section 1.1.
- testing
- testing
+ testing2
    - testing 3

=== Historical Context
This text belongs to Section 1.1.1.

= Methodology
This text belongs to Section 2.
