#import "/src/lib.typ": *

#show: clean_cv.with(
    name: "Your Name",
    location: "City, Country",
    phone: "+1 (123) 456-7890",
    email: "email@address.com",
    website: "website.com",
)

= Experience

#entry(
    title: "Position title",
    start: "20xx",
    end: "Present",
    organization: "Organization name",
    location: "City, Country",
)
#entry_bullet(lorem(30))
#entry_bullet(lorem(30))
#entry_bullet(lorem(30))

#entry(
    title: "Position title",
    start: "20xx",
    end: "20xx",
    organization: "Organization name",
    location: "City, Country",
)
#entry_bullet(lorem(30))
#entry_bullet(lorem(30))
#entry_bullet(lorem(30))

#entry(
    title: "Position title",
    start: "20xx",
    end: "20xx",
    organization: "Organization name",
    location: "City, Country",
)
#entry_bullet(lorem(20))
#entry_bullet(lorem(20))
#entry_bullet(lorem(20))

= Education

#entry(
    title: "PhD in Something",
    organization: "University of Somewhere",
    start: "20xx",
    end: "20xx",
    location: "City, Country",
)
#entry(
    title: "MS in Something",
    organization: "University of Somewhere",
    start: "20xx",
    end: "20xx",
    location: "City, Country",
)
#entry(
    title: "BS in Something",
    organization: "University of Somewhere",
    start: "20xx",
    end: "20xx",
    location: "City, Country",
)

= Projects

#project(
    name: "Project name",
    website: link(
        "https://website.com/",
        "project-website.com",
    ),
    start: "20xx",
    end: "",
)
#entry_bullet(lorem(10))

#project(
    name: "Project name",
    website: link(
        "https://website.com/",
        "project-website.com",
    ),
    start: "20xx",
    end: "",
)
#entry_bullet(lorem(10))

= Skills

#skill_block(title: "Languages")[
    #skill_level(skill: "Python", level: "8 yrs"), #skill_level(skill: "Rust", level: "2 yrs"), #skill_level(skill: "SQL", level: "5 yrs")
]
#skill_block(title: "Knowledge")[
    Skill one, Skill two, Skill three
]
#skill_block(title: "Technical")[
    Skill one, Skill two, Skill three
]

= Awards

#entry(
    title: "Award name",
    organization: "Organization name",
    start: "20xx",
    end: "",
    location: "",
)
#entry(
    title: "Award name",
    organization: "Organization name",
    start: "20xx",
    end: "",
    location: "",
)

= References

#reference(
    name: "Contact Name",
    position: "Position title",
    organization: "Organization",
    email: link("email@address.com", "email@address.com"),
    phone: "+1 (123) 456-7890",
)
#reference(
    name: "Contact Name",
    position: "Position title",
    organization: "Organization",
    email: link("email@address.com", "email@address.com"),
    phone: "+1 (123) 456-7890",
)

= Publications

#publications("/template/citations.bib")
