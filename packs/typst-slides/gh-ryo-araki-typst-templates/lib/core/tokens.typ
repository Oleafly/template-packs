#let colors = (
  accent: rgb("#f93d6e"),
  structure: rgb("#1f4e79"),
  alert: rgb("#F77F00"),
  example: rgb("#2d6a4f"),
  question: rgb("#FFB11B"),
  answer: rgb("#B23A8E"),
  advanced: orange,
  muted: gray,
  navy: navy,
)

#let fonts = (
  document-serif: "Libertinus Serif",
  document-serif-cjk: "IPAexMincho",
  document-sans: "Liberation Sans",
  document-sans-cjk: "IPAexGothic",
  ui: "Cabin",
  code: "Noto Sans Mono",
  math: "Latin Modern Math",
  cjk: "Noto Sans CJK JP",
)

#let slide-palette = (
  blue: rgb("#4E79A7"),
  orange: rgb("#F28E2B"),
  green: rgb("#59A14F"),
  red: rgb("#E15759"),
  cyan: rgb("#76B7B2"),
  purple: rgb("#B07AA1"),
  brown: rgb("#9C755F"),
  gray: rgb("#BAB0AC"),
)

#let spacing = (
  block-gap: 1.2em,
  poster-margin: 1cm,
)

#let document-defaults = (
  lang: "ja",
  paper: "a4",
  fontsize: 12pt,
  seriffont: fonts.at("document-serif"),
  seriffont-cjk: fonts.at("document-serif-cjk"),
  sansfont: fonts.at("document-sans"),
  sansfont-cjk: fonts.at("document-sans-cjk"),
  justify: false,
  equation-numbering: "(1)",
  title: "文書のタイトル",
  authors: ((name: "荒木亮", affiliation: "東京理科大学", email: "araki.ryo@rs.tus.ac.jp"),),
  subtitle: [],
  summary: [],
  abstract: [文書の要旨．],
  venue: [],
  logo: [],
  bibliography: "/starters/biblio.bib",
  date: datetime.today().display(),
)

#let slide-defaults = (
  text-font: fonts.at("ui"),
  cjk-font: fonts.at("cjk"),
  math-font: fonts.at("math"),
  code-font: fonts.at("code"),
  title: [Presentation title\ ...continued to the second line],
  subtitle: [Subtitle],
  authors: (
    (name: [*Presenter name*], affiliation: [Institution], email: []),
    (name: [Co-author name], affiliation: [Institution], email: []),
  ),
  date: datetime.today(),
  date-locale: "en",
  institution: [],
  logo: "",
  logo-position: "right-bottom",
  summary: [#("presenter")#sym.at#("subtitle")],
  abstract: [],
  venue: [],
  bibliography: none,
  datetime-format: auto,
  footer-columns: (45%, 45%, 10%),
  handout: false,
  equation-numbering: none,
  equation-numbering-pattern: "(1)",
)

#let poster-defaults = (
  text-font: fonts.at("ui"),
  cjk-font: fonts.at("cjk"),
  math-font: fonts.at("math"),
  box-spacing: spacing.at("block-gap"),
  title: [*Title of the poster*],
  authors: ((name: [Presenter name], affiliation: [Institution], email: [`email@address`]),),
  subtitle: [],
  date: [],
  summary: [],
  abstract: [],
  venue: [#("Conference name")#sym.at~Conference venue, October 1--10, 2025],
  logo: [],
  logo-relative-width: none,
  bibliography: none,
)
