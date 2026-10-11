#import "/libs/charts/aw_diagram.typ": attack_chain_diagram
#import "@preview/fletcher:0.5.8" as fletcher: diagram
#import fletcher.shapes: rect, circle, ellipse, pill, parallelogram, trapezium, diamond, triangle, house, chevron, hexagon, octagon

// you can set color or shape keys to "none" to use the defaults 
// default colour: as assigned by template
// default shape for stage titles: ellipse

#let attack_chain_stages = (
  (
    name: "Connect to Network",
    color: blue,
    shape: diamond,
    steps: (
      [Authentication\ Relaying],
      [Name Resolution\ Poisoning],
      [DHCPv6\ Poisoning],
    )
  ),
  (
    name: "Gaining Initial Access",
    color: green,
    shape: none,
    steps: (
      ([Captured user hash],  [Cracked password]),
      [Created Machine account],
    )
  ),
  (
    name: "Low Privileged Access",
    color: yellow,
    shape: none,
    steps: (
      [ADCS ESC1],
      [ADCS ESC8])
  ),
  (
    name: "Domain Admin Access",
    color: red,
    shape: none,
    steps: (
      ([Dump NTDS],[Cracked offline\ Passwords]),
      ([Extracted M365 Creds], [Obtained list\ of Global Admins]))
  ),
  (
    name: "Global Admin Access",
    color: purple,
    shape: diamond,
    steps: ()
  ),
  
)

// The diagram itself is below
#[
  #set par(justify: false)

  #align(center, box(
    stroke: gray, //border
    inset: 2mm, //padding
    scale(
      x: 80%, //scale whole diagram horizontal within box
      y: 80%, //scale whole diagram vertical within box
      origin: center + horizon, 
      reflow: true,
      diagram(
        spacing: (4em, 1.2em), //wide columns, shorter rows
        attack_chain_diagram(attack_chain_stages)
        ))
  ))
]
