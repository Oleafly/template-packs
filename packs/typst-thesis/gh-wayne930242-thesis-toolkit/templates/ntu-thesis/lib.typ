#import "layouts/whole.typ": whole
#import "layouts/mainmatter.typ": mainmatter
#import "pages/cover.typ": make-cover
#import "pages/verification.typ": make-verification
#import "pages/abstract.typ": make-abstract-zh, make-abstract-en
#import "pages/acknowledgement.typ": make-acknowledgement
#import "pages/outline.typ": make-outline
#import "pages/ref.typ": make-ref
#import "utils/page-numbering.typ": begin-roman-numbering, begin-arabic-numbering

#let setup(
  // 基本設定
  university: "國立臺灣大學",
  university-en: "National Taiwan University", 
  college: "工學院",
  college-en: "College of Engineering",
  institute: "工業工程學研究所",
  institute-en: "Institute of Industrial Engineering",
  
  // 學位設定
  degree: (master: true, doctor: false),
  degree-zh: "碩士",
  degree-en: "Master's",
  type-zh: "論文", 
  type-en: "Thesis",
  
  // 個人資訊
  title: (zh: "", en: ""),
  author: (zh: "", en: ""),
  advisor: (zh: "", en: ""),
  co-advisor: (), // 共同指導教授陣列
  student-id: "",
  
  // 日期設定
  date: "",
  oral-date: "",
  
  // 語言設定
  main-lang: (zh: true, en: false),
) = {
  
  // 參數驗證
  assert(
    degree.master or degree.doctor,
    message: "必須設定學位類型 (master 或 doctor)！"
  )
  assert(
    (degree.master and not degree.doctor) or (degree.doctor and not degree.master),
    message: "學位類型只能選擇一種！"
  )
  assert(institute != "", message: "必須設定研究所名稱！")
  assert(title.zh != "" and title.en != "", message: "必須設定中英文論文題目！")
  assert(author.zh != "" and author.en != "", message: "必須設定中英文作者姓名！")
  assert(advisor.zh != "" and advisor.en != "", message: "必須設定中英文指導教授姓名！")
  assert(
    main-lang.zh or main-lang.en,
    message: "必須設定主要語言！"
  )
  assert(
    (main-lang.zh and not main-lang.en) or (main-lang.en and not main-lang.zh),
    message: "主要語言只能選擇一種！"
  )
  
  // 返回模組化函數
  return (
    // === 頁面元件 ===
    make-cover: () => {
      make-cover(
        university: university,
        university-en: university-en,
        college: college,
        college-en: college-en,
        institute: institute,
        institute-en: institute-en,
        degree-zh: if degree.master { "碩士" } else { "博士" },
        degree-en: if degree.master { "Master's" } else { "Doctor's" },
        type-zh: if degree.master { "論文" } else { "學位論文" },
        type-en: if degree.master { "Thesis" } else { "Dissertation" },
        title: title,
        author: author,
        advisor: advisor,
        co-advisor: co-advisor,
        student-id: student-id,
        date: date,
      )
    },
    
    make-verification: () => {
      make-verification(
        university: university,
        institute: institute,
        degree-zh: if degree.master { "碩士" } else { "博士" },
        type-zh: if degree.master { "論文" } else { "學位論文" },
        title: title,
        author-zh: author.zh,
        student-id: student-id,
        oral-date: oral-date,
      )
    },
    
    make-abstract-zh: (content, keywords: ()) => {
      make-abstract-zh(content, keywords: keywords)
    },
    
    make-abstract-en: (content, keywords: ()) => {
      make-abstract-en(content, keywords: keywords)
    },
    
    make-acknowledgement: (content) => {
      make-acknowledgement(content)
    },
    
    make-outline: () => {
      make-outline()
    },
    
    make-ref: (bibliography-content) => {
      make-ref(bibliography-content)
    },
    
    // === 佈局元件 ===
    whole: (doc) => {
      whole(main-lang: main-lang, doc)
    },
    
    mainmatter: (doc) => {
      mainmatter(doc)
    },
    
    // === 工具函數 ===
    begin-roman-numbering: (doc) => {
      begin-roman-numbering(doc)
    },
    
    begin-arabic-numbering: (doc) => {
      begin-arabic-numbering(doc)
    },
  )
} 
// Re-exported so documents can import everything from the package entrypoint.
#import "font-config.typ": ntu-fonts, ntu-heading-fonts, ntu-math-fonts, ntu-mono-fonts, check-font-availability, setup-ntu-fonts
#import "layouts/no-watermark.typ": no-watermark-layout
#import "chapter-bib.typ": chapter-bib
