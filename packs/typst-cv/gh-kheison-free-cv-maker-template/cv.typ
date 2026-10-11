#import "@preview/modern-cv:0.10.0": *

#show: resume.with(
  author: (
    firstname: "Mark",
    lastname: "Scout",
    email: "mark.s@lumon.example",
    phone: "+1 (555) 010-PE00",
    linkedin: "marks-mdr",
    address: "Kier, PE",
    positions: ("Refiner — Macrodata Refinement",),
  custom: (
    (text: "lumon.example/mdr", icon: "globe", link: "https://lumon.example/mdr"),
  ),
  ),
  profile-picture: none,
  date: datetime.today().display(),
  paper-size: "a4",
  accent-color: "#26428b",
)

= Experience

#resume-entry(
  title: "Lumon Industries",
  location: "Refiner & Team Lead — Macrodata Refinement",
  date: "Severed Date – Present",
  description: "Severed Floor, MDR Department",
)
#resume-item[
  - Refine mysterious and important numerical data on a Lumon-issued terminal, sorting figures into the four prescribed bins based on the feelings they evoke.
  - Promoted from Refiner to Team Lead following a recent departure on the team; now responsible for the daily output of three direct reports.
  - Sustained a consistent quarterly quota above target, earning team perks including a Music Dance Experience and an upcoming Waffle Party.
  - Maintain rigorous adherence to the Lumon Compliance Handbook and recite the Nine Core Principles on request.
  - Onboard new department hires, walk them through the wellness session protocols, and demonstrate proper bin-completion etiquette.
]

#resume-entry(
  title: "Ganz College",
  location: "Lecturer — Department of History",
  date: "Pre-Severance",
  description: "Undergraduate teaching",
)
#resume-item[
  - Designed and delivered semester-long courses in modern history for first- and second-year undergraduates.
  - Authored lecture material, set examinations, and supervised end-of-term essays for cohorts of \~80 students per term.
  - Served on faculty committees for curriculum review and undergraduate advising.
]

= Education

#resume-entry(
  title: "Ganz College",
  location: "M.A. — History",
  date: "Pre-Severance",
  description: "Focus: 20th-century industrial labor history",
)

= Certifications

#resume-entry(
  title: "Lumon Severance Procedure — Recipient",
  location: "Lumon Industries, Office of Severance Compliance",
  date: "On File",
  description: "",
)

#resume-entry(
  title: "Lumon Compliance Handbook — Annual Recertification",
  location: "Lumon Industries",
  date: "Current Cycle",
  description: "",
)

= Skills

#resume-skill-item(
  "Refinement",
  (strong("Macrodata Bin-Sorting"), "Quota Management", "Numerical Pattern Recognition", "Terminal Operation (Lumon Standard Issue)"),
)

#resume-skill-item(
  "Compliance",
  ("Lumon Handbook (Cover-to-Cover)", "The Nine Core Principles", "Workplace Etiquette", "Hallway Wayfinding"),
)

#resume-skill-item(
  "Leadership",
  ("Team Lead (MDR)", "New-Hire Onboarding", "Wellness Session Coordination", "Quarterly Perk Allocation"),
)

#resume-skill-item(
  "Prior Discipline",
  ("Lecturing", "Curriculum Design", "Historical Research", "Undergraduate Mentorship"),
)

#resume-skill-item(
  "References",
  ("Available upon request", "Pending pre-clearance from the Office of Severance Compliance"),
)
