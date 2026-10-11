#import "lib.typ": *

#show: cv.with(
  // The language filed change the language of the titles
  // It is used to add the data protection section,
  // necessary if you want to the cv in Italy, and
  // change the title of the prelabeled section (eg.#contacts-section)
  // Can be either "english", "italian"
  language: "english",
  margin: 0.5in,
  name: "Mario Rossi",
  description: "I'm a goat passionate about shiny wafer. Open source entousiast, I use Arch BTW :)",
  location: "Windy Hill",
  side: [
    #profile-picture("images/sample_profile_picture.jpeg")
    
    #contacts-section()[
      // #contact-entry("type", "contact")
      // type can be {email, github, linkedin, phone}
      #contact-entry("email", "username@email-server.tld")
      #contact-entry("github", "https://github.com/the-rest-of-the-link")
      #contact-entry("linkedin", "https://www.linkedin.com/the-rest-of-the-link")
    ]

    #languages-section()[
      // #language-entry("language", "level")
      #language-entry("Esperanto", "Native")
      #language-entry("English", "B2")
    ]

    #skills-section()[
      Group work

      Communication
    ]

    #hobbies-section()[
      Jump
      
      Lick salt
    ]
  ]
)

#section("Work experience")[
  // #work-entry()
  #work-entry(
    "Silicon alternative researcher",
    "Cliff SRL",
    "Windy Hill",
    "2020-now"
  )
]

#section("Education")[
  // #education-entry("course name", "degree type", "emitter organisation", "years", skills: [skills list])
  #education-entry(
    "Material engineering - curricula on semiconductor", 
    "Master of Science", 
    "University of Windy Hill", 
    "Windy Hill",
    "2018-2020"
  )
  #education-entry(
    "Chemical engineering", 
    "Bachelor of Science", 
    "University of Hornville", 
    "Hornville",
    "2015-2018"
  )
  #education-entry(
    "Scientific", 
    "High School", 
    "Public liceum of Hornville", 
    "Hornville",
    "2010-2015"
  )
]

