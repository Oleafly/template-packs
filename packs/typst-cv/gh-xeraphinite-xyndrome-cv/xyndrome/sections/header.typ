#import "@preview/rubby:0.10.2": get-ruby

#let render-header(
  en_name: "",
  original_name: "",
  furigana_name: none,
  furigana: none,
  show_furigana: true,
  address: "",
  contacts: (),
  font_configs: (),
  original_name_font: none,
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
) = {
  let header-title-lift = 1.7em
  let resolved-avatar-path = if header_avatar_path == none or header_avatar_path == "" {
    none
  } else if str(header_avatar_path).contains(":") or str(header_avatar_path).starts-with("/") {
    header_avatar_path
  } else {
    "../" + str(header_avatar_path)
  }
  let resolved-furigana-name = if furigana_name == none or furigana_name == "" { original_name } else { furigana_name }
  let resolved-furigana = furigana
  let ruby = get-ruby(
    size: 0.4em,
    dy: 2pt,
    pos: top,
    alignment: "center",
    delimiter: "|",
    auto-spacing: true,
  )

  let header-align = if header_alignment == "left" { start } else { center }
  let contact-info = contacts
  if address != none and address != "" {
    contact-info.push([#smallcaps(address)])
  }
  let contact-items = contact-info.map(item => box(baseline: 32%)[#item])

  let original-name-content = {
    let show-ruby = (
      show_furigana
        and resolved-furigana != none
        and resolved-furigana != ""
        and resolved-furigana-name != none
        and resolved-furigana-name != ""
        and resolved-furigana.contains("|")
        and resolved-furigana-name.contains("|")
    )
    if show-ruby {
      text(
        font: original_name_font,
        size: header_original_name_size,
        weight: header_original_name_weight,
      )[#ruby[#resolved-furigana][#resolved-furigana-name]]
    } else {
      text(
        original_name,
        font: original_name_font,
        size: header_original_name_size,
        weight: header_original_name_weight,
      )
    }
  }

  let header-info = [
    #if header_alignment == "left" {
      block(text(size: header_name_size, weight: header_name_weight, font: font_configs.at("content"), [
        #smallcaps(en_name)
        #if original_name != none and original_name != "" {
          [#h(0.4em)#original-name-content]
        }
        #if header_job_intent != none {
          [#h(0.55em)#text(size: header_job_intent_size, weight: "medium", fill: luma(45%))[#header_job_intent]]
        }
      ]))
    } else {
      block(text(size: header_name_size, weight: header_name_weight, font: font_configs.at("content"), [
        #smallcaps(en_name)
        #if original_name != none and original_name != "" {
          [#h(0.4em)#original-name-content]
        }
        #if header_job_intent != none {
          [#v(0.55em)#text(size: header_job_intent_size, weight: "medium", fill: luma(45%))[#header_job_intent]]
        }
      ]))
    }
    #if contact-items.len() > 0 {
      pad(
        top: 2pt,
        align(header-align)[
          #set text(size: header_contact_size)
          #stack(dir: ltr, spacing: 0.4em, ..contact-items)
        ],
      )
    }
  ]

  pad(top: 0.24cm, bottom: -0.3cm)[
    #if header_show_avatar {
      context {
        let header-info-height = measure(header-info).height + header-title-lift
        let offset = 1.25em
        let header-avatar = if resolved-avatar-path != none and resolved-avatar-path != "" {
          block(
            radius: 18%,
            clip: true,
            inset: 0em,
          )[
            #image(resolved-avatar-path, height: header-info-height * 1.3)
          ]
        } else {
          rect(
            width: header_avatar_size * 1.5,
            height: header-info-height * 1.5,
            radius: 18%,
            inset: 0em,
            fill: rgb("#f6f1e8"),
            stroke: (paint: rgb("#d6cab5"), thickness: 0.8pt),
          )[
            #place(center + horizon)[
              #text(size: 7pt, weight: "medium", fill: luma(55%))[PHOTO]
            ]
          ]
        }

        grid(
          inset: 0pt,
          columns: (1fr, auto),
          column-gutter: 0.8cm,
          align: (start, top),
          align(top)[#header-info],
          align(top)[#box(outset: (bottom: -header-title-lift - offset))[
            #move(dy: -header-title-lift - offset)[#header-avatar]
          ]],
        )
      }
    } else {
      align(header-align)[#header-info]
    }
  ]
  v(-0.5cm)
}
