// === 頁碼工具函數 ===

// 開始羅馬數字頁碼（用於前置頁面）
#let begin-roman-numbering(doc) = {
  set page(numbering: "i")
  counter(page).update(1)
  doc
}

// 開始阿拉伯數字頁碼（用於正文）
#let begin-arabic-numbering(doc) = {
  set page(numbering: "1")
  counter(page).update(1)
  doc
} 