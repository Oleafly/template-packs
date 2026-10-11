#import "template.typ": resume

#let content = (
  profile: (
    fullname: "姓名",
    subtitle: "副标题/学历",
    // Use `photo: "avatar.jpg"` to show a photo, or `photo: none` to hide it.
    photo: none,
    contacts: (
      (icon: "\u{f095}", body: [138 0000 0000]),
      (icon: "\u{f0e0}", body: [#link("mailto:liming@example.com")[liming\@example.com]]),
      (icon: "\u{f0ac}", body: [#link("https://example.com")[example.com]]),
      (icon: "\u{f09b}", body: [#link("https://github.com/example")[github.com/example]]),
      (icon: "\u{f041}", icon-size: 10.6pt, body: [北京]),
    ),
  ),
  education: (
    (
      title: "本科 某某大学",
      date: "2022.09 - 2026.06",
      subheading: "计算机学院，计算机科学与技术专业",
      location: "北京",
      items: (
        [这里写主要经历],
        [例如绩点、学生干部经历等],
      ),
    ),
    (
      title: "硕士 某某大学",
      date: "2024.09 - 2025.01",
      subheading: "工程学院，软件工程方向",
      location: "上海",
      items: (
        [发表了114514篇论文],
      ),
    ),
  ),
  projects: (
    (
      title: "项目",
      date: "2025.03 - 2025.06",
      items: (
        [S (Situation) – 情景：事情发生的背景、环境或当时的状况。],
        [T (Task) – 任务：你面临的具体任务、目标或需要解决的问题。],
        [A (Action) – 行动：你实际采取的具体行动、方法、策略或技术。],
        [R (Result) – 结果：你的行动带来了什么样的可量化或可评价的结果。],
      ),
    ),
    (
      title: "其它项目",
      date: "2024.11 - 2025.01",
      items: (
        [可以按照上面的STAR继续写],
        [也可以自由发挥],
      ),
    ),
  ),
  experience: (
    (
      title: "竞赛与荣誉",
      date: "",
      strong-title: false,
      items: (
        [2025 年某某程序设计竞赛一等奖],
        [2024 - 2025 学年校级优秀学生奖学金],
      ),
    ),
    (
      title: [开源贡献：#strong[Example Project]],
      date: "2025.02",
      strong-title: false,
      items: (
        [参与了某个开源项目],
        [做了什么贡献],
      ),
      after: 0pt,
    ),
  ),
  skills: (
    (name: "英语水平", body: [CET-6 750 分，莎士比亚转生]),
    (name: "编程语言", body: [精通 C++]),
    (name: "开发工具", body: [熟悉 Git、Docker、Linux、PostgreSQL]),
  ),
)

#resume(content)
