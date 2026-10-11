#import "@preview/cheq:0.4.0": checklist

#show: checklist

#let data = (
  number: "0N",
  title: "lab name",
  course: "IS",
  course-number: "1004",
  section: "904",
  author: "first last",
  abc123: "abc123",
  date: datetime.today().display("[month]-[day]-[year]"),
  read-directions: false // set to true to make the directions box disappear
)

#set page(footer: context [
  #set text(rgb("#999999"))
  #show text: it => {
    align(center)[#it]
  }
  
  #(data.course + "-" + data.course-number + " Lab Report Template - Fall 2026 | Page " + counter(page).display())
])

#let directions-box = [#rect(fill: rgb("#f4f4ff"), stroke: rgb("#05004d"), width: 100%)[
  #show heading: set text(rgb("#05004d"))

  === HOW TO USE THIS TEMPLATE — PLEASE READ FIRST
  
  *This template is required.* Every lab report must be written in this template. A report submitted outside the template will be returned for resubmission.

  *The text under each heading is instructions to you.* Replace or delete it as you write; none of it should remain in your finished report.

  *Match the breakpoints to your lab.* Your lab must have only five breakpoints to correlate to the five steps in each lab. The breakpoints should contain the deliverables listed in the “Breakpoint” section of each step.

 === Every breakpoint needs three things:
 
  #enum(numbering: "1)",
    [
      a summary of the breakpoint’s goal and your process, in two to four sentences and in your own words; 
    ],
    [
      answers to every question asked in that breakpoint’s instructions; and 
    ],
    [
      your own screenshots, each with at least one narrative sentence above it and a Figure number and caption below it (References tab → Insert Caption).
    ]
  )

  Every screenshot must show the final state your text describes — if you change anything after writing, re-capture it. Only include an image when you have something to say about it; an image with no explanation and caption is not needed.

  *Your own choices are what earn the points.* Wherever a breakpoint asks you to make a choice and explain it — your example, your setting, your search, your file — that answer is graded on being yours. There is no single correct response, and no two reports should look alike. A generic answer that could have come from anyone is not sufficient.

  *Submit a .docx file* named lastname-abc123-IS1003_Lab-XX.docx, where abc123 is your myUTSA ID and XX is the lab number. 

  *Keep the Submission Checklist and Attestation* at the end of your report. Delete this box and all templated text before you submit. This is your lab report, and so, only include your work!
]]

#if not data.read-directions {
  show: directions-box
}

#align(center)[= Lab #data.number -- #data.title]

*Name:* #data.author

*Course/Section:* #(data.course + "-" + data.course-number + "-" + data.section)

*Date:* #data.date

*File name:* #(data.author.split().at(1) + "-" + data.abc123 + "-" + data.course + data.course-number + "_Lab" + data.number + ".docx")

=== Introduction

Replace this sentence with an introduction to this lab: an overview of the lab's goals in two or three complete sentences and in your own words, plus one or two sentences on what you expect to be challenging or interesting and why. *Write this section before you start the lab* — you will look back at it in your Limitations/Conclusion.

=== Breakpoint 1
Replace this text with your report for this breakpoint. Keep the blue box's advice on page 1 in mind. 

=== Breakpoint 2
Replace this text with your report for this breakpoint. Keep the blue box's advice on page 1 in mind. 

=== Breakpoint 3
Replace this text with your report for this breakpoint. Keep the blue box's advice on page 1 in mind. 

=== Breakpoint 4
Replace this text with your report for this breakpoint. Keep the blue box's advice on page 1 in mind. 

=== Breakpoint 5
Replace this text with your report for this breakpoint. Keep the blue box's advice on page 1 in mind. 

=== Limitations/Conclusion

Replace this text with a reflective summary of your process in this lab. In complete sentences, answer all four:

#list(
  [
    What challenges did you encounter and/or what most interested you about this lab?
  ],
  [
    How did you address your challenges and/or what additional research did you do?

  ],
  [
    How might you use the skills and concepts of this lab going forward?

  ],
  [
    Were the challenges you anticipated in your Introduction the ones you actually met? What surprised you?
  ]
)

=== References

First, cite the lab instructions, as shown in reference [1] below (replace the lab number, title, and access date). You may use Zotero Bib (zbib.org) to format citations — choose the “IEEE” style from its style menu.

[1] R. Mitra, “Lab-XX Title Instructions,” The University of Texas at San Antonio, San Antonio, TX, USA, 2026. Accessed: May 30, 2026.

Then, list every source that helped you — sites that explained a concept, helped you troubleshoot, etc. Here is an example of an online reference in IEEE style. 

[2] C. Martin, “How to spot and block scam texts on your iPhone,” AppleInsider, Jan. 12, 2025. Accessed: August 1, 2026. [Online]. Available: #link("https://appleinsider.com/articles/25/01/12/psa-text-scammers-resorting-to-new-tactics-to-get-you-to-enable-phishing-links") Only leave your references in this section and delete everything else!

=== Generative AI Citations

This disclosure is made in the spirit of transparency and to acknowledge the role of AI, if any, in the creation process. In creating this lab report, how did you use generative AI? Select all that apply.

- [ ] I asked an AI assistant to troubleshoot a technical problem with me.
- [ ] I asked an AI assistant to explain a concept or process to me.
- [ ] I asked an AI assistant to check my work against the lab rubric.
- [ ] I asked an AI assistant to check my grammar and punctuation.
- [ ] I used an AI assistant for a task the lab instructions required (for example, generating a practice artifact, brainstorming, or stress-testing my own work).
- Other (please describe):  #underline[Description]
Or, if you used none of the above:
- [ ] I did not collaborate with a generative AI assistant.
If you used generative AI, include one example prompt that is representative of how you used it, cited in IEEE format and continuing the same numbering as your References. You are welcome to cite more. Where a breakpoint asks you to include a specific prompt and its response, include it there as well.

[\#] \<AI tool\> [\<model\>], response to “\<prompt\>,” \<company\>, \<date of model update\>. Accessed: \<date\>. [Online]. Available: \<link\>

Here is an example of a prompt cited using Anthropic Claude:

[3] Anthropic Claude [Sonnet 4.6], response to “I would like to share best password practices with my family. What are current views on how to create a strong password?,” Anthropic, Feb. 17, 2026. Accessed: August 1, 2026. [Online]. Available: https://claude.ai/

=== Collaboration

Replace this text with an explanation of any work you completed with a peer, tutor, instructor, or relative, including any tips or advice you found helpful along the way.
If you worked entirely alone, that's perfectly fine — simply state so with a sentence such as the following: I worked independently on this lab.

=== Submission Checklist

Check each box before you submit, and keep this section and the Attestation in your report.
- [ ] Every Step/Breakpoint in the lab instructions appears above with its number and a descriptive heading.
- [ ] There are one or two introductory sentences under every heading, and all text is in complete sentences.
- [ ] Every figure has narrative in complete sentences above it and a figure number and caption below it (using Insert Caption).
- [ ] Every screenshot is my own and shows the final settings, queries, or results that my text describes.
- [ ] My writing and examples are my own — not restatements of the walkthrough’s examples.
- [ ] Inline IEEE citations appear in my text, and my references are numbered in the order first cited.

=== Attestation

By submitting this report, I affirm that it describes work I performed myself on my own device(s), that the writing and examples in it are my own, and that all generative AI use is cited above. The final output accurately reflects my understanding, expertise, and intended meaning, and I maintain full responsibility for the content, its accuracy, and its presentation. I understand that I may be asked to demonstrate any breakpoint of this lab for my instructor or a tutor.

*Typed name and date:* #data.author, #data.date