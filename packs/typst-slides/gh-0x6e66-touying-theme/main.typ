#import "@preview/touying:0.6.3": *
#import "theme.typ": *

#show: theme.with(
  config-info(
    title: [Title],
    author: [Author],
    date: datetime.today(),
  ),
)

#title-slide()

= 1

1 @lorem

== 2

1 - 2

=== 3

1 - 2 - 3

==== 4.1

1 - 2 - 3 - 4.1

==== 4.2

1 - 2 - 3 - 4.2

==== 4.3

1 - 2 - 3 - 4.3

= sources

#set text(size: 10pt)
#bibliography(title: none, "main.bib")
