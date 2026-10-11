#import "@preview/basic-resume:0.2.9": * // template que escogí

#let name = "Javier Larré"
#let location = "Maipú, Santiago" // Yo coloqué mi dirección, pero la eliminé aquí
#let email = link("mailto:javier.larre@uc.cl")
#let gmail = link("mailto:javierlarreu@gmail.com")
#let github = link("https://github.com/JavierLarre")
#let gitlab = link("https://gitlab.com/JavierLarre")
#let telegram = "@JavierLarre"
#let linkedin = link("https://linkedin.com/in/javier-larre-v")
#let phone = "+56 9 9056 3636"
#let slack = link("https://uc-chile-mcd.slack.com/team/U0BNBDP4CGJ")
#let zmartboard = "JavierLarre"
#let program = "Licenciatura en Ingeniería en Ciencias de la Computación" 
#let becas = [Ninguna]
#let english-level = [C2]
// Si eres de ingeniería entonces deberías modificar esta última variable y la tabla

#let photo = {
  image(
  "photo.jpg",
  fit: "contain"
)
}

// Esta función construye una tabla a partir de un csv de ramos
#let ramos(filename) = {
  let data = csv(filename + ".csv").slice(1) // elimina el header
  table(
    columns: (1fr, 3fr, 1fr), // espacios de la columna
    table.header([*Sigla*], [*Nombre*], [*Semestre*]), 
    ..data.flatten()
  )
}

#set table(stroke: none) 
// las tablas NO tendrán lineas por default

// Función para empezar el cv
#show: resume.with(
  author: name,
  // All the lines below are optional.
  // For example, if you want to to hide your phone number:
  // feel free to comment those lines out and they will not show.
  // location: location,
  // email: email,
  // github: github,
  // linkedin: linkedin,
  // phone: phone,
  // personal-site: personal-site,
  accent-color: "#26428b",
  font: "New Computer Modern",
  paper: "us-letter",
  author-position: left,
  personal-info-position: left,
  lang: "es"
)

// Comentarios del creador del template
/*
* Lines that start with == are formatted into section headings
* You can use the specific formatting functions if needed
* The following formatting functions are listed below
* #edu(dates: "", degree: "", gpa: "", institution: "", location: "", consistent: false)
* #work(company: "", dates: "", location: "", title: "")
* #project(dates: "", name: "", role: "", url: "")
* #certificates(name: "", issuer: "", url: "", date: "")
* #extracurriculars(activity: "", dates: "")
* There are also the following generic functions that don't apply any formatting
* #generic-two-by-two(top-left: "", top-right: "", bottom-left: "", bottom-right: "")
* #generic-one-by-two(left: "", right: "")
*/

// Ejemplo de uso
/*
== Education

#edu(
  institution: "Harvey Mudd College",
  location: "Claremont, CA",
  dates: dates-helper(start-date: "Aug 2023", end-date: "May 2027"),
  degree: "Bachelor's of Science, Computer Science and Mathematics",

  // Uncomment the line below if you want edu formatting to be consistent with everything else
  // consistent: true
)
- Cumulative GPA: 4.0\/4.0 | Dean's List, Harvey S. Mudd Merit Scholarship, National Merit Scholarship
- Relevant Coursework: Data Structures, Program Development, Microprocessors, Abstract Algebra I: Groups and Rings, Linear Algebra, Discrete Mathematics, Multivariable & Single Variable Calculus, Principles and Practice of Comp Sci
*/

== Datos Personales

#columns(2)[

#table(
  columns: 2,
  [Nombre], name,
  [Domicilio], location,
  [Telefono], phone,
  [Telegram], telegram,
  [Correo], email,
  [Gmail], gmail,
  [Linkedin], linkedin,
  [Github], github,
  [Gitlab], gitlab,
  [Zmartboard], zmartboard,
  [Slack], slack,
  [Programa], program,
  [Becas], becas,
  [Nivel de ingles], english-level,
)

#colbreak()

#figure(
  photo,
  caption: [Foto Actual], // Mentira, es ma vieja la wea
  supplement: none // Para no mostrar "figura 1:"
)
]


== Ayudantías

#ramos("ayudantias")

== Cursos nivel 2000 

#ramos("2000")

== Cursos nivel 3000

#ramos("3000")

== Experiencia en Desarrollo de Software

#work(
  title: "Práctica de desarrollo en Pharo",
  location: "Lille, Hauts-de-France, France",
  company: "Centre INRIA de l’université de Lille",
  dates: dates-helper(start-date: "Diciembre 2025", end-date: "Marzo 2026")
)

// Escribí estas variables auxiliares para no tener que repetir el formato de las palabras que más se repetían
#let pharo = [*Pharo*]
#let dr_tests = [_DrTests_]
#let test_runner = [_TestRunner_]
#let smells = [_smells_]
#let test_smells = [_test _] + smells

El objetivo de esta práctica está compuesto de tres proyectos distintos relacionados con #underline[_testing_], realizados en el lenguaje de programación #underline(pharo):
- El primer objetivo fue sobre implementar un plugin de #dr_tests para mostrar tests con algún orden significativo. El primer mes fue dedicado exclusivamente a esto.
- Desde el segundo mes visité y retomé el trabajo hecho para detectar #test_smells. Implementé detectores para cuatro #smells distintos, y luego integré los cambios a #dr_tests para visualizar los #smells detectados al usuario.
- Finalmente, también tuve que investigar sobre #test_runner, un proyecto iniciado anteriormente con el objetivo de desacoplar la ejecución de los tests. Este proyecto debe ser integrado a aquellos clientes en Pharo que manejen ejecución de tests.
- Durante la segunda mitad de mi estadía me dediqué a entender la arquitectura de _SUnit_ y #test_runner, refactorizando el proyecto oportunamente para prepararlo para la integración. Durante las últimas semanas se integró al plugin de #test_runner de #dr_tests.
Este equipo en particular estaba interesado en desarrollar un lenguaje y frameworks legibles para humanos, #underline[por lo que no estaban interesados en IA generativa]. Es decir, el desarrollo de estos proyectos *fue hecho sin IA generativa*. Por este mismo motivo, tuve que escribir código considerando que se va a seguir leyendo, usando y modificando en el futuro, por lo que utilicé prácticas como #underline[TDD] para lograr esto. El resultado fueron frameworks que seguían principios #underline[SOLID].

#generic-one-by-two(left: [*Ayudantía de Estructuras de Datos*], right: dates-helper(start-date: "Agosto 2024", end-date: "Julio 2025"))

Además de participar en el diseño de los problemas, utilizamos Python para la generación de los tests y C para las soluciones esperadas de los alumnos. Tomé la ayudantía porque me gusta programar en C.

#generic-one-by-two(left: [*Ayudantía de Lenguajes de Programación*], right: dates-helper(start-date: "Agosto 2025", end-date: "Julio 2026"))

Mis responsabilidades como ayudante fueron principalmente corregir entregas de tareas hechas en #underline[_Scheme_, y un par en _Haskell_], parcialmente con #underline[corrección automatizada con tests]. Además, ayudé a alumnos con esos lenguajes. Tomé la ayudantía porque me gustó la #underline[programación funcional], además de aprender sobre lenguajes de programación y sus #underline[implementaciones].

#project(dates: dates-helper(start-date: "Agosto 2025", end-date: "Septiembre 2025"), name: "Uno en Godot", role: "Pet Project", url: "https://github.com/JavierLarre/uno-no-mercy")

Proyecto personal hecho #underline[en Godot con C\#] para experimentar y aprender #underline[_clean code_]. Utilicé #underline[TDD, sin IA generativa,] para desarrollar principalmente el backend del juego. No es un juego terminado, pero gracias a que el código sigue #underline[principios SOLID] se puede retomar fácilmente.

#pagebreak()

#project(dates: "Marzo 2025", name: "Mesh Generation en Godot", role: "Pet Project", url: "https://github.com/JavierLarre/mesh-generation-demo")

Demo hecha en Godot para #underline[generar terreno] utilizando meshes escrita en #underline[GDScript]. Después de seguir el tutorial #underline[refactoricé] el código para desafiar si entendía #underline[cómo dibujar meshes y gráficos 3D]. Este proyecto tambien fue hecho sin uso de IA generativa.

=== Lenguajes de Programación 

#table(
  columns: (4cm, auto),
  table.header([*Lenguaje*], [*Experiencia*]),
  link("https://en.wikipedia.org/wiki/Pharo")[Pharo], [Es un lenguaje poderoso, cómodo y divertido de trabajar. Cómo lo dije antes, lo aprendí y utilicé durante mi práctica],
  [GDScript], [Lo encuentro muy fácil de usar, me gusta usarlo para hacer cosas rápidas en Godot como demos o prototipos.],
  [C], [Uno de mis favoritos porque me gusta manejar memoria y utilizar punteros, pero extraño los objetos. Además, he utilizando un poco C++.],
  [C\#], [Lo he usado para algunos projectos y Game Jams en Godot, además de haberlo utilizado para el proyecto de Diseño Detallado de Software (IIC2113).],
  [Haskell y Scheme], [Utilicé estos lenguajes durante mis ayudantías en los cursos de lenguajes de programación. En general me gusta la programación funcional. He escrito tareas, soluciones y scripts para automatizar la corrección con tests.],
  [Latex y Typst], [He escrito y diseñado tareas y presentaciones en Latex, y ultimamente en Typst. ¡De hecho, este Currículum Vitae fue escrito en Typst! (Y tambien sin apoyo de la IA, porque la documentación online es muy fácil de usar)],
  [Python], [Además de haberlo usado en múltiples cursos y ayudantías, me ha sido útil cuando necesito algún script corto, por ejemplo que traspase datos o formatos.],
  [JavaScript, TypeScript, HTML y CSS], [He usado React para un par de proyectos y hackatones.],
  [Clingo], [Escribí un programa para obtener todas las combinaciones posibles de los ramos que puedo tomar en un semestre, me tomó menos de una hora y el código resultó corto y explícito.],
)


== Experiencia en Diseño Gráfico

#project(dates: "2026-1", name: "LicitApp", role: "Proyecto en interfaces y experiencia de usuarios (IIC2182)", url: "https://github.com/JavierLarre/LicitApp")

Proyecto de semestre sobre visualización de licitaciones de Mercado público: Ordena los datos obtenidos online y los muestra en tres vistas diferentes #underline[diseñadas para analistas o consultores del sector público]. Fue hecho con #underline[Next.js, TypeScript, Vercel e IA generativa]. 

#project(dates: "2024-2", name: "Visualizaciones de conectividad a internet en Chile", role: "Proyecto de visualización de la información (IIC2026)", url: "https://github.com/JavierLarre/proyecto-infovis")


En este proyecto de semestre buscábamos alguna correlación entre la estabilidad de conexiones móviles y la cantidad de usuarios activos en redes sociales en Chile, con la hipótesis de que la cantidad de usuarios aumentaba junto con la estabilidad de las conexiones móviles, lo cual no fue cierto. 

Se utilizó principalmente JavaScript, junto con la librería Plotly, para graficar los datos. Además, el proyecto utilizaba #underline[sonidos y representaciones físicas, junto con tecnología Aruco], para interactuar con las visualizaciones.

== Experiencia en Administración de proyectos de Software 

#project(dates: dates-helper(start-date: "Enero 2025", end-date: "Febrero 2025"), name: "Global Game Jam 2026", role: "Game Jam", url: "https://globalgamejam.org/games/2026/ntm-3")

Tuve la oportunidad de participar en la GGJ 2026, donde el desafio era desarrollar un juego en *48 horas* con la temática de máscaras. Nos dividimos las tareas entre #underline[un artista, un compositor y dos programadores] para hacer una demo en Godot. Además de ser un programador, #underline[organicé el plan incial de desarrollo].

#pagebreak()

#project(dates: dates-helper(start-date: "Abril 2025", end-date: "Mayo 2025"), name: "Receso Game Jam 2025", role: "Game Jam", url: "https://zabieru-lol.itch.io/diseador-de-puertas-pro")

Participé en una GameJam organizada por la comunidad GameDevUc (de la cual #underline[actualmente formo parte del equipo de organizadores]) durante el receso de 2025-1. El desafío era desarrollar un juego en una semana con la temática de puertas. Nos dividimos las tareas entre #underline[dos artistas y tres programadores] para una demo en Godot. Como programador fui responsable del proceso de build y publicación; diseñar la estructura inicial del código y el flujo del juego; y comunicarme con los artistas sobre algunos requisitos.

#project(dates: "Julio 2024", name: "Game Design Jam 2024", role: "Game Design Document", url: "https://www.instagram.com/p/C8pDXBtu0Tr/")

Participé en una jam de documentos de diseño para el desarrollo de un videojuego #underline[junto con otros dos programadores]. Durante el final del evento #underline[presenté nuestro documento a la audiencia].

== Publicaciones de artículos en Workshops o Conferencias

No tengo publicaciones a mi nombre, pero hay una en proceso de review donde yo investigué e hice proof-checking. Es sobre #underline[generación de tests con LLMs en Pharo.]

== Tareas que me gustaría desarrollar

/*
Tareas que te interesaría desarrollar y por qué (tareas asociadas al rol preferido, y tareas asociadas al rol secundario). Las tareas asociadas a ciertos roles son: Administrador, Analista, Diseñador/Arquitecto de Software, Desarrollador o Tester.

El Administrador es el principal responsable del proyecto (Decision-maker). Las actividades en este rol
son ejercidas por un solo estudiante en el equipo.
El responsable de las tareas de análisis (Analista) es el encargado de relevar y especificar los requisitos del
sistema a desarrollar. Las actividades en este rol son ejercidas como complemento a las principales
actividades o tareas de implementación de componentes o soluciones de software que todos los
estudiantes del equipo deben desarrollar.
El responsable de las tareas de diseño (Diseñador/Arquitecto de Software) es el encargado de generar el
diseño del front-end y back-end del sistema. Las actividades en este rol son ejercidas como complemento
a las principales actividades o tareas de implementación de componentes o soluciones de software que
todos los estudiantes del equipo deben desarrollar.
El responsable de las tareas de implementación (Implementador/Desarrollador) es el encargado de
implementar diferentes componentes o soluciones de software para el sistema. LAS ACTIVIDADES EN
ESTE ROL SON EJERCIDAS POR TODOS LOS ESTUDIANTE EN EL EQUIPO.
El responsable de las tareas de testing (Tester) es el encargado de asegurar la calidad de cada uno de los
productos (documentos, prototipos, etc). Las actividades en este rol son ejercidas como complemento
a las principales actividades o tareas de implementación de componentes o soluciones de software
que todos los estudiantes del equipo deben desarrollar.

*/

Mis roles preferidos son tester y diseñador de software porque me gusta desarrollar #underline[siguiendo buenas prácticas], como TDD, para tener codebases moldeables, explícitas y fáciles de usar.

Escribir distintos tipos de tests (unit, integration, system, end2end, etc) tiene por objetivo verificar que el programa se comporte como se espera, como asímismo facilita tanto moldear el código, para que sea mantenible en el tiempo, como el proceso de escribir la documentación. Además, si hay buena comunicación, los tests representarán los requisitos de los usuarios. Me gustaría ser parte de este rol sin importar que mis compañeros de grupo no conozcan estas prácticas.

Me gustaría ser administrador *solamente* si el proyecto está relacionado con desarrollo de videojuegos (soñar es gratis).

== Expectativas

/*
Uno, dos o tres párrafos que manifiestes-detalles las expectativas que tienes al realizar el curso Capstone IIC2154 Proyecto de Especialidad del Major en Ingeniería de Software o Computación y Sistemas de Información.  
*/

Estoy emocionado por ver los resultados de desarrollar programas que ayuden a personas en la industria, al mismo tiempo de entregar código valioso para el futuro. Además, *Docker* es una de las tecnologías que me gustaría aprender.

// Abajo está el ejemplo del autor del template

/*
== Work Experience

#work(
  title: "Subatomic Shepherd and Caffeine Connoisseur",
  location: "Atomville, CA",
  company: "Microscopic Circus, Schrodinger's University",
  dates: dates-helper(start-date: "May 2024", end-date: "Present"),
)
- Played God with tiny molecules, making them dance to uncover the secrets of the universe
- Convinced high-performance computers to work overtime without unions, reducing simulation time by 50%
- Wowed a room full of nerds with pretty pictures of invisible things and imaginary findings

#work(
  title: "AI Wrangler and Code Ninja",
  location: "Silicon Mirage, CA",
  company: "Organic Stupidity Startup",
  dates: dates-helper(start-date: "Dec 2023", end-date: "Mar 2024"),
)
- Taught robots to predict when (and how much!) humans will empty their wallets at the doctor's office
- Developed HIPAA-compliant digital signatures, because doctors' handwriting wasn't illegible enough already
- Turned spaghetti code into a gourmet dish, making other interns drool with envy

#work(
  title: "Digital Playground Architect",
  location: "The Cloud",
  company: "Pixels & Profit Interactive",
  dates: dates-helper(start-date: "Jun 2020", end-date: "May 2023"),
)
- Scaled user base from 10 to 2000+, accidentally becoming a small wealthy nation in the process
- Crafted Bash scripts so clever they occasionally made other engineers weep with joy
- Automated support responses, reducing human interaction to a level that would make introverts proud
- Built a documentation site that actually got read, breaking the ancient RTFM curse

#work(
  title: "Code Conjurer Intern",
  location: "Silicon Suburb, CA",
  company: "Bits & Bytes Consulting",
  dates: dates-helper(start-date: "Jun 2022", end-date: "Aug 2022"),
)
- Developed a cross-platform mobile app that turned every user into a potential paparazzi
- Led a security overhaul, heroically saving the company from the menace of "password123"

== Projects

#project(
  name: "Hyperschedule",
  // Role is optional
  role: "Maintainer",
  // Dates is optional
  dates: dates-helper(start-date: "Nov 2023", end-date: "Present"),
  // URL is also optional
  url: "hyperschedule.io",
)
- Maintain open-source scheduler used by 7000+ users at the Claremont Consortium with TypeScript, React and MongoDB
  - Manage PR reviews, bug fixes, and coordinate with college for releasing scheduling data and over \$1500 of yearly funding
- Ensure 99.99% uptime during peak loads of 1M daily requests during course registration through redundant servers

== Extracurricular Activities

#extracurriculars(
  activity: "Capture The Flag Competitions",
  dates: dates-helper(start-date: "Jan 2021", end-date: "Present"),
)
- Founder of Les Amateurs (#link("https://amateurs.team")[amateurs.team]), currently ranked \#4 US, \#33 global on CTFTime (2023: \#4 US, \#42 global)
- Organized AmateursCTF 2023 and 2024, with 1000+ teams solving at least one challenge and \$2000+ in cash prizes
  - Scaled infrastructure using GCP, Digital Ocean with Kubernetes and Docker; deployed custom software on fly.io
- Qualified for DEFCON CTF 32 and CSAW CTF 2023, two of the most prestigious cybersecurity competitions globally

// #extracurriculars(
//   activity: "Science Olympiad Volunteering",
//   dates: "Sep 2023 --- Present"
// )
// - Volunteer and write tests for tournaments, including LA Regionals and SoCal State \@ Caltech

// #certificates(
//   name: "OSCP",
//   issuer: "Offensive Security",
//   // url: "",
//   date: "Oct 2024",
// )

== Skills
- *Programming Languages*: JavaScript, Python, C/C++, HTML/CSS, Java, Bash, R, Flutter, Dart
- *Technologies*: React, Astro, Svelte, Tailwind CSS, Git, UNIX, Docker, Caddy, NGINX, Google Cloud Platform
*/