// Section 3: State of the Art

#import "../Utilities/style.typ": definition-box, example-box

= State of the Art <sec:sota>

// Production by Intern during the first 2 months of internship

== Introduction <subsec:sota-introduction>

== Literature Review <subsec:literature-review>
// Description of the state of the art related to the R&D operation.
// One paragraph per approach + final paragraph with summary.
// 1. All references
// 2. Grouped by approach
// 3. Summary and analysis

== Summary <subsec:summary>

// 1) Identify the current limits and purpose of the R&D operation with its scientific/technological barriers.
// 2) Identify the missing elements or the novelty in relation to the state of the art.
// 3) Specify the positioning of the R&D operation in relation to the state of the art.
// ==> Presentation to be scheduled during M+2 presenting these summary elements.

=== Limitations

#definition-box[
  *Goal*: Identification of the limitations of the state of the art after summarizing the bibliographical references and existing resources that address the above constraints/difficulties, and explaining their inadequacies in meeting the difficulties/constraints:
  
  - Reference all available bibliographies and patents used to summarize this section. Warning: stating that the state of the art is non-existent is not a valid argument. On the contrary, you should explain what does exist in order to highlight the gap with the objective: this involves qualifying and analyzing the gaps in existing knowledge;
  - We invite you to present these solutions in the form of a table listing the solutions and detailing which constraints/difficulties/needs they do or do not meet. This will serve as a basis for formulating the R&D problem.
  - Define and qualify gaps: areas of the performance space, operating regimes or use cases that are not covered by existing knowledge. This paragraph should make it possible to identify and criticize the limits of scientific references that address technical difficulties.
]

#example-box[
  E.g.: the analysis of the state of the art has highlighted a first category of on-board computers, but which are not powerful enough to implement the necessary trajectory calculations. A second category can take all flight-related parameters into account, but are not sufficiently miniaturizable. For this state of the art, several research issues are possible:
  
  - Mathematical problems: developing original algorithms that can be implemented in an on-board computer.
  - Microelectronics: developing original, much more powerful and miniaturized computers.
]

=== Analysis

Example: the development of lean algorithms requires a reduction in the number of parameters taken into account for trajectory calculation. The increase in calculation speed no longer guarantees trajectory accuracy (paradox, to be argued with the state of the art). The absence of control over parameter X produces an instability that we can't model (absence, to be argued with the state of the art). Feedback on other parameters should compensate for this instability, but this has not yet been integrated into the flight model (complexity, to be argued with the state of the art).

== Our research axis

#definition-box[
  This section must show that the difficulties encountered are not the result of a lack of knowledge of existing principles or a need for training. The difficulties must be recognized as such by experts in the field.
  
  This part consists of starting from the technical difficulties/constraints, then identifying and criticizing the existing state of the art in order to state the underlying scientific problem and finally formulate the locks that stand in the way of solving it.
  
  The argument should lead to the conclusion that the state of the art (at the start of the work) does not give you access to any obvious solution enabling you to remove the locks, and that quite rightly, the objective cannot be achieved without undertaking R&D work.
]
