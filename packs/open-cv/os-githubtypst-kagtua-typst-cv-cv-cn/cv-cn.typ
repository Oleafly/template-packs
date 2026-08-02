/* Global settings */

// #show link: underline
#set page(margin: (x: 1.5cm, y: 1.5cm))
#set par(
    leading: 0.8em,
    justify: true,
)
#set text(font: ("SimSong"), size: 11pt)


/* Functions */

#let h1(body) = {text(size: 17pt, font: "Songti SC", weight: "bold")[#body]}
#let h2(body) = {text(size: 13pt)[#body]}
#let h3(body) = {text(size: 11pt, font: "Songti SC", weight: "bold")[#body]}

#let small(body) = {text(size: 10pt)[#body]}
#let bold(body) = {text(font: "Songti SC", weight: "bold")[#body]}

#let xline() = {v(-8pt); line(length: 100%); v(-3pt)}

#let section-title(body) = {
    v(5pt)
    h2[#body]
    xline()
}

#let zsection(body) = { grid(columns: (10pt, 1fr))[][#par(leading: 0.75em)[#body]]; v(3pt) }


/* Content */

#h1[张三]
#v(-5pt)
12312341234 | zhangsan\@gmail.com | #link("https://github.com/zhangsan")[github.com/zhangsan]

#section-title[教育背景]


- #h3[中国山河大学] #h(1fr) 山东 河南 \
#v(-3pt)
#zsection[
计算机不科学（学士）#h(0.5cm)#small[绩点 0.4（200/250），多次荣获山河四省鼓励奖学金] #h(1fr) 2000/09 -- 2004/06 \
计算机很科学（硕士）#h(0.5cm)#small[一篇 CCF Z 类文章] #h(1fr) 2004/09 -- 2007/06 \
]

- #h3[中国社会大学] #h(1fr) 安徽 南京 \
#v(-3pt)
#h(0.3cm) 猫的流体力学研究（博士）#h(0.2cm)#small[获得 2023 搞笑诺贝尔奖] #h(1fr) 2007/09 -- 2010/06 \

#section-title[研究经历]

- #h3[咖啡因对创造力的影响] #h(1fr) 山河大学次时代研究所
#v(-4pt)
#zsection[我们进行了一项随机对照实验，探究了咖啡因对创造力的影响。通过给参与者不同剂量的咖啡因后进行创造性任务的评估，我们发现适量的咖啡因能够显著提升创造力水平，为理解咖啡因对认知功能的影响提供了实证支持。]

- #h3[猫咪的睡眠行为与梦境研究] #h(2fr) 山河大学白日梦研究所
#v(-4pt)
#zsection[在研究期间，我带领着一支勇敢的研究小组，深入探索了猫咪的睡眠行为与梦境之间的神秘联系，这项研究成果不仅能够让人们更好地照顾和理解自己的宠物，还有望为人类的睡眠障碍研究提供新的思路和启示。]

#section-title[实习经历]

#h3[快乐游戏有限公司] #h(1fr) 2010/07 -- 2013/10 \

- #bold[笑话筛选挑战]：负责阅读大量笑话并进行评估，只有笑出肚子痛的才能通过。每次笑出声都会有同事以"哈哈奖"激励，但副作用是喝水时总会喷出来。

- #bold[研发新奇笑话]：参与团队的创新项目，努力开发出新颖有趣的笑话。但有时候创意会突然消失，只能在办公室角落寻找，有时幸运会发现它藏在打印机里。


#section-title[开源项目]

#h3[笑话生成器] #h(0.3cm)#link("https://github.com/zhangsan/joker")[https://github.com/zhangsan/joker] \
- 设计并实现了笑话分类算法，确保笑话生成器能准确地将笑话分为爆笑、冷笑和微笑三个级别，让用户在笑料丰富的同时能得到适合自己口味的笑话。

#h3[智能梦境] #h(0.3cm)#link("https://github.com/zhangsan/joker")[https://github.com/zhangsan/intelli-dream] \
- 通过深度学习算法和神经网络模型，我们能够分析用户的睡眠模式和脑电波，为他们提供个性化的梦境刺激，让他们在梦中体验奇幻、创意和冒险的旅程。


#section-title[个人技能]

- 拖延症高手：我擅长将任务推迟到最后一刻，然后以惊人的速度完成
- 熬夜能手：我具备超凡的熬夜能力，可以在没有咖啡因的情况下保持精力充沛
- 键盘快手：我可以用一只手快速打字，而且从不看屏幕