#import "core.typ": cv
#import "sections/render.typ": default-section-order, render-contacts, render-section
#import "utils.typ": rich, to-length, parse-length

#let heading-size-override = state("heading-size-override", none)
#let subheading-size-override = state("subheading-size-override", none)
#let list-size-override = state("list-size-override", none)
#let text-size-override = state("text-size-override", none)
#let title-font-override = state("title-font-override", none)
#let heading-gap-override = state("heading-gap-override", none)
#let section-gap-override = state("section-gap-override", none)

#let render-cv(locale-path, config-path: none) = {
  let display-lang-from-path = path => {
    let normalized = str(path)
    if normalized.contains("zh-cn") {
      "zh-cn"
    } else if normalized.contains("zh-hk") {
      "zh-hk"
    } else if normalized.contains("\\ja\\") or normalized.contains("/ja/") or normalized.contains("cv-ja") {
      "ja"
    } else if normalized.contains("\\ko\\") or normalized.contains("/ko/") or normalized.contains("cv-ko") {
      "ko"
    } else {
      none
    }
  }
  let empty-style = (
    text_size: none,
    heading_size: none,
    heading_gap: none,
    subheading_size: none,
    list_size: none,
    section_gap: none,
    font_title: none,
    font_title_cjk: none,
    font_content: none,
    font_content_cjk: none,
  )
  let default-profile = (
    en_name: "",
    original_name: "",
    furigana_name: none,
    furigana: none,
    job_intent: none,
    aliases: (),
    location_label: none,
    show_icons: true,
    contacts: (),
  )
  let default-config = (
    page: (
      margin_top: "1.25cm",
      margin_bottom: "1.25cm",
      margin_left: "1.5cm",
      margin_right: "1.5cm",
    ),
    global: (
      lang: "en",
      show_furigana: true,
      font_size: 10,
      heading_size: 12,
      heading_gap: "0.6em",
      subheading_size: 10.5,
      list_size: 9,
      section_gap: "0pt",
      font_content: "Spectral",
      font_content_cjk: "MiSans",
      font_title: "Rethink Sans",
      font_title_cjk: "MiSans",
      name_font: none,
      font_mono: "Inconsolata",
      font_math: "New Computer Modern Math",
      footer_size: 8,
    ),
    header: (
      name_size: 18,
      name_weight: "bold",
      original_name_size: 15.3,
      original_name_weight: "black",
      alignment: "center",
      job_intent_size: 10.5,
      contact_size: 9,
      show_avatar: false,
      avatar_size: "1.8cm",
      avatar_path: none,
    ),
    footer: (
      show_name: true,
      text: "",
      show_updated: true,
      updated_prefix: "Last Updated:",
      show_page: true,
      page_format: "1 of 1",
    ),
    sections: (default: empty-style),
  )

  let locale-data = toml(locale-path)
  let config-data = if config-path == none { default-config } else { toml(config-path) }
  let metadata = locale-data.at("metadata", default: none)
  let profile = locale-data.at("profile", default: none)
  let profile-value = (key, default: none) => {
    let from-profile = if profile != none and type(profile) == dictionary {
      profile.at(key, default: none)
    } else {
      none
    }
    if from-profile != none {
      from-profile
    } else {
      if metadata != none and type(metadata) == dictionary {
        metadata.at(key, default: default)
      } else {
        default
      }
    }
  }

  let page-config = config-data.at("page", default: default-config.page)
  let global-config = config-data.at("global", default: default-config.global)
  let header-config = config-data.at("header", default: default-config.header)
  let footer-config = config-data.at("footer", default: default-config.footer)
  let section-config = config-data.at("sections", default: default-config.sections)

  let aliases = profile-value("aliases", default: default-profile.aliases)
  let en-name = profile-value("en_name", default: default-profile.en_name)
  let original-name = profile-value("original_name", default: default-profile.original_name)
  let furigana-name = profile-value("furigana_name", default: original-name)
  let furigana = profile-value("furigana", default: default-profile.furigana)
  let location-label = profile-value("location_label", default: default-profile.location_label)
  let contacts = profile-value("contacts", default: default-profile.contacts)
  let job-intent = rich(profile-value("job_intent", default: none))

  let lang = global-config.at("lang", default: "en")
  let display-lang = if global-config.at("display_lang", default: none) != none {
    global-config.at("display_lang")
  } else {
    let inferred = display-lang-from-path(locale-path)
    if inferred == none { lang } else { inferred }
  }
  let show-furigana = global-config.at("show_furigana", default: true)
  // Keep the profile key as a compatibility fallback for older CV data.
  let show-icons = global-config.at(
    "show_icons",
    default: profile-value("show_icons", default: default-profile.show_icons),
  )
  let base-font = to-length(global-config.at("font_size", default: none), 10pt)
  let heading-size = to-length(global-config.at("heading_size", default: none), base-font + 2pt)
  let heading-gap = parse-length(global-config.at("heading_gap", default: none), 0.6em)
  let subheading-size = to-length(global-config.at("subheading_size", default: none), base-font + 0.5pt)
  let list-size = to-length(global-config.at("list_size", default: none), base-font - 1pt)
  let section-gap = parse-length(global-config.at("section_gap", default: none), 0pt)
  let first-section-gap = parse-length(global-config.at("first_section_gap", default: none), none)
  let footer-size = to-length(global-config.at("footer_size", default: none), base-font - 2pt)
  let regional-cjk-font = family => if display-lang == "zh-hk" and family == "MiSans" {
    "MiSans TC"
  } else {
    family
  }
  let font-content = global-config.at("font_content", default: "Spectral")
  let font-content-cjk = regional-cjk-font(global-config.at("font_content_cjk", default: "MiSans"))
  let font-title = global-config.at("font_title", default: "Rethink Sans")
  let font-title-cjk = regional-cjk-font(global-config.at("font_title_cjk", default: "MiSans"))
  let name-font = regional-cjk-font(global-config.at("name_font", default: none))
  let font-mono = global-config.at("font_mono", default: "Inconsolata")
  let font-math = global-config.at("font_math", default: "New Computer Modern Math")

  let header-name-size = to-length(header-config.at("name_size", default: none), 18pt)
  let header-name-weight = header-config.at("name_weight", default: "bold")
  let header-original-size = to-length(header-config.at("original_name_size", default: none), 15.3pt)
  let header-original-weight = header-config.at("original_name_weight", default: "black")
  let header-alignment = header-config.at("alignment", default: "center")
  let header-job-intent-size = to-length(header-config.at("job_intent_size", default: none), 10.5pt)
  let header-contact-size = to-length(header-config.at("contact_size", default: none), 9pt)
  let header-show-avatar = header-config.at("show_avatar", default: false)
  let header-avatar-size = parse-length(header-config.at("avatar_size", default: none), 1.8cm)
  let header-avatar-path = header-config.at("avatar_path", default: none)

  let page-margin-top = parse-length(page-config.at("margin_top", default: none), 1.25cm)
  let page-margin-bottom = parse-length(page-config.at("margin_bottom", default: none), 1.25cm)
  let page-margin-left = parse-length(page-config.at("margin_left", default: none), 1.5cm)
  let page-margin-right = parse-length(page-config.at("margin_right", default: none), 1.5cm)

  let footer-show-name = footer-config.at("show_name", default: true)
  let footer-text = rich(footer-config.at("text", default: default-config.footer.text))
  let footer-show-updated = footer-config.at("show_updated", default: true)
  let footer-updated-prefix = footer-config.at("updated_prefix", default: "Last Updated:")
  let footer-show-page = footer-config.at("show_page", default: true)
  let footer-page-format = footer-config.at("page_format", default: "1 of 1")

  let default-style = section-config.at("default", default: empty-style)
  let style-value = (section-style, key, fallback: none) => {
    let section-value = section-style.at(key, default: none)
    if section-value != none {
      section-value
    } else {
      let default-value = default-style.at(key, default: none)
      if default-value != none { default-value } else { fallback }
    }
  }
  let style-for = section-name => {
    let section-style = section-config.at(section-name, default: empty-style)
    (
      text_size: to-length(style-value(section-style, "text_size"), none),
      heading_size: to-length(style-value(section-style, "heading_size"), none),
      heading_gap: parse-length(style-value(section-style, "heading_gap"), none),
      subheading_size: to-length(style-value(section-style, "subheading_size"), none),
      list_size: to-length(style-value(section-style, "list_size"), none),
      section_gap: parse-length(style-value(section-style, "section_gap"), none),
      font_title: (
        (
          name: style-value(section-style, "font_title", fallback: font-title),
          covers: "latin-in-cjk",
        ),
        (
          name: regional-cjk-font(style-value(section-style, "font_title_cjk", fallback: font-title-cjk)),
        ),
      ),
      font_content: (
        (
          name: style-value(section-style, "font_content", fallback: font-content),
          covers: "latin-in-cjk",
        ),
        (
          name: regional-cjk-font(style-value(section-style, "font_content_cjk", fallback: font-content-cjk)),
        ),
      ),
    )
  }

  let titles = locale-data.at("sections", default: none)
  let configured-order = if titles != none and type(titles) == dictionary {
    titles.keys().filter(key => default-section-order.contains(key))
  } else {
    ()
  }
  let discovered-order = default-section-order.filter(section =>
    locale-data.at(section, default: none) != none and not configured-order.contains(section)
  )
  let section-order = configured-order + discovered-order
  let get-section = section => {
    if locale-data.at(section, default: none) == none { none } else { locale-data.at(section) }
  }
  let render-with-style = (section-name, body-fn) => {
    let section-style = style-for(section-name)
    context {
      heading-size-override.update(section-style.at("heading_size"))
      heading-gap-override.update(section-style.at("heading_gap"))
      section-gap-override.update(section-style.at("section_gap"))
      subheading-size-override.update(section-style.at("subheading_size"))
      list-size-override.update(section-style.at("list_size"))
      text-size-override.update(section-style.at("text_size"))
      title-font-override.update(section-style.at("font_title"))
      set text(font: section-style.at("font_content"))
      if section-style.at("text_size") != none {
        set text(size: section-style.at("text_size"))
      }
      body-fn()
    }
  }

  show: cv.with(
    page_margin_top: page-margin-top,
    page_margin_bottom: page-margin-bottom,
    page_margin_left: page-margin-left,
    page_margin_right: page-margin-right,
    en_name: en-name,
    original_name: original-name,
    furigana_name: furigana-name,
    furigana: furigana,
    show_furigana: show-furigana,
    lang: lang,
    display_lang: display-lang,
    text_size: base-font,
    heading_size: heading-size,
    heading_gap: heading-gap,
    subheading_size: subheading-size,
    list_size: list-size,
    section_gap: section-gap,
    font_content: font-content,
    font_content_cjk: font-content-cjk,
    font_title: font-title,
    font_title_cjk: font-title-cjk,
    name_font: name-font,
    font_mono: font-mono,
    font_math: font-math,
    header_name_size: header-name-size,
    header_name_weight: header-name-weight,
    header_original_name_size: header-original-size,
    header_original_name_weight: header-original-weight,
    header_alignment: header-alignment,
    header_job_intent: job-intent,
    header_job_intent_size: header-job-intent-size,
    header_contact_size: header-contact-size,
    header_show_avatar: header-show-avatar,
    header_avatar_size: header-avatar-size,
    header_avatar_path: header-avatar-path,
    footer_size: footer-size,
    footer_show_name: footer-show-name,
    footer_text: footer-text,
    footer_show_updated: footer-show-updated,
    footer_updated_prefix: footer-updated-prefix,
    footer_show_page: footer-show-page,
    footer_page_format: footer-page-format,
    icons_enabled: show-icons,
    contacts: render-contacts(contacts, location-label, icons-enabled: show-icons),
  )

  for (index, section) in section-order.enumerate() {
    let current-style = style-for(section)
    let current-gap = current-style.at("section_gap")
    let active-section-gap = if index == 0 {
      if first-section-gap != none { first-section-gap } else { none }
    } else {
      if current-gap == none { section-gap } else { current-gap }
    }
    if active-section-gap != none and active-section-gap != 0pt {
      v(active-section-gap)
    }
    render-section(section, titles, get-section, aliases, render-with-style)
  }
}
