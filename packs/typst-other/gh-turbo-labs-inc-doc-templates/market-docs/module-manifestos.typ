#let project(title: "", authors: (), date: none, body) = {
  // Set document properties
  set document(author: authors, title: title)
  set page(
    margin: (left: 1.5cm, right: 1.5cm, top: 2cm, bottom: 2cm),
    numbering: "1 / 1", // Display current page / total pages
    number-align: center,
  )

  // Set paragraph spacing
  set par(justify: true, leading: 0.75em, first-line-indent: 0pt)

  // Set text properties
  set text(font: "PP Neue Montreal", size: 11pt)

  // Title page header
  align(left)[
    #grid(
      columns: (1fr, 2fr),
      gutter: 1em,
      align(left)[
        #text(size: 20pt, weight: "bold")[Narrative AI] // Placeholder if no image
      ],
      align(right)[
        #text(weight: "bold", size: 14pt)[MODULE MANIFESTOS]
        #linebreak()
        #text(size: 10pt)[Internal Documentation · May 2025]
      ]
    )
    #line(length: 100%, stroke: rgb("#dddddd"))
    #v(1cm)
  ]

  // Main body
  body

  // Footer for all pages
  set page(
    footer: [
      #line(length: 100%, stroke: rgb("#dddddd"))
      #grid(
        columns: (1fr, 1fr, 1fr),
        align(left)[
          [Confidential]
        ],
        align(center)[
          counter(page).display("1 / " + counter(page).final().at(0).display())
        ],
        align(right)[
          #text(style: "italic")[Transform Your Thinking]
        ]
      )
    ]
  )
}

// Heading Styles
#let h1(heading) = {
  set text(weight: "regular", size:20pt, hyphenate: false)
  v(1em)
  [#heading]
  v(0.5em)
}
#let h2(heading) = {
  set text(weight: "semibold", size:14pt, hyphenate: false)
  v(0.75em)
  [#heading]
  v(0.3em)
}
#let h3(heading) = {
  set text( size:12pt, font:"Fira Mono", fill: black, weight: "bold", hyphenate: false)
   v(0.5em)
  [#heading]
   v(0.2em)
}

// Line breaks
#let lightlinebreak() = {
 v(0.5cm)
 line(stroke: gray, length: 100%)
 v(0.5cm)
}
#let darklinebreak() = {
 v(0.5cm)
 line(length: 100%)
 v(0.5cm)
}

// Component for standard text sections
#let manifesto_section(section_title, section_content) = {
  h2(section_title)
  section_content
  v(0.5em)
}

// REVISED AND SIMPLIFIED: Helper to parse markdown lists
#let parse_md_list(text) = {
  let items = ()
  for line in text.split("\n") {
    let trimmed_line = line.trim()
    let content_item = ""
    let marker_stripped = false

    // Strip common list markers
    if trimmed_line.starts-with("- ") {
      content_item = trimmed_line.slice(2).trim()
      marker_stripped = true
    } else if trimmed_line.starts-with("* ") {
      content_item = trimmed_line.slice(2).trim()
      marker_stripped = true
    } else {
      let num_match = trimmed_line.match(regex("^[0-9]+\.\s+"))
      if num_match != none {
        content_item = trimmed_line.slice(num_match.end()).trim()
        marker_stripped = true
      } else {
        // Basic indented item marker stripping (more robust)
        let indent_marker_match = trimmed_line.match(regex("^\s*(-|\*)\s"))
        if indent_marker_match != none {
          content_item = trimmed_line.slice(indent_marker_match.end()).trim()
          marker_stripped = true
        }
      }
    }

    if marker_stripped {
      if content_item == "" {
        items.push("") // Handle empty list items
      } else {
        let processed = false
        // Pattern: "**Key**: Value"
        let idx_colon_space = content_item.find(": ")
        if content_item.starts-with("**") and idx_colon_space != none and type(idx_colon_space) == int and idx_colon_space > 2 {
            // Check if the format is "**Key**: Value" (colon is NOT bold)
            // We need to ensure the bold ends before the colon
            let potential_key_end_marker = "**: " // Key part ends with **
            let key_end_pos = content_item.find(potential_key_end_marker)
            
            if key_end_pos != none and type(key_end_pos) == int and key_end_pos == idx_colon_space - 2 { // i.e. "**Key" + "**" + ": "
                let key_text = content_item.slice(2, key_end_pos)
                let value_text = content_item.slice(idx_colon_space + 2)
                items.push([#strong(key_text + ":") #value_text])
                processed = true
            } else if not processed { // Fallback for cases like "**A bit longer key**: value"
                let key_text = content_item.slice(2, idx_colon_space)
                let value_text = content_item.slice(idx_colon_space + 2)
                items.push([#strong(key_text + ":") #value_text])
                processed = true
            }
        }

        // Pattern: "**Key:** Value" (colon is part of the bold string)
        if not processed {
            let idx_colon_inside_bold = content_item.find(":** ")
            if content_item.starts-with("**") and idx_colon_inside_bold != none and type(idx_colon_inside_bold) == int and idx_colon_inside_bold > 2 {
                let key_text = content_item.slice(2, idx_colon_inside_bold)
                let value_text = content_item.slice(idx_colon_inside_bold + 4) // length of ":** " is 4
                items.push([#strong(key_text + ":") #value_text])
                processed = true
            }
        }
        
        if not processed {
            // General bolding if not the key-value pattern
            if content_item.starts-with("**") and content_item.ends-with("**") {
              items.push(strong(content_item.slice(2, -2)))
            } else {
              items.push(content_item) // Regular text
            }
        }
      }
    }
  }
  items
}

// Component for standard bullet lists using the REVISED parser
#let manifesto_bullet_list(section_title, md_text) = {
  h2(section_title)
  let parsed_items = parse_md_list(md_text)
  if parsed_items.len() > 0 {
    list(..parsed_items.map(item => item))
  }
  v(0.5em)
}

// Component for two-column list table
#let two_column_list_table(section_title, list_items) = {
  h2(section_title)
  let cells = ()
  for item in list_items {
    cells.push(item.at(0))
    cells.push(item.at(1))
  }
  table(
    columns: (auto, 1fr),
    inset: 8pt,
    align: (left + top, left + top),
    stroke: none,
    ..cells
  )
  v(0.5em)
}

#show: project.with(
  title: "Narrative AI Module Manifestos",
  authors: ("Narrative AI",),
  date: "May 2025",
)

// --- Butter DS Module Manifesto ---
#pagebreak()
#h1("Butter DS Module")

#manifesto_section(
  "Executive Summary",
  [Butter DS is the foundational design system module within Narrative AI's presentation platform. It functions as a comprehensive component library for building slides, similar to a sophisticated React component library but specifically optimized for presentation contexts. Butter DS provides the visual building blocks that power the entire slide ecosystem, enabling consistent, brand-aligned, and visually stunning presentations without requiring design expertise from users.]
)

#manifesto_section(
  "Module Purpose",
  [Butter DS serves as the visual foundation upon which all slides in the Narrative AI ecosystem are built. It provides a code-driven design system specifically for slides and marketing content, representing a fundamentally different approach from competitors who are adding AI to existing deck builders. This module enables programmatic control of all design elements, ensuring all slides within the ecosystem can be perfectly branded and visually harmonious regardless of content type. The module maintains a clear separation from content creation, focusing exclusively on the visual representation and styling of content. When it's time to generate slides, other modules use Butter DS components to assemble the visual presentation based on content from the Skeleton Editor.]
)

#two_column_list_table(
  "Core Value Proposition",
  (
    (strong("ensures visual harmony across all slides:"), [Ensures visual harmony across all slides regardless of content]),
    (strong("enables perfect branding across the ecosystem:"), [Enables perfect branding across the entire presentation ecosystem]),
    (strong("provides reusable blocks for thousands of variations:"), [Provides building blocks that can be composed into thousands of different slide variations]),
    (strong("creates a foundation that improves with scale:"), [Creates a foundation that improves with scale rather than becoming more complex]),
    (strong("allows changes to spread automatically:"), [Allows changes to propagate across entire slide libraries automatically])
  )
)

#manifesto_section(
  "Object Model Summary",
  [Butter DS is built around a component-based architecture:
  #list(
      [#strong("DesignSystem"): The top-level container representing the entire design system configuration],
      [#strong("Components"): Reusable visual elements that can be composed into slides],
      [#strong("Tokens"): Design variables that control visual properties across the system],
      [#strong("Themes"): Collections of tokens that define visual styles for different brands],
      [#strong("Layouts"): Structural frameworks for arranging components on slides]
  )
  Supporting objects include StyleRules for defining visual behaviors and ComponentVariants for different visual states of components.]
)

#manifesto_section(
  "Key Processes",
  [Butter DS facilitates several critical processes:

  #h3("Component Rendering")
  #list(
    [Transforming component definitions into visual elements],
    [Applying theme tokens to components],
    [Handling responsive behaviors across different slide dimensions],
    [Optimizing visual performance]
  )

  #h3("Theme Application")
  #list(
    [Mapping brand elements to design tokens],
    [Applying themes consistently across components],
    [Handling theme switching and overrides],
    [Ensuring accessibility within themes]
  )

  #h3("Component Composition")
  #list(
    [Combining primitive components into complex structures],
    [Managing layout and spacing relationships],
    [Handling component nesting and inheritance],
    [Ensuring visual harmony in compositions]
  )
  ]
)

#manifesto_section(
  "Efficacy Metrics",
  [Butter DS's success will be measured by:

  #h3("Component Coverage")
  #list(
      [Percentage of slide designs that can be built with existing components],
      [Ability to represent 90% of common presentation patterns with the component library]
  )

  #h3("Brand Fidelity")
  #list(
      [Accuracy of brand representation compared to official guidelines],
      [Consistency of brand application across different slide types]
  )

  #h3("Design Quality")
  #list(
      [Professional quality rating of generated slides by design experts],
      [User satisfaction with visual appearance of slides]
  )
  ]
)

#two_column_list_table(
  "Competitive Differentiation",
  (
    (strong("uses code, not templates like others:"), [Unlike template-based approaches in traditional tools]),
    (strong("built on components, unlike static designs:"), [Fundamentally different from static slide designs]),
    (strong("allows systematic updates and branding:"), [Enables systematic updates and brand application]),
    (strong("keeps visuals consistent regardless of content:"), [Ensures visual consistency regardless of content]),
    (strong("it's unique:"), [No competitor offers a comparable component-based design system specifically built for presentations. This module represents a key technological moat that would be difficult for competitors to replicate.])
  )
)

#manifesto_bullet_list(
  "Relationship to Other Modules",
   "- **Skeleton Editor**: Receives content that will be styled using Butter DS components\n- **Slide Component Library**: Provides the visual building blocks for slide components\n- **Deck Editor**: Renders the final slides using Butter DS components\n- **Onboarding Brand Setup**: Receives brand guidelines to create appropriate themes\n- **Template Ingestion**: Provides visual styling for ingested templates"
)

// --- Context Window Module Manifesto ---
#pagebreak()
#h1("Context Window Module")

#manifesto_section(
  "Executive Summary",
  [The Context Window is the primary user interaction module within Narrative AI's presentation platform. It functions as a chat client that serves as the starting point for users and remains available throughout the presentation creation process. The Context Window enables users to express their thoughts, receive AI assistance, and make large-scale operations to the content skeleton without directly manipulating individual elements. It also supports Model Context Protocol (MCP) integrations that allow users to incorporate external data sources into their presentations.]
)

#manifesto_section(
  "Module Purpose",
  [The Context Window serves as the conversational interface through which users initiate and guide the presentation creation process. It provides multiple interaction formats (conversation, rambling voice, interview) to accommodate different user preferences and thinking styles. This module focuses on helping users get their thoughts out quickly and efficiently, then translating those thoughts into structured content in the Skeleton Editor. The module maintains a clear separation from content editing and visualization, focusing exclusively on high-level user interaction and AI-assisted content generation. It serves as both the entry point to the system and an ongoing assistant throughout the creation process.]
)

#two_column_list_table(
  "Core Value Proposition",
  (
    (strong("lets users express ideas quickly and naturally:"), [Quick and natural expression of ideas without structural constraints]),
    (strong("intelligently turns thoughts into organized content:"), [Intelligent transformation of unstructured thoughts into organized content]),
    (strong("seamlessly brings in data from external sources:"), [Seamless incorporation of data from external sources via MCP]),
    (strong("provides ongoing help throughout creation:"), [Ongoing support throughout the presentation creation process]),
    (strong("minimizes revisions needed after creation:"), [Minimizing the need for content revisions after initial creation])
  )
)

#manifesto_section(
  "Object Model Summary",
  [The Context Window is built around a conversation-based architecture:
  #list(
    [#strong("Conversation"): The top-level container representing the entire interaction history],
    [#strong("Messages"): Individual user inputs and system responses],
    [#strong("MCPConnectors"): Integrations with external data sources],
    [#strong("ConversationModes"): Different interaction formats (conversation, ramble, interview)],
    [#strong("ContentOperations"): Actions that modify the content skeleton based on conversation]
  )
  Supporting objects include ContextMemory for maintaining conversation history and IntentRecognition for understanding user goals.]
)

#manifesto_section(
  "Key Processes",
  [The Context Window facilitates several critical processes:

  #h3("Conversation Management")
  #list(
    [Capturing user input in various formats],
    [Generating appropriate AI responses],
    [Maintaining conversation context and history],
    [Switching between conversation modes]
  )

  #h3("Content Generation")
  #list(
    [Transforming conversational input into structured content],
    [Suggesting content organization and structure],
    [Generating draft content based on user direction],
    [Refining content based on feedback]
  )

  #h3("External Integration")
  #list(
    [Connecting to external data sources via MCP],
    [Extracting relevant information from connected sources],
    [Transforming external data into presentation content],
    [Maintaining links to source data for updates]
  )
  ]
)

#manifesto_section(
  "Efficacy Metrics",
  [The Context Window's success will be measured by:

  #h3("Thought Capture Efficiency")
  #list(
    [Time required for users to express their presentation ideas],
    [Completeness of captured information from initial conversation],
    [Number of follow-up clarifications needed]
  )

  #h3("Content Quality")
  #list(
    [Accuracy of AI-generated content based on conversation],
    [Appropriateness of content structure and organization],
    [Reduction in manual editing required after generation]
  )

  #h3("User Experience")
  #list(
    [User satisfaction with conversation flow],
    [Time saved compared to traditional content creation],
    [Number of changes to the skeleton after initial generation]
  )
  ]
)


#two_column_list_table(
  "Competitive Differentiation",
  (
    (strong("offers flexible input, unlike rigid forms:"), [Unlike rigid input forms in traditional tools]),
    (strong("connects to external data, unlike isolated systems:"), [Fundamentally different from isolated content creation systems]),
    (strong("gives ongoing support, not just one-time help:"), [Ongoing support rather than one-time generation]),
    (strong("lets users change structure via conversation:"), [Direct manipulation of content structure through conversation]),
    (strong("it's unique:"), [No competitor offers a comparable conversation-based approach with the same level of external data integration and content structure manipulation. This module represents a key differentiator that would be difficult for competitors to replicate.])
  )
)

#manifesto_bullet_list(
  "Relationship to Other Modules",
   "- **Skeleton Editor**: Sends generated content to the Skeleton Editor for structure\n- **Slide Lookup**: Provides content context for slide recommendations\n- **Butter DS**: Indirectly influences design through content structure\n- **Deck Editor**: Provides guidance for final presentation refinement\n- **Onboarding Brand Setup**: Incorporates brand context into content suggestions"
)

// --- Deck Editor Module Manifesto ---
#pagebreak()
#h1("Deck Editor Module")

#manifesto_section(
  "Executive Summary",
  [The Deck Editor module is the final presentation assembly and refinement system within Narrative AI's presentation platform. It transforms the structured content from the Skeleton Editor into complete, visually stunning slides using recommendations from the Slide Lookup module. The Deck Editor provides users with the ability to review, refine, and finalize their presentations without requiring direct manipulation of design elements, representing the culmination of Narrative AI's unique approach to presentation creation.]
)

#manifesto_section(
  "Module Purpose",
  [The Deck Editor serves as the presentation finalization interface where users can see their content transformed into professionally designed slides. It enables users to review slide recommendations, select alternative designs, and make final adjustments without ever needing to directly manipulate design elements. This module focuses on providing a harmonious "now that I see it" experience that bridges content creation and final presentation delivery. This module maintains a clear separation from content creation and component design, focusing exclusively on slide generation, visualization, and final refinement. Its effectiveness is measured by how rarely users feel the need to directly edit design elements, with success defined by users finding the polish step so effortless that they don't yearn for direct design control.]
)

#two_column_list_table(
  "Core Value Proposition",
  (
    (strong("immediately turns content into professional slides:"), [Immediate transformation of content into professional slides]),
    (strong("offers multiple design options without manual work:"), [Multiple design options for each content block without manual design]),
    (strong("provides simple tools for final tweaks:"), [Simple tools for making final adjustments without design complexity]),
    (strong("includes features like speaker notes and presentation mode:"), [Complete presentation features including speaker notes and presentation mode]),
    (strong("frees users from design tasks while keeping quality control:"), [Liberation from design tasks while maintaining quality control])
  )
)

#manifesto_section(
  "Object Model Summary",
  [The Deck Editor is built around a presentation assembly architecture:
  #list(
    [#strong("Presentation"): The top-level container representing the complete slide deck],
    [#strong("Slides"): Individual slides composed of content and visual design],
    [#strong("SlideAlternatives"): Different design options for the same content],
    [#strong("SpeakerNotes"): Presentation guidance text associated with slides],
    [#strong("PresentationSettings"): Configuration options for the final presentation]
  )
  Supporting objects include SlideTransitions for movement between slides and PresentationExports for creating deliverable files.]
)

#manifesto_section(
  "Key Processes",
  [The Deck Editor facilitates several critical processes:

  #h3("Slide Generation")
  #list(
    [Transforming content blocks into visual slides],
    [Applying slide designs from the Slide Lookup module],
    [Generating multiple design alternatives],
    [Creating coherent visual flow across the presentation]
  )

  #h3("Presentation Refinement")
  #list(
    [Reviewing generated slides],
    [Selecting alternative designs when desired],
    [Making final content adjustments],
    [Ensuring visual consistency across the presentation]
  )

  #h3("Presentation Delivery")
  #list(
    [Generating speaker notes],
    [Creating presentation view],
    [Preparing export formats],
    [Finalizing presentation for delivery]
  )
  ]
)

#manifesto_section(
  "Efficacy Metrics",
  [The Deck Editor's success will be measured by:

  #h3("Design Satisfaction")
  #list(
    [Percentage of slides accepted without design changes],
    [User satisfaction with visual quality],
    [Reduction in desire for direct design manipulation]
  )

  #h3("Refinement Efficiency")
  #list(
    [Time spent in final polish phase],
    [Number of adjustments needed per presentation],
    [Simplicity of refinement process]
  )

  #h3("Presentation Readiness")
  #list(
    [Completeness of generated presentations],
    [Quality of generated speaker notes],
    [Presentation performance across delivery contexts]
  )
  ]
)

#two_column_list_table(
  "Competitive Differentiation",
  (
    (strong("avoids manual slide editing unlike traditional tools:"), [Unlike manual slide editing in traditional tools]),
    (strong("lets users browse options without recreating slides:"), [Ability to browse multiple design options without recreation]),
    (strong("emphasizes the message, not design fiddling:"), [Emphasis on message rather than design manipulation]),
    (strong("smoothly connects content creation to the final deck:"), [Seamless connection between content creation and final presentation]),
    (strong("it's unique:"), [No competitor offers a comparable approach to presentation finalization that maintains the separation between content and design while providing professional quality results. This module represents the culmination of Narrative AI's vision to transform how people create presentations.])
  )
)

#manifesto_bullet_list(
  "Relationship to Other Modules",
   "- **Skeleton Editor**: Receives structured content that forms the basis of slides\n- **Slide Lookup**: Receives slide design recommendations for content\n- **Butter DS**: Utilizes components from the design system for slide rendering\n- **Slide Component Library**: Uses slide designs from the library\n- **Onboarding Brand Setup**: Applies brand identity to final presentation"
)

// --- Onboarding Brand Setup Module Manifesto ---
#pagebreak()
#h1("Onboarding Brand Setup Module")

#manifesto_section(
  "Executive Summary",
  [The Onboarding Brand Setup module is a critical entry point within Narrative AI's presentation platform that enables rapid brand integration and aesthetic matching. This module allows users to quickly establish their brand identity or find an aesthetic that matches their vision through an intuitive, streamlined process. The Onboarding Brand Setup module represents a significant user experience enhancement that removes traditional barriers to creating branded presentations.]
)

#manifesto_section(
  "Module Purpose",
  [The Onboarding Brand Setup module serves as the brand identity foundation for the entire presentation platform. It provides a fast, intuitive process for either matching an existing brand or helping users discover an aesthetic that aligns with their vision. This module focuses on capturing brand elements and preferences in seconds rather than minutes, using innovative approaches like quiz-style interactions and visual preference selection. This module maintains a clear separation from content creation and slide design, focusing exclusively on brand identity extraction, analysis, and configuration. Its effectiveness is measured by user satisfaction with the selected brand and the speed of the process, which should not exceed two minutes.]
)

#two_column_list_table(
  "Core Value Proposition",
  (
    (strong("automatically extracts and applies brand elements:"), [Automatic extraction and application of brand elements]),
    (strong("offers intuitive tools to find the right visual style:"), [Intuitive tools for finding visual styles that match user vision]),
    (strong("completes brand setup in under two minutes:"), [Complete brand setup in under two minutes]),
    (strong("gets rid of complex configuration screens:"), [Elimination of complex configuration screens]),
    (strong("ensures visual harmony across the presentation:"), [Ensuring visual harmony across all presentation elements])
  )
)

#manifesto_section(
  "Object Model Summary",
  [The Onboarding Brand Setup module is built around a brand identity architecture:
  #list(
    [#strong("BrandProfile"): The top-level container representing the complete brand identity],
    [#strong("BrandElements"): Core visual components of the brand (colors, typography, imagery, etc.)],
    [#strong("StylePreferences"): User preferences for visual aesthetics],
    [#strong("BrandSources"): Origins of brand information (uploaded guidelines, websites, etc.)],
    [#strong("BrandRules"): Specifications for how brand elements should be applied]
  )
  Supporting objects include BrandExtractors for obtaining brand information and StyleRecommenders for suggesting aesthetics.]
)

#manifesto_section(
  "Key Processes",
  [The Onboarding Brand Setup module facilitates several critical processes:

  #h3("Brand Extraction")
  #list(
    [Analyzing uploaded brand guidelines],
    [Scraping brand elements from websites],
    [Processing logo and visual assets],
    [Identifying brand color schemes and typography]
  )

  #h3("Aesthetic Matching")
  #list(
    [Presenting visual style options],
    [Capturing user preferences through interactive selection],
    [Analyzing preference patterns],
    [Recommending cohesive visual styles]
  )

  #h3("Brand Configuration")
  #list(
    [Transforming extracted elements into system tokens],
    [Creating brand-specific theme configurations],
    [Validating brand consistency],
    [Finalizing brand setup for use across the platform]
  )
  ]
)

#manifesto_section(
  "Efficacy Metrics",
  [The Onboarding Brand Setup module's success will be measured by:

  #h3("Setup Speed")
  #list(
    [Time to complete brand setup (target: under 2 minutes)],
    [Number of user interactions required],
    [Reduction in configuration complexity]
  )

  #h3("Brand Satisfaction")
  #list(
    [User satisfaction with brand representation],
    [Accuracy of brand element extraction],
    [Appropriateness of aesthetic recommendations]
  )

  #h3("Brand Application")
  #list(
    [Consistency of brand application across slides],
    [Adaptability to different content types],
    [Visual harmony of branded presentations]
  )
  ]
)

#two_column_list_table(
  "Competitive Differentiation",
  (
    (strong("automates branding, unlike manual setup tools:"), [Unlike manual configuration in traditional tools]),
    (strong("finds styles based on preference, not just Browse templates:"), [Fundamentally different from template Browse]),
    (strong("is dramatically faster than conventional setup:"), [Dramatically faster than conventional setup]),
    (strong("automatically understands brand documents:"), [Automatic interpretation of brand documentation]),
    (strong("it's unique:"), [No competitor offers a comparable approach to brand setup with the same level of automation, speed, and preference-based discovery. This module represents a key user experience enhancement that removes significant friction from the presentation creation process.])
  )
)

#manifesto_bullet_list(
  "Relationship to Other Modules",
   "- **Butter DS**: Provides brand elements that inform design system tokens\n- **Slide Component Library**: Influences how slides are styled with brand elements\n- **Context Window**: Incorporates brand context into content suggestions\n- **Deck Editor**: Ensures final slides reflect brand identity"
)

// --- Skeleton Editor Module Manifesto ---
#pagebreak()
#h1("Skeleton Editor Module")

#manifesto_section(
  "Executive Summary",
  [The Skeleton Editor is the foundational content creation and organization module within Narrative AI's presentation platform. It represents a revolutionary approach to presentation authoring that separates content from design while maintaining their relationship. This module embodies Narrative AI's unique technological moat of a "Content Skeleton CMS" that functions as a specialized content management system for presentations, allowing users to focus on their message while the system handles design implementation.]
)

#manifesto_section(
  "Module Purpose",
  [The Skeleton Editor serves as the primary interface for users to create, structure, and organize presentation content in a block-based format. It enables users to focus exclusively on content and narrative flow without being distracted by design considerations. By providing a structured approach to content creation, it ensures presentations maintain logical coherence, appropriate content density, and professional quality regardless of the user's design expertise. This module is fundamental to Narrative AI's value proposition of transforming raw content into professionally designed presentations without requiring users to manually design slides. It represents a paradigm shift from traditional slide-by-slide editing to a content-first approach that dramatically improves efficiency and quality.]
)

#two_column_list_table(
  "Core Value Proposition",
  (
    (strong("lets users focus on message, not design:"), [Focus on message and structure without design distractions]),
    (strong("ensures content follows best practices via structure:"), [Structured approach ensures content follows presentation best practices]),
    (strong("dramatically cuts down creation and revision time:"), [Dramatically reduces time spent on presentation creation and revisions]),
    (strong("makes sure content flows logically:"), [Ensures content maintains logical flow and coherence]),
    (strong("helps build a strong story across the deck:"), [Facilitates logical flow and storytelling across the presentation])
  )
)

#manifesto_section(
  "Object Model Summary",
  [The Skeleton Editor is built around a hierarchical object model:
  #list(
    [#strong("ContentSkeleton"): The top-level container representing the entire presentation structure],
    [#strong("Sections"): Logical divisions of content within the presentation],
    [#strong("ContentBlocks"): The fundamental units of content that map to slide components],
    [#strong("ContentSchemas"): Define structure and validation rules for different types of blocks],
    [#strong("ContentTemplates"): Pre-defined structures for common presentation patterns]
  )
  Supporting objects include EditHistory for version control and ContentMapping for component relationships.]
)

#manifesto_section(
  "Key Processes",
  [The Skeleton Editor facilitates several critical processes:

  #h3("Content Creation")
  #list(
    [New presentation initialization from scratch or templates],
    [Content block addition with appropriate schemas],
    [Content editing with real-time validation],
    [Section management for logical organization]
  )

  #h3("Content Organization")
  #list(
    [Reordering of blocks and sections],
    [Grouping content into logical hierarchies],
    [Template application to sections or entire presentations]
  )

  #h3("Content Management")
  #list(
    [Version control and history tracking],
    [Content export to other modules],
    [Content import from external sources]
  )
  ]
)

#manifesto_section(
  "Efficacy Metrics",
  [The Skeleton Editor's success will be measured by:

  #h3("Content Creation Efficiency")
  #list(
    [70% reduction in time to create presentation content compared to traditional tools],
    [85% reduction in revision cycles]
  )

  #h3("Content Quality")
  #list(
    [90% of presentations created achieve high narrative coherence scores],
    [95% of content structures successfully map to design components]
  )

  #h3("User Experience")
  #list(
    [80% of users can create a complete presentation structure within 30 minutes of first use],
    [90% user satisfaction rating for content creation process]
  )
  ]
)


#two_column_list_table(
  "Competitive Differentiation",
  (
    (strong("uses blocks, unlike slide-by-slide tools:"), [Unlike slide-by-slide approaches in traditional tools]),
    (strong("separates content and design, unlike template systems:"), [Fundamentally different from template-based systems]),
    (strong("maintains content integrity during editing:"), [Maintains content integrity throughout editing]),
    (strong("smartly adapts content within the structure:"), [Adapts content within structural constraints]),
    (strong("it's unique:"), [No competitor offers a comparable content-first approach with the same level of structure and design integration. This module represents a key technological moat that would be difficult for competitors to replicate.])
  )
)

#manifesto_bullet_list(
  "Relationship to Other Modules",
  "- **Butter DS**: Provides the design system that will be applied to content (handled separately)\n- **Slide Component Library**: Receives content from the Skeleton Editor to populate components\n- **Context Window**: Receives content context to provide relevant AI assistance\n- **Slide Lookup**: Uses content structure to recommend relevant slide components\n- **Deck Template Ingestion**: Provides templates that can be populated via the Skeleton Editor\n- **Onboarding Brand Setup**: Ensures brand guidelines are available for later application\n- **Deck Editor**: Receives content from the Skeleton Editor to generate and visualize slides"
)

// --- Slide Component Library Module Manifesto ---
#pagebreak()
#h1("Slide Component Library Module")

#manifesto_section(
  "Executive Summary",
  [The Slide Component Library is a comprehensive collection of slide designs within Narrative AI's presentation platform. It functions as a massive repository of slide templates, each composed of Butter DS components and designed to work with specific content structures. The Slide Component Library bridges the gap between raw content from the Skeleton Editor and visually stunning slides, providing thousands of professionally designed options that can be matched to user content.]
)

#manifesto_section(
  "Module Purpose",
  [The Slide Component Library serves as the visual pattern repository that powers Narrative AI's slide generation capabilities. It contains a vast collection of slides with defined input schemas that specify what content blocks they work best with and their visual purpose. Each slide in the library is composed of Butter DS components, ensuring design consistency while providing tremendous visual variety. This module maintains a clear separation from both content creation and component design, focusing exclusively on the composition of components into complete slide designs and the management of this slide collection. It provides the visual templates that the Slide Lookup module will match with content from the Skeleton Editor.]
)

#two_column_list_table(
  "Core Value Proposition",
  (
    (strong("offers thousands of pro slide options for different needs:"), [Thousands of professionally designed slide options for different content needs]),
    (strong("clearly specifies which content fits each design:"), [Clear specifications for what content works best with each slide design]),
    (strong("builds all slides from the same library for harmony:"), [All slides built from the same component library for visual harmony]),
    (strong("allows the library to grow continuously:"), [Ability to continuously expand the library with new designs]),
    (strong("optimizes slides for specific communication goals:"), [Slides optimized for specific communication goals and content types])
  )
)

#manifesto_section(
  "Object Model Summary",
  [The Slide Component Library is built around a template-based architecture:
  #list(
    [#strong("SlideCollection"): The top-level container representing the entire library of slides],
    [#strong("SlideTemplate"): Individual slide designs composed of Butter DS components],
    [#strong("InputSchema"): Specifications for what content structures work with each slide],
    [#strong("VisualPurpose"): Categorization of slides by their visual communication goal],
    [#strong("ComponentComposition"): Definitions of how Butter DS components are arranged in each slide]
  )
  Supporting objects include TemplateMetadata for organizing and searching slides and CompatibilityRules for determining content-to-slide matching.]
)

#manifesto_section(
  "Key Processes",
  [The Slide Component Library facilitates several critical processes:

  #h3("Slide Organization")
  #list(
    [Categorizing slides by purpose, industry, and content type],
    [Tagging slides with relevant metadata],
    [Maintaining searchable indices of slides],
    [Versioning slides as they evolve]
  )

  #h3("Schema Definition")
  #list(
    [Defining input requirements for each slide],
    [Mapping content structures to visual elements],
    [Specifying optional and required content fields],
    [Creating validation rules for content compatibility]
  )

  #h3("Library Management")
  #list(
    [Adding new slides to the collection],
    [Updating existing slides],
    [Deprecating outdated slides],
    [Tracking slide usage and effectiveness]
  )
  ]
)

#manifesto_section(
  "Efficacy Metrics",
  [The Slide Component Library's success will be measured by:

  #h3("Library Coverage")
  #list(
    [Number of unique slide designs available],
    [Percentage of common presentation needs covered by the library],
    [Diversity of visual styles and approaches]
  )

  #h3("Content Compatibility")
  #list(
    [Percentage of content structures that match with appropriate slides],
    [Accuracy of input schema specifications],
    [Flexibility of slides to accommodate varied content]
  )

  #h3("Design Quality")
  #list(
    [Professional quality rating of slides by design experts],
    [User satisfaction with slide options],
    [Visual consistency across the library]
  )
  ]
)

#two_column_list_table(
  "Competitive Differentiation",
  (
    (strong("provides thousands of designs, far more than competitors:"), [Thousands of slide designs compared to hundreds in competing systems]),
    (strong("builds slides from components, not static designs:"), [Slides built from consistent components rather than static designs]),
    (strong("designs slides around content needs, not just themes:"), [Slides designed around content needs rather than visual themes alone]),
    (strong("uses comprehensive metadata and categories:"), [Comprehensive metadata and purpose-driven categorization]),
    (strong("it's unique:"), [No competitor offers a comparable library of slides with the same level of organization, scale, and content-design integration. This module represents a key asset that would be difficult for competitors to replicate quickly.])
  )
)

#manifesto_bullet_list(
  "Relationship to Other Modules",
   "- **Butter DS**: Uses components from Butter DS to compose all slides\n- **Skeleton Editor**: Receives content that will be matched with slide designs\n- **Slide Lookup**: Provides the collection of slides that Slide Lookup searches through\n- **Deck Editor**: Supplies slide designs for the final presentation\n- **Template Ingestion**: Receives new slide designs from ingested templates"
)

// --- Slide Lookup Module Manifesto ---
#pagebreak()
#h1("Slide Lookup Module")

#manifesto_section(
  "Executive Summary",
  [The Slide Lookup module is a sophisticated AI-powered system within Narrative AI's presentation platform that matches content blocks from the Skeleton Editor with the most appropriate slide designs from the Slide Component Library. This module represents one of the most advanced LLM features in the platform, serving as the "magic" that transforms structured content into visually stunning slides. The Slide Lookup module employs advanced retrieval techniques to efficiently search through thousands of slide templates and identify the optimal visual representation for each content block.]
)

#manifesto_section(
  "Module Purpose",
  [The Slide Lookup module serves as the intelligent bridge between content and design, analyzing content blocks created in the Skeleton Editor and identifying the most appropriate slide designs from the Slide Component Library. It functions as a sophisticated recommendation engine that understands both content structure and visual communication principles to make optimal matches. This module maintains a clear separation from both content creation and slide design, focusing exclusively on the matching process that connects these elements. Its effectiveness is measured by how well it can identify slides that best represent the user's content, outperforming what users could find manually.]
)

#two_column_list_table(
  "Core Value Proposition",
  (
    (strong("uses smart AI that understands content and design:"), [Advanced AI that understands both content needs and design capabilities]),
    (strong("can efficiently search through thousands of templates:"), [Ability to efficiently search through thousands of slide templates]),
    (strong("suggests content tweaks to better fit designs:"), [Suggestions for how content might be adjusted to better match available designs]),
    (strong("surfaces great designs users might miss manually:"), [Surfacing of slide designs users might not have found manually]),
    (strong("ensures all content gets proper visual treatment:"), [Ensuring all content receives appropriate visual treatment])
  )
)

#manifesto_section(
  "Object Model Summary",
  [The Slide Lookup module is built around a recommendation-based architecture:
  #list(
    [#strong("LookupEngine"): The core system that performs content-to-slide matching],
    [#strong("ContentAnalyzer"): System for understanding content structure and requirements],
    [#strong("SlideIndex"): Optimized database of slide templates with searchable attributes],
    [#strong("MatchingRules"): Definitions of what makes a good content-to-slide match],
    [#strong("RecommendationSet"): Collection of slide options for a given content block]
  )
  Supporting objects include MatchScore for evaluating recommendation quality and ContentAdaptation for suggesting content modifications.]
)

#manifesto_section(
  "Key Processes",
  [The Slide Lookup module facilitates several critical processes:

  #h3("Content Analysis")
  #list(
    [Analyzing content structure and purpose],
    [Identifying key content characteristics],
    [Determining visual requirements],
    [Recognizing content patterns]
  )

  #h3("Slide Indexing")
  #list(
    [Creating searchable representations of slides],
    [Maintaining optimized indices for fast retrieval],
    [Updating indices as the slide library evolves],
    [Categorizing slides by multiple attributes]
  )

  #h3("Match Generation")
  #list(
    [Searching for slides that match content needs],
    [Ranking potential matches by relevance],
    [Generating multiple options for each content block],
    [Ensuring diversity in recommendations]
  )
  ]
)

#manifesto_section(
  "Efficacy Metrics",
  [The Slide Lookup module's success will be measured by:

  #h3("Match Quality")
  #list(
    [Percentage of content blocks that receive highly relevant slide matches],
    [User acceptance rate of recommended slides],
    [Comparison to manually selected slides for the same content]
  )

  #h3("Search Efficiency")
  #list(
    [Speed of recommendation generation],
    [Ability to handle library scale (5,000 to 10,000+ slides)],
    [Resource utilization during search operations]
  )

  #h3("Discovery Effectiveness")
  #list(
    [Frequency of surfacing valuable slides users wouldn't have found manually],
    [Diversity of recommendations provided],
    [Novelty and relevance balance in recommendations]
  )
  ]
)

#two_column_list_table(
  "Competitive Differentiation",
  (
    (strong("uses AI matching, unlike manual template Browse:"), [Unlike manual template Browse in traditional tools]),
    (strong("effectively uses thousands of designs:"), [Ability to effectively utilize thousands of slide designs]),
    (strong("selects based on content, unlike theme-based tools:"), [Fundamentally different from theme-based template selection]),
    (strong("provides alternatives, not just one solution:"), [Providing alternatives rather than single solutions]),
    (strong("it's unique:"), [No competitor offers a comparable AI-powered slide recommendation system with the same scale capabilities and content understanding. This module represents a key technological moat that would be difficult for competitors to replicate.])
  )
)

#manifesto_bullet_list(
  "Relationship to Other Modules",
   "- **Skeleton Editor**: Receives content blocks that need slide recommendations\n- **Slide Component Library**: Searches through this library to find appropriate slides\n- **Deck Editor**: Provides recommendations that the Deck Editor presents to users\n- **Context Window**: Receives content context to improve recommendations\n- **Butter DS**: Understands component capabilities to ensure feasible recommendations"
)

// --- Template Ingestion Module Manifesto ---
#pagebreak()
#h1("Template Ingestion Module")

#manifesto_section(
  "Executive Summary",
  [The Template Ingestion module is a specialized system within Narrative AI's presentation platform that enables rapid scaling of the Slide Component Library by automatically processing and integrating external templates from sources like Figma and PowerPoint. This module represents a critical scaling mechanism that allows Narrative AI to quickly expand from hundreds to thousands of slide designs, creating a significant competitive advantage in the market.]
)

#manifesto_section(
  "Module Purpose",
  [The Template Ingestion module serves as the growth engine for Narrative AI's slide library, automatically analyzing and converting external design templates into the platform's component-based architecture. It enables the platform to leverage the vast ecosystem of existing templates while transforming them to work within Narrative AI's unique approach. This module maintains a clear separation from both content creation and slide design, focusing exclusively on the ingestion, analysis, and conversion process that brings external designs into the system. Its effectiveness is measured by how quickly and accurately it can expand the slide library while maintaining design quality and consistency.]
)

#two_column_list_table(
  "Core Value Proposition",
  (
    (strong("lets us grow the slide library from hundreds to thousands quickly:"), [Ability to grow from hundreds to thousands of slide designs quickly]),
    (strong("gives access to a wide range of professional designs:"), [Access to a wide range of professional design approaches]),
    (strong("automates what would be a manual design process:"), [Automation of what would otherwise be a manual design process]),
    (strong("systematically validates and approves ingested templates:"), [Systematic validation and approval of ingested templates]),
    (strong("creates a barrier to entry for competitors through scale:"), [Barrier to entry for competitors through scale])
  )
)

#manifesto_section(
  "Object Model Summary",
  [The Template Ingestion module is built around a conversion-based architecture:
  #list(
    [#strong("IngestionPipeline"): The core system that processes external templates],
    [#strong("TemplateSource"): Connection to external template repositories (Figma, PowerPoint, etc.)],
    [#strong("DesignAnalyzer"): System for understanding external design patterns],
    [#strong("ComponentMapper"): Tool for mapping external designs to Butter DS components],
    [#strong("ApprovalWorkflow"): Process for reviewing and approving converted templates]
  )
  Supporting objects include ConversionRules for guiding the transformation process and QualityMetrics for evaluating ingested templates.]
)

#manifesto_section(
  "Key Processes",
  [The Template Ingestion module facilitates several critical processes:

  #h3("Template Discovery")
  #list(
    [Connecting to external template sources],
    [Identifying high-quality template candidates],
    [Categorizing and prioritizing templates],
    [Managing template source relationships]
  )

  #h3("Design Analysis")
  #list(
    [Analyzing external template structure],
    [Identifying design patterns and components],
    [Extracting design specifications],
    [Determining component relationships]
  )

  #h3("Component Conversion")
  #list(
    [Mapping external designs to Butter DS components],
    [Recreating designs using the component library],
    [Preserving design intent during conversion],
    [Optimizing converted designs for the platform]
  )

  #h3("Quality Assurance")
  #list(
    [Validating converted templates],
    [Comparing original and converted designs],
    [Identifying conversion issues],
    [Managing approval workflows]
  )
  ]
)

#manifesto_section(
  "Efficacy Metrics",
  [The Template Ingestion module's success will be measured by:

  #h3("Scaling Velocity")
  #list(
    [Number of templates successfully ingested per time period],
    [Growth rate of the Slide Component Library],
    [Reduction in manual template creation needs]
  )

  #h3("Conversion Quality")
  #list(
    [Fidelity of converted templates compared to originals],
    [Percentage of templates requiring minimal manual adjustment],
    [Component efficiency of converted designs]
  )

  #h3("Library Diversity")
  #list(
    [Range of design styles represented],
    [Coverage of presentation needs],
    [Uniqueness of ingested templates]
  )
  ]
)

#two_column_list_table(
  "Competitive Differentiation",
  (
    (strong("converts designs automatically, unlike manual creation:"), [Unlike manual template creation in traditional tools]),
    (strong("can rapidly build a massive slide library:"), [Ability to rapidly build a massive slide library]),
    (strong("turns static designs into flexible components:"), [Converting static designs to flexible components]),
    (strong("maintains design quality through automation:"), [Maintaining design quality through automated processes]),
    (strong("it's unique:"), [No competitor offers a comparable automated template ingestion system with the same scale capabilities and component-based approach. This module represents a key technological moat that enables Narrative AI to outpace competitors in building a comprehensive slide library.])
  )
)

#manifesto_bullet_list(
  "Relationship to Other Modules",
   "- **Butter DS**: Uses Butter DS components as the target for template conversion\n- **Slide Component Library**: Adds converted templates to this library\n- **Slide Lookup**: Indirectly improves by providing more slide options\n- **Onboarding Brand Setup**: Leverages brand understanding to improve template conversion"
)