// ==========================================
// hw1.typ - 作业演示文件
// ==========================================

// 1. 导入模版
#import "assignment.typ": *

// 2. 导入绘图包 (如果你的作业需要画自动机或树)
#import "@preview/finite:0.5.0": automaton
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge


// 3. 初始化模版
#show: homework.with(
  title: "Assignment 1: Test Cases",
  course: "Compiler Principles",
  author: "Zhang San",
  student-id: "2024001",
  date: datetime.today().display()
)

// ------------------------------------------
// Case 1: 标准情况 (有题目 + 有答案)
// ------------------------------------------
#prob(
  title: "Regular Expressions",
  solution: [
    The minimal regular expression is:
    $ (a|b)^* a b b $
    This ensures we match any string ending in "abb".
    
    // 注意：在数学模式里，集合用 { } 直接写，不要加反斜杠 \
    // \Sigma 是错的，要写 Sigma
    The alphabet is $ Sigma = {a, b} $.
  ]
)[
  *[Standard Case]*
  
  Write a regular expression for the set of strings over $ Sigma = {a, b} $ that end with the substring "abb".
]

// ------------------------------------------
// Case 2: 只有题目 (没有答案)
// ------------------------------------------
#prob(
  title: "Open Problem",
  // 不传 solution 参数
  newpage: false // 不强制换页，紧凑一点
)[
  *[Only Question Case]*
  
  // 修正：P = NP，直接写 "NP" 避免报 undefined variable
  Please ponder the following question: Does $P = "NP"$? 
  
  (No solution is provided for this box, so no dashed line will appear.)
]

// ------------------------------------------
// Case 3: 只有答案 (没有题目)
// ------------------------------------------
#prob(
  title: "Pure Code Submission",
  solution: [
    *[Only Solution Case]*
    
    Since no question body was provided, the dashed separator line is hidden automatically.
    
    ```python
    def standard_solution():
        return "Clean Look!"
    ```
  ]
)[] // <--- Body 留空

// ------------------------------------------
// Case 4: 带有自动机绘图 (Finite 包)
// ------------------------------------------
#prob(
  title: "DFA Construction",
  solution: [
    Here is the DFA that accepts strings with an even number of 0s:
    
    #align(center)[
      #automaton((
        // 状态名称必须是字符串 
        "q0": ("0": "q1", "1": "q0"),
        "q1": ("0": "q0", "1": "q1")
      ), 
      initial: "q0", 
      final: "q0",
      padding: 1.5,
      style: (
        q0: (label: "Even"), 
        q1: (label: "Odd"),
        transition: (curve: 0) // 直线边
      ))
    ]
  ]
)[
  Draw a DFA over $ Sigma = {0, 1} $ that accepts the language:
  $ L = { w | w "has an even number of 0s" } $
]

// ------------------------------------------
// Case 5: 带有数学公式推导
// ------------------------------------------
#prob(
  title: "Subset Construction",
  solution: [
    Let $N = (Q_N, Sigma, Delta_N, q_0, F_N)$ be an NFA.
    We construct a DFA $M = (Q_D, Sigma, delta_D, {q_0}, F_D)$ where:
    
    1. $Q_D = cal(P)(Q_N)$ is the powerset of states.
    2. For a set of states $R in Q_D$ and input symbol $a in Sigma$:
       $ delta_D(R, a) = union_(r in R) Delta_N(r, a) $
    3. $F_D = {R in Q_D | R inter F_N != nothing }$
  ]
)[
  Prove that every NFA has an equivalent DFA using the subset construction algorithm.
]