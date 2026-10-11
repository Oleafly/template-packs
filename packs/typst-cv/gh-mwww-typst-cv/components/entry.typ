#import "../theme.typ": *

// Usage:
//   #cv-entry(
//     title: "Senior Software Engineer",
//     org: "Acme Corp",          // optional
//     date: "2022 – present",    // optional
//     location: "New York, NY",  // optional
//     details: (                 // optional
//       "Led migration of monolithic Rails app to microservices.",
//       "Shipped internal CI/CD platform used by 80+ engineers.",
//     ),
//     techs: ("Rust", "Kubernetes", "Postgres"),  // optional
//   )
#let cv-entry(
  title: "",
  org: "",
  date: "",
  location: "",
  details: (),
  techs: (),
) = {
  block(breakable: false, {
    // ── Title row ──
    grid(
      columns: (1fr, auto),
      align: (bottom, bottom),
      {
        text(weight: "bold")[#title]
        if org      != "" [ · #org]
        if location != "" [ · #location]
      },
      text(font: font-mono, size: size-meta)[#date],
    )

    // ── Tech stack ──
    if techs.len() > 0 {
      v(0.2em)
      text(font: font-mono, size: size-section, style: "italic")[#techs.join([,#h(0.4em)])]
    }

    // ── Detail bullets ──
    if details.len() > 0 {
      v(0.48em)
      for detail in details {
        grid(
          columns: (0.85em, 1fr),
          align: (top, top),
          text(size: size-body)[•],
          text(size: size-body)[#detail],
        )
        v(gap-between-details)
      }
    }
  })
  v(gap-between-entries)
}
