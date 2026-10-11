#import "resume.typ": resume, experience, chip, linked_block, skills

#show: doc => resume(
  name: "John Smith",
  contacts: (
    email: "john.smith@example.com",
    linkedin: "john-smith-fake",
    github: "JohnSmith",
    website: "johnsmith.example.com",
  ),
  // These are embedded into the document metadata
  keywords: ("pdf", "typesetting", "typist"),
  header_gradient: (
    ..color.map.flare,
  ),
  paper: "us-letter",
  // These should be changed to a better display font that is installed on your computer.
  // If you aren't sure what is available, try using the Typst language server with
  // `#text(font: "type here")` to get auto-complete for available fonts
  header_font: "Liberation Serif",
  body_font: "DejaVu Sans",
  // This changes the default spacing between blocks
  // Using em as the unit should improve scaling
  spacing: 1em,
  doc
)

#align(center)[
  _Professional PDF maker with 20+ years of experience and a passion for clean typesetting_
]

#v(0.75em)

#grid(columns: (auto, auto), column-gutter: 1fr, row-gutter: 0.9em,
  skills(label: [Programs], ("Acrobat", "Typst"),("Other",)),
  skills(label: [Soft Skills], ("Time Management", "Communication"), ("Work Ethic", "Attention to Detail")),
)

= Experience

#experience(
  name: "ACME Corp",
  highlight: "PDF Maker",
  "Remote",
  "2001-2020",
)[
  === 2001-2007
  - Create professional PDFs for clients in various industries, including legal, financial, and marketing
  - Collaborate with clients to ensure the final product meets their specifications and requirements
  === 2007-2020
  - Utilize various tools and software to optimize PDFs for print and digital distribution
  - Maintain a high level of accuracy and attention to detail throughout the process
]

= Portfolio

#block(inset: (left: 2em))[

  _The source code for each of these projects is available on my GitHub page at #link("https://github.com/JohnSmith")[github.com/JohnSmith]_
  
  #v(0.5em)
  
  #columns(2)[
  
    #linked_block(name: "Professional Business Plan", github: "JohnSmith/bus-plan", tech: ("Microsoft Word", "HTML"))[
      A comprehensive business plan for a new startup in the technology industry.
      The plan includes an executive summary, market analysis, financial projections,
      and a detailed marketing strategy.
    ]
    
    #colbreak()
    
    #linked_block(name: "Interactive Resume", address: "https://example.com", tech: ("CSS", "JavaScript"))[
      An interactive resume that showcases the skills and experience of a professional in the marketing industry. The resume includes interactive elements such as a skill bar, portfolio links, and a contact form.
    ]

  ]

]

= Education

Efficient GPU Implementation of Stable Position-Based Dynamics for Rigid Bodies
#experience(
  name: "XYZ University",
  highlight: "3.6 GPA",
  [Bachelor of Science in Computer Science, #chip()[Honors], Minors: Typesetting],
  "May 2000",
)[
  #block(inset: (left:2em), skills((), ("The Impact of Social Media on Mental Health in College Students: A Qualitative Study",), label: "Thesis"))
  #block(inset: (left:2em), skills(label: "Relevant Coursework", ("PDF Basics",), ("How to use Word",)))
]

= Certifications

#block(inset: (left: 2em))[

#linked_block(
  name: [*GFACT* - GIAC Foundational Cybersecurity Technologies],
  address: "https://example.com/badges/badge-id",
  image_file: "images/gfact.png",
)[
  _Global Information Assurance Certification (GIAC)_

  The GFACT certification tests knowledge of foundational
  cybersecurity concepts and practical skills in computers,
  technology, and security fundamentals.
]

]

= Volunteer Experience

#experience(
  name: "Volunteer Coordinator",
  highlight: "Event Manager",
  "XYZ Organization",
  "April 2021",
)[
  As a volunteer coordinator at XYZ organization, I was responsible for organizing and managing volunteer events for the organization. This included recruiting volunteers, scheduling events, and providing support during events.
]

