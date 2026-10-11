// Project-specific use
#import "../main.typ": report

#show: report.with(
  title: "Academic Report Template in Typst",
  author: "Alejandro Cobos",
  course: "Typst 101 — Document Automation",
  supervisor: "Supervised by: Mr. Typst", 
  
  logo: image("../assets/logoipsum-404.svg"),
  show-toc: true,
  heading-numbering: true 
)

= Introduction
This document demonstrates the capabilities of the UAB Report Template. Typst is a new markup-based typesetting system that is designed to be as powerful as LaTeX while being much easier to learn and use. This template leverages Typst's scripting capabilities to provide a consistent academic layout.

== Core Philosophy
The template follows a "Content-First" approach. By separating the styling logic (found in the `main.typ` file) from the content, users can focus on writing while the system handles margins, font weights, and navy-blue heading accents.

= Template Features

== Typography and Spacing
The template uses _New Computer Modern_ as the primary typeface at 11pt, which provides a classic academic feel. Paragraphs are justified with a leading of 0.65em to ensure high readability.

== Layout Components
The document is structured into several distinct parts:
- *Title Page:* Displays the logo, title, author, course, and optional roles.
- *Table of Contents:* Automatically generated and linked.
- *Main Content:* Uses navy blue headings and blue-colored links.

#pagebreak()

= Elements and Styling

== Code Blocks
The template provides a clean, shaded background for code snippets, making them stand out from the prose:

```typst
#show: report.with(
  title: "Mastering Custom Templates in Typst",
  author: "Alejandro Cobos",
  course: "Typst 101 — Document Automation",
  supervisor: "Supervised by: Mr. Typst", 
  
  logo: image("../assets/logoipsum-404.svg"),
  show-toc: true,
  heading-numbering: true 
)
```

== Figures and Tables
Figures are automatically centered, and the template handles the naming conventions for you (e.g., using "Fig." for images and "Table" for tables).

#figure(
table(
columns: (auto, auto),
[*Command*], [*Result*],
[show-toc], [Toggles the Table of Contents page],
[heading-numbering], [Enables or disables "1.1." prefixes],
[supervisor], [Adds a custom role line to the title page],
),
caption: [Available template parameters.],
) <tab:params>

As shown in @tab:params, the template is highly configurable via the main function call.

= Technical Implementation
The template uses a context block to handle dynamic headers and footers. This ensures that the page numbering starts correctly after the front matter and that the author's name appears consistently in the header of the main body.

= Conclusion
By using this template, users can produce professional reports that adhere to university standards with minimal effort. The combination of Typst's speed and this template's pre-configured styles makes it an ideal choice for students and researchers alike.