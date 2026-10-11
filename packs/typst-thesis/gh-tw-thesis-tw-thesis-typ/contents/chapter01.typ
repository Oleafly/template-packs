#import "/helper/mod.typ": *

= 開始使用

初次使用時，請先保留範例檔案，按照本章的步驟編譯一次，確認能正常產生 PDF，並檢查中文字型與頁面是否顯示正確。完成後，再填入自己的論文資料，逐章替換標題與內文。建議每改完一個部分就重新編譯，若出現錯誤，也比較容易找出是哪一處修改造成的。

這份教學的原始檔都放在 `contents/`，各章的內容與 PDF 中的章節相互對應。看到想使用的圖表、引用或程式碼排版時，可以打開對應章節，複製範例，再換成自己的文字與資料即可。不熟悉的語法可以先保留原樣，對照編譯結果逐項調整，確認效果後再套用到其他章節。

== 安裝與編譯

在正式開始編譯與撰寫之前，需先安裝 #link("https://typst.app/open-source/")[#typst]。下面三行是不同的安裝方式，依自己的環境選一行執行即可；使用 `brew`、`winget` 或 `cargo` 前，電腦上須先有對應的套件管理工具。

#code[
  ```bash
  brew install typst                # macOS
  winget install --id Typst.Typst   # Windows
  cargo install --locked typst-cli  # 任何平台
  ```
]

安裝後，在終端機切換到專案根目錄，也就是放有 `main.typ` 的資料夾，執行下列指令：

```bash
typst compile main.typ --font-path fonts/
```

完成後會在同一個資料夾產生 `main.pdf`。打開 PDF，確認中文能正常顯示，其中

#code[
  ```bash
  --font-path fonts/
  ```
]

會讓 #typst 讀取專案附帶的字型，不必另外安裝到系統。

若已安裝 #link("https://github.com/casey/just")[`just`] 建置工具（單一執行檔，`brew install just` 或依官網說明安裝），也可以使用下列指令，執行專案 `justfile` 中定義的編譯工作：

#code[
  ```bash
  just compile   # 輸出 main.pdf（草稿，沒有浮水印）
  just watch     # 存檔就重新編譯
  just release   # 定稿，加上學校浮水印
  just clean     # 刪掉 main.pdf
  ```
]

撰寫論文時，可以在專案根目錄執行 `just watch`，啟動*監視模式*。指令執行後會持續監看檔案；每次修改並儲存論文內容或設定，#typst 就會重新編譯，成功後更新同一份 `main.pdf`，不必每次手動執行編譯指令。使用期間請保持該終端機開啟；要停止監看時，切回終端機並按下 `Ctrl+C`。

需要輸出含浮水印的版本時，請先停止監視模式，再執行 `just release`。該指令會加入


#code[
  ```bash
  --input watermark=true
  ```
]


依設定檔指定的圖片產生浮水印，編譯完成後便會結束，不會持續監看檔案。請注意，`just watch` 與 `just release` 都使用 `main.pdf` 作為輸出檔名；若之後重新啟動 `just watch`，PDF 會再次被不含浮水印的草稿版本覆寫。

== 專案結構

下載或複製專案後，可以先花時間認識各個資料夾的用途，之後要改任何內容就知道該打開哪個資料夾或是檔案。#ref(<tbl:layout>)是整個專案的檔案與目錄一覽：

#tlt(
  caption: [目錄與檔案],
  columns: (auto, 1fr),
  align: (left + horizon, left + horizon),
  header: ([路徑], [用途]),
  rows: (
    ([`config.yml`], [你的論文資料：題目、作者、系所、日期、關鍵字]),
    ([`main.typ`], [裝訂順序：前置、各章、參考文獻、附錄]),
    ([`contents/`], [論文內容。`front/` 是摘要與致謝，`back/` 是附錄與 `.bib`]),
    ([`schools/`], [各校格式設定。`default.yml` 是唯一的預設值來源]),
    ([`lib/`], [模板核心，跟哪一本論文無關，一般不用改]),
    ([`helper/`], [這本論文專用的工具：圖片、三線表、程式碼樣式]),
    ([`misc/`], [#typst 標誌、假文工具與文字資料]),
    ([`figures/`], [論文圖片與範例圖片]),
    ([`assets/`], [學校浮水印等模板素材]),
    ([`docs/`], [各校論文格式規範的原始 PDF]),
  ),
  notes: [要改格式規則請改 `schools/`，要改文字內容請改 `contents/`。],
) <tbl:layout>

基本上主要會改 `config.yml`、`main.typ` 和 `contents/`。論文圖片放進 `figures/`；需要調整圖片、表格或程式碼等共用樣式時再看 `helper/`。每個內容檔案開頭保留下面這行，就能使用本教學中的工具函式。

#code[
  ```typ
  #import "/helper/mod.typ": *
  ```
]

== 修改設定檔

確認可以成功編譯後，打開根目錄的設定檔 `config.yml`，先把題目、姓名、系所與日期換成自己的資料。下面列出常用欄位；原檔中的英文欄位也要一併填寫，否則將會出現某一語言缺失的情況：

#code[
  ```yaml
  title: "分散式系統的一致性研究"
  title-en: "A Study on Consistency in Distributed Systems"

  author: "王小明"
  author-en: "Wang, Xiao-Ming"
  id: "111753001"

  advisor: "陳大文"
  advisor-en: "Chen, Da-Wen"

  college: "資訊學院"
  institute: "資訊科學系"

  degree: "碩士"
  type: "論文"

  date: "2027-01-15"       # 封面上的日期
  oral-date: "2026-12-20"  # 印在審定書上的口試日期

  keywords: ["分散式系統", "一致性"]
  keywords-en: ["Distributed Systems", "Consistency"]
  ```
]

日期格式預設用 `YYYY-MM-DD`。封面會自動換成民國年與英文月份，審定書也會自動套上口試日期。預設值亦為 `YYYY-MM-DD`。

`degree`（碩士／博士）和 `type`（論文／技術報告）會用在封面和審定書。修改時，也要檢查對應的 `degree-en` 和 `type-en`。存檔後重新編譯，先看封面上的中英文資料是否一致，再檢查審定書的日期。

== 套用學校格式

在 `config.yml` 加入 `school:`，或移除原本那行開頭的 `#`，再填入學校代碼。例如使用政大的設定：

#code[
  ```yaml
  school: nccu   # 對應 schools/nccu.yml
  ```
]

專案提供的學校代碼列在#ref(<tbl:schools>)。代碼必須和 `schools/` 裡的檔名相同，不含 `.yml`。未指定學校時，模板使用預設格式，校名也會保留為佔位文字。

#tlt(
  caption: [內建學校代碼],
  columns: (auto, 1fr, auto, 1fr),
  align: (left + horizon, left + horizon, left + horizon, left + horizon),
  header: ([代碼], [學校], [代碼], [學校]),
  rows: (
    ([`ntu`], [國立臺灣大學], [`ncu`], [國立中央大學]),
    ([`nthu`], [國立清華大學], [`nsysu`], [國立中山大學]),
    ([`nycu`], [國立陽明交通大學], [`nchu`], [國立中興大學]),
    ([`ncku`], [國立成功大學], [`ccu`], [國立中正大學]),
    ([`nccu`], [國立政治大學], [`ntou`], [國立臺灣海洋大學]),
    ([`ntpu`], [國立臺北大學], [`nuk`], [國立高雄大學]),
    ([`ntnu`], [國立臺灣師範大學], [`ncue`], [國立彰化師範大學]),
    ([`nknu`], [國立高雄師範大學], [], []),
  ),
  notes: [各校規範的原始 PDF 收在 `docs/`，檔名含版本日期。],
) <tbl:schools>

設定檔的套用順序是後面設定覆蓋前面設定：

#code[
  ```text
  schools/default.yml  ←  schools/<school>.yml  ←  config.yml
  ```
]

也就是說，你可以在 `config.yml` 裡直接覆蓋任何格式規則，不必去改學校設定檔。設定檔有好幾層，以 `layout` 為例，`layout` 底下有 `margin`，`margin` 底下才是上下左右四個邊界。覆蓋時是一項一項比對，僅有實際寫在 `config.yml` 的那一項才會被換掉，若無實際指定則維持預設值。

例如下方範例只修改上邊界，其餘三邊仍沿用學校設定：

#code[
  ```yaml
  layout:
    margin:
      top: 3.5
  ```
]

如果編譯時出現 `unknown key`，先檢查錯誤訊息指出的欄位。例如下面的 `fnot-size` 拼錯了，應改成 `font-size`：

#code[
  ```text
  error: panicked with: /config.yml: unknown key `layout.fnot-size`
         (see schools/default.yml)
  ```
]

所有可用的 key 與預設值都寫在 `schools/default.yml`，每一項都有註解說明單位，該份檔案就是完整的設定清單。

== 主要檔案

紙本論文有固定的裝訂順序：封面、審定書、致謝、摘要、目次、正文、參考文獻、附錄。`main.typ` 就是這份順序表。它不放任何論文內容，只寫明哪一個檔案排在哪個位置，以及從哪裡開始編章號。

換句話說，內容寫在 `contents/` 的各個檔案裡，`main.typ` 決定它們的先後；要調整裝訂順序、增刪某一頁，都是改這個檔案，不必去動內容。整份檔案很短，開頭到結尾就是下面這些：

#code[
  ```typ
  #import "helper/mod.typ": *

  #show: thesis

  // front matter
  #include "contents/front/acknowledgement.typ"
  #include "contents/front/abstract.typ"

  // notation
  #include "contents/front/denotation.typ"

  // chapters
  #set heading(numbering: "1.1")
  #include "contents/chapter01.typ"
  #include "contents/chapter02.typ"

  // references
  #references()

  // appendices
  #include "contents/back/appendix01.typ"
  ```
]

每一行的作用整理成#ref(<tbl:main>)。

#tlt(
  caption: [`main.typ` 各行的作用],
  columns: (7.5cm, 1fr),
  align: (left + horizon, left + horizon),
  header: ([內容], [作用]),
  rows: (
    ([`#import "helper/mod.typ": *`], [讀入設定與工具函式]),
    ([`#show: thesis`], [套用模板，並產生封面、審定書、目次、圖次、表次]),
    ([`#include "contents/front/..."`], [前置各頁，排版順序即此檔的先後順序]),
    ([`#set heading(numbering: "1.1")`], [此行後的標題才開始編章號]),
    ([`#include "contents/chapterNN.typ"`], [正文各章，`#include` 的順序即為章號]),
    ([`#references()`], [參考文獻，可指定文獻管理檔案位置]),
    ([`#include "contents/back/..."`], [附錄，編號由附錄檔案自己切換成 `A.1`]),
  ),
  notes: [封面與審定書由 `#show: thesis` 產生。],
) <tbl:main>

幾件事需要特別注意：

1. 編號分界：`#set heading(numbering: "1.1")` 是編號的分界線：寫在它前面的 `=` 標題不編號，所以致謝、摘要不會變成第一章；寫在後面的才會。

2. 章號看的是 `#include` 的排列順序，不是檔名，例如將 `chapter03.typ` 那行移到 `chapter02.typ` 前面，就會變成第二章。

3. 檔名雖然不影響結果，還是建議跟順序保持一致，免得日後自己找不到檔案。

== 新增與刪除章節

模板把內容切成一章一個檔案，全部放在 `contents/`，檔名依章次編號，例如 `chapter01.typ`、`chapter02.typ`。改某一章不會動到其他章，編譯出錯時也可以快速判斷是哪個檔案的問題。

`main.typ` 裡的 `#include` 決定了各章的順序，新增或刪除章節時都需要自己維護這幾行。

新增一章：建立 `contents/chapter05.typ`（檔名依章次編號），檔案開頭放 `#import`、一個章標題與一個節標題，接著到 `main.typ` 的 `#references()` 之前加入 `#include "contents/chapter05.typ"`。

#code[
  ```typ
  #import "/helper/mod.typ": *

  = 章標題

  == 節標題

  內文。
  ```
]

刪除一章：把檔案刪掉，同時移除 `main.typ` 裡對應的那行 `#include`，否則 #typst 找不到檔案會直接編譯失敗。後面各章的章號會自動遞補，正文裡的 `@cha:...` 引用也會跟著更新，都不用手改。

前置部分（`contents/front/`）與附錄（`contents/back/`）的做法相同：建立檔案，並在 `main.typ` 對應位置加一行 `#include`；刪除時也要一併移除那行。

== 撰寫章節內容

章節檔案建好後即可開始撰寫論文。保留第一行的 `#import`，那行負責載入設定與圖表等工具函式，刪掉之後這一章裡的 `#fig()`、`#tlt()` 都會失效。建議先把章標題與幾個節標題列出來，再逐節填內文，不必一開始就寫完。

一章最基本的樣子如下：

#code[
  ```typ
  #import "/helper/mod.typ": *

  = 緒論

  == 研究背景

  第一段內文。

  第二段內文，段落之間空一行。

  === 研究動機

  第三層標題底下的內文。
  ```
]

標題用等號開頭，等號的數量就是層級：一個是章，兩個是節，三個是小節。每一層的字級、對齊方式與編號用詞都由學校設定檔決定，寫作時只要選對層級，不必自己調整外觀。章標題還會自動換頁，所以檔案開頭與結尾都不需要留空白。

段落之間空一行就會分段，首行縮排也是自動的。不要在每行末尾手動斷行，#typst 會依版面寬度自行折行；原始碼裡的單一換行只會被當成一個空白，強制斷行反而會讓日後修改文字時出現奇怪的排版。

要讓某一章能被引用，在標題後面加上標籤，例如 `= 研究方法 <cha:method>`。之後在任何地方寫 `@cha:method`，就會顯示成可點擊的「第三章」，章號變動時也會自動更新。圖、表與程式碼的標籤寫法相同，詳見第三章。

== 暫時用假文看版面

章節架構先定好、內文還沒寫時，可以先填假文，把版面、分頁與圖表位置排出來。`misc/lorem.typ` 包了兩個函式，預設各給五段：

#code[
  ```typ
  #zh-lorem()            // 中文五段
  #en-lorem()            // 英文五段
  #zh-lorem(count: 2)    // 顯示兩段
  #en-lorem(count: 8)    // 顯示八段
  ```
]

中文假文來自 #link("https://typst.app/universe/package/kouhu/")[kouhu] 套件的繁體文本，內容取自 #latex 的 #link("https://ctan.org/pkg/zhlipsum")[zhlipsum]；英文假文來自 #link("https://typst.app/universe/package/ipsum/")[ipsum] 套件。兩個套件都會在第一次編譯時自動下載並快取，之後離線也能編譯。想換成別的文本或調整生成方式，改 `misc/lorem.typ` 裡的那兩行即可。
