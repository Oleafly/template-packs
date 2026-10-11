#import "/layout/thesis_template.typ": *
#import "/metadata.typ": *

#set document(title: titleEnglish, author: author)

#show: thesis.with(
  title: titleEnglish,
  degree: degree,
  program: program,
  supervisor: supervisor,
  author: author,
  submissionDate: submissionDate,
  university: university,
  location: location,
  abstract_en: "",
  abstract_de: "",
  preface: include "/content/preface.typ",
  //acknowledgement: include "/content/acknowledgement.typ",
  glossary: include "/content/glossary.typ",
  transparency_ai_tools: include "/content/transparency_ai_tools.typ",
)

#include "/content/1_introduction.typ"
#include "/content/2_background.typ"
#include "/content/3_concept_system_design.typ"
#include "/content/4_implementation.typ"
#include "/content/5_conclusion.typ"