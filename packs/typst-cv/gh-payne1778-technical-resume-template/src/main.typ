#import "./resume.typ": *

// Personal Information
#let name = "Jon Doe"
#let phone = "123-456-7890"
#let location = "Pittsburgh, PA"
#let email = "jondoe@example.com"
#let github = "jondoe123"
#let linkedin = "jon-doe"

#show: resume.with(
  author-name: name,
  phone: phone,
  location: location,
  email: email,
  linkedin-user-id: linkedin,
  github-username: github
)

#custom-title("Education")[
  #education-heading(
    major: "Bachelor of Science in Computer Engineering",
    grad-date: "December 2026",
    uni: "Penn State University",
    location: "Pittsburgh, PA",
    gpa: "3.78"
  )[
    Minor in Mathematics
  ]
  #education-heading(
    major: "Master of Science in Computer Engineering",
    grad-date: "December 2027",
    uni: "Penn State University",
    location: "Pittsburgh, PA"
  )[]
]

#custom-title("Skills")[
  #skills()[
    - *Programming Languages:* Java, Python, C/C++, Go, JavaScript/TypeScript, MATLAB
    - *Technologies:* RESTful APIs, Embedded Systems, Linux, SQL, MariaDB, Docker, Typst
    - *Tools:* Git, VS Code, JetBrains IDEs, Make, Arduino IDE, Postman, VirtualBox
  ]
]

#custom-title("Projects")[
  #project-heading(
    name: "Smart Campus Navigation App",
    technologies: "React Native, Node.js, PostgreSQL, REST APIs",
    repo-name: "campus-nav",
    github-username: github,
    start-date: "January 2025",
    end-date: "April 2025"
  )[
    - Developed a mobile application to help students navigate campus buildings using real-time location data
    - Designed RESTful backend services and optimized database queries to support hundreds of concurrent users
  ]

  #project-heading(
    name: "Embedded Weather Station",
    technologies: "C, Arduino, Sensors, UART/I2C",
    repo-name: "weather-station",
    github-username: github,
    start-date: "September 2024",
    end-date: "December 2024"
  )[
    - Built an embedded weather monitoring system collecting temperature, humidity, and pressure data
    - Implemented low-power firmware and serial communication for reliable data logging
  ]

  #project-heading(
    name: "Distributed Chat Application",
    technologies: "Go, TCP/IP, Concurrency",
    repo-name: "go-chat",
    github-username: github,
    start-date: "June 2024"
  )[
    - Implemented a concurrent client-server chat system using Go routines and TCP sockets
    - Focused on fault tolerance, message ordering, and clean protocol design
  ]
]

#custom-title("Experience")[
  #work-heading(
    title: "Computer Engineering Teaching Assistant",
    company: "Penn State University",
    location: "Pittsburgh, PA",
    start-date: "August 2024"
  )[
    - Assisted with instruction for core computer engineering courses covering data structures and digital logic
    - Held weekly office hours, providing one-on-one academic support to over 40 students per semester
    - Supported grading, exam preparation, and lab troubleshooting in collaboration with faculty
  ]

  #work-heading(
    title: "Software Engineering Intern",
    company: "Local Tech Startup",
    location: "Pittsburgh, PA",
    start-date: "May 2025",
    end-date: "August 2025"
  )[
    - Developed backend features for a web-based analytics platform using Python and SQL
    - Improved system performance by profiling and optimizing database queries
    - Collaborated in an agile team environment using Git and issue tracking tools
  ]
]

#custom-title("Extracurricular Activities")[
  #activity-heading(
    position: "Vice President",
    activity: "Tau Beta Pi Engineering Honor Society",
    start-date: "October 2024",
    end-date: "Present"
  )
  #activity-heading(
    position: "Treasurer",
    activity: "IEEE Penn State Student Chapter",
    start-date: "August 2023",
    end-date: "Present"
  )
  #activity-heading(
    position: "Member",
    activity: "Penn State Programming Club",
    start-date: "September 2023",
    end-date: "Present"
  )
  #activity-heading(
    position: "Participant",
    activity: "ACM Programming Contest",
    start-date: "October 2023, October 2024"
  )
]

#spacer()

#custom-title("Achievements")[
  #activity-heading(
    activity: "Dean’s List, College of Engineering",
    start-date: "August 2023",
    end-date: "Present"
  )
  #activity-heading(
    activity: "Undergraduate Research Grant Recipient",
    start-date: "May 2024"
  )
  #activity-heading(
    activity: "Penn State Honors Program Scholarship",
    start-date: "June 2023"
  )
]
