#import "config.typ": novel
#set text(lang: "es")

#novel(
  [Novel Title],
  [Author Name],
  (
    [Verse 1],
    [Verse 2],
    [Verse 3],
  ),
  (
    (1,3), // include a range of chapters
    (4,4), // or just one
  ),
)
