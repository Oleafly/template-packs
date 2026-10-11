#import "@preview/cmarker:0.1.10"
#import "@preview/mitex:0.2.7"
#import "@preview/cheq:0.4.0"
// --- REUSABLE MARKDOWN RENDERER FUNCTION ---

#let clean-markdown-math(md) = {
  md = md.replace(
    regex("(?m)([ \t]+|\\||\\*|^)\\(([^)+\n]+)\\)"),
    m => {
      let prefix = m.captures.at(0)
      let inner = m.captures.at(1).trim()

      // 1. SKIP ONLY LOWERCASE ENGLISH WORDS (like input, optional)
      // Changing [a-zA-Z] to [a-z] ensures terms with uppercase letters like Mgl or J are treated as math
      if inner.match(regex("^[a-z]{2,}$")) != none {
        return m.text
      }

      // 2. Prevent formatting if the parenthesis is wrapped inside [ ... ]
      let match_pos = md.position(m.text)
      if match_pos > 0 and md.at(match_pos - 1) == "[" {
        return m.text
      }

      // 3. Otherwise, convert safely to Typst inline math
      return prefix + "$" + inner + "$"
    },
  )

  md = md.replace(regex("\\\\\\[\\s*"), "$$")
  md = md.replace(regex("\\s*\\\\\\]"), "$$")

  md = md.replace(regex("(?m)^\\[\\s*"), "$$")
  md = md.replace(regex("(?m)^\\s*\\]"), "$$")

  md = md.replace(regex("\\\\\\(\\s*"), "$")
  md = md.replace(regex("\\s*\\\\\\)"), "$")
  return md
}


#let render-md-doc(file-path, remove-dash: false, remove-emoji: true, convert-latex: true) = {
  // Convert path type to string safely if a path object was provided
  let path-str = if type(file-path) == path {
    // repr(path("a/b")) outputs 'path("a/b")'. We slice off 'path("' and '")'
    let r = repr(file-path)
    r.slice(6, -2)
  } else {
    file-path
  }

  // 1. Extract the folder directory containing the markdown file
  let file-dir = path-str.split("/").slice(0, -1).join("/")
  let base-path = if file-dir != "" { file-dir + "/" } else { "" }

  // 2. Extract frontmatter metadata and layout content
  // Note: read() natively accepts both string and path types, so we pass file-path
  //
  let md = read(file-path)
  // Remove emojis from the text
  if remove-emoji {
    md = md.replace(regex("[\u{1F300}-\u{1F9FF}\u{1F600}-\u{1F64F}\u{2700}-\u{27BF}]"), "")
  }
  if remove-emoji {
    // \p{Extended_Pictographic} catches all modern emojis and their modifiers
    md = md.replace(regex("\p{Extended_Pictographic}"), "")
  }
  if remove-dash {
    md = md.replace("---", "")
  }
  md = md.replace(regex("\s*\n*={3,}\s*\n*"), "=")
  if convert-latex {
    md = clean-markdown-math(md)
  }
  let (meta, md-body) = cmarker.render-with-metadata(
    md,
    metadata-block: "frontmatter-yaml",
    // Fix: Intercept and append the base path directly to image sources
    scope: (
      image: (source, alt: none, ..args) => figure(image(base-path + source, alt: alt, ..args), caption: alt),
    ),
    math: mitex.mitex,
    task-list-marker: checked => if checked { cheq.checked-sym() } else { cheq.unchecked-sym() },
  )

  // 3. Render centered header ONLY if a title is specified in the YAML frontmatter
  if meta != none and "title" in meta {
    align(center)[
      #block(width: eval(meta.at("header_width", default: "100%")))[
        #text(size: eval(meta.at("title_size", default: "14pt")), weight: "bold")[#meta.at("title")]
        #if "subtitle" in meta [#v(0.1em); #text(size: eval(meta.at("subtitle_size", default: "10pt")))[#meta.at(
            "subtitle",
          )]]
        #if "author" in meta [#v(0.1em); #text(size: eval(meta.at("author_size", default: "14pt")))[#meta.at("author")]]
        #if "date" in meta [#v(0.1em); #text(
            size: eval(meta.at("date_size", default: "11pt")),
            fill: rgb("666666"),
          )[#meta.at("date")]]
        #v(0.2em)
      ]
    ]
  }

  // 4. Output the document content
  md-body
}


