#import "@preview/touying:0.7.1": touying-slide-wrapper

#let colors = (
  primary: rgb("#006cdc"),
  primary-dark: rgb("#3030B1"),
  secondary: rgb("#62b230"),
  neutral: white,
)
#let margin = (left: 1cm, right: 1.3cm, bottom: 2.5cm, top: 7em)

#let shaded(..args, body) = {
  show math.equation: set text(font: "New Computer Modern Math")
  text(fill: luma(0%, 50%), style: "italic", ..args, body)
}
#let block(title, body) = {
  text(fill: colors.primary-dark, title)
  parbreak()
  [#body]
}
#let arrow-list(..args) = list(marker: (
  text(fill: colors.primary, $->$),
  text(fill: colors.primary, math.triangle.filled.r)
), ..args)

#let slide(title, subtitle: none, page_number: true, ..args) = touying-slide-wrapper(self => {
  import "@preview/touying:0.7.1": touying-slide, utils, config-page, config-common

  let header(self) = layout(size => {
    set align(bottom + left)
    set text(size: 1.18em)
    show: pad.with(left: margin.left, right: margin.right / 2)

    let subtitle_content = if subtitle != none{
      set text(size: 0.9em)
      set par(leading: 0.2em)
      box(inset: (y: 0.3em))[#h(0.5em) $arrow.curve$ #subtitle]
    } else {
      none
    }
    let subtitle_height = measure(subtitle_content, width: 20cm).height

    grid(columns: (auto, 4em), rows: (auto, auto, subtitle_height, 3pt),
      none,
      grid.cell(rowspan: 4, image("../assets/Logo_Blue_No-BG.png")),
      box(inset: (y: 0.2em), smallcaps(title)),
      subtitle_content,
      line(stroke: self.colors.primary + 3pt, length: 100%)
    )
  })

  let footer(self) = {
    set align(right + top)
    set text(fill: self.colors.primary, size: 0.8em)
    show: pad.with(x: 1.5cm)
    
    if page_number {
      context utils.slide-counter.display() + " / " + utils.last-slide-number
    } else {
      none
    }
  }

  // set page(background: {
  //   place(center + horizon, scale(66%, image("../assets/bmstu_rk6_logo3.png")))
  //   place(center + horizon, rect(fill: luma(100%, 96%), width: 100%, height: 100%))
  // })

  self = utils.merge-dicts(
    self,
    config-page(
      header: header,
      footer: footer
    )
  )

  touying-slide(self: self, ..args)
})

#let title-slide(
  line_correction: 0em,
  ..args
) = touying-slide-wrapper(self => {
  import "@preview/touying:0.7.1": touying-slide

  let exists(what, then) = {
    if what != none { then(what) }
  }
  let or_default(what, default) = {
    if what == none or what == auto { default } else { what }
  }

  let info = self.info + (
    institution: "Московский государственный технический университет имени Н.Э. Баумана",
    title: "@Название темы, в полной мере раскрывающее раскрывающее раскрывающее раскрывающее замысел@",
    subtitle: "@Подробности темы, различные детали, неуместившиеся в названии темы@",
    place: (location: "@место проведения@|online", country: "Россия", city: "Москва", duration: "10 минут"),
    speaker: (position: "@должность@/@учебная группа@, @уч.ст.@", name: auto, position_name: auto),
    supervisor: (position: "@должность@, @уч.ст.@", name: "@Фамилия И.О.@", position_name: auto),
    email: "email@domain",
  ) + args.named();
  if info.speaker != none and info.speaker.name == auto {
    info.speaker.name = info.author
  }

  let body = {
    set page(margin: 0pt)

    let image_shift = 32%;
    let line_shift = 67.6%;
    let line_angle = 5deg;
    let line_width = 1em;

    place(
      dx: image_shift,
      image(height: 100%, "../assets/bmstu_building_lighter.jpeg")
    )

    place(polygon(
      fill: self.colors.neutral,
      stroke: none,
      (0%, 0%),
      (line_shift * (1 + calc.sin(line_angle)), 0%),
      (line_shift * (1 - calc.sin(line_angle)), 100%),
      (0%, 100%)
    ))

    place(line(
      stroke: self.colors.primary + line_width,
      start: (line_shift * (1 + calc.sin(line_angle)), -1%),
      end: (line_shift * (1 - calc.sin(line_angle)), 101%)
    ))

    place(bottom + right, dx: -2%, image(width: 15%, "../assets/Logo_Color_No-BG.svg"))

    show: pad.with(left: margin.left, right: 100% - line_shift)

    stack(
      5fr,
      smallcaps(info.institution),
      3fr,
      text(size: 1.5em, info.title),
      3fr,
      exists(info.subtitle, it => emph(it)),
      2fr,
      exists(info.place, it => [
        #exists(it.location, it => [Место проведения: #it]) \
        #exists(it.duration, it => [Продолжительность: #it])
      ]),
      2fr,
      pad(left: -1.5%, right: line_correction, line(
        stroke: self.colors.primary + 3pt,
        length: 100%
      )),
      2fr,
      par[
        #exists(info.speaker, it => [#or_default(it.at("position_name", default: none), "Должность"): #it.position, #it.name]) \
        #exists(info.supervisor, it => [#or_default(it.at("position_name", default: none), "Научный руководитель"): #it.position, #it.name])
      ],
      1fr,
      exists(info.email, it => text(fill: self.colors.secondary, it)),
      1fr,
      exists(info.place, it => text(size: 0.8em)[#it.country, #it.city, #info.date]),
      3fr
    )
  }

  touying-slide(self: self, body)
})

#let end-slide(extra: (
  text(size: 28pt, weight: "medium", fill: white)[Спасибо за внимание!],
  1fr,
  text(size: 28pt, weight: "medium", fill: white)[Вопросы?],
)) = touying-slide-wrapper(self => {
  import "@preview/touying:0.7.1": touying-slide

  let body = {
    set page(margin: 0pt)

    place(rect(fill: self.colors.primary, width: 100%, height: 100%))
    place(dx: 63%, dy: 13%, image("../assets/Logo_White_No-BG.png"))
    place(rect(fill: self.colors.primary.transparentize(40%), width: 100%, height: 100%))

    set align(left + horizon)
    show: pad.with(left: margin.left)
    stack(
      3fr,
      ..extra,
      3fr
    )
  }

  touying-slide(self: self, body)
})

#let template(
  preamble: none,
  body
) = {
  import "@preview/touying:0.7.1": *

  set text(
    size: 15pt,
    font: "Fira Sans",
    weight: "light",
    lang: "ru",
  )
  show text.where(weight: "bold"): set text(weight: "light")
  set align(horizon)
  show math.equation: set text(weight: "light", font: "New Computer Modern Math")
  set math.equation(numbering: "(1)")
  show highlight: set text(fill: colors.primary)
  set list(
    marker: (
      text(fill: colors.primary, math.circle.filled),
      text(fill: colors.primary, math.triangle.filled.r)
    ),
    indent: 1em
  )
  set enum(indent: 1em, numbering: n => text(fill: colors.primary-dark)[#n.])
  show figure.caption: set text(size: 0.75em)
  show link: set text(fill: red)
  show figure.where(kind: raw): set figure.caption(position: top)
  show figure.where(kind: raw): set figure(supplement: "Исходный код")

  show: touying-slides.with(
    config-page(
      paper: "presentation-16-9",
      margin: margin
    ),
    config-colors(..colors),
    config-common(
      preamble: preamble,
      slide-fn: slide,
    )
  )

  body
}
