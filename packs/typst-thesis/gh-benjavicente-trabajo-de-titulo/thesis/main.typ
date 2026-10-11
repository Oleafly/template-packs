#import "/template/thesis.typ" as TT
#import "/template/cover.typ": cover
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge
#import "@preview/codly:1.3.0": codly-init, codly
#show: codly-init.with()
#codly(zebra-fill: none, lang-stroke: none, stroke: 1pt + black.lighten(75%), inset: 0.3em)

#let title = "Desarrollo de herramientas white-label para la venta inmobiliaria en MOME"
#let author = "Benjamín Vicente Goecke"

#set document(author: author, title: title)
#show: TT.template

#cover(
  header: [
    Escuela de Ingeniería.
    #parbreak()
    Departamento de Ciencia de la Computación
  ],
  title: title,
  author: author,
  description: [
    Trabajo de Título para optar al Título
    #linebreak()
    de Ingeniero Civil de Computación.
  ],
  lead: [
    Profesor guía:
    #linebreak()
    #text(weight: "semibold", upper("Jaime Navon"))
  ],
  date: "20 de enero del 2025",
)

#TT.main_outline(depth: 2)
#TT.figure_outline()

= Resumen

En este informe, se muestra el trabajo realizado por Benjamín Vicente Goecke en el trabajo de título, entre septiembre y diciembre del 2024, desempeñándose como CTO en MOME. Los proyectos establecidos fueron la creación de un sistema para páginas web _white-label_ para la venta inmobiliaria, y la integración de inteligencia artificial en los canales de fuerza de ventas.

Dentro los proyectos, se resolvieron problemas de arquitectura, de la modelación de la base de datos del inventario, del diseño del sistema web requerido para las páginas _white-label_, y del desarrollo de un sistema para integrar una inteligencia artificial para ayudar a la fuerza de ventas.

En cada uno, se logró demostrar las competencias al aplicar conocimientos de computación para entender problemas complejos, diseñar y planificar soluciones innovadoras dado las características de los problemas, y llevar el desarrollo de estas soluciones, desde el realizado en el corto plazo dentro del trabajo de título, hasta el largo plazo con las estrategias y planificación realizada.


#v(3em)
= Abstract

This report outlines the word done by Benjamín Vicente Goecke during his thesis project, between September and December 2024, working as CTO at MOME. The established projects included the creation of a system for _white-label_ web pages for real estate sales, and the integration of artificial intelligence into sales force channels.

Within those projects, challenges were addressed in areas such as architecture, database modeling for the inventory system, the design of the web system required for the _white-label_ pages, and the development of a system to integrate artificial intelligence to assist the sales force.

In each case, the competencies were addressed by applying computer science knowledge to understand complex problems, design and plan innovative solutions based on the characteristics of the problems, and carry out the development of these solutions, from the work done within the time of the thesis project, to the long-term, with the strategies and planning carried out.

#show: TT.content

= Introducción

== Contexto de la empresa y las soluciones a desarrollar

MOME es una Start-Up tecnológica del mundo inmobiliario (_proptech_). Su objetivo es proveer tecnología a inmobiliarias, para que puedan vender por canales propios, sin depender de muchos terceros. Fue fundada en mayo del 2024, y, al momento de la escritura de este informe, cuenta con 4 empleados full-time y contó con un desarrollador practicante part-time. Yo soy CTO y el único empleado técnico full time. Además, a finales del trabajo de título, contó con 4 clientes.

El software que busca desarrollar es similar a #link("https://www.shopify.com")[Shopify] en mundo de _e-commerce_, o #link("https://www.getjusto.com")[Justo] en los restaurantes. Es decir, una plataforma _white-label_ para proyectos inmobiliarios, permitiendo la creación de su página web, gestión de su inventario, herramientas para la comunicación con clientes, integraciones con diferentes servicios y reportaría.

El mercado inmobiliario es considerablemente diferente con otros mercados. Primero, el valor por unidad es el más alto de los bienes esenciales, y por tanto, la compra es infrecuente. Segundo, dado que suele ser la inversión más grande de una persona, la decisión de compra es lenta, se toma con mucha información, y el proceso de venta es largo.

Considerando el contexto internacional actual, es un mercado que recientemente se ha encontrado en una recesión, y no había tenido la presión hacia la digitalización que otros mercados han tenido. Por último, el funcionamiento en la venta inmobiliaria es considerablemente distinto en países como Estados Unidos, donde los procesos están estructurados para requieran corretajes.

En este contexto, la solución que se busca desarrollar inicialmente cuenta de 2 pilares. Uno es el desarrollo de los medios propios, como es la página web. Esta deberá ser optimizada para motores de búsqueda (SEO), y para la experiencia y conversión (_user experience_, UX). Además, deberá ser alimentada por un gestor de contenido e inventario (_content management system_, CMS).

El segundo pilar es la gestión de clientes. Se busca desarrollar la integración a las bandejas de entrada (_inbox_) de mensajes de los clientes, para poder asistir a la respuesta inicial de estos con inteligencia artificial, y proveer herramientas para la gestión y seguimiento de los clientes. Lo anterior, para entregar visibilidad del proceso a los vendedores y las inmobiliarias.

// Todo esto se buscará ser administrado en un sistema centralizado, que además entregará reportería al estado de la venta de los proyectos inmobiliaria.


== Objetivos del Trabajo de Título


Dentro del marco del trabajo de título, las competencias que se escogieron a demostrar son:

- Aplicar conocimientos avanzados de Ciencia de la Computación, Ingeniería de Software y Sistemas de Información para entender problemas complejos y abiertos.
- Diseñar aplicaciones de software complejas, siguiendo los estándares de la Ingeniería de Software, y tomando aspectos de seguridad y complejidad computacional.
- Desarrollar soluciones innovadoras basadas en conocimientos avanzados de Ingeniería de Computación.


Estas competencias se pueden entender como etapas en el desarrollo de soluciones tecnológicas, en donde hay que entender los problemas a resolver, diseñar soluciones, llevar desarrollos y estrategias de trabajo, y finalmente, implementar estas con la programación. Defino en más detalle cada paso en el @appendix.DevelopmentProcess.

#figure(
  diagram(
    node-corner-radius: 0.5em,
    node-stroke: black,
    node((0,0), [Entender]),
    edge("-|>"),
    node((1, 0), [Diseñar]),
    edge("-|>"),
    node((2, 0), [Desarrollar]),
    edge("-|>"),
    node((3, 0),  text([Programar], fill: luma(50%)), stroke: luma(50%), ),
    edge((1, 0), (0, 0), "--|>", bend: -45deg),
    edge((2, 0), (1, 0), "--|>", bend: -45deg),
    edge((3, 0), (2, 0), "--|>", bend: -45deg),
  ),
  caption: "Etapas del desarrollo de software",
)

En la inscripción del trabajo de título, se plantearon los siguientes 2 proyectos a desarrollar:

1. El desarrollo de sistema _white-label_ para la creación de sitios web de proyectos inmobiliarios. Estos es, la creación de componentes que puedan ser personalizados como deseen las inmobiliarias, y la integración a un _content management system_ (CMS) que permita administrar las características e inventario de las unidades.

2. La implementación de un _shared inbox_ impulsada por inteligencia artificial. Plataforma que permita el control y la gestión centralizada de la fuerza de ventas vía canales como WhatsApp, impulsada por inteligencia artificial, para otorgar respuestas 24/7 y reducir el trabajo realizado por la fuerza de ventas.

Estos proyectos, a pesar de resolver problemas distintos, comparten la necesidad de un sistema centralizado que permita su administración. Por lo tanto, también se buscó desarrollar un sistema de datos centralizado administrable en un _dashboard_.

== Contexto adicional

Es importante considerar que se inició el desarrollo de estos proyectos sin ningún conocimiento previo de la industria inmobiliaria. También se comenzó sin ningún desarrollo tecnológico previo. Por lo tanto, se investigó e iteró desde cero que soluciones serían más adecuadas para todos los componentes de la solución que será desarrollada inicialmente en la empresa.

Como rol de CTO, me desempeño también en gran parte de las reuniones comerciales para entender los problemas que enfrentan los clientes. También, participé en la formación de la estrategia de la construcción del producto que ofrecemos, y coordiné y asistí en el trabajo más técnico de mis compañeros, como por ejemplo, en instalar Microsoft Office.


== Orden del cuerpo de este informe

Este informe, se destacarán los diferentes desafíos que involucraron el desarrollo de los proyectos mencionados, y como se demostró el análisis del problema, el diseño de la solución y la implementación de esta, en sus secciones correspondientes.

Previo a aquello, explicaré las estrategias de trabajo que se siguieron en todos los proyectos, cubriendo tanto metodología de trabajo como el principio de composición, que permitió la rápida iteración en el desarrollo de software.


#pagebreak(weak: true)
= Estrategias de trabajo

== Metodología de trabajo

Se decidió seguir fuertemente los principios ágiles en el desarrollo de software @agile-manifesto. Especialmente, se buscó iteración continua y rápida, simplicidad de soluciones, y participación activa con mis compañeros no técnicos.

Yo implementé y organicé un seguimiento de tareas, usando #link("https://linear.app/homepage")[Linear]. Fui reconociendo los proyectos y tareas claves, y las organicé en tareas accionables concretas. Con el equipo, iterativamente fuimos priorizando los proyectos, y cada día revisábamos el avance. 

Si bien llevamos ciertos rituales asociados a la metodología Scrum como reuniones de revisión diarias @scrum, decidimos no seguirla estrictamente dado el contexto de la empresa, donde no existe un producto completamente definido como tal, y se espera validar y experimentar con nuestros primeros clientes.


== Composición en el desarrollo de software <composition>

Uno de los principios fuertemente usados en el desarrollo fue la composición. Se entiende como composición el patrón que permite construir sistemas complejos a partir de sistemas más simples e independientes. Una buena composición sigue los principios SOLID @solid, aplicados a cualquier nivel de abstracción que involucre la solución.


Por ejemplo, un desarrollo que se realizó fue la generación de PDFs de cotización de proyectos inmobiliarios. La cotización usa la información de una unidad, del cliente, descuentos aplicados, precio UF referencial, y fichas de las unidades y proyectos.

#figure(
  diagram(
    spacing: (3em, 5pt),
    node-stroke: black,
    node((0, 0))[Información unidad],
    node((0, 1))[Información cotizante],
    node((0, 2))[Descuentos aplicados],
    node((0, 3))[Fichas del proyecto],
    node((0, 4))[Valor UF],
    edge((0, 0), "r,d,d,r", "-|>"),
    edge((0, 1), "r,d,r", "-|>"),
    edge((0, 2), "r,r", "-|>"),
    edge((0, 3), "r,t,r", "-|>"),
    edge((0, 4), "r,t,t,r", "-|>"),
    node((2, 2))[Generador PDFs cotización],
  ),
  caption: "Entradas requeridas para la generación de cotizaciones",
)

La generación misma requiere la implementación de un servidor  con una rutina que utilice un sistema que pueda unir la información y generar el PDF. Información como el precio de la UF podría ser obtenido en esta misma rutina, pero esto haría que la generación de PDFs sea más compleja, dado que también se estaría encargando de como se obtiene información.

Uno de todas formas podría programar un software desacoplado, que permita a través de un _dashboard_, cargar la información necesaria, obtener el último valor de la UF, y generar el PDF. Si bien esta es la meta, iniciar así caería en un desarrollo de tipo cascada, contrario al principio ágil, dado que requiere el desarrollo de múltiples funcionalidades antes de tener una versión funcional.

Así que se trató la composición no solo como un principio a nivel de software en un repositorio de código particular, sino como un principio a nivel de sistema y la creación de bloques que puedan ser usados ágil e independientemente, desde pequeños servicios para solucionar rápidamente los problemas, como pequeñas librerías que permitan ser reutilizadas para otros proyectos.

En el caso del ejemplo, lo que se realizó fue montar un servidor que habilite públicamente una rutina que genere PDFs, que tenga como entrada toda la información necesaria, incluyendo las fichas como PDF que deben ser enviadas como binarios. De esta forma, se pudo usar macros (Google Apps Script) de Google Sheet para la carga de datos, y validar la solución.


#figure(
  diagram(
    spacing: (3.5em, 5pt),
    node-stroke: black,
    node((0, 0), fill: green.lighten(85%))[Información unidad (Hoja Unidades)],
    node((0, 1), fill: yellow.lighten(85%))[Información cotizante (Formulario)],
    node((0, 2), fill: yellow.lighten(85%))[Descuentos aplicados (Formulario)],
    node((0, 3), fill: red.lighten(85%))[Fichas del proyecto (Archivos Drive)],
    node((0, 4), fill: purple.lighten(85%))[Valor UF (Función Google Sheet)],
    edge((0, 0), "r,d,d,r", "-|>"),
    edge((0, 1), "r,d,r", "-|>"),
    edge((0, 2), "r,r", "-|>"),
    edge((0, 3), "r,t,r", "-|>"),
    edge((0, 4), "r,t,t,r", "-|>"),
    node((2, 2), fill: purple.lighten(85%))[Macro],
    edge((2, 2), "r", "-|>")[HTTP],
    node((3, 2), fill: blue.lighten(85%))[Rutina generador PDFs cotización],
  ),
  caption: "Implementación inicial de la generación de PDFs",
)

Este desarrollo no solo permitió obtener una solución funcional rápidamente, sino que también permitió añadir funcionalidades adicionales para agilizar la operación, como el envió de la cotización al cliente automáticamente, el guardado de los clientes en una tabla, y el guardado de las cotizaciones generadas en una carpeta de Google Drive.


#pagebreak(weak: true)
= Elección de la arquitectura de la aplicación <testing-on-the-architecture>

== Problema a resolver

El sistema que se buscó construir dentro de MOME, tiene 3 componentes principales:
las páginas _white-label_ para los proyectos inmobiliarios, la base de datos y procesos, y el panel de administrador.

El sistema  _white-label_ provee las páginas de los proyectos a los cotizantes. Su información cambia infrecuentemente, la del proyecto mismo podría cambiar cada mes, y la información de precios y disponibilidad podría cambiar cada semana. Este sistema requiere tener una velocidad de carga muy alta, SEO y buen UX, y permitir la personalización de la página sin grandes costos.

El panel de administrador es consumido por los gestores de los proyectos, por su personal de ventas y administradores de precios y disponibilidad de las unidades. El acceso a este es infrecuente y por pocos usuarios. Este debe ser intuitivo, cómodo de usar, y mantener los datos consistentes y actualizados.

La base de datos y procesos (_backend_), es consumido por los otros dos sistemas, y permite la integración con otros servicios, como el _shared inbox_ y la inteligencia artificial. 
Este sistema debe permitir diferentes niveles de lectura y modificación a la información, la subida de imágenes, poseer un sistema de tareas, y actualizar los datos en tiempo real.

#figure(
  diagram(
    node-stroke: luma(0),
    spacing: 2em,

    let tint(c) = (stroke: c, fill: rgb(..c.components().slice(0,3), 5%), inset: 8pt),

    node((0, 0), [Cotizantes], name: <cotizantes>),
    node((2, 0), [Gestores], name: <gestores>),
    node((0, 1), [Web Proyectos _white-label_], name: <web>),
    node((1, 1), [Base de datos y procesos], name: <db>),
    node((2, 1), [Panel de administrador], name: <admin>),

    node(enclose: ((0, 1), (2, 1)), inset: 8pt, height: 2.25cm, label: align(bottom + left)[Sistema MOME]),
    node(enclose: ((1, 1), (2, 1)), inset: 4pt, label: align(bottom + center)[Sistema de gestión centralizada], height: 2cm),


    edge(<cotizantes>, <web>, "-|>"),
    edge(<gestores>, <admin>, "-|>"),
    edge(<web>, <db>, "-|>"),
    edge(<db>, <admin>, "<|-|>"),
  ),
  caption: "Arquitectura simplificada que se busca desarrollar",
)


== Diseño de la solución

Dado el contexto actual de la empresa, se buscó una arquitectura que permita la rápida iteración sin comprometer sustancialmente la escalabilidad. Para cumplir, la arquitectura deberá permitir fácilmente componer diferentes funcionalidades.

El diseño de el sistema _white-label_ se detalla en su sección #link(<section.white-label>)[su sección correspondiente]. El panel de administrador, se decidió emplear un sistema simple de _single page application_ (SPA) con _React_ que se conecta al _backend_, utilizando #link("https://vite.dev/")[Vite] como _build tool_. Finalmente, el _backend_ requirió más análisis, dado que requiere estado persistente tanto en datos como en tareas.

Además de los requerimientos técnicos, es muy importante que el sistema permita la rápida iteración y desarrollo, sin comprometer sustancialmente lo que pueda hacer el sistema. Es por esto, es que se decidió usar un _Backend as a Service_ (BaaS) para el desarrollo del backend. De este modo, no se necesitará preocuparse de la infraestructura necesaria para las funcionalidades requeridas.

Utilizar un BaaS sacrifica el control y la flexibilidad en el sistema que se desarrolla, en comparación a soluciones donde uno gestiona la infraestructura, como utilizar un servicio como AWS o Google Cloud. Ese sacrificio es aceptable dado que no hay requerimientos que necesiten arquitectura compleja, y que la etapa temprana de la empresa, en la cual se busca validar soluciones.

Para ver que BaaS utilizar, se realizó un análisis comparativo. Además de revisar que tan rápido sería la iteración de funcionalidades con las diferentes soluciones, se características como que tan fácil sería migrar fuera de la solución cloud. Entre las funcionalidades importantes a considerar, se revisaron las siguientes:

#figure(
  table(
    columns: (4.5cm, auto),
    align: (right, left),
    [Infraestructura], [Funcionalidad],
    [Actualización de datos en tiempo real (_real time sync_)], [
      - Ver el estado actual de la IA sin tener que recargar la página.
      - Consistencia de datos a través de los diferentes usuarios.
    ],
    [Sistema de tareas], [
      - Ejecutar la IA luego de cierto tiempo de espera.
      - Permitir actualizar datos con otros sistemas recurrentemente.
    ],
    [Subir imágenes y archivos], [
      - Fotos para las plantas de las unidades y las imágenes de la página del proyecto.
    ],
    [Integración fácil navegador (cliente)], [
      - Agilizar el desarrollo reduciendo la cantidad de código.
    ],
    [Sistema de permisos flexible], [
      - Fácil granularidad de permisos sin comprometer la escalabilidad del sistema.
      - Evitar que lógica de la aplicación quede en sistemas propietarios o lejanos.
    ]
  ),
  caption: "Infraestructura requerida para funcionalidades del backend"
)

== Desarrollo realizado

Se revisaron varias soluciones, y decidí realizar una comparativa en detalle de 4 de estas: #link("https://supabase.io")[Supabase], #link("https://firebase.google.com")[Firebase], #link("https://developers.cloudflare.com/durable-objects/")[Cloudflare Durable Objects], y #link("https://convex.dev")[Convex]. Aunque Durable Objects no es estrictamente un BaaS, facilita la creación de un backend. El detalle de la comparativa se puede ver en el @appendix.BaaS.

Luego de pruebas de concepto con las diferentes soluciones, y un análisis realizado con la comparativa, se decidió utilizar Convex, destacado del resto de las soluciones por los diferentes atributos:

- Sistema generalmente imperativo y explicito, que evita que el comportamiento de funcionalidades varíe lejos de donde está implementado, como es el caso de las _security rules_ y _triggers_ en soluciones como Firebase y Supabase.
- Excelente integración con el cliente, que permite agilizar el desarrollo de la aplicación, y reducir la dependencia de lógica de negocios en el frontend.
- Buenas herramientas de desarrollo. Sistema de testing y subida a producción simple.
- Tuvo la implementación, e iteración de funcionalidades, más rápida de todas las soluciones.


Implementa el principio de consultas y mutaciones separadas @command-query-separation, permitiendo optimizaciones por defecto, como cache automático en consultas y complicidad ACID en mutaciones @acid, importante dado el alto ticket por unidad. Además, permite generar rutinas públicas, que pueden ser llamadas desde la integración que proveen para el navegador.

Se realizó un desarrollo de funcionalidades en Convex, incluyendo las funcionalidades de la gestión de inventario y de la inteligencia artificial que se mencionan más adelante, validando que la solución era adecuada.

Convex no provee un servicio para hostear servicios frontend, por lo que se utilizó #link("https://cloudflare.com")[Cloudflare] temporalmente, dado que posee plan gratuito, y porque ya es parte de la infraestructura de MOME dado que es usado como DNS. Luego del trabajo de título, se evaluará migrar a otro servicio más simple aún, como #link("https://vercel.com")[Vercel].


#pagebreak(weak: true)
= Base de datos del inventario

== Problema a resolver

El sistema que se busca desarrollar debe permitir gestionar diferentes tipos de proyectos. Existen proyectos de casas, parcelas, departamentos, oficinas, y locales comerciales, donde estos pueden tener bienes secundarios como estacionamientos y bodegas, cada uno con precio distinto, y atributos únicos.

Comercialmente, los inmuebles suelen separarse en primarios y secundarios, buscando que los bienes secundarios se vendan junto a los primarios. Legalmente, cada inmueble es independiente. Por ejemplo, en Chile, estacionamientos y oficinas como la misma entidad legal: bienes de dominio exclusivo @ley-21442.

La gestión de inventario es distinto al resto de los comercios online. Es el único bien esencial donde cada unidad es significativamente distinta. Otros bienes, como autos, pueden tener unidades que son prácticamente iguales. En cambio, en bienes raíces, cada una tiene una posición única, y atributos que deben ser considerados como propios de la unidad, y no de un modelo compartido.

Es importante que este sistema permita cargar los datos fácilmente y que pueda alimentar a diferentes funcionalidades. Por ejemplo, el cotizador web, con sus respectivos programas, modelos, y bienes secundarios, la generación y registro de cotizaciones en PDF, y canales externos, como otros portales.

Además, si bien este mercado prioriza soluciones enfocadas únicamente a proyectos de viviendas, el objetivo de MOME es abarcar todo tipo de proyectos inmobiliarios, permitiendo la gestión de estos, y conectando estos a las funcionalidades desarrolladas en el sistema.

#pagebreak(weak: true)
== Diseño de la solución

Para la modelación de estos datos en el sistema de gestión de inventario consideré 3 características principales. Primero, que datos se normalizaran para evitar repetición. Segundo, como se distinguirán los diferentes tipos de unidades. Y por último, como se relacionan los bienes secundarios con las unidades, permitiendo las restricciones empleadas en los proyectos inmobiliarios.

#v(1em)
=== Normalización y agrupación de datos

Sobre la normalización de datos, los proyectos inmobiliarios de viviendas suelen agrupan las unidades de proyectos en torno a programas, y modelos. Ambos deben ser guardados como entidades separadas y con ciertos atributos:

- Los programas suelen ser usados para guardar cuantos dormitorios y baños tienen las unidades, pero esto lleva a 2 problemas. Primero, hay modelos, como “Studio” y 1D+1B, que son diferentes a pesar de que tienen la misma cantidad de dormitorios y baños. Segundo, esto forzaría a que cada proyecto se agrupe por programas, lo que no ocurre en algunos casos, como los proyectos de oficinas, que tienen baños. Soportar ambos casos añade complejidad innecesaria al sistema.

- En el caso de los modelos, se suele asociar un metraje correspondiente, dado que el mismo modelo está normalmente asociado a columnas de edificios, pero aún que estén en la misma columna, el metraje puede cambiar levemente, y debe ser reflejado al momento de la venta. En los modelos se suele asociar un plano de venta, que puede ser levemente distinto a sus unidades.

Además, hay proyectos que agrupan por torre. Uno de nuestros clientes, poseía una limitación en el flujo de cotización que proveían: este se separaba en torre, a pesar de que lo que se vendía era el proyecto completo. Esto es debido a que se asume que las torres son independientes en el software de gestión que emplean, que es uno de los más usados en Chile.


Es por esto, es que decidí no normalizar datos de las unidades que se suelen asociar a los programas y modelos. Los datos que irán asociados a los programas y modelos estarán más orientados a la visualización y marketing de las unidades, y no la información misma de la unidad.

=== Diferentes tipos de unidades

Sobre como diferenciar los diferentes tipos de unidades, se debe considerar que cada tipo puede requerir atributos diferentes. Por ejemplo, los departamentos poseen piso y dormitorios, mientras que una casa no posee piso.

Una opción, que se hace en soluciones importantes en el mercado, es separar los diferentes tipos en diferentes tablas, incluyendo bienes secundarios. Esto permite más fácilmente añadir restricciones en los diferentes tipos. Sin embargo, separarlos añade complejidad al sistema, dado que cualquier funcionalidad asociada a las unidades debe considerar toda tabla de unidades.

La solución que se escogió es tener todo tipo de inmueble en una misma tabla, incluyendo secundarios, que serán diferenciados por un atributo. Esto permite mayor flexibilidad en el sistema, ya que cualquier tipo de funcionalidad puede ser implementado directamente en la tabla de unidades, sin requerir unir datos con cada tipo. Y si se requiere restringir, se puede hacer proactívamente.

Para cada tipo de datos, se añadió un atributo discriminador, que permite diferenciar los diferentes tipos de unidades. Dependiendo del tipo, se valida los atributos que son requeridos. Esto además permite mayor flexibilidad al modelar relaciones entre unidades, por ejemplo, en caso que una unidad requiera ser cotizada en conjunto con otra unidad.

#v(1em)
=== Relaciones entre unidades

Finalmente, las relaciones de como están asociadas las unidades en la cotización, fueron modeladas con una tabla distinta, siguiendo la misma estrategia del atributo discriminador presente en las unidades. Cada unidad podría tener un número arbitrario de relaciones, y se definieron 2 tipos de relaciones: directas a otra unidad, o con un filtro.

Esto aborda todos los casos observados en los proyectos inmobiliarios durante este trabajo. Por ejemplo, un departamento podría tener 2 relaciones directas, uno a un estacionamiento y otro a una bodega. O también, podría existir 2 relaciones que permitan elegir un número máximo de estacionamientos, y una bodega cualquiera opcional.

Si bien estas relaciones ayudan a enforzar las restricciones del plan de venta de los proyectos, se consideró que estas son referencias iniciales para los clientes, y guías y defectos para los vendedores, y no restricciones requeridas en los procesos del sistema.

Por lo tanto, se decidió inicialmente solo verificar las restricciones de la unidad escogida, y no de las relacionadas, para evitar complejidad. Además, se considera que el inventario es estático y solo cambia de estado y precio, por lo que ninguna relación podría quedar en un estado indefinido.


== Desarrollo realizado


Previo a la implementación misma de la base de datos, se estudió que información poseían las inmobiliarias de su inventarios. Los 4 clientes utilizaban distintas estrategias para organizarlo, así que se vió que información era común y que información es clave para los procesos de la venta.

A pesar de que algunos clientes usaban sistemas especializados de gestión de inventario inmobiliario, todos usaban realmente una hoja de cálculo para llevar el inventario. Así que para iterar sobre la solución y proveer mejor experiencia de _onboarding_, se implementó un sistema que valide y cargue los datos desde una hoja tabular.

Para eso, se buscó una librería de validación que permita cargar datos tabulares y evite fallar por filas inválidas. No se encontró, así que se decidió extender una. Entre las librerías populares, está #link("https://valibot.dev")[Valibot], que fue creado con una arquitectura modular @valibot que no poseen otras librerías. Con esta librería, se creó 2 esquemas, con el mismo formato que las librerías _build-in_:

/ `arrayDropInvalid`: Obtiene solo los valores validos de una lista.
/ `namedTuple`: Permite cargar una fila de una tabla con los nombres de columnas dados.


Estos en conjunto pueden ser compuestos para validar datos de la siguiente forma:

#figure(
  [
  ```ts
  import * as v from "extended-valibot";
  const schema = v.arrayDropInvalid(
    v.namedTuple([
      ["state", v.string()],
      ["price", v.number()],
    ]),
  );
  const units = v.validate(schema, [["Vendido", 6000], ["Disponible", 7000], [null, 13000]]);
  console.log(units); // [["Vendido", 6000], ["Disponible", 7000]]
  ```
  ]
)


Si bien esto fue realizado para la carga a la base de datos, la validación es un bloque independiente que puede ser usado en diferentes contextos. Esto fue utilizado en la integración de datos directo desde Google Sheets, como se comenta más adelante.


#let class-diagram-box(
  color: white,
  title: none,
  ..content
) = {
  grid(
    inset: 0.5em,
    fill: white,
    grid.vline(),
    grid.hline(),
    grid.cell(fill: color, align: center,  text(weight: "bold", title)),
    grid.hline(),
    ..content,
    grid.hline(),
    grid.vline(),
  )
}

#let class-diagram-property(name, type) = {
  grid.cell({
    name   
    h(1fr)
    h(1em)
    type
  })
}

#figure(
  diagram(
    node-inset: 0pt,
    node-shape: rect,
    mark-scale: 150%,
    spacing: (2.5em, 1.3em),
    node((0, 0), 
      class-diagram-box(
        color: blue.lighten(80%),
        title: [Unidad],
        class-diagram-property([id], `int`),
        class-diagram-property([tipo], `str`),
        class-diagram-property([estado], `str`),
        class-diagram-property([precio], `int`),
      )
    ),
    edge((0, 0), (1, 0), "<|-"),
    node((1, 0), 
      class-diagram-box(
        color:  blue.lighten(80%),
        title: [Vivienda],
        class-diagram-property([dormitorios], `int`),
        class-diagram-property([baños], `int`),
        class-diagram-property([idModelo], `int | null`),
      )
    ),

    edge((0, 0), (0, 1), "<|-"),
    node((0, 1), 
      class-diagram-box(
        color: green.lighten(80%),
        title: [Parcela],
        class-diagram-property([tipo], `"parcela"`),
      )
    ),
    edge((1, 0), (1, 1), "<|-"),
    node((1, 1), 
      class-diagram-box(
        color: green.lighten(80%),
        title: [Departamento],
        class-diagram-property([tipo], `"departamento"`),
        class-diagram-property([piso], `int`),
      )
    ),
    edge((1, 0), (2, 0), "->"),
    node((2, 0), 
      class-diagram-box(
        color: green.lighten(80%),
        title: [Modelo],
        class-diagram-property([id], `int`),
        class-diagram-property([idPrograma], `int`),
        class-diagram-property([nombre], `str`),
        class-diagram-property([urlPlano], `str`),
      )
    ),
    edge((2, 0), (2, 1), "->"),
    node((2, 1), 
      class-diagram-box(
        color: green.lighten(80%),
        title: [Programa],
        class-diagram-property([id], `int`),
        class-diagram-property([nombre], `str`),
      )
    ),
    edge((0, 0), (-1, 0), "->"),
    node((-1, 0), 
      class-diagram-box(
        color: blue.lighten(80%),
        title: [Relación],
        class-diagram-property([id], `int`),
        class-diagram-property([orden], `float`),
        class-diagram-property([idUnidad], `int`),
        class-diagram-property([tipo], `str`),
      )
    ),
    edge((-1, 0), (-1, 1), "<|-"),
    node((-1, 1), 
      class-diagram-box(
        color: green.lighten(80%),
        title: [Se vende con],
        class-diagram-property([tipo], `"se vende con"`),
        class-diagram-property([idOtraUnidad], `int`),
      )
    ),
    edge((-1, 1), (0, 0), "->"),

    node(enclose: ((-1, 0), (-1, 1)), fill: yellow.lighten(80%), snap: false, inset: 0.4em),
    node(enclose: ((0, 0), (1, 0), (0, 1), (1, 1)), fill: red.lighten(80%), snap: false, inset: 0.4em),
    node(enclose: ((2, 0), (2, 1)), fill: purple.lighten(95%), snap: false, inset: 0.4em),
    node(enclose: ((2, 0), (2, 0)), fill: purple.lighten(75%), snap: false, inset: 0.4em),
    node(enclose: ((2, 1), (2, 1)), fill: purple.lighten(75%), snap: false, inset: 0.4em),
  ),
  caption: "Simplificación del esquema elaborado para la gestión de inventario",
)

Para las tablas de #text(fill: yellow.darken(20%))[relaciones] y las #text(fill: red)[unidades], se implementaron #text(fill: blue)[esquemas abstractos] que son heredados por otros o por #text(fill: green)[esquemas concretos], que poseen un nombre único dentro de su tabla, y posee atributos específicos. Los #text(fill: purple)[modelos] y #text(fill: purple)[programas] son tablas asociadas solamente a viviendas.

#figure(
  grid(
    columns: (auto, auto),
    gutter: 0.5em,
    [
      ```ts
      const _unit = v.object({
        type: v.string(),
        state: v.string(),
        price: v.number(),
      })
      const _residence = _unit.extend({
        bedrooms: v.number(),
        bathrooms: v.number(),
        modelId: v.optional(v.id("model")),
      })
      const apartment = _residence.extend({
        type: v.literal("apartment"),
        floor: v.number(),
      })
      const plot = unit.extend({
        type: v.literal("plot"),
      })
      ```
    ],
    [
      #codly(offset: 17)
      ```ts
      const model = v.object({
        programId: v.id("program"),
        name: v.string(),
        planUrl: v.string(),
      })
      const program = v.object({
        name: v.string(),
      })
      const _relation = v.object({
        order: v.number(),
        unitId: v.id("unit"),
        type: v.string(),
      })
      const soldWith = _relation.extend({
        type: v.literal("soldWith"),
        otherUnitId: v.id("unit"),
      })
      ```
    ],
    grid.cell(colspan: 2)[
      #codly(offset: 34)
      ```ts
      export default defineSchema({ 
        units: defineTable(v.union(apartment, plot)),
        relations: defineTable(v.union(soldWith)),
        models: defineTable(model), programs: defineTable(program),
      })
      ```
    ]
  ),
  caption: [Simplificación de la implementación de los esquemas en Convex],
)

#pagebreak(weak: true)
= Sistema de páginas white-label <section.white-label>

== Problema a resolver

Uno de los productos que ofrece MOME es la creación de páginas web para los proyectos inmobiliarios. Las páginas, además de proveer información de los proyectos, buscan ser un canal de venta, entregando precios actualizados y disponibilidad de las unidades, en flujos de cotización optimizados para el tipo de proyecto.


Si bien el objetivo es entregar herramientas _white-label_ que puedan ser auto-gestionadas por los mismos clientes para la creación de estas, esto no es posible dentro de un desarrollo ágil, especialmente considerando que inicialmente se contaban con 4 clientes con 1 proyecto cada uno, donde el cambio de precios y disponibilidad no muy frecuente para justificar el desarrollo.


== Diseño de la solución

Se armó un plan a largo plazo de desarrollo de estas páginas, considerando un desarrollo ágil y reutilización de los componentes. Inicialmente, cada página será desarrollada de cero, luego, se armará un kit de flujos reutilizable, y finalmente, se buscará armar un sistema autogestionable.

Para que se pueda avanzar con ese plan con la mayor reutilización de código, es esencial poseer tecnologías que permitan tanto la rápida iteración como el uso en diferentes contextos, desde páginas fijas hasta creadas dinámicamente. Se determinó 3 tipos de tecnologías claves: el sistema de componentes, el sistema de diseño, y la herramienta de revisión continua.

=== Sistema de componentes


Se decidió usar React. Esta es la librería de componentes más usada del mercado, con un gran ecosistema @state-of-js-2024. Además, sus últimos avances, React Server Components (RSC), permitirá en el futuro incluir código condicionalmente en el navegador, evitando la carga de componentes que no se usan en la página cuando este sea autogestionable @react-server-components-rfc.

Una ventaja de React es que posee múltiples librerías de UI sin estilos mantenidas por empresas establecidas, como #link("https://react-spectrum.adobe.com/react-aria/index.html")[React Aria] (Adobe) y #link("https://base-ui.com/")[Base UI] (MUI), que permiten  fácilmente crear componentes con buena accesibilidad y UX, agilizando la creación de componentes _white-label_.


RSC provee una arquitectura distinta a las páginas web tradicionales, que permite seguir el principio de composición tanto en la obtención de datos como en las vistas de las páginas.

- Las arquitecturas _client-first_ suelen ser _single-page applications_ (SPA) renderizadas y optimizadas en el servidor. Estas tienen 2 limitaciones:
  - La carga de datos es lejano a donde se usan.
    Por ejemplo, #link("https://svelte.dev/docs/kit/load#Page-data")[SvelteKit] y #link("https://nextjs.org/docs/pages/building-your-application/data-fetching/get-server-side-props#example")[NextJS (Pages)] emplean una función que carga los datos de toda la página. Cuando solo una sección requiere cierto tipo de datos, la página completa se acopla a esta. Esto pasa en la sección de cotización.
  - Todos los componentes que pueden ser usados por la página son cargados en el navegador.
    En la etapa de autogestión, una página solo ocuparía un subconjunto de las secciones disponibles, y con esta limitación, tendría que cargar todas, aumentando el tiempo de carga.
- RSC es una arquitectura _backend-first_, pero se diferencia de servidores tradicionales dado que:
  - Permite cargar componentes interactivos de forma declarativa y con composición. Otras alternativa es #link("https://astro.build/")[Astro], que también solo envía el código necesario al navegador.
  - Frameworks con RSC permiten el envío de fragmentos de forma más declarativa y con composición. Frameworks tradicionales recurren a herramientas más imperativos, como #link("https://htmx.org/")[HTMX] para enviar partes de la página, en vez de re-cargar la página completa en la navegación.

En el periodo del trabajo de título, NextJS es el único framework con soporte completo de RSC, y además, la compañía detrás de NextJS, Vercel, tiene empleados trabajando en el desarrollo de React. Por lo tanto, se decidió utilizar NextJS para el desarrollo de las páginas _white-label_.

=== Sistema de diseño

En el sistema de estilos, se buscó un sistema que permita iterar rápidamente y crear un design system fácilmente, sin sacrificar la mantención de los estilos.
Estos requisitos se cumplen en un sistema que permite la colocación, es decir, que los estilos estén junto a donde están aplicados.
Es importante notar que este sistema además debe ser compatible con el resto y fácil de migrar.

Hay 2 tipo de soluciones de colocación: estilos en linea y clases atómicas. Sobre estilos en línea, hay librerías como #link("https://stylexjs.com/")[StyleX] que han permitido empresas como Instagram escalar sus estilos, pero con el costo de una API restringida. En cambio, clases atómicas como #link("https://tailwindcss.com/")[Tailwind] permiten una mayor agilidad y flexibilidad, con el costo de tener que enforzar buenas practicas manualmente.

Dado que la prioridad es la agilidad y flexibilidad, y que se busca un equipo de desarrollo pequeño en los primeros años, se decidió utilizar Tailwind. Se estableció tokens de diseño con variables de CSS para colores primarios y base, anchos de secciones, tamaño y familia de fuente, entre otros, que pueden ser consumidos rápidamente a traves de las clases auto-generadas.

=== Revisión continua

Finalmente, para la revisión continua de los componentes, uno de los requisitos que establecí fue que el equipo de diseño pueda revisar el sistema de diseño tal como el equipo de desarrollo revisa cambios en el código. Esto es, para lograr un desarrollo ágil con la menor cantidad de errores posibles, reduciendo la brecha entre el diseño y la implementación.

La herramienta que se decidió utilizar fue #link("https://storybook.js.org")[Storybook], que permite documentar los componentes de forma atómica, y además, la revisión constante a través del servicio de #link("https://www.chromatic.com")[Chromatic]. Dado que Storybook es open source, y Chromatic ofrece un plan gratuito, nos permite experimentar con la herramienta sin costos. Además, incluye herramientas de tests visuales y de iteración.

== Desarrollo realizado

En el periodo de el trabajo de título, se realizaron completamente 2 páginas de proyectos inmobiliarios, uno de departamentos y otro de parcelas. Ambos fueron trabajados en conjunto con la encargada de UX, se ordenaron las tareas concretas en el sistema de seguimiento, y se estableció un plazo de 2 semanas para la entrega de cada una. Partieron en momentos distintos sin solaparse.

Se configuró en cada uno el hosting tanto para la página misma como para la documentación de componentes con Storybook, utilizando Cloudflare. Se configuró NextJS para que funcione en Cloudflare. Se realizó la configuración inicial de los estilos y librerías de componentes sin estilos.

Para los estilos, se utilizó específicamente Tailwind v4, que se integra directamente con variables de CSS para crear un sistema de estilos a partir de lo especificado en los tokens de diseño. 


#figure(
  grid(
    columns: (7cm, auto),
    gutter: 0.5em,
    grid.cell[
      ```css
      @theme {
        --color-base-500: #71717a;
        --breakpoint-lg: 1080px;
      }
      ```
    ],
   grid.cell[
      ```html
      <div class="text-base-500 lg:text-lg">
        Texto en color base 500 que se
        agranda en pantallas grandes.
      </div>
      ```
    ],
  ),
  caption: "Ejemplo de uso de tokens de diseño en Tailwind v4"
)

En cada página, se realizaron entregas constantes, para la revisión del resto del equipo. Una vez terminado el desarrolló de las vista, se añadió las funcionalidades para mejorar SEO e integrar con analíticas. 
En el periodo del trabajo de título, no se alcanzó a realizar estudios de usabilidad.

Para los datos de disponibilidad y precios de las unidades, se decidió empezar con datos estáticos a partir de los datos reales. En la última semana del trabajo de título, se añadió la carga de datos a partir de Google Sheets y el sistema realizado en la carga de inventario.

= Inteligencia artificial en inbox

== Problema a resolver

Un gran dolor de la industria inmobiliaria es el seguimiento de leads. El éxito de la venta de proyectos están a la merced de los vendedores, lo que lleva a problemas cuando los clientes contactan fuera del horario laboral, o los vendedores no dan correcto seguimiento.

En diferentes industrias, se han desarrollado diferentes automatizaciones que han permitido reducir la dependencia de vendedores humanos con procesos auto-gestionables, como son los sitios y aplicaciones e-commerce. Si bien estos aportan en el contexto inmobiliario, se quedan cortos dado que el proceso de compra inmobiliaria es más complejo y requiere un seguimiento más cercano.

Es por esto que se buscó desarrollar un sistema de inteligencia artificial generativa que permita reducir la dependencia de vendedores, y a la vez entregue un mayor seguimiento y reportabilidad a los gerentes de ventas.

Una característica importante de este sistema es usar medios de comunicación cercanos a los clientes. WhatsApp es el medio más usado en Latinoamérica, y en primeros análisis, fue el medio más preferible por los clientes. Por lo tanto, se buscó una integración a WhatsApp, que permita potenciar el canal existente de WhatsApp, en el mismo número que utilizan los vendedores.

Para la respuestas automáticas con inteligencia artificial, hay 2 requisitos: primero, debe responder naturalmente, por lo que la IA, además de responder con un lenguaje natural adecuado, debe esperar un pequeño tiempo antes de responder, poseer el contexto de los mensajes anteriores. Segundo, deberá poder ser interrumpido por un vendedor, que tome el control de la conversación.

#pagebreak(weak: true)
== Diseño de la solución

WhatsApp se separa en 2, las aplicaciones y API. Conectarse via API requiere un proceso de aprobación opaco, y se pierde el acceso a la aplicación. Por lo tanto, se decidió utilizar un proveedor que pueda enviar mensajes a través de la aplicación, y que permita la integración con la API.

Considerando que el sistema deberá permitir la integración con la API a futuro, se utilizó el patrón plantilla, donde se creó una interfaz que permite la integración via proveedores externos o por API, permitiendo el intercambio a la API en el futuro sin cambiar el sistema.

Los requisitos del sistema de IA hacen este deba estar integrado a una cola de tareas, que permita esperar un _delay_, y cancelar la ejecución si es que el cliente manda algo antes de que la IA responda, o si es que el ejecutivo de ventas toma el control de la conversación.

A esto se le suma la futura inclusión de conexión a sistemas, como por ejemplo, el estado y precios del inventario, y la actualización de información en el CRM, que se obtienen a través de _function calling_ a los servicios correspondientes. Esto hace que la tarea de ejecución sea con múltiples pasos y llamadas externas encadenadas.


#figure(
  diagram(
    node-stroke: black,
    node-inset: 4pt,
    node-corner-radius: 2pt,
    spacing: 4em,
    edge((0,-0.5), (0, 0), "-|>", ),
    node((0, 0))[Esperando mensajes],
    edge("-|>", label-sep: 0.7em)[Mensaje],
    node((1, 0))[Esperando delay],
    edge("-|>", label-sep: 0.7em)[Terminó delay],
    node((2, 0))[Modelo en ejecución],
    edge("-|>", label-sep: 0.7em)[Obtiene respuesta],
    edge((2, 0), (2, 0), "-|>", bend: 130deg, label-sep: 0.1em)[Llamada externa],
    node((3, 0), extrude: (1, -1))[Enviando mensajes],
    edge((1, 0), (1, 0), "-|>", bend: 130deg, stroke: red, label-sep: 0.1em)[#text(fill: red)[Nuevo mensaje]],
    edge((2, 0), (1, 0), "-|>", bend: 10deg, stroke: red),
  ),
  caption: "Procesamiento de mensajes en el sistema de IA",
)

Cuando llega un mensaje, se espera un tiempo definido antes de procesar. Si llega un nuevo mensaje, se cancela el procesamiento y se espera el nuevo mensaje, marcado en #text(fill: red)[rojo]. Además, si el ejecutivo de ventas toma el control de la conversación, se cancela el procesamiento.

Dado la complejidad del sistema, se buscó realizar un suite de tests, donde se establecieron casos de prueba que establecen el funcionamiento esperado del sistema previo a su implementación completa. 

Realizar tests de este tipo involucra simular el avance en el tiempo en la cola de tareas usadas en el entorno de pruebas, que es poblado por rutinas internas.
Convex posee una libraría para testear con #link("https://vitest.dev/")[Vitest], permitiendo simular el avance en el tiempo. Esta característica fue parte de lo que se revisó al elegir la arquitectura.


== Desarrollo realizado


Para la generación de texto en lenguaje natural, se utilizó OpenAI. Esto es dado que provee una API para la creación de conversaciones sin preocuparse del guardado del estado, es muy rápido de configurar en comparación a otras soluciones, y provee _structured-output_, sistema que permite garantizar el formato estructurado deseado en modelos generativos @we-need-structured-output.

Inicialmente, y previo al estudio de la arquitectura, se desarrolló una versión inicial en Firebase, que fue usada para el primer cliente. Cada mensajes iniciaba el procesamiento en una rutina, y se usaba la base de datos Cloud Firestore, para coordinar la ejecución. Si bien, funciono en gran parte para el primer cliente, el flujo requería código complejo.

Esto es dado al requerimiento permitir la cancelación de la rutina en cualquier momento. Sistemas de tareas, como #link("https://firebase.google.com/docs/functions/task-functions?gen=2nd")[Cloud Tasks], no proveen los mecanismos requeridos para la cancelación de tareas, se debe implementar manualmente. Como se mencionó anteriormente, Convex se eligió por tener un primitivo de tareas fácil de usar, que a futuro podría ser empleado con #link("https://www.convex.dev/components/workflow")[Workflows].

Se configuró los tests, añadiendo los mocks para las llamadas externas a OpenAI, WhatsApp, y a las notificaciones, y la simulación del tiempo. Se crearon tests para revisar que:
- Mandar varios mensajes en un corto periodo de tiempo solo hace una ejecución de la IA.
- Cuando llegan mensajes, y la IA responde con una alerta, se notifica al ejecutivo de ventas.
- No se llama la IA cuando llegan mensajes cuando el chat tiene la IA desactivada.
- La IA indica que debe parar y se refleja el cambio en la base de datos.
- El sistema no manda mensajes si el modelo partió la ejecución y se apaga la IA.

Esto en el código, fue implementado en la siguiente forma:


#figure(
  ```ts
  test("Multiple messages only triggers one AI execution", async () => {
    const t = createConvextTestClient();
    await t.mutation(internal.whatsapp.saveMessage, createSampleMessage());
    await t.mutation(internal.whatsapp.saveMessage, createSampleMessage());
    await t.finishAllScheduledFunctions(vi.runAllTimers);  // Se espera que terminen las tareas
    expect(runAI).toHaveBeenCalledTimes(1);  // Función externa con mock
  });
  ```,
  caption: "Ejemplo de test de Convex con Vitest para el sistema de IA",
)


#pagebreak(weak: true)
= Otros desarrollos realizados

Otro desarrollo destacable en el periodo del trabajo de título fue el refractor parcial del el dashboard donde se realizaron las pruebas para la gestión de inventario, por 2 problemas. Primero, una abstracción creada para evitar código, resultó en código más complejo. Segundo, la manera que se definía las rutas, causaba que no se reflejaran cambios en el modo de desarrollo (_hot-reloading_).

Cambiar esto de forma manual tomaría múltiples horas, usar métodos como expresiones regulares no es suficiente, y usar modelos de IA generativa corre el riesgo de cambiar código que no debería ser cambiado. Yo no conocía en ese momento herramientas que pudieran realizar este trabajo, pero si sabia que existían y como se debería transformar el código.

Es por esto que se usó modelos generativos para ayudar a generar código complejo para la refactorización. Se fue iterando con un modelo generativo, iterando el código complejo de 
transformaciones de _abstract syntax trees_ con #link("https://github.com/facebook/jscodeshift")[`jscodeshift`], hasta lograr lo deseado, en un menos de 1 hora, cambiando sobre de 200 lineas de código. Se puede ver el código final en el @appendix.jscodeshift.


= Conclusiones

Si bien no se realizó una gran cantidad de desarrollo, en este trabajo de título se logró explorar, validar y diseñar diversas soluciones para dolores de la industria inmobiliaria. Se exploró problemas de arquitectura, modelo de datos, diseño de sistemas web y de inteligencia artificial.

En las secciones de cada problema, se demostró como se entendieron, empleando conocimientos de computación y del contexto inmobiliario, para identificar sus requerimientos claves.
Siguiendo diferentes estándares de la ingeniería de software, como SOLID y Agile, se diseñó sistemas complejos que abordaban los requerimientos identificados.
Y finalmente, se realizó una planificación del desarrollo e iteración inicial de estos sistemas, validando soluciones y tecnologías.

No se pudo observar resultados concretos de todas las soluciones llevadas a cabo, dado la temprana etapa de la empresa y que se no se inició el trabajo de ventas de la mayoría de los clientes en el periodo del trabajo de título. Sin embargo, este trabajo realizado establece una base sólida para el desarrollo futuro de la empresa, dado las estrategias y tecnologías establecidas.

#TT.bibliography("/thesis/bibliography.yml")
#TT.appendix("/thesis/appendix.typ")
