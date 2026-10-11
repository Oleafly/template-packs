#import "../style/lib.typ": *
#show: appearance

#section[Khái niệm phương trình và hệ phương trình#linebreak() bậc nhất hai ẩn]

#subsection[Lý thuyết]

#subsubsection[Phương trình bậc nhất hai ẩn]

#dn(tieude: "Phương trình bậc nhất hai ẩn")[
  #itemize()[
    - _Phương trình bậc nhất hai ẩn $x$ và $y$_ là hệ thức dạng $ a x + b y = c, quad (1) $ trong đó $a$, $b$ và $c$ là các số đã biết ($a != 0$ hoặc $b != 0$).
    - Nếu tại $x = x_0$ và $y = y_0$ ta có $a x_0 + b y_0 = c$ là một khẳng định đúng thì cặp số $(x_0; y_0)$ được gọi là một _nghiệm_ của phương trình (1).
  ]
]

#vd[
  #listEX()[
    + Trong các hệ thức $4x + 3y = 5$; $0x + y = -1$; $0x + 0y = 3$, hệ thức nào là phương trình bậc nhất hai ẩn? Hệ thức nào không là phương trình bậc nhất hai ẩn?
    + Trong các cặp số $(2; -1)$ và $(1; 0)$, cặp số nào là nghiệm của phương trình $4x + 3y = 5$?
  ]
  #loigiai()[
    #listEX()[
      + Cả ba hệ thức đều có dạng $a x + b y = c$.\
        Nhưng chỉ có hai hệ thức $4x + 3y = 5$ và $0x + y = -1$ thỏa mãn điều kiện $a != 0$ hoặc $b != 0$ nên là phương trình bậc nhất hai ẩn.\
        Hệ thức $0x + 0y = 3$ có $a = b = 0$, không thỏa mãn điều kiện trên nên hệ thức đó không phải là phương trình bậc nhất hai ẩn.
      + Cặp số $(2; -1)$ là một nghiệm của phương trình $4x + 3y = 5$, vì
        $ 4 dot 2 + 3 dot (-1) = 5. $
        Cặp số $(1; 0)$ _không_ là nghiệm của phương trình $4x + 3y = 5$, vì
        $ 4 dot 1 + 3 dot 0 = 4 != 5. $
    ]
  ]
]

#pagebreak()

#vd()[
  Giả sử $(x; y)$ là nghiệm của phương trình bậc nhất hai ẩn $x + 2y = 5$.
  #listEX()[
    + Hoàn thành bảng sau đây:
      #block(breakable: false, width: 100%)[
        #align(center)[
          #table(
            columns: (auto, auto, auto, auto, auto, auto),
            stroke: 0.5pt + black,
            align: center + horizon,
            [$x$], [$-2$], [$-1$], [$0$], [?], [?],
            [$y$], [?], [?], [?], [$1$], [$2$],
          )
        ]
      ]
      Từ đó suy ra 5 nghiệm của phương trình đã cho.
    + Biểu diễn $y$ theo $x$. Từ đó cho biết phương trình đã cho có bao nhiêu nghiệm?
  ]
  #loigiai()[
    #listEX()[
      + Ta có:
        #block(breakable: false, width: 100%)[
          #align(center)[
            #table(
              columns: (auto, auto, auto, auto, auto, auto),
              stroke: 0.5pt + black,
              align: center + horizon,
              [$x$], [$-2$], [$-1$], [$0$], [$3$], [$1$],
              [$y$], [$7/2$], [3], [$5/2$], [$1$], [$2$],
            )
          ]
        ]
      + Ta có $(5 - x)/2$. Với mỗi giá trị $x$ tùy ý cho trước, ta luôn tìm được một giá trị $y$ tương ứng. Do đó phương trình đã cho có vô số nghiệm.
    ]
  ]
]

#vd()[
  Viết nghiệm và biểu diễn hình học tất cả các nghiệm của mỗi phương trình bậc nhất hai ẩn sau:
  #listEX()[
    + $x + 2y = 3$;
    + $0x + y = -2$;
    + $x + 0y = 3$.
  ]
  #loigiai()[
    #listEX[
      + Xét phương trình $x + 2y = 3 quad (1)$\
        Ta viết (1) dưới dạng $y = -0,5x + 1,5$. Mỗi cặp số $(x; -0,5x + 1,5)$ với $x in RR$ tuỳ ý, là một nghiệm của (1). Khi đó ta nói phương trình (1) có nghiệm (tổng quát) là:
        $ (x; -0,5x + 1,5) " với " x in RR " tuỳ ý." $
        #align(center)[
          #import "@preview/cetz:0.5.2": *
          #set text(size: 10pt)
          #canvas(length: 1cm, {
            import draw: *
            // Trục tọa độ Oxy
            line((-1.5, 0), (5, 0), mark: (end: ">", fill: black))
            line((0, -1), (0, 3), mark: (end: ">", fill: black))
            content((0, 0), anchor: "north-east", padding: 5pt, [$O$])
            content((5, 0), anchor: "south-east", padding: 5pt, [$x$])
            content((0, 3), anchor: "north-west", padding: 5pt, [$y$])
            // Đường thẳng d
            line((-1.5, 2.25), (5, -1), stroke: (paint: blue))
            content((5, -1), anchor: "south", padding: 5pt, [$d$])
            // Vẽ điểm và nhãn
            fill(black)
            circle((-1, 2), radius: 1.5pt)
            content((-1, 2), anchor: "south-west", padding: 5pt, [$N$])
            circle((0, 1.5), radius: 1.5pt)
            content((0, 1.5), anchor: "north-east", padding: 5pt, [$A$])
            content((0, 1.5), anchor: "west", padding: 5pt, [$1,5$])
            circle((3, 0), radius: 1.5pt)
            content((3, 0), anchor: "south-west", padding: 5pt, [$B$])
            content((3, 0), anchor: "north", padding: 5pt, [$3$])
            // Vẽ gạch đứt
            line((-1, 2), (-1, 0), stroke: (dash: (5pt, 5pt)))
            content((-1, 0), anchor: "north", padding: 5pt, [$-1$])
            line((-1, 2), (0, 2), stroke: (dash: (5pt, 5pt)))
            content((0, 2), anchor: "west", padding: 5pt, [$2$])
          })
        ]
        Mỗi nghiệm này là toạ độ của một điểm thuộc đường thẳng $y = -0,5x + 1,5$. Ta cũng gọi đường thẳng này là đường thẳng $d: x + 2y = 3$.\
        Để vẽ đường thẳng $d$, ta chỉ cần xác định hai điểm tuỳ ý của nó, chẳng hạn $A(0; 1,5)$ và $B(3; 0)$ rồi vẽ đường thẳng đi qua hai điểm đó.
      + Xét phương trình $0x + y = -2 quad (2)$.\
        Ta viết gọn (2) thành $y = -2$. Phương trình (2) có nghiệm là $(x; -2)$ với $x in RR$ tuỳ ý.\
        Mỗi nghiệm này là toạ độ của một điểm thuộc đường thẳng song song với trục hoành và cắt trục tung tại điểm $(0; -2)$. Ta gọi đó là đường thẳng $y = -2$.\
        #align(center)[
          #import "@preview/cetz:0.5.2": *
          #set text(size: 10pt)
          #canvas(length: 0.9cm, {
            import draw: *
            // Thiết lập font chữ chung
            set-style(font: "sans", size: 8pt)
            // Trục tọa độ
            line((-4, 0), (4, 0), mark: (end: ">", fill: black))
            content((4, 0), anchor: "south-east", padding: 5pt, [$x$])
            line((0, -3.5), (0, 1.5), mark: (end: ">", fill: black))
            content((0, 1.5), anchor: "north-west", padding: 5pt, [$y$])
            content((0, 0), anchor: "north-east", padding: 5pt, [$O$])
            // Các vạch số trên trục Ox
            for x in (-3, -2, -1, 1, 2, 3) {
              line((x, 0.1), (x, -0.1))
              content((x, -0.1), anchor: "north", padding: 5pt, str(x))
            }
            // Các vạch số trên trục Oy
            for y in (-1, -2, -3) {
              line((0.1, y), (-0.1, y))
              content((-0.1, y), anchor: "east", padding: 5pt, str(y))
            }
            // Vẽ đường thẳng y = -2 (blue, dày hơn)
            line((-4, -2), (4, -2), stroke: (paint: blue, thickness: 1.5pt))
            content((-2.4, -2), anchor: "south", padding: 5pt, [$y = -2$])
            // Vẽ điểm A
            circle((0, -2), radius: 0.07, fill: black)
            content((0, -2), anchor: "south-west", padding: 5pt, [$A$])
          })
        ]
      + Xét phương trình $x + 0y = 3 quad (3)$.\
        Ta viết gọn (3) thành $x = 3$. Phương trình (3) có nghiệm là $(3; y)$ với $y in RR$ tuỳ ý.\
        Mỗi nghiệm này là toạ độ của một điểm thuộc đường thẳng song song với trục tung và cắt trục hoành tại điểm $(3; 0)$. Ta gọi đó là đường thẳng $x = 3$.
        #align(center)[
          #import "@preview/cetz:0.5.2": *
          #set text(size: 10pt)
          #canvas(length: 0.85cm, {
            import draw: *
            // Thiết lập font chữ chung
            set-style(font: "sans", size: 8pt)
            // Trục tọa độ
            line((-2.5, 0), (6, 0), mark: (end: ">", fill: black))
            content((6, 0), anchor: "south-east", padding: 5pt, [$x$])
            line((0, -2.5), (0, 3), mark: (end: ">", fill: black))
            content((0, 3), anchor: "north-west", padding: 5pt, [$y$])
            content((0, 0), anchor: "north-east", padding: 5pt, [$O$])
            // Các vạch số trên trục Ox
            for x in (-2, -1, 1, 2, 3, 4, 5) {
              line((x, 0.1), (x, -0.1))
              // Căn chỉnh đặc biệt cho số 3 để tránh đè lên điểm B
              let pos = if x == 3 { "north-west" } else { "north" }
              content((x, -0.1), anchor: pos, padding: 5pt, str(x))
            }
            // Các vạch số trên trục Oy
            for y in (-2, -1, 1, 2) {
              line((0.1, y), (-0.1, y))
              content((-0.1, y), anchor: "east", padding: 5pt, str(y))
            }
            // Vẽ đường thẳng x = 3 (blue, dày hơn)
            line((3, -2.5), (3, 3), stroke: (paint: blue, thickness: 1.5pt))
            content((3, -2.5), anchor: "south-west", padding: 5pt, [$x = 3$])
            // Vẽ điểm B
            circle((3, 0), radius: 0.07, fill: black)
            content((3, 0), anchor: "south-west", padding: 5pt, [$B$])
          })
        ]
    ]
  ]
]

#subsubsection()[Hệ hai phương trình bậc nhất hai ẩn]

#dn(tieude: "Hệ hai phương trình bậc nhất hai ẩn")[
  #itemize()[
    - Một cặp gồm hai phương trình bậc nhất hai ẩn $a x + b y = c$ và $a' x + b' y = c'$ được gọi là một _hệ hai phương trình bậc nhất hai ẩn_. Ta thường viết hệ phương trình đó dưới dạng:
      $ heva(a x + b y = c, a' x + b' y = c'.) quad (*) $
    - Mỗi cặp số $(x_0; y_0)$ được gọi là một _nghiệm_ của hệ $(*)$ nếu nó đồng thời là nghiệm của cả hai phương trình của hệ $(*)$.
  ]
]

#vd()[
  Trong các hệ phương trình sau, hệ nào _không_ phải là hệ hai phương trình bậc nhất hai ẩn? Vì sao?
  #set enum(spacing: 1.5em)
  #listEX[
    + $heva(2x = -6, 5x + frac(4, 3) y = 1";")$
    + $heva(x + 2y = -3, 0x + 0y = 1";")$
    + $heva(23x - y = 1, x + y = 3.)$
  ]
  #loigiai()[
    Hệ phương trình b) không phải là hệ hai phương trình bậc nhất hai ẩn, vì phương trình thứ hai của hệ là $0x + 0y = 1$ không phải là phương trình bậc nhất hai ẩn.
  ]
]

#vd()[
  Giải thích tại sao cặp số $(1; 2)$ là một nghiệm của hệ phương trình $heva(2x-y=0, x+y=3)$.
  #loigiai()[
    Ta thấy khi $x = 1$ và $y = 2$ thì:\
    $2x - y = 2 dot 1 - 2 = 0$ nên $(1; 2)$ là nghiệm của phương trình thứ nhất;\
    $x + y = 1 + 2 = 3$ nên $(1; 2)$ là nghiệm của phương trình thứ hai.\
    Vậy $(1; 2)$ là nghiệm chung của hai phương trình, nghĩa là $(1; 2)$ là một nghiệm của hệ phương trình đã cho.
  ]
]

#luuy()[
  #immini()[
    Trong Ví dụ 5, cặp số $(1; 2)$ là nghiệm của hệ phương trình đã cho có nghĩa là điểm $M(1; 2)$ vừa thuộc đường thẳng $d_1 : 2x - y = 0$, vừa thuộc đường thẳng $d_2 : x + y = 3$. Vậy $M$ là giao điểm của hai đường thẳng $d_1$ và $d_2$ trong hình sau.
  ][
    #import "@preview/cetz:0.5.2": *
    #set text(size: 10pt)
    #canvas(length: 0.8cm, {
      import draw: *
      set-style(font: "sans", size: 8pt)
      // Trục tọa độ
      line((-1.5, 0), (4.5, 0), mark: (end: ">", fill: black))
      content((4.5, 0), anchor: "north-east", padding: 5pt, [$x$])
      line((0, -1.5), (0, 4.5), mark: (end: ">", fill: black))
      content((0, 4.5), anchor: "north-east", padding: 5pt, [$y$])
      // Các vạch số
      for i in (-1, 1, 2, 3) {
        line((i, 0.1), (i, -0.1))
        content((i, -0.1), anchor: "north", padding: 2pt, str(i))
        line((0.1, i), (-0.1, i))
        content((-0.1, i), anchor: "east", padding: 2pt, str(i))
      }
      // Vẽ đường thẳng 2x - y = 0 (y = 2x)
      // Miền vẽ từ x=-0.6 đến 2.1
      line((-0.6, -1.2), (2.1, 4.2), stroke: (paint: blue, thickness: 1.5pt))
      content((1.2, 2.4), anchor: "south-west", angle: 63.4deg, padding: 5pt, [$2x - y = 0$])
      // Vẽ đường thẳng x + y = 3 (y = 3 - x)
      // Miền vẽ từ x=-1.2 đến 4
      line((-1.2, 4.2), (4, -1), stroke: (paint: blue, thickness: 1.5pt))
      content((3.5, 0.5), anchor: "north-east", angle: -45deg, padding: 5pt, [$x + y = 3$])
      // Đường gióng và điểm M
      line((1, 0), (1, 2), stroke: (dash: "dashed"))
      line((1, 2), (0, 2), stroke: (dash: "dashed"))
      circle((1, 2), radius: 1.5pt, fill: black)
      content((1, 2), anchor: "west", padding: 5pt, [$M$])
    })
  ]
]

#subsection[Bài tập áp dụng]

#bt()[
  Viết nghiệm và biểu diễn hình học tất cả các nghiệm của mỗi phương trình bậc nhất hai ẩn sau:
  #listEX()[
    + $2x - 3y = 5$;
    + $0x + y = 3$;
    + $x + 0y = -2$.
  ]
  #loigiai()[
    #dotlineEX(25)
  ]
]

#bt()[
  Trong hai cặp số $(0;-2)$ và $(2;-1)$, cặp số nào là nghiệm của hệ phương trình $heva(x-2y=4, 4x+3y=5?)$
  #loigiai()[
    #dotlineEX(10)
  ]
]

#bt[
  #immini()[
    Xét bài toán cổ sau:
    #align(center)[
      Quýt, cam mười bảy quả tươi\
      Đem chia cho một trăm người cùng vui.\
      Chia ba mỗi quả quýt rồi,\
      Còn cam, mỗi quả chia mười vừa xinh.\
      Trăm người, trăm miếng ngọt lành.\
      Quýt, cam mỗi loại tính rành là bao?
    ]
  ][
    #image(width: 8cm, "../imgs/9D1-1-cam-quyt.png")
  ]
  Gọi $x$ là số cam, $y$ là số quýt cần tính ($x, y in NN^*$), ta có hệ phương trình bậc nhất hai ẩn sau:
  $ heva(x+y=17, 10x+3y=100.) $
  Trong hai cặp số $(10; 7)$ và $(7; 10)$, cặp số nào là nghiệm của hệ phương trình trên? Từ đó cho biết một phương án về số cam và số quýt thoả mãn yêu cầu của bài toán cổ.
  #loigiai()[
    #dotlineEX(5)
  ]
]

#subsection()[Bài tập rèn luyện]

#btrl[
  Xác định các hệ số $a$, $b$, $c$ của mỗi phương trình bậc nhất hai ẩn sau:
  #listEX()[
    + $2x-y=-4$;
    + $sqrt(2)x-3y=0$;
    + $0x-frac(3, 4)y=-7$;
    + $-frac(3, 2)+0y=-2,5$;
    + $-frac(2, 3)x+4y=2$;
    + $0x-frac(5, 2)y=0$;
    + $10x-0y=5$;
    + $-3x+4y=-6$.
  ]
  #loigiai()[
    Hướng dẫn giải....
  ]
]

#btrl()[
  Trong các cặp số $(-2;1)$, $(0;2)$, $(-1;0)$, $(1,5;3)$ và $(4;-3)$, cặp số nào là nghiệm của phương trình?
  #listEX()[
    + $5x-4y=8$;
    + $3x+5y=-3$.
  ]
  #loigiai()[
    Hướng dẫn giải....
  ]
]

#btrl()[
  Cho phương trình $2x+y=3$. (1)
  #listEX()[
    + Trong ba cặp số $(1;1)$, $(-2;7)$ và $(2;-7)$, cặp số nào là nghiệm của phương trình (1)?
    + Tìm $y_0$ để cặp số $(-1;y_0)$ là nghiệm của phương trình (1).
    + Tìm $x_0$ để cặp số $(x_0;-3)$ là nghiệm của phương trình (1).
    + Tìm thêm hai nghiệm của phương trình (1).
    + Hãy biểu diễn tất cả các nghiệm của phương trình (1) trên mặt phẳng $O x y$.
  ]
  #loigiai()[
    Hướng dẫn giải....
  ]
]

#btrl()[
  Cho phương trình $5x-2y=-1$. (2)
  #listEX()[
    + Trong ba cặp số $(1;3)$, $(2;5)$ và $(-3;7)$, cặp số nào là nghiệm của phương trình (2)?
    + Tìm $y_0$ để cặp số $(3;y_0)$ là nghiệm của phương trình (2).
    + Tìm $x_0$ để cặp số $(x_0;-2)$ là nghiệm của phương trình (2).
    + Tìm thêm hai nghiệm của phương trình (2).
    + Hãy biểu diễn tất cả các nghiệm của phương trình (2) trên mặt phẳng $O x y$.
  ]
  #loigiai()[
    Hướng dẫn giải....
  ]
]

#btrl()[
  Trong các hệ phương trình sau, hệ phương trình nào là hệ hai phương trình bậc nhất hai ẩn?
  #listEX()[
    + $heva(-2x+y=0, 3x-y=-5)$;
    + $heva(sqrt(2)x+0y=-2, 0x-frac(3, 5)y=6)$;
    + $heva(0x+0y=-3, 2x+3y=-2)$;
    + $heva(3x+2y=-5, 0x+0y=3)$;
    + $heva(0x+sqrt(5)y=5, x-frac(5, 4)y=15)$;
    + $heva(x-2y=7, 3x+4y=-9)$.
  ]
  #loigiai()[
    Hướng dẫn giải....
  ]
]

#btrl()[
  Cho hệ phương trình $heva(-2x+7y=12, 5x-y=3)$. \
  Trong hai cặp số $(-6;0)$ và $(1;2)$, cặp số nào là nghiệm của hệ phương trình đã cho?
  #loigiai()[
    Hướng dẫn giải....
  ]
]

#btrl()[
  Cho hệ phương trình $heva(3x-2y=-4, -x+2y=8)$. \
  Trong hai cặp số $(2;5)$ và $(0;2)$, cặp số nào là nghiệm của hệ phương trình đã cho?
  #loigiai()[
    Hướng dẫn giải....
  ]
]

#btrl()[
  Trong các phương trình sau, phương trình nào là phương trình bậc nhất hai ẩn? Xác định các hệ số $a$, $b$, $c$ của mỗi phương trình bậc nhất hai ẩn đó.
  #listEX()[
    + $-3x+4y=-9$;
    + $0x-0y=4$;
    + $0x-frac(5, 3)y=6$;
    + $0,4+0y=-2,5$;
    + $0x+7y=-21$;
    + $0x+0y=13$;
    + $-5x+0y=8$;
    + $0,6x-0y=-7,4$;
    + $frac(2, 3)x+3y=-frac(5, 2)$.
  ]
  #loigiai()[
    Hướng dẫn giải....
  ]
]

#btrl()[
  Trong các cặp số $(1;-4)$, $(2;-3)$, $(3;0)$, cặp số nào là nghiệm của mỗi phương trình sau
  #listEX()[
    + $2x+3y=-5$;
    + $5x-4y=15$;
    + $-2x+5y=-22$;
    + $x-5y=-12$.
  ]
  #loigiai()[
    Hướng dẫn giải....
  ]
]

#btrl()[
  Hãy biểu diễn tất cả các nghiệm của mỗi phương trình sau trên mặt phẳng $O x y$.
  #listEX()[
    + $x+y=-2$;
    + $0x-y=4$;
    + $-2x+0y=4$;
    + $2x+y=0$.
  ]
  #loigiai()[
    Hướng dẫn giải....
  ]
]

#btrl()[
  Cho hệ phương trình $heva(3x-y=17, x+4y=-3)$. Cặp số nào dưới đây là nghiệm của hệ phương trình đã cho?
  #listEX()[
    + $(5;-5)$;
    + $(5;-2)$;
    + $(1;-1)$;
    + $(6;1)$.
  ]
  #loigiai()[
    Hướng dẫn giải....
  ]
]

#btrl()[
  Cho hai đường thẳng $y=3x-2$ và $y=x+2$.
  #listEX()[
    + Vẽ hai đường thẳng đó trên cùng một hệ toạ độ.
    + Xác định toạ độ giao điểm $K$ của hai đường thẳng trên.
    + Toạ độ của điểm $K$ có là nghiệm của hệ phương trình $heva(3x-y=-2, -x+y=2)$ không? Tại sao?
  ]
  #loigiai()[
    Hướng dẫn giải....
  ]
]

#btrl()[
  Cho hai đường thẳng $y=frac(1, 2)x$ và $y=-x+3$.
  #listEX()[
    + Vẽ hai đường thẳng đó trên cùng một hệ toạ độ.
    + Xác định toạ độ giao điểm $M$ của hai đường thẳng trên.
    + Toạ độ của điểm $M$ có là nghiệm của hệ phương trình $heva(x-2y=0, x+y=3)$ không? Tại sao?
  ]
  #loigiai()[
    Hướng dẫn giải....
  ]
]


#subsection()[Câu hỏi trắc nghiệm]

#BatDauLuuDapAn("9D1-1-Tracnghiem")
#ex()[
  Phương trình nào sau đây KHÔNG là phương trình bậc nhất hai ẩn?
  #choice(
    [$x - 2y = 5$],
    [$0x + 0y = -3$],
    [$6x + 0y = 1$],
    [$0x - 4y = 3$],
    dapan: "B",
  )
  #loigiai()[
    Hướng dẫn giải....
  ]
]

#ex()[
  Phương trình $3x + y = -2$ có nghiệm là cặp số nào sau đây?
  #choice(
    [$(1; -5)$],
    [$(-1; -1)$],
    [$(0; 2)$],
    [$(2; 4)$],
    dapan: "A",
  )
  #loigiai()[
    Hướng dẫn giải....
  ]
]

#ex()[
  Phương trình nào sau đây nhận cặp số $(-2; 3)$ làm nghiệm?
  #choice(
    [$2x + 3y = -5$],
    [$2x - 3y = 5$],
    [$-2x + 3y = 5$],
    [$2x + 3y = 5$],
    dapan: "D",
  )
  #loigiai()[
    Hướng dẫn giải....
  ]
]

#ex()[
  Nghiệm tổng quát của phương trình bậc nhất hai ẩn $5x - 2y = 4$ là
  #choice(
    [$(x; frac(5, 2)x + 2)$ với $x in RR$],
    [$(x; frac(-5, 2)x + 2)$ với $x in RR$],
    [$(x; frac(5, 2)x - 2)$ với $x in RR$],
    [$(x; frac(-5, 2)x - 2)$ với $x in RR$],
    dapan: "C",
  )
  #loigiai()[
    Hướng dẫn giải....
  ]
]

#ex()[
  Cặp số nào sau đây là nghiệm của hệ phương trình $heva(3x+y=3, 2x+5y=-11)$?
  #choice(
    [$(-2; -3)$],
    [$(-2; 3)$],
    [$(2; -3)$],
    [$(2; 3)$],
    dapan: "C",
  )
  #loigiai()[
    Hướng dẫn giải....
  ]
]

#ex()[
  Cặp số $(frac(1, 2); 4)$ là nghiệm của hệ phương trình nào sau đây?
  #choice(
    [$heva(2x-y=-3, 6x-3y=15)$],
    [$heva(2x-y=-3, 6x+3y=15)$],
    [$heva(2x+y=-3, 6x+3y=15)$],
    [$heva(-2x+y=-3, 6x+3y=15)$],
    dapan: "D",
  )
  #loigiai()[
    Hướng dẫn giải....
  ]
]

#ex()[
  Phát biểu nào sau đây là đúng/sai?
  #choiceTF(
    [$(frac(1, 2); 4)$ là nghiệm của hệ phương trình $heva(2x-y=-3, 6x-3y=15)$],
    [$(frac(1, 2); 4)$ là nghiệm của hệ phương trình $heva(2x-y=-3, 6x+3y=15)$],
    [$(frac(1, 2); 4)$ là nghiệm của hệ phương trình $heva(2x+y=-3, 6x+3y=15)$],
    [$(frac(1, 2); 4)$ là nghiệm của hệ phương trình $heva(-2x+y=-3, 6x+3y=15)$],
    dapan: "S, S, S, Đ",
    kieu: "t",
  )
  #loigiai[
    Hướng dẫn giải....
    #itemchoice[
      + Giải thích ý a)...
      + Giải thích ý b)...
      + Giải thích ý c)..
      + Giải thích ý d)..
    ]
  ]
]

#ex()[
  Hệ phương trình $heva(2x+3y=3, 2x+3y=-1)$ có nghiệm là $(frac(a, b);frac(c, d))$, trong đó $frac(a, b)$ và $frac(b, c)$ là các phân số tối giản. Khi đó số tự nhiên $overline(a b c d)$ là số nào?
  #shortans("1234", kieu: "oly")
  #loigiai()[
    Hướng dẫn giải....
  ]
]

#KetThucLuuDapAn("9D1-1-Tracnghiem")

#pagebreak()
#v(1fr)
#align(center)[
  *BẢNG ĐÁP ÁN TRẮC NGHIỆM*
]

#XuatDapAn("9D1-1-Tracnghiem", socot: 6, duongthang: 1pt + blue, maunen: blue.lighten(95%))
