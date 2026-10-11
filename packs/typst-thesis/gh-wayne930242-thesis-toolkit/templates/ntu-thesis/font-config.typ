// NTU Thesis Font Configuration
// 台大論文模板字體配置檔案 - 整合版
// 根據可用字體優化配置，支援現代化學術寫作需求

// ==================== 字體配置方案 ====================
// 配置原則：
// 1. 主文：宋體優先（思源宋體等現代宋體）
// 2. 標題：使用跨平台可取得的思源字體
// 3. 英文字體優先於中文字體（避免中文字體的英文部分）
// 4. 使用現代開源字體替代傳統字體

// 正文字體配置（宋體優先）
#let ntu-fonts = (
  // === 英文字體（最高優先，避免中文字體的英文部分） ===
  "Libertinus Serif",           // 高品質襯線字體，類似 Times New Roman
  "New Computer Modern",        // 現代 Computer Modern - 可用
  
  // === 現代宋體字體（按優先順序） ===
  "Noto Serif TC",              // 思源宋體繁體 - 已有，現代化設計
  "Noto Sans TC",               // 思源黑體繁體 - 備選
)

// 標題專用字體配置
#let ntu-heading-fonts = (
  // === 英文標題字體（最高優先） ===
  "Libertinus Serif",           // 與正文一致的襯線字體
  "New Computer Modern",        // 學術風格 - 可用
  
  // === 跨平台中文字體 ===
  "Noto Serif TC",              // 思源宋體 - 標題首選
  "Noto Sans TC",               // 思源黑體 - 已有，現代設計，用於標題
)

// 數學字體配置
#let ntu-math-fonts = (
  "New Computer Modern Math",   // 現代數學字體 - 可用
  "New Computer Modern",        // 備選字體
)

// 等寬字體配置（程式碼等）
#let ntu-mono-fonts = (
  "DejaVu Sans Mono",          // 系統預設等寬字體 - 可用
  "New Computer Modern",        // 現代等寬字體備選
)

// ==================== 字體應用函數 ====================

// 字體可用性測試函數
#let check-font-availability() = [
  #text(font: ntu-fonts)[測試中文字體：繁體中文顯示測試]
  #linebreak()
  #text(font: ntu-fonts)[Test English Font: Available fonts working properly]
  #linebreak()
  #text(font: ntu-mono-fonts)[Code font test: `console.log("Hello World")`]
  #linebreak()
  #text(font: ntu-heading-fonts)[標題字體測試：楷體風格展示]
]

// 基本字體設定（正文）
#let set-ntu-fonts() = {
  set text(font: ntu-fonts, size: 12pt, lang: "zh", region: "TW")
}

// 標題字體設定
#let set-ntu-heading-fonts() = {
  set text(font: ntu-heading-fonts)
}

// 數學字體設定
#let set-ntu-math-fonts() = {
  set math.equation(numbering: "(1)")
  show math.equation: set text(font: ntu-math-fonts)
}

// 等寬字體設定（程式碼等）
#let set-ntu-mono-fonts() = {
  show raw: set text(font: ntu-mono-fonts)
}

// 統一字體設定（推薦使用）
#let setup-ntu-fonts(doc) = {
  set text(font: ntu-fonts, size: 12pt, lang: "zh", region: "TW")
  set heading(numbering: "1.")
  show raw: set text(font: ntu-mono-fonts)
  show math.equation: set text(font: ntu-math-fonts)
  doc
}

// ==================== 可用字體資訊 ====================

// 可用字體總覽
#let available-fonts-info() = [
  == 目前可用字體配置
  
  === 中文字體
  - *TW-MOE-Std-Kai*: edukai-5.0 正統楷體（推薦標題使用）
  - *Noto Serif TC*: 思源宋體繁體（推薦正文使用）
  - *Noto Sans TC*: 思源黑體繁體（現代標題選擇）
  - *Xiangcui Kesong*: 香萃刻宋字體（楷體風格替代）
  
  === 英文字體  
  - *Libertinus Serif*: 高品質襯線字體，類似 Times New Roman
  - *New Computer Modern*: 現代學術字體，優秀數學支援
  - *DejaVu Serif*: 可靠的系統襯線字體
  - *DejaVu Sans*: 清晰的無襯線字體
  
  === 特殊用途字體
  - *DejaVu Sans Mono*: 程式碼專用等寬字體
  - *New Computer Modern Math*: 數學公式專用字體
] 

// ==================== 使用說明 ====================
// 字體載入需要設定正確的字體路徑：
// 編譯指令：typst compile --root . --font-path fonts 你的檔案.typ
//
// 使用方法：
// #import "font-config.typ": *
// #show: setup-ntu-fonts
//
// 或分別設定：
// #set-ntu-fonts()           // 設定正文字體
// #set-ntu-heading-fonts()   // 設定標題字體  
// #set-ntu-math-fonts()      // 設定數學字體
// #set-ntu-mono-fonts()      // 設定等寬字體
