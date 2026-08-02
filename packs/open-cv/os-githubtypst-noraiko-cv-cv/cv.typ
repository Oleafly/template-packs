#import "@preview/basic-resume:0.2.9": *

#let name = "Nurulhuda Gumay Riswandi"
#let location = "London, UK"
#let email = "riswn1205@gmail.com"
#let linkedin = "linkedin.com/in/riswandi-ng"
#let phone = "+447918982178"

#show: resume.with(
  author: name,
  email: email,
  location: location,
  linkedin: linkedin,
  phone: phone,
  accent-color: "#000",
  font: "New Computer Modern",
  font-size: 10.25pt,
  author-font-size: 20.5pt,
  paper: "a4",
  author-position: center,
  personal-info-position: left,
)

== Education

#edu(
  dates: dates-helper(start-date: "September 2025", end-date: "Present"),
  degree: "Master of Science in Public Policy",
  consistent: true,
)
- *Relevant Modules:* Causal Inference, Introduction to Quantitative Methods,
  Qualitative Methods: Case Studies and Comparative Analysis, Public Policy
  Economics and Analysis, Policy Implementation, Policy Proposal Project

#edu(
  dates: dates-helper(start-date: "September 2022", end-date: "July 2025"),
  degree: "Bachelor of Arts (Hons) in Philosophy and Politics - Grade: 2:1",
  consistent: true,               
)

== Projects

#project(
  name: "National Transition Package for Disadvantaged Students in Higher Education",
  dates: dates-helper(start-date: "June 2026", end-date: "Present")
)
- Developed an initial policy evidence base examining post-entry inequalities in higher education, including continuation, completion, financial pressure and student belonging.
- Synthesised evidence from regulators, student organisations and higher education providers to identify gaps in transition and support provision.
- Currently developing policy recommendations on transition support, targeted first-year financial assistance and ongoing support standards.

#project(
  name: "Causal Inference: Poor Housing Conditions and Self-Reported Health in the UK",
  dates: "May 2026"
)
- Analysed whether poor housing conditions affect the likelihood of reporting poor health using UK Poverty and Social Exclusion Survey data
- Applied regression analysis, robust standard errors and propensity score matching to estimate the relationship between poor housing and poor health.
-  Used R to clean survey data, construct treatment and outcome variables, conduct robustness checks and present findings through tables and visualisations

== Work Experience

#work(
  title: "Student Storyteller",
  dates: dates-helper(start-date: "January 2026", end-date: "June 2026"),
  company: "Student Communications Team",
  location: "UK University",
)
- Write commissioned articles surrounding complex ideas and institutional
  initiatives into clear, accessible content.
- Research stories, develop narrative angles and conduct interviews,
  translating student experiences and institutional initiatives.
- Produce audience-focused written content in line with editorial briefs,
  ensuring clarity, engagement and impact.

#work(
  title: "Student Writer and Contributor",
  dates: dates-helper(start-date: "December 2025", end-date: "May 2026"),
  company: "Online Student Publication",
  location: "UK University",
)
- Write analytical and opinion-based articles on social and political issues
  for an online audience.
- Conduct independent research and develop arguments, presenting complex topics
  in a clear and engaging format.
- Adapt tone and structure to suit audience needs, strengthening communication
  beyond academic writing.

#work(
  title: "Research Team Member",
  dates: dates-helper(start-date: "November 2025", end-date: "June 2026"),
  company: "Policy Research Institute",
  location: "UK University",
)
- Conduct research on migration and refugee policy, producing evidence-informed
  insights for policy-relevant discussions.
- Synthesise academic literature, policy reports and datasets to identify key
  trends and support analytical outputs.
- Contribute to collaborative research outputs, including drafting sections and
  refining findings for clarity and impact.

#work(
  title: "Lead Intern",
  dates: dates-helper(start-date: "June 2025", end-date: "August 2025"),
  company: "Centre of Higher Education Practice",
  location: "UK University",
)
- Led a team of interns to deliver a university-wide academic programme,
  coordinating across staff and stakeholders.
- Acted as a liaison between academic, operational and student teams to support
  effective project delivery.
- Facilitated structured planning and communication processes to ensure timely
  and organised outputs.

#work(
  title: "Student Project Intern",
  dates: dates-helper(start-date: "April 2025", end-date: "January 2026"),
  company: "Centre of Higher Education Practice",
  location: "UK University",
)
- Supported education-focused projects through stakeholder engagement,
  coordination and content development.
- Designed a centralised SharePoint hub to improve access to information and
  collaboration across teams.
- Contributed to project delivery through organisation, communication and
  problem-solving.


== Technical Skills

- *Research & Analysis:* Policy research, evidence synthesis, literature reviews, qualitative research, quantitative methods, policy analysis.
- *Policy and Communication:* Policy brief writing, analytical writing, stakeholder engagement, interview-based research, audience-focused communication.
- *Project and Coordination:* Project coordination, team liaison, planning, SharePoint-based collaboration, cross-functional communication.
- *Tools:* Microsoft Office: Word, Excel, PowerPoint; SharePoint; R (competent working knowledge: data cleaning, statistical analysis and visualisation); Python (currently developing).