// ckunte's custom letter template -- 2024
// This function gets your whole document as its `body`
// and formats it as a simple letter.
#let letter(
  // The letter's sender, which is display at the top of the page.
  sender: none,

  // The letter's recipient, which is displayed close to the top.
  recipient: none,

  // The date, displayed to the right.
  date: none,

  // The subject line.
  subject: none,

  // The name with which the letter closes.
  name: none,

  // The letter's content.
  body
) = {
  // Configure page and text properties.
  set page(
    paper: "a5",
    margin: (top: 0.6in), 
    numbering: "1",
    )
  set text(
    font: "erewhon", // options: erewhon, Courier Prime, etc
    top-edge: "cap-height", 
    bottom-edge: "baseline",
    number-type: "old-style",
    // size: 10pt // 11pt is default
    )  
  // Set paragraph
  set par(justify: true)

  // Display sender at top of page. If there's no sender
  // add some hidden text to keep the same spacing.
  align(center, {
    text(9pt, if sender == none {
      hide("a")
    } else {
      sender
    })
  })

  v(0.5in)

  // Display date. If there's no date add some hidden
  // text to keep the same spacing.
  align(right, if date != none {
    date
  } else {
    hide("a")
  })

  v(0.5cm)

  // Display recipient.
  recipient

  v(0.5cm)

  // Add the subject line, if any.
  if subject != none {
    pad(right: 10%, strong(subject))
  }

  // Add body and name.
  body
  v(0.5in)
  name
}