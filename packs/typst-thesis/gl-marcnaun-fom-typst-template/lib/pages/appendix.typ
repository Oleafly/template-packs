// ─── Appendix ─────────────────────────────────────────────────────────────────
// Numbering: uppercase Roman numerals (Anhang I, Anhang II, …)

#let appendix(body) = {
  pagebreak(weak: true)
  heading(level: 1, numbering: none, outlined: true)[Anhang]

  set heading(
    numbering: (..n) => {
      let nums = n.pos()
      if nums.len() == 2 {
        "Anhang " + "I II III IV V VI VII VIII IX X".split(" ").at(nums.last() - 1)
      }
    },
    supplement: "Anhang",
  )

  body
}
