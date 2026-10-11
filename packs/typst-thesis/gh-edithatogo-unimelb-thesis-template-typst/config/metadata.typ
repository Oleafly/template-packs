#let required-fields = (
  "title",
  "author",
  "degree",
  "department",
  "school",
  "university",
  "submission_date",
)

#let resolve(base, overrides: (:)) = {
  let pick = (key, fallback) => {
    let override = overrides.at(key, default: none)
    if override != none { override } else { fallback }
  }

  let meta = (
    title: pick("title", base.at("title", default: none)),
    subtitle: pick("subtitle", base.at("subtitle", default: none)),
    author: pick("author", base.at("author", default: none)),
    degree: pick("degree", base.at("degree", default: none)),
    department: pick("department", base.at("department", default: none)),
    school: pick("school", base.at("school", default: none)),
    university: pick("university", base.at("university", default: none)),
    supervisor: pick("supervisor", base.at("supervisor", default: none)),
    co_supervisor: pick("co_supervisor", base.at(
      "co_supervisor",
      default: none,
    )),
    submission_date: pick("submission_date", base.at(
      "submission_date",
      default: none,
    )),
    abstract: pick("abstract", base.at("abstract", default: none)),
    keywords: pick("keywords", base.at("keywords", default: ())),
    acknowledgements: pick("acknowledgements", base.at(
      "acknowledgements",
      default: none,
    )),
    preface: pick("preface", base.at("preface", default: none)),
    bibliography_style: pick("bibliography_style", base.at(
      "bibliography_style",
      default: "apa",
    )),
    word_count: pick("word_count", base.at("word_count", default: none)),
    includes_publications: pick("includes_publications", base.at(
      "includes_publications",
      default: false,
    )),
    percentage_dissertation: pick("percentage_dissertation", base.at(
      "percentage_dissertation",
      default: none,
    )),
    percentage_creative: pick("percentage_creative", base.at(
      "percentage_creative",
      default: none,
    )),
    ai_usage: pick("ai_usage", base.at("ai_usage", default: none)),
    third_party_assistance: pick("third_party_assistance", base.at(
      "third_party_assistance",
      default: none,
    )),
    third_party_items: pick("third_party_items", base.at(
      "third_party_items",
      default: (),
    )),
    preface_contributions: pick("preface_contributions", base.at(
      "preface_contributions",
      default: (),
    )),
    preface_sections: pick("preface_sections", base.at(
      "preface_sections",
      default: (),
    )),
    publications: pick("publications", base.at("publications", default: ())),
    appendices: pick("appendices", base.at("appendices", default: ())),
    include_bibliography: pick("include_bibliography", base.at(
      "include_bibliography",
      default: true,
    )),
    bibliography_path: pick("bibliography_path", base.at(
      "bibliography_path",
      default: "references.bib",
    )),
    include_glossary: pick("include_glossary", base.at(
      "include_glossary",
      default: false,
    )),
    include_abbreviations: pick("include_abbreviations", base.at(
      "include_abbreviations",
      default: false,
    )),
    include_index: pick("include_index", base.at(
      "include_index",
      default: false,
    )),
    index_entries: pick("index_entries", base.at(
      "index_entries",
      default: (:),
    )),
  )

  for field in required-fields {
    if meta.at(field, default: none) == none {
      panic(
        "Missing required metadata field '"
          + field
          + "'. Provide it via thesis(...).",
      )
    }
  }

  meta
}
