#import "admonitions.typ": *

#lorem(30)

#tip(title: "Hello, World!")[
  #lorem(10)
]

#tip-colored(title: "Hello, World!")[
  #lorem(10)
]

#info(title: "Hello, World!")[
  #lorem(10)
]

#info-colored(title: "Hello, World!")[
  #lorem(30)
]

#important(title: "Hello, World!")[
  #lorem(10)
]

#important-colored(title: "Hello, World!")[
  #lorem(30)
]

#warning(title: "Hello, World!")[
  #lorem(10)
]

#warning-colored(title: "Hello, World!")[
  #lorem(30)
]

#caution(title: "Hello, World!")[
  #lorem(10)
]

#caution-colored(title: "Hello, World!")[
  #lorem(30)
]

#danger(title: "Hello, World!")[
  #lorem(10)
]

#danger-colored(title: "Hello, World!")[
  #lorem(30)
]

#construction(title: "Hello, World!")[
  #lorem(10)
]

#construction-colored(title: "Hello, World!")[
  #lorem(30)
]

#note(title: "Hello, World!")[
  #lorem(10)
]

#note-colored(title: "Hello, World!")[
  #lorem(30)
]

#talk(title: "Hello, World!")[
  #lorem(10)
]

#talk-colored(title: "Hello, World!")[
  #lorem(30)
]

#alert(title: "Hello, World!")[
  #lorem(10)
]

#alert-colored(title: "Hello, World!")[
  #lorem(30)
]

#experiment(title: "Hello, World!")[
  #lorem(10)
]

#experiment-colored(title: "Hello, World!")[
  #lorem(30)
]

#snippet(title: "Hello, World!")[
  #lorem(10)
]

#snippet-colored(title: "Hello, World!")[
  #lorem(30)
]

#line(length: 100%)

#admonition[
  #lorem(30)
]

#lorem(10)

#admonition(type: "Admonition", title: [_Hello, World!_])[
  #lorem(30)
]

#admonition(type: "Admonition", title: [_Hello, World!_], bar: black)[
  #lorem(30)
]

#admonition(type: "Admonition", title: [_Hello, World!_], bar: black, icon: emoji.llama)[
  #lorem(30)
]

#admonition(type: "Llama", title: [_Hello, Llama!_], bar: black, icon: emoji.llama)[
  #lorem(30)
]

#admonition(
  type: "Llama", title: [_Hello, Llama!_], bar: black, icon: emoji.llama,
  background-color: green.lighten(20%), border: green + 3pt, text-color: white
)[
  #lorem(30)
]

#line(length: 100%)

#admonition(bar: black)[
  #lorem(30)
]

#admonition(bar: white, background-color: black, text-color: white, icon: "〇", icon-color: white)[
  #lorem(30)
]

#admonition(bar: gray)[
  Hello, Word!
]

#admonition(bar: gray, border: gray, title: [_Hello, World! in Java_])[
  #lorem(20)

  ```java
  public class HelloWorld {
    public static void main(String[] args) {
      System.out.println("Hello, World!")
    }
  }
  ```
]