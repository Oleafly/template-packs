
#import "lib.typ": *

#show: resume.with(
  author: (
    firstname: "Max",
    lastname: "Mustermann",
    address: "Musterstraße 10, 22374 Musterstadt",
    phone: "+49 1923655",
    email: "max.mustermann@gmail.de",
    github: "mustermann",
    linkedin: "mustermann",
  )
)

= Experience

#resume-entry(
  title: link("https://www.duckduckgo.com/", "Tech Solutions GmbH"),
  date: "2024 - Present",
  description: "Software Engineer",
  location: "Berlin"
)

#resume-item[
  - Leading a team of 5 developers to create and maintain web applications, improving user experience and performance
  - Designing and implementing REStful APIs using Nojde.js and Express.js
]

#resume-entry(
  title: link("https://www.google.com/", "Innovatech AG"),
  date: "2020 - 2023",
  description: "Junior Software Engineer",
  location: "Munich"
)

#resume-item[
  - Assisted in developing and deploying full-stack web applications using JavaScript, HTML, CSS, and Python
  - Participated in the design and architecture of new software projects, focusing on scalability and performance
]

= Education

#resume-entry(
  title: "Karlsruhe Institute of Technology",
  date: "2023 - Present",
  description: "M. Sc. Computer Science"
)
#resume-item[
  - Focusing on data structures and algorithms
]


#resume-entry(
  title: "Technical University of Munich",
  date: "2019 - 2023",
  description: "B. Sc. Computer Science"
)

#resume-item[
  - Final GPA: 1.0 (German scale, best 1.0)
  - Relevant Coursework: Database Systems, Web Development, Machine Learning
]

#resume-entry(
  title: "Albert-Einstein-Gymnasium",
  date: "2011 - 2019",
  description: "Abitur (High school diploma)",
  location: "Dresden"
)

#resume-item[
  - Final GPA: 1.2 (German scale, best 1.0)
]


= Projects

#resume-entry(
  title: "E-commerce Web Application",
  date: "2024",
  description: github-link("typst/typst")
)

#resume-item[
  - Developed a full-featured e-commerce platform using React.js for the frontend and Node.js for the backend
]


#resume-entry(
  title: "Internal Tool for Project Management",
  date: "2023",
  description: github-link("typst/typst"),
  location: "Musterverein"
)
#resume-item[
  - Created an internal project management tool to track project progress, manage tasks, and allocate resources.
]

#resume-entry(
  title: "Real-Time Chat Application",
  date: "2023",
  description: github-link("typst/typst")
)

#resume-item[
  - Designed and developed a real-time chat application using Socket.io for real-time communication and Node.js for the server-side
]
