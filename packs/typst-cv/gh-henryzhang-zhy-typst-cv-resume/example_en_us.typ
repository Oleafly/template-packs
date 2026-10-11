#import "./template/r.typ": *;
// To fit the content into one page, we can adjust the font size and spacing.
#show: template.with(font-size: 11pt);

#r_name("Alex Chen")

#contact("+86-138-0000-0000", "alex.chen@example.com")

#intent("Objective: Technical Intern")

#r_section("Education")
#r_item(
  "University of XX",
  "Sep 2020 - Jun 2024",
  "B.S. in Computer Science, School of Information",
  "Beijing",
)
#r_description("GPA", "3.6 / 4.0")
#r_description("English Proficiency", "CET-4 Score: 550")

#r_section("Honors & Awards")
#award_item("National Mathematical Contest in Modeling, Provincial Second Prize", "May 2023")
#award_item("University Outstanding Student Scholarship, First Prize", "Nov 2022")

#r_section("Projects")
#r_item(
  "Face Recognition Attendance System",
  "Dec 2023",
  none,
  none
)

- Developed a web-based face recognition attendance system as a course project; users upload an image and the system automatically logs attendance — independently completed the full implementation.
- Trained a feature extraction model using FaceNet on a public face dataset, integrated OpenCV for detection and alignment, and adopted dlib for matching; boosted overall accuracy through a well-designed preprocessing pipeline.
- Experimented with GitHub Copilot during development to generate code snippets and help debug issues; all generated code was personally reviewed, understood, and adapted before integration, gaining initial exposure to AI‑assisted development workflows.
- Carried out the complete cycle from dataset preparation, model training, to web service deployment; deepened hands‑on Python skills and independent troubleshooting ability, and gained concrete experience in “turning an AI model into a real, usable service”.

#r_section("Summary")
- Active participant in academic competitions — earned provincial second prize in the National Mathematical Contest in Modeling and a university first‑class scholarship; built resilience through sustained, independent problem‑solving.
- Independently built a face recognition attendance system, gaining first‑hand exposure to model training, image preprocessing, and API integration; aware of the gaps between course projects and production engineering, and motivated to close them.
- Seeking a technical internship where I can contribute to meaningful projects, learn from experienced engineers, and build a strong practical foundation for long‑term career growth.
