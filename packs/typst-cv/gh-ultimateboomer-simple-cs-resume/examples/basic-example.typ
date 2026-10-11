#import "../template.typ": *

#show: resume.with(
  firstname: "First",
  lastname: "Last",
  email: "example@uwaterloo.ca",
  website: "example.com",
  github: "example",
  linkedin: "johnsmith",
  location: "Waterloo, ON",
)

= Skills
#resume-skill-items(
  (
    "Languages",
    ("Python", "JavaScript", "TypeScript", "Java", "C++", "Go", "SQL", "HTML", "CSS"),
  ),
  (
    "Tools",
    ("Git", "Docker", "VSCode", "IntelliJ", "Figma", "Postman"),
  ),
  (
    "Frameworks",
    ("React", "Node.js", "Express", "Django", "Spring Boot", "PostgreSQL", "MongoDB"),
  ),
)

= Experience
#resume-entry(
  title: "Software Engineer Intern",
  description: "Tech Solutions Inc.",
  start-date: "May 2024",
  end-date: "Aug 2024",
)
#resume-item[
  - Developed full-stack web applications using *React* and *Node.js*, serving over *10,000* daily active users.
  - Implemented RESTful APIs with *Express.js* and *PostgreSQL*, improving data retrieval performance by *30%*.
  - Collaborated with cross-functional teams to design and implement new features using Agile methodologies.
  - Wrote comprehensive unit tests achieving *85%* code coverage using Jest and React Testing Library.
]

#resume-entry(
  title: "Frontend Developer",
  description: "Digital Agency Co.",
  start-date: "Jan 2024",
  end-date: "Apr 2024",
)
#resume-item[
  - Built responsive web interfaces using *React* and *TypeScript* for e-commerce clients, increasing conversion rates by *15%*.
  - Optimized application performance through code splitting and lazy loading, reducing initial load time by *40%*.
  - Integrated third-party payment systems including Stripe and PayPal for seamless checkout experiences.
  - Collaborated with UX/UI designers to implement pixel-perfect designs using modern CSS techniques.
]

#resume-entry(
  title: "Teaching Assistant",
  description: "University Computer Science Department",
  start-date: "Sep 2023",
  end-date: "Dec 2023",
)
#resume-item[
  - Assisted in teaching introductory programming courses to *150+* students, focusing on *Python* and data structures.
  - Conducted weekly tutorial sessions and office hours, helping students debug code and understand core concepts.
  - Graded assignments and provided detailed feedback to support student learning and improvement.
]

= Projects

#resume-entry(
  title: "Task Management Web App",
  title-link: "https://github.com/johnsmith/task-manager"
)
#resume-item[
  - Built a full-stack task management application using *React*, *Node.js*, and *MongoDB* with user authentication.
  - Implemented real-time collaboration features using Socket.io, allowing multiple users to work on shared projects.
  - Deployed application using *Docker* containers on AWS EC2 with automated CI/CD pipeline.
]

#resume-entry(
  title: "Weather Dashboard",
  title-link: "https://github.com/johnsmith/weather-dashboard"
)
#resume-item[
  - Created a responsive weather dashboard using *JavaScript* and external weather APIs with location-based forecasts.
  - Implemented data visualization using Chart.js to display weather trends and historical data.
  - Added offline functionality using service workers and local storage for improved user experience.
]

#resume-entry(
  title: "E-commerce Mobile App",
)
#resume-item[
  - Developed a mobile shopping app using *React Native* with payment integration and product catalog.
  - Implemented user authentication, shopping cart functionality, and order tracking features.
  - Integrated push notifications for order updates and promotional offers using Firebase Cloud Messaging.
]

#resume-entry(
  title: "Machine Learning Projects",
  title-link: "https://github.com/johnsmith/ml-projects"
)
#resume-item[
  - Built various ML models using *Python*, scikit-learn, and TensorFlow for classification and regression tasks.
  - Developed a recommendation system for movie ratings using collaborative filtering algorithms.
  - Created data visualization dashboards using matplotlib and seaborn for exploratory data analysis.
]

= Education

#resume-entry(
  title: "University of Waterloo",
  description: "Bachelor of Computer Science",
  start-date: "Sep 2021",
  end-date: "Apr 2025",
)
#resume-item[
  - Relevant coursework: Data Structures & Algorithms, Software Engineering, Database Systems, Machine Learning, Web Development, Operating Systems, Computer Networks
  - Cumulative GPA: *3.8/4.0*
]
