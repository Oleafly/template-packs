#import "/template/template.typ": htl-doc

#let title = "HTL Saalfelden Thesis Requirements Template - Manual"
#set document(title: title)
#set text(size: 11pt)
#set page(
  paper: "a4",
  margin: (top: 2cm, bottom: 2cm, left: 2cm, right: 2cm),
  numbering: "1",
)

#align(center)[
  #text(size: 18pt, weight: "bold")[#title]
  #v(0.5cm)
  #text(size: 12pt)[Version 0.1.0]
]

#v(1cm)

= Introduction

This package provides a Typst template for creating thesis requirements specifications (Pflichtenheft) for HTL Saalfelden diploma theses.

= Usage

Import the template:

```typ
#import "@preview/htl-saalfelden-thesis-requirements:0.1.4": htl-doc
```

Apply it with parameters:

```json
{
  "title": "Thesis Title",
  "subtitle": "Subtitle",
  "lang": "en",
  "school-year": "2026/27",
  "class": "5AHETS",
  "department": "Electrical Engineering",
  "authors": "Johannes Höllwerth",
  "candidates": [
    {
      "name": "Johannes Höllwerth",
      "class": "5AHETS",
      "task": "Develop foo classification system"
    } 
  ],
  "supervisors": [
    {
      "title": "Dipl.-Ing. Dr.",
      "name": "Gerhard Gaube"
    }
  ],
  "due_date": "15.04.2027"
}
```

```typ
#import "@preview/htl-saalfelden-thesis-requirements:0.1.4": htl-doc

#show: htl-doc.with(json(requirements.json))
```

= Parameters

The template accepts the following key parameters:

- `lang` ("de" or "en", default "de")
- `title`, `subtitle`
- `school`, `department`, `school-year`
- `authors`, `class`, `due_date`
- `candidates`: array of dictionaries with `name`, `class`, `task`
- `supervisors`: array of dictionaries with `title`, `name`
- `cover` (boolean), `doc-type`
- `header-left`, `header-center`, `header-right`
- `footer-left`, `footer-center`, `cover-footer`
- `school-logo`, `htl-logo` (defaults to `assets/*.svg`)
- `font`, `cover-font`
- `usage`, `abstract`, `thesis-number`, `project-number`

See the template source for full details.
