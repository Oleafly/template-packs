#import "@preview/touying:0.7.3": *
#import "c3_typst_template.typ": *
#import "@preview/numbly:0.1.0": numbly

#show: c3-theme.with(
  aspect-ratio: "16-10",
  config-info(
    title: [C3 Typst Template Demo],
    short-title: [C3 Typst Template],
    author: [Jacob],
    institution: [C3 Robotics Laboratory#linebreak()Department of Mechanical and Automation Engineering#linebreak()The Chinese University of Hong Kong],
  ),
)

#set heading(numbering: numbly("{1}.", default: "1.1"))

#title-slide()
#outline-slide(level: 1)

= Structure

== Message Slide

#slide(title: [1.1 Message-first slide])[
  #text-panel[
    Start with the short claim the audience should retain.
    The template keeps prose compact, uses a softer panel background, and leaves enough white space for equations or images to breathe.
  ]

  #v(0.12cm)
  #eq-panel[
    $ y = f(x; theta) + epsilon $
  ]

  #v(0.12cm)
  #tblock(title: [Takeaway])[
    Use a single strong statement when the slide is mostly explanatory.
  ]
]

== Split Evidence

#slide(title: [1.2 Split evidence layout])[
  #grid(
    columns: (0.88fr, 1.12fr),
    column-gutter: 0.42cm,
    [
      #text-panel[
        Two-column slides work best when the left side carries interpretation and the right side carries evidence.
        The spacing mirrors the denser analytical deck style without copying its defect-specific content.
      ]
      #v(0.12cm)
      #eq-panel[
        $ Delta = op("measure") - op("baseline") $
      ]
    ],
    [
      #pair-card(
        "c3_template_media/image4.png", [C3 Robotics Laboratory],
        "c3_template_media/image1.png", [The Chinese University of Hong Kong],
        height: 4.1cm,
      )
    ],
  )
]

= Components

== Figure Cards

#slide(title: [2.1 Figure card rhythm])[
  #text-panel[
    Reusable figure cards standardize image fitting, caption scale, and column gutters.
    This keeps mixed visual material aligned across a research update or group-meeting deck.
  ]

  #v(0.16cm)
  #triple-card(
    "c3_template_media/image4.png", [Lab],
    "c3_template_media/image3.jpeg", [Center],
    "c3_template_media/image2.png", [Department],
    height: 4.3cm,
  )
]

== Progressive Content

#slide(title: [2.2 Progressive content])[
  #text-panel[
    Touying pauses remain available for incremental explanation.
  ]

  #v(0.18cm)
  First idea appears immediately.
  #pause

  #v(0.18cm)
  Second idea appears after a pause.
  #meanwhile

  #v(0.18cm)
  Meanwhile content can synchronize related details.
]

#focus-slide[
  Keep the slide doing one job.
]

#show: appendix

= Appendix

== Backup

#slide(title: [A.1 Backup slide])[
  #text-panel[
    Appendix slides keep the same grid, panel, and footer system as the main deck.
  ]
]
