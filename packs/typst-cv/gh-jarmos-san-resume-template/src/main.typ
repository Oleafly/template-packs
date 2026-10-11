// Import variables and functions
#import "variables.typ": doc, college, skills, details, experiences
#import "functions.typ": header, section, experience, academic

// Document settings
#set document(
  author: doc.author,
  title: doc.title,
  description: [#doc.description],
  keywords: doc.keywords,
)
#set page(margin: 1.25cm)
#show link: underline
#set text(font: "Liberation Serif")

// The top-level heading of the resume
#header(details.name, details.links)

// The "skills" section
#section[Skills]
#for (key, value) in skills {
  [*#key*: #value #linebreak()]
}

// The "experience" section
#section[Experience]
#for exp in experiences {
  experience(
    exp.designation,
    exp.company,
    exp.location,
    exp.start,
    exp.end,
    exp.achievements,
  )
}

// The "education" section
#section[Education]
#academic(
  college.name,
  college.degree,
  college.subject,
  college.start,
  college.end,
)
