/*
appendix.typ

This file contains the content of the appendix (attachments).
*/

#import "resources/appendixConfig.typ": appendix-heading

// Content

#appendix-heading([How to use the appendix])
Insert an appendix entry with:
#figure(
  kind: "listing",
  supplement: [Listing],
  ```typst
  #appendix-heading([Your heading title here])
  // Put your content here, e.g. figure:
  #figure(
    image("images/foo")
  ) <appendixA> // Put your reference label here
  ```,
  caption: [Typst code preview to insert the heading for an appendix entry]
)
The reference label has to be somewhere inside of the appendix content, since no label can be attached to the headings (limitations by Typst / didn't find a solution yet).

#appendix-heading("Second appendix")
Feel free to message me if you have any improvements. To insert code here that does not appear in the list of listings, do this:

#figure(
  ```cpp
  #include <iostream>

  int main() {
    std::cout << "Hello World!";
    return 0;
  }
  ```,
  kind: "appendixCode",
  supplement: "",
)

And put your code description below. This is because if you use captions here they will be weird like this:

#figure(
  ```python
  def main():
    print("Hello World!")
  ```,
  kind: "appendixCode",
  supplement: "Your Supplement",
  caption: [I am a caption]
)

#pagebreak()

If you add code like this:

```python
print("1")
print("2")
print("3")
```

You can see that the line spacing will be applied.