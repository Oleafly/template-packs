#let conf(
  name: str,
  contact: dictionary,
  research-interests: "",
  education: array,
  awards: array,
  body,
) = {

  set page(
    paper: "us-letter",
  )

  [
    = #name
    #line(length: 100%)
  ]

  show heading: it => {
    smallcaps(it.body)
    linebreak()
  }

  let columns = (1fr, 5fr)

  // Contact Information
  if contact.len() != 0 {
    grid(
      columns: columns,
      rows: (auto),
      [ === Contact Information ],
      for (k, v) in contact [
        #k.replace(regex("^\w"), m => upper(m.text)): #v \
      ],
    )
  }

  // Research Interests
  if research-interests.len() != 0 {
    grid(
      columns: columns,
      rows: (auto),
      [ === Research Interests ],
      [
        Operating Systems
      ],
    )
  }

  // Education
  if education.len() != 0 {
    let text = for e in education {
      let degrees = for (n, d, aux) in e.degrees {
          if d.len() == 1 [
            - #n #box(width: 1fr, repeat[.])
              #d.at(0).display("[month repr:short]. [year repr:full]")
              #for a in aux [ - #a ]
          ] else if d.len() == 2 and d.at(1) == datetime.today() [
            - #n #box(width: 1fr, repeat[.])
              #d.at(0).display("[month repr:short]. [year repr:full]") - Present
              #for a in aux [ - #a ]
          ] else if d.len() == 2 [
            - #n #box(width: 1fr, repeat[.])
              #d.at(0).display("[month repr:short]. [year repr:full]") -
              #d.at(1).display("[month repr:short]. [year repr:full]")
              #for a in aux [ - #a ]
          ] else {
            panic("Bad date range of a program")
          }
      }

      [
        *#e.institute*, #e.location \
        #degrees
      ]
    }

    grid(
      columns: columns,
      rows: (auto),
      [ === Education ],
      text,
    )
  }

  // Honors and awards
  if awards.len() != 0 {
    grid(
      columns: columns,
      rows: (auto),
      [ === Honors and Awards ],
      for (n, d) in awards [
        #n #box(width: 1fr, repeat[.])
        #d.display("[month repr:short]. [year repr:full]") \
      ],
    )
  }

  // Create additional sections
  let sections = ()
  let current_section = none

  for item in body.children.slice(
    body.children.position(x => x.func() == heading)) {
    if item.func() == heading {
      if current_section != none {
        sections.push(current_section)
      }
      current_section = (item, [])
    } else {
      current_section.at(1) = current_section.at(1) + item
    }
  }

  sections.push(current_section)

  for (h, c) in sections {
    grid(
      columns: columns,
      rows: (auto),
      h, c,
    )
  }
}