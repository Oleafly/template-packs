#import "styles.typ": *

#show: template.with(
  book: (
    title: [Título do Livro],
    author: (
      long: [Nome Sobrenome],
      short: [Sobrenome, N.]
    )
  ),
  author: [Igo da Costa Andrade]
)



#include "chapters/chapther-01.typ"
#include "chapters/chapther-02.typ"
#include "chapters/chapther-03.typ"
#include "chapters/chapther-04.typ"
#include "chapters/chapther-05.typ"