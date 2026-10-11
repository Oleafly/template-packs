#import "../lib.typ": fiuba-tp

#show: fiuba-tp.with(
  titulo: "Título del trabajo",
  subtitulo: "Subtítulo opcional",
  materia-codigo: "XX.XX",
  materia-nombre: "Nombre de la materia",
  catedra: "Cátedra Apellido",
  docente: "Prof. Nombre Apellido",
  cuatrimestre: "N.º cuatrimestre",
  anio: "2026",
  autores: (
    (nombre: "Apellido, Nombre", padron: "000000", email: "nombre@fi.uba.ar"),
    (nombre: "Otro Apellido, Otro Nombre", padron: "111111", email: "otro@fi.uba.ar"),
  ),
)

= Introducción

Este es un documento de ejemplo con la plantilla FIUBA. La carátula se genera automáticamente con los datos de arriba.

== Ecuaciones y código

Una ecuación de ejemplo:

$ sum_(i=1)^n i = (n (n + 1)) / 2 $

Un bloque de código:

```python
def hola():
    print("Hola, FIUBA")
```

= Desarrollo

Texto de prueba con una referencia a la @tab:autores.

#figure(
  table(
    columns: (auto, auto, auto),
    inset: 8pt,
    table.header([*Nombre*], [*Padrón*], [*Email*]),
    [Apellido, Nombre], [000000], [nombre\@fi.uba.ar],
  ),
  caption: [Ejemplo de tabla.],
) <tab:autores>

= Conclusión

Conclusiones del trabajo.
