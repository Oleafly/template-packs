#import "/helper/mod.typ": abstract-en, abstract-zh, cfg

#abstract-zh(keywords: cfg.keywords)[
  撰寫中文摘要時，請先打開 `contents/front/abstract.typ`，找到 `abstract-zh` 區塊，將方括號內的說明換成自己的內容。外層的函式與括號請保留，模板會自動加入「摘要」標題，段落之間空一行即可。

  內容可以先交代研究問題，再依序說明方法、主要結果與結論。整理結果時，盡量寫出實際觀察到的差異或數據，讓讀者知道這項研究得到什麼發現。完成初稿後，可以暫時不看正文，單獨讀一次摘要，確認研究的目的與結果是否交代清楚。

  摘要下方的關鍵字由 `config.yml` 帶入，請在 `keywords` 填寫中文關鍵字。英文摘要則寫在同一個檔案的 `abstract-en` 區塊，並搭配 `keywords-en` 使用。兩種摘要填好後，請重新編譯，檢查分頁與關鍵字的位置，再比對中英文的內容是否一致。
]

#abstract-en(keywords: cfg.keywords-en)[
  Open `contents/front/abstract.typ` and find the `abstract-en` block. Replace the text inside the square brackets with your English abstract, keeping the function call and brackets in place. Leave a blank line between paragraphs; the template will add the heading.

  Begin with the research question, then describe the method, main findings, and conclusion. Include specific results where possible. Once the draft is ready, compare it with the Chinese abstract to check that the findings and terminology agree.

  To change the keywords below the abstract, edit `keywords-en` in `config.yml`. Compile the document again after updating both abstracts, and check the page breaks and the position of the keywords.
]
