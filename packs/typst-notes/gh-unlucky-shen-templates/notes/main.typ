#import "template.typ": project, definition, note

#show: project.with(
  title: " ",
  subtitle: " ",
  author: " ",
)

= Heading 1.

== Heading 2.

=== Heading 3.

\

#definition(" ")[
  A type of machine learning where the model is trained on labeled data.
]

#note[
  Remember to check the dataset distribution before training.
]
