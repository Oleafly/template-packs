#import "template.typ": template-config, detail

// TODO: Update your information
#show: doc => template-config(
  name: "John Doe", // Your name
  id: 801234567, // Your student ID
  email: "jdoe@charlotte.edu", // Your email
  instructor: "Dr. Jane Smith", // Instructor name
  department: "Department of Computer Science", // Department name
  title: "Independent Study in Typst Programming", // Independent study title
  credit: 3, // Credit hours
  term: "Fall 2025", // Term
  substitution: none, // If this is a course substitution, enter the course number; otherwise keep none for an elective
  doc,
)

// --- Course Application to Plan of Study ---

#detail[Expected Student Learning Outcomes/Objectives][
  // TODO: Add expected student learning outcomes/objectives.
]

#detail[Grading/Evaluation Criteria][
  // TODO: Add grading/evaluation criteria.
]

#detail[Assignments (readings, description of assignments, etc.)][
  // TODO: Add assignments (readings, description of assignments, etc.).
]
