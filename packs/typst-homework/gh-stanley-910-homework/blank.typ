// Example: How to use the template for any new assignment
// Import all template functions
#import "assignment-template.typ": *
// For nested subparts, also import the nested-subpart function

// Apply document setup (page formatting, fonts, etc.)
#show: setup-document

// Add assignment header
#assignment-header(
  course: "COMP 421",
  number: "2",
  name: "Stanley Wang",
  date: "January 18, 2026"
)

// Simple exercise without problem description
#exercise(
  number: "01",
  title: "Database Design",
  problem: [],
  solution: [
    #qed
  ]
)

// Exercise with problem description
#exercise(
  number: "02",
  title: "Normalization",
  problem: [
    Given the relation $R(A, B, C, D, E)$ with functional dependencies:
    $ A -> B, C -> D, D -> E $
    Determine the highest normal form.
  ],
  solution: [
    Starting with the given functional dependencies...

    Therefore, the relation is in 3NF but not BCNF.

    #qed
  ]
)

// Multi-part exercise
#exercise(
  number: "03",
  title: "Query Optimization",
  problem: [
    Consider the following SQL query...
  ],
  solution: [
    #subpart(
      label: "(a) (3 points)",
      description: [Draw the relational algebra tree.],
    )[
      The relational algebra tree is...
    ]

    #subpart(
      label: "(b) (7 points)",
      description: [Optimize the query and explain your transformations.],
    )[
      Applying optimization rules:

      1. Push down selections...
      2. Push down projections...
    ]

    #qed
  ]
)

// Exercise with an image
#exercise(
  number: "04",
  title: "ER Diagram",
  problem: [
    Design an ER diagram for a university database system.
  ],
  solution: [
    // #align(center)[
    // ]

    Additional constraints:
    - #text[$R(A, B, C, D, E)$]
    - Professors can teach multiple courses

    #qed
  ]
)

// Example: Multi-part problem using subpart function
#exercise(
  number: "05",
  title: "SQL Queries and Relational Algebra",
  problem: [
    Given the following database schema:
    - Students(sid, name, major)
    - Courses(cid, title, credits)
    - Enrolled(sid, cid, grade)
  ],
  solution: [
    // Each subpart has a label, optional description, and solution content
    // The label and description appear at base indentation (left-aligned)
    // The content is indented automatically

    #subpart(
      label: "(a) (5 points)",
      description: [Write a SQL query to find all students in CS major.],
    )[
      ```sql
      SELECT name
      FROM Students
      WHERE major = 'CS';
      ```

      This query filters students by their major field.
    ]

    #subpart(
      label: "(b) (7 points)",
      description: [
        Convert the following SQL to relational algebra:
        `SELECT DISTINCT s.name FROM Students s, Enrolled e WHERE s.sid = e.sid`
      ],
    )[
      The relational algebra expression is:

      $ pi_("name") (sigma_("Students.sid = Enrolled.sid") ("Students" times "Enrolled")) $

      Steps:
      1. Cartesian product of Students and Enrolled
      2. Select matching sid values (natural join condition)
      3. Project only the name attribute
    ]

    #subpart(
      label: "(c) (3 points)",
      description: [List the normal forms violated by this schema.],
    )[
      The schema satisfies:
      - #text[$1"NF"$] - All attributes are atomic
      - #text[$2"NF"$] - No partial dependencies
      - #text[$3"NF"$] - No transitive dependencies

      No violations detected.
    ]

    #qed
  ]
)

// Example: Nested subparts with increased indentation
#exercise(
  number: "06",
  title: "Advanced Database Concepts",
  problem: [
    Answer the following questions about database transactions and normalization.
  ],
  solution: [
    // Main part (a) at base indentation
    #subpart(
      label: "(a) (10 points)",
      description: [Explain ACID properties with examples.],
    )[
      Each ACID property is explained below:

      // Nested subpart (i) - indented further than (a)
      #nested-subpart(
        label: "(a)",
        description: [Atomicity:],
      )[
        All operations in a transaction complete or none do.

        Example: Bank transfer either completes both debit and credit, or neither.
      ]

      // Nested subpart (ii) - same level as (i)
      #nested-subpart(
        label: "(ii)",
        description: [Consistency:],
      )[
        Database moves from one valid state to another.

        Example: Account balances always sum to the same total.
      ]

      // Nested subpart (iii)
      #nested-subpart(
        label: "(iii)",
        description: [Isolation:],
      )[
        Concurrent transactions don't interfere with each other.
      ]

      // Nested subpart (iv)
      #nested-subpart(
        label: "(iv)",
        description: [Durability:],
      )[
        Committed changes persist even after system failure.
      ]
    ]

    // Main part (b) at base indentation
    #subpart(
      label: "(b) (8 points)",
      description: [Normalize the following relation to BCNF.],
    )[
      Given: #text[$R(A, B, C, D)$] with FDs: #text[$A -> B$], #text[$C -> D$]

      // Nested steps for the normalization process
      #nested-subpart(
        label: "Step 1:",
        description: [Identify candidate keys],
      )[
        The candidate key is #text[$(A, C)$] since:
        - #text[$A$] determines #text[$B$]
        - #text[$C$] determines #text[$D$]
        - We need both to determine all attributes
      ]

      #nested-subpart(
        label: "Step 2:",
        description: [Check for BCNF violations],
      )[
        Both #text[$A -> B$] and #text[$C -> D$] violate BCNF because:
        - #text[$A$] is not a superkey
        - #text[$C$] is not a superkey
      ]

      #nested-subpart(
        label: "Step 3:",
        description: [Decompose into BCNF],
      )[
        The decomposition yields:
        - #text[$R_1(A, B)$] with FD: #text[$A -> B$]
        - #text[$R_2(C, D)$] with FD: #text[$C -> D$]
        - #text[$R_3(A, C)$] to maintain the relationship

        All relations are now in BCNF.
      ]
    ]

    #qed
  ]
)
