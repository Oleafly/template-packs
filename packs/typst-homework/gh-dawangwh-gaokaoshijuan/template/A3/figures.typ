// Figures specific to this exam. Keep these out of the reusable template.

#let prism-figure = {
  // 设置画布大小
  box(width: 4.5cm, height: 4.0cm)[
    // 虚线部分：被遮挡或内部辅助线

    // 线段 AC：A -> C
    #place(dx: 0.9cm, dy: 3.4cm)[
      #line(angle: 333.5deg, length: 1.56cm, stroke: (dash: "dashed", thickness: 0.7pt))
    ]

    // 线段 CB：C -> B
    #place(dx: 2.3cm, dy: 2.7cm)[
      #line(angle: 26.5deg, length: 1.56cm, stroke: (dash: "dashed", thickness: 0.7pt))
    ]

    // 线段 CC1
    #place(dx: 2.3cm, dy: 2.7cm)[
      #line(angle: 270deg, length: 2.0cm, stroke: (dash: "dashed", thickness: 0.7pt))
    ]

        // 线段 DE：D -> E
    #place(dx: 2.3cm, dy: 3.4cm)[
      #line(angle: 242.6deg, length: 1.52cm, stroke: (dash: "dashed", thickness: 0.7pt))
    ]
    // 线段 DE
    #place(dx: 0.9cm, dy: 3.4cm)[
      #line(angle: 297.5deg, length: 1.52cm, stroke: (dash: "dashed", thickness: 0.7pt))
    ]

    // 线段 EC1：E -> C1
    #place(dx: 1.6cm, dy: 2.05cm)[
      #line(angle: 297.5deg, length: 1.52cm, stroke: (dash: "dashed", thickness: 0.7pt))
    ]

    // 实线部分：可见轮廓

    // 线段 AB
    #place(dx: 3.7cm, dy: 3.4cm)[
      #line(angle: 180deg, length: 2.8cm, stroke: 1pt)
    ]

    // 线段 AA1
    #place(dx: 3.7cm, dy: 3.4cm)[
      #line(angle: 270deg, length: 2.0cm, stroke: 1pt)
    ]

    // 线段 BB1
    #place(dx: 0.9cm, dy: 3.4cm)[
      #line(angle: 270deg, length: 2.0cm, stroke: 1pt)
    ]

    // 线段 A1B1
    #place(dx: 3.7cm, dy: 1.4cm)[
      #line(angle: 180deg, length: 2.8cm, stroke: 1pt)
    ]

    // 线段 A1C1
    #place(dx: 3.7cm, dy: 1.4cm)[
      #line(angle: 206.5deg, length: 1.56cm, stroke: 1pt)
    ]

    // 线段 B1C1
    #place(dx: 0.9cm, dy: 1.4cm)[
      #line(angle: 333.5deg, length: 1.56cm, stroke: 1pt)
    ]

    // 标签文字
    #place(dx: 3.7cm, dy: 3.5cm)[$B$]
    #place(dx: 0.6cm, dy: 3.5cm)[$A$]
        #place(dx: 1.45cm, dy: 2.0cm)[$E$]

    #place(dx: 3.7cm, dy: 1.2cm)[$B_1$]
    #place(dx: 0.6cm, dy: 1.2cm)[$A_1$]
    #place(dx: 2.2cm, dy: 0.55cm)[$C_1$]

    #place(dx: 2.2cm, dy: 3.65cm)[$D$]
  ]
}

#prism-figure
