= Motivation
Some text with a reference to the image below: @fig:example

#figure(
  image("/figures/1_example/Example.jpg", width: 75%),
  caption: [
    Caption with a reference to a book @book
  ],
)<fig:example>
Text after image. Reference to specific pages of a source: @inbook[pp. 1--2]. This text leaps onto the next line to show the indent.

#link("https://github.com/bklaric1/typst_template")[GitHub link] is the link for the GitHub page of this template. There, the newest updates will be shown.

#pagebreak()