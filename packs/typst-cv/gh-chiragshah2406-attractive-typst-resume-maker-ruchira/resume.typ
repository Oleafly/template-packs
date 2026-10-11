#import "template.typ": *

#show: project.with(
  theme: rgb("#0F83C0"),
  name: "Ruchira Shah",
  title: "PMP Certified | MBA | AI-Powered Project Manager",
  contact: (
    contact(text: "640-267-5118", url: "tel:640-267-5118"),
    contact(text: "shahruchira17@gmail.com", url: "mailto:shahruchira17@gmail.com"),
    contact(text: "LinkedIn", url: "https://linkedin.com/in/ruchirashahmbapmp"),
    contact(text: "Somerset, NJ, USA"),
  ),
  main: (
    section(
      title: "Professional Summary",
      content: [
        Certified Project Management Professional (PMP) and MBA with over 15 years of progressive experience leading complex, high‑stakes projects across government, technology, finance, retail and real‑estate sectors. Demonstrated expertise in AI‑driven project delivery, stakeholder engagement, and cross‑functional team leadership.
      ]
    ),
    section(
      title: "Professional Experience",
      content: [
        #subSection(
          title: "Project Manager",
          titleEnd: "Remote",
          subTitle: "ARC HOMEZ",
          subTitleEnd: "(Jan 2025 – Present)",
          content: list(
            [Led full property lifecycle management, increasing revenue by 22% through AI-powered market analysis and strategic growth initiatives.],
            [Architected and deployed automated guest communication workflows and AI-driven 24/7 support systems, reducing manual response times by 85%.],
            [Managed diverse multi-vendor teams using AI scheduling and resource allocation tools, reducing maintenance costs by 15%.],
            [Oversaw end-to-end financial planning using AI predictive modeling for demand forecasting, dynamic pricing, and budget management.],
            [Monitored real-time portfolio KPIs, occupancy rates, and financial health through AI analytics dashboards.]
          )
        )
        #subSection(
          title: "Program Manager – Consultant",
          titleEnd: "Trenton, NJ",
          subTitle: "New Jersey State Parole Board",
          subTitleEnd: "(2021 – 2024)",
          content: list(
            [Served as program liaison to Federal, state, and local government officials and service providers, facilitating seamless inter-agency collaboration.],
            [Managed multiple concurrent projects up to \$5M, identified and mitigated risks, and tracked schedule and cost performance.],
            [Provided end-to-end business analysis covering requirements, success criteria, milestones, KPIs, and Work Breakdown Structures.],
            [Drove PM process improvements by introducing a new business case template that enhanced project visibility for executive decision-making.],
            [Leveraged AI tools including the NJ AI Assistant to improve operational efficiency and data analysis workflows.]
          )
        )
        
        // Pushing the following experience to page 2
        #v(180pt)
        
        #subSection(
          title: "Project Manager",
          titleEnd: "Edison, NJ",
          subTitle: "Kaizen Technologies",
          subTitleEnd: "(2016 – 2019)",
          content: list(
            [Managed cross-departmental coordination for global instructor-led and online training programs executed successfully, on time, and within scope.],
            [Gathered project information, initiated kick-off meetings, and ensured all stakeholders understood project scope and success criteria.],
            [Responsible for end-to-end event planning and logistics execution for all instructor-led programs.],
            [Analyzed instructional problems and training gaps, determining goals aligned with organizational capability-building strategies.]
          )
        )
        #subSection(
          title: "Project Manager – Private Consultant",
          titleEnd: "Princeton, NJ",
          subTitle: "Zirtual Inc",
          subTitleEnd: "(2013 – 2015)",
          content: list(
            [Led small to medium-scale projects to validate needs and define success criteria for all stakeholders involved.],
            [Served as the primary liaison between business units and technical staff for a major enterprise-wide overhaul of the IVR system.],
            [Gathered business requirements through interviews and workshops; documented rules and detailed process flows.],
            [Assisted in developing use cases, storyboards, and functional specifications to guide technical development teams.]
          )
        )
        #subSection(
          title: "Procurement Project Manager",
          titleEnd: "Roselle Park, NJ",
          subTitle: "Patel Consulting",
          subTitleEnd: "(2011 – 2013)",
          content: list(
            [Transformed work plans and staffing structures for project execution phases, ensuring efficient resource utilization.],
            [Monitored Quality Assurance, Merchandising, and Inventory Control to maintain operational standards.],
            [Analyzed historical and market pricing data to support development of commodity budgets and procurement strategies.],
            [Supervised buyers and expediters, overseeing all home office and jobsite procurement activities for Power Projects.]
          )
        )
        #subSection(
          title: "Relationship Banker",
          titleEnd: "Greater Chicago Area",
          subTitle: "Bank of America",
          subTitleEnd: "(2008 – 2010)",
          content: list(
            [Engaged customers to build relationships, uncover financial needs, and deliver tailored recommendations.],
            [Implemented targeted sales activities to achieve revenue objectives and expand customer base.],
            [Partnered with Financial Advisors and Mortgage Bankers to provide specialized financial guidance.]
          )
        )
      ]
    ),
  ),
  sidebar: (
    section(
      title: "Technical Competencies",
      content: [
        *Tools:* MS Project, Jira, Gantt, WBS, Teams, SharePoint\
        *AI & Analytics:* AI Market Analysis, PMI Infinity, NJ AI Assistant, Predictive Modeling\
        *Methodologies:* Agile, Scrum, Risk Management, Change Control
      ]
    ),
    section(
      title: "Education & Certifications",
      content: list(
        [**PMP** – Project Management Institute],
        [**MBA** – Schiller International University],
        [**GenAI / Prompt Eng** – PMI Certifications]
      )
    ),
    section(
      title: "Awards",
      content: list(
        [PMI-NJ Volunteer of the Month (Feb 2022)],
        [Certificate of Appreciation – NJ SPB (2022, 2023)]
      )
    ),
    section(
      title: "Volunteer Work",
      content: [
        *PMI NJ Chapter:* Volunteer (2016 – Present). Dedicated contributor to chapter initiatives.
      ]
    ),
    section(
      title: "Status",
      content: [
        US Citizen\
        Available for Opportunities\
        PMI Member (NJ Chapter)
      ]
    )
  )
)
