// components/theme.typ
// Color palettes and state management for light and dark modes
// Modeled directly on Charlie's cmt.sty with carefully balanced, muted tones

#let current-theme = state("template-theme", "light")

#let light-palette = (
  mode: "light",
  page-bg: rgb("#ffffff"),
  text: rgb("#1f2937"),
  text-muted: rgb("#5c6b73"),
  border: rgb("#dce1e6"),
  accent: rgb("#003c6e"),         // Charlie's \doc: RGB(0, 60, 110)
  accent-muted: rgb("#668aa8"),   // Charlie's \doc!60: RGB(102, 138, 168) - used in TOC

  // Definition (Charlie's attached tab badge box: \mydefinitbg & \mydefinitfr)
  definition: (
    border: rgb("#8a1c1c"),       // Deep burgundy red
    bg: rgb("#fff7f7"),           // Soft muted off-white blush
    header-bg: rgb("#8a1c1c"),    // Dark burgundy tab badge
    header-fg: rgb("#ffffff"),
    text: rgb("#1f2937"),
  ),

  // Note (Charlie's signature screws/rivets card: gray!20!white & gray!80!black)
  note: (
    border: rgb("#6c757d"),       // Muted slate gray
    bg: rgb("#f1f3f5"),           // Soft light gray
    badge-bg: rgb("#ffffff"),     // Clean white badge
    badge-border: rgb("#6c757d"),
    badge-fg: rgb("#212529"),
    dot: rgb("#6c757d"),          // Muted slate rivet dots
    text: rgb("#212529"),
  ),

  // Example (Charlie's teal outline box: \myexamplefr & \myexampleti)
  example: (
    border: rgb("#88d6d1"),       // Muted dusty teal border
    bg: rgb("#f4faf9"),           // Subtle pale teal tint
    title: rgb("#2a7f7f"),        // Muted deep teal title
    text: rgb("#1f2937"),
  ),

  // Left-bar theorem blocks (exact colors from cmt.sty)
  theorem: (
    bar: rgb("#00007b"),          // \mytheoremfr: deep navy blue
    bg: rgb("#f4f4fa"),           // \mytheorembg: soft lavender tint
    title: rgb("#00007b"),
    text: rgb("#1f2937"),
  ),
  proposition: (
    bar: rgb("#191971"),          // \mypropfr: midnight blue
    bg: rgb("#f3f9fb"),           // \mypropbg: soft ice blue
    title: rgb("#191971"),
    text: rgb("#1f2937"),
  ),
  lemma: (
    bar: rgb("#983b0f"),          // \mylemmafr: muted terracotta / dark rust
    bg: rgb("#fff9f7"),           // \mylemmabg: soft warm tint
    title: rgb("#983b0f"),
    text: rgb("#1f2937"),
  ),
  corollary: (
    bar: rgb("#8b3a99"),          // \myp!85!black: dull plum
    bg: rgb("#fbf4fc"),           // \myp!10
    title: rgb("#8b3a99"),
    text: rgb("#1f2937"),
  ),
  claim: (
    bar: rgb("#388c46"),          // \myg: muted forest green
    bg: rgb("#f2f8f3"),           // \myg!10
    title: rgb("#2c7037"),
    text: rgb("#1f2937"),
  ),
  exercise: (
    bar: rgb("#3d8b88"),          // Muted teal
    bg: rgb("#f2fbf8"),
    title: rgb("#2b6d6a"),
    text: rgb("#1f2937"),
  ),
  remark: (
    bar: rgb("#475569"),          // Slate charcoal
    bg: rgb("#f8fafc"),
    title: rgb("#334155"),
    text: rgb("#1f2937"),
  ),

  // Ribbon boxes (Charlie's question: myb!80!black, solution: myg!80!black)
  question: (
    ribbon: rgb("#275887"),       // Muted steel navy (not neon)
    border: rgb("#275887"),
    bg: rgb("#ffffff"),
    text: rgb("#1f2937"),
  ),
  solution: (
    ribbon: rgb("#2d6e37"),       // Muted forest green (not neon)
    border: rgb("#2d6e37"),
    bg: rgb("#ffffff"),
    text: rgb("#1f2937"),
  ),

  // Wrong concept box (\wconc: myr)
  wrong-concept: (
    border: rgb("#a33130"),
    bg: rgb("#fdf5f5"),
    title: rgb("#a33130"),
    text: rgb("#1f2937"),
  ),

  // Blockquote & Quotes
  blockquote: (
    bar: rgb("#5c768d"),
    bg: rgb("#f8fafc"),
    title: rgb("#2c3e50"),
    quote-mark: rgb("#94a3b8"),
    text: rgb("#334155"),
    author: rgb("#5c768d"),
  ),

  // Code blocks (\codebg, \codeframe, etc.)
  code: (
    bg: rgb("#f7f8fa"),
    gutter: rgb("#edeff3"),
    border: rgb("#d8dee8"),
    bar: rgb("#4b6cb7"),
    title: rgb("#24292f"),
    lang: rgb("#4b6cb7"),
    text: rgb("#24292f"),
    line-num: rgb("#8c959f"),
  ),

  // Callouts
  callouts: (
    info: (bar: rgb("#2b6cb0"), bg: rgb("#f0f6fc"), title: rgb("#2b6cb0")),
    tip: (bar: rgb("#2d6e37"), bg: rgb("#f2f8f3"), title: rgb("#2d6e37")),
    warning: (bar: rgb("#b46914"), bg: rgb("#fef8ed"), title: rgb("#b46914")),
    caution: (bar: rgb("#a33130"), bg: rgb("#fdf4f4"), title: rgb("#a33130")),
    success: (bar: rgb("#2d6e37"), bg: rgb("#f2f8f3"), title: rgb("#2d6e37")),
  ),
)

#let dark-palette = (
  mode: "dark",
  page-bg: rgb("#16181d"),
  text: rgb("#d1d5db"),
  text-muted: rgb("#8b949e"),
  border: rgb("#2e3440"),
  accent: rgb("#7da2c6"),
  accent-muted: rgb("#5a7a99"),

  // Definition
  definition: (
    border: rgb("#782525"),
    bg: rgb("#201516"),
    header-bg: rgb("#782525"),
    header-fg: rgb("#ffffff"),
    text: rgb("#e2e8f0"),
  ),

  // Note
  note: (
    border: rgb("#4f5666"),
    bg: rgb("#1f232b"),
    badge-bg: rgb("#282d37"),
    badge-border: rgb("#4f5666"),
    badge-fg: rgb("#e2e8f0"),
    dot: rgb("#8b949e"),
    text: rgb("#d1d5db"),
  ),

  // Example
  example: (
    border: rgb("#3e6e6a"),
    bg: rgb("#141f1e"),
    title: rgb("#68b0aa"),
    text: rgb("#d1d5db"),
  ),

  // Left-bar theorem blocks
  theorem: (
    bar: rgb("#4a68a8"),
    bg: rgb("#171a24"),
    title: rgb("#7a98d8"),
    text: rgb("#d1d5db"),
  ),
  proposition: (
    bar: rgb("#3f558a"),
    bg: rgb("#161922"),
    title: rgb("#6c85bf"),
    text: rgb("#d1d5db"),
  ),
  lemma: (
    bar: rgb("#944d2d"),
    bg: rgb("#221a16"),
    title: rgb("#c27553"),
    text: rgb("#d1d5db"),
  ),
  corollary: (
    bar: rgb("#7c438a"),
    bg: rgb("#201724"),
    title: rgb("#ad67bf"),
    text: rgb("#d1d5db"),
  ),
  claim: (
    bar: rgb("#3b7447"),
    bg: rgb("#162018"),
    title: rgb("#5fa16e"),
    text: rgb("#d1d5db"),
  ),
  exercise: (
    bar: rgb("#397572"),
    bg: rgb("#141e1d"),
    title: rgb("#5ea39f"),
    text: rgb("#d1d5db"),
  ),
  remark: (
    bar: rgb("#4a5260"),
    bg: rgb("#1a1d24"),
    title: rgb("#8892a0"),
    text: rgb("#d1d5db"),
  ),

  // Ribbon boxes
  question: (
    ribbon: rgb("#27486e"),
    border: rgb("#27486e"),
    bg: rgb("#181e26"),
    text: rgb("#d1d5db"),
  ),
  solution: (
    ribbon: rgb("#255433"),
    border: rgb("#255433"),
    bg: rgb("#17221b"),
    text: rgb("#d1d5db"),
  ),

  // Wrong concept box
  wrong-concept: (
    border: rgb("#782525"),
    bg: rgb("#231617"),
    title: rgb("#d16464"),
    text: rgb("#d1d5db"),
  ),

  // Blockquote & Quotes
  blockquote: (
    bar: rgb("#475569"),
    bg: rgb("#1e232b"),
    title: rgb("#cbd5e1"),
    quote-mark: rgb("#475569"),
    text: rgb("#cbd5e1"),
    author: rgb("#8b949e"),
  ),

  // Code blocks
  code: (
    bg: rgb("#161a22"),
    gutter: rgb("#1c212a"),
    border: rgb("#30363d"),
    bar: rgb("#4f6fa8"),
    title: rgb("#c9d1d9"),
    lang: rgb("#79b8ff"),
    text: rgb("#c9d1d9"),
    line-num: rgb("#6e7681"),
  ),

  // Callouts
  callouts: (
    info: (bar: rgb("#3f6da8"), bg: rgb("#161d28"), title: rgb("#70a1e0")),
    tip: (bar: rgb("#356e42"), bg: rgb("#152219"), title: rgb("#5fb872")),
    warning: (bar: rgb("#8a5a1f"), bg: rgb("#241c12"), title: rgb("#dca052")),
    caution: (bar: rgb("#8a2e2d"), bg: rgb("#241414"), title: rgb("#e06866")),
    success: (bar: rgb("#356e42"), bg: rgb("#152219"), title: rgb("#5fb872")),
  ),
)

/// Helper to resolve the active palette based on global or local theme
#let resolve-palette(theme-override: none) = {
  let mode = if theme-override != none {
    theme-override
  } else {
    current-theme.get()
  }
  if mode == "dark" {
    dark-palette
  } else {
    light-palette
  }
}
