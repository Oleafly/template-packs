#import "templates/iitk.typ": resume, section, project

#show: resume.with(
  name: "Someone",
  tagline: [Third Year Undergraduate, IIT Kanpur],
  dept: [Department of Computer Science and Engineering],
  email: "hello@gmail.com",
  phone: "+91 39284 10829",
  github: (
    username: "someone",
    url: "https://github.com"
  ),
  linkedin: (
    username: "someone",
    url: "https://linkedin.com"
  )
)

#section(title: "Academic Qualifications")[
  #show table.cell.where(y: 0): strong
  #table(
    columns: (3.5fr, 7fr, 10fr, 2.5fr),
    align: (center, center, center, left),
    table.header(
      [Year], [Degree/Certificate], [Institute/School], [CPI/\%]
    ),
    [2023 #sym.dash Present], [B.Tech], [Indian Institute of Technology, Kanpur], [9.8/10],
    [2022], [CBSE (XII)], [Khalsa College Public School, Amritsar], [92.8\%],
    [2020], [ICSE (X)], [Sacred Heart Public School, Punga], [94%]
  )
]

#section(title: "Scholastic Achievements")[
  - Received the *Academic Excellence Award* for exceptional academic performance in 2022-23 session.
  - Secured *All India Rank XXX* in *Joint Entrance Exam (Advanced) 2023* among the 250,000 candidates.
  - Secured *All India Rank XXX* in *Joint Entrance Exam (Mains) 2023* among the 1,200,00 candidates.
  - Qualified for *National Talent Search Exam* among XXXXXX candidates conducted by CBSE in 2020.
]

#section(title: "Key Projects")[
  - #project(
      title: "Very Cool Todo App", 
      url: "https://github.com",
      attr: [Coding Club, IIT Kanpur],
      from: "Jan'23", to: "Mar'23"
    )[
    - Designed and developed a *modern, responsive task management web app* with a focus on *performance* and *user experience*.
    - Implemented a *dynamic state management system* enabling real-time task updates without *page reloads*.
    - Integrated *persistent storage* using *browser APIs* to ensure data durability without a backend.
  ]
  
  - #project(
      title: "MyCompiler", 
      attr: [Course Project | Prof. Arghya Das],
      from: "Jan'24", to: "Mar'24"
    )[
    - Built a *compiler from scratch* for a custom programming language, including *lexer,* *parser* and *type checker*
    - Implemented *recursive descent parsing* and *AST generation* for full *language grammar support*, including *control flow, expressions, and user-defined functions*.
    - Designed and enforced a *static type system* with support for *type inference*, *scoping,* and *error reporting*.
  ]

]


#section(title: "Technical Skills")[
  - *Programming Languages:* C, C++, Java, Python, JavaScript, Ruby, Rust, Go, Haskell, OCaml, LaTeX
  - *Software and Libraries:* Git, GitHub, Docker, React, Express, Node.js, MongoDB
]


#section(title: "Relevant Coursework")[
  #table(columns: (1fr, 1fr, auto))[
    Data Structure and Algorithms\ 
    Fundamentals of Computing \
    Computer Organisation
  ][
    Discrete Mathematics \
    Logic for Computer Science\ 
    Probability for Computer Science
  ][
    Linear Algebra and ODE \
    Real Analysis and Multivariate Calculus \
    Software Development 
  ]
]


#section(title: "Positions of Responsibility")[
  - *Member, Coding Club, IIT Kanpur* #h(1fr) #emph[Jul'23 #sym.dash Present]
    - Hosted and managed events organised by the Coding Club
]

#section(title: "Extra Curriculars")[
  - Participated in Inter-IIT Tech Meet 11 (Feb 2024)
]

