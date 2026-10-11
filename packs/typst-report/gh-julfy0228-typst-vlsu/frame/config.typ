#let thin-stroke = .3mm
#let thick-stroke = .8mm

#let tables = (
  form-1: (
    width: 185mm,
    height: 55mm,
    cells: (
      (x: 0mm, y: 0mm, width: 7mm, height: 5mm),
      (x: 7mm, y: 0mm, width: 10mm, height: 5mm),
      (x: 17mm, y: 0mm, width: 23mm, height: 5mm),
      (x: 40mm, y: 0mm, width: 15mm, height: 5mm),
      (x: 55mm, y: 0mm, width: 10mm, height: 5mm),

      (x: 0mm, y: 5mm, width: 7mm, height: 5mm),
      (x: 7mm, y: 5mm, width: 10mm, height: 5mm),
      (x: 17mm, y: 5mm, width: 23mm, height: 5mm),
      (x: 40mm, y: 5mm, width: 15mm, height: 5mm),
      (x: 55mm, y: 5mm, width: 10mm, height: 5mm),

      (x: 0mm, y: 10mm, width: 7mm, height: 5mm),
      (x: 7mm, y: 10mm, width: 10mm, height: 5mm),
      (x: 17mm, y: 10mm, width: 23mm, height: 5mm),
      (x: 40mm, y: 10mm, width: 15mm, height: 5mm),
      (x: 55mm, y: 10mm, width: 10mm, height: 5mm),

      (x: 0mm, y: 15mm, width: 7mm, height: 5mm),
      (x: 7mm, y: 15mm, width: 10mm, height: 5mm),
      (x: 17mm, y: 15mm, width: 23mm, height: 5mm),
      (x: 40mm, y: 15mm, width: 15mm, height: 5mm),
      (x: 55mm, y: 15mm, width: 10mm, height: 5mm),

      (x: 0mm, y: 20mm, width: 7mm, height: 5mm, text: [Изм.]),
      (x: 7mm, y: 20mm, width: 10mm, height: 5mm, text: [Лист]),
      (x: 17mm, y: 20mm, width: 23mm, height: 5mm, text: [№ докум.]),
      (x: 40mm, y: 20mm, width: 15mm, height: 5mm, text: [Подп.]),
      (x: 55mm, y: 20mm, width: 10mm, height: 5mm, text: [Дата]),

      (x: 0mm, y: 25mm, width: 17mm, height: 5mm, text: [Разраб.]),
      (x: 17mm, y: 25mm, width: 23mm, height: 5mm, text: "_developed"),
      (x: 40mm, y: 25mm, width: 15mm, height: 5mm),
      (x: 55mm, y: 25mm, width: 10mm, height: 5mm),

      (x: 0mm, y: 30mm, width: 17mm, height: 5mm, text: [Пров.]),
      (x: 17mm, y: 30mm, width: 23mm, height: 5mm, text: "_checked"),
      (x: 40mm, y: 30mm, width: 15mm, height: 5mm),
      (x: 55mm, y: 30mm, width: 10mm, height: 5mm),

      (x: 0mm, y: 35mm, width: 17mm, height: 5mm, text: [Т. контр.]),
      (x: 17mm, y: 35mm, width: 23mm, height: 5mm, text: "_technical_controlled"),
      (x: 40mm, y: 35mm, width: 15mm, height: 5mm, hidden-when: "_technical-control"),
      (x: 55mm, y: 35mm, width: 10mm, height: 5mm, hidden-when: "_technical-control"),

      (x: 0mm, y: 40mm, width: 17mm, height: 5mm),
      (x: 17mm, y: 40mm, width: 23mm, height: 5mm),
      (x: 40mm, y: 40mm, width: 15mm, height: 5mm),
      (x: 55mm, y: 40mm, width: 10mm, height: 5mm),

      (x: 0mm, y: 45mm, width: 17mm, height: 5mm, text: [Н. контр.]),
      (x: 17mm, y: 45mm, width: 23mm, height: 5mm, text: "_standard_controlled"),
      (x: 40mm, y: 45mm, width: 15mm, height: 5mm),
      (x: 55mm, y: 45mm, width: 10mm, height: 5mm),

      (x: 0mm, y: 50mm, width: 17mm, height: 5mm, text: [Утв.]),
      (x: 17mm, y: 50mm, width: 23mm, height: 5mm, text: "_approved"),
      (x: 40mm, y: 50mm, width: 15mm, height: 5mm),
      (x: 55mm, y: 50mm, width: 10mm, height: 5mm),

      (x: 65mm, y: 0mm, width: 120mm, height: 15mm, text: "_title", text-size: 7mm, align: center),

      (x: 65mm, y: 15mm, width: 70mm, height: 25mm, text: "_description", align: center),

      (x: 135mm, y: 15mm, width: 15mm, height: 5mm, text: [Лит.]),
      (x: 135mm, y: 20mm, width: 5mm, height: 15mm, text: "_lit0", align: center),
      (x: 140mm, y: 20mm, width: 5mm, height: 15mm, text: "_lit1", align: center),
      (x: 145mm, y: 20mm, width: 5mm, height: 15mm, text: "_lit2", align: center),

      (x: 150mm, y: 15mm, width: 15mm, height: 5mm, text: [Масса]),
      (x: 150mm, y: 20mm, width: 15mm, height: 15mm, text: "_mass", align: center),

      (x: 165mm, y: 15mm, width: 20mm, height: 5mm, text: [Масштаб]),
      (x: 165mm, y: 20mm, width: 20mm, height: 15mm, text: "_scale", align: center),

      (x: 135mm, y: 35mm, width: 20mm, height: 5mm, text: fields => [Лист #fields.at("_page")]),
      (x: 155mm, y: 35mm, width: 30mm, height: 5mm, text: fields => [Листов #fields.at("_pages")]),

      (x: 135mm, y: 40mm, width: 50mm, height: 15mm, text: "_group", text-size: 7mm, align: center),
    ),
    lines: (
      // Вертикальные линии
      (x1: 0mm, y1: 0mm, x2: 0mm, y2: 55mm, stroke: thick-stroke),
      (x1: 185mm, y1: 0mm, x2: 185mm, y2: 55mm, stroke: thick-stroke),
      (x1: 65mm, y1: 0mm, x2: 65mm, y2: 55mm, stroke: thick-stroke),
      (x1: 17mm, y1: 0mm, x2: 17mm, y2: 55mm, stroke: thick-stroke),
      (x1: 7mm, y1: 0mm, x2: 7mm, y2: 25mm, stroke: thick-stroke),
      (x1: 40mm, y1: 0mm, x2: 40mm, y2: 55mm, stroke: thick-stroke),
      (x1: 55mm, y1: 0mm, x2: 55mm, y2: 55mm, stroke: thick-stroke),
      (x1: 135mm, y1: 15mm, x2: 135mm, y2: 55mm, stroke: thick-stroke),
      (x1: 150mm, y1: 15mm, x2: 150mm, y2: 35mm, stroke: thick-stroke),
      (x1: 165mm, y1: 15mm, x2: 165mm, y2: 35mm, stroke: thick-stroke),
      (x1: 155mm, y1: 35mm, x2: 155mm, y2: 40mm, stroke: thick-stroke),

      // Горизонтальные линии
      (x1: 0mm, y1: 0mm, x2: 185mm, y2: 0mm, stroke: thick-stroke),
      (x1: 0mm, y1: 55mm, x2: 185mm, y2: 55mm, stroke: thick-stroke),
      (x1: 65mm, y1: 15mm, x2: 185mm, y2: 15mm, stroke: thick-stroke),
      (x1: 0mm, y1: 20mm, x2: 65mm, y2: 20mm, stroke: thick-stroke),
      (x1: 0mm, y1: 25mm, x2: 65mm, y2: 25mm, stroke: thick-stroke),
      (x1: 135mm, y1: 20mm, x2: 185mm, y2: 20mm, stroke: thick-stroke),
      (x1: 135mm, y1: 35mm, x2: 185mm, y2: 35mm, stroke: thick-stroke),
      (x1: 65mm, y1: 40mm, x2: 185mm, y2: 40mm, stroke: thick-stroke)
    )
  ),
  form-2: (
    width: 185mm,
    height: 40mm,
    cells: (
      (x: 0mm, y: 0mm, width: 7mm, height: 5mm),
      (x: 7mm, y: 0mm, width: 10mm, height: 5mm),
      (x: 17mm, y: 0mm, width: 23mm, height: 5mm),
      (x: 40mm, y: 0mm, width: 15mm, height: 5mm),
      (x: 55mm, y: 0mm, width: 10mm, height: 5mm),

      (x: 0mm, y: 5mm, width: 7mm, height: 5mm),
      (x: 7mm, y: 5mm, width: 10mm, height: 5mm),
      (x: 17mm, y: 5mm, width: 23mm, height: 5mm),
      (x: 40mm, y: 5mm, width: 15mm, height: 5mm),
      (x: 55mm, y: 5mm, width: 10mm, height: 5mm),

      (x: 0mm, y: 10mm, width: 7mm, height: 5mm, text: [Изм.]),
      (x: 7mm, y: 10mm, width: 10mm, height: 5mm, text: [Лист]),
      (x: 17mm, y: 10mm, width: 23mm, height: 5mm, text: [№ докум.]),
      (x: 40mm, y: 10mm, width: 15mm, height: 5mm, text: [Подп.]),
      (x: 55mm, y: 10mm, width: 10mm, height: 5mm, text: [Дата]),

      (x: 0mm, y: 15mm, width: 17mm, height: 5mm, text: [Разраб.]),
      (x: 17mm, y: 15mm, width: 23mm, height: 5mm, text: "_developed"),
      (x: 40mm, y: 15mm, width: 15mm, height: 5mm),
      (x: 55mm, y: 15mm, width: 10mm, height: 5mm),

      (x: 0mm, y: 20mm, width: 17mm, height: 5mm, text: [Пров.]),
      (x: 17mm, y: 20mm, width: 23mm, height: 5mm, text: "_checked"),
      (x: 40mm, y: 20mm, width: 15mm, height: 5mm),
      (x: 55mm, y: 20mm, width: 10mm, height: 5mm),

      (x: 0mm, y: 25mm, width: 17mm, height: 5mm, text: [Т. контр.]),
      (x: 17mm, y: 25mm, width: 23mm, height: 5mm, text: "_technical_controlled"),
      (x: 40mm, y: 25mm, width: 15mm, height: 5mm, hidden-when: "_technical-control"),
      (x: 55mm, y: 25mm, width: 10mm, height: 5mm, hidden-when: "_technical-control"),

      (x: 0mm, y: 30mm, width: 17mm, height: 5mm, text: [Н. контр.]),
      (x: 17mm, y: 30mm, width: 23mm, height: 5mm, text: "_standard_controlled"),
      (x: 40mm, y: 30mm, width: 15mm, height: 5mm),
      (x: 55mm, y: 30mm, width: 10mm, height: 5mm),

      (x: 0mm, y: 35mm, width: 17mm, height: 5mm, text: [Утв.]),
      (x: 17mm, y: 35mm, width: 23mm, height: 5mm, text: "_approved"),
      (x: 40mm, y: 35mm, width: 15mm, height: 5mm),
      (x: 55mm, y: 35mm, width: 10mm, height: 5mm),

      (x: 65mm, y: 0mm, width: 120mm, height: 15mm, text: "_title", text-size: 7mm, align: center),

      (x: 65mm, y: 15mm, width: 70mm, height: 25mm, text: "_description", align: center),

      (x: 135mm, y: 15mm, width: 15mm, height: 5mm, text: [Лит.]),
      (x: 135mm, y: 20mm, width: 5mm, height: 5mm, text: "_lit0", align: center),
      (x: 140mm, y: 20mm, width: 5mm, height: 5mm, text: "_lit1", align: center),
      (x: 145mm, y: 20mm, width: 5mm, height: 5mm, text: "_lit2", align: center),

      (x: 150mm, y: 15mm, width: 15mm, height: 5mm, text: [Лист]),
      (x: 150mm, y: 20mm, width: 15mm, height: 5mm, text: "_page"),

      (x: 165mm, y: 15mm, width: 20mm, height: 5mm, text: [Листов]),
      (x: 165mm, y: 20mm, width: 20mm, height: 5mm, text: "_pages"),

      (x: 135mm, y: 25mm, width: 50mm, height: 15mm, text: "_group", text-size: 7mm, align: center)
    ),
    lines: (
      // Вертикальные линии
      (x1: 0mm, y1: 0mm, x2: 0mm, y2: 40mm, stroke: thick-stroke),
      (x1: 185mm, y1: 0mm, x2: 185mm, y2: 40mm, stroke: thick-stroke),
      (x1: 65mm, y1: 0mm, x2: 65mm, y2: 40mm, stroke: thick-stroke),
      (x1: 17mm, y1: 0mm, x2: 17mm, y2: 40mm, stroke: thick-stroke),
      (x1: 7mm, y1: 0mm, x2: 7mm, y2: 15mm, stroke: thick-stroke),
      (x1: 40mm, y1: 0mm, x2: 40mm, y2: 40mm, stroke: thick-stroke),
      (x1: 55mm, y1: 0mm, x2: 55mm, y2: 40mm, stroke: thick-stroke),
      (x1: 135mm, y1: 15mm, x2: 135mm, y2: 40mm, stroke: thick-stroke),
      (x1: 150mm, y1: 15mm, x2: 150mm, y2: 25mm, stroke: thick-stroke),
      (x1: 165mm, y1: 15mm, x2: 165mm, y2: 25mm, stroke: thick-stroke),

      // Горизонтальные линии
      (x1: 0mm, y1: 0mm, x2: 185mm, y2: 0mm, stroke: thick-stroke),
      (x1: 0mm, y1: 40mm, x2: 185mm, y2: 40mm, stroke: thick-stroke),
      (x1: 0mm, y1: 15mm, x2: 185mm, y2: 15mm, stroke: thick-stroke),
      (x1: 0mm, y1: 10mm, x2: 65mm, y2: 10mm, stroke: thick-stroke),
      (x1: 135mm, y1: 20mm, x2: 185mm, y2: 20mm, stroke: thick-stroke),
      (x1: 135mm, y1: 25mm, x2: 185mm, y2: 25mm, stroke: thick-stroke)
    )
  ),
  form-2a: (
    width: 185mm,
    height: 15mm,
    x: 20mm,
    y: 277mm,
    cells: (
      (x: 0mm, y: 0mm, width: 7mm, height: 5mm),
      (x: 7mm, y: 0mm, width: 10mm, height: 5mm),
      (x: 17mm, y: 0mm, width: 23mm, height: 5mm),
      (x: 40mm, y: 0mm, width: 15mm, height: 5mm),
      (x: 55mm, y: 0mm, width: 10mm, height: 5mm),

      (x: 0mm, y: 5mm, width: 7mm, height: 5mm),
      (x: 7mm, y: 5mm, width: 10mm, height: 5mm),
      (x: 17mm, y: 5mm, width: 23mm, height: 5mm),
      (x: 40mm, y: 5mm, width: 15mm, height: 5mm),
      (x: 55mm, y: 5mm, width: 10mm, height: 5mm),

      (x: 0mm, y: 10mm, width: 7mm, height: 5mm, text: [Изм.]),
      (x: 7mm, y: 10mm, width: 10mm, height: 5mm, text: [Лист]),
      (x: 17mm, y: 10mm, width: 23mm, height: 5mm, text: [№ докум.]),
      (x: 40mm, y: 10mm, width: 15mm, height: 5mm, text: [Подп.]),
      (x: 55mm, y: 10mm, width: 10mm, height: 5mm, text: [Дата]),

      (x: 65mm, y: 0mm, width: 110mm, height: 15mm, text: "_title", text-size: 7mm, align: center),

      (x: 175mm, y: 0mm, width: 10mm, height: 7mm, text: [Лист]),
      (x: 175mm, y: 7mm, width: 10mm, height: 8mm, text: "_page", align: center)
    ),
    lines: (
      // Вертикальные линии
      (x1: 185mm, y1: 0mm, x2: 185mm, y2: 15mm, stroke: thick-stroke),
      (x1: 65mm, y1: 0mm, x2: 65mm, y2: 15mm, stroke: thick-stroke),
      (x1: 175mm, y1: 0mm, x2: 175mm, y2: 15mm, stroke: thick-stroke),
      (x1: 0mm, y1: 0mm, x2: 0mm, y2: 15mm, stroke: thick-stroke),
      (x1: 7mm, y1: 0mm, x2: 7mm, y2: 15mm, stroke: thick-stroke),
      (x1: 17mm, y1: 0mm, x2: 17mm, y2: 15mm, stroke: thick-stroke),
      (x1: 40mm, y1: 0mm, x2: 40mm, y2: 15mm, stroke: thick-stroke),
      (x1: 55mm, y1: 0mm, x2: 55mm, y2: 15mm, stroke: thick-stroke),

      // Горизонтальные линии
      (x1: 0mm, y1: 0mm, x2: 185mm, y2: 0mm, stroke: thick-stroke),
      (x1: 0mm, y1: 15mm, x2: 185mm, y2: 15mm, stroke: thick-stroke),
      (x1: 0mm, y1: 10mm, x2: 65mm, y2: 10mm, stroke: thick-stroke),
      (x1: 175mm, y1: 7mm, x2: 185mm, y2: 7mm, stroke: thick-stroke)
    )
  )
)
