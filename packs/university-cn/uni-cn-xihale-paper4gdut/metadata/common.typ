// 统一元数据配置
// 在此填写公共信息，根据文档类型自动提取有效字段

#let metadata = (
  // ========== 基本信息 ==========
  title: "",           // 题目/课程设计题目
  title_en: "",        // 外文题目（仅论文需要）
  author: "",          // 作者姓名
  student_id: "",      // 学号
  advisor: "",         // 指导教师
  major: "",           // 专业名称
  school: "",          // 学院名称
  class_info: "",      // 年级班别
  date: datetime.today(),

  // ========== 论文专用 ==========
  abstract_cn: [],     // 中文摘要
  keywords_cn: (),     // 中文关键词
  abstract_en: [],     // 英文摘要（可选）
  keywords_en: (),     // 英文关键词（可选）

  // ========== 课程设计专用 ==========
  grade: "",           // 成绩（可选）

  // ========== 通用 ==========
  header_text: none    // 页眉文字（默认使用题目）
)
