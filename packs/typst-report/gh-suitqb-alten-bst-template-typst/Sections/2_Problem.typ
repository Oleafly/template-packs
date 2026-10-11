// Section 2: Scientific Problem and Obstacles to Overcome

#import "../Utilities/style.typ": definition-box, example-box

= Scientific Problem and Obstacles to Overcome <sec:problem>

#definition-box[
  - *Goal*: This section should clearly define the Scientific Problem: This section is dedicated to articulating the specific scientific problem or challenge that the research addresses. It should go beyond a general topic or area of interest and pinpoint the exact issue or question that the research aims to resolve or answer.
  - *RACI*:
    - Writer(s): Innovation Pilot, Intern
    - Reviewer: PIValo, Research Director
  - *Note*: This section is written while doing your SoTA, as one cannot go without the other: here you describe your problem, and eventually already summarise some obstacles found in the literature. Whilst a document is provided in a sequential manner, its production might be non linear, so don't be afraid to re-iterate the production of this section while building your SoTA
  - *Evaluation Process*: This section as well as the SoTA MUST be presented by the intern to the PIValo and the Research Director *between the second and third month of internship*.
]

== Relevant Context <subsec:context>

// Specification of the relevant context for the R&D Operation to happen. This section should explain the importance of the problem and how it aligns with the research project's vision and the overarching research program.

== Research Question(s) <subsec:research-questions>

// Focus on the identified research questions;

== Obstacles to overcome: identified Technical and Scientific Locks <subsec:locks>

#definition-box[
  This section must show that the difficulties encountered are not the result of a lack of knowledge of existing principles or a need for training. The difficulties must be recognized as such by experts in the field.
  
  - Starting from the research questions, describe the associated lock(s) and uncertainty(ies). These locks/uncertainties can be:
    - An absence or shortcoming in the approach, model, method or problem definition, which makes it impossible to assess the feasibility of a solution and/or its viability under conditions representative of reality;
    - A paradox: increasing one factor contributes to a deterioration in one or more others, with no a priori optimum for satisfying all constraints or resolving all difficulties;
    - Complexity: it is not possible to isolate and qualify the influence of one or more factors (non-linearities, multiple interactions, feedbacks, systemic effects, combinations of factors of different natures, etc.).
  - Explain the technical difficulties and constraints in terms of feasibility (i.e. difficulties that do not result from a lack of knowledge of existing solutions or a need for training). To do this:
    - Mention the main complex technical issues you are facing;
    - Explain clearly how these points represent difficulties for the _tradesman_ (a person who is already experienced, and who has no prior need to upgrade skills or receive training in the field);
]

#definition-box[
  *Lock*: Limit whose solution is not known in advance based on the knowledge available in the state of the art. Can be conceptual or technical.
]

#example-box[
  *Examples*: (context: install a trajectory computer on a drone)
  
  - Challenge: the constraints are to achieve a weight of less than 100g, 5cm³ and to withstand accelerations of 2g. The challenge is to reduce thermal power density and maintain sufficient computing power while reducing size.
  - Technical Lock: the development of lean algorithms requires a reduction in the number of parameters taken into account for trajectory calculation. The increase in calculation speed no longer guarantees trajectory accuracy (paradox, to be argued with the state of the art). The absence of control over parameter X produces an instability that we can't model (absence, to be argued with the state of the art). Feedback on other parameters should compensate for this instability, but this has not yet been integrated into the flight model (complexity lock, to be supported by the analysis state of the art).
]
