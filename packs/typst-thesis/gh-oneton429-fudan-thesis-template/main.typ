#import "styles.typ": template
#import "config.typ": chapter_num
#include "cover/cover.typ"

#counter(page).update(1)
#show: template
#include "contents.typ"
#include "chapters/abstract-zh.typ"
#include "chapters/abstract-en.typ"
#set page(numbering: "1")
#counter(page).update(1)

#for chapter_id in range(1, chapter_num + 1) {
  include "chapters/" + numbering("01", chapter_id) + ".typ"
}

#include "bibliography.typ"
#include "chapters/acknowledgments.typ"
