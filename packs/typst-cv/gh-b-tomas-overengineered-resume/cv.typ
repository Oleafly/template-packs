// Template documentation: https://github.com/stuxf/basic-typst-resume-template
#import "@preview/basic-resume:0.2.9": *

// Variant and language selection.
// Build a target with, e.g.:
//   typst compile cv.typ --input variant=backend --input lang=en
// or build everything with the Makefile (`make all`).
#let VARIANTS = ("backend", "embedded")
#let LANGS = ("en", "es")
#let DEFAULT-VARIANT = "backend"
#let DEFAULT-LANG = "en"

#let variant = sys.inputs.at("variant", default: DEFAULT-VARIANT)
#let lang = sys.inputs.at("lang", default: DEFAULT-LANG)

#assert(variant in VARIANTS,
  message: "Unknown variant '" + variant + "'. Choose: " + VARIANTS.join(", "))
#assert(lang in LANGS,
  message: "Unknown lang '" + lang + "'. Choose: " + LANGS.join(", "))


// Version + generation date are injected at build time
// They live in PDF metadata only
#let version = sys.inputs.at("version", default: "dev")
#let date-str = sys.inputs.at("date", default: none)
#let gen-date = if date-str != none {
  let p = date-str.split("-")
  datetime(year: int(p.at(0)), month: int(p.at(1)), day: int(p.at(2)))
} else {
  datetime.today()
}

#set document(date: gen-date, keywords: ("CV", "resume", "John Doe", "v" + version))
#set text(lang: lang)

// pick: select the block for the active (lang, variant), falling back to
// DEFAULT-LANG / DEFAULT-VARIANT so partially authored matrices still render.
// matrix shape: (en: (backend: [...], embedded: [...]), ...)
#let pick(matrix) = {
  let by-lang = matrix.at(lang, default: matrix.at(DEFAULT-LANG))
  by-lang.at(variant, default: by-lang.at(DEFAULT-VARIANT))
}

// lang-pick: like pick() but for content shared across all variants.
// matrix shape: (en: [...], es: [...])
#let lang-pick(matrix) = matrix.at(lang, default: matrix.at(DEFAULT-LANG))

// Section headings keyed by language
#let hl = lang-pick((
  en: (
    summary: "Summary",
    experience: "Experience",
    projects: "Projects & Open Source",
    education: "Education",
    skills: "Skills",
  ),
  es: (
    summary: "Resumen",
    experience: "Experiencia",
    projects: "Proyectos y Open Source",
    education: "Educación",
    skills: "Habilidades",
  ),
))

// Personal information — replace with your own
#let name = "John Doe"
#let location = "San Francisco, CA"
#let email = "john@example.com"
#let github = "github.com/john-doe"
#let linkedin = "linkedin.com/in/john-doe"

#show: resume.with(
  author: name,
  location: location,
  email: email,
  github: github,
  linkedin: linkedin,
  // accent-color: "#000000",
  accent-color: "#26428b",
  font: "New Computer Modern",
  paper: "a4",
  author-position: left,
  personal-info-position: left,
)


// Varies by variant: Summary
#let summary-content = (
  en: (
    backend: [
      Software engineer with N+ years of turning requirements into CRUD operations and questionable architectural decisions.
      Has a healthy relationship with tech debt.
    ],
    embedded: [
      Computer engineer who programs microcontrollers for fun and also for work, which ruins the fun.
      Comfortable with LED debugging and sillyscoping.
    ],
  ),
  es: (
    backend: [
      Ingeniero de software con N+ años convirtiendo requisitos en operaciones CRUD y decisiones cuestionables.
      Experto en mantenimiento de backlog creciente.
    ],
    embedded: [
      Ingeniero en computación que programa microcontroladores por diversión y por trabajo,
      lo que arruina la diversión.
      Cómodo cuando el OS es opcional y el debugger es un LED.
    ],
  ),
)

== #hl.summary

#pick(summary-content)


== #hl.experience

#work(
  title: "Senior Software Engineer",
  company: "Placeholder Corp",
  location: lang-pick((en: "Remote", es: "Remoto")),
  dates: dates-helper(start-date: "Jan 2022", end-date: lang-pick((en: "Present", es: "Presente"))),
)
#pick((
  en: (
    backend: [
      - Maintained a monolith nobody knew how it worked, then split it into microservices everyone was too afraid to touch.
      - Reduced API response time by 40% by swapping HDDs with SSDs.
      - Built and operated a production system with 99.9% uptime during business hours.
    ],
    embedded: [
      - Wrote self-healing firmware by jumping to the reset vector every few lines.
      - Traced a race condition to a 3ns signal path mismatch. Fixed it by adding a NOP.
      - Got a chip working without vendor support. The vendor was surprised too.
    ],
  ),
  es: (
    backend: [
      - Mantuve un monolito que nadie sabía tocar, luego lo dividí en microservicios que nadie se atrevía a tocar.
      - Reduje el tiempo de respuesta de la API un 40% cambiando los HDDs por SSDs.
      - Construí y operé un sistema en producción con 99,9% de uptime — durante horario laboral.
    ],
    embedded: [
      - Escribí firmware self-healing saltando al reset vector cada un par de líneas.
      - Tracé una race condition hasta un mismatch de 3ns en el signal path. Lo resolví con un NOP.
      - Puse en marcha un chip sin soporte del vendor. El vendor también se sorprendió.
    ],
  ),
))

#work(
  title: "Co-Founder & Engineering Lead",
  company: "SomeSaaS LLC",
  location: lang-pick((en: "Remote, part-time", es: "Remoto, part-time")),
  dates: dates-helper(start-date: "2023", end-date: lang-pick((en: "Present", es: "Presente"))),
)
#lang-pick((
  en: [
    - Co-founded a B2B AI-native SaaS with real customers without knowing what "go-to-market" meant.
    - Built and deployed a multi-tenant backend with a dedicated microservice for each API endpoint.
    - Owned the product end-to-end from idea to implementation to success.
    - Lead a small team of 3 engineers, mentoring them through the challenges of building a product from scratch (me, myself and I).
  ],
  es: [
    - Co-fundé un SaaS B2B AI-native con clientes reales sin saber qué significaba "go-to-market".
    - Construí y desplegué un backend multi-tenant con un microservicio dedicado para cada endpoint.
    - Fui owner del producto end-to-end, de la idea a la implementación al éxito.
    - Lideré un equipo de 1.
  ],
))

== #hl.projects

#pick((
  en: (
    backend: [
      #project(name: "overengineered-todo", url: "github.com/john-doe/overengineered-todo")
      - A to-do list with a message queue and a cache layer. Designed for 10M users; currently used by 3.
      #project(name: "json-to-json-transformer", url: "github.com/john-doe/json-to-json-transformer")
      - Transforms JSON into slightly different JSON. Fully unit-tested to ensure the output remains JSON parseable.
      #project(name: "personal-api", url: "github.com/john-doe/personal-api")
      - REST API for life management. The endpoints are documented. Good luck with the life part.
    ],
    embedded: [
      #project(name: "blinkenlights", url: "github.com/john-doe/blinkenlights")
      - Blink an LED on a bare-metal ARM Cortex-M leveraging RTOS, Bluetooth and a lot of regrets.
      #project(name: "useless-fpga", url: "github.com/john-doe/useless-fpga")
      - FPGA implementation of something that already exists in software to prove hardware can do it too, and faster.
      #project(name: "coffee-machine-firmware", url: "github.com/john-doe/coffee-machine-firmware")
      - Controls a coffee machine.
    ],
  ),
  es: (
    backend: [
      #project(name: "overengineered-todo", url: "github.com/john-doe/overengineered-todo")
      - Lista de tareas con message queue y cache layer. Diseñada para 10M de usuarios; usada por 3.
      #project(name: "json-to-json-transformer", url: "github.com/john-doe/json-to-json-transformer")
      - Transforma JSON en JSON levemente diferente. Con tests para verificar que el output sigue siendo JSON parseable.
      #project(name: "personal-api", url: "github.com/john-doe/personal-api")
      - API REST para gestión de vida personal. Los endpoints están documentados. La vida, no.
    ],
    embedded: [
      #project(name: "blinkenlights", url: "github.com/john-doe/blinkenlights")
      - LED parpadeando en ARM Cortex-M bare-metal con RTOS, Bluetooth y optimización por FPGA.
      #project(name: "useless-fpga", url: "github.com/john-doe/useless-fpga")
      - Implementación en FPGA de algo que ya existe en software, para demostrar que el hardware también puede. Y más rápido.
      #project(name: "coffee-machine-firmware", url: "github.com/john-doe/coffee-machine-firmware")
      - Controla una cafetera.
    ],
  ),
))


== #hl.education

#edu(
  institution: "State University of Generic Studies",
  location: "Somewhere, CA",
  dates: dates-helper(start-date: "Jan 2024", end-date: "Dec 2027"),
  degree: lang-pick((
    en: "Computer Engineering (in progress, expected Dec 2027, GPA: average)",
    es: "Ingeniería en Computación (en curso, egreso estimado dic 2027, promedio: suficiente)",
  )),
)
#lang-pick((
  en: [- Data Structures, Algorithms, Operating Systems, Databases, weekly movie night.],
  es: [- Estructuras de Datos, Algoritmos, Sistemas Operativos, Bases de Datos y una noche de películas semanal.],
))

#edu(
  institution: "Community College of Practical Experience",
  location: "The Internet",
  dates: dates-helper(start-date: "2018", end-date: "2021"),
  degree: lang-pick((
    en: "Applied Computing",
    es: "Informática Aplicada",
  )),
)
#lang-pick((
  en: [- Networking, web development, Excel spreadsheets"],
  es: [- Redes, desarrollo web y hojas de cálculo Excel"],
))


// Varies by variant: Skills
#let skills-content = (
  en: (
    backend: [
      - *Languages*: Python, TypeScript & JavaScript, Go, SQL, Bash, and a little Rust
      - *Backend & Web*: REST APIs, GraphQL, Node.js, Express, React, Next.js, WebSockets
      - *Cloud & DevOps*: GCP or AWS, Docker, Kubernetes, Terraform, CI/CD
      - *Databases*: PostgreSQL, Redis, MongoDB, MySQL
      - *AI/ML*: RAG, LangChain, LangGraph
      - *Spoken Languages*: English (professional), Spanish (native)
    ],
    embedded: [
      - *Embedded & Hardware*: ARM Cortex-M (bare-metal), FPGA, VHDL, digital electronics, oscilloscope therapy
      - *Languages*: C, VHDL, Python, assembly (reluctantly)
      - *Protocols*: SPI, I2C, UART, CAN, USB-C (I never manage to plug the rectangular ones in the right way)
      - *Backend & Cloud*: Docker, CI/CD, basic cloud
      - *Spoken Languages*: English (professional), Spanish (native)
    ],
  ),
  es: (
    backend: [
      - *Lenguajes*: Python, TypeScript & JavaScript, Go, SQL, Bash y algo de Rust
      - *Backend y Web*: REST APIs, GraphQL, Node.js, Express, React, Next.js, WebSockets
      - *Cloud y DevOps*: GCP o AWS, Docker, Kubernetes, Terraform, CI/CD
      - *Bases de datos*: PostgreSQL, Redis, MongoDB, MySQL
      - *IA/ML*: RAG, LangChain, LangGraph
      - *Idiomas*: Inglés (profesional), Spanish (nativo)
    ],
    embedded: [
      - *Embebidos y Hardware*: ARM Cortex-M (bare-metal), FPGA, VHDL, electrónica digital
      - *Lenguajes*: C, VHDL, Python, Assembly
      - *Protocolos*: SPI, I2C, UART, CAN, USB
      - *Backend y Cloud*: Docker, CI/CD, cloud
      - *Idiomas*: Inglés (profesional), Spanish (nativo)
    ],
  ),
)

== #hl.skills

#pick(skills-content)
