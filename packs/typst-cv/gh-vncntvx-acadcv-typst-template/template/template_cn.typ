// 中文简历模板
// 编译命令: typst compile --root . --font-path fonts template/CV_zh_template.typ output.pdf

#import "../src/lib.typ": *

// ========== 个人信息 ==========
#let name = "张三"
#let location = "上海，中国"
#let email = "zhangsan@example.com"
#let github = "github.com/zhangsan"
#let phone = "+86 13900000000"
#let personal-site = "zhangsan.example.com"
#let orcid = "0000-0000-0000-0000"

#show: resume.with(
  author: name,
  location: location,
  email: email,
  github: github,
  phone: phone,
  personal-site: personal-site,
  orcid: orcid,
  accent-color: "#2E5090",
  paper: "a4",
  author-position: left,
  personal-info-position: left,
  en-font: "New Computer Modern",
  cjk-font: "Source Han Serif SC",
  en-font-weight: "regular",
  cjk-font-weight: "regular",
  name-weight: "bold",
)

== Profile

- 研究方向：如何优雅地摸鱼、躺平姿势优化、沙发工程学、深度睡眠研究。

== Education

#edu(
  institution: "家里蹲大学",
  school: "摸鱼与躺平学院",
  location: "沙发，卧室",
  dates: dates-helper(start-date: "2020-09", end-date: "2025-06"),
  degree: "博士研究生，划水工程学",
  compact: true,
)

#edu(
  institution: "咸鱼理工学院",
  school: "快乐研究所",
  location: "被窝",
  dates: dates-helper(start-date: "2016-09", end-date: "2020-06"),
  degree: "工学学士，发呆科学与技术",
  gpa: "4.0/4.0",
  compact: true,
)

== Publications

#article(
  authors: ("张三", "李四", "王五"),
  highlight-authors: (0,),
  corresponding-authors: (2,),
  title: "基于深度睡眠的高质量午休优化方法研究",
  journal: "躺平科学学报",
  year: "2025",
  volume: "48",
  issue: "3",
  pages: "521-535",
  doi: "10.12345/tp.2025.00521",
  style: "gb-7714",
  list-style: "number",
)

#article(
  authors: ("Zhang San", "Li Si", "Wang Wu"),
  highlight-authors: (0,),
  corresponding-authors: (1,),
  title: "A Novel Framework for Optimal Couch Allocation in Modern Living Rooms",
  journal: "Journal of Procrastination Studies",
  year: "2024",
  volume: "35",
  issue: "8",
  pages: "10234-10248",
  doi: "10.1109/JPS.2024.1234567",
  style: "ieee",
  list-style: "number",
)

#article(
  authors: ("赵六", "张三", "孙七"),
  highlight-authors: (1,),
  title: "面向快乐生活的数据驱动摸鱼策略研究",
  journal: "摸鱼工程学报",
  year: "2024",
  volume: "50",
  issue: "6",
  pages: "1125-1138",
  note: "(已录用)",
  style: "gb-7714",
  list-style: "number",
)

== Books

#book(
  authors: ("李四", "张三"),
  highlight-authors: (1,),
  title: "躺平学导论：从入门到精通",
  publisher: "快乐出版社",
  location: "沙发",
  year: "2025",
  pages: "256",
  list-style: "none",
)

#book(
  authors: ("王五", "赵六"),
  highlight-authors: (0,),
  title: "摸鱼艺术与修养",
  publisher: "轻松大学出版社",
  location: "被窝",
  year: "2024",
  chapter: "如何科学地划水",
  chapter-authors: ("张三", "李四"),
  pages: "45-78",
  note: "（章节第一作者）",
  list-style: "none",
)

== Manuscripts under Review

#article(
  authors: ("张三", "王五", "李四"),
  highlight-authors: (0,),
  corresponding-authors: (0,),
  title: "基于强化学习的奶茶选择决策优化模型",
  journal: "快乐生活研究",
  list-style: "bullet",
)

== Patents & Software Copyrights

#patent(
  authors: ("张三", "李四", "王五"),
  highlight-authors: (0,),
  title: "一种智能午休闹钟系统及方法",
  patent-number: "CN119XXXXXXXA",
  publication-date: "2024-08-15",
  patent-type: "发明专利",
  country: "中国",
  status: "实质审查",
  note: "排名 1/3",
)

#software(
  authors: ("张三", "李四"),
  highlight-authors: (0,),
  title: "快乐摸鱼助手",
  version: "2.0",
  date: "2024-05-20",
  country: "中国",
  number: "2024SR05XXXXX",
  note: "排名 1/2",
)

== Research Projects

#research-project(
  name: "面向快乐生活的午休质量提升关键技术研究",
  funding: "国家自然科学基金重点项目",
  role: "项目骨干",
  dates: "2023-2027",
)

#research-project(
  name: "智能化摸鱼辅助系统研发",
  funding: "国家重点研发计划子课题",
  role: "核心成员",
  dates: "2022-2025",
)

#research-project(
  name: "沙发舒适度智能监测与优化平台",
  funding: "躺平协会委托项目",
  role: "技术负责人",
  dates: "2024-2025",
)

== Work Experience

#work(
  title: "快乐实习生",
  company: "躺平科技有限公司",
  location: "沙发",
  dates: dates-helper(start-date: "2023-06", end-date: "2023-09"),
)

- 负责午休环境优化与睡眠质量监测
- 参与摸鱼效率提升系统的设计与实现

== Projects

#project(
  name: "智能奶茶推荐系统",
  role: "项目负责人",
  url: "github.com/zhangsan/bubble-tea-ai",
  dates: "2023",
)
- 设计并实现基于口味偏好的奶茶推荐算法
- 系统支持糖度、冰度、配料的智能匹配

== Honors & Awards

#award(
  title: "年度最佳躺平奖",
  issuer: "国际躺平协会",
  date: "2024",
)

#award(
  title: "优秀摸鱼研究生",
  issuer: "家里蹲大学",
  note: "摸鱼之星",
  date: "2023",
)

#award(
  title: "Best Napping Award",
  issuer: "World Procrastination Conference",
  date: "2024",
)

== Certificates

#certificates(
  name: "高级午休规划师认证",
  issuer: "国家睡眠研究会",
  url: "sleep.example.org",
  date: "2023-11",
)

#certificates(
  name: "专业奶茶品鉴师（一级）",
  issuer: "奶茶爱好者协会",
  date: "2022-05",
)

== Extracurriculars

#extracurriculars(
  activity: "沙发躺平协会会长",
  dates: "2021-2023",
)

#extracurriculars(
  activity: "奶茶品鉴社技术顾问",
  dates: "2020-2022",
)
