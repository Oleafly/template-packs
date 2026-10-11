#import "template/template.typ": template, education_entry, skill_entry, work_entry, references_entry, interests_entry, icon, languages_entry, misc_entry

#let name = "John Doe"
#let color = black
#let photo = "photo.jpeg"
#let personal_profile = "lorem(120)"
#let personal_info = ((
  (
    "service": "email",
    "display": "john@doe.ch"
  ),
  (
    "service": "phone",
    "display": "+1 206 555 0100"
  ),
  (
    "service": "nationality",
    "display": "US National"
  ),
  (
    "service": "home",
    "display": "	1600 Pennsylvania Avenue, Washington D.C."
  ),
  (
    "service": "birthday",
    "display": "01.01.1994"
  )
))

#show: doc => template(doc, color, name, photo, personal_profile, personal_info)

= #icon("experience") Work Experience
#work_entry("Chief Hackerman", "National Security Agency", start_date: "Since August 2021", tasks: (
  "Hacked at least 2 nation states, 22 US citizens and one starbucks",
  "Broke international law, like 20 times",
  "Created a system that randomly decides who has to pick up donuts"
  ), location: "Fort Meade, Maryland")
#work_entry("Software Developer ", "Example.com", start_date: "August 2016", end_date: "August 2020", tasks: (
  "Implemented and maintained a system to create fantastic data, to use as examples",
  "Made funny jokes during meetings"
  ), location: "Dallas, Texas")

= #icon("education") Education
#education_entry("Computer Science", "University of Texas",
degree_title: "BSc.", description: "Theoretical education in computer science topics mixed with practical projects in a wide range of subjects.", start_date: "August 2010", end_date: "August 2016", location: "Austin, Texas")

= #icon("skills") Skills 
#skill_entry((
    (
        icon: "git",
        name: [ Git ]
    ),
    (
        icon: "java",
        raise: true,
        name: [ Java ]
    ),
    (
        icon: "springboot",
        name: [ Spring Boot ]
    ),
    (
        icon: "maven",
        name: [ Maven ]
    ),
    (
        icon: "docker",
        raise: true,
        name: [ Docker ]
    ),
    (
        icon: "cicd",
        name: [ CI/CD with Jenkins ]
    ),
    (
        icon: "sonarqube",
        name: [ SonarQube ]
    ),
    (
        icon: "cloudfoundry",
        name: [ Cloud Foundry ]
    ),
))

#languages_entry((
     (
      name: [ English ],
      level: 10,
      acquisition: [ Native language ],
    ),
    (
      name: [ English(British Accent) ],
      level: 1,
      acquisition: [ "Cool, innit?" ],
    ),
    (
      name: [ French ],
      level: 1, 
      acquisition: [ Can say "French Fries" ],
    ))
)

= #icon("interests") Interests & Hobbies
#interests_entry((
    (
        name: [ Invisible Object Photography ],
        description: [ 
          I delight in the whimsical world of invisible object photography, capturing the hilarity of pretending with non-existent item It's a playful exploration where creativity knows no bounds, yielding laughter-filled snapshots.
        ]
    ),
    (
        name: [ Pet Rock Olympics ],
        description: [ 
          Participating in the Pet Rock Olympics is a riot! Almost clinching victory in absurd events like rock rolling and synchronize rock swimming made for a side-splitting, near-triumphant experience.
         ]
    )
))

= #icon("online") Online Presence
#misc_entry(
  (
    (
      label: [ GitHub ],
      value: [ https://github.com/Example ]
    ),
    (
      label: [ Website ],
      value: [ https://example.com ]
    )
  )
)

= #icon("references") References
#references_entry((
    (
      name: [ Jane Smith ],
      role: [ Software Architect at Example.com ],
      email: "jane.smith@example.com",
      phone: "+1 206 555 0200",
    ),
    (
      name: [ Harry Schmo ],
      role: [ Scrum Master at Example.com ],
      email: "harry.schmo@example.com",
      phone: "+1 206 555 0300",
    ),
))