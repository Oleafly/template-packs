#import "template.typ": resume, header, coursework_item, resume_heading, edu_item, exp_item, project_item, skill_item

#show: resume

#header(
  name: "Sigma Final Boss",
  website: "github.com/yourhandle",
  email: "email@domain.com",
  linkedin: "linkedin.com/in/you",
  number: "0000000000",
  misc: "locked in since birth"
)

#resume_heading[Education]
#edu_item(
  name: "University of Chronic Brainrot",
  degree: "Bachelor of Science in Advanced Cookery with a minor in Strategic Mogging",
  GPA: "6.7",
  date: "Fall 2027"
)

#coursework_item(
  category: "Relevant Lore:",
  courses: "Introduction to Locking In Under Pressure, Applied Mewing and Facial Optimization, Parallel Mogging Systems, Operating Systems for NPC Containment, Data Structures with Zero Weak Links, FPGA Sorcery and Bit-Level Wizardry, Advanced Signal Vibes"
)

#resume_heading[Experience]

#exp_item(
  role: "Professional Lock-In Engineer",
  date: "December 2025 -- Present",
  [Consistently entered high-pressure environments and locked in immediately despite missing documentation.],
  [Transformed vague ideas and partially functioning systems into just stable enough to be considered “done”],
  [Assumed responsibility for critical path work while publicly downplaying contributions to maintain team morale],
  [Exited projects quietly after delivery, leaving behind functioning systems and unanswered questions]
)

#exp_item(
  role: "Intern - NPC Debugger",
  date: "May 2025 -- July 2025",
  [Diagnosed root causes of failure by translating statements like “it was working yesterday” into actionable items],
  [Resolved confusion across teams by identifying the single incorrect assumption everyone silently agreed on],
  [Provided solutions that worked immediately while refusing to explain them twice]
)

#exp_item(
  role: "Intern - Chief Button Clicker",
  date: "April 2024 -- July 2024",
  [Interacted directly with complex systems through strategic button pressing and configuration toggling.],
  [Ignored official documentation when it conflicted with observed reality, choosing success over theory],
  [Accidentally discovered hidden features, legacy modes, and forbidden settings while attempting unrelated tasks],
  [Declared the system stable after achieving success three times in a row and immediately moved on]
)

#resume_heading("Projects")

#project_item(
  name: "Thing That Shouldn’t Have Worked but Did Anyway",
  skills: "link.to/alleged-proof",
  [Designed and implemented a system with minimal planning, unclear constraints, and no real world applications],
  [Conducted the majority of debugging during late-night sessions fueled by caffeine, spite, and a lot of chatgpt],
  [Achieved a fully working state after multiple near-death moments and promptly froze the codebase],
  [Referenced this project frequently despite never touching it again]
)

#project_item(
  name: "Overengineered Solution to a Mild Inconvenience",
  skills: "link.to/cope",
  [Applied a lot of abstractions and config options to a problem that could have been solved manually],
  [Justified every design decision with phrases like “future-proofing” and “scalability” regardless of actual need],
  [Added optional features that became mandatory due to emotional attachment],
  [Defended the architecture passionately in discussions no one wanted to have]
)

#project_item(
  name: "Side Project That Gradually Replaced My Personality",
  skills: "link.to/identity-crisis",
  [Originally started as a learning exercise before expanding uncontrollably into a full-fledged obsession],
  [Underwent multiple full rewrites prompted by minor inconveniences and/or aesthetic dissatisfaction],
  [Remains technically unfinished but spiritually complete]
)

#project_item(
  name: "Group Project I Publicly Shared and Privately Solo’d",
  skills: "trust.me.bro",
  [Quietly resolved last-minute failures to ensure deadlines were met and presentations appeared smooth],
  [Allowed credit to be distributed evenly to preserve social harmony and reduce meeting length],
  [Gained invaluable character development and trust issues]
)

#resume_heading("Technical Skills")

#skill_item(
  category: "Languages: ",
  skills: "Language A, Language B, Language C, That One Scripting Language"
)

#skill_item(
  category: "Tools: ",
  skills: "Tool 1, Tool 2, Tool 3, StackOverflow, Random GitHub Gist from 2016"
)

#skill_item(
  category: "Protocols: ",
  skills: "Protocol X, Protocol Y, Handshakes, Timeouts, Vibes, Hope"
)

#skill_item(
  category: "Lab Equipment: ",
  skills: "Oscilloscope (broken), Breadboard with Loose Wires, Laptop Running on 2% Battery"
)
