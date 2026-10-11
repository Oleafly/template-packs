#import "../theme.typ": *

// Usage:
//   #cv-publication(
//     title: "Distributed Consensus Under Partial Partitions",
//     authors: "J. Doe, A. Smith",   // your name will appear as-is
//     venue: "OSDI 2023",            // optional
//     date: "2023",                  // optional
//     url: "https://arxiv.org/...",  // optional
//     url-label: "arxiv",            // optional — defaults to "link"
//   )
#let cv-publication(
  title: "",
  authors: "",
  venue: "",
  date: "",
  url: "",
  url-label: "link",
) = {
  block(breakable: false, {
    grid(
      columns: (1fr, auto),
      align: (bottom, bottom),
      text(weight: "bold", style: "italic")[#title],
      text(font: font-mono, size: size-meta)[#date],
    )
    v(0.15em)
    text(size: size-meta)[#authors]
    if venue != "" {
      [ · ]
      text(size: size-meta, style: "italic")[#venue]
    }
    if url != "" {
      [ · ]
      text(font: font-mono, size: size-meta)[#underline(link(url)[\[#url-label\]])]
    }
  })
  v(gap-between-entries)
}
