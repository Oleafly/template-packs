#import "../utils.typ": translate

#let title = (
  es: [Experiencia profesional],
  en: [Professional experience],
)

#let presentLabel = translate((
  es: [Presente],
  en: [Present],
))

#let company1 = (
  company: [Company 01],
  location: [City, Country],
  role: translate((
    es: [Rol],
    en: [Role],
  )),
  period: [01/2025 - #presentLabel],
  description: translate((
    es: [
      - Desarrollé multiples sistemas *web* y *mobiles* en *simultaneo* aplicando principios de diseño *responsive* y *mobile-first*, utilizando tecnologías como *JavaScript, TypeScript, React, React-Native, RESTful, Python* y *Django*, bajo la metodología ágil *Scrum* con herramientas como Jira y Bitbucket.
      - Implementé soluciones de mensajería y comunicación en tiempo real con *WebRTC* y *WebSockets*, mejorando la interacción entre usuarios y la eficiencia en la transmisión de datos audiovisuales.
      - Implementé formularios y esquemas dinámicos con *React Hook Form* y *React JSON Schema Form*, mejorando la experiencia de usuario y acelerando los tiempos de desarrollo de interfaces.
      - Desarrollé una librería de componentes reutilizables y accesibles utilizando *React Aria*, incluyendo soporte para interacción mediante teclado y funciones de drag and drop, enfocada en la compatibilidad con usuarios que navegan mediante teclado o *tecnologías de asistencia*.
      - Refactoricé módulos críticos para mejorar la mantenibilidad del código y realicé la migración del sistema de componentes para las aplicaciones móviles, lo cual incrementó en *60%* su rendimiento.
      - Contribuí en el desarrollo y mantención del lado del servidor levantando vistas, modificando formularios, ajustando viewsets y creando o actualizando endpoints en *Django REST Framework*.
    ],
    en: [
      - Developed multiple *web* and *mobile* systems *simultaneously*, applying *responsive* and *mobile-first* design principles, using technologies such as *JavaScript, TypeScript, React, React Native, RESTful, Python*, and *Django*, following the agile *Scrum* methodology with tools like Jira and Bitbucket.
      - Implemented real-time messaging and communication solutions using *WebRTC* and *WebSockets*, enhancing user interaction and improving the efficiency of audiovisual data transmission.
      - Built dynamic forms and schemas with *React Hook Form* and *React JSON Schema Form*, improving user experience and accelerating interface development time.
      - Developed a library of reusable and accessible components using *React Aria*, including keyboard interaction support and drag-and-drop functionality, focused on compatibility with users navigating via keyboard or *assistive technologies*.
      - Refactored critical modules to improve code maintainability and migrated the component system for mobile applications, resulting in a *60%* performance improvement.
      - Contributed to server-side development and maintenance by creating views, modifying forms, adjusting viewsets, and creating or updating endpoints in *Django REST Framework*.
    ],
  )),
)

#let company2 = (
  company: [Company 02],
  location: [City, Country],
  role: translate((
    es: [Rol],
    en: [Role],
  )),
  period: [01/2025 - 01/2025],
  description: translate((
    es: [
      - Desarrollé *aplicaciones web* responsivas con *JavaScript, TypeScript, React, Angular, Next.js y RESTful APIs* bajo metodologías ágil *Scrum*, implementando *GitFlow* para garantizar entregas eficientes y código mantenible.
      - Diseñé y optimicé sistemas de componentes reutilizables y formularios avanzados utilizando *Formik* y *Reack Hook Form*, mejorando la consistencia y reduciendo el tiempo de desarrollo en futuras implementaciones.
      - Realicé *revisiones de código* y coordinaciones técnicas con clientes, asegurando estándares de calidad y facilitando la escalabilidad de los proyectos.
      - Contribuí en el desarrollo del servidor levantando vistas, y ajustando viewsets con *Django REST Framework*.
    ],
    en: [
      - Developed *responsive web applications* using *JavaScript, TypeScript, React, Angular, Next.js*, and *RESTful APIs* under agile *Scrum* methodologies, implementing *GitFlow* to ensure efficient delivery and maintainable code.
      - Designed and optimized reusable component systems and advanced forms using *Formik* and *React Hook Form*, improving consistency and reducing development time in future implementations.
      - Conducted *code reviews* and held technical discussions with clients, ensuring quality standards and facilitating project scalability.
      - Implemented interactive dashboards with *Tailwind CSS* and *SASS*, optimizing data presentation to support client decision-making and streamline internal processes.
      - Contributed to backend development by creating views and adjusting viewsets using *Django REST Framework*.
    ],
  )),
)

#let company3 = (
  company: [Company 03],
  location: [City, Country],
  role: translate((
    es: [Rol],
    en: [Role],
  )),
  period: [01/2025 - 01/2025],
  description: translate((
    es: [
      - Diseñé y desarrollé aplicaciones web y de escritorio para el control de asistencia y gestión de planillas utilizando *JavaScript, React y Node.js*, participando en el análisis de requerimientos con stakeholders y aplicando la metodología ágil SCRUM
    ],
    en: [
      - Designed and developed web and desktop applications for attendance control and payroll management using *JavaScript, React,* and *Node.js*, participating in requirements analysis with stakeholders and applying the agile *SCRUM* methodology.
    ],
  )),
)

#let experienceList = (company1, company2, company3)

#let experienceDict = (
  title: translate(title),
  content: experienceList,
)

// #let template = (
//   company: [your company],
//   location: [location, country],
//   role: translate((
//     es: [role in spanish],
//     en: [role in english],
//   )),
//   period: [year-month – year-month],
//   description: translate((
//     es: [- description in *spanish*],
//     en: [- description in *english*],
//   )),
// )
