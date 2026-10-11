#import "../template.typ": classic
// Una vez instalado utilizar: #import "@local/unrn-template:1.0.0": classic 

// Valores por defecto
#show: classic.with(
  title: "Template UNRN",
  subtitle: "Esto es un ejemplo",
  toc: true,
  font: "New Computer Modern Sans",
  monofont: "New Computer Modern Mono",
  authors: ("Autor 1", "Autor 2",),
  subject: "Materia de ejemplo",
  career: "Ingenería en Templates",
  date: "1 de enero de 2077",
  npar: false,
)

= Prueba

#lorem(20)

== Prueba 2

#lorem(20)

=== Prueba 3

```c
#include <stdio.h>

int main(int argc, char *argv[]) {
  printf("Hola mundo! \n");

  return 0;
}
```
