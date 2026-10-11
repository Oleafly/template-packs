#import "../../src/component/title.typ": (
  approved-and-agreed-fields,
  per-line,
)
#import "../../src/utils.typ": fetch-field, sign-field, unbreak-name

#let arguments(..args, year: auto) = {
  let args = args.named()
  args.organization = fetch-field(
    args.at("organization", default: none),
    ("*full", "short"),
    hint: "организации",
  )
  args.institute = fetch-field(
    args.at("institute", default: none),
    ("number", "name"),
    default: (number: "", name: ""),
    hint: "института",
  )
  args.department = fetch-field(
    args.at("department", default: none),
    ("number", "name"),
    default: (number: "", name: ""),
    hint: "кафедры",
  )
  args.approved-by = fetch-field(
    args.at("approved-by", default: none),
    ("name*", "position*", "year"),
    default: (year: auto),
    hint: "согласования",
  )
  args.agreed-by = fetch-field(
    args.at("agreed-by", default: none),
    ("name*", "position*", "year"),
    default: (year: auto),
    hint: "утверждения",
  )
  args.stage = fetch-field(
    args.at("stage", default: none),
    ("type*", "num"),
    hint: "этапа",
  )
  args.manager = fetch-field(
    args.at("manager", default: none),
    ("position*", "name*"),
    hint: "руководителя",
  )

  if args.approved-by.year == auto {
    args.approved-by.year = year
  }
  if args.agreed-by.year == auto {
    args.agreed-by.year = year
  }
  return args
}

#let mirea-sign(label, position, name) = {
  if name == none { return }
  [
    #label
    #table(
      stroke: none,
      align: (left, center, right),
      columns: (40%, 1fr, 35%),
      inset: (x: 0pt, y: 3pt),
      [#position], [«__» __________ 20__ г.], [#text[/#unbreak-name(name)]],
      table.hline(start: 0, end: 3),
      table.cell(colspan: 3, align: center)[(подпись и расшифровка подписи)]
    )
  ]
}

#let template(
  ministry: none,
  organization: (full: "«МИРЭА – Российский технологический университет»", short: none),
  institute: (number: none, name: none),
  department: (number: none, name: none),
  udk: none,
  research-number: none,
  report-number: none,
  approved-by: (name: none, position: none, year: auto),
  agreed-by: (name: none, position: none, year: none),
  report-type: "Отчёт",
  about: none,
  part: none,
  bare-subject: false,
  research: none,
  subject: none,
  stage: none,
  manager: (position: none, name: none),
  performer: none,
) = {
  // Логотип по центру
  align(center)[#image("logo/mirea-logo.png", width: 25%)]

  v(1em)

  // Тексты организации точно как на скрине
  align(center)[
    #if ministry != none { upper(ministry) + linebreak() }
    Федеральное государственное бюджетное образовательное учреждение высшего образования \
    #text(weight: "bold")[#organization.full] \
    #text(weight: "bold")[РТУ МИРЭА]
  ]

  v(0.5em)

  // Разделительная линия из "=" на всю ширину
  align(center)[#text("=".repeat(70))]

  v(1em)

  // Институт и кафедра с подписями (наименование...)
  if institute.name != none or institute.number != none {
    align(center)[
      Институт #institute.name #if institute.number != none {[(#institute.number)]} \
      (наименование института, филиала)
    ]
  }
  if department.name != none or department.number != none {
    align(center)[
      Кафедра #if department.number != none [#department.number ]#department.name \
      (наименование кафедры)
    ]
  }

  v(1em)

  // Регистрационные номера (слева)
  per-line(
    align: left,
    (value: [УДК: #udk], when-present: udk),
    (value: [Рег. №: #research-number], when-present: research-number),
    (value: [Рег. № ИКРБС: #report-number], when-present: report-number),
  )

  v(1em)

  approved-and-agreed-fields(approved-by, agreed-by)

  // Название работы (ПО ДИСЦИПЛИНЕ вместо "по теме:")
  per-line(
    align: center,
    indent: 2fr,
    (value: upper(report-type), when-present: report-type),
    (value: upper(about), when-present: about),
    (value: [ПО ДИСЦИПЛИНЕ:], when-present: subject),
    (value: upper(subject), when-present: subject),
    (
      value: [(#stage.type)],
      when-rule: (stage.type != none and stage.num == none),
    ),
    (
      value: [(#stage.type, этап #stage.num)],
      when-present: (stage.type, stage.num),
    ),
    (value: [\ Книга #part], when-present: part),
  )

  // Подписи (точно как на скрине)
  if manager.name != none {
    mirea-sign([Проверил:], manager.position, manager.name)
  }
  if performer != none {
    mirea-sign(
      [Выполнил:],
      performer.at("position", default: none),
      performer.at("name", default: none),
    )
  }

  v(0.5fr)
}