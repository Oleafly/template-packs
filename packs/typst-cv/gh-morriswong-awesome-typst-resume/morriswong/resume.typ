#show heading.where(level: 1): text.with(size: 30pt / 1.4, weight: "bold")
#show heading.where(level: 2): text.with(size: 15pt / 1.2, weight: "bold")
#show heading.where(level: 3): text.with(size: 11pt, weight: "bold")
#show link: underline

// Uncomment the following lines to adjust the size of text
// The recommended resume text size is from `10pt` to `12pt`
#set text(font: "Noto Sans", size: 10.5pt)
#set text(top-edge: 0.3em, bottom-edge: -0.3em)
#set par(leading: 0.9em)

// Feel free to change the margin below to best fit your own CV
#set page(
  margin: (x: 0.9cm, y: 1.3cm),
)

// For more customizable options, please refer to official reference: https://typst.app/docs/reference/

#set par(justify: true)

#let chiline() = {v(-5pt); line(length: 100%); v(-1pt)}

= John Doe

Anywhere, Earth | john.doe\@example.com | +00 000 000 0000 #h(1fr) #link("https://example.com")[Portfolio] | #link("https://example.com")[LinkedIn] | #link("https://example.com")[Github]

== Professional Summary
#chiline()

Results-driven technology professional with experience in data analytics, engineering, and AI. Skilled in building scalable solutions and collaborating across teams. Passionate about leveraging technology to solve complex problems.

== Professional Experience
#chiline()

*Lead Data Engineer, ExampleTech Corp* #h(1fr) Jan 2024 -- Present \  
International technology solutions provider #h(1fr) Remote \  
- Designed and implemented a cloud-based data pipeline, reducing processing time by 60%.  
- Led a team of engineers to deliver a real-time analytics dashboard for enterprise clients.  
- Automated data quality checks, improving reliability and reducing manual intervention.  
- Coordinated cross-functional teams to deliver projects on schedule.

*Data Analyst, Generic Analytics Ltd.* #h(1fr) Jun 2021 -- Dec 2023 \  
Analytics consulting firm #h(1fr) Remote \  
- Developed interactive reports and dashboards for business stakeholders.  
- Conducted statistical analysis to identify trends and inform business decisions.  
- Improved data collection processes, increasing data accuracy by 30%.  
- Provided training and support to junior analysts.

*Software Developer, Sample Solutions* #h(1fr) Jul 2019 -- May 2021 \  
Software development agency #h(1fr) Remote \  
- Built and maintained web applications using modern frameworks.  
- Collaborated with designers and product managers to deliver user-focused features.  
- Wrote automated tests to ensure code quality and reliability.

== Projects
#chiline()

*ResumeGen (https://resumegen.example.com)* #h(1fr) Mar 2025 -- Present \  
Automated resume generator using AI \  
- Developed a web application that generates professional resumes from user input.  
- Integrated third-party APIs for document formatting and export.

*DataViz Toolkit* #h(1fr) 2024 \  
Open-source data visualization library \  
- Created reusable components for interactive charts and graphs.  
- Published documentation and tutorials for community use.

== Technical Skills
#chiline()

- *Languages:* Python, SQL, JavaScript, TypeScript
- *Frameworks & Tools:* React, FastAPI, Docker, Git, Airflow, Tableau
- *Cloud:* AWS, Azure

== Education
#chiline()

*University of Example* #h(1fr) Sep 2015 -- Jun 2019 \  
Bachelor of Science in Computer Science #h(1fr) Anywhere, Earth
