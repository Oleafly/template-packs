// Shared component catalog for both formal canvas profiles.
// Keep all component demonstrations here so the standard and wide examples
// cannot drift apart as the public API evolves.

#import "../lib.typ" as brief

#let _swatch(label, color) = block(
  width: 100%,
  fill: white,
  stroke: 0.5pt + brief.colors.border,
  radius: brief.tokens.chip-radius,
  inset: 5pt,
)[
  #stack(
    dir: ttb,
    spacing: 4pt,
    rect(width: 100%, height: 0.42cm, fill: color, radius: 4pt),
    align(center, text(size: 5.8pt, fill: brief.colors.muted)[#label]),
  )
]

#let component-catalog(
  profile-name: [Standard 16:9],
  canvas-label: [19.2 cm × 10.8 cm],
  sample-images: (
    "/assets/attractor/standard/dark-1.svg",
    "/assets/attractor/standard/dark-2.svg",
    "/assets/attractor/standard/dark-3.svg",
    "/assets/attractor/standard/dark-4.svg",
    "/assets/attractor/standard/dark-5.svg",
  ),
) = [
  // ----------------------------------------------------------------------
  // 1. Slide skeletons and foundational composition
  // ----------------------------------------------------------------------

  #brief.title-slide()

  #brief.section-slide(
    [页面骨架与基础组件],
    label: [第一部分 · #profile-name],
    summary: [先理解页面层级与组合原语，再选择适合内容关系的组件。],
    tags: [title-slide · section-slide · content-slide],
  )

  #brief.content-slide(
    [content-slide：一页只回答一个问题],
    lead: [lead 交代背景，主体承载证据，takeaway 在页底收束“所以什么”。],
    takeaway: [页面骨架稳定后，作者只需要选择与内容关系匹配的组件。],
  )[
    #brief.callout[
      当前渲染配置：#profile-name · #canvas-label。standard.typ 与 wide.typ 使用完全相同的页面内容。
    ]
    #v(0.24cm)
    #brief.kpi-row(
      brief.kpi([背景], [1 个问题], [lead 控制在一到两行]),
      brief.kpi([证据], [2–4 组], [用组件组织，而不是堆列表]),
      brief.kpi([结论], [1 句话], [放进 takeaway]),
    )
  ]

  #brief.content-slide(
    [配置对象决定画布、字体、配色与品牌槽位],
    lead: [theme-config 组合 canvas、palette、typography、brand 与 background；正文 API 不随配置改变。],
    takeaway: [配置变化停留在主题边界，组件调用保持稳定。],
  )[
    #brief.data-table(
      (
        ([配置构造器], [负责内容], [当前示例]),
        ([canvas], [宽高与 standard / wide profile], [#canvas-label]),
        ([palette], [语义色与强调色序列], [semantic]),
        ([typography], [正文、标题与代码字体], [open font stack]),
        ([brand], [背景、Logo、页眉与页脚槽位], [generic public brand]),
        ([background], [off / cached / compute provider], [cached attractor]),
      ),
      columns: (1.05fr, 1.75fr, 1.20fr),
    )
  ]

  #brief.content-slide(
    [colors、tokens 与 palettes：共享设计基础],
    lead: [colors 提供语义色，tokens 固定圆角、描边、字号与间距，palettes 提供可替换的强调色序列。],
  )[
    #grid(
      columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
      gutter: 0.10cm,
      _swatch([info], brief.colors.info),
      _swatch([success], brief.colors.success),
      _swatch([warning], brief.colors.warning),
      _swatch([danger], brief.colors.danger),
      _swatch([violet], brief.colors.violet),
      _swatch([cyan], brief.colors.cyan),
      _swatch([orange], brief.colors.orange),
      _swatch([slate], brief.colors.slate),
    )
    #v(0.24cm)
    #brief.columns(
      (1fr, 1fr),
      brief.info-panel[
        #text(weight: "bold", fill: brief.colors.navy)[tokens]
        #v(0.08cm)
        card-radius = #repr(brief.tokens.card-radius) · chip-radius = #repr(brief.tokens.chip-radius) \
        layout-gap = #repr(brief.tokens.layout-gap) · card-title-size = #repr(brief.tokens.card-title-size)
      ],
      brief.info-panel[
        #text(weight: "bold", fill: brief.colors.navy)[palettes]
        #v(0.08cm)
        semantic = #brief.palettes.semantic.len() colors · google = #brief.palettes.google.len() · material = #brief.palettes.material.len() · classic-mac = #brief.palettes.classic-mac.len()
      ],
    )
  ]

  #brief.content-slide(
    [columns 与 rows：先决定阅读方向],
    lead: [横向比较用 columns，纵向推进用 rows；比例由内容主次决定。],
    takeaway: [布局原语表达阅读顺序，不承担业务语义。],
  )[
    #brief.columns(
      (1.08fr, 0.92fr),
      brief.info-panel[
        #text(weight: "bold", fill: brief.colors.info)[columns · 左侧证据]
        #v(0.12cm)
        #brief.bullets((
          [事实：系统在峰值阶段出现排队。],
          [约束：不能增加关键路径开销。],
          [目标：先定位，再按需放大。],
        ))
      ],
      brief.rows(
        (auto, auto),
        brief.tint-cell([rows · 上层], [先给出可验证的观察。], accent: brief.colors.violet),
        brief.tint-cell([rows · 下层], [再解释观察改变了哪个选择。], accent: brief.colors.teal),
        gap: 0.18cm,
      ),
    )
  ]

  #brief.content-slide(
    [等高、堆叠与垂直居中],
    lead: [equal-columns 拉齐并列项高度，stack 组织垂直层级，vertical-center 负责固定区域内的光学居中。],
  )[
    #brief.equal-columns(
      (1fr, 1fr, 1fr),
      brief.evidence-card([equal-columns], ([短内容。], [与相邻长内容等高。])),
      brief.evidence-card([stack], ([按顺序组织多个块。], [间距由一个参数统一控制。], [适合纵向叙事。])),
      brief.info-panel[
        #brief.vertical-center(
          [#align(center)[#text(weight: "bold", fill: brief.colors.violet)[vertical-center] \\ 固定区域内垂直居中]],
          height: 1.65cm,
        )
      ],
    )
  ]

  #brief.content-slide(
    [card-grid、card、vertical-card 与 render],
    lead: [card 是标准强调卡；card-grid 负责排列，vertical-card 可直接渲染，render 接受组件或普通内容。],
    takeaway: [并列卡片必须处于同一抽象层级。],
  )[
    #brief.card-grid(
      (1fr, 1fr, 1fr),
      brief.card([card], footer: [由 card-grid 排列])[自动强调色，适合并列判断。],
      brief.vertical-card([vertical-card], [直接渲染的强调卡。], footer: [无需容器]),
      brief.render(brief.card([render], footer: [统一渲染入口])[组件或普通内容均可传入。]),
    )
  ]

  #brief.content-slide(
    [intro、info-panel、callout、bullets 与 bullet-row],
    lead: [这些组件处理解释性文字：从弱提示到强结论，层级逐步增强。],
  )[
    #brief.intro[brief.intro 用于局部背景说明，视觉权重低于正文。]
    #v(0.16cm)
    #brief.columns(
      (1fr, 1fr),
      brief.info-panel[
        #text(weight: "bold", fill: brief.colors.navy)[info-panel · 中性容器]
        #v(0.10cm)
        #brief.bullets((
          [bullets 自动统一圆点、间距和强调色。],
          [适合三到五条同层级事实。],
        ))
      ],
      brief.stack(
        brief.callout(accent: brief.colors.orange)[callout 用左侧强调条标出关键解释。],
        brief.bullet-row([bullet-row 可单独嵌入自定义布局。], brief.colors.success, size: 8pt),
        gap: 0.18cm,
      ),
    )
  ]

  #brief.content-slide(
    [image-card 与 evidence-card：证据和解读并排],
    lead: [image-card 保持图像比例并附带图注；evidence-card 把可验证事实组织成短列表。],
  )[
    #brief.columns(
      (1.02fr, 0.98fr),
      brief.image-card(
        sample-images.at(0),
        caption: [主题自带的缓存 attractor 资产，仅用于演示图像容器。],
        height: 3.65cm,
      ),
      brief.evidence-card(
        [evidence-card · 证据清单],
        (
          [观察窗口和指标口径已明确。],
          [数据来源可以被独立复核。],
          [解释与事实分层书写。],
          [下一步动作由证据触发。],
        ),
      ),
    )
  ]

  #brief.content-slide(
    [四种紧凑语义卡],
    lead: [phase-card、badge-card、formula-card 与 tint-cell 分别表达阶段、带编号事实、公式解释和轻量语义对照。],
  )[
    #brief.card-grid(
      (1fr, 1fr),
      brief.phase-card([运行时], [持续轻量采集], [只保留定位所需的低成本信号。], emphasized: true),
      brief.badge-card([A], [约束已确认], [Architecture], [控制面与数据面拥有独立预算。], accent: brief.colors.violet),
      brief.formula-card([开销预算], [$ T_"total" = T_"work" + T_"observe" $], [把观测成本显式纳入总时延。], accent: brief.colors.orange),
      brief.tint-cell([轻量提示], [适合在图旁补充定义、前提或边界。], accent: brief.colors.teal),
    )
  ]

  #brief.content-slide(
    [flow-node、flow-arrow 与 process-flow],
    lead: [flow-node 和 flow-arrow 可以手工组合；process-flow 自动生成完整横向流程。],
    takeaway: [流程图表达先后和转换机制，不表达并列分类。],
  )[
    #brief.columns(
      (1fr, 0.62cm, 1fr),
      brief.flow-node([采集], [events / metrics]),
      brief.flow-arrow([写入]),
      brief.flow-node([查询], [SQL / DataFrame]),
      gap: 0.08cm,
    )
    #v(0.32cm)
    #brief.process-flow(
      brief.flow-node([输入], [问题 / 范围]),
      brief.flow-node([定位], [对象 / 时间窗]),
      brief.flow-node([验证], [对照 / 指标]),
      brief.flow-node([交付], [结论 / 动作]),
      labels: ([归纳], [缩小], [复核]),
    )
  ]

  #brief.content-slide(
    [ribbon-list 与 ribbon-row：分类、标签和判断对齐],
    lead: [左侧显示分类，中间显示字段名，右侧承载对应判断，适合替代密集项目符号。],
  )[
    #brief.ribbon-list(
      brief.ribbon-row(
        [方案 A], [稳健路线],
        ([适用场景], [主要取舍]),
        ([需求明确、变化较少。], [交付快，但后续弹性有限。]),
      ),
      brief.ribbon-row(
        [方案 B], [弹性路线],
        ([适用场景], [主要取舍]),
        ([需求仍在探索。], [前期复杂，调整成本更低。]),
      ),
      brief.ribbon-row(
        [方案 C], [突破路线],
        ([适用场景], [主要取舍]),
        ([瓶颈明确且有验证窗口。], [潜在收益高，工程风险也高。]),
      ),
    )
  ]

  #brief.content-slide(
    [data-table：承载可以直接比较的事实],
    lead: [第一行作为表头，最后一行可高亮推荐结论；列数和密度应控制在短时间可读范围内。],
    takeaway: [定性判断用组件，精确数值和可比事实用表格。],
  )[
    #brief.data-table(
      (
        ([维度], [方案 A], [方案 B], [方案 C]),
        ([复杂度], [低], [中], [高]),
        ([扩展性], [有限], [较好], [最好]),
        ([交付风险], [低], [中], [高]),
        ([建议], [短期兜底], [主线推进], [保留验证]),
      ),
      columns: (1.05fr, 1fr, 1fr, 1fr),
    )
  ]

  #brief.content-slide(
    [loss-card 与 loss-grid：风险页要解释失效机制],
    lead: [每张 loss-card 同时给出原因和影响；loss-grid 负责把同层级风险排成矩阵。],
  )[
    #brief.loss-grid(
      brief.loss-card([目标漂移], [问题定义持续变化。], [验证口径无法稳定。]),
      brief.loss-card([指标缺失], [没有提前定义比较指标。], [评审退化为偏好讨论。]),
      brief.loss-card([依赖不清], [接口与资源假设未锁定。], [集成成本被低估。]),
      brief.loss-card([叙事过密], [一页承载太多层级。], [术语被记住，判断被遗忘。]),
    )
  ]

  #brief.content-slide(
    [stage-item、step-hint、banner 与 closing-banner],
    lead: [stage-item 与 step-hint 组成竖向推进；banner 和 closing-banner 分别承担强结论与收束动作。],
  )[
    #brief.columns(
      (0.94fr, 1.06fr),
      brief.stack(
        brief.stage-item([1], [观察], [持续采集低成本信号。]),
        brief.step-hint(label: [触发异常], accent: brief.colors.orange),
        brief.stage-item([2], [深挖], [在目标时间窗启动高成本分析。], accent: brief.colors.orange, emphasized: true),
        gap: 0.10cm,
      ),
      brief.stack(
        brief.banner([结论], [先保持全局可见，再对局部按需放大。]),
        brief.closing-banner[下一步：定义触发条件、责任人和验收指标。],
        brief.brand-rule(),
        brief.ending-strip([ending-strip 可在自定义组合中复用页底结论样式。]),
        gap: 0.16cm,
      ),
    )
  ]

  // ----------------------------------------------------------------------
  // 2. Consumer-proven controls promoted into the public theme
  // ----------------------------------------------------------------------

  #brief.section-slide(
    [真实项目沉淀的通用控件],
    label: [第二部分 · #profile-name],
    summary: [从 Agent Infra、DeepLink.Next、Probing 与 Fabric 汇报中提炼重复版式，并移除项目名、Logo 与专用图形。],
    tags: [evidence · comparison · media · hierarchy · references],
  )

  #brief.content-slide(
    [flat-card：固定高度的扁平证据卡],
    lead: [色轨收在卡片内部，固定高度让并列信息保持稳定节奏；可选 note 用于补充口径或状态。],
    takeaway: [规则化网格优先使用 flat-card；内容长度不确定时改用自适应的 rail-card。],
  )[
    #brief.card-grid(
      (1fr, 1fr),
      brief.flat-card(
        [事实边界],
        [身份、状态与证据保持稳定，重试和迁移不会改变事实坐标。],
        accent: brief.colors.info,
        note: [稳定语义 · 可回放],
      ),
      brief.flat-card(
        [观察预算],
        [默认保持全局可见，只在触发条件满足时放大局部细节。],
        accent: brief.colors.teal,
        note: [持续观察 · 按需深挖],
      ),
      brief.flat-card(
        [责任归属],
        [每个判断都绑定输入、执行者与验收条件，避免结论悬空。],
        accent: brief.colors.violet,
      ),
      brief.flat-card(
        [交付信号],
        [结果以可复核的状态变化结束，而不是停留在过程描述。],
        accent: brief.colors.success,
      ),
    )
  ]

  #brief.content-slide(
    [rail-card、label-band 与 source-note],
    lead: [三者分别承载扁平证据、标签化元信息和弱化来源说明；同一形态已在多个真实项目中重复出现。],
  )[
    #brief.card-grid(
      (1fr, 1fr),
      brief.rail-card(
        [生命周期需要稳定边界],
        [一次运行可以重试或迁移，但身份、事实和最终状态必须保持一致。],
        note: [rail-card · 可选 note],
        accent: brief.colors.info,
      ),
      brief.rail-card(
        [状态需要成为数据产品],
        [模型、工具与环境事件共享稳定坐标，才能被回放、评测与复核。],
        note: [rail-card · 适合并列证据],
        accent: brief.colors.teal,
      ),
    )
    #v(0.20cm)
    #brief.label-band(
      [公开结构参考],
      [技术报告、系统卡与架构说明可以共用同一条紧凑元信息带。],
      accent: brief.colors.violet,
    )
    #v(0.12cm)
    #brief.source-note(
      [Public documentation and reproducible project evidence.],
      label: [Sources:],
    )
  ]

  #brief.content-slide(
    [section-chip、flow-card 与 chip],
    lead: [section-chip 提供轻量过渡；flow-card 承载带标签的解释步骤；chip 和 legend-item 处理短状态与图例。],
  )[
    #brief.section-chip([运行机制], subtitle: [从持续观察到按需深挖])
    #v(0.18cm)
    #brief.columns(
      (1.15fr, 0.85fr),
      brief.stack(
        brief.flow-card([部署时], [保持低成本信号], [持续采集摘要、计数和低频样本，不进入关键路径。], accent: brief.colors.info),
        brief.flow-card([调查时], [围绕目标放大], [对象和时间窗确定后，再启动高精度分析。], accent: brief.colors.success),
        gap: 0.16cm,
      ),
      brief.info-panel[
        #text(weight: "bold", fill: brief.colors.navy)[chip · 状态词汇]
        #v(0.12cm)
        #brief.stack(
          brief.legend-item(brief.chip([稳定], accent: brief.colors.success), [已验证且可复核]),
          brief.legend-item(brief.chip([观察], accent: brief.colors.info), [仍需收集证据]),
          brief.legend-item(brief.chip([风险], accent: brief.colors.danger), [存在明确失效条件]),
          gap: 0.14cm,
        )
      ],
    )
  ]

  #brief.content-slide(
    [comparison-list 与 comparison-row：富比较行],
    lead: [当单元格需要状态 chip 或任意内容时，用富比较行；精确数值仍应使用 data-table。],
  )[
    #brief.comparison-list(
      ([候选], [延迟], [扩展], [结论]),
      brief.comparison-row(
        [均衡], [方案 A], [默认主线],
        (brief.chip([良好], accent: brief.colors.success), brief.chip([良好], accent: brief.colors.info)),
        [无致命短板],
        accent: brief.colors.info,
        emphasized: true,
      ),
      brief.comparison-row(
        [低延迟], [方案 B], [局部最优],
        (brief.chip([最优], accent: brief.colors.success), brief.chip([有限], accent: brief.colors.warning)),
        [适合小范围],
        accent: brief.colors.orange,
      ),
      brief.comparison-row(
        [可扩展], [方案 C], [规模优先],
        (brief.chip([一般], accent: brief.colors.warning), brief.chip([最优], accent: brief.colors.success)),
        [保留验证],
        accent: brief.colors.violet,
      ),
      columns: (2.60cm, 1fr, 1fr, 1.70fr),
    )
  ]

  #brief.content-slide(
    [media-card 与 spec-row：带图规格卡],
    lead: [一个统一组件覆盖工作负载卡、拓扑卡、姿态卡和图文面板；差异只由可选标签、徽章、规格与页脚表达。],
  )[
    #brief.columns(
      (1fr, 1fr),
      brief.media-card(
        [持续采集],
        sample-images.at(1),
        subtitle: [runtime · low-cost signals],
        tag: [运行时],
        badge: [低成本],
        specs: (
          brief.spec-row([范围], [全局持续]),
          brief.spec-row([输出], [摘要与索引]),
        ),
        footer: [偏好：固定预算 · 可长期保留],
        accent: brief.colors.info,
      ),
      brief.media-card(
        [按需分析],
        sample-images.at(2),
        subtitle: [investigation · high fidelity],
        tag: [调查],
        specs: (
          brief.spec-row([范围], [目标对象与时间窗]),
          brief.spec-row([输出], [完整证据包]),
        ),
        footer: [偏好：高精度 · 可独立复核],
        accent: brief.colors.violet,
      ),
    )
  ]

  #brief.content-slide(
    [layer-stack 与 layer：表达责任层级],
    lead: [layer 是参数构造器，layer-stack 把同一系统中的能力域按依赖或责任从上到下排列。],
    takeaway: [层级图回答“谁依赖谁”；流程图回答“先做什么”。],
  )[
    #brief.columns(
      (1fr, 1fr),
      brief.layer-stack(
        brief.layer([应用层], [面向用户的问题、交互与工作流。], accent: brief.colors.violet),
        brief.layer([运行层], [执行、调度、隔离与状态管理。], accent: brief.colors.orange),
        brief.layer([数据层], [不可变事实、索引、查询与证据。], accent: brief.colors.success),
      ),
      brief.layer-stack(
        brief.layer([控制面], [声明策略、预算和触发条件。], accent: brief.colors.info),
        brief.layer([数据面], [采集与传输保持可替换。], accent: brief.colors.teal),
        brief.layer([验证面], [通过对照实验确认边界。], accent: brief.colors.warning),
      ),
    )
  ]

  #brief.content-slide(
    [ladder 与 ladder-step：纵向递进],
    lead: [ladder-step 同时容纳编号、可选媒体、量级与解释；ladder 自动组织连接关系。],
  )[
    #brief.ladder(
      brief.ladder-step([1], [发现], [全局 · 持续], [用固定低预算信号发现异常。], accent: brief.colors.info),
      brief.ladder-step([2], [定位], [对象 · 时间窗], [用查询缩小需要观察的范围。], media: sample-images.at(3), accent: brief.colors.teal),
      brief.ladder-step([3], [深挖], [局部 · 高精度], [在目标范围启动昂贵工具。], accent: brief.colors.orange),
      brief.ladder-step([4], [复核], [证据 · 可重复], [保存完整性信息与复现步骤。], media: sample-images.at(4), accent: brief.colors.violet),
      media-width: 1.35cm,
    )
  ]

  #brief.content-slide(
    [reference-card：引用与主张同框],
    lead: [reference-card 把类别、标题、引用编号与简短判断绑定，适合标准、论文、供应链或竞品证据。],
  )[
    #brief.card-grid(
      (1fr, 1fr, 1fr),
      brief.reference-card(
        [标准], [接口契约], [§2.1],
        [字段、状态和错误语义应当能被独立实现与验证。],
        accent: brief.colors.info,
        height: 2.65cm,
      ),
      brief.reference-card(
        [论文], [方法边界], [Fig. 3],
        [引用结论时同时保留适用范围、实验条件和限制。],
        accent: brief.colors.violet,
        height: 2.65cm,
      ),
      brief.reference-card(
        [实现], [复现入口], [commit],
        [把代码版本、配置和数据范围连接到可重复步骤。],
        accent: brief.colors.success,
        height: 2.65cm,
      ),
    )
  ]

  // ----------------------------------------------------------------------
  // 3. Argument structures
  // ----------------------------------------------------------------------

  #brief.section-slide(
    [逻辑型组件：让版式形状承载论证],
    label: [第三部分 · #profile-name],
    summary: [先判断内容关系，再选择对比、象限、因果、阶段、框架或取舍组件。],
    tags: [contrast · quadrant · causal chain · decision structures],
  )

  #brief.content-slide(
    [逻辑关系到组件：一张选择表],
    lead: [组件目录的目标不是增加装饰，而是让页面轮廓直接表达论证关系。],
  )[
    #brief.data-table(
      (
        ([逻辑关系], [主组件], [参数构造器]),
        ([旧与新 / 转折], [contrast], [left / right dictionary]),
        ([两轴分类], [quadrant], [tl / tr / bl / br]),
        ([因果递进], [causal-chain], [chain-step]),
        ([阶段推进], [phase-track], [phase]),
        ([一体多面], [framework], [facet]),
        ([命题角色 / 认知状态], [claim / notice], [kind]),
        ([收益与代价], [tradeoff], [gains / costs]),
        ([结论与支撑], [pyramid], [facet]),
        ([判据 / 程度 / 时间], [compare-matrix / rating-list / timeline], [matrix-row / rating / milestone]),
      ),
      columns: (1.25fr, 1.75fr, 1.25fr),
      size: 6.2pt,
    )
  ]

  #brief.content-slide(
    [contrast：过去与现在对置，再收束结论],
    lead: [适合“旧做法为什么失效、新做法改变了什么”的转折论证。],
  )[
    #brief.contrast(
      (title: [过去：全量导出], tag: [先采后查], body: [每个节点都持续上传完整数据；规模越大，观测系统越容易成为新瓶颈。]),
      (title: [现在：原位归约], tag: [先查后取], body: [节点保留本地数据，只返回查询结果；问题缩小后再提取必要证据。]),
      verdict: [诊断流量从“随采集量增长”变成“随答案规模增长”。],
    )
  ]

  #brief.content-slide(
    [quadrant：两条正交判据形成四类],
    lead: [象限适用于两个独立维度交叉后的分类；坐标轴本身就是判据。],
  )[
    #brief.quadrant(
      x-axis: [分析成本],
      y-axis: [持续性],
      tl: (title: [持续 · 轻量], body: [计数器、摘要和低频采样，长期保留。]),
      tr: (title: [持续 · 重量], body: [高成本且长期运行，应谨慎避免。]),
      bl: (title: [按需 · 轻量], body: [快速检查，用于确认范围和对象。]),
      br: (title: [按需 · 重量], body: [Profiler、完整堆栈和高精度追踪。]),
      height: 4.75cm,
    )
  ]

  #brief.content-slide(
    [causal-chain 与 chain-step：把因果机制写在边上],
    lead: [节点说明发生了什么，边标签说明为什么会进入下一步。],
  )[
    #brief.columns(
      (0.82fr, 1.18fr),
      brief.causal-chain(
        brief.chain-step(brief.colors.info, [请求碎片化], [单次载荷变小、请求频率升高。], then: [导致排队]),
        brief.chain-step(brief.colors.orange, [固定开销占比上升], [调度和协议开销无法被大载荷摊薄。], then: [放大尾延迟]),
        brief.chain-step(brief.colors.danger, [服务抖动], [最慢节点决定整体完成时间。]),
      ),
      brief.info-panel[
        #text(weight: "bold", fill: brief.colors.navy)[何时使用 causal-chain]
        #v(0.12cm)
        #brief.bullets((
          [需要把“因为”与“所以”显式写出来。],
          [节点数量较少，但机制比时间更重要。],
          [若只关心执行顺序，改用 process-flow。],
        ))
      ],
    )
  ]

  #brief.content-slide(
    [phase-track 与 phase：同一对象沿时间推进],
    lead: [编号和横向轨道把阶段显形，适合生命周期、交付路径和运行时状态。],
  )[
    #brief.phase-track(
      brief.phase([接入], [注册数据源], [声明触发条件、成本、表结构和关联坐标。]),
      brief.phase([运行], [持续轻量采集], [保持全局可见性，不进入关键路径。]),
      brief.phase([调查], [按需精细分析], [围绕目标 rank、step 与时间窗启动 Profiler。]),
      brief.phase([复核], [形成证据包], [保存查询、完整性元数据与可重复步骤。]),
      height: 3.45cm,
    )
  ]

  #brief.content-slide(
    [claim：明确一句话在论证里的角色],
    lead: [定义、命题、方法、反例和结论使用不同语义色，避免把事实与推断混在一起。],
  )[
    #brief.card-grid(
      (1fr, 1fr),
      brief.claim([定义], [持续观测], [以固定低预算长期保留用于定位的信号。]),
      brief.claim([命题], [全量采集不可扩展], [采集规模与训练规模同步增长时，观测会改变被观测系统。]),
      brief.claim([方法], [先缩小窗口], [先用低成本查询确定对象和时间，再启动精细分析。]),
      brief.claim([反例], [采到数据不等于得到证据], [若缺少关联坐标和完整性信息，数据无法支撑归因。]),
    )
  ]

  #brief.content-slide(
    [framework 与 facet：一个母题拆成多个互补侧面],
    lead: [共享标题让观众识别“仍在讨论同一套框架”，facet 定义各个支撑面。],
  )[
    #brief.framework(
      [统一诊断语言：采集、查询与证据闭环],
      brief.facet([采集], [按公共坐标写入事件表，持续与按需数据源遵守同一契约。]),
      brief.facet([查询], [通过 SQL 或 DataFrame 跨 rank、step、模块与时间窗关联。]),
      brief.facet([证据], [结果携带范围、完整性和复现步骤，支持独立复核。]),
    )
    #v(0.28cm)
    #brief.framework(
      [同一结构也可表达阶段性演进],
      brief.facet([阶段一], [统一坐标。]),
      brief.facet([阶段二], [统一查询。]),
      brief.facet([阶段三], [统一证据。]),
      accent: brief.colors.success,
    )
  ]

  #brief.content-slide(
    [notice、callout 与 banner：三种不同强度的提示],
    lead: [notice 标记认知状态，callout 强调解释，banner 用于不可忽略的单句结论。],
  )[
    #brief.stack(
      brief.notice([要点], [持续轻量采集负责发现，按需精细分析负责归因。]),
      brief.notice([前提], [所有数据源必须能关联到 rank、step、模块和时间窗。]),
      brief.notice([注意], [“低开销”必须通过同负载对照实验验证。]),
      brief.notice([风险], [若查询等待远端采集完成，训练回调仍会被诊断系统阻塞。]),
      brief.callout(accent: brief.colors.teal)[callout：解释为什么这些约束共同决定了架构边界。],
      brief.banner([结论], [查询和跨机请求不进入训练回调。], accent: brief.colors.success),
      gap: 0.12cm,
    )
  ]

  #brief.content-slide(
    [tradeoff：收益与代价左右对账],
    lead: [适合“方案有价值，但同时引入新成本”的决策页。],
  )[
    #brief.tradeoff(
      (
        [问题发生前已有连续上下文。],
        [精细分析只作用于目标对象和窗口。],
        [查询结果可以直接复用为证据。],
      ),
      (
        [需要维护本地数据生命周期。],
        [控制面与完整性语义更复杂。],
        [必须持续验证开销预算。],
      ),
      height: 4.10cm,
    )
  ]

  #brief.content-slide(
    [pyramid 与 facet：结论先行，再给出 MECE 支撑],
    lead: [顶部横幅承载主张，下方支撑柱解释为什么这个主张成立。],
  )[
    #brief.pyramid(
      [诊断系统应当先缩小调查范围，再启动高成本观测。],
      brief.facet([开销], [持续运行的采集器必须保持固定低预算。]),
      brief.facet([精度], [高精度工具只在已定位的对象与窗口中开启。]),
      brief.facet([复核], [所有结论都要能回到原始事件与完整性元数据。]),
      support-height: 3.0cm,
    )
  ]

  #brief.content-slide(
    [compare-matrix、matrix-row 与 matrix-legend],
    lead: [行是候选方案，列是判据；✓、◐、✕ 让定性差异可以快速扫描。],
  )[
    #brief.compare-matrix(
      ([持续可用], [低开销], [高精度], [跨节点], [可复核]),
      brief.matrix-row([日志导出], "y", "p", "p", "p", "p"),
      brief.matrix-row([全程 Profiler], "n", "n", "y", "n", "p"),
      brief.matrix-row([节点查询], "y", "y", "p", "y", "y"),
      brief.matrix-row([分层诊断], "y", "y", "y", "y", "y"),
      name-width: 2.7cm,
      corner: [方案],
    )
    #v(0.20cm)
    #align(right)[#brief.matrix-legend(yes: [满足], partial: [部分满足], no: [不满足])]
  ]

  #brief.content-slide(
    [rating-list 与 rating：表达成熟度或程度],
    lead: [填充圆点适合相对评估；必须同时给出说明，避免把主观评级伪装成精确数据。],
  )[
    #brief.rating-list(
      brief.rating([采集契约], 4, [触发、成本、表结构与坐标已经明确。]),
      brief.rating([本地存储], 3, [热路径稳定，恢复与冷热查询仍在优化。]),
      brief.rating([跨节点查询], 2, [已有 fan-out 方案，完整性语义待收敛。]),
      brief.rating([自动归因], 1, [先保留接口和证据链，不提前承诺结论。]),
      levels: 4,
    )
    #v(0.28cm)
    #brief.notice([前提], [rating 是沟通用相对尺度；正式评价应另附可复核指标。])
  ]

  #brief.content-slide(
    [timeline 与 milestone：沿时间轴安排里程碑],
    lead: [时间轴适合路线图和交付节奏；每个 milestone 只保留时间、标题和一句结果。],
  )[
    #brief.timeline(
      brief.milestone([现在], [统一接口], [固定数据源、查询与完整性契约。]),
      brief.milestone([下一步], [联调验证], [在真实负载下验证开销和故障路径。]),
      brief.milestone([随后], [跨节点查询], [加入 fan-out 与 partial result 语义。]),
      brief.milestone([收敛], [开放复核], [沉淀可重复实验和证据包。]),
    )
    #v(0.34cm)
    #brief.closing-banner[
      完整组件目录在 #profile-name（#canvas-label）下渲染完成；切换画布不需要修改任何正文调用。
    ]
  ]
]
