#import "template.typ": *

#set page(
  margin: (
    left: 9mm,
    right: 9mm,
    top: 9mm,
    bottom: 7mm
  ),
  paper: "us-letter",
)

#set text(font: "Mulish", size: 9pt)
#set list(indent: 3pt, body-indent: 3pt, spacing: 4.5pt)
#set par(leading: 0.62em)
#set block(spacing: 0.62em)

#show: project.with(
  theme: rgb("#1A6FA0"),
  name: "Your Name",
  contact: (
    contact(
      text: "LinkedIn",
      link: "https://www.linkedin.com/in/yourprofile"
    ),
    contact(
      text: "GitHub",
      link: "https://github.com/yourusername"
    ),
    contact(
      text: "your.email\@gmail.com",
      link: "mailto:your.email@gmail.com"
    ),
    contact(
      text: "(123) 456-7890",
    ),
  ),
  summary: [
    *Senior software engineer with X+ years of experience* building scalable applications using *your key technologies*. Describe your most impressive achievement with a *metric*. Mention your most notable project or leadership --- keep it to 2-3 sentences that make a recruiter want to keep reading.
  ],
  skills: (
    ("Languages", ("Swift", "Python", "TypeScript", "Go", "Rust")),
    ("Frameworks", ("UIKit", "SwiftUI", "React", "Node.js", "Django")),
    ("Architecture", ("MVVM", "Clean Architecture", "Microservices", "Event-Driven")),
    ("Tools & Testing", ("Xcode", "Docker", "Git", "CI/CD", "XCTest", "Jest")),
  ),
  main: (
    section(
      title: "Experience",
      content: (
        subSection(
          title: "Company Name",
          titleEnd: "Jan 2023 – Present",
          subTitle: "Senior Software Engineer",
          content: list(
            [*Led result with metric* --- describe what you did, the technology used, and the measurable outcome.],
            [*Another achievement with impact* by doing something specific, resulting in a quantifiable improvement.],
            [*Cross-functional leadership example* --- co-authored specs, drove alignment across teams, shipped with high quality.],
          ),
        ),
        subSection(
          title: "Previous Company",
          titleEnd: "Jun 2020 – Dec 2022",
          subTitle: "Software Engineer",
          content: list(
            [*Improved performance by X%* by migrating legacy system to modern architecture with reactive patterns.],
            [*Architected key system* with specific technologies --- adopted as the team's reference implementation.],
            [*Mentored intern/junior* on a specific feature --- they delivered successfully and received a return offer.],
          ),
        ),
        subSection(
          title: "Earlier Company",
          titleEnd: "Jan 2018 – May 2020",
          subTitle: "Software Engineer",
          content: list(
            [*Shipped high-impact feature* that increased a key business metric by designing and A/B testing across platforms.],
            [*Owned features end-to-end* --- list the features, emphasizing cross-functional ownership and quality.],
          ),
        ),
      ),
    ),
    section(
      title: "Projects & Education",
      content: (
        subSection(
          title: "Side Project Name",
          titleEnd: "2024 – Present",
          subTitle: "Founder & Engineer",
          content: list(
            [*Built and shipped a production app* with a specific architecture --- describe the tech stack and what makes it notable.],
          ),
        ),
        subSection(
          content: [
            #grid(
              columns: (1fr, auto),
              row-gutter: 4pt,
              [*University Name* --- MS, Computer Science],
              [_Dec 2022_],
              [*Another University* --- BS, Computer Science],
              [_May 2020_],
            )
          ],
        ),
      ),
    ),
  ),
  sidebar: (),
)
