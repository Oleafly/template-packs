// Значения оформления по умолчанию. Для обычной лабораторной достаточно
// менять config.typ; этот файл нужен для изменения общего дизайна шаблона.
#let default-theme = (
  // Основной и моноширинные шрифты.
  body-font: "Liberation Serif",
  mono-fonts: ("Liberation Mono", "DejaVu Sans Mono"),

  // Размеры обычного текста, титульника и трёх уровней заголовков.
  body-size: 14pt,
  institution-size: 12pt,
  title-size: 16pt,
  heading-1-size: 19pt,
  heading-2-size: 17pt,
  heading-3-size: 15pt,

  // Геометрия страницы и обычного абзаца.
  page-margin: 20mm,
  paragraph-indent: 1.25cm,
  paragraph-leading: 0.7em,
  paragraph-spacing: 0.8em,

  // Размеры блочного и встроенного кода.
  code-size: 10pt,
  inline-code-size: 10pt,
)
