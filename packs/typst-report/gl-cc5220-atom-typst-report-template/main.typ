// -----------------------------------------------------------------------------
// ATOM — Informe breve
//
// 1. Reemplazar los metadatos.
// 2. Mantener `draft: true` mientras se redacta.
// 3. Cambiar a `draft: false` antes de entregar para ocultar las guías.
// 4. Reemplazar los ejemplos por evidencia real del proyecto.
// -----------------------------------------------------------------------------

#import "atom-report.typ": atom-report, section-guide, draft-warning
#import "@preview/lovelace:0.3.1": pseudocode-list

#let draft = true

#show: atom-report.with(
  title: [Título específico del informe],
  assignment: [Tarea 1],
  authors: (
    "Nombre Apellido",
    "Nombre Apellido",
  ),
  course: [Algoritmos y Técnicas de Optimización Metaheurística],
  institution: [Departamento de Ciencias de la Computación — Universidad de Chile],
  instructor: [Nombre de la persona docente],
  submission-date: datetime(year: 2026, month: 8, day: 15),
  repository: none,
  commit: none,
  keywords: (
    "optimización de caja negra",
    "metaheurísticas",
    "reproducibilidad",
  ),
)

#let guide(expected-pages, body) = {
  if draft {
    section-guide(expected-pages, body)
  }
}

#let placeholder(body) = {
  if draft {
    draft-warning(body)
  }
}

= Problema y pregunta experimental

#guide([1/2-1 página])[
  Explicar qué se busca optimizar, por qué el problema es relevante y cuál es la
  pregunta experimental concreta. Definir con precisión la variable de respuesta.
]

#placeholder[
  Reemplazar este párrafo por una descripción autocontenida del problema. Evitar
  comenzar por los algoritmos: primero debe quedar claro qué decisión se optimiza,
  bajo qué condiciones y cómo se evalúa una solución candidata.
]

La formulación matemática puede escribirse directamente. Por ejemplo:

$ min_(bold(x) in cal(X)) f(bold(x)) $

La pregunta experimental debe permitir una respuesta sustentada en evidencia. Un
formato útil es: _¿Cómo cambia [métrica] al comparar [tratamientos] bajo [protocolo
común] en [instancias o escenarios]?_

= Decisiones de diseño

#guide([1 página])[
  Documentar la representación de soluciones candidatas, el espacio de búsqueda,
  las restricciones y la función objetivo. Justificar las decisiones que puedan
  afectar la validez o la interpretación de los resultados.
]

Describir aquí la representación y sus invariantes. Incluir, cuando aporte claridad,
un fragmento pequeño del código relevante:

```kotlin
fun sphere(candidate: List<Double>): Double =
  candidate.sumOf { coordinate -> coordinate * coordinate }
```

El pseudocódigo puede mostrar la estructura del algoritmo sin acoplarla a una
implementación particular:

#pseudocode-list[
  + *input:* objective, search space, evaluation budget
  + sample the initial candidate
  + *while* the evaluation budget is not exhausted
    + sample a proposal
    + evaluate the proposal
    + update the incumbent when the proposal is better
  + *return* the incumbent
]

= Metodología y protocolo experimental

#guide([1 página])[
  Especificar algoritmos, configuraciones, presupuestos de evaluación, semillas,
  instancias, métricas y procedimiento de análisis. La comparación debe usar un
  protocolo común y permitir que otra persona reproduzca el experimento.
]

#placeholder[
  Reportar todos los parámetros que influyen en los resultados. Indicar cuántas
  ejecuciones independientes se realizaron por tratamiento y cómo se eligieron las
  semillas. No seleccionar resultados manualmente.
]

Las prácticas de benchmarking deben separar con claridad el problema, el algoritmo,
la instancia y la medición del desempeño @hansen2021coco. Para fortalecer la
reproducibilidad, conviene publicar código, configuración y artefactos suficientes
para reconstruir el análisis @pineau2021reproducibility.

== Protocolo mínimo

- *Tratamientos:* algoritmos y configuraciones comparadas.
- *Presupuesto:* número máximo de evaluaciones de la función objetivo.
- *Semillas:* lista completa y criterio de reutilización entre tratamientos.
- *Métricas:* calidad final, variabilidad y, cuando corresponda, convergencia.
- *Artefactos:* configuración, resultados sin procesar, tablas, figuras y versión del código.

= Resultados y discusión

#guide([2-3 páginas])[
  Presentar evidencia, comparar tratamientos, describir la variabilidad e interpretar
  los resultados. Priorizar las tablas y figuras que respondan directamente la
  pregunta experimental; no duplicar la misma información sin una razón clara.
]

La @tab:summary muestra un ejemplo de resumen descriptivo. Reemplazar sus valores y
su texto por resultados reales.

#figure(
  table(
    columns: (1.5fr, 1fr, 1fr, 1fr, 1fr),
    align: (left, right, right, right, right),
    table.header(
      [*Algoritmo*],
      [*Mediana*],
      [*$Q_1$*],
      [*$Q_3$*],
      [*Mejor*],
    ),
    [Random Search], [12.4], [10.8], [15.1], [8.9],
    [Hill Climbing], [4.7], [4.1], [5.9], [3.8],
  ),
  caption: [Resumen descriptivo de la calidad final. Valores ilustrativos.],
) <tab:summary>

La @fig:convergence ilustra cómo insertar una figura y referenciarla desde el texto.
La figura debe tener un propósito analítico, una leyenda informativa y una descripción
alternativa.

#figure(
  image("assets/example-convergence.svg", width: 82%),
  caption: [Ejemplo de convergencia. Reemplazar por una figura generada desde los datos.],
  alt: "Dos curvas de mejor valor acumulado disminuyen con el número de evaluaciones; la segunda alcanza valores menores antes.",
) <fig:convergence>

#placeholder[
  Interpretar magnitud, dirección y variabilidad de las diferencias. Distinguir entre
  observaciones y explicaciones plausibles. No afirmar causalidad cuando el protocolo
  solo sustenta una asociación.
]

= Conclusiones y limitaciones

#guide([1/2-1 página])[
  Responder la pregunta experimental de manera directa, resumir la evidencia decisiva
  y delimitar el alcance. Identificar amenazas a la validez, decisiones pendientes y
  condiciones bajo las cuales la conclusión podría cambiar.
]

#placeholder[
  Evitar repetir toda la sección de resultados. Una conclusión sólida indica qué se
  aprendió, con qué nivel de respaldo y qué no puede concluirse a partir del estudio.
]

#pagebreak(weak: true)
#bibliography(
  "references.bib",
  style: "apa",
  title: [Referencias],
)

#pagebreak()
#set heading(numbering: none)
= Anexos

Los anexos no cuentan dentro del límite de páginas, pero deben ser relevantes y estar
referenciados desde el cuerpo. Pueden incluir configuraciones completas, tablas
secundarias, detalles de implementación o instrucciones de reproducción.

== Lista de verificación de reproducibilidad

- [ ] El ZIP o el repositorio de la implementación corresponde exactamente a los resultados del informe.
- [ ] El procedimiento de ejecución está documentado desde un entorno limpio.
- [ ] Las semillas y configuraciones están disponibles como archivos.
- [ ] Los resultados sin procesar permiten reconstruir tablas y figuras.
- [ ] Las dependencias y sus versiones están fijadas o documentadas.
- [ ] Cada figura tiene leyenda y descripción alternativa.
- [ ] Cada tabla usa una fila de encabezado semántica.
