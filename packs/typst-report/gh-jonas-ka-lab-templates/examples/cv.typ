// CV theme example. Compile from the repository root:
//   typst compile --root . --pdf-standard ua-1 examples/cv.typ build/cv.pdf
#import "/themes/cv-theme.typ": *

#show: cv-doc.with(title: "A. Author, Curriculum Vitae", author: "A. Author")

#heading(level: 1, outlined: false)[A. Author]
Your Institute · you\@example.edu · #link("https://example.edu")[example.edu]

= Positions
#dated(years(2025, none))[*Assistant Professor*, Your Institute]
#dated(years(2021, 2024))[*Postdoctoral Researcher*, Elsewhere]

= Publications
#numbered(1)[A. Author _et al._, "A title", _Journal_ *1*, 1 (2026) #tag[Editors' Suggestion]]

= Mentoring
#numbered-dated(1, years(2025, none))[B. Student, Ph.D. student]
