#import "template.typ": resume, header, resume_heading, edu_item, exp_item, activity_item, skill_item, set_variables

#set page(
    paper: "us-letter",
    margin: (x: 0.25in, 
              y: 0.25in)
  )

#set_variables(rgb("#ba0404"), "Source Sans 3", 11pt, rgb("#050505"))

#show: resume

#header(
  name: "Brayden Jonsson",
  title: "Honors Computer Science and Physics Student",
  phoneNumber: "123-456-7890",
  email: "example@gmail.com",
  linkedinLink: "linkedin.com/in/brayden-jonsson/",
  linkedinUsername: "Brayden Jonsson",
  githubLink: "github.com/F1scherman",
  githubUsername: "F1scherman",
  site: "braydenjonsson.dev",
)

#resume_heading[Education]
#edu_item(
  name: "University of Utah",
  degree: "Honors Bachelor of Science in Computer Science, Bachelor of Science in Physics",
  location: "Salt Lake City, UT",
  date: "Aug 2022 - May 2026",
  [#text(weight:600, "GPA: 3.990"), Dean's List, Presidential Scholar, Engineering Scholar, CompU Leaders Scholar, \ Alpha Alpha Alpha First-Generation Honors Society, Sigma Pi Sigma Physics Honors Society],
  [#text(weight:600, "Courses:") Software Practice I & II, Computer Systems, Security, Graphics, Algorithms, Databases, \ 
  Compilers, Raytracing, Computational Physics I, Physics I-V, Discrete Mathematics, Linear Algebra, ODEs]
)
#edu_item(
  name: "Somewhere High School",
  degree: "High School Diploma",
  location: "Somewhere, UT",
  date: "Aug 2019 - May 2022"
)

#resume_heading[Experience]
#exp_item(
  role: "Software Engineering Intern",
  name: "Lucid Software",
  location: "South Jordan, Utah",
  date: "May 2025 - Aug 2025",
  [Learned the Lucid Tech Stack (Typescript, Angular, Scala)],
  [Onboarded as a regular Engineering New Hire to act as a contributor to team projects],
  [Worked on integrations with airfocus and accompanying frontend developments],
)
#exp_item(
  role: "Information Technology Intern",
  name: "Department of Defense",
  location: "Washington, DC",
  date: "May 2024 - Aug 2024",
  [Current US Top Secret/Sensitive Compartmented Information Security Clearance (Investigated in Nov 2023)],
)
#exp_item(
  role: "Undergraduate Teaching Assistant",
  name: "Kahlert School of Computing",
  location: "Salt Lake City, UT",
  date: "Aug 2023 - Present",
  [Works as part of the CS2420: Data Structures and Algorithms Teaching Team],
  [Leads practical labs, hosts office hours, and answers online questions],
  [Grades submitted coding projects, written assignments, and exams for correctness and coding style],
  [Built an application to partially automate grading for bug report assignments],
)

#resume_heading("Activities")
#activity_item(
  name: "Kahlert School of Computing",
  role: "CompU Leaders Scholar",
  date: "Aug 2022 - Present",
  location: "Salt Lake City, UT",
  [Took a specific seminar course to boost soft skills.],
  [Participated in a summer bridge program prior to the start of the 2022 Fall Semester.],
)
#activity_item(
  name: "Software Development Club",
  role: "Treasurer",
  date: "Apr 2024 - Present",
  location: "Salt Lake City, UT",
  [The goal of the SDC is to act as a professional development organization for students.],
  [Planned an "Internship Post-Mortem" panel for the Fall 2024 semester, to allow interning students to provide \ guidance and support for other students looking to intern.],
)
#activity_item(
  name: "Society of Physics Students",
  role: "Officer",
  date: "Apr 2024 - Present",
  location: "Salt Lake City, UT",
  [The goal of the SPS is to connect physics students and provide resources and support.],
  [Plans meetings, advertisements, and activities for the club along with other officers and the presidency.],
)
#activity_item(
  name: "John and Marcia Price College of Engineering",
  role: "Engineering Scholar",
  date: "Aug 2022 - May 2023",
  location: "Salt Lake City, UT",
  [Completed a research project during the Spring semester about the history of the School of Computing.]
)

#resume_heading("Skills")
#skill_item(
  category: "Programming",
  skills: "Angular, C/C++, C#, HTML/CSS, Java, Javascript/Typescript, Matlab, Maple, Python, R, Rust, Scala, SQL, Vue.js, x86"
)
#skill_item(
  category: "Software",
  skills: "Adobe Photoshop/Illustrator, Bitbucket, Blender, DaVinci Resolve, Docker, Eclipse, Elasticsearch, Fusion360, GIMP, Git/Github, Godot, Google Suite, Graphite, JetBrains IDEs, Krita, LaTeX, Linux, Paint.net, Typst, Unity, Visual Studio, VSCode, WebGL, Windows"
)
#skill_item(
  category: "Soft Skills",
  skills: "Communication, Confidential Information Security, Customer Service, Documentation, Inventory, Money Management/Handling, Presentation, Teaching, Teamwork, Time Management"
)

#text(datetime.today().display("[month repr:long] [day] [year]"), size: 0.8em)