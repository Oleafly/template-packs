// ============================================================================
// 虚拟示例简历 (Demo) — 全部内容为虚构, 切勿直接投递
// 人物: 李华 (占位姓名) · 软件工程 本科 · 上海 (占位城市)
// 学校/项目/赛事/链接均为虚构占位; 链接统一指向 example.com, 不会有真实跳转
// 用法: 拷贝 template.typ + resume.typ 到自己的工作目录, 替换为真实信息
// 渲染: ./build.sh 或 typst compile resume.typ resume.pdf
// 编译要求: typst >= 0.13, Noto Sans CJK SC 已安装
// ============================================================================

#import "template.typ": *

#resume-template[

#align(center)[
  = 李华
  #set text(fill: cv-body, size: 9pt)
  #v(2pt)
  求职意向：全栈开发工程师

  软件工程 本科 · 2026 届 · li.hua\@example.com · 上海
]

以 Python 为主线语言，覆盖前端交互、后端服务与数据存储，并具备容器化部署经验。2026 年多次参与网络安全与算法类竞赛（最佳名次第 37 名），持续维护个人开源练习项目。

== 教育经历 Education
#item[示例大学 · 软件工程学院][软件工程 本科][2022.09 - 2026.06]

== 技术能力 Technical Skills
#skill("编程语言", [Go、Python、TypeScript/JavaScript、C++])
#skill("Web / 后端", [HTML5、CSS3、React、Vue 3、Gin])
#skill("数据 / 中间件", [Docker、Docker Compose、PostgreSQL、Redis、SQLite])
#skill("系统 / 工具", [Linux、Git、CMake、Vite、pnpm])
#skill("AI 开发工具", [GitHub Copilot、Cursor、Codeium])

== 项目经历 Projects
#project(
  (label: "宿舍智能门禁系统", short: "dorm-access", link: "https://example.com/dorm-access"),
  "2026.03 - 2026.05",
  "Python、Flask、MQTT、OpenCV、树莓派",
  "面向学生宿舍的智能门禁：人脸比对开门 + 远程授权 + 进出记录，本地部署零云端依赖。",
  (
    [OpenCV 人脸检测 + 特征比对，识别失败自动降级为刷卡/密码。],
    [MQTT 上报进出事件，Flask 提供管理与查询接口，异常时段触发告警。],
  ),
  role: "个人项目",
)
#project(
  (label: "校园二手书交易小程序", short: "campus-books", link: "https://example.com/campus-books"),
  "2026.01 - 2026.02",
  "微信小程序、JavaScript、Flask、SQLite",
  "面向校内师生的二手书买卖小程序：发布、检索、站内私信与信用分。",
  (
    [微信小程序端 + Flask JSON API，按学科分类检索与模糊搜索。],
    [信用分与评价体系，交易完成后双向互评。],
  ),
  role: "个人项目",
)
#project(
  (label: "家乡美食地图", short: "foodmap", link: "https://example.com/foodmap"),
  "2025.10 - 2025.12",
  "Vue 3、TypeScript、Leaflet、Flask",
  "在地图上标记家乡特色小吃的 Web 应用：分类筛选、评分与路线预览。",
  (
    [Leaflet 交互地图 + 自定义标记图层，按品类/区域筛选。],
    [评分与留言评论，数据持久化到 SQLite，前后端分离部署。],
  ),
  role: "个人项目",
)
#project(
  (label: "在线书店管理系统"),
  "2025.02 - 2025.05",
  "Go 1.22、Gin、React 18、PostgreSQL、Redis、Docker",
  "Go 全栈模拟书店系统：认证、商品与订单管理，Docker Compose 编排。",
  (
    [Gin + GORM + PostgreSQL，JWT 会话令牌校验。],
    [React 18 + Vite 实现管理后台；Compose 编排 PostgreSQL/Redis。],
  ),
  role: "毕业设计",
)

#block(breakable: false)[
== 竞赛经历 Competitions
#item[网络安全与算法竞赛][个人参赛][2026]
#grid(
  columns: (1fr, 1fr),
  column-gutter: 1.2em,
  [
    #set list(spacing: 0.22em)
    - 全国大学生算法邀请赛（示例）：第 37 名
    - 网络安全线上邀请赛（示例）：第 64 名
    - 程序设计区域赛（示例）：第 121 名
  ],
  [
    #set list(spacing: 0.22em)
    - 信息安全挑战赛（示例）：第 143 名
    - 开源软件安全赛事（示例）：第 156 名
    - 逆向分析邀请赛（示例）：第 201 名
  ],
)]

== 证书与其他 Certifications
- 大学英语六级（CET-6）；计算机技术与软件专业技术资格（初级）

]