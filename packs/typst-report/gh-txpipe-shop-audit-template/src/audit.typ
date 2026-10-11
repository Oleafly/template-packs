#import "templates/report.typ": *
#import "transactions.typ": *

// The following shell command can be used to build this table, skipping the aiken lib files and any files with test in its name:
// find . -type f -name "*.ak" ! -path "./build/*" ! -name "*test*" -exec sh -c 'for file; do sha256sum "$file"; done' sh {} + | sort -k2 | awk '{printf "( \"%s\", \"%s\" ),\n", $2, $1}'
#let audited_files = (
  ("path/to/file", "hash"),
)

#show: report.with(
  client: "[CLIENT]",
  title: "[TITLE]",
  // date: "[DATE]", // Default: Today.
  audited_files: audited_files,
  is_draft: true,
)

= Summary
#v(1em)
#lorem(50)
#v(1em)

== Overview
#v(1em)
#lorem(50)
#v(1em)

== Process
#v(1em)
#lorem(50)
#pagebreak()

=== Audited Files
#v(1em)

Below is a list of all audited files in this report.
Any files *not* listed here were *not* audited.
The final state of the files for the purposes of this report is considered to be commit `XXXX`.
// i.e., this is the commit hash resulting from all resolutions, if any.

#files_audited(
  items: audited_files.map(t => t.first())
)

#pagebreak()

= Specification

== UTxOs

// - Use singular "UTxO" for singletons: UTxO types that are designed to have
//   only one instance sitting at an address.
//   Example: "Protocol Settings UTxO"
// - Use plural "UTxOs" for UTxO types that are designed to have multiple
//   instances.
//   Example: "Order UTxOs"

=== Example UTxO/s

_Briefly explain here the purpose of the UTxO/s._

- Address:
  - Parameters: ...
- Value:
  - ADA:
  - Asset A: _(policy and token name)_
  - ...
- Datum: _(datum type and fields)_

== Assets

== Transactions

The purpose of the transaction diagrams that follow is to outline the key
aspects of each operation in the protocol.
To provide a clearer presentation, we omit details such as the minimum ADA
required in each UTxO, transaction fees, the sources of that ADA, etc.

=== Example transaction

_Briefly explain here the purpose of the transaction._
_You can use @XXX-001 to reference findings_

See @fig:example for an example transaction diagram.

#figure(
  scale(100%, reflow: true)[#example_transaction],
  caption: [
    Example transaction
  ],
  gap: 2em,
) <fig:example>


#pagebreak()

= Findings <Findings>
#v(1em)
#findings(tag: "XXX", items: ( // tag: client identifier (e.g. "IND", "BUT")
                               // IDs are generated as TAG-XNN, where X is
                               // the severity digit and NN is a per-severity counter.
                               // Findings are displayed sorted by severity.
(
    title: [Finding title],// diagnosis: write it as a fact about the
                           // current version of the code. Do not write it
                           // as a recommendation
    severity: "Critical",  // Critical (0), Major (1), Minor (2), Info (3)
                           // determines the X digit in the finding ID
    status: "Resolved",    // Resolved, Acknowledged, Informed, Identified
    category: "Bug",       // Bug, Redundancy, Optimization, Robustness, etc.
    commit: "",            // commit hash at which it was arranged to perform
                           // the audit. If the codebase is updated, a new
                           // milestone commit hash must be agreed upon. Later
                           // findings use the new commit hash.
    description: [
      XXXXXXX
    ],
    recommendation: [
      XXXXXXX
    ],
    resolution: [
      Resolved in commit `XXXX`.
      // Alternatively:
      // The project team decided not to resolve this ﬁnding.
    ],
  ),
))

= Minor issues

In this section we list some issues we found that do not qualify as findings
such as typos, coding style, naming, etc.
We used the Github issues system to report them.

- #link("https://github.com/midnight-reserve-contracts/issues/<number>")[Issue \#<number>: <title>]
