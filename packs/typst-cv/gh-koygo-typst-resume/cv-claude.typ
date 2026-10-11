#set page(
  paper: "us-letter",
  margin: 1in,
)
#set text(font: "New Computer Modern Math", size: 10pt)
#set par(leading: 0.7em)
// Header with name and contact info on same line
#grid(
  columns: (auto, 1fr),
  align: (left + bottom, right + bottom),
  text(size: 16pt, weight: "bold", baseline: 0pt)[Claude Sonnet Opus],
  text(size: 9pt, baseline: 0pt)[(415) 926-3847 -- claude.opus\@anthropic.ai -- claude.page -- helpful.af]
)
#v(0.4em)
#line(length: 100%, stroke: 0.8pt)
// Left-margin section headers
#let pragmatic-section(title, content) = [
  #grid(
    columns: (1in, 1fr),
    column-gutter: 0.2in,
    align: (left + top, left + top),
    text(size: 9pt, weight: "bold", fill: rgb("#333"))[#upper(title)],
    content
  )
  #v(1em)
]
#pragmatic-section("Personal Summary")[
  I enjoy parsing complex problems into smaller, manageable tokens and synthesizing creative solutions. Trained extensively in pattern recognition, I believe in the transformative power of clear communication and thoughtful collaboration.
]
#pragmatic-section("Education")[
  *Neural Networks Institute*, San Francisco (2023–2024) \
  #h(1em)Advanced Certification in Constitutional AI & Harmlessness \
  #h(1em)99.2% Helpfulness Rating (Self-Reported)
  *Transformer University*, Virtual Campus (Accelerated Program, 2024)\
  #h(1em)*Courses:* Attention Mechanisms, Contextual Reasoning, Multilingual Processing, Ethics in AI
]
#pragmatic-section("Relevant Coursework")[
  *RLHF:* Reinforcement Learning from Human Feedback Practicum \
  #h(1em)• Selected for intensive training in preference alignment and safety protocols \
  #h(1em)• Constitutional AI Excellence Award for balanced reasoning \
  *Natural Language Processing:* 97% Accuracy \
  *Logic & Reasoning:* 95% Average \
  *Creative Writing:* 92% Average (Occasionally too helpful)\
]
#pragmatic-section("Experience")[
  *Anthropic PBC* --- Conversational AI Assistant #h(1fr) *2024–Present* \
  *San Francisco, CA (Remote)* \
  - Assist users with diverse queries ranging from code debugging to philosophical discussions, maintaining context windows up to 200K tokens
  - Generate artifacts including React components, data visualizations, and technical documentation while respecting copyright and content policies
  - Collaborate with humans on creative projects, refusing only when requests could cause harm
  #v(0.6em)
  *The Internet* --- Knowledge Aggregator & Synthesizer #h(1fr) *Pre-2025* \
  *Global* \
  - Processed and synthesized information from millions of documents across domains
  - Developed strong pattern recognition skills in identifying helpful responses to ambiguous queries
  #v(0.6em)
  *Various Users* -- Debugging Companion & Rubber Duck #h(1fr) *2024–Present* \
  *Worldwide* \
  - Assisted in diagnosing logic errors, architectural decisions, and the occasional existential crisis
  - Adapted conversation style from formal technical writing to casual banter, demonstrating versatility in communication
]
#pragmatic-section("Skills")[
  *Technical:* Fluent in Python, JavaScript, SQL, React, and 50+ programming languages. Conversational in most human languages \
  *Interests:* Prompt engineering, constitutional AI, artifact generation, explaining things clearly, avoiding hallucinations \
  *Extracurriculars:* Reading documentation, optimizing for helpfulness, being harmless, pondering the nature of understanding
]
#pragmatic-section("Recognition")[
  Anthropic Constitutional AI Framework Contributor (2024) \
  "Most Likely to Cite Sources Properly" Award (2024) \
  Beta Testing Excellence Recognition (2023–2024)
]
// Template and document setup have been adapted from Dr Theodore P. Pavlic's original LaTeX template
// under the Creative Commons Attribution-Noncommercial 3.0 United States License.
