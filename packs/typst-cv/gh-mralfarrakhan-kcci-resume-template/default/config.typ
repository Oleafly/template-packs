#let config = (
  personal: (
    name: [],
    dob: [],
    address: [],
    phone: [],
    email: [],
    company: [],
    position: [],
    competencies: [
      - #lorem(20)
      - #lorem(20)
      - #lorem(20)
    ],
  ),
  education: (
    (
      period: [yyyy.mm \~ yyyy.mm],
      institution: [],
      major: [],
      gpa: [],
      degree: [Bachelor's Degree],
      location: [],
    ),
    (
      period: [],
      institution: [],
      major: [],
      gpa: [],
      degree: [Master's Degree],
      location: [],
    ),
  ),
  work: (
    (
      period: [yyyy.mm \~ yyyy.mm],
      company: [],
      resp: [],
      position: [],
    ),
    (
      period: [],
      company: [],
      resp: [],
      position: [],
    ),
  ),
  cert: (
    (
      category: [],
      level: [],
      date: [],
      org: [],
    ),
  ),
  training: (
    (
      course: [],
      period: [yyyy.mm.dd \~ yyyy.mm.dd],
      provider: [],
    ),
    (
      course: [],
      period: [],
      provider: [],
    ),
  ),
  motivation: [#lorem(80)],
  skills: [#lorem(80)],
  about: [#lorem(80)],
  project: (
    name: [],
    period: [],
    role: [],
    objectives: [],
    tech: [],
    details: [#lorem(400)],
  ),
)
