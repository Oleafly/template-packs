#import "../style.typ": *
#import themes.metropolis: *

#let theme-setting(
  title: [タイトル],
  subtitle: [サブタイトル],
  author: [名前],
  date: nowdate_slash,
  institution: [所属],
  handout: false,
  ..args,
  body,
) = {
  show: metropolis-theme.with(
    aspect-ratio: "16-9",
    config-colors(
      primary: rgb("#eb811b"),
      primary-light: rgb("#d6c6b7"),
      secondary: rgb("#d1edf9"),
      neutral-lightest: rgb("#fafafa"),
      neutral-dark: rgb("#23373b"),
      neutral-darkest: rgb("#23373b"),
    ),
    config-info(
      title: title,
      subtitle: subtitle,
      author: author,
      date: date, // nowdate_slash: 2024/10/2  nowdate_jp: 2024年10月2日
      institution: institution,
    ),
    // Do not show 'new section' slide
    config-common(new-section-slide-fn: none),
    // Handout slide
    config-common(handout: handout),
    footer: self => utils.display-current-heading(level: 1),
    header: self => utils.display-current-heading(style: current-heading => text(current-heading.body, fill: black), level: 2),
    ..args,
  )
  body
}

// ========================================

// スライドの右上に補足説明を表示
#let description(it, dx: 0pt, dy: 0pt) = place(
  top + right,
  dx: 20pt + dx,
  dy: -40pt + dy,
  align(center, it),
)

#let citet(..citation, size: 15pt) = text(bib-style.bib-cite-func.with(bib-cite: bib-citet)(..citation), size: size)

#let citep(..citation, size: 15pt) = text(bib-style.bib-cite-func.with(bib-cite: bib-citep)(..citation), size: size)
