#import "template.typ": *

// Apply the project styling to the entire document
#project[
  // Use the title function to create your title table
  #title(
    title: "TITLE",
    subtitle: "Subtitle",
    info: "Info",
  )

  = #lorem(5)
  == #lorem(5)
  #lorem(289)

  == #lorem(5)
  #lorem(289)

]
