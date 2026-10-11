#import "@preview/fontawesome:0.2.1": fa-icon
#import "utilities.typ": to-string


// Configure the template
#let conf(separator: ",", doc) = {
  set document(title: "Curriculum Vitae")
  set page(paper: "a4", margin: (x: 1.8cm, y: 1.5cm))
  set text(font: "Roboto", size: 10pt, weight: "light", lang: "en")
  set par(justify: true)

  // Show level 1 headings with a line after them
  show heading.where(level: 1): it => {
    let headingText = text(size: 16pt, it.body)
    let size = measure(headingText)
    grid(
      columns: (auto, 1fr),
      headingText,
      grid.cell(inset: (left: 1pt), line(start: (0pt, size.height), length: 100%, stroke: 0.3pt))
    )
  }

  // If level 3 heading contains a comma, split it into two columns
  // Use the separator argument to use a different character for splitting
  show heading.where(level: 3): it => {
    let content = it.body
    let allText = to-string(it.body)

    if allText.contains(separator) {
      let (leftText, rightText) = allText.split(separator)
      content = grid(
          columns: (auto, 1fr),
          leftText,
          grid.cell(align: right, rightText)
        )
    }

    block(width: 100%, above: 0em, below: 0.9em,
      text(size: 11pt, fill: luma(150), weight: "regular",
        content
      )
    )
  }

  // Render the document
  doc
}

// Function for formatting name
#let name(content) = {
    let nameString = to-string(content)
    set document(author: nameString)

    block(width: 100%, below: 0.9em,
      align(center,
        text(size:28pt,
          content
        )
      )
    )
}

// Function for formatting address
#let address(content) = {
  align(center, text(size:12pt, fill: luma(150), weight: "regular", content))
}

// Display a link with a Font Awesome icon and text
#let icon-link(icon, text, url) = link(url)[#fa-icon(icon) #text]

// Show links to contact information and social media profiles
#let link-bar(email: none, phone: none, twitter: none, threads: none,
    mastodon: none, github: none, linkedin: none, stackoverflow: none) = {
  let contentArray = ()

  if email != none {
    contentArray.push(icon-link("envelope", email, "mailto:" + email))
  }

  if phone != none {
    contentArray.push(icon-link("phone", phone, "tel:" + phone.replace(" ", "")))
  }

  if twitter != none {
    contentArray.push(icon-link("x-twitter", twitter, "https://x.com/" + twitter))
  }

  if mastodon != none {
    let (.., userid, server) = mastodon.split("@")
    let url = "https://" + server + "/@" + userid
    contentArray.push(icon-link("mastodon", mastodon, url))
  }

  if github != none {
    contentArray.push(icon-link("github", github, "https://github.com/" + github))
  }

  if linkedin != none {
    contentArray.push(icon-link("linkedin", linkedin, "https://www.linkedin.com/in/" + linkedin))
  }

  if stackoverflow != none {
    contentArray.push(icon-link("stack-overflow", stackoverflow.name, stackoverflow.url))
  }

  let spacer = sym.space.nobreak + sym.bar.v + sym.space.nobreak
  let content = contentArray.join(spacer)
  align(center, text(size:12pt, content))
}
