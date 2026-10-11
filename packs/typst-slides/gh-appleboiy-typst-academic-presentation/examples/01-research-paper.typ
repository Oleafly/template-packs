#import "@preview/touying:0.5.5": *
#import "@preview/clean-math-presentation:0.1.1": *
#import "../lib/lib.typ": *

#show: clean-math-presentation-theme.with(
  config-info(
    title: [Research Paper Presentation: \ Knowledge Graph-Driven Testing],
    short-title: [KG Testing],
    authors: ((name: "Research Team", affiliation-id: 1),),
    author: "Research Team",
    affiliations: ((id: 1, name: "University Research Lab"),),
    date: datetime.today(),
  ),
  config-common(slide-level: 2),
  progress-bar: true,
)

#title-slide(
  logo1: image("../images/logo_placeholder.svg", height: 4.5em),
)

= Introduction

#slide(title: "Research Problem")[
  #slide-content[
    Traditional autonomous driving system (ADS) testing relies on manually crafted scenarios, which limits edge-case discovery and scalability.

    #v(1em)

    #paper-insight[
      Manual test creation yields only 45 edge cases per 500 scenarios, creating a critical coverage gap in safety validation.
    ]

    #v(1em)

    Our approach: Leverage Knowledge Graphs and LLMs to automatically generate realistic accident scenarios at scale.
  ]
]

#slide(title: "Methodology Overview")[
  #slide-content[
    #slide-split(
      [
        *Three-Phase Pipeline:*

        + Extract accident data from reports
        + Cluster scenarios using DBSCAN
        + Generate test cases via LLM

        #v(1em)

        Each phase builds upon structured semantic relationships stored in the Knowledge Graph.
      ],
      [
        #paper-figure(
          image("../images/diagram_placeholder.svg", fit: "contain"),
          caption: [System architecture]
        )
      ]
    )
  ]
]

= Algorithm

#slide(title: "Clustering Algorithm")[
  #slide-content[
    #paper-algorithm(
      name: "Density-Based Scenario Extraction",
      inputs: [Knowledge Graph $G$, radius $epsilon$],
      outputs: [Set of scenario clusters $C$],
      steps: (
        [Retrieve all nodes $n in G$ matching target ontology.],
        [Compute feature embeddings using LLM.],
        [Initialize spatial index (R-tree).],
        [*for each* unvisited node $x$ *do*:
          + *if* density $gt.eq$ `min_samples` *then* form cluster.],
        [*return* $C$.],
      )
    )
  ]
]

= Results

#slide(title: "Performance Metrics")[
  #slide-content[
    #grid(
      columns: (1fr, 1fr, 1fr),
      gutter: 16pt,
      paper-metric(
        title: "Scenario Gen. Time",
        value: "1.2s",
        subtext: "Down from 45.0s"
      ),
      paper-metric(
        title: "Edge Case Discovery",
        value: "+340%",
        subtext: "Novel topologies"
      ),
      paper-metric(
        title: "Coverage",
        value: "93%",
        subtext: "Test suite coverage"
      )
    )
  ]
]

#slide(title: "Comparative Analysis")[
  #slide-content[
    #figure(
      caption: [Edge case discovery rate comparison],
      academic-bar-chart(
        data: (
          ("Random", 45),
          ("Rule-Based", 210),
          ("Proposed", 465)
        ),
        max-value: 500,
        chart-height: 140pt,
        bar-width: 50pt
      )
    )
  ]
]

= Conclusion

#slide(title: "Key Contributions")[
  #slide-content[
    + Novel KG+LLM architecture for automated test generation
    + 10× improvement in edge-case discovery
    + Scalable pipeline for continuous integration

    #v(2em)

    #paper-insight[
      By leveraging semantic relationships in accident data, we enable systematic exploration of the ADS operational design domain.
    ]
  ]
]
