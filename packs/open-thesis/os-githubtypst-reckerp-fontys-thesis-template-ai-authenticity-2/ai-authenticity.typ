#let ai-authenticity-page(
  font-body,
  author: none,
  student-number: none,
  date: none,
  location: none,
  signature-image: none,
  ai-used: false,
  ai-tools: none,
  ai-chapter-description: none,
  ai-usage-explanation: none,
) = {
  page(
    margin: (left: 1.2in, right: 1.0in, top: 1.0in, bottom: 1.0in),
  )[
    #set text(font: font-body)
    #set par(justify: true, leading: 0.65em)

    #heading(outlined: false, numbering: none)[Statement of Authenticity on AI usage]

    #v(0.5cm)

    I, #if author != none {strong(author)} else {text(fill: gray)[Student Name]}, declare the following use of Artificial Intelligence (AI) tools (please cross the correct situation):

    #v(0.5cm)

    // Checkbox for NOT using AI
    #box(
      width: 1em,
      height: 1em,
      stroke: 0.5pt,
      inset: 2pt,
    )[
      #if not ai-used {
        // Draw X mark
        place(line(start: (0%, 0%), end: (100%, 100%), stroke: 1pt))
        place(line(start: (0%, 100%), end: (100%, 0%), stroke: 1pt))
      }
    ] I have not used any AI tools, including but not limited to AI writing assistants, AI generators, and AI art creators, to create any portion of my submission.

    #v(0.1cm)

    // Checkbox for USING AI
    #box(
      width: 1em,
      height: 1em,
      stroke: 0.5pt,
      inset: 2pt,
    )[
      #if ai-used {
        // Draw X mark
        place(line(start: (0%, 0%), end: (100%, 100%), stroke: 1pt))
        place(line(start: (0%, 100%), end: (100%, 0%), stroke: 1pt))
      }
    ] I have used AI tools, clearly cited and marked these sections according to the referencing style prescribed by my study programme, and provided a detailed explanation of AI's involvement. This includes direct use of AI-generated text, images, or other materials and indirect use where AI has guided, improved or influenced my work. An overview of these AI tools is noted below.

    #v(0.5cm)

    // AI Tools section (only if AI was used)
    #if ai-used {
      [
        #text(13pt)[*AI Tools (if applicable):*]

        #v(0.1cm)

        *AI tool(s) used:* #if ai-tools != none {ai-tools} else {text(fill: gray)[[List the AI tool(s) you used]]}

        #v(0.1cm)

        *Paragraph/Chapter where AI was used:* #if ai-chapter-description != none {ai-chapter-description} else {text(fill: gray)[[Provide a brief description per paragraph/chapter where you used AI]]}

        #v(0.1cm)

        *Purpose of AI usage:* #if ai-usage-explanation != none {ai-usage-explanation} else {text(fill: gray)[[Explain why and how AI was used]]}

        #v(0.5cm)
      ]
    } else {
      v(1cm)
    }

    I acknowledge the ethical implications and academic integrity concerns surrounding using AI tools and commit to using these technologies responsibly. I understand that failure to adhere to the AI policy may result in academic consequences.

    #v(1cm)

    *Signature:*

    // Display signature image if provided
    #if signature-image != none {
      block(
        signature-image
      )
    } else {
      v(1cm)
    }

    #line(length: 40%, stroke: 0.5pt)

    #v(0.1cm)

    *Place and Date:* #if location != none and date != none {
      [#location, #date]
    } else if location != none {
      location
    } else if date != none {
      date
    } else {
      text(fill: gray)[NOT PROVIDED]
    }
  ]
}
