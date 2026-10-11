// /!\ PLEASE READ README.md AT THE ROOT BEFORE TESTING
//
#import "../src/entry.typ": *
#show: subject-default

#set document(title: "DEMO", description: "FULL DEMO OF THE SYNTAX")

#subject-title-page()

#subject-page([
  = DEMO

  == Common text formatting

  This is NOT standard Markdown, it is #link("https://typst.app")[Typst] actually with *bold*, #text("italic", style: "italic") and `backticks`.

  #linebreak()

  Here's a codeblock:

  ```c
  #include <stdio.h>

  int main(void)
  {
    printf("Automatic syntax highlighting!\n")
    return 0;
  }
  ```
])

#subject-page([
  = Lists

  == Unordered

  - a
  - b
  - c

  == Ordered

  1. one
  2. two
  3. three
])

#subject-page([
  #note("note")
  #tip("tip")
  #important("important")
  #warning("warning")
  #caution("caution")
  #note([
    very
    #linebreak()
    long
    #linebreak()
    note
    #linebreak()
    note
    #linebreak()
    note
    #linebreak()
    note
    #linebreak()
    note
    #linebreak()
    note
    #linebreak()
    note
    #linebreak()
    note
    #linebreak()
    note
  ])
])

#subject-final-page(version_text: "1.0.0")
