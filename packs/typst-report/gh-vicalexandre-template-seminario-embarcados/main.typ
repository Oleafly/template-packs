#import "template.typ": *

#show: presentation.with(
  title: "Seminário de Embarcados",
  authors: (
    (name: "Fulano de Tal", email: "fulano.detal@edge.ufal.br"),
  ),
)


= Introdução

== Slide 0
Slide vazio

== Slide 1
Lorem ipsum

- Lorem ipsum
- Lorem ipsum

== Slide 2
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

= Lorem ipsum

== Slide 3
```c
#include <zephyr/kernel.h>

int main(void){
  printk("Hello, Edge Embarcados!\n");

  return 0;
}
```