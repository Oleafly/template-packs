#import "../template/src/lib.typ": *

// Put your personal information here
#let name = "Chris Qi"
#let phone = "+1 (123) 456-7890"
#let email = "chrisyqpro@gmail.com"
#let github = "chrisyqpro"
#let linkedin = "chris-yu-qi"
#let location = "Ontario, Canada"
#let personal-site = "chrisyqpro.com"

// Since the following arguments are within the `with` block,
// you can remove/comment any argument to fallback to the preset value and/or
// remove it.
#show: resume.with(
  font: "XCharter",
  // bottom-margin: 0.3in,
  // personal-info-font-size: 10.5pt,
  author-name: name,
  // phone: phone,
  email: email,
  // website: personal-site,
  linkedin-user-id: linkedin,
  // github-username: github,
  location: location,
)

// Use custom-title function instead of first-level headings to customize the
// size between two sections by specifying the `spacingBetween` argument.
// https://typst.app/docs/reference/layout/length/

#custom-title("Education")[
  #education-heading(
    "Scranton University", // institution
    "Scranton, PA", // location
    "Bachelor of Arts", // degree
    "Business Administration", // major
    datetime(year: 1992, month: 9, day: 1), // start-date
    datetime(year: 1998, month: 4, day: 1), // end-date
    gpa: "4.0",
  )[]
  #education-heading(
    "Scranton University", // institution
    "Scranton, PA", // location
    "Bachelor of Arts", // degree
    "Business Administration", // major
    datetime(year: 1992, month: 9, day: 1), // start-date
    datetime(year: 1998, month: 4, day: 1), // end-date
  )[]
]

#custom-title("Skills")[
  #skills()[
    - *Professional Skills:*
      Sales Expertise,
      Leadership,
      Conflict Resolution,
      Strategic Planning,
      Negotiation
    - *Personal Traits:*
      Alpha Male,
      Hardworking,
      Jackhammer,
      Merciless,
      Insatiable
    - *Specialized Talents:*
      Karate (Black Belt),
      Jujitsu,
      Werewolf Hunting,
      Table Making
    - *Certifications:*
      MS
  ]
]

#custom-title("Experience")[
  #work-heading(
    "Regional Manager", // title
    "Dunder Mifflin", // company
    "Scranton, PA", // location
    datetime(year: 2013, month: 5, day: 1), // start-date
    "Present", // end-date
  )[
    - Led a team of 10+ employees, boosting office productivity and morale
    - Maintained the highest sales average, outperforming competitors despite market challenges
    - Maintained the highest sales average, outperforming competitors despite market challenges
    - Successfully negotiated client contracts, increasing annual revenue by 20%
  ]
  #work-heading(
    "Regional Manager", // title
    "Dunder Mifflin", // company
    "Scranton, PA", // location
    datetime(year: 2013, month: 5, day: 1), // start-date
    "Present", // end-date
  )[
    - Led a team of 10+ employees, boosting office productivity and morale
    - Maintained the highest sales average, outperforming competitors despite market challenges
    - Successfully negotiated client contracts, increasing annual revenue by 20%
  ]
  #work-heading(
    "Regional Manager", // title
    "Dunder Mifflin", // company
    "Scranton, PA", // location
    datetime(year: 2013, month: 5, day: 1), // start-date
    "Present", // end-date
  )[
    - Led a team of 10+ employees, boosting office productivity and morale
    - Maintained the highest sales average, outperforming competitors despite market challenges
    - Successfully negotiated client contracts, increasing annual revenue by 20%
  ]
  #work-heading(
    "Regional Manager", // title
    "Dunder Mifflin", // company
    "Scranton, PA", // location
    datetime(year: 2013, month: 5, day: 1), // start-date
    "Present", // end-date
  )[
    - Led a team of 10+ employees, boosting office productivity and morale
    - Maintained the highest sales average, outperforming competitors despite market challenges
  ]
]

#custom-title("Projects")[
  #project-heading(
    "Schrute Farms (Bed and Breakfast)", // name
    info: "Hackthon No.1",
    stack: "Next.js, TailwindCSS, Postgres", // stack
    project-url: "schrutefarms.com", // project_url
  )[
    - Established and managed a family-run agro-tourism business offering unique activities such as table.
    - Maintained a 4.9/5 guest satisfaction rating on travel review platforms
  ]
  #project-heading(
    "Schrute Farms (Bed and Breakfast)", // name
    // info: "Hackthon No.1",
    // stack: "Next.js, TailwindCSS, Postgres", // stack
    // project-url: "schrutefarms.com", // project_url
  )[
    - Established and managed a family-run agro-tourism business offering unique activities such as table-making workshops, beet farming tours, and hay rides
    - Increased guest bookings by 50% through effective online marketing and guest engagement
  ]
]

