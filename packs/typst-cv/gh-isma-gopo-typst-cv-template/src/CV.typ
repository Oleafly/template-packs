// #import "utils.typ"
#import "./palette.typ": *
#import "./personal_information.typ": *
#import "./styling.typ": styling

// ------------------------
// BLOCKS
// ------------------------

#let profile_picture(lenght) = block(
  fill: colours.background-2,
  clip: true,
  // radius: 20pt,
  height: lenght,
  width: lenght,
)[
  #place(
    // For croping the image
    dx: 0%,
    dy: 0%, //-30%,
  )[
    #image(
      "../assets/profile.png",
      height: 100%,
      width: 100%,
      //scaling: "pixelated",
    )
  ]
]

#let show_title(language) = align(center)[
  #text(size: sizes.title-size)[
    #underline(author)
  ]
  #v(-0.9cm)
  #text(size: sizes.h1-size, fill: colours.primary-1)[
    #subtitle.at(language)
  ]
]

#let rhombus(colour: colours.primary-1) = box[
  // Box for integrate it within the text
  #rotate(45deg)[
    #square(
      fill: colour,
      stroke: none,
      size: 8pt,
    )
  ]
]

#let rhombus_bar(level, max: 4) = {
  let array = ()
  for i in range(level) { array.push(rhombus()) }
  for i in range(max - level) { array.push(rhombus(colour: colours.primary-2)) }
  stack(dir: ltr, spacing: 4pt, ..array)
}


// ------------------------
// CODE
// ------------------------

#let info(image_path, content) = grid(
  columns: 2,
  align: (horizon),
  gutter: 8pt
)[
  #box(
    fill: colours.primary-1,
    inset: 4pt,
    //radius: 4pt,
  )[
    #image(image_path, width: 16pt, height: 16pt)
  ]
][
  #content
]

#let minimalistic_link(url) = {
  let link_size = sizes.font-size - 2pt
  if do_show_links {
    link(url, underline(text(fill: rgb("#3366CC"), size: link_size, "🔗")))
  }
}

/*box(
fill: none,
//radius: 4pt,
)[
#link(url, image("../assets/icons/Link.svg", width: size, height: size))
]*/


#let left_right(left_content, right_content) = grid(
  columns: (1fr, auto),
  gutter: 1cm,
)[
  #align(left)[
    #left_content
  ]
][
  #align(right)[
    // #text(fill: colours.primary-1, weight: "bold")[
    #right_content
    // ]
  ]
]

#let event(title, date, location: none, content) = grid(
  rows: (auto, auto),
)[
  #left_right()[
    #title
  ][
    #emph(date)
  ]
  #v(6pt)
][
  #content
  #v(2pt)
]

#let location_event(title, date, location: none, content) = grid(
  rows: (13pt, sizes.font-size-small + 4pt, auto),
)[
  #left_right()[
    * #title *
  ][
    #date
  ]
][
  #if location != none [#emph(text(size: sizes.font-size-small, location))]
][
  #if location == none [#v(-(sizes.font-size-small + 4pt))]
  #content
  #v(6pt)
]

#let skill(level, content) = left_right(
  content,
  rhombus_bar(level),
)

#let pretty_list(content) = {
  set list(marker: scale(70%, rhombus()))
  content
}




// ------------------------
// CV
// ------------------------

#let cv(sidebar_width: 5.5cm, sidebar, main-content, language: "english") = {
  show: styling

  grid(
    columns: (sidebar_width, 1fr),
    gutter: 1cm,
  )[


    #align(center)[
      #profile_picture(5cm)
    ]

    //#v(1fr)

    #stack(
      spacing: 3pt,
      info("../assets/icons/Home.svg", location.at(language)),
      info("../assets/icons/Phone.svg", phone),
      info("../assets/icons/Email.svg", email),
      info("../assets/icons/LinkedIn.svg", linkedin),
      info("../assets/icons/GitHub.svg", github),
    )

    #sidebar

    //#v(1fr)

  ][

    #show_title(language)

    #main-content

    //#v(1fr)

  ]
}
