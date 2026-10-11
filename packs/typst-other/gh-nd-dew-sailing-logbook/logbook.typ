#set page(
  paper: "a4",
  margin: (x: 1.5cm, y: 2.5cm),
  numbering: "1",
  header: context {
    if counter(page).get().first() > 1 {
      align(right)[
        #stack(
          dir: ttb,
          spacing: 2pt,
          align(center)[#image("favicon.png", width: 1cm)],
          align(center)[#text(font: "Libertinus Serif", style: "italic", weight: "bold", size: 12pt, fill: navy)[BSC]]
        )
      ]
    }
  },
  footer: context {
    let page_num = counter(page).get().first()
    if page_num > 1 {
      align(center)[#page_num]
    }
  },
  header-ascent: 20%,
)

#set text(
  font: "Libertinus Serif",
  size: 12pt,
)

#show heading: set text(navy)
#show heading.where(level: 1): set text(size: 16pt)
#show heading.where(level: 2): set text(size: 14pt)

// --- Configuration Variables ---
// You can quickly update all logbook details right here.
#let title = ""
#let yacht-model = ""
#let yacht-name = ""
#let mmsi = ""
#let call-sign = ""
#let home-port = ""
// Set to none to hide from cover page in blank template
#let start-date = none
#let end-date = ""
#let sailing-area = ""
#let charter-company = ""
#let version = "1.1.0"

#let captain = ""

#let crew = (
  "", "", "", "", "", "", "", "", "", "", "", "",
)

// Define Watch Assignments here for automatic filling
// Supports 3 members per officer (12 people total in rotation)
#let watch-assignments = (
  (officer: "", members: ("", "", "")),
  (officer: "", members: ("", "", "")),
  (officer: "", members: ("", "", "")),
)

// --- Cover Page ---
#v(-1em)
#align(center)[
  #text(size: 11pt, style: "italic")[The logbook of the project:] \
  #v(-1.2em)
  #text(size: 42pt, weight: "bold")[#if title == "" [Sailing Logbook] else [#title]]
]
  
#v(0.5em)
  
#grid(
  columns: (auto, 1fr), // Auto fits the longest label perfectly, 1fr takes the rest
  row-gutter: 0.6em,
  align: (right, left),
  column-gutter: 1.5em,
  [*Yacht:*], [#if yacht-model != "" or yacht-name != "" [#yacht-model #if yacht-name != "" ["#yacht-name"]] else [#box(width: 100%, repeat[#text(fill: luma(220))[.]])] ],
  [*MMSI:*], [#if mmsi != "" [#mmsi] else [#box(width: 100%, repeat[#text(fill: luma(220))[.]])] ],
  [*Call Sign:*], [#if call-sign != "" [#call-sign] else [#box(width: 100%, repeat[#text(fill: luma(220))[.]])] ],
  [*Home Port:*], [#if home-port != "" [#home-port] else [#box(width: 100%, repeat[#text(fill: luma(220))[.]])] ],
  [*Start Date:*], [#if start-date != none [#start-date.display("[month repr:long] [day], [year]")] else [#box(width: 100%, repeat[#text(fill: luma(220))[.]])] ],
  [*End Date:*], [#if end-date != "" [#end-date] else [#box(width: 100%, repeat[#text(fill: luma(220))[.]])] ],
  [*Sailing Area:*], [#if sailing-area != "" [#sailing-area] else [#box(width: 100%, repeat[#text(fill: luma(220))[.]])] ],
  [*Charter Company:*], [#if charter-company != "" [#charter-company] else [#box(width: 100%, repeat[#text(fill: luma(220))[.]])] ],
  [*Captain:*], [#if captain != "" [#captain] else [#box(width: 100%, repeat[#text(fill: luma(220))[.]])] ],
)
  
#v(0.5em)
  
#align(center)[
  #block(width: 80%, stroke: 0.5pt + luma(220), inset: 1em)[
    #align(left)[
      *Crew List:*
      #v(0.5em)
      #for (idx, person) in crew.enumerate() [
        #if person != "" [
          #(idx + 1). #person \
        ] else [
          #grid(
            columns: (auto, 1fr),
            [#(idx + 1). ], [#box(width: 100%, repeat[#text(fill: luma(220))[.]])]
          )
        ]
      ]
    ]
  ]
]

#v(1fr)
#align(center)[
  #block(breakable: false)[
    #image("favicon.png", width: 2.5cm)
    #v(0.2em)
    #text(size: 11pt, style: "italic")[Belgian Sailing Community]
    #v(0.1em)
    #text(size: 5pt, fill: luma(180))[v#version]
  ]
]


#pagebreak()

// --- Page 2: NATO Phonetic Alphabet ---
#heading(level: 1)[NATO Phonetic Alphabet]
#v(2em)

#align(center)[
  #table(
    columns: (1fr, 1fr),
    stroke: 0.5pt + luma(220),
    align: left + horizon,
    inset: 1.2em,
    [*A* - Alfa], [*N* - November],
    [*B* - Bravo], [*O* - Oscar],
    [*C* - Charlie], [*P* - Papa],
    [*D* - Delta], [*Q* - Quebec],
    [*E* - Echo], [*R* - Romeo],
    [*F* - Foxtrot], [*S* - Sierra],
    [*G* - Golf], [*T* - Tango],
    [*H* - Hotel], [*U* - Uniform],
    [*I* - India], [*V* - Victor],
    [*J* - Juliett], [*W* - Whiskey],
    [*K* - Kilo], [*X* - X-ray],
    [*L* - Lima], [*Y* - Yankee],
    [*M* - Mike], [*Z* - Zulu],
  )
]

#pagebreak()

// --- Emergency Radio Call ---
#heading(level: 1)[EMERGENCY RADIO CALL]
#v(1em)

#block(
  fill: rgb("#fff5f5"),
  stroke: 3pt + red,
  inset: 2em,
  width: 100%,
  height: 80%, 
)[
  #align(center)[
    #text(red, weight: "bold", size: 14pt)[USE ONLY IN CASE OF DANGER TO LIFE. SPEAK SLOWLY.]
  ]
  
  #v(1fr)
  
  *1. PRESS AND HOLD THE RED BUTTON ON THE RADIO UNTIL IT BEEPS.*
  
  #v(1fr)
  
  2. *SWITCH RADIO CHANNEL TO 16, PRESS "PUSH-TO-TALK" AND READ:*
  #pad(left: 1.5em, top: 0.5em)[
    #text(style: "italic", size: 14pt)[
      "MAYDAY, MAYDAY, MAYDAY \
      THIS IS YACHT #if yacht-name != "" [#upper(yacht-name), YACHT #upper(yacht-name), YACHT #upper(yacht-name)] else [............. , YACHT ............. , YACHT .............]"
    ]
  ]
  
  #v(1fr)
  
  *3. READ GPS POSITION AND REPORT IT:*
  #pad(left: 1.5em, top: 0.5em)[
    #text(style: "italic", size: 14pt)[
      "MY POSITION IS ... DEGREES ... MINUTES NORTH \
      ... DEGREES ... MINUTES EAST"
    ]
  ]
  
  #v(1fr)
  
  *4. SAY WHAT HAPPENED:*
  #pad(left: 1.5em, top: 0.5em)[
    #text(style: "italic", size: 14pt)[
      "WE HAVE ... [Fire / Sinking / Person Overboard / Medical Emergency]"
    ]
  ]
  
  #v(1fr)
  
  *5. WHAT DO YOU WANT?*
  #pad(left: 1.5em, top: 0.5em)[
    #text(style: "italic", size: 14pt)[
      "WE REQUIRE ... [Immediate Rescue / Towing / Medical Advice]" \
      "WE HAVE #(crew.len() + 1) PERSONS ON BOARD."
    ]
  ]
  
  #v(1fr)
  
  *6. SAY "OVER" AND RELEASE THE "PUSH-TO-TALK" BUTTON.*
  
  #v(1fr)
  #align(center)[
    #text(style: "italic", size: 11pt)[No answer? Repeat every 2 minutes. Stay on CH16.]
  ]
]

#pagebreak()

// --- Crew Briefing ---
#heading(level: 1)[Crew Briefing]
#v(1em)

#box(width: 1.2em, height: 1.2em, stroke: 1pt + navy, radius: 2pt) #h(0.5em) *Assignments:* Who sleeps where? Assign cabins and bunks now. \

#v(2em)

#heading(level: 2)[#text(rgb("#8B0000"))[Critical Dangers]]
#v(0.5em)

⚠️ *What can kill YOU:* \
#box(width: 1.2em, height: 1.2em, stroke: 1pt + navy, radius: 2pt) #h(0.5em) *The Boom:* The most dangerous object on deck—duck! \
#box(width: 1.2em, height: 1.2em, stroke: 1pt + navy, radius: 2pt) #h(0.5em) *Jumping:* NEVER jump, always step! Or you might be crushed between the boat and the dock. \
#box(width: 1.2em, height: 1.2em, stroke: 1pt + navy, radius: 2pt) #h(0.5em) *Stay Onboard!* Use jacklines and harnesses. In 15°C water: after 15 mins swimming gets hard, after 1 hour you get unconscious. You will die fast. Stay on the ship, do not fall out! \

#v(0.5em)

⚠️ *What can kill the BOAT (thus you):* \
#box(width: 1.2em, height: 1.2em, stroke: 1pt + navy, radius: 2pt) #h(0.5em) *Collisions:* Hitting hard things sinks ships fast. Use sonar to avoid rocks. Observe lights at night to avoid hitting other ships. Always watch the plotter and map for both. \
#box(width: 1.2em, height: 1.2em, stroke: 1pt + navy, radius: 2pt) #h(0.5em) *Fire:* Be extremely careful with the gas stove. NEVER leave gas in the pipe: close the bottle first. If fire starts: position yacht so wind blows fire *off* the boat. Use correct extinguisher. \
#box(width: 1.2em, height: 1.2em, stroke: 1pt + navy, radius: 2pt) #h(0.5em) *Water Ingress:* Keep hatches closed underway. If leaking: taste test (salt vs fresh), close seacocks, cut power, start bilge pumps, find source. \

#heading(level: 2)[Life Saving & Emergency Procedures]
#v(0.5em)
#box(width: 1.2em, height: 1.2em, stroke: 1pt + navy, radius: 2pt) #h(0.5em) *Life Jackets, Harnesses & Jacklines:* Always have it easily accessible, always wear at night and in bad weather. \
#box(width: 1.2em, height: 1.2em, stroke: 1pt + navy, radius: 2pt) #h(0.5em) *Life Raft:* Location, how to release, and when to use. \
#box(width: 1.2em, height: 1.2em, stroke: 1pt + navy, radius: 2pt) #h(0.5em) *Pyrotechnics:* Know location and how to use. Remember to read the instructions! \
#box(width: 1.2em, height: 1.2em, stroke: 1pt + navy, radius: 2pt) #h(0.5em) *VHF Radio (DSC):* CH16 monitoring; MAYDAY format. Requires a certificate! Do not mess with it and always ask the Captain before transmitting. \
#box(width: 1.2em, height: 1.2em, stroke: 1pt + navy, radius: 2pt) #h(0.5em) *EPIRB / SART / PLB:* Check what you have and how to use it. \
#box(width: 1.2em, height: 1.2em, stroke: 1pt + navy, radius: 2pt) #h(0.5em) *MOB (Man Overboard):* Shout "Man Overboard!", point, MOB button on plotter, throw lifebuoy/light. Approach maneuver – one person commands, others quiet. \
#box(width: 1.2em, height: 1.2em, stroke: 1pt + navy, radius: 2pt) #h(0.5em) *Evacuation:* Put on all the clothes you can, wear life jackets, and gather in the cockpit. Only then: 1st Officer (EPIRB/Raft), 2nd Officer (Grab-bag/Food/Docs), 3rd Officer (Pyrotechnics/VHF). Count crew. \

#heading(level: 2)[Crew Watches]
#v(0.5em)
#box(width: 1.2em, height: 1.2em, stroke: 1pt + navy, radius: 2pt) #h(0.5em) *Navigational Watch:* Responsible for sailing, steering, navigation, and deck safety. \
#box(width: 1.2em, height: 1.2em, stroke: 1pt + navy, radius: 2pt) #h(0.5em) *Galley Watch:* Responsible for cooking all meals and cleaning the galley for that entire day. \

#v(2em)

#pagebreak()
#heading(level: 1)[Crew Briefing (cont.)]
#v(1em)

#heading(level: 2)[Life On Board – Rules]
#v(0.5em)
#box(width: 1.2em, height: 1.2em, stroke: 1pt + navy, radius: 2pt) #h(0.5em) *Say before doing:* Whenever you want to maneuver, steer, or click something on the control panel, announce your intention loudly *before* you do it, so the crew can react. \
#box(width: 1.2em, height: 1.2em, stroke: 1pt + navy, radius: 2pt) #h(0.5em) *Conserve electricity:* When sailing, we run on batteries. Do not charge heavy devices (like 100W laptops) without asking first. If you drain the batteries, the engine won't start! \
#box(width: 1.2em, height: 1.2em, stroke: 1pt + navy, radius: 2pt) #h(0.5em) *Forgive minor faults:* It's a week together; speak directly and calmly. \
#box(width: 1.2em, height: 1.2em, stroke: 1pt + navy, radius: 2pt) #h(0.5em) *Watches & Sleeping:* Shared cabins, quiet hours; ALWAYS wake the Captain if in doubt. \
#box(width: 1.2em, height: 1.2em, stroke: 1pt + navy, radius: 2pt) #h(0.5em) *Water & Toilets:* Conserve water; follow yacht toilet rules (no paper in the bowl). \
#box(width: 1.2em, height: 1.2em, stroke: 1pt + navy, radius: 2pt) #h(0.5em) *Damage:* Shared responsibility; insurance deposit. Report everything immediately. \
#box(width: 1.2em, height: 1.2em, stroke: 1pt + navy, radius: 2pt) #h(0.5em) *Attitude:* Being proactive makes you liked in sailing! \

#v(2em)

#heading(level: 2)[Yacht Basics]
#v(0.5em)
#box(width: 1.2em, height: 1.2em, stroke: 1pt + navy, radius: 2pt) #h(0.5em) *Line Handling Drill (Stern Cleat):* Go to the stern, practice coiling and throwing the line. You must learn to quickly distinguish and execute: \
  #pad(left: 2em)[
    - *Blocking:* Taking one wrap to hold the load. \
    - *Cleating:* Fully securing the line. \
    - *Release / Cast off:* Giving the rope totally away. \
    - *Ease / Give rope:* Loosening it a little bit. \
    - *Take in slack:* Pulling it tight quickly. \
  ]
#box(width: 1.2em, height: 1.2em, stroke: 1pt + navy, radius: 2pt) #h(0.5em) *Knots:* Cleat hitch (mooring lines), Bowline (loop). Practice with eyes closed. \
#box(width: 1.2em, height: 1.2em, stroke: 1pt + navy, radius: 2pt) #h(0.5em) *Winches:* Line from bottom, 3–4 wraps, "on top", fingers away. Commands: "taking/easing" – confirm loudly. \
#box(width: 1.2em, height: 1.2em, stroke: 1pt + navy, radius: 2pt) #h(0.5em) *Port Maneuvers:* No jokes. Short, loud reports ("stern 2m, drifting left"). Wait for Captain's confirmation. \

// --- Watch Setup & Schedule ---
#pagebreak(to: "even")
#heading(level: 1)[Watch Assignments & Schedule]
#v(1em)

#{
  let ranks = ("1st Officer", "2nd Officer", "3rd Officer")
  for (idx, watch) in watch-assignments.enumerate() [
    - *#watch.officer* (#ranks.at(idx)) #box(width: 1fr, repeat[#text(fill: luma(220))[.]])
    #for m in watch.members [
      #pad(left: 1.5em)[
        - #m #box(width: 1fr, repeat[#text(fill: luma(220))[.]])
      ]
    ]
    #v(0.5em)
  ]
}

#v(2em)

#heading(level: 2)[Watch Schedule]
#v(0.5em)
#{
  let hours = ("0-4", "4-8", "8-12", "12-14", "14-16", "16-20", "20-24")
  let watch-rotation = (3, 1, 2)
  
  table(
    columns: (65pt, ..(1fr,) * hours.len(), 55pt),
    stroke: 0.5pt + luma(220),
    align: center + horizon,
    inset: (y: 0.4em),
    table.header(
      [*Date*], ..hours.map(h => [#text(size: 9pt, weight: "bold", h)]), [*Galley*]
    ),
    ..for day in range(0, 8) {
      // Calculate dynamic date using duration if available, else empty string
      let label = if start-date != none {
        (start-date + duration(days: day)).display("[weekday repr:short] [day]/[month]")
      } else {
        ""
      }

      let cells = ()
      cells.push([#text(size: 8pt)[#label]])
      for i in range(hours.len()) {
        // Shift rotation by day to start with 3, 1, 2
        let watch-num = watch-rotation.at(calc.rem(day + i, 3))
        let roman-num = if watch-num == 1 { "I" } else if watch-num == 2 { "II" } else { "III" }
        cells.push([#text(size: 9pt)[#roman-num]])
      }
      // Galley rotation also shifted to stay fair relative to watch start
      let galley-watch = watch-rotation.at(calc.rem(day + 1, 3))
      let galley-roman = if galley-watch == 1 { "I" } else if galley-watch == 2 { "II" } else { "III" }
      cells.push([*#text(size: 9pt)[#galley-roman]*])
      cells
    }
  )
}

#v(0.5em)
#block(width: 100%, stroke: 0.5pt + luma(220), inset: 1em, fill: luma(250))[
  *Legend:*
  - *Hourly Columns:* Assigned watch takes care of all *Navigation Duties* and deck operations during these times.
  - *Galley Column:* Assigned watch is responsible for *Cooking and Cleaning* for the *entire day* (from breakfast until supper, assigned watch is in charge of the kitchen).
]

#pagebreak()

#heading(level: 1)[How to fill Daily Logs]
#v(1em)

This logbook is organized into two-page spreads to make recording our journey easy. The *left page* is where we keep all the technical data—think of it as the boat's "brain" where we track our speed, position, and engine status every hour. The *right page* is the heart of the log; use it like a journal to write down what happened during the day, tell funny stories, note down the weather, or sketch the coastline.

#v(1em)

#heading(level: 2)[How to Fill the Data Columns]
#v(0.5em)

- *Time:* 4-digit military time (e.g., 0830, 1415).
- *Pos (Position):* Use Latitude and Longitude with precision to minutes (e.g., N44°50' E13°48') or write the name of the marina or anchorage if we are stationary.
- *HDG (Current Heading):* Our current compass heading (e.g., 210). When maneuvering in a marina or doing pilotage based on visual references, heading changes too often—write *PIL* instead.
- *Spd (Speed):* Our instantaneous Speed Over Ground (SOG) in knots at the moment of the entry. Record with a *single decimal* (e.g., 6.5).
- *Log:* The boat's *total lifetime mileage* (odometer). Round up/down to the *nearest whole mile* (no decimals). Recording the total value from the instrument rather than a trip log removes the overhead of manual calculations and prevents cumulative mathematical errors.
- *Wind:* The direction the wind is blowing *from* and speed in knots (e.g., NW 15).
- *Sails:* Use *M* for Main and *J* for Jib. Note reefing like "M1, J1" or "-" if the sails are down.
- *Eng (Engine):* Record the current *RPM* (e.g., 1800) or write "-" if the engine is off.

#v(1em)
#align(center)[
  #image("Compas_rose.svg", width: 6cm)
]

#v(1em)

#heading(level: 2)[What MUST be recorded]
#v(0.5em)
- *Watch Change:* The time and initials of who is taking over.
- *Arrivals & Departures:* When we leave or enter a port or anchorage.
- *Changes:* Any time the sails go up/down or the engine RPM changes.
- *Refueling:* Any time we top up the diesel or the fresh water tanks.
- *Checks:* Equipment failures or routine inspections (like battery levels).
- *Corrections:* If you make a mistake, DO NOT overwrite single digits. Strike through the entire row and write a fresh, correct entry on the line below it.

#v(1em)

#heading(level: 2)[Shorthand Symbols]
#v(0.5em)
To save space, especially in the *Notes* page, use these standard symbols:
#v(0.5em)
#table(
  columns: (3cm, 10cm),
  stroke: 0.5pt + gray,
  align: center + horizon,
  [*⚓*], align(left)[Anchoring (Dropping the anchor)],
  [*〰*], align(left)[Moored (Tied to a dock or buoy)],
  [*#sym.arrow.r*], align(left)[Departure (Leaving the dock or anchorage)],
  [*#sym.arrow.t*], align(left)[Up / ON (e.g., Sails up, Engine on)],
  [*#sym.arrow.b*], align(left)[Down / OFF (e.g., Sails down, Engine off)],
  [#v(1.5em)], [],
  [#v(1.5em)], [],
  [#v(1.5em)], [],
)

// --- Daily Log Pages ---

// Ensure the Day 0 Demo spread stays aligned.
#pagebreak(to: "even")
#heading(level: 1)[Day 0 - Demo Data Page]
#v(0.5em)

#block(height: 94%)[
  #table(
    columns: (4fr, 16fr, 3fr, 3fr, 6fr, 6fr, 5fr, 4fr),
    rows: (auto, ..(1fr,) * 24),
    stroke: 0.5pt + luma(220),
    align: center + horizon,
    inset: (x: 2pt, y: 0.2em),
    table.header(
      [*Time*], [*Pos*], [*HDG*], [*Spd*], [*Log*], [*Wind*], [*Sails*], [*Eng*],
    ),
    [0830], [Marina Pula], [PIL], [3.5], [120], [NW 10], [-], [1200],
    [0915], [N44°50' E13°48'], [210], [6.5], [122], [NW 15], [M1, J1], [-],
    [1000], [N44°45' E13°45'], [215], [7.0], [127], [NW 18], [M1, J1], [-],
    [#strike[1130]], [#strike[N44°38' E13°40']], [#strike[120]], [#strike[5.5]], [#strike[136]], [#strike[N 8]], [#strike[-]], [#strike[1800]],
    [1130], [N44°38' E13°40'], [210], [5.5], [136], [N 8], [-], [1800],
    [1230], [Susak Bay], [PIL], [0.0], [140], [N 5], [-], [-],
    [1500], [Susak Bay], [PIL], [4.0], [140], [NE 12], [-], [1500],
    [1530], [N44°30' E14°05'], [090], [6.0], [142], [NE 15], [M, J], [-],
    [1800], [N44°32' E14°15'], [085], [5.5], [157], [NE 12], [M, J], [-],
    [2030], [N44°33' E14°25'], [090], [5.0], [170], [NE 8], [-], [1500],
    [2130], [Mali Lošinj], [PIL], [0.0], [175], [NE 5], [-], [-],
    ..for _ in range(13) { ([], [], [], [], [], [], [], []) }
  )
]

#pagebreak(to: "odd")
#heading(level: 1)[Day 0 - Demo Notes Page]
#v(1em)
#block(width: 100%, height: 85%, stroke: 0.5pt + luma(200), inset: 1.5em)[
  #set text(size: 13pt)
  #v(0.5em)
  0830 - #sym.arrow.r Marina Pula. Eng #sym.arrow.t \
  #align(right)[*-- John Doe*]
  0915 - M #sym.arrow.t, J #sym.arrow.t, Eng #sym.arrow.b. Watch III taking over. \
  #align(right)[*-- Alice Smith*]
  1130 - Wind dropped. M #sym.arrow.b, J #sym.arrow.b, Eng #sym.arrow.t. (Mistake in log table crossed out below). \
  #align(right)[*-- Alice Smith*]
  1230 - ⚓ Susak Bay. Anchoring for lunch. \
  #align(right)[*-- Alice Smith*]
  1500 - #sym.arrow.r Susak Bay. Eng #sym.arrow.t. \
  #align(right)[*-- Bob Jones*]
  1530 - M #sym.arrow.t, J #sym.arrow.t, Eng #sym.arrow.b. \
  #align(right)[*-- Bob Jones*]
  2000 - Navigational lights #sym.arrow.t. \
  #align(right)[*-- Captain Dave*]
  2030 - M #sym.arrow.b, J #sym.arrow.b, Eng #sym.arrow.t. Approaching marina. \
  #align(right)[*-- Captain Dave*]
  2130 - 〰 Mali Lošinj. Nav lights #sym.arrow.b, Eng #sym.arrow.b. Moored safely. \
  #align(right)[*-- Captain Dave*]
]

#for i in range(1, 9) [
  // Left Page: Log Table (Even Page)
  #pagebreak(to: "even")
  #heading(level: 1)[Day #i - Log]
  #v(0.5em)
  
  // Stretch rows to fill the page (24 hourly slots + header)
  #block(height: 94%)[
    #table(
      columns: (4fr, 16fr, 3fr, 3fr, 6fr, 6fr, 5fr, 4fr),
      rows: (auto, ..(1fr,) * 24), // First row is auto (header), the rest stretch to fill the block
      stroke: 0.5pt + luma(220),
      align: center + horizon,
      table.header(
        [*Time*], [*Pos*], [*HDG*], [*Spd*], [*Log*], [*Wind*], [*Sails*], [*Eng*],
      ),
      ..for _ in range(24) { ([], [], [], [], [], [], [], []) }
    )
  ]

  // Right Page: Loose Notes (Odd Page)
  #pagebreak(to: "odd")
  #heading(level: 1)[Day #i - Notes]
  #v(1em)
  #block(width: 100%, height: 85%, stroke: 0.5pt + luma(200), inset: 1em)[]
]

// --- Appendix Notes (Blank Pages) ---
#for _ in range(2) [
  #pagebreak()
  #heading(level: 1)[Notes]
  #v(1em)
  #block(width: 100%, height: 85%, stroke: 0.5pt + luma(200), inset: 1em)[]
]

#pagebreak(to: "odd")
#v(1fr)
#align(center)[
  #image("favicon.png", width: 2cm)
  #v(1em)
  #text(size: 14pt, weight: "bold")[Belgian Sailing Community] \
  #v(0.5em)
  This logbook template is an open-source community project. \
  If you have feedback, ideas, or want to contribute to future versions, please visit: \
  #v(0.5em)
  #link("https://github.com/nd-dew/sailing-logbook")[*github.com/nd-dew/sailing-logbook*]
]
#v(1fr)


