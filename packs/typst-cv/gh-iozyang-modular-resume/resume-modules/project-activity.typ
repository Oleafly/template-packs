#let activity = (
  id: "project-activity",
  source-refs: (
    "source/projects.md：proj-001.名称、时间、团队、个人角色、技术、表结构、接口、事务与结果",
  ),
  review-notes: ("3 人课程项目；本地模拟活动与测试账户；未进行有记录的并发压测。",),
  dates: "2026 春季学期",
  title: "校园活动报名与管理平台",
  role: "课程项目 / 后端开发",
  stack: ("Python", "FastAPI", "PostgreSQL", "SQLAlchemy", "React", "Docker Compose"),
  bullets: (
    "负责 3 人课程项目的后端和数据库设计，建立用户、活动、报名、分类、审计 5 张表，实现浏览、报名、取消及管理员发布等 11 个 REST 接口。",
    "为报名表设置用户-活动唯一约束，在数据库事务中完成名额检查与记录写入，对重复提交返回明确错误，支持管理员导出报名名单。",
    "使用 Docker Compose 启动 API 与 PostgreSQL，通过 OpenAPI 文档验证请求和响应并与前端联调；使用模拟活动与测试账户完成课程展示。",
  ),
)
