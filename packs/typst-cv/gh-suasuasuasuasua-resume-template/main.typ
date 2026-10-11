#set text(font: "Libertinus Serif", size: 10pt)
#set page(paper: "a4", margin: 0.5in)
#set par(justify: true)
#set list(tight: true)

// Custom line function
#let chiline() = {
  v(-3pt)
  line(length: 100%)
  v(-6pt)
}

// Title
#align(center)[
  // Name
  #text(size: 2em, weight: "bold")[
    Lisan al-Gaib
  ] \
  // Refs
  #link("mailto:name@gmail.com")[name\@gmail.com]
  | #link("https://mitcommlab.mit.edu/meche/commkit/portfolio/")[portfolio.com]
  | #link("https://old.reddit.com/r/EngineeringResumes/wiki/index#wiki_portfolios")[github.com/name]
]

= Skills
#chiline()
#list(
  [*CAD:* Siemens NX, CATIA V5, SolidWorks],
  [*Analysis:* Thermal Desktop, Abaqus, LS-DYNA, STAR-CCM+],
  marker: [],
)

= Experience
#chiline()

*Job Title*, #link("https://www.fstl1992.com/")[Company] - City, ST #h(1fr) June 2022 - Present
- *STAR:* *S*;ituation *T*;ask *A*;ction *R*;esult:
  #link("https://www.levels.fyi/blog/applying-star-method-resumes.html",)[#underline[article 1];];,
  #link("https://resumegenius.com/blog/resume-help/star-method-resume")[#underline[article 2];]
- *STAR:* Situation Task Action Result
- *STAR:* Situation Task Action Result
- *STAR:* Situation Task Action Result
- *STAR:* Situation Task Action Result

*Job Title,* #link("https://www.fstl1992.com/")[Company] - City, ST #h(1fr) Jan 2021 - May 2022
- *XYZ:* Accomplished *X* as measured by *Y* by doing *Z*;:
  #link( "https://www.inc.com/bill-murphy-jr/google-recruiters-say-these-5-resume-tips-including-x-y-z-formula-will-improve-your-odds-of-getting-hired-at-google.html",)[#underline[article 1];];,
  #link("https://elevenrecruiting.com/create-an-effective-resume-xyz-resume-format/")[#underline[article 2];]
- *XYZ:* Accomplished X as measured by Y by doing Z
- *XYZ:* Accomplished X as measured by Y by doing Z
- *XYZ:* Accomplished X as measured by Y by doing Z

*Job Title,* #link("https://www.fstl1992.com/")[Company] - City, ST #h(1fr) Aug 2014 - Sept 2020
- *CAR:* *C*;hallenge *A*;ction *R*;esult:
  #link("https://ca.indeed.com/career-advice/resumes-cover-letters/challenge-action-result-resume",)[#underline[article 1];];,
  #link("https://www.topresume.com/career-advice/how-to-get-more-results-with-a-car-resume")[#underline[article 2];]
- *CAR:* Challenge Action Result
- *CAR:* Challenge Action Result
- *CAR:* Challenge Action Result

*Job Title,* #link("https://www.fstl1992.com/")[Company] - City, ST #h(1fr) June 2014 - July 2014
- Start each bullet with a
  #link("https://old.reddit.com/r/EngineeringResumes/wiki/index#wiki_action_verbs")[#underline[strong, past-tense action verb];]
- Having trouble coming up with content for your bullet points? Read these:
  #link("https://old.reddit.com/r/EngineeringResumes/wiki/index#wiki_having_trouble_coming_up_with_content_for_your_bullet_points.3F_ask_yourself_the_following_questions.3A",)[#underline[link 1];];,
  #link( "https://old.reddit.com/r/EngineeringResumes/wiki/index#wiki_got_writer.27s_block_from_looking_at_star.2Fcar.2Fxyz.3F",)[#underline[link 2];];,
  #link("https://archive.ph/Xmdqt")[#underline[link 3];];,
  #link("https://old.reddit.com/r/EngineeringResumes/wiki/sample-bullet-points")[#underline[link 4];]
- Each bullet point should be 1-2 lines long and max 1 sentence long.
  Use #link("https://quillbot.com/")[#underline[Quillbot];];,
  #link("https://languagetool.org/paraphrasing-tool")[#underline[LanguageTool];];,
  and #link("https://hemingwayapp.com/")[#underline[Hemingway Editor];]
  to help you #link("https://www.youtube.com/watch?v=VvPaEsuz-tY")[paraphrase and shorten them]
- Don't let bullets spill onto the next line with only 1-4 words on it, it's a
  huge waste of space #link("https://imgur.com/QCcZ792")

= Projects
#chiline()

*Project Title* #h(1fr) #link("https://github.com/matiassingers/awesome-readme")[github.com/name/project]
- The more work experience you have, the less relevant outside-work projects tend
- If you have something that really stands out, consider listing it here

*Project Title* #h(1fr) #link("https://mitcommlab.mit.edu/meche/commkit/portfolio/")[project.com]
- Only list real projects, not mandatory school projects or trivial tutorial
  projects found online
- Something that someone uses to solve a problem
- Something that has users (can be just you, as long as you use it often) and is
  actively maintained and not just rotting in a GitHub repo, never to see a PR
  for the rest of its life

*Project Title* #h(1fr) #link("https://www.hardwareishard.net/portfolio-database")[blog.com/projectname]
- Resume checklist:
  #link("https://old.reddit.com/r/EngineeringResumes/wiki/checklist")
- Google Docs version of this template:
  #link("https://docs.google.com/document/d/1MBvhATv8y-ESORopRoLSZ3f3HjkM_Qa_f8fIHAEqgnI/edit")

= Education
#chiline()

#list(
  [*#link("https://www.southharmoninstituteoftechnology.org/")[School];* - PhD in Mechanical Engineering #h(1fr) May 2010],
  [*#link("https://www.southharmoninstituteoftechnology.org/")[School];* - MS in Mechanical Engineering #h(1fr) June 2006],
  [*#link("https://www.southharmoninstituteoftechnology.org/")[School];* - BS in Mechanical Engineering #h(1fr) Apr 2004],
  marker: [],
)
