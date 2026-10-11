// ─── AI tools register ─────────────────────────────────────────────────────────
// Usage in chapters/ai-tools.typ:
//
//   #ai-entry(
//     tool:     "Claude Sonnet 4.6 (Anthropic)",
//     usage:    [What the tool was used for …],
//     prompt:   [Your prompt …],
//     response: [Model response …],
//   )
//
//   #ai-entry(...)   ← add further entries below

#let ai-entry(tool: "", usage: [], prompt: [], response: []) = {
  block(above: 1.5em, below: 0.3em)[*#tool*]
  list(
    tight: true,
    [*Nutzung:* #usage],
    [*Prompt:* #prompt],
    [*Ergebnis:* #response],
  )
}
