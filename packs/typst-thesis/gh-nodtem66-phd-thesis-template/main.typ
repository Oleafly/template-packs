#import "style.typ": page_setup, thesis_style, postface_style

// Set PDF metadata
#set document(title: "Title of PhD Thesis", author: "Your name")

// Use the page setup for printing with crop marks
#show: page_setup.with(format: "print")

// Include the title page and dedication
#include "preface/title.typ"
#include "preface/dedication.typ"

// Generate the outline (table of contents)
#outline()

// Use the thesis style (chapter ribbon) for the main content
#show: thesis_style.with()

#include "chapters/1.typ"
#include "chapters/2.typ"
#include "chapters/3.typ"

#show: postface_style.with()
#include "chapters/appendix.typ"

#include "chapters/ref.typ"