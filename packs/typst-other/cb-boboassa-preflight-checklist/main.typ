#import "template/template.typ" as cl

#show link: set text(fill: blue, weight: 700)
#show link: underline
#let horizontal = true

#set page("a4", flipped: horizontal, margin: (y: .4in, x: .5in))

#show: cl.checklist.with(
  title: "BN Islander Checklist",
  version: "0.2.0",
  disclaimer: "This checklist is for hobby purposes only and should not be used in real life.",
  style: 1,
  horizontal: horizontal,
)

#cl.topic("Normal Operations")[
  #cl.section("Power Up")[
    #cl.step("Walkaround", "Performed")
    #cl.step("Battery Master", "On")
    #cl.step("Beacon", "On")
    #cl.step("NAV Lights", "On")
    #cl.step("Throttle", "Closed")
    #cl.step("Prop", "Full Forward")
    #cl.step("Mixture", "Full Forward")
    #cl.step("External Supply", "On")
    #cl.step("Fuel Selectors", "On")
    #cl.step("Fuel Pumps", "On")
    #cl.step("Throttle", "10%")
    #cl.step("STBD MAGS", "No. 1")
    #cl.step("Starter", "STBD")
    #cl.step("STBD MAGS", "No. 2")
    #cl.step("Throttle", "1.000 RPM")
    #cl.step("PORT MAGS", "No. 1")
    #cl.step("Starter", "PORT")
    #cl.step("PORT MAGS", "No. 2")
    #cl.step("Throttle", "1.000 RPM")
  ]

  #colbreak()
  #cl.section("Taxi")[
    #cl.step("Parking Brake", "Release")
  ]

  #cl.section("Pre Takeoff")[
    #cl.step("Flaps", "Set")
    #cl.step("Trim", "T/O (0)")
    #cl.step("Heating", "As Required")
  ]

  #cl.section("Takeoff")[
    #cl.step("Throttle", "Full")
    #cl.step("Prop", "Full Forward")
    #cl.step("Mixture", "Full Forward")
  ]

  #cl.section("After Takeoff")[
    #cl.step("Flaps", "Up")
    #cl.step("Landing Lights", "Off")
    #cl.step("Heating", "As Required")
  ]

  #cl.section("Cruise")[
    #cl.step("Prop", "83%")
    #cl.step("Mixture", "70%")
    #cl.step("Throttle", "RPM in Green")
  ]

  #colbreak()

  #cl.section("Shutdown")[
    #cl.step("Parking Brake", "Set")
    #cl.step("Avionics Master", "Off")
    #cl.step("External Lights", "Beacon & NAV")
    #cl.step("Heating", "Off")
    #cl.step("Right Engine Mixture", "Off")
    #cl.step("Left Engine Mixture", "Off")
    #cl.step("Prop", "Off")
    #cl.step("Throttle", "Off")
    #cl.step("MAGS", "Off")
    #cl.step("Fuel Selectors", "Off")
    #cl.step("Beacon & NAV", "Off")
    #cl.step("Generators", "Off")
    #cl.step("Battery", "Off")
  ]
]

#cl.emer-page(black-and-white: false)[
  #cl.topic("Emergency Procedures")[
    #cl.section("Fire")[
      #cl.step("Fire Extinguisher", "Activate")
      #cl.step("Windows", "Close")
      #cl.wait-separator()

      If fire completely extinguished
      #linebreak()
      #cl.step("Windows", "Open")
    ]
  ]]

#cl.topic("A Normal topic")[
  #cl.section("A Normal section")[
    #cl.step("Parking Brake", "Set")
    #cl.step("Avionics Master", "Off")
    #cl.step("External Lights", "Beacon & NAV")
    #cl.step("Heating", "Off")
    #cl.step("Right Engine Mixture", "Off")
    #cl.step("Left Engine Mixture", "Off")
    #cl.step("Prop", "Off")
    #cl.step("Throttle", "Off")
    #cl.step("MAGS", "Off")
    #cl.step("Fuel Selectors", "Off")
    #cl.step("Beacon & NAV", "Off")
    #cl.step("Generators", "Off")
    #cl.step("Battery", "Off")
  ]
]
