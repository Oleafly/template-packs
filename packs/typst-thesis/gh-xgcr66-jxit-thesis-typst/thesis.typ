#import "lib/model.typ": *
// 所有正文写在此处。字符串中的换行可用 \n；普通段落用 p("……")。
// 同一份结构化 Typst 内容用于 PDF 和可编辑 Word，避免维护两份正文。
#let thesis = (
  meta: (
    title: "本科毕业论文题目",
    english-title: "Title of the Undergraduate Thesis",
    school: "江西科技学院", college: "【待填写】", major: "【待填写】",
    class: "【待填写】", student-id: "【待填写】", author: "【待填写】",
    supervisor: "【待填写】", second-supervisor: "", confidential: "公开",
    date: "【填写年月】", logo: "assets/school-emblem.jpeg",
    school-wordmark: "assets/school-wordmark.jpeg",
  ),
  abstract-cn: (
    "【请填写研究背景。由研究领域逐步说明具体课题及研究必要性。中文摘要约300字，采用第三人称表述。】",
    "【请填写研究内容、方法和技术路线。用连贯文字概括实际完成的工作，说明研究对象、实现过程及验证方法。】",
    "【请填写真实研究结论及局限。摘要独立成文，避免插入图表、代码、引文和未经核验的数据。】",
  ),
  keywords-cn: ("关键词一", "关键词二", "关键词三", "关键词四"),
  abstract-en: (
    "[Replace this paragraph with the research background and the purpose of the study. The English abstract should correspond to the Chinese abstract.]",
    "[Describe the scope, methods and main work of the study. Use consistent technical terms and report only work actually completed.]",
    "[Summarize verified findings and relevant limitations. The English abstract should contain approximately 250 words according to the supplied guidance.]",
  ),
  keywords-en: ("keyword one", "keyword two", "keyword three", "keyword four"),
  chapters: (
    chapter("引言", (
      h2("选题背景及意义"), h3("选题背景"),
      p("【结合真实文献阐述选题背景，由领域现状逐步引出研究问题。正文采用宋体小四，英文和数字采用 Times New Roman，首行缩进两个汉字。】"),
      h3("选题意义"), p("【说明课题的实际价值和适用范围，避免将尚未完成的目标写成已取得的成果。】"),
      h2("国内外研究现状"), p("【按研究主题综合相关工作，说明已有研究的特点和待解决问题。文献标记用 cite 块在行内插入；下列仅演示真实技术文档引用。】"),
      rich(("Typst 官方文档介绍了页面与文本的排版方法", cite(1), "。本示例仅用于展示引用格式，正式论文应按研究内容补充和核验文献。")),
      h2("研究内容与论文结构"), p("【概括研究目标、主要内容和章节安排。模板示例为六章结构，可按专业要求增减章节。】"),
    )),
    chapter("需求与可行性分析", (
      h2("可行性分析"), h3("技术可行性"), p("【结合实际工具、已有技术基础及开发条件分析技术可行性。】"),
      h3("经济与操作可行性"), p("【说明设备、软件和服务成本，以及目标用户的操作条件。】"),
      h2("功能与非功能需求"), p("【界定真实用户角色、核心功能、使用限制和质量要求。】"),
    )),
    chapter("系统设计", (
      h2("总体设计"), p("排版与导出流程如图3.1所示。该图是模板自身的流程示例，撰写论文时应替换为研究对象的真实架构图。"),
      fig("模板内容与导出流程", "assets/example-flow.png", width: 14.0),
      h2("数据库设计"), h3("数据表设计"),
      p("数据字典排版示例如表3.1所示。字段内容仅为格式示例，应替换为项目实际建表结构。"),
      tab("数据表结构示例", ("字段名", "数据类型", "字段含义", "约束或备注"),
        (("id", "INTEGER", "记录编号", "主键"), ("title", "TEXT", "标题", "非空"), ("created_at", "TEXT", "创建时间", "由业务规则确定"))),
      p("表题置于表格上方，图题置于图片下方。图表分别按章自动编号。英文标识以可编辑文本保存。"),
    )),
    chapter("系统开发与实现", (
      h2("技术选型与开发环境"), p("【介绍项目实际使用的技术及其作用，版本应从当前配置中核验。】"),
      h2("主要模块实现"), h3("核心功能实现"), p("【按照用户操作、关键流程、数据变化和异常处理的顺序说明实现过程。需要界面截图时使用真实运行图片。】"),
      code("示例代码用于说明代码块排版；请替换为与论述相关的短代码。\nfunction normalize(value) {\n  return value.trim().toLowerCase();\n}"),
    )),
    chapter("系统测试", (
      h2("测试环境与方法"), p("【记录实际测试环境、测试范围及执行方法。尚未执行的项目标为待验证。】"),
      h2("功能测试"), p("功能测试用例表的格式如表5.1所示，测试结果需依据实际执行情况填写。"),
      tab("功能测试用例示例", ("序号", "测试项", "测试操作", "预期结果", "测试结果"),
        (("1", "正常流程", "【填写步骤】", "【填写预期】", "待验证"), ("2", "异常输入", "【填写步骤】", "显示明确提示", "待验证"))),
      h2("测试结果分析"), p("【分析已验证结果、失败项目、适用范围和剩余问题。】"),
    )),
    chapter("总结与展望", (
      h2("总结"), p("【依次总结需求分析、系统设计、实现与测试中已证明的工作。】"),
      h2("展望"), p("【根据实际局限提出后续改进方向，明确其属于未来工作。】"),
    )),
  ),
  references: (
    "Typst. Typst Documentation[EB/OL]. [2026-09-27]. https://typst.app/docs/.",
  ),
  appendix: (p("【附录为可选部分。可放置与正文有关的补充资料、必要代码或详细数据。无需附录时将 appendix 设为空数组 ()。】"),),
  acknowledgements: ("【请结合真实指导和帮助情况撰写致谢，使用仿宋小四。无需致谢时将 acknowledgements 设为空数组 ()。】",),
)
