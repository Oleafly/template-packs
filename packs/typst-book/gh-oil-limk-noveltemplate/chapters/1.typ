#import "../config.typ": chapter

#show: doc => chapter(
  [Chapter 1],
  (
    [Verse 1],
    [Verse 2],
    [Verse 3],
  ),
  doc
)

#lorem(60)...
