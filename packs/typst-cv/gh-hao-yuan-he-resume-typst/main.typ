#import "lib.typ": *

// Put your personal information here, replacing mine
#let name = "Hao-Yuan He (何浩源)"
#let location = "Nanjing, China"
#let email = "alkane0050@gmail.com"
#let github = "github.com/stuxf"
#let linkedin = "linkedin.com/in/stuxf"
#let phone = "+86 18851768896"
#let personal-site = "hao-yuan-he.github.io"
#let img = "prof_pic.png"

#show: resume.with(
  author: name,
  // All the lines below are optional.
  // For example, if you want to to hide your phone number:
  // feel free to comment those lines out and they will not show.
  location: location,
  email: email,
  // github: github,
  // linkedin: linkedin,
  phone: phone,
  img: img,
  personal-site: personal-site,
  accent-color: "#26428b",
)

/*
 * Lines that start with == are formatted into section headings
 * You can use the specific formatting functions if needed
 * The following formatting functions are listed below
 * #edu(dates: "", degree: "", gpa: "", institution: "", location: "")
 * #work(company: "", dates: "", location: "", title: "")
 * #project(dates: "", name: "", role: "", url: "")
 * #extracurriculars(activity: "", dates: "")
 * There are also the following generic functions that don't apply any formatting
 * #generic-two-by-two(top-left: "", top-right: "", bottom-left: "", bottom-right: "")
 * #generic-one-by-two(left: "", right: "")
 */

== Education

#edu(
  institution: "School of Computer Science, Nanjing Tech University",
  location: "Nanjing, China",
  dates: dates-helper(start-date: "2017", end-date: "2021"),
  degree: "B.Eng. in Computer Science.",
)

#edu(
  institution: "School of Artificial Intelligence, Nanjing University",
  location: "Nanjing, China",
  dates: dates-helper(start-date: "2021", end-date: "2024"),
  degree: "M.Eng. in Computer Science, LAMDA Group. Advised by Prof. Ming Li.",
)

#edu(
  institution: "School of Artificial Intelligence, Nanjing University",
  location: "Nanjing, China",
  dates: dates-helper(start-date: "2024", end-date: "Now"),
  degree: "Ph.D. in Computer Science, LAMDA Group. Advised by Prof. Ming Li.",
)
== Work Experience


#work(
  title: "Research Intern, AI Lab, Tencent",
  location: "Shenzhen, China",
  des: "Worked on game AI for Honor of Kings (王者荣耀), migrating the training pipeline from TensorFlow 1.12 to PyTorch and developing novel algorithms for fine-grained, competition-level agents.",
  dates: dates-helper(start-date: "2023.05", end-date: "2023.07"),
)

== Research
I study reliable neuro-symbolic AI under weak supervision and structured reasoning.
Selected publications:

#work(
  title: "Learning-Augmented Smooth Integer Programs with PAC-Learnable Oracles",
  des: "Developed a learning-augmented framework for NP-hard optimization problems such as MAX-CUT and MAX-k-SAT. The method uses predictions to build a tractable surrogate objective, remains robust to prediction errors, extends approximation guarantees from dense to near-dense settings, and proves the oracle can be learned efficiently from data.",
  dates: "Submitted to ICML'2026",
)

#work(
  title: "A Learnability Analysis on Neuro-Symbolic Learning",
  des: "Established a characterization of when neuro-symbolic tasks are truly learnable by linking them to their underlying constraint structure. ",
  dates: "NeurIPS'2025 (Spotlight)",
)

#work(
  title: "Ambiguity-Aware Abductive Learning",
  des: "Proposed an ambiguity-aware approach for abductive learning when logical reasoning returns multiple plausible supervision candidates. Instead of committing to one candidate too early, the method models uncertainty over candidates, yielding more reliable supervision and stronger performance.",
  dates: "ICML'2024",
)


== Academic Service
// #work(
//   title: "Volunteer",
//   des: "MLA’2023, IJCLR’2024",
//   dates: dates-helper(start-date: "2023", end-date: "Now"),
// )

#work(
  title: "Conference Reviewer / PC Member",
  des: "Reviewed for ACML, IJCLR, ICLR, ICML, NeurIPS, and AAAI.",
  dates: dates-helper(start-date: "2023", end-date: "Now"),
)

#work(
  title: "Journal Reviewer",
  des: "Reviewed for Knowledge and Information Systems.",
  dates: dates-helper(start-date: "2023", end-date: "Now"),
)


== Awards

#award(
  name: "Outstanding Graduate Student",
  des: "Nanjing University",
  dates: "2023, 2024",
)

#award(
  name: "Winner",
  des: "International Algorithm Case Competition, Track of Data Selection and Label Correction",
  dates: "2022",
)

#award(
  name: "First Prize of Academic Scholarship",
  des: "Top 10%, Nanjing University",
  dates: "2022, 2023",
)

#award(
  name: "National Encouragement Scholarship",
  des: "Jiangsu Education Department",
  dates: "2019",
)

#award(
  name: "First Prize, Chinese Mathematics Competitions",
  des: "Chinese Mathematical Society",
  dates: "2018, 2020",
)

== Publications
// show me by underline
#show "H.-Y. He": name => box[
  #underline(name)
]

#bibliography("works.bib", title: none, full: true)
