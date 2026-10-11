#import "template.typ": *

#set page(
  margin: (left: 8mm, right: 8mm, top: 8mm, bottom: 8mm),
)

// Data source. Override at build time with `typst compile --input data=path/to/cv.yaml ...`
#let dataFile = sys.inputs.at("data", default: "master-cv.yaml")
#let data = yaml(dataFile)

// Font switcher. CLI `--input font=Roboto` overrides the YAML `font:` field.
#let bodyFont = sys.inputs.at("font", default: data.at("font", default: "Inter"))
#set text(font: bodyFont)

#let itemToSubSection(item) = {
  let body = if "bullets" in item {
    let bs = item.bullets.map(b => eval(b, mode: "markup"))
    if "tech" in item {
      bs.push([*Technologies:* #item.tech.join(", ")])
    }
    list(..bs)
  } else if "lines" in item {
    item.lines.map(l => eval(l, mode: "markup")).join([\ ])
  } else {
    []
  }

  subSection(
    title: item.title,
    titleEnd: item.at("titleEnd", default: none),
    subTitle: item.at("subTitle", default: none),
    subTitleEnd: item.at("subTitleEnd", default: none),
    content: body,
  )
}

#let main = data.sections.map(s =>
  section(title: s.title, content: s.items.map(itemToSubSection))
)

#show: project.with(
  theme: rgb(data.at("theme", default: "#0F83C0")),
  name: data.name,
  contact: data.contact.map(c => contact(text: c.text, link: c.at("link", default: none))),
  main: main,
  sidebar: (),
)
