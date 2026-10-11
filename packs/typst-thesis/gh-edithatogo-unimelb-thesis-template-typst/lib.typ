// =================================
// University of Melbourne Thesis Template Library
// =================================

// Import utilities
#import "utils/style.typ": *
#import "utils/locales.typ": locale-labels
#import "config/index.typ": config

#let default-profile = sys.inputs.at("profile", default: "default")
#let default-font-theme = sys.inputs.at("font_theme", default: "unimelb")
#let default-locale = sys.inputs.at("locale", default: "en")
#let default-show-logo = sys.inputs.at("show_logo", default: true)

// Import page components
#import "pages/title.typ": title-page
#import "pages/abstract.typ": abstract-page
#import "pages/declaration.typ": declaration-page
#import "pages/acknowledgements.typ": acknowledgements-page
#import "pages/preface.typ": preface-page
#import "pages/front-matter.typ": (
  loa-page, lof-page, lot-page, third-party-page, toc-page,
)
#import "pages/landscape-sample.typ": landscape-sample-page
#import "pages/glossary.typ": (
  abbreviations-page, comprehensive-glossary-page, glossary-page,
)
#import "endmatter/optional-glossary.typ": (
  optional-abbreviations-page, optional-glossary-abbreviations-page,
  optional-glossary-page,
)
#import "endmatter/optional-index.typ": (
  optional-index-glossary-page, optional-index-page,
  optional-index-with-subentries,
)
#import "pages/appendix.typ": appendix-page

// Import automated index functions
#import "config/index.typ": (
  auto-extract-index, extract-index-terms, format-page-references,
  generate-index, generate-index-page, get-index-stats, get-index-terms,
  get-term-references, index-term, validate-index,
)

// Import automated glossary functions
#import "config/glossary.typ": (
  add-glossary-terms, auto-extract-glossary, extract-technical-terms,
  extract-terms-from-content, generate-full-glossary, generate-glossary-entry,
  generate-glossary-index, generate-glossary-page, get-extracted-glossary,
  glossary-term,
)

// Import layout components
#import "layouts/document.typ": (
  appendix-layout, front-matter-layout, main-matter-layout,
)

// =================================
// Bibliography Setup
// =================================

// Bibliography style presets
#let bibliography-styles = (
  apa: "apa",
  ieee: "ieee",
  numeric: "numeric",
  author_year: "author-year",
  chicago: "chicago-author-date",
  mla: "mla",
)

// Custom bibliography function with selectable style presets
#let thesis-bibliography(
  metadata,
  path,
  title: "Bibliography",
) = {
  // Get style from metadata and validate/resolve it
  let style-key = metadata.bibliography_style
  let resolved-style = if type(style-key) == "string" {
    bibliography-styles.at(style-key, default: style-key)
  } else {
    style-key
  }

  heading(title, numbering: none)
  bibliography(path, style: resolved-style)
}

// =================================
// Main Thesis Template Function
// =================================

#let thesis(
  title: none,
  subtitle: none,
  author: none,
  degree: none,
  department: none,
  school: none,
  university: none,
  supervisor: none,
  co_supervisor: none,
  submission_date: none,
  abstract: none,
  keywords: (),
  acknowledgements: none,
  declaration: none,
  preface: none,
  blind: false,
  double_sided: false,
  font_theme: default-font-theme,
  locale: default-locale,
  profile: default-profile,
  show_logo: default-show-logo,
  bibliography_style: "apa",
  word_count: none,
  includes_publications: false,
  percentage_dissertation: none,
  percentage_creative: none,
  ai_usage: none,
  third_party_assistance: none,
  third_party_items: (),
  metadata_overrides: (:),
  preface_contributions: (),
  preface_sections: (),
  publications: (),
  appendices: (),
  include_bibliography: true,
  bibliography_path: "references.bib",
  include_glossary: false,
  include_abbreviations: false,
  include_index: false,
  index_entries: (:),
  body,
) = {
  let style = make-thesis-style(font_theme: font_theme)
  let labels = locale-labels(locale: locale)
  let base-metadata = (
    title: title,
    subtitle: subtitle,
    author: author,
    degree: degree,
    department: department,
    school: school,
    university: university,
    supervisor: supervisor,
    co_supervisor: co_supervisor,
    submission_date: submission_date,
    abstract: abstract,
    keywords: keywords,
    acknowledgements: acknowledgements,
    preface: preface,
    bibliography_style: bibliography_style,
    word_count: word_count,
    includes_publications: includes_publications,
    percentage_dissertation: percentage_dissertation,
    percentage_creative: percentage_creative,
    ai_usage: ai_usage,
    third_party_assistance: third_party_assistance,
    third_party_items: third_party_items,
    preface_contributions: preface_contributions,
    preface_sections: preface_sections,
    publications: publications,
    appendices: appendices,
    include_bibliography: include_bibliography,
    bibliography_path: bibliography_path,
    include_glossary: include_glossary,
    include_abbreviations: include_abbreviations,
    include_index: include_index,
    index_entries: index_entries,
  )

  let metadata = (config.metadata.resolve)(
    base-metadata,
    overrides: metadata_overrides,
  )

  let ctx = (
    style: style,
    labels: labels,
    locale: labels.locale,
    profile: profile,
    font_theme: font_theme,
    show_logo: show_logo,
    metadata: metadata,
  )

  let effective-university = if metadata.university != none {
    metadata.university
  } else { labels.university_name }
  let resolved-double = double_sided or profile == "print"

  set document(
    title: metadata.title,
    author: metadata.author,
    keywords: metadata.keywords,
  )

  // =================================
  // Front Matter
  // =================================

  front-matter-layout(ctx)[
    // Title page
    #title-page(
      ctx,
      title: metadata.title,
      subtitle: metadata.subtitle,
      author: metadata.author,
      degree: metadata.degree,
      department: metadata.department,
      school: metadata.school,
      university: effective-university,
      supervisor: metadata.supervisor,
      co_supervisor: metadata.co_supervisor,
      submission_date: metadata.submission_date,
      blind: blind,
    )

    // Abstract
    #if metadata.abstract != none {
      abstract-page(ctx, metadata.abstract, keywords: metadata.keywords)
    }

    // Declaration
    #declaration-page(
      ctx,
      candidate_name: metadata.author,
      thesis_title: metadata.title,
      degree: metadata.degree,
      word_count: metadata.word_count,
      includes_publications: metadata.includes_publications,
      percentage_dissertation: metadata.percentage_dissertation,
      percentage_creative: metadata.percentage_creative,
      ai_usage: metadata.ai_usage,
      third_party_assistance: metadata.third_party_assistance,
    )

    // Acknowledgements
    #if metadata.acknowledgements != none and not blind {
      acknowledgements-page(ctx, metadata.acknowledgements)
    }

    // Preface
    #if (
      metadata.preface != none
        or metadata.preface_contributions.len() > 0
        or metadata.preface_sections.len() > 0
    ) {
      preface-page(ctx, metadata)
    }

    // Tables of contents and listings
    #toc-page(ctx)
    #lof-page(ctx)
    #lot-page(ctx)
    #loa-page(ctx)
    #third-party-page(ctx, metadata.third_party_items)
  ]

  // =================================
  // Main Content
  // =================================

  main-matter-layout(ctx, title: metadata.title, double-sided: resolved-double)[
    #body
  ]

  // =================================
  // Appendices
  // =================================

  if metadata.appendices.len() > 0 {
    appendix-layout(ctx)[
      appendix-page(ctx, metadata)
    ]
  }

  // =================================
  // Bibliography
  // =================================

  if include_bibliography {
    thesis-bibliography(metadata, bibliography_path)
  }

  // =================================
  // Glossary
  // =================================

  if metadata.include_glossary {
    comprehensive-glossary-page()
  }

  // =================================
  // Abbreviations
  // =================================

  if metadata.include_abbreviations {
    optional-abbreviations-page()
  }

  // =================================
  // Index
  // =================================

  if metadata.include_index {
    generate-index-page()
  }
}

// =================================
// Additional Utility Functions
// =================================

// Proof environment
#let proof(body) = {
  block[
    *Proof.*#h(1em)
    #body
    #h(1fr) $square$
  ]
}

// Enhanced figure with subfigures
#let figurex = figure.with(
  kind: "figure",
  supplement: "Figure",
)

// Enhanced table with advanced features
#let tablex-enhanced = tablex.with(
  auto-lines: false,
  header-rows: 1,
  header-hlines-have-priority: true,
  column-gutter: 1em,
)


// Word count display
#let display-word-count(text) = {
  let count = word-count(text)
  [Word count: #count]
}

// Character count display
#let display-char-count(text) = {
  let count = char-count(text)
  [Character count: #count]
}

// Page count display
#let display-page-count = context {
  let count = counter(page).final().first()
  [Page count: #count]
}

// =================================
// Embedded PDF Support
// =================================

// Include embedded PDF pages
// Note: Page numbering display control requires custom layout modifications
// For now, this function embeds PDFs which are automatically counted in page numbering
#let embed-pdf(
  path,
  pages: none,
  caption: none,
  alt: none,
  width: 100%,
  height: auto,
  fit: "contain",
) = {
  // If no specific pages requested, try to embed the first page as a fallback
  // In practice, users should specify pages explicitly
  let page-list = if pages == none {
    (1,) // Default to first page
  } else {
    pages
  }

  // Create a figure for each page if caption is provided
  if caption != none {
    figure(
      caption: caption,
      {
        for page-num in page-list {
          // Embed the PDF page
          image(
            path,
            page: page-num,
            width: width,
            height: height,
            fit: fit,
            alt: alt,
          )

          // Add page break between pages (except for the last one)
          if page-num != page-list.last() {
            pagebreak()
          }
        }
      },
    )
  } else {
    // No caption, just embed the pages
    for page-num in page-list {
      // Embed the PDF page
      image(
        path,
        page: page-num,
        width: width,
        height: height,
        fit: fit,
        alt: alt,
      )

      // Add page break between pages (except for the last one)
      if page-num != page-list.last() {
        pagebreak()
      }
    }
  }
}

// =================================
// Export all components
// =================================
