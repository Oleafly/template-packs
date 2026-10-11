// ============================================================================
// CTU THESIS INFORMATION CONFIGURATION
// Can Tho University - College of Information and Communication Technology
// ============================================================================

#let info = (
  en: (
    student: (
      name: "{{STUDENT_NAME}}",
      id: "{{STUDENT_ID}}",
      class: "{{STUDENT_CLASS}}",
      major: "{{MAJOR}}",
      program: "{{PROGRAM}}",
    ),
    advisor: (
      name: "{{ADVISOR_NAME}}",
      title: "{{ADVISOR_TITLE}}",
    ),
    thesis: (
      title: "{{THESIS_TITLE}}",
      short_title: "{{SHORT_TITLE}}",
      date: "{{THESIS_DATE}}",
      location: "{{THESIS_LOCATION}}",
      degree: "{{THESIS_DEGREE}}",
    ),
    keywords: (
      "keyword 1",
      "keyword 2",
      "keyword 3",
      "keyword 4",
      "keyword 5"
    ),
    committee: (
      chairman: "Dr. Chairman Name",
      reviewer: "Dr. Reviewer Name",
      advisor: "{{ADVISOR_NAME}}",
    ),
    abbreviations: (
      ("API", "Application Programming Interface"),
      ("CTU", "Can Tho University"),
      ("ICT", "Information and Communication Technology"),
      ("UI/UX", "User Interface/User Experience"),
      ("HTTP", "Hypertext Transfer Protocol"),
    ),
  ),
  vi: (
    student: (
      name: "{{STUDENT_NAME}}",
      id: "{{STUDENT_ID}}",
      class: "{{STUDENT_CLASS}}",
      major: "{{MAJOR_VI}}",
      program: "{{PROGRAM_VI}}",
    ),
    advisor: (
      name: "{{ADVISOR_NAME}}",
      title: "{{ADVISOR_TITLE}}",
    ),
    thesis: (
      title: "{{THESIS_TITLE_VI}}",
      short_title: "{{SHORT_TITLE_VI}}",
      date: "{{THESIS_DATE_VI}}",
      location: "{{THESIS_LOCATION_VI}}",
      degree: "{{THESIS_DEGREE_VI}}",
    ),
    keywords: (
      "từ khóa 1",
      "từ khóa 2",
      "từ khóa 3",
      "từ khóa 4",
      "từ khóa 5"
    ),
    committee: (
      chairman: "TS. Tên Chủ Tịch",
      reviewer: "TS. Tên Phản Biện",
      advisor: "{{ADVISOR_NAME}}",
    ),
    abbreviations: (
      ("API", "Giao diện lập trình ứng dụng"),
      ("CTU", "Đại học Cần Thơ"),
      ("CNTT-TT", "Công nghệ Thông tin và Truyền thông"),
      ("UI/UX", "Giao diện/Trải nghiệm người dùng"),
      ("HTTP", "Giao thức truyền tải siêu văn bản"),
    ),
  ),
)

// ============================================================================
// GLOBAL SETTINGS (CTU STANDARD — Decision 4125/QĐ-ĐHCT 2024)
// ============================================================================
#let settings = (
  primary_lang: "{{LANG}}",

  // CTU Official Colors
  border_color: rgb(0, 51, 153), // CTU Blue (#003399)
  accent_color: rgb(0, 83, 159), // CTU Accent (#00539F)

  // CTU Format Requirements (2025-2026)
  format: (
    font: "Times New Roman",
    font_size: 13pt,
    line_spacing: 1.2,
    margins: (
      left: 4cm,
      right: 2.5cm,
      top: 2.5cm,
      bottom: 2.5cm,
    ),
    paragraph_indent: 1cm,
    abstract_words: (200, 350),
  ),
)
