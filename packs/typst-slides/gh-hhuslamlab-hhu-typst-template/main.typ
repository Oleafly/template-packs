#import "@preview/touying:0.6.1": *
#import "@preview/curryst:0.5.1" as curryst: rule

#import "theme.typ": *

#show: presentation-theme.with(
  config-colors(
    primary: primary-color,
    secondary: secondary-color,
    tertiary: tertiary-color,
    neutral-darkest: text-color
  ),
  config-info(
    title: [Your Presentation Title],
    subtitle: [Optional Subtitle],
    author: [Your Name],
    date: [Date],
    institution: [Your Institution],
    logo: image("assets/logo.png", width: 6em),
  ),
)

#set heading(numbering: "1.")

#title-slide()

= Introduction

#slide[
  #block[
    #text(weight: "bold", size: 1.2em)[Welcome]
    #v(0.5em)
    #text[This is a template slide. Replace this content with your own.]
    
    #v(1em)
    #text(weight: "bold")[Key Points:]
    #list[
      - Point 1: Explain your first key point here
      - Point 2: Add your second important point
      - Point 3: Include any additional points
    ]
  ]
]

#slide[
  #block[
    #text(weight: "bold", size: 1.2em)[About This Presentation]
    #v(0.5em)
    #text[Use this slide to introduce yourself and the topic.]
    
    #v(1em)
    #text(weight: "bold")[What You'll Learn:]
    #list[
      - Learning objective 1
      - Learning objective 2
      - Learning objective 3
    ]
  ]
]

= Main Content

#slide[
  #block[
    #text(weight: "bold", size: 1.2em)[Your Main Topic]
    #v(0.5em)
    #text[This is where you present your main content.]
    
    #v(1em)
    #text(weight: "bold")[Important Concepts:]
    #list[
      - Concept 1: Explain the first concept
      - Concept 2: Describe the second concept
      - Concept 3: Detail the third concept
    ]
  ]
]

#slide[
  #block[
    #text(weight: "bold", size: 1.2em)[Detailed Explanation]
    #v(0.5em)
    #text[Use this slide for more detailed explanations or examples.]
    
    #v(1em)
    #text(weight: "bold")[Example:]
    #text(style: "italic")[Provide a concrete example here to illustrate your point.]
    
    #v(1em)
    #text(weight: "bold")[Key Takeaway:]
    #text[Summarize the main point of this slide.]
  ]
]

= Examples and Applications

#slide[
  #block[
    #text(weight: "bold", size: 1.2em)[Real-World Applications]
    #v(0.5em)
    #text[Show how your topic applies in practice.]
    
    #list[
      - #text(weight: "bold")[Application 1]: Describe how this is used in practice
      - #text(weight: "bold")[Application 2]: Show another practical example
      - #text(weight: "bold")[Application 3]: Include additional applications
    ]
  ]
]

= Conclusion

#slide[
  #block[
    #text(weight: "bold", size: 1.2em)[Summary]
    #v(0.5em)
    #text[Summarize the key points of your presentation.]
    
    #v(1em)
    #text(weight: "bold")[Key Takeaways:]
    #list[
      - Main point 1
      - Main point 2
      - Main point 3
    ]
    
    #v(1em)
    #text(weight: "bold")[Next Steps:]
    #text[What should the audience do next?]
  ]
]

#slide[
  #block[
    #text(weight: "bold", size: 1.2em)[Thank You]
    #v(0.5em)
    #text[Thank your audience and provide contact information if relevant.]
    
    #v(1em)
    #text(weight: "bold")[Questions?]
    #text[Encourage questions and discussion.]
  ]
]

