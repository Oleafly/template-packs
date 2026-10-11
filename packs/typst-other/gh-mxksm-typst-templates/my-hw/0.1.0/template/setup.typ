#import "config.typ": *
#import "environments.typ": *

#let get-now() = {
  let now-str = if "now" in sys.inputs {
    sys.inputs.now
  } else {
    datetime.today().display("[year] [month] [day]") + " 00 00 00"
  }
  let (year, month, day, hour, minute, second) = now-str.split(" ").map(int)
  return datetime(year: year, month: month, day: day, hour: hour, minute: minute, second: second)
}

#let project(title: title, authors: authors, show_info: true, body) = {
  // Set the document's basic properties.
  let title = course + " " + title

  if q.sum() == 1 {
    for i in range(q.len()) {
      if q.at(i) == 1 {
        // change i + 1 to i if wanna start from problem 0
        title = title + " Problem " + str(i + 1)
        if grading == 1 {
          title = title + " Self Graded"
        }

        break
      }
    }
  }

  set document(author: authors, title: title)
  set text(font-size, font: font, lang: "en")
  show raw: text.with(font: font)

  set page(
    header: context {
      if here().page() == 1 {
        let datetimeobj = get-now()
        let ts = datetimeobj.display("[year]-[month]-[day]") + " at " + datetimeobj.display("[hour]:[minute]:[second]")
        // uncomment for compiled on
        //align(right, h(1fr) + emph("Compiled on " + ts))
      }
    },
    paper: "us-letter",
    numbering: "1", 
    margin: (top: 1.5in, bottom: 1.5in, left: 1.5in, right: 1.5in),
  )

  if show_info {
    // Title row.
    align(center)[
      #block(text(weight: 700, 1.75em, title))
    ]
    
    // Author information.
    pad(
      top: 0.5em,
      bottom: 0.5em,
      x: 2em,
      grid(
        columns: (1fr,) * calc.min(3, authors.len()),
        gutter: 1em,
        ..authors.map(author => align(center, strong(author))),
      ),
    )
  }
  
  // Main body.
  set par(first-line-indent: 1em, justify: true, spacing: 0.65em)

  body
}
