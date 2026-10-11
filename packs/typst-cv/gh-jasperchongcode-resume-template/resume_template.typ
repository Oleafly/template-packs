//* ##########################################
//* #                                        #
//* #     Jasper Chong's Resume Template     #
//* #                                        #
//* ##########################################

// =============
// = constants =
// =============

#let website_link = "https://yourwebsite.com/thanks-for-viewing"

// ========================
// = Setup Page Settings  =
// ========================

#set page(margin: (top: 0.3in, bottom: 0.5in, left: 0.4in, right: 0.4in), footer: [
  #set text(size: 8pt, fill: black)
  #grid(
    columns: (1fr, auto),
    [References available upon request], [#datetime.today().display("[month repr:long] [year]")],
  )
])
#set text(font: "Arial", size: 10.5pt)
#set par(justify: true)

// ===================
// = Setup Functions =
// ===================
#let header_text(content) = text(size: 14pt, weight: "bold")[#content]

#let section_header(content, additional: []) = [
  #grid(
    columns: (1fr, auto),
    [
      #text(size: 12pt, weight: "bold")[#content]],
    [#emph(additional)],
  )
  #v(-0.9em)
  #line(length: 100%, stroke: 0.5pt)
]

#let subheader_text(content) = text(size: 11pt, weight: "bold")[#content]

#let contact_item(content) = text(size: 9pt)[#content]

#let job_title(title, company, duration) = [
  #grid(
    columns: (1fr, auto),
    [#subheader_text(company) - #emph(title)], [#emph[#duration]],
  )
]

#let education_item(degree, institution, duration) = [
  #grid(
    columns: (1fr, auto),
    [#subheader_text(institution) - #emph(degree)], [#emph(duration)],
  )
]

#let vdiv = [#h(1fr) | #h(1fr)]

// ==================
// = Header Section =
// ==================

#align(center)[
  #header_text[Your Name Here]

  #v(0.2em)
  #contact_item[
    #link("https://linkedin.com/in/yourprofile")[linkedin] #vdiv
    #link("https://github.com/yourhandle")[github] #vdiv
    #link(website_link)[*yourwebsite.com*] #vdiv
    your.email\@example.com #vdiv +61XXXXXXXXX
    #vdiv Citizenship or Work Eligibility #vdiv Languages spoken
  ]

  #v(0.1em)
]

#v(0.3em)

// ===================
// = Summary Section =
// ===================

*Summary:* One to two sentences summarizing your background, interests, or professional goals. Mention your academic focus, experience areas, and what you’re looking to do or learn next.

*Learning Interests:* List current areas you’re exploring (e.g. cloud computing, AI ethics, systems design, quantitative research)

// =====================
// = Education Section =
// =====================

#section_header[EDUCATION]

#education_item[
  Degree Name (e.g. BSc Computer Science)
][
  University Name
][Month Year -- Month Year]
*Majors or Minors:* Subject 1 & Subject 2 #vdiv *GPA:* X.X/7.0 or equivalent #vdiv *Relevant Scholarship or Award* #vdiv *Year Standing (e.g. Final Year)*

*Extra Program/Club:* Optional description of a selective or prestigious opportunity (e.g. research academy, innovation hub, leadership program)

#grid(
  columns: (1fr, auto),
  [#text(size: 11pt, weight: "bold")[High School Name] - _ATAR/Score: XX.XX_], [#emph[Month Year - Month Year]],
)

Relevant Subject (Score%) #vdiv Subject (Score%) #vdiv Subject (Score%) #vdiv Subject (Score%) #vdiv Subject (Score%)

// ======================
// = Experience Section =
// ======================

#section_header[EXPERIENCE]

#job_title[Job Title or Role][Company or Org Name][Month Year -- Present or End Date]

- One-line explanation of your key accomplishment. Use action verbs, mention tech/tools if relevant, and quantify results where possible.

#job_title[Job Title][Organization Name][Month Year -- Month Year]

- Describe a project or contribution you owned. Could be client-focused, research-based, or process-improving.

#job_title[Intern / Team Member / Assistant Role][Company, Lab, or Club Name][Month Year -- Month Year]

- Write about what you helped with or learned, especially if technical, cross-functional, or collaborative.

// =============================
// = Selected Projects Section =
// =============================

#section_header(additional: [More details at #link(website_link)[yourwebsite.com]])[SELECTED PROJECTS]

- *Project Title*: Describe a personal or team project. Mention its purpose and what technologies were used.

- *Another Project*: Could be anything from a class assignment to a hackathon idea. Short, specific, and interesting.

- *Portfolio Work or Tool*: Describe a creative or helpful tool, script, or platform you developed.

- *Experimental or Research Project*: Mention algorithm type, data, or system if applicable.

- *Fun or Side Project*: Optional—highlight creativity, design, or novelty.

// ============================
// = Technical Skills Section =
// ============================

#section_header[TECHNICAL SKILLS]

*Languages:* Programming or scripting languages, listed with comfort level or usage hours (optional)

*Tools & Platforms:* Frameworks, APIs, deployment tools, cloud services, editors, or environments

// ===========================
// = Extracurricular Section =
// ===========================

#section_header[EXTRACURRICULAR]

#subheader_text[Leadership or Volunteering]

List formal or informal roles (e.g. club executive, peer mentor, volunteer team member), especially if recurring or long-term

#subheader_text[Competitions]

Mention coding, maths, data science, hackathons, finance, etc. Include percentile or rank if notable

#subheader_text[Topics & Learning]

List key course topics or personal studies (e.g. NLP, Computer Vision, Linear Models, Security, Backend APIs)
