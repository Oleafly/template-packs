// Glossary definitions — imported by main.typ, abbreviations.typ, and concepts.typ

// ─── Abbreviations / Acronyms ────────────────────────────────────────────────
// Add your own entries here. Each entry needs a unique `key` (lowercase, no spaces),
// a `short` form (the abbreviation), and a `long` form (the full expanded term).
// Use @key in your text to reference an entry — first use prints the full form,
// subsequent uses print only the abbreviation.
#let abbreviation-list = (
  (key: "ai",    short: "AI",    long: "Artificial Intelligence"),
  (key: "llm",   short: "LLM",   long: "Large Language Model",  plural: "LLMs", longplural: "Large Language Models"),
  (key: "ngo",   short: "NGO",   long: "Non-Governmental Organisation"),
  (key: "un",    short: "UN",    long: "United Nations"),
)

// ─── Key Concepts / Definitions ──────────────────────────────────────────────
// Add entries here for terms you want defined in the Key Concepts section.
// Each entry needs a `key`, a `short` display name, and a `description` (content block).
// Unlike abbreviations, concepts are always shown in full in the Key Concepts list
// regardless of whether they are referenced in the text (show-all: true).
#let concept-list = (
  (
    key: "humanitarian-principles",
    short: "Humanitarian Principles",
    description: [The four core principles guiding humanitarian action: humanity, neutrality, impartiality, and independence. Established by the International Committee of the Red Cross and endorsed by the United Nations.],
  ),
  (
    key: "do-no-harm",
    short: "Do No Harm",
    description: [A foundational principle requiring that interventions — including technological ones — must not cause unintended harm to affected populations. Derived from medical ethics and formalised in humanitarian practice.],
  ),
  (
    key: "accountability",
    short: "Accountability to Affected Populations",
    description: [The commitment of humanitarian actors to be answerable to the people they serve, ensuring that communities have a voice in decisions affecting them and can provide feedback or lodge complaints.],
  ),
)

// ─── Combined list (used for register-glossary in main.typ) ──────────────────
#let entry-list = abbreviation-list + concept-list
