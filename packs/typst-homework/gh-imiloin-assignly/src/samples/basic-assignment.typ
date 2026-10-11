// Basic Assignment Sample
// Demonstrates core functionality of the Assignly template
//
// This sample shows:
// - Basic assignment setup
// - All question types in simple form
// - Standard academic formatting
// - Student mode (show-answers: false)

#import "../assignly.typ": *

#assignment(
  title: "Introduction to Computer Science - Quiz 1",
  course: "CS 101",
  due-date: "September 25, 2025",
  author: "Prof. Smith",
  instructions: "Please answer all questions clearly. Show your work where applicable. You have 50 minutes to complete this quiz.",
  show-answers: false,
)[

  #section("Multiple Choice Questions")[
    Choose the best answer for each question.
  ]

  #single-choice(
    "Which of the following is NOT a programming language?",
    ("Python", "Java", "HTML", "C++"),
    2,
    points: 2,
    explanation: "HTML is a markup language, not a programming language.",
  )

  #single-choice(
    "What does CPU stand for?",
    (
      "Central Processing Unit",
      "Computer Processing Unit",
      "Central Program Unit",
      "Computer Program Unit",
    ),
    0,
    points: 2,
    explanation: "CPU stands for Central Processing Unit, the main processor of a computer.",
  )

  #multiple-choice(
    "Which of the following are valid data types in most programming languages? (Select all that apply)",
    ("Integer", "String", "Boolean", "Unicorn", "Float"),
    (0, 1, 2, 4),
    points: 3,
    explanation: "Integer, String, Boolean, and Float are common data types. 'Unicorn' is not a standard data type.",
  )

  #multiple-choice(
    [Which mathematical expressions represent *Big O notation* correctly?],
    (
      [$O(n^2)$ - quadratic complexity],
      [$O(log n)$ - logarithmic complexity],
      [$O(1)$ - constant complexity],
      [$O(n!)$ - factorial complexity],
    ),
    (0, 1, 2, 3), // All are correct
    points: 4,
    explanation: [All these are valid Big O notation examples representing different algorithm complexities.],
  )

  #section("True/False Questions")[
    Mark each statement as true or false.
  ]

  #true-false(
    "A compiler translates source code into machine code.",
    true,
    points: 2,
    explanation: "Yes, a compiler converts high-level source code into machine language that the processor can execute.",
  )

  #true-false(
    "RAM is a type of permanent storage.",
    false,
    points: 2,
    explanation: "False. RAM (Random Access Memory) is volatile memory that loses its contents when power is removed.",
  )

  #section("Fill in the Blanks")[
    Complete each sentence by filling in the missing words.
  ]

  #fill-blank(
    "An ___ is a step-by-step procedure for solving a problem, while a ___ is the implementation of an algorithm in a specific programming language.",
    ("algorithm", "program"),
    points: 3,
    explanation: "An algorithm is the logical sequence of steps, and a program is its implementation in code.",
  )

  #fill-blank(
    [The time complexity of binary search is #fill-blank-space(answer: "O(log n)", width: "4cm") because it divides the search space in *half* at each step.],
    (), // Content mode
    points: 4,
    explanation: [Binary search has logarithmic complexity since it eliminates half the possibilities in each iteration.],
  )

  #fill-blank(
    "The three main components of a computer system are: ___, ___, and ___.",
    ("hardware", "software", "firmware"),
    points: 3,
    explanation: "A computer system consists of hardware (physical components), software (programs), and firmware (low-level software).",
  )

  #section("Short Answer Questions")[
    Provide brief but complete answers.
  ]

  #short-answer(
    "Explain the difference between a variable and a constant in programming.",
    answer: "A variable is a storage location that can hold different values during program execution and can be modified. A constant is a value that remains fixed throughout the program execution and cannot be changed once defined.",
    points: 5,
    answer-lines: 4,
    explanation: "This tests understanding of basic programming concepts.",
  )

  #short-answer(
    "List three advantages of using functions in programming.",
    answer: "1. Code reusability - functions can be called multiple times. 2. Modularity - breaks complex problems into smaller parts. 3. Easier debugging and maintenance - isolated functionality is easier to test and fix.",
    points: 6,
    answer-lines: 5,
    explanation: "Functions provide structure, reusability, and maintainability to code.",
  )

  #section("Problem Solving")[
    Show your work and reasoning.
  ]

  #multi-part(
    "Consider a simple program that calculates the area of a rectangle:",
    (
      [Write the mathematical formula for the area of a rectangle.],
      [If length = 8 and width = 5, what is the area?],
      [Write pseudocode for a program that asks the user for length and width, then calculates and displays the area.],
    ),
    points: 10,
  )

  #separator()

  #note-box(
    "Remember to review your answers before submitting. Good luck!",
    type: "info",
  )
]
