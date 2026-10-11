// ── Matter-state contract ─────────────────────────────────────────────────────
// A shared cross-module state keyed by the string "ucsd-matter" (default "main")
// signals which part of the document is active.  lib/floats.typ reads this same
// key (no import needed — Typst state is global and keyed by string) to gate
// chapter-counter steps and float-counter resets to main matter only, preventing
// spurious "CHAPTER N" rendering on appendix and bibliography headings.
// Valid values: "front" | "main" | "back"
// ─────────────────────────────────────────────────────────────────────────────

// Front matter: update the matter state so the state-driven footer in
// dissertation() (lib/template.typ) switches to roman numerals.  The footer
// itself lives in dissertation() because set rules inside function bodies do
// not propagate beyond the call; the show-wrapper is the correct home.
#let front-matter() = {
  state("ucsd-matter").update("front")
}

// Main matter: force the body onto a fresh page, switch the footer to arabic,
// and restart the page counter at 1.  pagebreak(weak: true) is a no-op when
// already at a page boundary (e.g. after a one-shot page() call), so it is
// safe to call regardless of context.
#let main-matter() = {
  pagebreak(weak: true)
  state("ucsd-matter").update("main")
  counter(page).update(1)
}

// Back matter: sets the matter state so floats-rules does NOT treat back-matter
// level-1 headings (appendices, bibliography) as chapters.  Body and back matter
// share one continuous Arabic page sequence, so this MUST NOT reset or alter the
// page counter.
#let back-matter() = {
  state("ucsd-matter").update("back")
}
