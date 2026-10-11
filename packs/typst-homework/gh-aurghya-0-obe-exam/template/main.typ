#import "/obe-paper.typ": obe-paper, obe-section, obe-question-table, obe-blueprint

#show: obe-paper.with(
  mode: "exam", // Switch between "exam" (raw question paper) and "internal" (OBE/IQAC audit copy)
  institution: "NAME OF THE INSTITUTION / UNIVERSITY",
  sub-institution: "Affiliated to State University | Accredited with Grade 'A'",
  department: "DEPARTMENT OF COMPUTER SCIENCE & ENGINEERING",
  exam-title: "END SEMESTER REGULAR EXAMINATION",
  session: "ACADEMIC SESSION 2025-2026",
  degree: "Master of Computer Applications (MCA)",
  semester: "Semester II",
  course-code: "CS202",
  course-name: "ADVANCED DATABASE MANAGEMENT SYSTEMS",
  time-allowed: "3 Hours",
  max-marks: 80,
  date: "15-05-2026",
  co-list: (
    (id: "CO1", text: "Demonstrate comprehension of relational model, ER modeling, and relational algebra operations.", bloom: "K1, K2"),
    (id: "CO2", text: "Construct complex SQL queries, database triggers, views, and stored procedures.", bloom: "K3"),
    (id: "CO3", text: "Apply database normalization techniques (up to 5NF/BCNF) to eliminate schema redundancies.", bloom: "K3, K4"),
    (id: "CO4", text: "Evaluate concurrency control, transaction isolation levels, and recovery protocols.", bloom: "K4, K5"),
    (id: "CO5", text: "Design distributed databases and NOSQL data architectures for scalable big data applications.", bloom: "K5, K6"),
  )
)

// ==========================================
// PART A: SHORT ANSWER QUESTIONS (AUTOMATIC NUMBERING 1-10)
// ==========================================
#obe-section(
  "PART A: SHORT ANSWER QUESTIONS",
  description: "Answer ALL questions. Each question carries 2 marks.",
  total-marks: "20 (10 x 2)"
)

#obe-question-table(
  // Automatically numbered 1 to 10 since `num` is omitted
  questions: (
    (body: [Define total participation and partial participation in Entity-Relationship (ER) diagrams with a suitable example.], marks: 2, co: "CO1", bl: "K1"),
    (body: [Differentiate between Primary Key, Candidate Key, and Super Key in a relational schema.], marks: 2, co: "CO1", bl: "K2"),
    (body: [Explain the significance of the `HAVING` clause versus the `WHERE` clause in SQL aggregate queries.], marks: 2, co: "CO2", bl: "K2"),
    (body: [What is a database trigger? State one practical scenario where a `BEFORE INSERT` trigger is used.], marks: 2, co: "CO2", bl: "K1"),
    (body: [Define Lossless-Join decomposition in relational database normalization.], marks: 2, co: "CO3", bl: "K1"),
    (body: [State the ACID properties of database transactions and briefly define Isolation.], marks: 2, co: "CO4", bl: "K2"),
    (body: [What is a Phantom Read problem in concurrent transaction execution?], marks: 2, co: "CO4", bl: "K2"),
    (body: [Explain the difference between Strict Two-Phase Locking (Strict 2PL) and Rigorous 2PL.], marks: 2, co: "CO4", bl: "K2"),
    (body: [Summarize the CAP theorem for distributed databases and NoSQL systems.], marks: 2, co: "CO5", bl: "K2"),
    (body: [Differentiate document-oriented databases (e.g., MongoDB) from key-value stores (e.g., Redis).], marks: 2, co: "CO5", bl: "K2"),
  )
)

// ==========================================
// PART B: ANALYTICAL & APPLICATION QUESTIONS (INTERNAL CHOICE: BOTH NUMBERED 11, 12, ETC.)
// ==========================================
#obe-section(
  "PART B: ANALYTICAL & APPLICATION QUESTIONS",
  description: "Answer EITHER option from each question. Each question carries 8 marks.",
  total-marks: "40 (5 x 8)"
)

#obe-question-table(
  questions: (
    // Question 11
    (num: "11", body: [
      Consider a University Management System. Construct a complete Entity-Relationship (ER) diagram showing Entities (`Student`, `Course`, `Department`, `Instructor`), Attributes, Primary Keys, Cardinality Ratios (1:1, 1:N, M:N), and Participation Constraints. Translate the ER diagram into relational schemas.
    ], marks: 8, co: "CO1", bl: "K3"),
    (is-or: true),
    (num: "11", body: [
      Given relational schemas $R("StudentId", "Name", "DeptId")$ and $S("CourseId", "CourseName", "Credits")$, write equivalent expressions in both *Relational Algebra* and *Tuple Relational Calculus (TRC)* to find:
      + Names of all students enrolled in 'Data Mining'.
      + Departments having more than 50 enrolled students.
    ], marks: 8, co: "CO1", bl: "K3"),

    // Question 12
    (num: "12", body: [
      Given the schema `Employee(EmpID, EmpName, DeptID, Salary, Commission)`, write advanced SQL queries to:
      + Retrieve the second highest salary among employees in the 'Engineering' department.
      + Find all departments where the total salary expense exceeds \$500,000.
      + Write a PL/SQL stored procedure to calculate and update annual performance bonuses for all employees based on their tenure.
    ], marks: 8, co: "CO2", bl: "K3"),
    (is-or: true),
    (num: "12", body: [
      Analyze the execution plan of nested SQL queries with `IN`, `EXISTS`, and `JOIN` operations. Compare their performance on large datasets (10+ million records) and write optimized SQL queries utilizing appropriate index strategies (B-Tree vs Hash indexing).
    ], marks: 8, co: "CO2", bl: "K4"),

    // Question 13
    (num: "13", body: [
      Given a relation schema $R(A, B, C, D, E, F)$ and Functional Dependencies:
      $ F = { A -> B C, C D -> E, B -> D, E -> A } $
      + Find all candidate keys of $R$.
      + Determine the highest normal form of $R$ (1NF, 2NF, 3NF, or BCNF). Justify your answer.
      + Decompose relation $R$ into 3NF relations ensuring Dependency Preservation and Lossless Join.
    ], marks: 8, co: "CO3", bl: "K4"),
    (is-or: true),
    (num: "13", body: [
      Explain Fourth Normal Form (4NF) and Fifth Normal Form (5NF). Construct a concrete practical example of a relation that satisfies BCNF but contains Multi-Valued Dependencies (MVD), and demonstrate its step-by-step 4NF decomposition.
    ], marks: 8, co: "CO3", bl: "K4"),

    // Question 14
    (num: "14", body: [
      Consider the following concurrent schedule involving transactions $T_1, T_2, T_3$:
      $ S: r_1(X); r_2(Y); w_1(X); r_3(X); w_2(Y); w_3(Z); c_1; c_2; c_3; $
      + Draw the Precedence (Serialization) Graph for schedule $S$.
      + Determine whether schedule $S$ is Conflict Serialisable. If yes, find an equivalent serial schedule.
      + Explain how Timestamp Ordering protocol prevents deadlock in transaction management.
    ], marks: 8, co: "CO4", bl: "K4"),
    (is-or: true),
    (num: "14", body: [
      Critically evaluate ARIES (Algorithm for Recovery and Isolation Exploiting Semantics) recovery protocol. Explain the three main phases of ARIES: Analysis Phase, Redo Phase, and Undo Phase with a system crash recovery log diagram.
    ], marks: 8, co: "CO4", bl: "K5"),

    // Question 15
    (num: "15", body: [
      Compare Horizontal Sharding, Vertical Partitioning, and Consistent Hashing in distributed database architectures. Evaluate how Two-Phase Commit (2PC) protocol guarantees atomicity across distributed nodes, and discuss the coordinator failure problem.
    ], marks: 8, co: "CO5", bl: "K5"),
    (is-or: true),
    (num: "15", body: [
      Contrast SQL Relational Databases with NoSQL Graph Databases (e.g. Neo4j) and Column-Family Stores (e.g. Apache Cassandra). Design a NoSQL schema for an e-commerce platform handling high-velocity user activity logs and recommendation queries.
    ], marks: 8, co: "CO5", bl: "K5"),
  )
)

// ==========================================
// PART C: HIGH ORDER DESIGN & SYNTHESIS (AUTOMATIC NUMBERING STARTING AT 16)
// ==========================================
#obe-section(
  "PART C: COMPREHENSIVE & DESIGN-ORIENTED QUESTIONS",
  description: "Answer ANY TWO questions. Each question carries 10 marks.",
  total-marks: "20 (2 x 10)"
)

#obe-question-table(
  start-num: 16, // Automatically numbered 16, 17, 18
  questions: (
    (body: [
      *Real-World Database Design & Schema Optimization:* \
      A multi-specialty hospital management system requires a database to manage Patients, Doctors, Appointments, Medical Prescriptions, Lab Tests, and Billing.
      #v(2pt)
      + Design a fully normalized relational schema up to 3NF/BCNF with complete primary key and foreign key constraints. [4 Marks]
      + Write SQL scripts to create indices on high-cardinality attributes to optimize emergency patient search queries. [3 Marks]
      + Formulate a database view and security role definition restricting junior hospital staff from viewing confidential patient diagnosis records while allowing access to billing data. [3 Marks]
    ], marks: 10, co: "CO3", bl: "K6"),

    (body: [
      *Concurrency Control & High Availability Evaluation:* \
      An online banking system experiences severe performance bottlenecks and deadlock cycles during high-traffic flash sales.
      #v(2pt)
      + Analyze how lock escalation and phantom read anomalies contribute to deadlocks in high-throughput banking systems. [4 Marks]
      + Propose a multi-version concurrency control (MVCC) architecture paired with Optimistic Concurrency Control (OCC) to mitigate transaction blocking. [3 Marks]
      + Evaluate the trade-offs between Snapshot Isolation and Serializable Isolation in terms of throughput, latency, and data consistency. [3 Marks]
    ], marks: 10, co: "CO4", bl: "K5"),

    (body: [
      *Big Data & Distributed Database Systems Architecture:* \
      Design a global food delivery platform backend database supporting 50 million active users, real-time driver GPS tracking, and instant payment transactions.
      #v(2pt)
      + Architect a hybrid data storage strategy integrating RDBMS (for financial transactions) and NoSQL/In-Memory Caching (for real-time driver locations and session states). [4 Marks]
      + Explain how Read Replicas, Write Masters, and Geo-distributed Replication ensure fault tolerance under node crashes. [3 Marks]
      + Write a MapReduce or Aggregation Pipeline algorithm in MongoDB to compute top-performing restaurants by revenue per postal zip code. [3 Marks]
    ], marks: 10, co: "CO5", bl: "K6"),
  )
)

// ==========================================
// OBE QUESTION PAPER BLUEPRINT (AUDIT TRAIL)
// ==========================================
#obe-blueprint(
  co-summary: (
    (co: "CO1", title: "ER Modeling & Relational Algebra", k1: 4, k2: 4, k3: 16, k4: 0, k5: 0, k6: 0),
    (co: "CO2", title: "Advanced SQL & Query Processing", k1: 2, k2: 2, k3: 8, k4: 8, k5: 0, k6: 0),
    (co: "CO3", title: "Normalization & Schema Design", k1: 2, k2: 0, k3: 0, k4: 16, k5: 0, k6: 10),
    (co: "CO4", title: "Transactions & Concurrency", k1: 0, k2: 6, k3: 0, k4: 8, k5: 18, k6: 0),
    (co: "CO5", title: "Distributed & NoSQL Databases", k1: 0, k2: 4, k3: 0, k4: 0, k5: 16, k6: 10),
  ),
  target-lots-pct: 20,
  target-hots-pct: 80
)
