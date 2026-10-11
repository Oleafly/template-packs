// ./typst compile --font-path fonts --input dark=false main.typ output-light.pdf && ./typst compile --font-path fonts --input dark=true  main.typ output-dark.pdf

#import "lib/mod.typ": project
#import "config.typ": meta, intro, parts, topics, sources
#import "@preview/codly:1.3.0": *
#show: codly-init.with()

#show: project.with(..meta, intro: intro, topics: topics, sources: sources)

#for part in parts [
  = #part.title
  #for chapter in part.chapters [
    #include chapter.path
  ]
]

#bibliography("citations.bib")
