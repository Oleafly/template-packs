#import "@preview/one-liner:0.3.0": shrink-to-width

// helpers for auto-numbered finding IDs
#let _severity_digit(sev) = if sev == "Critical" { "0" } else if sev == "Major" { "1" } else if sev == "Minor" { "2" } else { "3" }
#let _pad2(n) = if n < 10 { "0" + str(n) } else { str(n) }

// severity colors
#let critical = rgb("#EB6F92")
#let major = rgb("#EA9A97")
#let minor = rgb("#F6C177")
#let info = rgb("#e0def4")

// status colors
#let resolved = rgb("#73D480")
#let acknowledged = rgb("#F1A03A")
#let identified = rgb("#ED706B")
#let unknown = rgb("#665555")

// other colors
#let table_header = rgb("#E5E5E5")

// table cells
#let cell = rect.with(
    inset: 10pt,
    fill: rgb("#F2F2F2"),
    width: 100%,
    height: 50pt,
    radius: 2pt
)

#let tx_link(url, content) = {
  link(url, underline(text(fill: rgb("#007bff"), content)))
}

#let repository = sys.inputs.at("repository", default: "GitHub remote")

#let create_table = (tuples) => {
  table(
    columns: 1,
    rows: tuples.len(),
    ..tuples.map(((file, hash)) =>
      [*Filename*: #text(font:"Ubuntu Mono", file)
       #linebreak()
       *Hash*: #text(font:"Ubuntu Mono", hash)
      ]
      ),
  )
}

// Backmatter configuration to change Appendix numbering to letters
#let backmatter(content) = {
	set heading(numbering: "A.1")
	counter(heading).update(0)
	state("backmatter").update(true)
	content
}

// The project function defines how your document looks.
// It takes your content and some metadata and formats it.
// Go ahead and customize it to your liking!
#let report(
  client: "",
  title: "",
  authors: (),
  date: datetime.today().display("[day] [month repr:long] [year]"),
  audited_files: (),
  repo: repository,
  is_draft: true,
  body,
) = {


  let watermark = if is_draft {
    [#image("img/draft.svg")]
  } else {
    []
  }

  set page(background: watermark)

  // Set the document's basic properties.
  let title = client + " - " + title
  set document(author: authors, title: title)
  set text(font: "Libertinus Serif", lang: "en")
  set heading(numbering: "1.1.a -")

  // Title page.
  // The page can contain a logo if you pass one with `logo: "logo.png"`.
  v(0.6fr)
  align(right, image("img/txpipe.png", width: 50%))
  v(4fr)
  align(center, text(3em, weight: 700, "Audit Report"))
  v(5.6fr)

  text(1.1em, date)
  v(1.2em, weak: true)
  text(2em, weight: 700, title)

  // Author information.
  if authors.len() > 0 {
    pad(
      top: 0.7em,
      right: 20%,
      grid(
        columns: (1fr,) * calc.min(3, authors.len()),
        gutter: 1em,
        ..authors.map(author => align(start, strong(author))),
      ),
    )
  }

  v(2.4fr)
  pagebreak()
  set page(numbering: "1", number-align: center, fill: none)

set par(justify: true)
  align(horizon)[
    Disclaimer. This report is a time-boxed security review of the artifacts, commits and file hashes identified herein, performed to the best of TxPipe's knowledge, skill and experience through manual expert code review combined with AI-assisted analysis, with all findings validated by qualified human auditors; it is a snapshot in time, covers only the issues actually identified within the stated scope and assessment period, does not claim to detect every vulnerability, and does not extend to any change made to the code afterwards. This report does not constitute an authorization, certification, endorsement or approval by TxPipe for the reviewed system to be deployed on mainnet, released publicly, or used to handle real assets or user funds, nor does it constitute legal, regulatory, financial or investment advice: that decision, and the acceptance of any residual risk, rests solely with the client, which TxPipe recommends supports with additional independent audits and an open bug bounty programme. This report is addressed to the client, may not be relied upon by third parties, and is subject in full to the terms and conditions set out in #link(<appendix>)[Appendix A].
  ]
  pagebreak()

  // Table of contents.
  outline(depth: 2, indent: auto)
  pagebreak()

  // Main body.
  body

  show: backmatter

  [
    = Appendix <appendix>

    #v(1em)

    == Terms and Conditions of the Commercial Agreement

    #v(1em)

    === Confidentiality

    Both parties agree, within a framework of trust, to discretion and confidentiality in handling the business. This report cannot be shared, referred to, altered, or relied upon by any third party without Txpipe LLC, 651 N Broad St, Suite 201, Middletown registered at the county of New Castle, written consent.

    The violation of the aforementioned, as stated supra, shall empower TxPipe to pursue all of its rights and claims in accordance with the provisions outlined in Title 6, Subtitle 2, Chapter 20 of the Delaware Code titled "Trade Secrets,", and to also invoke any other applicable law that protects or upholds these rights.

    Therefore, in the event of any harm inflicted upon the company's reputation or resulting from the misappropriation of trade secrets, the company hereby reserves the right to initiate legal action against the contractor for the actual losses incurred due to misappropriation, as well as for any unjust enrichment resulting from misappropriation that has not been accounted for in the calculation of actual losses.

    === Service Extension and Details

    *This report does not endorse or disapprove any specific project, team, code, technology, asset or similar. It provides no warranty or guarantee about the quality or nature of the technology/code analyzed.*

    This agreement does not authorize the client #client to make use of the logo, name, or any other unauthorized reference to Txpipe LLC, except upon express authorization from the company.

    TxPipe LLC shall not be liable for any use or damages suffered by the client or third-party agents, nor for any damages caused by them to third parties. The sole purpose of this commercial agreement is the delivery of what has been agreed upon. The company shall be exempt from any matters not expressly covered within the contract, with the client bearing sole responsibility for any uses or damages that may arise.

    Any claims against the company under the aforementioned terms shall be dismissed, and the client may be held accountable for damages to reputation or costs resulting from non-compliance with the aforementioned provisions. *This report provides general information and is not intended to constitute financial, investment, tax, legal, regulatory, or any other form of advice.*

    Any conflict or controversy arising under this commercial agreement or subsequent agreements shall be resolved in good faith between the parties. If such negotiations do not result in a conventional agreement, the parties agree to submit disputes to the courts of Delaware and to the laws of that jurisdiction under the powers conferred by the Delaware Code, TITLE 6, SUBTITLE I, ARTICLE 1, Part 3 § 1-301. and Title 6, SUBTITLE II, chapter 27 §2708.

    === Disclaimer

    The audit constitutes a comprehensive examination and assessment as of the date of report submission. The company expressly disclaims any certification or endorsement regarding the subsequent performance, effectiveness, or efficiency of the contracted entity, post-report delivery, whether resulting from modification, alteration, malfeasance, or negligence by any third party external to the company.

    The company explicitly disclaims any responsibility for reviewing or certifying transactions occurring between the client and third parties, including the purchase or sale of products and services.

    This report is strictly provided for *_informational purposes_* and reflects solely the due diligence conducted on the following files and their corresponding hashes using sha256 algorithm:

    #create_table(audited_files)

    TxPipe advocates for the implementation of multiple independent audits, a publicly accessible bug bounty program, and continuous security auditing and monitoring. Despite the diligent manual review processes, the potential for errors exists. TxPipe strongly advises seeking multiple independent opinions on critical matters. It is the firm belief of TxPipe that every entity and individual is responsible for conducting their own due diligence and maintaining ongoing security measures.

    #pagebreak()

    == Issue Guide

    === Severity
    #v(1em)

    #grid(
      columns: (20%, 80%),
      gutter: 1pt,
      cell(fill: table_header, height: auto)[
        #set align(horizon + center)
        *Severity*
      ],
      cell(fill: table_header, height: auto)[
        #set align(horizon + center)
        *Description*
      ],
      cell(fill: critical)[
        #set align(horizon + center)
        Critical
      ],
      cell()[
        #set align(horizon)
        Critical issues highlight exploits, bugs, loss of funds, or other vulnerabilities
        that prevent the dApp from working as intended. These issues have no workaround.
      ],
      cell(fill: major)[
        #set align(horizon + center)
        Major
      ],
      cell()[
        #set align(horizon)
        Major issues highlight exploits, bugs, or other vulnerabilities that cause unexpected
        transaction failures or may be used to trick general users of the dApp. dApps with Major issues
        may still be functional.
      ],
      cell(fill: minor)[
        #set align(horizon + center)
        Minor
      ],
      cell()[
        #set align(horizon)
        Minor issues highlight edge cases where a user can purposefully use the dApp
        in a non-incentivized way and often lead to a disadvantage for the user.
      ],
      cell(fill: info)[
        #set align(horizon + center)
        Info
      ],
      cell()[
        #set align(horizon)
        Info are not issues. These are just pieces of information that are beneficial to the dApp creator. These are not necessarily acted on or have a resolution, they are logged for the completeness of the audit.
      ],
    )

    #v(1em)

    === Status
    #v(1em)

    #grid(
      columns: (20%, 80%),
      gutter: 1pt,
      cell(fill: table_header, height: auto)[
        #set align(horizon + center)
        *Status*
      ],
      cell(fill: table_header, height: auto)[
        #set align(horizon + center)
        *Description*
      ],

      cell(fill: resolved)[
        #set align(horizon + center)
        Resolved
      ],
      cell()[
        #set align(horizon)
        Issues that have been *fixed* by the *project* team.
      ],
      cell(fill: acknowledged)[
        #set align(horizon + center)
        Acknowledged
      ],
      cell()[
        #set align(horizon)
        Issues that have been *acknowledged* or *partially fixed* by the *project* team. Projects
        can decide to not *fix* issues for whatever reason.
      ],
      cell(fill: identified)[
        #set align(horizon + center)
        Identified
      ],
      cell()[
        #set align(horizon)
        Issues that have been *identified* by the *audit* team. These
        are waiting for a response from the *project* team.
      ],
    )

    #pagebreak()

    == Revisions
    #v(1em)

    This report was created using a git based workflow. All changes are tracked in a github repo and the report is produced
    using #tx_link("https://typst.app")[typst]. The report source is available #tx_link(repo)[here]. All versions with downloadable PDFs can be found on the #tx_link(repo + "/releases")[releases page].

    #v(1em)

    == About Us
    #v(1em)

    TxPipe is a blockchain technology company responsible for many projects that are now a critical part
    of the Cardano ecosystem. Our team built #tx_link("https://github.com/txpipe/oura")[Oura], #tx_link("https://github.com/txpipe/scrolls")[Scrolls], #tx_link("https://github.com/txpipe/pallas")[Pallas], #tx_link("https://demeter.run")[Demeter], and we're the original home of #tx_link("https://aiken-lang.org")[Aiken]. We're passionate
    about making tools that make it easier to build on Cardano. We believe that blockchain adoption can be accelerated by improving developer experience. We develop blockchain tools, leveraging the open-source community and its methodologies.

    #v(1em)

    === Links

    #v(1em)

    - #tx_link("https://txpipe.io")[Website]
    - #tx_link("hello@txpipe.io")[Email]
    - #tx_link("https://twitter.com/txpipe_tools")[Twitter]

  ]
}

#let files_audited(items: ()) = {
    grid(
        columns: (auto),
        gutter: 1pt,
        cell(fill: rgb("#E5E5E5"), height: auto)[*Filename*],
        ..items.map(
            row => cell(height: auto)[#row]
        )
    )
}

#let titles = ("ID", "Title", "Severity", "Status")

#let finding_titles = ("Category", "Commit", "Severity", "Status")

#let findings(items: (), tag: "") = {
  let counts = ("Critical": 0, "Major": 0, "Minor": 0, "Info": 0)
  let numbered = ()
  for item in items {
    let n = counts.at(item.severity) + 1
    counts.insert(item.severity, n)
    numbered.push(item + (id: tag + "-" + _severity_digit(item.severity) + _pad2(n)))
  }
  let items = numbered.sorted(key: item => _severity_digit(item.severity))

  grid(
    columns: (1fr, 46%, 1fr, 1fr),
    gutter: 1pt,
    ..titles.map(t => cell(fill: table_header, height: auto)[
      #set align(horizon + center)
      *#t*
    ]),
    ..items
      .map(
        row => (
          cell()[
            #set align(horizon + center)
            #link(label(row.id))[*#row.id*]
          ],
          cell()[
            #set align(horizon)
            #row.title
          ],
          cell(
            fill: if row.severity == "Critical" {
              critical
            } else if row.severity == "Major" {
              major
            } else if row.severity == "Minor" {
              minor
            } else {
              info
            }
          )[
            #set align(horizon + center)
            #row.severity
          ],
          cell(
            fill: if row.status == "Resolved" {
              resolved
            } else if row.status == "Acknowledged"  {
              acknowledged
            } else if row.status == "Informed"  {
              identified
            } else if row.status == "Identified"  {
              identified
            } else {
              unknown
            }
          )[
            #set align(horizon + center)
            #shrink-to-width(row.status)
          ]
        )
      )
      .flatten()
  )

  pagebreak()

  show link: underline
  for finding in items {
    [
      == #finding.id #finding.title
      #label(finding.id)

      #v(1em)

      #grid(
        columns: (1.3fr, 48%, 1fr, 1.4fr),
        gutter: 1pt,
        ..finding_titles.map(t => cell(fill: rgb("#E5E5E5"), height: auto)[
          #set align(horizon + center)
          *#t*
        ]),
        cell(height: auto)[
          #set align(horizon + center)
          #finding.category
        ],
        cell(height: auto)[
          #set align(horizon + center)
          #finding.commit
        ],
        cell(
          height: auto,
          fill: if finding.severity == "Critical" {
            critical
          } else if finding.severity == "Major" {
            major
          } else if finding.severity == "Minor" {
            minor
          } else {
            info
          }
        )[
          #set align(horizon + center)
          #finding.severity
        ],
        cell(
          height: auto,
          fill: if finding.status == "Resolved" {
            resolved
          } else if finding.status == "Acknowledged"  {
            acknowledged
          } else if finding.status == "Informed"  {
            identified
          } else if finding.status == "Identified"  {
            identified
          } else {
            unknown
          }
        )[
          #set align(horizon + center)
          #finding.status
        ]
      )

      #v(1em)

      === Description

      #v(1em)

      #finding.description

      #v(1em)

      === Recommendation

      #v(1em)

      #finding.recommendation

      #v(1em)

      === Resolution

      #v(1em)

      #finding.resolution

      #v(3em)
      #align(right)[
        _Back to #link(<Findings>)[List of Findings]_
      ]
    ]

    pagebreak()
  }
}

// Transaction diagrams

#let tx_out_height_estimate(input) = {
  let address = if "address" in input { 1 } else { 0 }
  let value = if "value" in input { input.value.len() } else { 0 }
  let datum = if "datum" in input { input.datum.len() } else { 0 }
  return (address + value + datum) * 8pt
}

// show datum field
#let datum_field(indent, k, val) = [
  #if val == "" or val == [] [
    // no value or type
    #h(indent)\+ #raw(k)
  ] else [
    // value or type
    #h(indent)\+ #raw(k)
    #if type(val) == content [ \= #val ]  // value
    #if type(val) == str [ : #val ]  // type
    #if type(val) == int [ \= #val ]  // value
    #if type(val) == array [
      #stack(dir: ttb, spacing: 0.4em,
        for item in val [
          #datum_field(indent + 1.2em, "", item) \
        ]
      )
    ]
    #if type(val) == dictionary [
      #v(-0.7em)
      #stack(dir: ttb, spacing: 0.4em,
        ..val.pairs().map(((k, v)) => datum_field(indent + 1.2em, k, v))
      )
    ]
  ]
]

#let tx_out(input, position, inputHeight) = {
  let address = if "address" in input [
    *Address: #h(0.5em) #input.address*
  ] else []
  let value = if "value" in input [
    *Value:* #if ("ada" in input.value) [ *#input.value.ada* ADA ] \
    #v(-1.0em)
    #stack(dir: ttb, spacing: 0.4em,
      ..input.value.pairs().map(((k, v)) => [
        #if k != "ada" [
          #h(2.3em) \+
          #if type(v) == content { math.bold(v) }
          #if type(v) == str and v != "" [*#v*]
          #k
        ]
      ])
    )
  ] else []
  let datum = if "datum" in input [
    *Datum:* \
    #v(-0.8em)
    #stack(dir: ttb, spacing: 0.4em,
      ..input.datum.pairs().map(((k,val)) => datum_field(1.2em, k, val))
    )
  ] else []
  let addressHeight = measure(address).height + if "address" in input { 6pt } else { 0pt }
  let valueHeight = measure(value).height + if "value" in input { 6pt } else { 0pt }
  let datumHeight = measure(datum).height + if "datum" in input { 6pt } else { 0pt }
  let thisHeight = 32pt + addressHeight + valueHeight + datumHeight

  if "dots" in input {
    return (
    content: place(dx: position.x, dy: position.y, [
      #place(dx: 4em, dy: -1em)[*.*]
      #place(dx: 4em, dy: 0em)[*.*]
      #place(dx: 4em, dy: 1em)[*.*]
    ]),
    height: thisHeight,
  )
  } else {

  return (
    content: place(dx: position.x, dy: position.y, [
      *#input.name*
      #line(start: (-4em, -1em), end: (10em, -1em), stroke: red)
      #place(dx: 10em, dy: -1.5em)[#circle(radius: 0.5em, fill: white, stroke: red)]
      #if "address" in input { place(dx: 0em, dy: -3pt)[#address] }
      #place(dx: 0em, dy: addressHeight)[#value]
      #if "datum" in input { place(dx: 0em, dy: addressHeight + valueHeight)[#datum] }
    ]),
    height: thisHeight,
  )
  }
}

#let collapse_values(existing, v, one) = {
  if type(v) == int {
    existing.qty += one * v
  } else if type(v) != content{
    let parts = v.matches(regex("([ ]*([+-]?)[ ]*([0-9]*)[ ]*([a-zA-Z]*)[ ]*)"))
    for part in parts {
      let sign = part.captures.at(1)
      let qty = int(if part.captures.at(2) == "" { 1 } else { part.captures.at(2) })
      let var = part.captures.at(3)
      let existing_var = existing.variables.at(var, default: 0)
      if var == "" {
        existing.qty += one * qty
      } else {
        if sign == "-" {
          existing.variables.insert(var, existing_var - one * qty)
        } else {
          existing.variables.insert(var, existing_var + one * qty)
        }
      }
    }
  }
  existing
}

#let vanilla_transaction(name, inputs: (), outputs: (), signatures: (), certificates: (), withdrawals: (), mint: (:), validRange: none, notes: none) = context {
  let inputHeightEstimate = inputs.fold(0pt, (sum, input) => sum + tx_out_height_estimate(input))
  let inputHeight = 0em
  let inputs = [
    #let start = (x: -18em, y: 1em)
    #for input in inputs {
      let tx_out = tx_out(input, start, inputHeight)

      tx_out.content

      // Now connect this output to the transaction
      if not "dots" in input {
        place(dx: start.x + 10.5em, dy: start.y + 0.84em)[
          #let lineStroke = if input.at("reference", default: false) { (paint: blue, thickness: 1pt, dash: "dashed") } else { blue }
          #line(start: (0em, 0em), end: (7.44em, 0em), stroke: lineStroke)
        ]
        place(dx: start.x + 10.26em, dy: start.y + 0.59em)[#circle(radius: 0.25em, fill: blue)]
      }
      if input.at("redeemer", default: none) != none {
        place(dx: start.x + 12.26em, dy: start.y - 0.2em)[#input.at("redeemer")]
      }

      start = (x: start.x, y: start.y + tx_out.height)
      inputHeight += tx_out.height
    }
  ]

  let outputHeightEstimate = outputs.fold(0pt, (sum, output) => sum + tx_out_height_estimate(output))
  let outputHeight = 0em
  let outputs = [
      #let start = (x: 4em, y: 1em)
      #for output in outputs {

        let tx_out = tx_out(output, start, outputHeight)
        tx_out.content
        start = (x: start.x, y: start.y + tx_out.height)
        outputHeight += tx_out.height
      }
    ]

  // Collapse down the `mint` array
  let display_mint = (:)
  for (k, v) in mint {
    let display = []
    if type(v) == int {
      // the provided value is an integer
      if v == 0 {
        continue
      } else if v > 0 {
        display += [ \+ ]
      } else if v < 0 {
        display += [ \- ]
      }
      display += [#calc.abs(v)]
    } else {
      // the provided value can be a letter or variable name
      if type(v) == str and v.starts-with("-") {
        display += [\- #v.slice(1)]
      } else {
      display += [\+ #v]
      }
    }
    display += [ #raw(k)]
    display_mint.insert(k, display)
  }

  let mints = if display_mint.len() > 0 [
    *Mint:* \
    #for (k, v) in display_mint [
      #v \
    ]
  ] else []
  let sigs = if signatures.len() > 0 [
    *Signatures:* \
    #for signature in signatures [
      - #signature
    ]
  ] else []
  let certs = if certificates.len() > 0 [
    *Certificates:*
    #for certificate in certificates [
      - #certificate
    ]
  ] else []
  let withs = if withdrawals.len() > 0 [
    *Withdrawals:*
    #for withdrawal in withdrawals [
      - #withdrawal
    ]
  ] else []
  let valid_range = if validRange != none [
    *Valid Range:* \
    #if "lower" in validRange [#validRange.lower $<=$ ]
    `slot`
    #if "upper" in validRange [$<=$ #validRange.upper]
  ] else []

  let boxHeight = {
    100pt + 32pt * (mint.len() + certificates.len() + signatures.len()) + 40pt * withdrawals.len() + (if validRange != none { 60pt } else { 0pt })
  }

  let items = (mints, sigs, certs, withs, valid_range,)

  let transaction = [
      #set align(center)
      #rect(
        radius: 4pt,
        height: calc.max(boxHeight, inputHeight + 16pt, outputHeight + 16pt),
        [
          #pad(top: 1em, name)
          #v(1em)
          #set align(left)
          #stack(dir: ttb, spacing: 1em,
            ..items.filter(it => it != [])
          )
        ]
      )
    ]

  let diagram = stack(dir: ltr,
    inputs,
    transaction,
    outputs
  )
  let size = measure(diagram)
  block(width: 100%)[
    #set align(center)
    #diagram
    #set align(left)
    #if notes != none [
      #box(
        width: 100%,
        fill: rgb("f0f0f0"),
        stroke: 0.5pt + black,
        inset: 8pt,
      )[
        #set text(size: 9pt)
        *Notes*: #notes
      ]
    ]
  ]
}
