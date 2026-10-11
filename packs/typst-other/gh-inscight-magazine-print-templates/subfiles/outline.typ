#import "/template-files/inscight-template.typ": *

#prettyOutline(
  issueDetails: yaml("/dataFiles/issueData.yml"),
  spacing: 0.8em,
  splitAt: (60,)
)
