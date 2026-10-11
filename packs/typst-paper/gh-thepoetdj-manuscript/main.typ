#import "template.typ": manuscript, chapter, scenebreak, end

#show: manuscript.with(
  title: [The Last Typewriter],
  author: [John Q. Writer],
  last-name: [Writer],
  contact-info: [
    John Q. Writer \
    123 Ink Ribbon Lane \
    Paper Town, NY 10001 \
    (555) 012-3456 \
    john\@writer.com
  ],
  word-count: [500],
)

// Modular inclusion of content
#include "chapters/chapter1.typ"

#end()
