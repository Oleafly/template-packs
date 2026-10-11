#import "@preview/cetz:0.4.0"
#import "@preview/gantty:0.4.0": gantt

= Project Overview <introduction>


== Presentation of the host company


=== General information

Lorem Ipsum is a company. Their official logo is shown in @company_logo.

#figure(
  image(
    "/images/logos/company.png",
    alt: "Logo of Lorem Ipsum GmbH",
    width: 30%
  ), 
  caption: [Logo of Lorem Ipsum GmbH], 
  gap: 1.75em
) <company_logo>

=== Mission and vision

#lorem(50)

=== Organization and team structure

#lorem(50). The organization chart is displayed below in @company_org_chart.

#let org = (
  (lorem(2), lorem(2), lorem(2), lorem(2))
).map(dept => rect[#dept])

#figure(
  cetz.canvas({
    import cetz.draw: *
  
    set-style(
      content: (padding: 1),
      fill: gray.lighten(70%),
      stroke: black
    )
  
    cetz.tree.tree(
      org, 
      spread: 5,
      grow: 3,
      draw-node: (node, ..) => {
        content((), node.content)
      },
      draw-edge: (from, to, ..) => {
        line(
          (a: from, number: .8, b: to),
          (a: to, number: .8, b: from),
          mark: (end: ">"))
      }
    )
  }),
  caption: [Organizational structure of Lorem Ipsum],
)
<company_org_chart>

=== Market position and partnerships

#lorem(50)

#lorem(50)

== Project context

=== Origins and motivation

#lorem(50)

#lorem(50)

#lorem(50)

=== Problem statement

#lorem(50) 

#lorem(50) 

=== Contribution

#lorem(50)

#lorem(50)

=== Key challenges

#lorem(50)

#lorem(50)

#lorem(50)

#lorem(50)

=== Project requirements

#lorem(30)

==== Functional requirements

+ *Verb of action* — #lorem(10).
+ *Verb of action* — #lorem(10).
+ *Verb of action* — #lorem(10).
+ *Verb of action* — #lorem(10).
+ *Verb of action* — #lorem(10).
+ *Verb of action* — #lorem(10).
+ *Verb of action* — #lorem(10).
+ *Verb of action* — #lorem(10).

==== Non-Functional requirements

+ *X-ability* — #lorem(10).
+ *X-ability* — #lorem(10).
+ *X-ability* — #lorem(10).
+ *X-ability* — #lorem(10).
+ *X-ability* — #lorem(10).
+ *X-ability* — #lorem(10).
+ *X-ability* — #lorem(10).

== Work methodology

#lorem(500)

== Internship journal

#figure(
  gantt(yaml("/other/gantt.yaml")),
  caption: [Internship journal]
) <gantt_diagram>

The timeline shown in @gantt_diagram summarizes the main phases of the internship. 
The initial onboarding phase focused on orientation, setting up the work environment, and a simple introductory task to become familiar with the company’s tools and practices.

After this, the work unfolded across four sprints:  
+ The *Spring Sprint*, already ongoing at the internship’s start, was marked by work on basic documentation tasks.  
+ The *Mid-Spring Sprint* focused on a small feature update and routine bug fixing.  
+ The *Summer Sprint* centered on cleaning up the interface and improving ease of use.  
+ Finally, the *Final Sprint* was dedicated to making improvements to the @ci-cd pipeline, wrapping up tasks, preparing a short internal presentation, and completing the internship project.

