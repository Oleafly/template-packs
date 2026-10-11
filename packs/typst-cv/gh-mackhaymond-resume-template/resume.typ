// =====================================================================
// Resume — Typst template
// Formatting follows IB/finance industry conventions
// (Mergers & Inquisitions / WSO / Wharton career services standards):
//   - Times New Roman, 10pt body
//   - 0.5" margins, single page (US Letter)
//   - ALL-CAPS bold section headers with full-width rule
//   - Bold company/school left, bold location right (same line)
//   - Italic title/degree left, italic dates right (same line)
//   - En-dash for date ranges, no first-person pronouns in bullets
//
// =====================================================================
// DYNAMIC PAGE-FILL — TIERED DENSITY SYSTEM
// =====================================================================
//
// A single `density` value d in [0, 1] controls every spacing parameter
// in the document. Parameters are grouped into tiers ranked by how
// IMPERCEPTIBLE the adjustment is to the reader:
//
//   TIER 1 (imperceptible) - body font size, line leading, list spacing
//   TIER 2 (subtle)        - entry block spacing & section header gaps
//   TIER 3 (noticeable)    - inter-section gaps
//   TIER 4 (very visible)  - page margins  [NEVER ENGAGED]
//
// Tier activation is staggered with overlap so the densest, most
// imperceptible adjustments happen FIRST. Only once Tier 1 is mostly
// engaged does Tier 2 start contributing, and so on. Tier 4 is never
// engaged automatically - margins are IB-sacred.
//
// At compile time a bisection search finds the largest d whose layout
// still fits the page, so the content always fills one page naturally —
// slack is absorbed across every line, bullet, entry, and section,
// never concentrated in any one place.
//
// References:
//   - Bringhurst, "Elements of Typographic Style"
//   - Knuth-Plass line-breaking algorithm (glue parameter)
//   - LaTeX resume templates: moderncv, awesome-cv, sb2nov-resume
//   - M&I / WSO IB resume convention guides
//
// Compile:  typst compile resume.typ   (or `just build`)
// =====================================================================

// ---------- CONFIG — identity & contact ------------------------------
// TEMPLATE: fill these in during the first-load workflow (see AGENTS.md).
#let author-name      = "Firstname Lastname"
#let contact-location = "City, ST"
#let contact-phone    = "(555) 555-5555"
#let contact-email    = "you@university.edu"
#let contact-linkedin = "linkedin.com/in/yourhandle"   // set to none to omit
#let contact-github   = "github.com/yourhandle"        // set to none to omit

#set document(
  title: author-name + " — Resume",
  author: author-name,
)

// ---------- DEBUG INSTRUMENTATION (off by default) --------------------
// When true, every bullet emits a <bullet-debug> metadata element with
// last-line fill measurements. Extract via:
//   typst query resume.typ "<bullet-debug>" --field value
// Used by the bullet-polish workflow (see AGENTS.md "Bullet polish").
// MUST be `false` in any committed build — the metadata is invisible in
// the rendered PDF but pollutes the document's metadata stream.
#let debug-linefill = false

// ---------- TIER 4 (FIXED - IB-sacred values) -------------------------
// Margins are SACRED at 0.5". Body font size is Tier 1 (see below)
// to lean on physical glyph size over invisible leading.
#let page-margin = 0.5in
#let page-paper = "us-letter"
#let body-font = "Times New Roman"

#set page(
  paper: page-paper,
  margin: (top: page-margin, bottom: page-margin, left: page-margin, right: page-margin),
)

#set text(
  font: body-font,
  hyphenate: false,
)

// Standard justification + Knuth-Plass optimized line breaks.
// Internal lines of multi-line bullets extend to the right margin
// (no ragged interior). Optimized breaks distribute slack evenly,
// so even single-line bullets tend to land closer to the right edge.
// The LAST line of each bullet stays ragged — forcing it would create
// the ugly wide word-spacing typical of bad force-justified text.
#set par(justify: true, linebreaks: "optimized")

// ATS safety: force straight ASCII quotes. Some legacy ATS parsers
// (Taleo, iCIMS) garble curly/smart quotes during text extraction.
#set smartquote(enabled: false)

// ---------- DENSITY CONTROLLER ----------------------------------------

// Clamp x to [lo, hi]
#let clamp(x, lo, hi) = calc.min(calc.max(x, lo), hi)

// Smooth tier activation. Each tier ramps from 0 to 1 over its window;
// windows overlap slightly so transitions are smooth rather than steppy.
#let tier-factor(d, start, end) = clamp((d - start) / (end - start), 0, 1)

// Linear interpolation between a and b by factor t
#let lerp(a, b, t) = a + (b - a) * t

// ---------- BODY (parametric on density d) ----------------------------

#let body(d, emit-debug: false) = {

  // ---- Tier activation windows (in d-space) ----------
  // Tier 1 fully engages first. Tier 2 starts ~30% in. Tier 3 last.
  let t1 = tier-factor(d, 0.00, 0.40)   // imperceptible
  let t2 = tier-factor(d, 0.30, 0.85)   // subtle
  let t3 = tier-factor(d, 0.70, 1.00)   // noticeable

  // ---- TIER 1: body font size + line & list spacing (imperceptible) ----
  // Font size carries most of the load (physical glyph growth grows
  // every line proportionally - the most "natural" way to fill space).
  // Leading is dialed back so it does supporting work, not primary.
  let body-text-size   = lerp(10.0pt, 10.6pt, t1)   // ~6% glyph growth max
  let body-leading     = lerp(0.55em,  0.62em, t1)  // ~1.0x to ~1.07x (subtle)
  let bullet-leading   = lerp(0.50em,  0.55em, t1)
  let list-item-gap    = lerp(0.35em,  0.55em, t1)

  // ---- TIER 2: block & header spacing (subtle) ----
  let entry-above      = lerp(0.70em, 1.30em, t2)
  let entry-below      = lerp(0.30em, 0.55em, t2)
  let section-head-v   = lerp(6pt,    12pt,   t2)   // gap above section title
  let section-tail-v   = lerp(-4pt,    1pt,   t2)   // gap below rule (neg = compress)

  // ---- TIER 3: inter-section gaps (noticeable, last resort) ----
  let inter-section-v  = lerp(0pt,    16pt,   t3)
  let header-gap-v     = lerp(4pt,    10pt,   t3)   // header to first section

  // ---- Apply global typography (font size + paragraph leading) ----
  set text(size: body-text-size)
  set par(leading: body-leading, spacing: 0.5em)

  // ---- Helpers (closures over the interpolated values) ----

  let section(title) = {
    v(section-head-v, weak: false)
    text(size: 11pt, weight: "bold", upper(title))
    v(-3pt)
    line(length: 100%, stroke: 0.6pt)
    v(section-tail-v)
  }

  // Entry helpers use h(1fr) stretchy glue INSTEAD of grids. Visually
  // identical (left text + expandable gap + right text on one line),
  // but the underlying PDF text flow is a single linear text run per
  // visual row rather than two separate columns. This means ATS
  // extraction reads "Institution      Location" as one line of text
  // instead of interleaving columns - critical for Workday compatibility.

  let entry(institution, location, role, dates) = {
    block(above: entry-above, below: entry-below)[
      *#institution* #h(1fr) *#location* \
      #emph(role) #h(1fr) #emph(dates)
    ]
  }

  // Single-line entry for items with no role/degree (e.g., high school
  // with no notable program). School + location inline on left, dates
  // right-aligned italic. Single line of PDF text, ATS-clean.
  let entry-no-role(institution, location, dates) = {
    block(above: entry-above, below: entry-below)[
      *#institution*, #location #h(1fr) #emph(dates)
    ]
  }

  // Bare entry: no role, no dates. One line, bold institution left,
  // bold location right.
  let entry-bare(institution, location) = {
    block(above: entry-above, below: entry-below)[
      *#institution* #h(1fr) *#location*
    ]
  }

  // Project entry: single-line bold-left / bold-right header. Matches
  // the visual rhythm of every other entry's row 1 (bold institution +
  // bold location), avoiding the inconsistent italic-on-right that a
  // date in the right slot would create. Dates are intentionally
  // omitted from project entries — including them either creates an
  // orphaned second row or forces a date-bold-right deviation from
  // the resume-wide date-is-italic convention.
  let entry-project(title, url) = {
    block(above: entry-above, below: entry-below)[
      *#title* #h(1fr) *#url*
    ]
  }

  let bullets(..items) = {
    set list(indent: 0.05in, body-indent: 0.12in, marker: [•], spacing: list-item-gap)
    set par(leading: bullet-leading)
    for item in items.pos() {
      if emit-debug {
        // Approximate the bullet body width:
        //   page content width
        //     - list indent (0.05in)
        //     - body indent (0.12in)
        //     - marker glyph width (~4pt for "•" at body size)
        // Use 0.20in total subtractive padding as a conservative constant.
        // The < 0.9 threshold tolerates ~0.5pt slop without false positives.
        //
        // We use `layout(size => ...)` to capture the actual available
        // width at this point in the flow (post page margins). `measure`
        // on the bullet content gives its natural single-line width.
        layout(size => {
          let inner = size.width - 0.20in
          let natural = measure(item).width
          let lines = if natural <= 0pt {
            1
          } else {
            calc.max(1, calc.ceil(natural / inner))
          }
          // Width of the last line under perfect Knuth-Plass balancing
          // (what `linebreaks: "optimized"` actually produces in practice).
          let last-balanced = natural / lines
          // Width of the last line under worst-case no-balancing
          // (greedy left-to-right wrap).
          let last-loose = if lines == 1 {
            natural
          } else {
            natural - (lines - 1) * inner
          }
          [#metadata((
            natural_pt: natural / 1pt,
            inner_pt: inner / 1pt,
            lines: lines,
            fill_loose: last-loose / inner,
            fill_balanced: last-balanced / inner,
          )) <bullet-debug>]
        })
      }
      [- #item]
    }
  }

  // =====================================================================
  // CONTENT
  // =====================================================================
  // TEMPLATE: everything below is PLACEHOLDER content demonstrating each
  // helper. The first-load workflow (AGENTS.md) replaces it with the
  // user's real resume. Never ship a build that still contains
  // placeholder text.
  // =====================================================================

  // ---------- HEADER ----------
  align(center)[
    #text(size: 18pt, weight: "bold")[#author-name] \
    #v(3pt)
    #text(size: 10pt)[
      #contact-location | #contact-phone |
      #link("mailto:" + contact-email)[#contact-email]#if contact-linkedin != none [ |
        #link("https://www." + contact-linkedin)[#contact-linkedin]]#if contact-github != none [ |
        #link("https://" + contact-github)[#contact-github]]
    ]
  ]

  v(header-gap-v)

  // ---------- EDUCATION ----------
  section[Education]

  // TEMPLATE: replace with the user's university. List degrees exactly
  // as the registrar issues them (see AGENTS.md "Degree designation").
  entry(
    "University Name",
    "City, ST",
    "B.S. in Your Major",
    "Expected Jun 20XX",
  )
  bullets(
    [Academics: Cumulative GPA: X.XX/4.0 | Honors, relevant coursework, or test scores go on this line],
  )

  // TEMPLATE: optional high school entry (common for underclassmen;
  // drop it once university content can fill the page). `entry-bare`
  // omits dates — graduation timing is implied by the university entry.
  entry-bare(
    "High School Name",
    "City, ST",
  )
  bullets(
    [GPA: X.XX/4.0 | Awards: honor roll, AP Scholar, or other distinctions],
  )

  v(inter-section-v)

  // ---------- PROFESSIONAL EXPERIENCE ----------
  section[Professional Experience]

  // TEMPLATE: one `entry` per role, reverse-chronological. An accepted
  // future role may appear with no bullets (like this one).
  entry(
    "Company Name",
    "City, ST",
    "Incoming Summer Intern",
    "Jun 20XX–Aug 20XX",
  )

  entry(
    "Company Name",
    "City, ST",
    "Role Title",
    "Jun 20XX–Aug 20XX",
  )
  bullets(
    [Led a project or initiative — start with a past-tense action verb and quantify the scope or outcome],
    [Built, designed, or analyzed something concrete; name the tools and the business problem they addressed],
    [Delivered a measurable result — \$, %, counts, or rankings make the bullet credible and specific],
  )

  v(inter-section-v)

  // ---------- PROJECTS ----------
  // TEMPLATE: optional section. Delete it (and the v(inter-section-v)
  // above) if the user has no projects worth listing.
  section[Projects]

  entry-project(
    "Project Name — Short Descriptor",
    "project-url.example.com",
  )
  bullets(
    [Summarize what the project does and the problem it solves in one concrete sentence],
    [Name the stack and architecture decisions that demonstrate technical depth],
  )

  v(inter-section-v)

  // ---------- EXTRACURRICULAR ACTIVITIES ----------
  section[Extracurricular Activities]

  entry(
    "Club or Organization Name",
    "City, ST",
    "Role Title",
    "Sep 20XX–Present",
  )
  bullets(
    [Describe leadership, initiative, or competition results — present tense is fine for ongoing roles],
    [Quantify membership, rankings, funds managed, or events organized wherever possible],
  )

  v(inter-section-v)

  // ---------- SKILLS AND INTERESTS ----------
  section[Skills and Interests]

  bullets(
    [*_Skills:_* Excel, PowerPoint, Python, SQL, and other tools — ordered by relevance to the target industry],
    [*_Interests:_* Genuine, specific, conversation-starting interests (specificity beats breadth)],
  )
}

// =====================================================================
// LAYOUT - solve for the density d that fills the page
// =====================================================================
//
// 1. Measure body(0) -> H_0  (densest, IB-tightest)
// 2. Measure body(1) -> H_1  (maximum stretch across tiers 1-3)
// 3. Available content height = page-content-height - safety buffer
// 4. Bisection search for the largest d in [0, 1] whose layout fits
// 5. Render body(d)
// =====================================================================

// Bisection search instead of linear interpolation. H(d) is not linear
// (em-scaled leading times font growth = quadratic), and not even
// continuous (font growth can flip lines to wrap, creating step jumps).
// Bisection converges to the largest feasible d regardless of shape:
// guaranteed exact fit if any d in [0, 1] hits the target, or d=1 if
// even max stretch fits, or d=0 with a visible overflow warning if
// even the densest layout exceeds the page.
#layout(size => {
  let safety = 0.5pt   // bisection lands precisely; tight buffer suffices
  let target = size.height - safety

  let h0 = measure(block(width: size.width, body(0.0))).height
  let h1 = measure(block(width: size.width, body(1.0))).height

  let d = if h0 >= target {
    // Even the densest layout overflows. Render d=0 with a warning.
    0.0
  } else if h1 <= target {
    // Even max stretch fits — use d=1 for maximum page fill.
    1.0
  } else {
    // Bisection: largest d in [0, 1] such that body(d) fits in target.
    // 10 iterations → density resolution ~1/1024 (height precision <<1pt).
    let lo = 0.0
    let hi = 1.0
    let best = 0.0
    for _ in range(10) {
      let mid = (lo + hi) / 2
      let hm = measure(block(width: size.width, body(mid))).height
      if hm <= target {
        best = mid
        lo = mid
      } else {
        hi = mid
      }
    }
    best
  }

  // Overflow warning: only renders if even the densest layout (d=0)
  // exceeds the page. Visible red banner at top so it's impossible to
  // miss. The fix is content reduction, not algorithm tuning.
  if h0 >= target {
    block(
      fill: red.lighten(80%),
      stroke: red,
      inset: 6pt,
      width: 100%,
      text(fill: red, weight: "bold", size: 9pt)[
        ⚠ Content overflows one page (#h0 > #target).
        Cut bullets, condense sentences, or drop an entry to fit.
      ],
    )
  }

  // Pass `emit-debug` only on the FINAL render. The two measurement
  // passes above (h0, h1) and any bisection probes must NOT emit
  // metadata — otherwise `typst query` returns duplicates and the
  // bullet-index-to-source-line mapping breaks.
  body(d, emit-debug: debug-linefill)
})
