#import "template.typ": *

#show: resume.with( author: (
    name: "Grantham Taylor",
    email: "grantham@email.com",
    phone: "(123) 456-7890",
    linkedin: "granthamtaylor",
))

#section("Education")

  #organization("Fancy University, Some School of Business")
    #role("Master of Science in Quantitative Management", "2010 - 2014")

  #organization("Some University, An Undergraduate College")
    #role("Bachelor of Business Administration", "2000 - 2004")

#section("Experience")
  #organization("Big Corporation, Inc")

    #role("Principal Associate - Research Scientist", "June 2023 - Present")
      #content[
        - #lorem(30):
          - #lorem(30).
          - #lorem(30).
          - #lorem(30).
          - #lorem(30).
          - #lorem(30).
        - #lorem(30).
        - #lorem(30):
          - #lorem(30).
        - #lorem(30):
          - #lorem(30).
          - #lorem(30).
      ]

    #role("Senior Associate - Data Science", "May 2021 - June 2023")
      #content[
        - #lorem(30):
          - #lorem(30).
        - #lorem(30):
      ]

  #organization("Another Organization, LLC")
    #role("Associate - Data Science", "February 2020 - May 2021")
    #role("Senior Consultant - Data Science", "May 2019 - February 2020")

#section("Technical Skills")
  #skills("Engineering", (`git`, `kubernetes`, `python`, `julia`, `rust`, `javascript`, `scala`))
  #skills("Modeling", (`pytorch`, `lightning`, `optuna`, `katib`, `hydra`, `ray`))
  #skills("Orchestration", (`kubeflow`, `flyte`, `dvc`, `argo`, `metaflow`))
  #skills("Data", (`spark`, `sql`, `polars`, `torchdata`, `bytewax`, `kafka`))
  #skills("Documentation", (`justfile`, `draw.io`, `mermaid`, `markdown`, `typst`))
