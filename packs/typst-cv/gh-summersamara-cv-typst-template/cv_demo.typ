#import "template.typ": cv, skills_group_struct, timeline_struct

#cv(
    theme_color: rgb("#6b0840ff"),
    name: "Jane Due",
    title: "Full-stack developer",
    personal: (
        Email: "janedue@example.com",
        Phone: "+49 1040 404040",
        Location: "Berlin, Germany",
        Github: "@janedue",
        Website: "www.janedue.name"
    ),
    languages_section_title: "Speaks",
    languages: (
        English: "Advanced",
        French: "Basic",
        Lorem: "Native",
    ),
    skills: (
        skills_group_struct(
            group_title: "Languages & Frameworks",
            advanced_skills: (
                "PHP",
                "Python",
            ),
            skills: (
                "Rust",
            )
        ),
        skills_group_struct(
            group_title: "Front-end development",
            advanced_skills: (
                "React",
                "Node.js",
                "Typescript",
                "Javascript",
            ),
        ),
        skills_group_struct(
            group_title: "Database & Storage",
            advanced_skills: (
                "MySQL",
                "MariaDB",
                "Postgres",
                "Redis",
            ),
            skills: (
                "MongoDB",
            )
        ),
        skills_group_struct(
            group_title: "DevOps & Tools",
            advanced_skills: (
                "Git",
                "Docker",
                "Composer",
                "AWS",
                "Kubernetes"
            )
        )
    ),
    timelines: (
        "Work Experience": (
            timeline_struct(
                from: "06/2022",
                to: "present (3 years)",
                place: "Magnam Travel",
                address: "Hamburg, Germany",
                position: "Full stack developer",
                notes: (
                    "Designed " + lorem(8),
                    "Worked on " + lorem(12),
                )
            ),
            timeline_struct(
                from: "06/2019",
                to: "03/2022 (3 years)",
                place: "Adipiscing Electronics",
                address: "Bonn, Germany",
                position: "Web developer",
                notes: (
                    "Developed " + lorem(8),
                    "Collaborated on " + lorem(4),
                    "Wrote tests for " + lorem(6),
                )
            ),
            timeline_struct(
                from: "06/2018",
                to: "02/2019 (1 year)",
                place: "eiusmodtempor.nl",
                address: "Amsterdam, Netherlands",
                position: "Junior developer",
                notes: (
                    "Worked on solutions for " + lorem(7),
                )
            )
        ),

        "Education": (
            timeline_struct(
                from: "06/2012",
                to: "06/2017",
                place: "Ipsum University",
                address: "Paris, France",
                position: "Consec Science",
                notes: (
                    "Studied " + lorem(8),
                )
            ),
        )
    )
)
