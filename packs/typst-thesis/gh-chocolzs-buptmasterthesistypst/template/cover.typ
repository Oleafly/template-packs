#import "common.typ": *

#let chinese-cover(info, fonts: default-fonts, title_alignment: center) = {
  set page(
    paper: "a4",
    margin: (top: 25mm, bottom: 16mm, left: 25mm, right: 25mm),
    header: none,
    footer: none,
    numbering: none,
  )
  set text(font: fonts.body, size: 14pt)
  set par(first-line-indent: 0pt, justify: false)

  align(right)[#text(weight: "bold")[密级：#info.confidentiality]]
  v(5mm)
  align(center)[#move(dx: 0.9mm, dy: 0.4pt)[#image("/assets/img/name.png", width: 121mm)]]
  v(2mm)
  align(center)[
    #text(font: fonts.heading, size: 32pt, weight: "bold")[
      #degree-name-zh(info)学位论文（#degree-type-zh(info)）
    ]
  ]
  v(7.6mm)
  align(center)[#image("/assets/img/logo.png", width: 34.3mm, height: 33.4mm)]
  v(7.9mm)

  pad(left: 13mm)[
    #grid(
      columns: (19mm, 104mm),
      align: top,
      form-label(
        [题目：],
        height: 10mm,
        font: fonts.body,
        size: 18pt,
        alignment: left,
      ),
      multi-line-form-field(
        info.title_zh,
        width: 104mm,
        font: fonts.body,
        size: 18pt,
        alignment: title_alignment,
      ),
    )
  ]
  v(3.3mm)

  pad(left: 31.5mm)[
    #grid(
      columns: (30mm, 53mm),
      row-gutter: 3pt,
      align: top,
      form-label([学　　号：], height: 10mm, font: fonts.body), form-field(info.student_id, width: 53mm, height: 10mm, font: fonts.body),
      form-label([姓　　名：], height: 10mm, font: fonts.body), form-field(info.author_zh, width: 53mm, height: 10mm, font: fonts.body),
      form-label([学科专业：], height: 10mm, font: fonts.body), form-field(info.major_zh, width: 53mm, height: 10mm, font: fonts.body),
      form-label([学习方式：], height: 10mm, font: fonts.body), form-field(study-mode-zh(info), width: 53mm, height: 10mm, font: fonts.body),
      form-label([导　　师：], height: 10mm, font: fonts.body), form-field(info.supervisor_zh, width: 53mm, height: 10mm, font: fonts.body),
      form-label([学　　院：], height: 10mm, font: fonts.body), form-field(info.institute_zh, width: 53mm, height: 10mm, font: fonts.body),
    )
  ]
  v(11.6mm)
  align(center)[#text(size: 14pt, weight: "bold")[#date-zh(info.date)]]
}

#let english-cover(info, fonts: default-fonts, title_alignment: center) = {
  set page(
    paper: "a4",
    margin: (top: 45.1mm, bottom: 20mm, left: 25mm, right: 25mm),
    header: none,
    footer: none,
    numbering: none,
  )
  set text(font: fonts.latin, size: 14pt)
  set par(first-line-indent: 0pt, justify: false)

  if info.confidentiality_en != "Public" {
    align(right)[#text(weight: "bold")[Secret Level: #info.confidentiality_en]]
    v(4mm)
  }
  align(center)[#move(dx: 1.1mm)[#image("/assets/img/bupt_en_name_and_seal.pdf", width: 159mm)]]
  v(9.8mm)
  align(center)[
    #text(size: 24pt)[#degree-name-en(info) #thesis-name-en(info)]
  ]
  v(13.9mm)
  align(center)[
    #move(dx: 3.2mm)[
      #multi-line-form-field(
        info.title_en,
        width: 140mm,
        height: 10.5mm,
        row-gap: 2.2pt,
        font: fonts.latin,
        size: 18pt,
        alignment: title_alignment,
      )
    ]
  ]
  v(19.3mm)
  pad(left: 24.2mm)[
    #grid(
      columns: (40mm, 52mm),
      row-gutter: 3pt,
      align: top,
      form-label([Student ID：], height: 10mm, font: fonts.latin), form-field(info.student_id, width: 52mm, height: 10mm, font: fonts.latin),
      form-label([Author：], height: 10mm, font: fonts.latin), form-field(info.author_en, width: 52mm, height: 10mm, font: fonts.latin),
      form-label([Subject：], height: 10mm, font: fonts.latin), form-field(info.major_en, width: 52mm, height: 10mm, font: fonts.latin),
      form-label([Supervisor：], height: 10mm, font: fonts.latin), form-field(info.supervisor_en, width: 52mm, height: 10mm, font: fonts.latin),
      move(dy: 13pt)[#form-label([Institute：], height: 10mm, font: fonts.latin)],
      move(dy: 13pt)[#form-field(info.institute_en, width: 52mm, height: 10mm, font: fonts.latin)],
    )
  ]
  v(21.6mm)
  align(center)[#text(weight: "bold")[#date-en(info.date)]]
}

#let committee-page(info, committee, fonts: default-fonts) = {
  set page(
    paper: "a4",
    margin: (top: 25.4mm, bottom: 25.4mm, left: 31.7mm, right: 31.7mm),
    header: none,
    footer: none,
    numbering: none,
  )
  set text(font: fonts.body, size: 12pt)
  set par(first-line-indent: 0pt, justify: false)

  v(14.8mm)
  align(center)[#text(font: fonts.heading, size: 16pt)[答辩委员会名单]]
  v(-0.25mm)
  move(dx: -1.9mm)[
    #block(width: 149.6mm)[
      #table(
        columns: (22mm, 22.5mm, 27.5mm, 1fr),
        align: center + horizon,
        inset: (x: 4pt, y: 8.2pt),
        stroke: 0.5pt,
        [职务], [姓　名], [职　称], [工　作　单　位],
        ..committee.map(row => (row.role, row.name, row.title, row.affiliation)).flatten(),
        [答辩日期],
        table.cell(colspan: 3)[#align(center)[#date-zh(info.defense_date)]],
      )
    ]
  ]
}
