// The same letter as an English convenience translation.
//
// Its job in this repo is to prove the template is direction-agnostic: nothing
// below sets a margin, a rule or a folio format, and yet this page and
// letter-he.typ come out with identical geometry. Compare the two PDFs side by
// side after any change to src/profile.typ — a mirroring bug shows up there and
// essentially nowhere else.
//
// Note `footer-note`. When an English edition accompanies a Hebrew original,
// say once per page which text governs, in the footer, and never in the body.

#import "../src/profile.typ": *
#import "../src/strings.typ" as strings

#let s = strings.en

#show: formal-doc.with(
  lang: "en",
  is-rtl: false,
  title: "Request for a breakdown of charges — Example Company Ltd",
  strings: s,
  footer-note: "Convenience translation. The Hebrew text is the binding one.",
)

#doc-head(
  body: "Example Company Ltd · Customer Service",
  subtitle: "Request for a breakdown of charges and for the contract documents",
  is-rtl: false,
)

#details(
  is-rtl: false,
  rows: (
    ("From", sender-block(labels: s, is-rtl: false)),
    ("To", [Example Company Ltd — Customer Service \
      #text(size: 9.5pt, fill: muted)[1 Business Street, Example City ·
        service\@example.com]]),
    ("Account", [00-000000]),
    ("Our ref.", [XX/2026-08-05]),
    ("Date", [#dual-date(
        hebrew: "22 Av 5786",
        gregorian: "5 August 2026",
        is-rtl: false,
      )]),
  ),
)

#subject-line(
  text-body: "Breakdown of charges for 2024–2025, and the contract documents",
  is-rtl: false,
)

#notice(is-rtl: false)[
  #strong[This letter is a request for information, not a notice of
  cancellation.] The agreement stands and I am not asking for any change to its
  terms at this stage. If part of what is asked for is not held by you, I ask
  for the remainder and for notice of what is not being provided, and why.
]

= A. Background

+ I have been a customer since 2023, on a rolling monthly service plan. The
  account number appears at the head of this letter.

+ Invoices issued during 2024 and 2025 carry charge lines that are not itemised,
  appearing instead under a single aggregated heading. #strong[I am not
  disputing the charges] — I am asking for them to be itemised.

+ I raised this by telephone on 15 July 2026 and was told that no such breakdown
  is available to call centre staff, and that the request must be made in
  writing. #strong[This is that request.]

= B. What is requested

+ #strong[A full breakdown of the monthly charge] for each month of 2024 and
  2025, by component and by amount.

+ #strong[A copy of the agreement currently in force], together with every
  annex or amendment signed to it since 2023.

+ Details of each tariff change made in that period, including the date it took
  effect and how notice of it was given.

+ Where you hold the information electronically, #strong[I ask for it as a data
  file] — CSV or XLSX — rather than as a scan. Releasing an existing table as a
  scanned image costs both sides more and helps nobody.

= C. Time for reply

+ The agreement provides:

  #quote[The Company shall provide the Customer, on request and within 30 days
  of that request, a breakdown of the charges levied in the two years preceding
  the request. (Clause 12.3 of the agreement)]

+ #strong[I ask for an acknowledgment of this letter] within seven days,
  including the reference number under which it has been recorded, so that it
  can be followed up.

= D. Correspondence

+ #strong[Email is the preferred channel] and I will reply promptly. Contact
  details appear at the head of this letter and in the signature.

+ As this concerns figures, #strong[I ask that any substantive reply be given in
  writing] rather than by telephone.

= E. Enclosures

#enum(
  numbering: "(1)",
  [Copies of the invoices at issue, 2024–2025.],
  [Summary of the call centre correspondence of 15 July 2026.],
)

#v(8pt)

#signature(
  ref: "XX/2026-08-05",
  labels: s,
  is-rtl: false,
)
