
#import "@preview/touying:0.6.2": *
#import "@preview/curryst:0.6.0" as curryst: rule
#import "@preview/mitex:0.2.6": *
#import "theme.typ": *
#import "custom-outline.typ": custom-outline
#import "@preview/tablem:0.3.0": tablem, three-line-table
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
// #import "color-themes.typ":theme-elegant-green

// ============================================================================
// 演示信息配置 / Presentation Info Configuration
// ============================================================================

#let presentation-info = (
  title: [农民的力量],
  subtitle: [],
  author: [Author1 et al.],
  authors: [
    #text(weight: "bold")[Author1，Author2]
  ],
  date: [2026.1.1],
  institution: [中国科学院大学考古学与人类学系 \ 中国科学院古脊椎动物与古人类研究所],
  logo: image("assets/vi/UCAS/中国科学院院徽.png"),
  logo1: image("assets/vi/UCAS/中国科学院院徽.png"),
)

// ============================================================================
// 应用主题 / Apply Theme
// ============================================================================

#show: university-theme.with(
  // colors: theme-elegant-green,
  config-info(..presentation-info),
)
#show math.equation: set text(
  // font: (
  //   "Times New Roman", // 数学
  //   "Source Han Serif SC", // 中文
  // ),
  weight: "bold",
)
#show quote: set pad(x: 0em)
#show quote.where(block: false): it => {
  ["] + h(0pt, weak: true) + it.body + h(0pt, weak: true) + ["]
  if it.attribution != none [ (#it.attribution)]
}
// ============================================================================
// 自定义函数 / Custom Functions
// ============================================================================

// 高亮文本函数(使用主题默认样式)
#let highlight = text.with(
  ..default-text-styles.highlight,
  fill: default-color-palette.primary,
  font: default-fonts.serif,
  weight: "black",
  size: 24pt,
)

// ============================================================================
// 演示内容 / Presentation Content
// ============================================================================

// 标题页
#title-slide()

// 目录页
#empty-slide()[
  #set text(..default-text-styles.outline)
  #show outline.entry.where(
    level: 1,
  ): set block(above: default-layout-config.outline-block-above)
  #set align(center + horizon)
  #place(
    top + left,
    image("assets/vi/UCAS/国科大标准Logo横式一（白色）.png", height: default-layout-config.logo-height),
  )
  #grid(
    columns: (1fr, 1.5fr),
    gutter: default-layout-config.grid-gutter,
  )[
    #align(center + horizon)[
      #text(size: 60pt)[目录]
    ]
  ][
    #custom-outline(
      depth: 1,
      title: none,
    )
  ]
]
= 故事背景
#slide(composer: (1fr, 1.5fr))[
  - 少年时在蒙大拿农场打工，与一位黑脚族印第安人利瓦伊共事 
  - 利瓦伊在酒后咒骂来自瑞士的白人农民赫尔希："该死的船把你从瑞士运来！"
  - 这让他意识到：自己从小被灌输的"欧洲人英勇征服西部"的英雄行径的叙事，在印第安人视角里却是土地被夺，社会被摧毁的灾难史
  #highlight()[白人农民到底是如何胜过以骁勇善战著称印第安战士的？]
][
  #img("assets/image-30.png", width: 18cm)
]
= 核心观点
#slide(composer: 100%, composer-r: 2)[
  #highlight()["食物生产对枪炮，病菌和钢铁的发展而言，是间接的前提条件"]
  - 人类社会的大部分历史都以狩猎采集为生，在约1.1万年前才开始在部分地区转向农牧(作物种植＋动物驯化). 农业在西亚，中美洲和东亚几乎同时独立出现
  - 这种转变发生的时间和方式的差异，造成了不同大陆族群命运的根本差异
  #v(5pt, weak: true)
  #img("assets/image-31.png", caption: [农业起源中心示意图 @LiXiaoQiangNongYeDeQiYuanChuanBoYuYingXiang2022], width: 19cm)
]
= 分析原因
== 第一性原理：越多的卡路里，越多的人
#slide(composer: 100%)[
  #img("assets/image-32.png", width: 14cm)
][
  - 人类选择可以食用的动植物加以培育，集中种植和圈养
  - 从单位面积土地上获取比狩猎采集更多的卡路里
  - 可养活更多的农牧人口
  - 农业族群获得第一种军事优势：在*人数*上超越狩猎采集族群
]
== 家畜的多重价值
#slide()[
  - 驯化的动物在四个方面进一步增加了粮食供应和人口
    - 肉食：提供稳定的动物蛋白来源
    - 奶制品：提供比肉类更多的卡路里
    - 肥料：动物粪便能极大地提高农作物的产量
    - 畜力：大型驯化动物(如牛，马)能拉犁，能够开垦以前无法耕种的土地，从而扩大耕种面积
][
  #img("assets/image-33.png", width: 14cm)
]
== 农业生产带来定居生活
#slide(composer-r: 100%, composer: (1fr, 1.5fr))[
  - 缩短生育间隔
    - 狩猎采集生活需四处迁徙，无法同时照顾多个幼儿，生育间隔较大
    - 定居生活将生育间隔缩短至2年，提高人口出生率
  - 粮食储存
    - 狩猎采集社会很难长期保存大量食物，一般没有长期余粮
    - 定居使储存剩余粮食成为可能
][
  #img("assets/image-34.png", caption: [西班牙拉文特岩画中的狩猎场景(中石器时代)], width: 17cm)
]
== 社会分工与复杂政治组织
#slide(composer: (1fr, 1.1fr))[
  - 国王与官僚
    - 控制余粮，税收，形成酋邦，王国
    - 复杂的社会组织比平等的狩猎群体能更有效地发动持续征服战争
  - 职业士兵
    - 余粮供养军队，是不列颠帝国最后能击败武器精良的毛利人的关键原因
  - 神职人员，工匠，文士
    - 推动宗教，技术和知识的积累，增强社会的组织力和战斗力
  #v(10pt, weak: true)
  #highlight()[剩余粮食储备可以养活不直接从事粮食生产的人，催生社会的专门化分工]
][
  #img("assets/image-35.png", width: 15cm)
]
== 动植物的非食用用途
#slide(composer: (1fr, 1.4fr))[
  - 人工制品的原材料
    - 动植物提供纤维(棉花，亚麻，羊毛)用于制作织物
    - 兽皮用于制革，兽骨用于制作工具
    - 栽培葫芦用作容器
  - 交通运输
    - 大型驯化哺乳动物(马，骆驼，驴，牛，驯鹿等)是铁路出现前最重要的陆路运输工具
    - 极大地加快人员和货物的流动速度，加强了远距离控制和管理的能力
][
  #img("assets/image-36.png", width: 16cm)
]
== 粮食生产对战争的贡献
#slide()[
  - "军事上的战车与坦克"
    - 早期印欧人的向西扩张，希克索斯人征服埃及，到匈奴人和蒙古人的横扫欧亚大陆，拥有骑兵或战车的一方有压倒性优势
    - 第3章提到，科尔特斯和皮萨罗凭借少量骑兵推翻了庞大的美洲帝国
    - 骆驼在沙漠地带也发挥了类似的军事作用
][
  - 致命的生物武器：病菌
    - 人类许多传染病(如天花，麻疹，流感)最初来自动物传染病病菌的突变种
    - 这些病菌最初由动物传给人类，在与驯养动物长期共处中，欧亚大陆人群逐步演化出了部分免疫力或抵抗力
    - 当携带病菌的人(如欧洲殖民者)与从未接触过这些病菌的美洲，大洋洲原住民接触时，引发流行病肆虐，导致大量原住民死亡
]
= 总结与思考
== 总结
#slide(composer: 100%)[
  - 动植物驯化 #sym.arrow.r.double 剩余粮食 #sym.arrow.r.double 人口稠密 + 定居生活 + 阶级社会(社会分工，政治集权，技术革新，运输能力提升) #sym.arrow.r.double 致命病菌
  - 终极因的假设：大陆轴线的方向可能是某个族群得以征服其他族群的终极因
  - 结论：欧亚大陆拥有适宜驯化的动植物物种，得以率先发展出粮食生产，并因此获得了枪炮，钢铁武器，高效的军事组织力和致命的病菌
  - 为什么是赫尔希代表的白人农民能够取代利瓦伊代表的狩猎采集社会
  #v(10pt, weak: true)
  // #img("assets/image-37.png", height: 14cm)
  #text(size: 18pt)[
    #diagram(
      spacing: 28pt,
      cell-size: (10mm, 10mm),
      edge-stroke: 2pt,
      edge-corner-radius: 0pt,
      mark-scale: 50%,
      // 节点
      node((5, 2), align(center)[近因], stroke: 0.5pt),
      node((-1, 2), align(center)[终极因], stroke: 0.5pt),
      node((0, 1), align(center)[可供驯养\ 的野生物种], stroke: 0.5pt),
      node((-1, 0.5), align(center)[东\ 西\ 向\ 陆\ 轴], stroke: 0.5pt),
      node((0, 0.1), align(center)[易于传播的\ 物种], stroke: 0.5pt),
      node((1, 0.5), align(center)[许多作物\ 及家畜], stroke: 0.5pt),
      node((2, 0.5), align(center)[粮食剩余\ 与储藏], stroke: 0.5pt),
      node((3, 0.5), align(center)[人口稠密,定居\ 的阶级化社会], stroke: 0.5pt),
      node((4, 1), align(center)[科技发展], stroke: 0.5pt),
      node((5, 1.5), align(center)[马,枪,刀剑], stroke: 0.5pt),
      node((5, 1), align(center)[海上船只], stroke: 0.5pt),
      node((5, 0.5), align(center)[政治结构\ 与文字], stroke: 0.5pt),
      node((5, 0), align(center)[病菌], stroke: 0.5pt),
      // 边（显式连接）
      edge(
        (-1, 2),
        (5, 2),
        "-|>",
        stroke: 3pt + default-color-palette.success,
        [*历史普遍模式背后的因素(终极因与直接原因的因果链)*],
      ),
      edge((0, 1), (0, 1.5), (5, 1.5), "-|>"),
      edge((0, 1), (1, 0.5), "-|>"),
      edge((-1, 0), (0, 0), "-|>"),
      edge((0, 0), (1, 0.5), "-|>"),
      edge((1, 0.5), (2, 0.5), "-|>"),
      edge((2, 0.5), (3, 0.5), "-|>"),
      edge((2, 0.5), (2, 0), (5, 0), "-|>"),
      edge((3, 0.5), (5, 0.5), "-|>"),
      edge((3, 0.5), (5, 0), "-|>", bend: -5deg),
      edge((3, 0.5), (4, 1), "-|>", bend: 10deg),
      edge((4, 1), (5, 1), "-|>"),
      edge((4, 1), (5, 1.5), "-|>", bend: 0deg),
      edge((4, 1), (3, 0.5), "--|>", bend: 20deg),
      edge(
        (-1.6, -0.4),
        (5.6, -0.4),
        (5.6, 2.4),
        (-1.6, 2.4),
        (-1.6, -0.4),
        stroke: 3pt + default-color-palette.primary,
      ),
    )]
]
== 思考

#slide(composer: 100%)[
  === 早期农业的另一面
  - 戴蒙德只解释了农业生产的优势
  - 李小强用考古证据印证了农业起源，传播及其对社会的影响，但也指出"农业转型其实存在一定的选择性，并非只有优势，早期农业种植也有一些不利的影响"
][
  #alternatives()[
    #img("assets/image-38.png", width: 20cm)
  ][
    #img("assets/image-39.png", width: 20cm)
  ][
    #img("assets/image-40.png", width: 20cm)
  ]
]

#slide()[
  === 地理环境决定论的问题
  - 戴蒙德的假设
    - 不同大陆的地理环境差异(可驯化动植物数量，轴线走向)决定了农业的起源与传播，进而决定了各文明的发展速度和最终命运
    - 地理环境是决定性因素
  - 相同环境，不同结果
    - 相同的地理环境下可以出现截然不同的社会文化，政治制度和发展水平
    - 朝鲜半岛南北部，爱尔兰岛上的英国与爱尔兰，其差异无法用地理环境解释，而应归因于历史背景，民族差异，制度选择和文化传统
  - 地理环境是重要的 "初始条件"，但绝非"决定性因素"
    - 社会发展的根本动力在于生产力与生产关系的矛盾运动，以及人的主观能动性
    - 戴蒙德的演化生态学忽视了生产方式，文化等因素在人类社会发展中的作用
]

#slide()[
  === 殖民，病菌与种族灭绝
  - 戴蒙德：病菌在殖民美洲大陆的过程中起了"决定性作用"
    - 1960年代, Henry Dobyns和Alfred Crosby重新估算美洲原住民人口，指出在殖民者到来前可能人数上亿，欧亚旧大陆流行病使原住民人口锐减90%以上
    - "99%的以前没有接触过这种病菌的人因之而丧命"
  - 处女地土壤论
    - 欧亚大陆因长期与家畜共存，演化出多种人传人疾病(天花，麻疹，腮腺炎)
    - 美洲原住民没有经历过这些疾病，缺乏*获得性免疫*(非基因缺陷)
    - 疾病如同"点燃的引信"，一旦引入便会引发毁灭性流行病，且在殖民者"面对面接触"之前就已广泛传播
  // #v(10pt, weak: true)
@edwardsGermsGenocidesAmericas2020
]
#slide()[
  - "细菌无意识"
    - 流行病使阿兹特克和印加帝国崩溃，为欧洲征服美洲铺平道路
    - 病菌没有意识，殖民者的暴力与冷酷只是*次要角色*
    - 既然“细菌才是主因”，且细菌“没有意图”，那么殖民者的责任便被大大稀释
    - Crosby的理论被广泛吸收，成为洗脱殖民历史，否定种族灭绝的重要理论
  - 种族灭绝论
    - 1990年代，在哥伦布“发现”美洲500周年之际
    - 一批学者开始将“种族灭绝”一词正式引入对美洲原住民历史的描述
    - 强调原住民人口减少的规模之巨，速度之快，堪称人类历史上最严重的人口灾难
    - 殖民者的暴力，奴役，强制迁徙和同化政策，与疾病形成了“相互交织，彼此加剧”的毁灭性合力
]
#slide()[
  - 反对"种族灭绝论"
    - 美国例外论者
      - 殖民虽然带来悲剧，但也传播了“民主，法治，个人尊严”的“伟大思想”
      - 绝大多数原住民死亡是由“中立”的细菌造成的，而非殖民者的有意为之
    - 大屠杀独特性论者
      - 部分犹太学者坚持，纳粹对犹太人的灭绝与美洲原住民的遭遇在性质上根本不同
      - 原住民是因“缺乏免疫力”而自然死亡，美国政府还曾为原住民提供疫苗接种和保留地保护
    - 主流历史学家
      - 批评种族灭绝论者为“煽动性写作”
      - 认为"种族灭绝论"混淆了“殖民主义的复杂性”与“种族灭绝”的界限
    - 均依赖于“细菌主导论”的叙事
]
#slide()[
  - 修正主义研究(近二十年)
    - 流行病并非“提前传播”，与殖民扩张同步
      - 许多地区直到17世纪甚至更晚才出现流行病，与殖民者深入，传教系统建立，奴隶贸易扩张吻合，没有证据支持 “1520年代天花已传遍北美” 的假设
      - 美国东北部的人口直到1630年代出现明显下降，东南部的天花大爆发发生在1690年代，与英属卡罗来纳的奴隶贸易同步
    - 殖民暴力推动了疾病传播
      - 疾病往往是“次要杀手”，殖民暴力与政策才是根本原因
      - 强制迁徙与人口集中，破坏生计与营养不良，社会结构瓦解，心理创伤与生育率下降
    - 原住民并非“被动无防御”
      - 在不受殖民暴力严重干扰的情况下，许多原住民群体能够有效应对疾病
      - 原住民的应对能力之所以失效，正是因为殖民暴力摧毁了这些机制
]
#slide()[
  - 对“处女地土壤论”的批判
    - “原住民缺乏免疫力” 的说法被严重夸大。所有人类都能对病原体产生免疫反应，不存在“免疫上毫无防御”的人群
    - “处女地土壤论” 将原住民描绘成“被动，脆弱的受害者”，暗含了一种生物学决定论，甚至带有隐性的种族主义色彩
    - 真正导致原住民高死亡率的是“贫困，社会压力，环境脆弱性”——而这些正是殖民行为直接造成的
  - 走出"二元对立"
    - 原住民的人口灾难不是“自然悲剧”，而是殖民主义系统性暴力的产物
    - 细菌在其中扮演了重要角色，但这一角色的发挥，始终是由殖民者的行为所塑造和放大的
]
= 参考文献
#slide(size: 18pt)[
#bibliography("cite.bib",style:"geoarchaeology.csl",title: none)

]
#focus-slide[
  #text(font: default-fonts.sans, weight: "bold")[感谢垂听!]
]

