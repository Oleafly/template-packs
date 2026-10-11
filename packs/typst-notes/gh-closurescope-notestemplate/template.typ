// template.typ
#import "@preview/ilm:1.4.2": ilm
#import "@preview/frame-it:2.0.0": frame-style, frames, styles
#import "@preview/tablem:0.3.0": tablem, three-line-table

#let font-en = "Libertinus Serif"

#let font-song = "Noto Serif SC"
#let font-hei = "Noto Sans SC"
#let font-kai = "FandolKai"

#let font-code = "JetBrains Mono"

#let (
  // Math & Logic (Blues/Indigos)
  theorem,
  lemma,
  proposition,
  corollary,
  // Foundations (Greens/Teals)
  definition,
  axiom,
  assumption,
  // Explanation & Meta (Purples/Pinks)
  intuition,
  strategy,
  goal,

  // Notes & Extras (Cyans/Grays)
  note,
  remark,
  observation,
  // Examples (Orange)
  example,
  // Alerts (Red/Yellow)
  warning,
  tip,
  important,
  // Practice (Deep Blue/Green)
  question,
  answer,
  // Structural
  proof,
  summary,
) = frames(
  // -- Mathematical Statements --
  theorem: ("Theorem", rgb("#2563eb")), // Vibrant Blue
  lemma: ("Lemma", rgb("#3b82f6")), // Lighter Blue
  proposition: ("Proposition", rgb("#4f46e5")), // Indigo
  corollary: ("Corollary", rgb("#6366f1")), // Soft Indigo

  // -- Foundations --
  definition: ("Definition", rgb("#059669")), // Emerald Green
  axiom: ("Axiom", rgb("#0d9488")), // Teal
  assumption: ("Assumption", rgb("#14b8a6")), // Light Teal

  // -- Mental Models (Requested) --
  intuition: ("Intuition", rgb("#db2777")), // Pink (Vigorous)
  strategy: ("Strategy", rgb("#9333ea")), // Purple
  goal: ("Goal", rgb("#7c3aed")), // Violet

  // -- Standard Notes --
  note: ("Note", rgb("#0ea5e9")), // Sky Blue
  remark: ("Remark", rgb("#0284c7")), // Steel Blue
  observation: ("Observation", rgb("#0891b2")), // Cyan

  // -- Illustration --
  example: ("Example", rgb("#f97316")), // Orange

  // -- Alerts --
  warning: ("Warning", rgb("#dc2626")), // Red
  important: ("Important", rgb("#ea580c")), // Burnt Orange
  tip: ("Tip", rgb("#ca8a04")), // Dark Yellow/Gold

  // -- Q&A --
  question: ("Question", rgb("#1e40af")), // Dark Blue
  answer: ("Answer", rgb("#166534")), // Dark Green

  // -- Structure --
  summary: ("Summary", rgb("#475569")), // Slate
  proof: ("Proof", rgb("#525252")), // Neutral Gray
)
