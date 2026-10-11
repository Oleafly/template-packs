#import "lib.typ": jdoc

#show: jdoc.with(
  title: "日本語ドキュメントのテンプレート",
  author: "著者名",
  date: datetime.today().display("[year]年[month]月[day]日"),
  bib: "refs.bib",
  // 前書きは別ファイルに分ける。include は式としても使える
  preface: include "preface.typ",
)

// 章は chapters/ 以下に分け、ここで並べる
#include "templates/01-intro.typ"
#include "templates/02-format.typ"
#include "templates/03-math.typ"
#include "templates/04-code.typ"
#include "templates/05-quote.typ"
#include "templates/06-bib.typ"
#include "templates/07-footnote.typ"
#include "templates/08-figure.typ"
#include "templates/09-theorem.typ"
#include "templates/10-diagram.typ"
#include "templates/11-flowchart.typ"
#include "templates/12-fletcher.typ"
#include "templates/13-er.typ"
