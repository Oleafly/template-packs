#import "lib/template.typ"

#let lang = "en"
#if "lang" in sys.inputs.keys() {
  lang = sys.inputs.lang
}

#import "./data_" + lang + ".typ": data as d

/*
  replacing each key from `d` which has an equivalent key in
  in the file at sys.inputs.secrets_file

  basicly a line `bg_name=IMEBRAT` overwrites d.name when lang is bg.
  using this as a way to get secrets into the pdf
*/
#{
  for _ in range(1) {
    if "secret_file" not in sys.inputs {
      break
    }

    let c = read(sys.inputs.secret_file)
    let lines = str.split(str.trim(c), "\n")

    for line in lines {
      if not line.starts-with(lang) {
        continue
      }

      let s = line.slice(3).split("=")
      d.at(s.at(0)) = s.at(1)
    }
  }
}

#template.full(
  head: template.header(
    name: d.name,
    address: "X1Y 2Z3, Toronto, ON, Canada",
    links: (
      link("tel:+1 (647) 555-0199"),
      link("mailto:jane.doe@example.com"),
      link("https://example.dev", "example.dev"),
      link("https://www.linkedin.com/in/janedoe/", "linkedin.com/in/janedoe"),
      link("https://github.com/janedoe", "github.com/janedoe"),
    ),
  ),
  profile: "Enthusiastic professional with expertise in Python, JavaScript, HTML/CSS, Git, Linux, and various standard tools and technologies. Completed internships in the software development industry and actively engages in creating open-source projects, demonstrating a commitment to continuous learning and creative problem-solving. Interested in DevOps and Cloud roles, seeking new opportunities.",
  education: (
    template.education(
      institution: "University of Toronto",
      location: "Toronto, ON",
      program: "Bachelor of Science",
      major: "Computer Science",
      start: "Sep 2021",
      end: "Jan 2025",
      courses: (
        "Artificial Intelligence",
        "Data Structures and Algorithms",
        "Software Engineering",
        "Systems Security",
      ),
    ),
  ),
  experience: (
    template.experience(
      company: "XYZ Tech Inc.",
      location: "Toronto, ON",
      role: "Software Developer Intern (co-op)",
      start: "Sep 2023",
      end: "Dec 2023",
      points: (
        "Developed Javascript module to process user data for web applications using React and Node.js, ensuring efficient handling of concurrent requests",
        "Collaborated in a dynamic team to implement key features for Client App 2, following agile development methodologies",
        "Implemented test-driven development by creating unit and integration tests to ensure code reliability, running them in the CI/CD pipeline",
        "Assisted in optimizing stream processor configuration to standardize variable names across the platform, avoiding conflicts",
        "Conducted research on porting Docker container from x86 to ARM (Nvidia Jetson) for local deployment as an edge application",
      ),
    ),
    template.experience(
      company: "ABC Solutions Ltd.",
      location: "Hamilton, ON",
      role: "Research Intern (co-op)",
      start: "May 2023",
      end: "Aug 2023",
      points: (
        "Developed a Python script for audio generation, playback, and logging to test underwater acoustic projectors in-house",
        "Configured Raspberry Pi systems with Linux to develop and test the Acoustic Projector Control System",
        "Implemented module to connect to private Signal K server and utilize its API to retrieve sensor data effectively",
        "Created a framework for logging data from sensors, consuming it via API calls and storing it in an SQLite database",
      ),
    ),
  ),
  projects: (
    template.project(
      name: "Nix Build System Enhancements",
      lnk: "example.com/project1",
      desc: "Enhanced the Nix package manager's build system by contributing to its documentation and creating scripts for automating common tasks, making the process more efficient for developers.",
      skills: ("Nix", "Shell Scripting", "Documentation Tools"),
    ),
    template.project(
      name: "Programmatic template Generator",
      lnk: "example.com/project2",
      desc: "Created a web application that generates personalized templates from user-provided data using Python and web development frameworks. The tool is built using Docker for deployment, allowing easy access through a public container app.",
      skills: ("Python", "Docker", "Web Development", "CI/CD"),
    ),
    template.project(
      name: "Endless Runner Game",
      lnk: "example.com/project3",
      desc: "Developed a 2D side-scrolling endless runner game featuring unique characters and engaging gameplay. Built for Windows, Mac, Linux, and Desktop Web browsers using Unity and C#. The game showcases creative problem-solving skills in game development.",
      skills: ("C#", "Unity", "Game Development"),
    ),
  ),
  skills-dict: (
    "Technologies": (
      "Python",
      "Go",
      "Nix",
      "Docker",
      "Git",
      "Terraform",
      "Azure",
      "Kafka",
      "MongoDB",
      "MySQL",
      "JavaScript",
      "Java",
      "C#",
      "C/C++",
    ),
    "Interests": (
      "Linux",
      "Shell Scripting",
      "Automation",
      "Cloud",
      "CI/CD",
      "DevOps",
      "Agile Development",
      "Data Analytics",
    ),
  ),
)
