#import "@preview/showybox:2.0.4": showybox
#set page(flipped: true, margin: 40pt, columns: 3)
#set text(size: 8pt)

#place(top + center, scope: "parent", float: true)[
  #smallcaps()[#text(size: 12pt, weight: "bold")[*Computer Networks*]]
]

#let theory(title, body) = context [
  #showybox(
    frame: (
      border-color: blue,
      title-color: blue,
      body-color: white,
      radius: 0pt,
    ),
    title-style: (
      color: white,
      weight: "bold",
      align: left,
      // boxed-style: (
      //   radius: 4pt,
      // ),
    ),
    title: [#smallcaps()[#title]],
  )[#body]
]

#let topic(name) = [
  #grid(columns: 3, column-gutter: 4pt, align: horizon)[#line(length: 100%)][
    #smallcaps()[#text(size: 6pt, weight: "bold")[*#name*]]
  ][
    #line(length: 100%)
  ]
  #v(-1mm)
]

#theory("Definitions")[
  - *Computer Network*: Group of interconnected devices.
  - *Telecommunication*: Communication at a distance.
  - *Data*: Processed information. (in this context)
]

#theory("Types of Networks")[
  #topic("Geo Coverage")
  - *Personal Area Network (PAN)*: Very small area, e.g., Bluetooth.
  - *Local Area Network (LAN)*: Small area, high speed, e.g., home, office.
  - *Metropolitan Area Network (MAN)*: City-wide network, e.g., cable TV network.
  - *Wide Area Network (WAN)*: Large area, e.g., internet.
]

#theory("Topologies")[
  Arrangement of nodes in a network.
  - *Bus*: Single central cable (bus). Easy to install, but hard to troubleshoot.
  - *Star*: Central hub with nodes connected. Easy to manage, but hub failure affects all.
  - *Ring*: Nodes connected in a circle. Data travels in one direction, but a break can disrupt the network.
  - *Mesh*: Every node connected to every other. High redundancy, but expensive.
]

