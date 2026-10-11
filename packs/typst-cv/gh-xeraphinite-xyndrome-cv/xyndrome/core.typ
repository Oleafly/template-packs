#import "components/ui.typ": current-lang, icons-enabled
#import "sections/header.typ": render-header
#import "sections/footer.typ": render-footer

#let heading-size-override = state("heading-size-override", none)
#let subheading-size-override = state("subheading-size-override", none)
#let list-size-override = state("list-size-override", none)
#let text-size-override = state("text-size-override", none)
#let title-font-override = state("title-font-override", none)
#let heading-gap-override = state("heading-gap-override", none)

#let cv(
  en_name: "",
  original_name: "",
  furigana_name: none,
  furigana: none,
  address: "",
  contacts: (),
  updated: datetime.today(),
  lang: "en",
  display_lang: "en",
  show_furigana: true,
  page_margin_top: 1.25cm,
  page_margin_bottom: 1.25cm,
  page_margin_left: 1.5cm,
  page_margin_right: 1.5cm,
  text_size: 10pt,
  heading_size: 12pt,
  heading_gap: 0.6em,
  subheading_size: 10.5pt,
  list_size: 9pt,
  section_gap: 0pt,
  font_content: "Spectral",
  font_content_cjk: "MiSans",
  font_title: "Rethink Sans",
  font_title_cjk: "MiSans",
  name_font: none,
  font_mono: "Inconsolata",
  font_math: "New Computer Modern Math",
  header_name_size: 18pt,
  header_name_weight: "bold",
  header_original_name_size: 15.3pt,
  header_original_name_weight: "black",
  header_alignment: "center",
  header_job_intent: none,
  header_job_intent_size: 10.5pt,
  header_contact_size: 9pt,
  header_show_avatar: false,
  header_avatar_size: 1.8cm,
  header_avatar_path: none,
  footer_size: 8pt,
  footer_show_name: true,
  footer_text: none,
  footer_show_updated: true,
  footer_updated_prefix: "Last Updated:",
  footer_show_page: true,
  footer_page_format: "1 of 1",
  icons_enabled: true,
  body,
) = {
  icons-enabled.update(icons_enabled)
  current-lang.update(display_lang)
  let full_name_text = if original_name != "" { en_name + "  " + original_name } else { en_name }

  set document(author: full_name_text, title: full_name_text, date: updated)

  let font_configs = (
    content: (
      (name: font_content, covers: "latin-in-cjk"),
      (name: font_content_cjk),
    ),
    title: (
      (name: font_title, covers: "latin-in-cjk"),
      (name: font_title_cjk),
    ),
    mono: (
      (name: font_mono, covers: "latin-in-cjk"),
    ),
    math: font_math,
  )
  let original-name-font = if name_font == none or name_font == "" {
    font_configs.content
  } else {
    (
      (name: name_font, covers: "latin-in-cjk"),
      (name: font_content_cjk),
    )
  }

  show raw: it => box(
    text(font: font_configs.mono, weight: 500, it, size: 1.15em),
  )

  show link: it => underline(
    stroke: (dash: "dashed"),
    offset: 0.2em,
  )[#it]

  show strong: it => {
    let uses-misans = family => family == "MiSans" or family == "MiSans TC"
    let strong-weight = if uses-misans(font_content) or uses-misans(font_content_cjk) {
      "semibold"
    } else {
      "bold"
    }
    text(weight: strong-weight, it.body)
  }

  show list: it => context {
    let section-list-size = list-size-override.get()
    set text(size: if section-list-size == none { list_size } else { section-list-size })
    it
  }

  show list: set list(
    marker: [◦],
    spacing: 1em,
    body-indent: 0.5em,
  )

  show: doc => {
    set text(
      size: text_size,
      lang: lang,
      font: font_configs.content,
      fill: luma(20%),
    )
    doc
  }

  show heading.where(level: 1): it => context {
    let section-heading-size = heading-size-override.get()
    let section-heading-gap = heading-gap-override.get()
    let section-title-font = title-font-override.get()
    pad(
      top: 0pt,
      bottom: if section-heading-gap == none { heading_gap } else { section-heading-gap },
      text(
        font: if section-title-font == none { font_configs.title } else { section-title-font },
        size: if section-heading-size == none { heading_size } else { section-heading-size },
        weight: "black",
        it.body,
      ),
    )
  }
  show heading.where(level: 2): it => context {
    let section-subheading-size = subheading-size-override.get()
    let section-title-font = title-font-override.get()
    pad(
      top: -0.2em,
      bottom: 0.3em,
      text(
        font: if section-title-font == none { font_configs.title } else { section-title-font },
        size: if section-subheading-size == none { subheading_size } else { section-subheading-size },
        weight: "bold",
        it.body,
      ),
    )
  }

  set par(justify: true)

  set page(
    margin: (top: page_margin_top, bottom: page_margin_bottom, left: page_margin_left, right: page_margin_right),
    footer: render-footer(
      en_name: en_name,
      updated: updated,
      footer_size: footer_size,
      footer_show_name: footer_show_name,
      footer_text: footer_text,
      footer_show_updated: footer_show_updated,
      footer_updated_prefix: footer_updated_prefix,
      footer_show_page: footer_show_page,
      footer_page_format: footer_page_format,
    ),
  )
  render-header(
    en_name: en_name,
    original_name: original_name,
    furigana_name: furigana_name,
    furigana: furigana,
    show_furigana: show_furigana,
    address: address,
    contacts: contacts,
    font_configs: font_configs,
    original_name_font: original-name-font,
    header_name_size: header_name_size,
    header_name_weight: header_name_weight,
    header_original_name_size: header_original_name_size,
    header_original_name_weight: header_original_name_weight,
    header_alignment: header_alignment,
    header_job_intent: header_job_intent,
    header_job_intent_size: header_job_intent_size,
    header_contact_size: header_contact_size,
    header_show_avatar: header_show_avatar,
    header_avatar_size: header_avatar_size,
    header_avatar_path: header_avatar_path,
  )

  body
}
