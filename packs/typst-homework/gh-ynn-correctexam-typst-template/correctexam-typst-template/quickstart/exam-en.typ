// ============================================================================
// CorrectExam Quickstart - English
// ============================================================================
// Minimal example to get started with CorrectExam.
// For more features, see the full examples in the examples/ folder.

// Local import for repository CI and local development
#import "../lib/lib.typ": *

// Configure template - lang and mode are the most important settings
#show: correctexam.with(lang: "en", mode: "withid")

// Title page
#exam-title(
  [Exam Title],
  subtitle: (
    [2024-2025],
    [Duration: 2 hours],
    [Subject has #total-pages() pages],
  ),
)

// Exercise worth 5 points
#exercise(5)

// Free-text question
#question[First question.]
#answer-box(lines: 4)

// Multiple-choice question
#question[Which color?]
#qcm([blue], [red], [green])
