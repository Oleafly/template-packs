#import "@preview/fontawesome:0.6.0": fa-icon
#import "@preview/linguify:0.4.2": linguify, set-database

#set-database(toml("i18n.toml"))

#set par(spacing: 0.7em)

#let header-key-value(faKey, value, monospace: false) = {
  fa-icon(faKey, fill: rgb("#B6073F"), solid: true)
  if (monospace) {
    text(
      font: "Inconsolatazi4",
      features: (
        "ss01": 1,
      ),
    )[
      #value
    ]
  } else {
    text[
      #value
    ]
  }
}

// HEADER
#table(
  columns: (1fr, auto),
  stroke: none,
  [
    #heading[
      #text(font: "Cabin", weight: "medium", size: 1.4em)[
        #strong[
          #linguify("name")
        ]
      ]
    ]

    #set par(spacing: 0.5em)
    #grid(
      columns: (1fr, 1fr),
      [
        #header-key-value("envelope", "ngoduyanh.chip@gmail.com", monospace: true)
      ],
      [
        #header-key-value("github", link("https://github.com/btmxh", "github.com/btmxh"), monospace: true)
      ],
    )
    #grid(
      columns: (1fr, 1fr, 1fr),
      header-key-value("phone", linguify("phone")),
      header-key-value("calendar", "2004-08-31"),
      header-key-value("globe", linguify("location")),
    )
  ],
  [
    #image("delusionalstreamer.jpg", height: 5.5em)
  ],
)

#let section-header(title) = [
  #let SwishLineColour = rgb("#88AC0B")
  #let start-color = color.mix((SwishLineColour, 60%), (white, 40%))
  #set par(spacing: 0.5em)
  #text(font: "Cabin", weight: "medium", size: 1.2em)[
    #strong[#title]
  ]
  #block(fill: gradient.linear(start-color, white), height: 3pt, width: 100%)
]

#section-header(linguify("education"))

#table(
  columns: (auto, auto, 1fr),
  stroke: none,
  align: (top + right, top, horizon + left),
  [
    2024 - #linguify("now")
  ],
  [
    #v(-3pt)
    #fa-icon("bookmark", solid: true, fill: rgb("#B6073F"))
  ],
  [
    #strong[#linguify("msolab")]
  ],

  [
    2022 - 2026 (#linguify("est"))
  ],
  [
    #v(-3pt)
    #fa-icon("bookmark", solid: true, fill: rgb("#B6073F"))
  ],
  [
    #strong[#linguify("bsc"), #linguify("antidote")]

    *#linguify("program")*: #linguify("talentcs")

    *CPA*: 3.92 (#linguify("uptonow"))
  ],
)

#section-header[Skills]

#table(
  columns: (auto, auto, 1fr),
  stroke: none,
  align: (top + right, top, horizon + left),
  [
    #linguify("languages")
  ],
  [
    #v(-3pt)
    #fa-icon("bookmark", solid: true, fill: rgb("#B6073F"))
  ],
  [
    #linguify("languages_text")
  ],

  [
    #linguify("coding")
  ],
  [
    #v(-3pt)
    #fa-icon("bookmark", solid: true, fill: rgb("#B6073F"))
  ],
  [
    #linguify("coding_text")
  ],

  [
    #linguify("databases")
  ],
  [
    #v(-3pt)
    #fa-icon("bookmark", solid: true, fill: rgb("#B6073F"))
  ],
  [
    PostgreSQL, MySQL, SQLite, Microsoft SQL Server
  ],

  [
    #linguify("webdev")
  ],
  [
    #v(-3pt)
    #fa-icon("bookmark", solid: true, fill: rgb("#B6073F"))
  ],
  [
    HTML, JavaScript, CSS, TypeScript, SCSS, React, HTMX
  ],

  [
    #linguify("technologies")
  ],
  [
    #v(-3pt)
    #fa-icon("bookmark", solid: true, fill: rgb("#B6073F"))
  ],
  [
    CI/CD (GitHub Actions), #linguify("graphics") (OpenGL, Vulkan, WebGPU), SCM
    (Git), Game (Unity, Godot, libGDX)
  ],
)

#section-header(linguify("achievements"))

#table(
  columns: (auto, auto, 1fr),
  stroke: none,
  align: (top + right, top, horizon + left),
  [
    2022
  ],
  [
    #v(-3pt)
    #fa-icon("bookmark", solid: true, fill: rgb("#B6073F"))
  ],
  [
    *#linguify("second_prize")* -- #linguify("vmo")
  ],

  [
    2023
  ],
  [
    #v(-3pt)
    #fa-icon("bookmark", solid: true, fill: rgb("#B6073F"))
  ],
  [
    *#linguify("second_prize")* -- #linguify("scic")
  ],

  [
    2024
  ],
  [
    #v(-3pt)
    #fa-icon("bookmark", solid: true, fill: rgb("#B6073F"))
  ],
  [
    *#linguify("first_prize")* -- #linguify("vnoi")

    *#linguify("second_prize")* -- SoICT Hackathon 2024
  ],
)

#section-header(linguify("publications"))

#table(
  columns: (auto, auto),
  stroke: none,
  align: (top, horizon + left),
  [
    #v(-3pt)
    #fa-icon("bookmark", solid: true, fill: rgb("#B6073F"))
  ],
  [
    Nguyen Thi Tam, *Ngo Duy Anh*, Dao Van Tung, Huynh Thi Thanh Binh, Le Trong
    Vinh, "Evolving routing and sequencing policies for dynamic vehicle routing
    problem with time windows", _Applied Soft Computing_, 2025
    (*accepted*).
  ],

  [
    #v(-3pt)
    #fa-icon("bookmark", solid: true, fill: rgb("#B6073F"))
  ],
  [
    *Ngo Duy Anh*, Nguyen Thi Tam, Tran Huy Hung, Huynh Thi Thanh Binh,
    "Minimum-Cost Flow-Based Evolutionary Optimization for Disaster-Resilient
    Routing in Elastic Optical Inter-Data Center Networks", _IEEE Transactions
    on Emerging Topics in Computational Intelligence_, 2025
    (*under review*).
  ],
)

#section-header(linguify("projects"))

#let monolink(url) = text(font: "Inconsolatazi4", features: ("ss01": 1))[
  #link(url)
]

#table(
  columns: (auto, auto, 1fr),
  stroke: none,
  align: (top + right, top, horizon + left),
  [
    2021 - #linguify("now")
  ],
  [
    #v(-3pt)
    #fa-icon("bookmark", solid: true, fill: rgb("#B6073F"))
  ],
  [
    *nrs* -- #monolink("https://github.com/nrs-org/nrs-impl")

    #linguify("nrs_desc")
  ],

  [
    2024
  ],
  [
    #v(-3pt)
    #fa-icon("bookmark", solid: true, fill: rgb("#B6073F"))
  ],
  [
    *plst4* -- #monolink("https://github.com/btmxh/plst4")

    #linguify("plst4_desc")
  ],

  [
    2025
  ],
  [
    #v(-3pt)
    #fa-icon("bookmark", solid: true, fill: rgb("#B6073F"))
  ],
  [

    // *rt-weekend-vk* -- #monolink("https://github.com/btmxh/rt-weekend-vk")\
    // #linguify("rt_weekend_vk_desc")

    *vk_video* -- #monolink("https://github.com/btmxh/vk_video")\
    #linguify("vk_video_desc")

    // *sve4* -- #monolink("https://github.com/btmxh/sve4")\
    // #linguify("sve4_desc")

    *vkgrad* -- #monolink("https://github.com/btmxh/vkgrad")\
    #linguify("vkgrad_desc")

    *touying-ppt-hustvn* --
    #monolink("https://github.com/btmxh/touying-ppt-hustvn")\
    #linguify("touying_ppt_hustvn_desc")
  ],
)
