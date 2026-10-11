#import "lib-cv.typ": cv, cv-entry, cv-section, cv-skill, cv-signoff, h-bar
#import "@preview/datify:1.0.1": custom-date-format

#let t(lang, en, de) = if lang == "de" { de } else { en }


// Personal data

#let name = "Jane Doe"
#let first-name = "Jane"
#let last-name = "Doe"


// Metadata and layout settings

#let metadata(lang) = (
  cv_footer: t(lang, "Resume", "Lebenslauf"),
  letter_footer: t(lang, "Cover letter", "Anschreiben"),
  layout: (
    awesome_color: "darknight",
    before_section_skip: "0pt",
    before_entry_skip: "0pt",
    before_entry_description_skip: "-3pt",
    paper_size: "a4",
    page_margin: (
      top: "0.5cm",
      bottom: "1.5cm",
      left: "2.0cm",
      right: "2.0cm",
    ),
    date_width: if lang == "de" { "6.5cm" } else { "6.3cm" },
    font_size: "10pt",
    line_leading: "5pt",
    list_spacing: "5pt",
    fonts: (
      regular_fonts: ("Times New Roman",),
      header_font: "Times New Roman",
    ),
    header: (
      header_align: "center",
      display_profile_photo: false,
      info_font_size: "10pt",
      name_font_size: "21pt",
      name_gap: "-15pt",
      icon_row_spacing_adjust: "-7pt",
      after_skip: "-10pt",
    ),
    entry: (
      display_entry_society_first: true,
      display_logo: true,
      primary_font_size: "10pt",
      secondary_font_size: "10pt",
      row_gutter: "5pt",
      skill_label_width: if lang == "de" { "3.6cm" } else { "3.0cm" },
    ),
    section: (
      title_highlight: "none",
      title_font_size: "12.5pt",
      after_skip: "-3pt",
      rule_stroke: "0.4pt",
      rule_color: black,
    ),
    footer: (
      display_page_counter: false,
      display_footer: false,
    ),
  ),
  personal: (
    first_name: first-name,
    last_name: last-name,
    address: "100 Main St, 12345 Boston, MA",
    info: (
      (
        email: "jane@doe.net",
        phone: "+1 999 876-5432",
      ),
      (
        linkedin: "TODO",
        // Optional GitHub profile:
        // github: "TODO",
      ),
      (
        // Optional personal homepage:
        // homepage: "homepage.net/name",
      ),
    ),
  ),
)

#let education(lang) = {
  cv-section(t(lang, "Education", "Bildung"))

  cv-entry(
    title: t(
      lang,
      [B.Sc. in Management & Technology -- current GPA: 1.2/5.0 (top 5%)],
      [B.Sc. Management & Technology -- aktuelle Note: 1,2/5,0 (Top 5%)],
    ),
    society: t(
      lang,
      [Technical University of Munich #text(fill: rgb("#3070b3"))[(TUM)]],
      [Technische Universität München #text(fill: rgb("#3070b3"))[(TUM)]],
    ),
    location: t(lang, [Munich, Germany], [München]),
    date: t(lang, [Since 09/2017], [Seit 09/2017]),
    description: list(
      t(
        lang,
        [Specializing in Finance and Computer Science],
        [Schwerpunkt in Finance und Informatik],
      ),
      t(
        lang,
        [Bullet 2],
        [Punkt 2],
      ),
    ),
  )

  cv-entry(
    title: t(
      lang,
      [Exchange Semester -- GPA: 4.0/4.0 (with 4.0 best grade)],
      [Auslandssemester -- Note: 4,0/4,0 (mit 4,0 als Bestnote)],
    ),
    society: [Harvard Business School],
    location: t(lang, [Boston, United States], [Boston, Vereinigte Staaten]),
    date: [09/2018 -- 01/2019],
    description: list(
      t(
        lang,
        [Bullet 1],
        [Punkt 1],
      ),
      t(
        lang,
        [Bullet 2],
        [Punkt 2],
      ),
    ),
  )

  cv-entry(
    title: t(
      lang,
      [Abitur -- GPA: 1.5/6.0 (with 1.0 best grade)],
      [Abitur -- Note: 1,5/6,0 (mit 1,0 als Bestnote)],
    ),
    society: [Gymnasium Musterhausen],
    location: t(lang, [Munich, Germany], [München]),
    date: [09/2008 -- 06/2016],
    description: list(
      t(
        lang,
        [Bullet 1],
        [Punkt 1],
      ),
      t(
        lang,
        [Bullet 2],
        [Punkt 2],
      ),
    ),
  )
}

#let professional(lang) = {
  cv-section(t(lang, "Professional Experience", "Berufserfahrung"))

  cv-entry(
    title: t(
      lang,
      [Intern, Investment Banking],
      [Praktikantin, Investment Banking],
    ),
    society: [Some Bank AG],
    location: t(lang, [Munich, Germany], [München]),
    date: [06/2019 -- 09/2019],
    description: list(
      t(
        lang,
        [Bullet 1],
        [Punkt 1],
      ),
      t(
        lang,
        [Bullet 2],
        [Punkt 2],
      ),
      t(
        lang,
        [Bullet 3],
        [Punkt 3],
      ),
    ),
  )

  cv-entry(
    title: t(
      lang,
      [Intern, Strategy Consulting],
      [Praktikantin, Strategieberatung],
    ),
    society: [Some Consultancy AG],
    location: t(lang, [Munich, Germany], [München]),
    date: [06/2019 -- 09/2019],
    description: list(
      t(
        lang,
        [Bullet 1],
        [Punkt 1],
      ),
      t(
        lang,
        [Bullet 2],
        [Punkt 2],
      ),
      t(
        lang,
        [Bullet 3],
        [Punkt 3],
      ),
    ),
  )

  // Older entries are easily commented out again:
  /*
  cv-entry(
    title: t(
      lang,
      [Working Student, Business Development],
      [Werkstudentin, Business Development],
    ),
    society: t(
      lang,
      [Some old work at random company GmbH],
      [Ehemalige Tätigkeit bei zufälliger Firma GmbH],
    ),
    location: t(lang, [Munich, Germany], [München]),
    date: [06/2019 -- 09/2019],
    description: list(
      t(lang, [Bullet 1], [Punkt 1]),
      t(lang, [Bullet 2], [Punkt 2]),
      t(lang, [Bullet 3], [Punkt 3]),
    ),
  )
  */
}

#let extracurricular(lang) = {
  cv-section(t(lang, "Extracurricular Activity", "Engagement"))

  cv-entry(
    title: t(
      lang,
      [Part of the XYZ Band],
      [Teil der XYZ-Band],
    ),
    society: t(
      lang,
      [Some music group in which you are playing an instrument],
      [Musikgruppe, in der Sie ein Instrument spielen],
    ),
    location: t(lang, [Munich, Germany], [München]),
    date: t(lang, [Since April 2018], [Seit April 2018]),
    description: list(
      t(
        lang,
        [Bullet 1],
        [Punkt 1],
      ),
      t(
        lang,
        [Bullet 2],
        [Punkt 2],
      ),
    ),
  )

  cv-entry(
    title: t(
      lang,
      [Football Coach for 10-year-olds],
      [Fußballtrainerin für 10-Jährige],
    ),
    society: t(
      lang,
      [Some Football Club in which you were a coach],
      [Fußballverein, in dem Sie Trainerin waren],
    ),
    location: t(lang, [Munich, Germany], [München]),
    date: [09/2018 -- 08/2019],
    description: list(
      t(
        lang,
        [Bullet 1],
        [Punkt 1],
      ),
      t(
        lang,
        [Bullet 2],
        [Punkt 2],
      ),
    ),
  )

  cv-entry(
    title: t(
      lang,
      [Buddy for freshmen at TUM School of Management],
      [Buddy für Studienanfänger der TUM School of Management],
    ),
    society: t(
      lang,
      [Technical University of Munich],
      [Technische Universität München],
    ),
    location: t(lang, [Munich, Germany], [München]),
    date: [09/2018 -- 08/2019],
    description: list(
      t(
        lang,
        [Bullet 1],
        [Punkt 1],
      ),
      t(
        lang,
        [Bullet 2],
        [Punkt 2],
      ),
    ),
  )
}

#let skills(lang) = {
  cv-section(t(lang, "Additional Information / Skills", "Weitere Kenntnisse"))

  cv-skill(
    type: t(lang, [Languages], [Sprachen]),
    info: t(
      lang,
      [German (native) #h-bar() English (full professional proficiency)],
      [Deutsch (Muttersprache) #h-bar() Englisch (verhandlungssicher)],
    ),
  )

  cv-skill(
    type: t(lang, [Computer Skills], [Computerkenntnisse]),
    info: t(
      lang,
      [Microsoft Office #h-bar() Capital IQ #h-bar() Bloomberg],
      [Microsoft Office #h-bar() Capital IQ #h-bar() Bloomberg],
    ),
  )

  cv-skill(
    type: t(lang, [Interests], [Interessen]),
    info: t(
      lang,
      [Long-distance running (participated in Berlin Marathon in 2020)],
      [Langstreckenlauf (Teilnahme am Berlin-Marathon 2020)],
    ),
  )
}


// Final assembly

#let render-cv(lang: "en") = {
  show: cv.with(metadata(lang))

  cv-signoff(
    place-name: t(lang, "PLACE", "ORT"),
    date: custom-date-format(
      datetime.today(),
      pattern: "long",
      lang: lang,
    ),
    // signature: "../signature.png",
    placement: "bottom",
  )

  education(lang)
  professional(lang)
  extracurricular(lang)
  skills(lang)
}
