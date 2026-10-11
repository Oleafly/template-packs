#import "multi-ref.typ"

= How to cite references on multiple files

For the current version of Typst (05/06/2024), one cannot cite references on different Typst files. This folder show you how to hack this using file name `multi-ref.typ`.
In the following, you can see that the references were displayed properly.

#include "file1.typ"
#include "file2.typ"

#bibliography("ref.bib")