// Section 1: R&D Operation Context

#import "../Utilities/style.typ": definition-box

= R&D Operation Context <sec:context>

#definition-box[
  - *Goal*: This section should set the stage for the report by providing a global context of the R&D Operation within the ALTEN context (research program, research project).
  - *RACI*:
    - Writer(s): Innovation Pilot, Intern
    - Reviewer: Research Director
]

== Internal Context <subsec:internal-context>

=== Research Program
*Vision:*

=== Project
*Vision:*

== R&D Operation: Title <subsec:operation-brief>

=== Operation Objectives

#definition-box[
  *Goal*: detail the specific goals and outcomes that the R&D operation aims to achieve. These objectives should be measurable and aligned with the organization's overall R&D strategy.
  
  In the case of IT projects, wherever possible, specify objectives that fall into one of these three categories:
  
  - Creation of an original and/or better technique than the existing ones: the technique itself will be described and could be reused for future applications.
  - The search for an original and/or better methodology than the existing ones. This may involve the design of a new methodology or software development strategy, or the adaptation of an existing methodology with systematic application to a particular case study.
  - The improvement of know-how concerning existing but recent concepts or technologies, where know-how related to their use or application is not yet established and poses real problems.
]

=== Research Questions

#definition-box[
  *Goal*: Clearly define the specific problem or challenge that the research operation will address. This should relate to the research project's vision.
]

== Document Structure <subsec:document-structure>

This report is structured as follows:

- @sec:problem presents the Research and Development Operation in more detail, by clearly defining the research questions that this operation addresses in @subsec:research-questions as well as the technical and scientific obstacles to overcome in @subsec:locks;
- @sec:sota presents the State of the Art related to the topics that are relevant to the operation that has just been described. @subsec:sota-introduction introduces the relevant concepts and definitions to be understood in order to properly interpret the rest of the section, @subsec:literature-review depicts the literature review, and finally @subsec:summary summarizes the findings and highlights the limitations of the currently known solutions;
- @sec:operations illustrates the approach that has been proposed to overcome the identified limitations and locks in @subsec:approach-overview along with the details of its implementation by describing the experiments that have been performed during the operation, detailing the hypotheses, results and conclusions of each iteration;
- @sec:conclusions concludes this report by reviewing the advancement of the operation related to our research questions and obstacles in @subsec:review and provides a summary of the current limitations of the approach as well as the perspectives of future work in @subsec:future-work.
