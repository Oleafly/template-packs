#import "/pvc_template.typ": *
#show: vinyl-theme.with(
  config-info(
    title: [Your Title],
    date: [[Current Date]],
  ),
)

#title-slide()

== Example Slide Header
Example text content.

#pause

More example text content on click.

#emphasis-slide[Emphasis goes here.]

#releases-slide(
  next-theme: [Themed Albums],
  featured: (
    (artist: [Artist Name], album: [Album Name], genres: [Genre, Genre]),
  )
    * 3,
  releases: (
    ("Artist", "Album"),
    ("Artist", "Album"),
    ("Artist", "Album"),
    ("Artist", "Album"),
    ("Artist", "EP", "EP"),
    ("Artist", "Song", "Single"),
    ("Artist", "Song", "Single"),
  ),
)
