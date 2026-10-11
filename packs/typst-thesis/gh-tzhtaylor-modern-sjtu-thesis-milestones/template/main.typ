#import "../lib.typ": *

#let (
  doctype,
  date,
  info,
  ziti,
  doc,
  preface,
  mainmatter,
  cover,
  introduction,
  profile,
  declare,
) = documentclass(
  doctype: "proposal", // 文档类型: "proposal" | "midterm" | "annual-progress"
  font-set: "mac", // 字体集设置: "mac" | "windows" | "linux" | "webapp" | "webapp-upload", 根据系统设定字体集，可消除未知字体警告,
  info: (
    student-id: "012345678910",
    name: "张三",
    supervisor: "李四",
    title: "一个很长很长的题目",
    school: "上海交通大学",
    major: "电子信息",
    // 开题报告-学生类别 Degree Program:
    //    1. 学术型博士生 Academic Doctoral Student
    //    2. 专业型博士生 Professional Doctoral Student
    //    3. 学术型硕士生 Academic Master Student
    //    4. 专业型硕士生 Professional Master Student
    // 中期报告-学生类别 Degree Program:
    //    1. 学术型硕士生 Academic Master Student
    //    2. 专业型硕士生 Professional Master Student
    // 博士生年度报告-学生类别 Degree Program:
    //    1. 学术型 Academic
    //    2. 专业型 Professional
    degree: "专业型硕士生 Professional Master Student",
    // 开题/中期报告-学习形式 Study Mode:
    //    1. 全日制 Full-time
    //    2. 非全日制 Part-time
    //    3. 同等学力学生
    // 博士生年度报告-入学方式 Enrollment:
    //    1. 普博生 Regular Doctor Student
    //    2. 直博生 Doctor Student after Bachelor's
    //    3. 硕博连读生 Combined Master and Doctoral
    study-mode: "全日制 Full-time",
    // 研究课题来源(填数字1-6):
    //    1. 国家自然科学基金课题
    //    2. 国家社会科学基金课题
    //    3. 国家重大科研专项
    //    4. 其他纵向科研课题
    //    5. 企业横向课题
    //    6. 自拟课题
    project-source: 5,
    exam-date: datetime.today(), // 考核日期(开题报告无需填写)
    proposal-date: datetime(year: 2025, month: 1, day: 2), // 开题日期
    sign-date: datetime.today(), // 签名日期
    venue: "线上", // 开题地点(仅开题报告使用)
  ),
)

#show: doc

#cover()

#show: preface

#introduction()

#show: mainmatter

#profile()

#if doctype == "proposal" [
  = 请综述课题国内外研究进展、现状、挑战与意义，可分节描述。博士生不少于10,000汉字，硕士生不少于5,000汉字。请在文中标注参考文献。 Please review the frontier, current status, challenges and significance of the research topic. The citations should be marked in the context and listed in order at the end of this section. No less than 8,000 words for doctoral students and 4,000 words for master students if written in English.

  让我来综述一下课题国内外研究进展、现状、挑战与意义。这里要写好多好多字，博士生要写一万字，硕士生要写五千字，所以我们要多引用一些文献来达到字数要求。让我们写一点数学公式 $c^2 = a^2 + b^2$。

  == 国内外研究进展

  有一些进展。@Yu2001

  == 现状

  现状不乐观。@Cheng1999

  == 挑战

  挑战很严峻。

  == 意义

  非常有意义。

  #bilingual-bibliography(
    bibliography: bibliography.with("ref.bib"),
    title: "参考文献 References: ",
  )

  = 课题研究目标、主要研究内容和拟解决的关键问题。Research objectives, main contents and key issues to be solved.

  目标很明确，研究内容很丰富，关键问题很关键。

  = 拟采取的研究方法、研究方案及其可行性分析。Research methods and research scheme to be adopted and feasibility analysis.

  研究方法很复杂，可行性很可行。

  = 课题的创新点 Novelties of the proposed topic

  太创新了。

  = 计划进度、预期成果 Research schedule, and expected outcomes

  计划进度很紧凑，预期成果很丰硕。

  = 与本课题有关的工作积累、已有的研究工作成绩。Prior experience and accomplished achievements related to the proposed topic.

  无。
] else if doctype == "midterm" [
  = *报告正文 Report。*请阐述开题报告以来学位论文研究工作的进展情况及所取得的阶段性成果，并简述下一阶段研究计划，不少于4000汉字。Please summarize your research progress and achievements since your thesis proposal as well as your plan for next step. No less than 3200 words if written in English.

  == 进展情况 <12>

  进展情况良好。@img:subbifigures:test1

  #imagex(
    subimagex(
      image("figures/energy-distribution.png"),
      caption: [温室气体排放量随时间变化的情况],
      caption-en: [Greenhouse gas emissions over time],
      label-name: "test1",
    ),
    subimagex(
      image("figures/energy-distribution.png"),
      caption: [2050 年的温室气体排放量],
      // caption-en: [Greenhouse gas emissions in 2050],
      label-name: "test2",
      alignx: center + horizon,
    ),
    columns: (1fr, 1fr),
    caption: [不同情景下上海市乘用车的温室气体排放量],
    caption-en: [Greenhouse gas emissions from passenger cars in Shanghai under different scenarios],
    label-name: "subbifigures",
  )

  == 阶段性成果

  取得了很多成果。@tbl:long-table

  #tablex(
    ..for i in range(25) {
      ([250], [88], [5900], [1.65])
    },
    header: (
      [感应频率 #linebreak() (kHz)],
      [感应发生器功率 #linebreak() (%×80kW)],
      [工件移动速度 #linebreak() (mm/min)],
      [感应圈与零件间隙 #linebreak() (mm)],
    ),
    columns: (25%, 25%, 25%, 25%),
    caption: [高频感应加热的基本参数],
    caption-en: [XXXXXXX],
    label-name: "long-table",
  )

  == 下一阶段研究计划

  下一阶段计划很明确。@algo:fibonacci

  $
    1 + 2 = 3
  $

  #let tmp = math.italic("tmp")
  #algox(
    label-name: "fibonacci",
    caption: [斐波那契数列计算],
    pseudocode-list(line-gap: 1em, indentation: 2em)[
      - #h(-1.5em) *input:* integer $n$
      - #h(-1.5em) *output:* Fibonacci number $F(n)$
      + *if* $n = 0$ *then return* $0$
      + *if* $n = 1$ *then return* $1$
      + $a <- 0$
      + $b <- 1$
      + *for* $i$ *from* $2$ *to* $n$ *do*
        + $tmp <- a + b$
        + $a <- b$
        + $b <- tmp$
      + *end*
      + *return* $b$
    ],
  )

  = *成果清单 List of Achievements。*请列出开题报告以来或上次年度进展报告以来新发表的学术论文、授权专利、国际会议论文、专著等成果清单。作者、标题、杂志、卷、期、页码等信息请填写完整。Please provide a list of academic publications (papers, patents, international academic conference talks/presentations, monographs, etc.) since your thesis proposal. Information on author list, title, journal name, volume, number, and pages shall be complete.

  #achievements(
    papers: (
      "Chen H, Chan C T. Acoustic cloaking in three dimensions using acoustic metamaterials[J]. Applied Physics Letters, 2007, 91:183518.",
      "Chen H, Wu B I, Zhang B, et al. Electromagnetic Wave Interactions with a Metamaterial Cloak[J]. Physical Review Letters, 2007, 99(6):63903.",
    ),
    patents: (
      "第一发明人, 永动机[P], 专利申请号202510149890.0.",
    ),
  )
] else if doctype == "annual-progress" [
  = *报告正文 Report。*请阐述开题报告或上次年度进展报告以来学位论文研究工作的进展情况及所取得的阶段性成果，并简述下一年度研究计划，不少于3,000汉字。Please summarize your research progress and achievements since your dissertation proposal or last annual progress review, as well as your plan for next step. No less than 2,400 words if written in English.

  == 进展情况

  进展情况良好。

  == 阶段性成果

  取得了很多成果。

  == 下一阶段研究计划

  下一阶段计划很明确。

  = *成果清单 List of Achievements。*请列出开题报告以来或上次年度进展报告以来新发表的学术论文、授权专利、国际会议论文、专著等成果清单。作者、标题、杂志、卷、期、页码等信息请填写完整。Please provide a list of academic publications (papers, patents, international academic conference talks, monographs, etc.) since your dissertation proposal or last annual progress review. Information on author list, title, journal name, volume, number, and pages shall be complete.

  #achievements(
    papers: (
      "Chen H, Chan C T. Acoustic cloaking in three dimensions using acoustic metamaterials[J]. Applied Physics Letters, 2007, 91:183518.",
      "Chen H, Wu B I, Zhang B, et al. Electromagnetic Wave Interactions with a Metamaterial Cloak[J]. Physical Review Letters, 2007, 99(6):63903.",
    ),
    patents: (
      "第一发明人, 永动机[P], 专利申请号202510149890.0.",
    ),
  )
]

#declare(sign: place(dx: -10pt, dy: -20pt, image("figures/student-sign.png", height: 2.5em)))
