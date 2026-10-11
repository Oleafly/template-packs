#import "../lib/lib.typ": project-meta

= Acknowledgement

#context {
  let meta = project-meta.get()

  [
    We would like to express our sincere gratitude to #meta.supervisor, Head of the Department and our supervisor for his invaluable guidance and unwavering support throughout the preparation of this project. His insightful suggestions and constructive feedback have been instrumental in shaping our work, and we are truly appreciative of the time and effort he dedicated to our development. His leadership has not only provided us with direction but has also inspired us to pursue excellence in our academic endeavors.

    We are also deeply thankful to our esteemed teachers and faculty members for their encouragement and thoughtful insights, which have significantly enriched this proposal. Their commitment to academic excellence and their willingness to share knowledge have served as a constant source of inspiration for us. The collective guidance and support we received from them have greatly contributed to the refinement and improvement of our work, and we are sincerely grateful for their contributions.

    \
  ]

  for member in meta.by [
    *#member* \
  ]
}
