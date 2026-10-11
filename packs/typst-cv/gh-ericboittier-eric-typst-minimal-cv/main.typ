#import "@preview/minimal-cv:0.2.0": *

// Optional document metadata.
#set document(
  title: "Curriculum Vitae",
  author: "Eric Boittier <eric.boittier@icloud.com>",
  keywords: ("cv", "resume"),
  date: datetime(year: 2025, month: 3, day: 16),
)


// Right margin: used for page and to push Contact box into corner (dx = margin = flush right)
#let page-margin-right = 35pt
#set page(
  margin: (
    left: 47pt,
    right: page-margin-right,
  ),
)


// Learn about theming at https://github.com/lelimacon/typst-minimal-cv
#show: cv.with(
  theme: (
    font-size: 12pt,
    spacing: 17pt,
  )
)

// Alternate theming used in several areas.
#let accent-theme = (
  accent-color: maroon,
  body-color: maroon,
)

#block[
  // #par[]
  #v(5pt)
  = Eric Boittier, Ph.D.
  #v(5pt)
  == Scientific Software Architect -- Deep Learning Applications
  #v(5pt)
  
  #place(top + right, dx: 55pt, dy: -62pt)[
    #block(
      width: 200pt,
      fill: white,
      inset: 8pt,

      section(
        theme: (
          font-size: 10pt,
          accent-color: rgb("888"),
          gutter-body-color: rgb("888"),
          body-color: rgb("888"),
          section-style: "outlined",
          spacing: 10pt,
        ),
        [Contact],
        {
          entry(
            [Location],
            [Arlesheim, BL 4144],
            none,
          )
          entry(
            [Phone],
            [+4176 234 35 81],
            none,
          )
          entry(
            [Email],
            link("mailto:eric.boittier\u{40}icloud.com", [eric.boittier\u{40}icloud.com]),
            none,
          )
          entry(
            [Languages],
            [English (native), German (B2)],
            none,
          )
        }
      )
    )
  ]
]


#grid(
  columns: (6fr, 12pt, 3.4fr),

  // Left column.
  {

    show: theme.with(
      gutter-width: 26pt,
      section-style: "underlined",
    )


    section(
      [Professional Experience],
      {
        entry(
          // theme: accent-theme,
          right: [*\@Uni. Basel* -- Basel, CH],
          chronology(start: "2020", end: "2026"),
          [#text(fill: maroon)[Researcher]],
          [
            Deep learning on graph-structured data, chemistry
            #list(
              [Designed, trained, and validated deep learning models],
              [1st place in HYDRA Spectroscopy Prediction Challenge],
              [Peer reviewer, Journal of Chemical Physics],
            )
          ]
        )
        entry(
          right: [*\@TRI* -- Brisbane, AU],
          chronology(start: "2019", end: "2020"),
          [#text(fill: maroon)[Research Assistant]],
          [
            #par[Small-molecule \& biomolecular modelling, Schrödinger software suite, OpenMM  ]
            #list(
              [Designed, supervised, and authored research on structure- and ligand-based design],
              [Collaborated with multidisciplinary experts, building end-to-end data science solutions in Python and R],
            )
          ]
        )
      }
    )

    section(
      [Education],
      {
        entry(
          // theme: accent-theme,
          right: [*\@Uni. Basel* -- Basel, CH],
          chronology(start: "2020", end: "2025"),
          [#text(fill: maroon)[Doctor of Philosophy, Chemistry]],
          [#par[`Molecular Deep Learning for Quantitative Simulations and Electrostatic Models`]],
        )
        entry(
          right: [*\@Uni. Queensland* -- Brisbane, AU],
          chronology(start: "2015", end: "2020"),
          [#text(fill: maroon)[Bachelor of Advanced Science, Chemistry]],
          [#par[`Development of Computational Tools for the Rational Design of Glycosaminoglycan Mimetics`]],
        )
      }
    )

  },

  // Empty space.
  {},

  // Right column.
  {
    show: theme.with(
      // gutter-width: 46pt,
      section-style: "underlined",
    )



    section(
      theme: (gutter-width: 78pt),
      [Skills \& Competencies],
      {
        entry(
          [Programming],
          [Python, Julia, R, Fortran, C++, OpenMPI, CUDA],
          none,
        )
        entry(
          [Machine Learning],
          [JAX, TensorFlow, PyTorch, scikit-learn, NumPy],
          none,
        )
        entry(
          [DevOps],
          [Git, CI/CD, Docker],
          none,
        )
        entry(
          [Data Science],
          [SQL, Polars, Pandas],
          none,
        )
      }
    )

    section(
      theme: (gutter-width: 42pt),
      [Invited Technical Talks],
      {
        entry(
          [2024],
          none,
          [#par(justify: true)[*`Bridging Machine Learning Force Fields with Anisotropic Electrostatic Models`* \ #text(fill: maroon)[Swiss Chemical Society] \ #text(fill: maroon)[Machine~Learning Group] \ Lausanne, CH]],
        )
        entry(
          [2025],
          none,
          [#par(justify: true)[*`Mixing Machine Learned and Empirical Energy Functions`* \ #text(fill: maroon)[apoCHARMM Meeting NIH]  \ 
          Boston, US (Online)]],
        )
      }
    )

  },

)

#{
  show: theme.with(section-style: "underlined");
  section(
    [Open Source],
    [
      #par[Community-driven open-source contributions available on GitHub (\u{40}EricBoittier)]
      #grid(
        columns: (1fr, 1fr),
        gutter: 1em,
        [#list(
          [#text(fill: maroon)[Cheminformatics software] (RDKit) bug fixes for C++ and python bindings, attended User Group Meeting (Zurich, 2024) ],
          // [Computer vision tool for item tracking and inventory management for an online marketplace with Python/SQL],
          // [Frontend development for a literature carousel UI for browsing arXiv preprints, using React and Tailwind CSS],
        )],
        [#list(
          // [Cheminformatics software RDKit: bug fixes for C++ and python layers, hackathons and feature requests],
          [#text(fill: maroon)[Computer vision tool] (OpenCV) for item tracking and #text(fill: maroon)[inventory management] (SQL) for an online marketplace],
          // [Frontend development for a literature carousel UI for browsing arXiv preprints, using React and Tailwind CSS],
        )],
      )
    ]
)
}

// #block(
//   width: 100%,
//   fill: white,
//   inset: 8pt,
//   [Languages: English (native), German (B2)]
// )



