#import "../style.typ": *
#import themes.university: *

#let theme-setting(
  title: [タイトル],
  subtitle: [サブタイトル],
  author: [名前],
  date: nowdate_slash,
  institution: [所属],
  logo: "",
  summary: [所属],
  handout: false,
  ..args,
  body) = {
  show: university-theme.with(
    header-right: "", // Remove section
    footer-columns: (45%, 45%, 10%), // Decompose footer into three columns
    // left footer: current section
    footer-a: self => {
      sym.section + " " + utils.display-current-heading(level: 1)
    },
    // centre footer: summary & presentation date
    footer-b: self => {
      h(1fr)
      self.info.summary
      h(1fr)
      context self.info.date
      h(1fr)
    },
    // right footer: slide number
    footer-c: context utils.slide-counter.display() + " / " + utils.last-slide-number,
    config-info(
      title: title,
      subtitle: subtitle,
      author: author,
      date: date,  // nowdate_slash: 2024/10/2  nowdate_jp: 2024年10月2日
      institution: institution,  // [TUS, UC3M, MIT],
      logo: logo,  // emoji.school,
      summary: summary
    ),
    // Date format
    config-common(datetime-format: "[month repr:short]. [day], [year]"),
    // config-common(datetime-format: "[year]年[month]月[day]日"), // 日本語
    // Do not show 'new section' slide
    config-common(new-section-slide-fn: none),
    // Semi-transparent animation ***does not work for some cases***
    // config-methods(cover: utils.semi-transparent-cover.with(alpha: 80%)),
    // Handout slide
    config-common(handout: handout),
    ..args,
  )
  body
}

// ========================================

// スライドの右上に補足説明を表示
#let description(it, dx: 0pt, dy: 0pt) = place(
  top + right,
  dx: 20pt + dx,
  dy: -35pt + dy,
  align(center, it),
)
