// ============================================================================
// INTERNATIONALIZATION DICTIONARY (CTU STANDARD)
// Contains official CTU terminology in English and Vietnamese
// ============================================================================

#let dict = (
  en: (
    // Organization (CTU Official)
    ministry: "MINISTRY OF EDUCATION AND TRAINING",
    university: "CAN THO UNIVERSITY",
    college: "COLLEGE OF INFORMATION AND COMMUNICATION TECHNOLOGY",
    department: "DEPARTMENT OF SOFTWARE ENGINEERING",
    
    // Document Type
    thesis_type: "GRADUATION THESIS",
    in_major: "IN",
    
    // Labels
    student_label: "Student:",
    student_id_label: "Student ID:",
    class_label: "Class:",
    advisor_label: "Advisor:",
    keywords_label: "Keywords:",
    
    // Headings
    figure: "Figure",
    table: "Table",
    toc: "TABLE OF CONTENTS",
    lof: "LIST OF FIGURES",
    lot: "LIST OF TABLES",
    ref: "REFERENCES",
    appendix: "APPENDICES",
    part: "PART",
    chapter: "CHAPTER",
    
    // Front Matter
    abbreviations_title: "LIST OF ABBREVIATIONS",
    abbreviations_term: "Abbreviation",
    abbreviations_desc: "Description",
    abstract_title: "ABSTRACT",
    acknowledgments_title: "ACKNOWLEDGEMENTS",
    evaluation_title: "EVALUATION OF ADVISOR",
  ),
  vi: (
    // Organization (CTU Official Vietnamese)
    ministry: "BỘ GIÁO DỤC VÀ ĐÀO TẠO",
    university: "ĐẠI HỌC CẦN THƠ",
    college: "TRƯỜNG CÔNG NGHỆ THÔNG TIN VÀ TRUYỀN THÔNG",
    department: "KHOA CÔNG NGHỆ PHẦN MỀM",
    
    // Document Type
    thesis_type: "LUẬN VĂN TỐT NGHIỆP",
    in_major: "NGÀNH",
    
    // Labels
    student_label: "Sinh viên thực hiện:",
    student_id_label: "MSSV:",
    class_label: "Lớp:",
    advisor_label: "Cán bộ hướng dẫn:",
    keywords_label: "Từ khóa:",
    
    // Headings
    figure: "Hình",
    table: "Bảng",
    toc: "MỤC LỤC",
    lof: "DANH MỤC HÌNH",
    lot: "DANH MỤC BẢNG",
    ref: "TÀI LIỆU THAM KHẢO",
    appendix: "PHỤ LỤC",
    part: "PHẦN",
    chapter: "CHƯƠNG",
    
    // Front Matter
    abbreviations_title: "DANH MỤC TỪ VIẾT TẮT",
    abbreviations_term: "Từ viết tắt",
    abbreviations_desc: "Diễn giải",
    abstract_title: "TÓM TẮT",
    acknowledgments_title: "LỜI CẢM ƠN",
    evaluation_title: "NHẬN XÉT CỦA CÁN BỘ HƯỚNG DẪN",
  ),
)

// Helper function to retrieve a term
#let term(lang, key) = {
  let lang-dict = dict.at(lang, default: dict.en)
  lang-dict.at(key, default: key)
}
