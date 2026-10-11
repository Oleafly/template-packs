#import "@preview/i-figured:0.2.4"

#import "/configs.typ": font, fontsize
#import "/components.typ": paragraph, fp, rfp, hstack

#let number(..nums) = [
    #text(
        // 略微放大编号字体以适应 Word 中的视觉效果
        size: 1.05em,
        // 一级标题编号需要加粗
        weight: if nums.pos().len() == 1 { "bold" } else { "regular" } ,
        nums.pos().map(str).join(".") + " "
    )
]

#let main = paragraph[
    // 图表样式
    #show figure: i-figured.show-figure

    // 图下五号宋体加粗
    #show figure.where(kind: image): set text(size: fontsize.L5, weight: "bold")
    #show figure.where(kind: image): fig => [
        #show figure.caption: cap => pad(top: 0.5em, cap)
        #fig
    ]

    // 表上五号宋体加粗
    #show figure.where(kind: table): set figure.caption(position: top)
    #show figure.where(kind: table): set text(size: fontsize.L5, weight: "bold")

    // 重设代码框内的行距
    #show figure.where(kind: raw): set par(leading: 1em)

    // 代码框样式
    #show figure.where(kind: raw): fig => [
        #show figure.caption: cap => pad(top: 0.5em, cap)
        #fig
    ]

    // 三线表
    #show figure.where(kind: table): fig => [
        #show table: set table(stroke: (x, y) => if y == 0 { (bottom: 0.5pt) } else { none })
        #show table: tbl => [
            #v(-0.8em)
            #box(stroke: (top: 1pt, bottom: 1pt), tbl)
        ]
        #fig
    ]

    // 标题字号
    #show heading: set text(size: fontsize.L4s)
    #show heading.where(depth: 1): set text(size: fontsize.L3)

    // 标题字体
    #show heading: set text(font: font.sans, weight: "regular")

    // 处理逆天需求
    #set heading(numbering: number)

    #v(-4em)

    = 绪论

    == 中西文混排测试

    在「原神」的世界里，我们被带入了一个神秘而古老的大陆 —— Teyvat（提瓦特）。This is a world full of magic and wonders, 每一个角落都蕴藏着无尽的探索与冒险。

    在这个充满魔法的世界中，我们与各种各样的角色相遇。There are adventurers from different nations, 有些 wield extraordinary elemental abilities。而其他人则隐藏在阴影中。Their stories intertwine across the continent, 每一个人都有自己的故事与使命。

    在 Teyvat 大陆上，people are closely connected to the power of elements. 风、火、水、雷等元素在大陆上流动，塑造着丰富多彩的自然景观。The seven Archons, or gods, of Teyvat are the guardians of the continent, each wielding control over a different elemental power, maintaining balance and order in the world.

    #figure(caption: "示例图表")[
        // #let A = table.cell(fill: green.lighten(60%))[A]
        // #let B = table.cell(fill: aqua.lighten(60%))[B]

        #show table.cell: set text(weight: "regular")

        #table(
            columns: 4,
            [], [Exam 1], [Exam 2], [Exam 3],

            [John], [--], [A], [--],
            [Mary], [--], [A], [A],
            [Robert], [B], [A], [B],
        )
    ]

    #fp

    然而，在这个世界中，我们也可以感受到生活的美好与平静。From bustling cities to serene villages, 每一个地方都散发着独特的魅力。And our companions who accompany us are the true treasures of this world.

    However, Teyvat is not only about adventure and battle. In this world, 我们也可以体验到生活的美好与平静。无论是在忙碌的城市还是宁静的乡村，每一个地方都散发着独特的魅力。与我们相伴的 companions 是这个世界的真正 treasures。

    在这个充满奇迹的世界中，every adventure in life is worth cherishing. Whether it's exploring the unknown or sharing laughter with friends, every moment is a precious memory. 让我们抛开烦恼，let our spirits soar, and immerse ourselves in this world full of wonders！

    == 你说得对

    你说的对，但是《原神》是由米哈游自主研发的一款全新开放世界冒险游戏。游戏发生在一个被称作「提瓦特」的幻想世界，在这里，被神选中的人将被授予「神之眼」，导引元素之力‌​​​‌‌‌‌‌‌‌‌​​‌‌​‌‌‌​‌​。你将扮演一位名为「旅行者」的神秘角色，在自由的旅行中邂逅性格各异、能力独特的同伴们，和他们一起击败强敌，找回失散的亲人——同时，逐步发掘「原神」的真相。

    #figure(caption: "不是原神")[
        #image("/assets/images/example.jpg", width: 70%)
    ]

    = 高等元素论

    == 附着元素和触发元素
        
    游戏中的元素可以大体分为两种情况：

    *只存在一瞬的触发元素*：即触发反应的元素（包括反应破盾）。例如对一个附着水的目标上火会触发蒸发反应，此时火元素便为触发元素；*会持续存在的附着元素*：附着到目标身上可持续存在的元素即为附着元素

    #figure(caption: "玩舟玩的")[
        #hstack(
            image("/assets/images/figure-1.jpg", width: 25%),
            image("/assets/images/figure-2.jpg", width: 25%),
            image("/assets/images/figure-3.jpg", width: 25%),
        )
    ]

    #fp

    游戏中带有伤害的元素大多具有与角色对敌对单位施加元素相同的规律（称为伤害元素），即附着元素最多只具有约 80% 的最大元素量，伤害元素的最大元素量与最长附着时间符合公式关系。但对于角色自身附着（例如芭芭拉的水环给角色上水）和一些不带伤害的元素（例如海水），这些元素无论作为触发元素还是附着元素所可以拥有的最大元素量都为 100% 的最大元素量，且他们的最大元素量与最长附着时间之间无明显公式关系。

    == 元素量与消耗量

    元素量为元素本身所具有的且确切存在于游戏中的一种数值，是量化元素的必要工具。同种元素的反复叠加附着不存在反应，为附着元素间的元素量叠加覆盖。元素反应中，触发元素会消耗附着元素的元素量，我们称附着元素被消耗的元素量数值为反应消耗量，这一点对反应破盾的情况同样适用。“强度”不同的元素所对应的最长持续时间与最大元素量不同，最大元素量为元素作为触发元素时所具有的元素量，最长附着时间为元素作为附着元素所能单独存在的最长时间。
    
    = 结论

    玩原神玩的

    垫

    垫

    #v(-0.7em)

    == 换页测试

    #rfp

    壹

    贰

    叁

    肆

    伍

    在这个寂静的午后，阳光透过窗户洒在书桌上，一本书静静地躺在那里，等待着被翻阅。房间里弥漫着淡淡的咖啡香，仿佛时间在这一刻停滞了。窗外的风吹动着树叶，发出微弱的沙沙声，如同一首悠扬的小夜曲，轻柔地拂过耳畔。在这个宁静的时刻，心也变得安静下来，沉浸在这片宁静之中，享受着片刻的宁谧。

    #figure(caption: "跳板函数")[
        ```rust
        unsafe extern "C" fn trampoline() {
            asm!(
                "push {ra}",    // 1. backup return address
                "push 0",       // 2. keep stack aligned (*)
                "call {hook}",  // 3. call hook callback 
                "pop rax",      // 4. (*) skip
                "pop rax",      // 5. restore return address
                "jmp rax",      // 6. jump out!
                hook = sym hook,
                ra = in(reg) RETURN_ADDR,
                options(nostack)
            )
        }
        ```
    ]

    我超，引用了好多！
    @mao2001
    @mao2003
    @liu1979
    @mao2001ai
    @zhang1998
    @feng1997
    @jiang1983
    @gb1996
    @mao2000
    @wang1998
]
