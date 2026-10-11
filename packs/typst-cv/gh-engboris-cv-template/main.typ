#import "cv.typ": *

#show: project.with(
  title: lorem(10),
  firstname: "First",
  familyname: "Second",
  website: "www.website.net",
  email: "name@email.com",
  github: "https://github.com/username",
  phone: "+00 0 00 00 00 00",
  main_color: eastern,
  main_font: "Helvetica",
  socials_below_name: false,
)

= Education

#cv_list(
  [*PhD in Computer Science*],
  [Université Paris 13],
  [2019--2023],

  [*Master Parisien de Recherche en Informatique (MPRI)*],
  [Université Paris 7],
  [2018–2019],

  [*Bachelor in Computer Science*],
  [Université Paris 7],
  [2016--2017]
)

= Experience

#cv_block(
  title: [Put a title here],
  year: [Date--Date],
  subtitle:[Put a subtitle here],
  place: [Some place],
  description: [#lorem(40)]
)

#cv_block(
  title: [Put a title here],
  year: [Date--Date],
  subtitle:[Put a subtitle here],
  place: [Some place],
  description: [#lorem(40)]
)

#cv_block(
  title: [Put a title here],
  year: [Date--Date],
  subtitle:[Put a subtitle here],
  place: [Some place],
  description: [#lorem(40)]
)

#cv_block(
  title: [Put a title here],
  year: [Date--Date],
  subtitle:[Put a subtitle here],
  place: [Some place],
  description: [#lorem(40)]
)

= Skills

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  cv_item([Programming], [Skill1, Skill2, Skill3, Skill4, Skill5]),
  cv_item([Project management], [Skill1, Skill2]),
  cv_item([Web development], [Skill1, Skill2, Skill3]),
  cv_item([Typesetting], [Skill1, Skill2]),
)

= Languages

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  cv_item([French], [Native]),
  cv_item([English], [Professional proficiency]),
  cv_item([Japanese], [Professional proficiency]),
  cv_item([Italian], [Professional proficiency]),
  cv_item([Spanish], [Professional proficiency]),
)

= Hobbies

#lorem(15)
