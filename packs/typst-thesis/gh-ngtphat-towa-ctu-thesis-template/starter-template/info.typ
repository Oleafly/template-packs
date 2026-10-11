// ============================================================================
// CTU THESIS INFORMATION CONFIGURATION
// Can Tho University - College of Information and Communication Technology
// ============================================================================

#let info = (
  en: (
    student: (
      name: "John Doe",
      id: "B2026001",
      class: "Your Class",
      major: "INFORMATION TECHNOLOGY",
      program: "High-Quality Program",
    ),
    advisor: (
      name: "Dr. Advisor Name",
      title: "Dr.", // Academic title
    ),
    thesis: (
      title: "E-Commerce Platform",
      short_title: "SHORT TITLE FOR HEADERS", // Max 50 characters
      date: "December 2025",
      location: "Can Tho",
      degree: "BACHELOR OF ENGINEERING",
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
      advisor: "Dr. Advisor Name",
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
      name: "John Doe",
      id: "B2026001",
      class: "Lớp Của Bạn",
      major: "Công nghệ Thông tin",
      program: "Chất lượng cao",
    ),
    advisor: (
      name: "TS. Tên GVHD",
      title: "TS.",
    ),
    thesis: (
      title: "E-Commerce Platform",
      short_title: "TIÊU ĐỀ NGẮN", // Tối đa 50 ký tự
      date: "Tháng 12/2025",
      location: "Cần Thơ",
      degree: "KỸ SƯ",
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
      advisor: "TS. Tên GVHD",
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
// GLOBAL SETTINGS (CTU STANDARD)
// ============================================================================
#let settings = (
  primary_lang: "en",
  
  // CTU Official Colors
  border_color: rgb(0, 51, 153), // CTU Blue (#003399)
  accent_color: rgb(0, 83, 159), // CTU Accent (#00539F)
  
  // CTU Format Requirements (2025-2026)
  format: (
    font: "Times New Roman",
    font_size: 13pt,
    line_spacing: 1.2,      // Main text: 1.2 spacing
    margins: (
      left: 4cm,            // CTU Standard: 4cm left
      right: 2.5cm,         // CTU Standard: 2.5cm other sides
      top: 2.5cm,
      bottom: 2.5cm,
    ),
    paragraph_indent: 1cm,  // First line indent
    abstract_words: (200, 350), // Min-max words
  ),
)
