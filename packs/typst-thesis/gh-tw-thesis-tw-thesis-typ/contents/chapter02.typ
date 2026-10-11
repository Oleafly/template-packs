#import "/helper/mod.typ": *

= 版面設定 <cha:layout>

完成第一章的設定後，請先編譯一次，對照系所要求檢查字級、行距與頁面邊界，再調整需要修改的項目。本章會依序說明這些設定的位置與用法，建議一次修改一項，確認排版結果後再繼續。

下面的 `YAML` 範例都可以直接寫進 `config.yml` 覆蓋。若檔案裡已經有 `layout:`，請將新增的設定放在原有區塊下，保留範例中的縮排，不要再建立第二個同名區塊。

== 字體與字級

請先打開 `config.yml`，在 `layout:` 下設定本文的字型與字級。以下列出預設使用的字型；若目前顯示正常，可以先保留這些值，只調整系所要求的項目。

#code[
  ```yaml
  layout:
    language: "chinese" # chinese | english 決定標題語言
    font-latin: ["EB Garamond", "Tinos"] # 可填一個或多個，依序尋找
    font-cjk: ["TW-MOE-Std-Kai", "DFKai-SB"]
    font-size: 12 # pt
  ```
]

模板會依字型清單的順序尋找可用的字元，先使用 `font-latin`，再由 `font-cjk` 補上缺少的字。以上面的設定為例，英文優先使用 EB Garamond，它缺少的字元再由 Tinos 補上（Tinos 是字寬與 Times New Roman 完全相同的開源字型），中文則優先使用#link("https://language.moe.gov.tw/material/info?m=9fe3fe82-8bbf-44c0-961d-873ea079e284")[教育部標準楷書]（授權條款為創用 CC 姓名標示─禁止改作，引用時須標示「中華民國教育部」）。這些字型檔都已經附在專案的 `fonts/` 裡，編譯時保留下面這個參數即可。兩套英文字型的授權都是 SIL OFL 1.1，可以自由散布。若系所明確要求 Times New Roman，可以把 `font-latin` 改成 `"Tinos"`：它的字寬與 Times New Roman 逐字相同，字形也相近，分頁位置不會跑掉；若一定要用原字型，因它有散布限制、模板無法附上，需先在自己的電腦安裝，再填入 `"Times New Roman"`。EB Garamond 的字寬與 Times New Roman 不同（平均約差 7%），換過去後整份論文的分頁位置會改變：

#code[
  ```bash
  --font-path fonts/
  ```
]

若要換成系統或系所指定的其他字型，把字型名稱填進 `font-latin` 或 `font-cjk` 就好。這裡容易卡住的地方是：填的名稱要和字型檔內記載的家族名稱一致，而不是安裝畫面或字型網站上顯示的名稱，兩者有時不同。#ref(<tbl:font-name>)列出幾種常見情境下查詢家族名稱的方式。

#tlt(
  caption: [查詢字型家族名稱],
  columns: (auto, 1fr),
  align: (left + horizon, left + horizon),
  header: ([情境], [查詢方式]),
  rows: (
    (
      [字型檔已經放進 `fonts/`],
      [執行 `typst fonts --font-path fonts/`，印出的名稱就是 Typst 實際讀到的家族名，直接填入設定檔最準確。],
    ),
    (
      [macOS 已安裝的字型],
      [開啟字體簿（Font Book），點選字型後即可看到名稱。],
    ),
    (
      [Windows 已安裝的字型],
      [開啟「設定 → 個人化 → 字型」，點進字型頁面即可看到名稱。],
    ),
    (
      [從 Google Fonts 等網站下載],
      [頁面上顯示的名稱通常就是家族名，但下載後仍建議放進 `fonts/` 用 `typst fonts` 再確認一次。],
    ),
  ),
  notes: [不確定時，一律以放進 `fonts/` 後 `typst fonts --font-path fonts/` 印出的名稱為準。],
) <tbl:font-name>

若要把本文改成 14 點，請在 `layout:` 下將 `font-size` 改為 `14`，不需要在數字後面加上單位。修改後可以找一頁中英混排的內文，檢查兩種文字的大小是否合適。章節標題有各自的字級設定，需到後面的 `heading:` 區塊另外調整。

== 行高與段落

本文的行距、段距、首行縮排與左右對齊都放在 `layout:` 下。可以先挑一頁有數個完整段落的內文，套用下面的設定，再比較行與行、段與段之間的距離，以及各段開頭的位置。

#code[
  ```yaml
  layout:
    line-height: 1.5      # 行高 1.5 倍
    par-spacing: 1.2      # em，段落之間的間距
    first-line-indent: 2  # em，中文習慣首行縮排兩個字
    justify: true         # 左右對齊
    line-box:             # em，見下方說明
      top: 0.88
      bottom: -0.12
  ```
]

調整段落時，可以先從 `line-height` 與 `first-line-indent` 開始。本文為 12 點、行高設為 `1.5` 時，一般文字行的基線間距為 18 點；首行縮排設為 `2`，則會留出兩個字寬的空間。若系所要求段落不縮排，將 `first-line-indent` 改為 `0` 即可。

`par-spacing` 控制兩個段落之間的間距，預設為 `1.2`，單位是 `em`；在 `YAML`中只需填數字，不要加上單位。值越大，段落之間的留白越多。章節原始碼中以空白行分隔的文字會形成不同段落，可以用相鄰的兩段文字觀察調整結果。

若希望段落之間維持一般行距、不額外留白，可將 `par-spacing` 設為 `0`。#typst 會取段距與行間留白 `par(leading)` 中較大的值，因此段落不會因為設為 `0` 而重疊。模板將 `line-height` 減去 `1` 後換算成 em 作為 `leading`；例如 `line-height: 1.5` 對應 `0.5em`，此時將 `par-spacing` 設為 `0.5` 或更小，都不會增加段間留白。

`line-box` 用來設定文字行的上下緣，預設兩者相差 1em，供模板計算行距。初次調整時，請先保留 `top` 與 `bottom` 的數值，從一般文字段落觀察行距即可。若段落中還有較高的公式或圖片，再檢查該行是否需要額外的空間。

== 邊界與紙張

紙張大小由 `paper` 決定，四邊留白則在 `margin:` 下分別設定。以下使用 A4 紙張；若已選擇學校格式，請先查看套用結果，只加入需要覆蓋的邊界數值即可。

#code[
  ```yaml
  layout:
    paper: "a4"
    margin: # cm
      top: 3
      bottom: 2
      left: 3
      right: 3
  ```
]

請在 `margin:` 下填入四個方向的邊界，單位為公分，直接寫數字即可。例如系所要求左側留 3.5 公分，就將 `left` 設為 `3.5`，不要寫成 `3.5cm`。若只修改左側，其餘三邊仍會沿用學校設定或預設值，不必全部重寫。

修改後，請同時查看正文與封面，確認標題、圖表和封面資料是否仍放得下。模板目前沒有獨立的封面邊界設定，封面各區塊另以固定間距與彈性間距安排位置；若論文題目較長，可以再調整 `cover:` 下的字級或間距，避免文字擠在一起。

== 標題與編號

章節標題的字級、對齊方式與前後間距，都集中在 `layout.heading` 區。下列各組清單依照標題層級排列，可以先對照章、節與小節的外觀，再調整對應位置的數值。

#code[
  ```yaml
  layout:
    heading:
      size: [18, 16, 14, 12]                     # pt，第 1 至 4 層
      weight: "regular"                          # regular | bold
      align: ["center", "center", "left", "left"]
      line-height: 1.2                           # 標題內部的行距
      gap-above: [1, 0.8, 0.8, 0.6]              # em
      gap-below: [1, 0.5, 0.4, 0.3]              # em
      number-gap: [1, 1, 0, 0]                   # em，編號與標題之間
  ```
]

上面的清單依序對應第一至第四層標題。例如要調整章標題的字級，就修改 `size` 的第一個數值；要調整節標題，則修改第二個數值。建議先保留四個位置，只更換需要的值，方便對照各層的設定。

若要修改編號前後的文字，請在 `config.yml` 另外加入 `strings:`，與 `layout:` 放在同一層。以下範例會讓章、節分別使用「第一章」與「第一節」的寫法：

#code[
  ```yaml
  strings:
    chapter: ["第", "章"]   # 第一章
    section: ["第", "節"]   # 第一節
    subsection: "、"        # 一、
    appendix: ["附錄 ", ""] # 附錄 A
  ```
]

回到章節檔案後，在標題前加上 `=` 即可指定層級。一個 `=` 代表章標題，兩個代表節標題，依此類推。請在等號與標題文字之間留一個空白，並依照內容的層次安排：

#code[
  ```typ
  = 研究方法      // 第一層，章號依出現順序自動產生
  == 實驗設計     // 第二層，印成第一節
  === 資料來源    // 第三層，印成一、
  ==== 前處理     // 第四層，不編號
  ```
]

編譯時，第一層標題會自動另起一頁，章號也會依出現順序產生。因此標題只需寫「研究方法」，不必手動加上「第三章」或插入換頁指令。新增或調整章節順序後，重新編譯就會更新編號。

== 圖表與程式碼的標題位置 <sec:caption>

圖片、表格與程式碼的標題位置可以分別設定。請在 `config.yml` 的 `layout:` 下找到 `caption-position:`，將要調整的項目設為 `"top"` 或 `"bottom"`，分別代表放在內容上方或下方。以下是目前的預設值：

#code[
  ```yaml
  layout:
    caption-position:
      image: "bottom"    # 圖片標題放在下方
      table: "bottom"    # 表格標題放在下方
      code: "bottom"     # 程式碼標題放在下方
  ```
]

例如要將所有表格的標題移到上方，只需把 `table` 改為 `"top"`，圖片與程式碼不會跟著改變。圖片的設定也會套用到並排與網格圖片的總標題。修改後重新編譯，檢查標題與內容的位置即可，不需要逐一修改各章的圖表。

== 目次與頁碼

目次的收錄層級、縮排與頁碼格式都放在 `outline:` 下，與 `layout:` 位於同一層。以下列出常用設定，初次使用時可以先保留預設值，等章節內容齊全後再調整。

#code[
  ```yaml
  outline:
    depth: 3            # 目次收到第幾層
    indent: 1           # em，每層縮排一個字
    title-size: 16      # pt，目次、圖次、表次的字級
    page-numbering: "i" # 前置部分：i, ii, iii
    body-numbering: "1" # 正文開始：1, 2, 3
    entry-gap: 1        # em，章與章之間的間距
    entry-bold: true    # 章標題在目次裡加粗
  ```
]

目次會依照章節標題自動產生，圖次與表次則整理文件中的圖片和表格。若只想在目次中列出章與節，將 `depth` 改為 `2` 即可，正文的標題仍會保留原有層級。編譯後可以點擊目次條目，確認是否跳到對應位置。

要修改這三頁的標題，請在 `titles:` 下設定文字。字串中的 `~` 會轉成字距，例如 `"目~次"` 會拉開兩個字的間隔；若要直接顯示「目錄」，填入 `"目錄"` 即可：

#code[
  ```yaml
  titles:
    toc: "目~次"   # 有些學校用「目錄」
    lof: "圖~次"
    lot: "表~次"
  ```
]

頁碼的位置與顯示文字放在 `page-number:` 下，與 `outline:` 位於同一層。以下都是預設值，不修改也能直接使用：

#code[
  ```yaml
  page-number:
    position: "bottom" # top：頁首；bottom：頁尾
    align: "center"    # left：靠左；center：置中；right：靠右
    format: "{page}"   # {page} 會替換成該頁的頁碼
  ```
]

各項設定可依下表調整。將 `position` 設為 `"top"`、`align` 設為 `"right"`，頁碼就會移到頁首靠右。

#tlt(
  caption: [頁碼設定參數],
  columns: (7em, 1fr),
  align: left + horizon,
  header: ([參數], [用途與範例]),
  rows: (
    ([`position`], [位置：`"top"` 頁首、`"bottom"` 頁尾（預設）。]),
    ([`align`], [對齊：`"left"`、`"center"`（預設）、`"right"`。]),
    ([`format`], [顯示文字：`"第 {page} 頁"`；設為 `""` 可隱藏頁碼。]),
  ),
)

`format` 中的 `{page}` 會替換成頁碼，例如 `"第 {page} 頁"` 顯示為「第 1 頁」；也可以寫成 `"論文・{page}"`。其他文字會直接顯示，不會當成 #typst 語法執行。

`outline.page-numbering` 與 `outline.body-numbering` 分別控制前置部分與正文的編號方式，預設為小寫羅馬數字與阿拉伯數字。`page-number.format` 只調整頁首或頁尾的文字，目次仍保留原本的頁碼格式。封面與審定書不顯示頁碼。完成章節調整後，請檢查正文第一頁與目次所列的頁碼，確認兩者對應正確。

== 浮水印與定稿

提交前若需要加上浮水印，請先檢查學校設定是否已指定圖片。需要自行指定時，可以在 `config.yml` 加入下列區塊，將 `image` 改成要使用的圖檔路徑，再調整大小與深淺。

#code[
  ```yaml
  watermark:
    image: "/assets/watermarks/nccu.pdf"
    width: 100    # %，佔頁寬的比例，置中
    opacity: 100  # %，100 是原圖深淺，50 會刷淡一半
  ```
]

設定好圖片後，執行 `just release`，再打開 PDF 的正文頁面查看浮水印。一般的 `just compile` 不會啟用浮水印，封面與前置頁面也不會加上。若 `image` 的值是 `~`，表示沒有指定圖片，即使執行 `just release` 也不會顯示。

若要換成自己的浮水印，請先將圖片放進 `assets/watermarks/`，再修改 `image` 的路徑。可以用 `width` 調整圖片占頁寬的比例，或降低 `opacity`，讓浮水印淡一些。是否需要自行加上浮水印，請依提交時的學校要求處理。

沒有安裝 `just` 時，也可以在專案根目錄執行以下指令，輸出的檔案同樣是 `main.pdf`：

```bash
typst compile main.typ --font-path fonts/ --input watermark=true
```
