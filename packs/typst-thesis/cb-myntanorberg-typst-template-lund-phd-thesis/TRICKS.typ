= What is this?
A document with some niche tips and tricks. I was going to put them in the main file, but opted to remove them to reduce clutter.


= Reusable functions
If you want a reusable function for i.e. naming an Author that you need to refer to a lot, you can set it up like this:
#let AuthorI= "This is the name of Author I"
And then you can call \#AuthorI to print: #AuthorI. In the .typ file, the backslash is used here to break the call for the PDF.

= Outline
The outline (table of contents) isn't particularly customisable in Typst yet. I stole this idea for this template:

https://github.com/typst/typst/discussions/2704
