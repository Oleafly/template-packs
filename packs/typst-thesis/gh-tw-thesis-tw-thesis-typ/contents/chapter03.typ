#import "/helper/mod.typ": *

= 圖片與表格

準備好章節內容後，就可以開始加入圖片與表格。本章會先示範單張圖片，再說明並排圖片、網格圖片、傳統表格與三線表的寫法。初次使用時，建議先將範例貼進自己的章節，確認能正常編譯，再替換圖片路徑、標題與數據。

章節檔案開頭請保留 `#import "/helper/mod.typ": *`，讓後面的圖表函式可以使用。模板會自動產生編號，預設將圖片與表格的標題都放在下方；需要更換位置時，可以依#ref(<sec:caption>)的說明調整。以下圖片與數字都是排版範例，換成論文內容時，請一併修改標題和說明。

== 插入單張圖片

若要插入圖片，建議將圖片放進 `figures/` 資料夾中，再將檔案路徑填入 `fig()`。以下使用專案附帶的 `/figures/samples/architecture.png`，路徑開頭的 `/` 代表從專案根目錄尋找檔案。`width: 60%` 則將圖片寬度設為目前可用排版寬度的六成，可以先照範例編譯，再依圖片內容調整大小。

#code[
  ```typ
  #fig("/figures/samples/architecture.png", caption: [研究架構], width: 60%) <fig:one>
  ```
]

編譯結果如#ref(<fig:one>)所示，使用預設設定時，圖片下方會顯示自動產生的編號與 `caption` 中的文字。替換圖片時，請一起修改路徑與標題；若是複製範例來新增另一張圖，也要更換後面的 `<fig:one>` 標籤，讓每張圖都有不同的名稱，供內文引用。

#fig("/figures/samples/architecture.png", caption: [研究架構], width: 60%) <fig:one>

如果需要加入替代文字，或自行設定圖片的其他選項，可以先用 `image()` 建立圖片，再傳給 `fig()`。採用這種寫法時，圖片的寬度也請直接寫在 `image()` 裡，例如以下範例：

#code[
  ```typ
  #fig(
    image(
      "/figures/samples/architecture.png",
      width: 60%,
      height: 5cm,
      fit: "contain",
      alt: "研究流程圖：資料蒐集、資料處理、模型訓練、模型評估、結果分析",
    ),
    caption: [說明],
  )
  ```
]

`width` 設定圖片顯示寬度；`60%` 是目前可用排版寬度的六成，也可以寫成 `8cm` 等固定長度。`height` 設定顯示高度，不指定時會依原圖比例自動計算。在這個例子裡，寬、高一起決定圖片要放入的區域。

`fit` 決定原圖如何放進該區域：`"contain"` 保留完整圖片與原比例，可能留下空白；`"cover"` 也保留原比例，但會裁掉超出區域的部分以填滿空間，這是 #typst 的預設值；`"stretch"` 會拉伸到指定寬高，可能使圖片變形。若只設定 `width` 而讓 `height` 自動計算，這三種方式通常看不出差別。圖表通常先用 `"contain"`，避免文字或座標軸被裁掉。

其他常用選項有 `alt`（供螢幕閱讀器使用的圖片描述）、`page`（插入多頁 PDF 的第幾頁，預設 `1`）和 `scaling`（縮放像素圖時選 `"smooth"` 或 `"pixelated"`）。完整參數可參考 #link("https://typst.app/docs/reference/visualize/image/")[Typst 的 `image()` 文件]。將已建立的 `image()` 傳入 `fig()` 時，請在 `image()` 裡設定寬度；`fig(width:)` 只會套用在直接傳入圖片路徑的寫法。

== 並排圖片

要將兩張圖片放在同一列時，可以使用 `fig-row()` 函數，依序填入各張圖片的路徑與小標題。小標題會自動加上 `(a)`、`(b)` 等編號，整組圖片則共用一個圖號與總標題，在圖次中也只會列出一筆。以下示範兩張圖片的寫法：

#code[
  ```typ
  #fig-row(
    caption: [取樣策略比較],
    ("/figures/samples/sampling-uniform.png", [均勻取樣]),
    ("/figures/samples/sampling-importance.png", [重要性取樣]),
  ) <fig:row>
  ```
]

#fig-row(
  caption: [取樣策略比較],
  ("/figures/samples/sampling-uniform.png", [均勻取樣]),
  ("/figures/samples/sampling-importance.png", [重要性取樣]),
) <fig:row>

若不需要小標題，每張圖只填路徑即可，不必寫成 `(路徑, [小標題])`。編譯後若覺得圖片靠得太近，可以加入 `gutter: 2em`，增加兩欄之間的距離，再觀察圖片是否仍有足夠的顯示空間。

#code[
  ```typ
  #fig-row(
    caption: [取樣策略比較],
    gutter: 2em,
    "/figures/samples/sampling-uniform.png",
    "/figures/samples/sampling-importance.png",
  )
  ```
]

此外，並排圖片的 `width` 是相對於各自那一欄的寬度。例如設為 `80%` 時，每張圖會占自己欄寬的八成。需要縮小圖片時可以從這個數值調整，不必先修改原始圖檔。

== 網格圖片

如果圖片較多，希望分成數列排列，可以改用 `fig-grid()`。`rows` 指定列數，`columns` 指定每列的欄數。下面放入四張圖片，設定 `rows: 2`、`columns: 2`，就會由左到右、由上而下排成兩列。每張圖的小標題與整組圖片的總標題，寫法都和並排圖片相同。

#code[
  ```typ
  #fig-grid(
    rows: 2,
    columns: 2,
    caption: [模型預測結果],
    ("/figures/samples/a.png", [線性模型]),
    ("/figures/samples/b.png", [決策樹]),
    ("/figures/samples/c.png", [隨機森林]),
    ("/figures/samples/d.png", [神經網路]),
  ) <fig:grid>
  ```
]

#fig-grid(
  rows: 2,
  columns: 2,
  caption: [模型預測結果],
  ("/figures/samples/a.png", [線性模型]),
  ("/figures/samples/b.png", [決策樹]),
  ("/figures/samples/c.png", [隨機森林]),
  ("/figures/samples/d.png", [神經網路]),
) <fig:grid>

四張圖使用相同的合成訓練資料：橘色點是觀測值，藍色線是各模型的預測結果。這些數據只用於示範排版，並非真實論文的實驗結果。

若要排成兩列、每列三張，可設定 `rows: 2, columns: 3`。圖片會依照填入的順序重新排列；此例只有四張圖，因此第二列的後兩格留白。`rows` 可以省略，讓列數隨圖片數量自動增加；若指定列數，圖片數量不可超過 `rows * columns`。調整後請確認圖片中的文字仍能清楚閱讀；若縮得太小，可以減少每列的欄數。

#code[
  ```typ
  #fig-grid(
    rows: 2,
    columns: 3,
    caption: [兩列三欄排版示例],
    ("/figures/samples/a.png", [線性模型]),
    ("/figures/samples/b.png", [決策樹]),
    ("/figures/samples/c.png", [隨機森林]),
    ("/figures/samples/d.png", [神經網路]),
  ) <fig:grid-2x3>
  ```
]

編譯結果如#ref(<fig:grid-2x3>)所示：

#fig-grid(
  rows: 2,
  columns: 3,
  caption: [兩列三欄排版示例],
  ("/figures/samples/a.png", [線性模型]),
  ("/figures/samples/b.png", [決策樹]),
  ("/figures/samples/c.png", [隨機森林]),
  ("/figures/samples/d.png", [神經網路]),
) <fig:grid-2x3>

== 表格

表格有兩種寫法：需要逐格框線時，用 #typst 原生的 `table()`；只要表頭上下與表尾三條線的三線表，則用模板提供的 `tlt()`。兩者的資料填法相同，差別只在外觀與框線，可以依論文或系所規定挑一種。

=== 傳統表格

需要每個儲存格都有框線時，直接使用 #typst 的 `table()`。`columns: 3` 指定三欄，`table.header(...)` 放入表頭，後面的資料依照由左到右、由上而下的順序填入。注意，必須用 `figure()` 包住表格，才能加上標題與標籤供內文引用。

#code[
  ```typ
  #figure(
    table(
      columns: 3,
      align: center + horizon,
      table.header([批次大小], [準確率（%）], [訓練時間（秒）]),
      [32], [91.2], [48],
      [64], [92.8], [31],
      [128], [92.1], [22],
    ),
    caption: [實驗結果（傳統表格）],
  ) <tbl:traditional>
  ```
]

#figure(
  table(
    columns: 3,
    align: center + horizon,
    table.header([批次大小], [準確率（%）], [訓練時間（秒）]),
    [32], [91.2], [48],
    [64], [92.8], [31],
    [128], [92.1], [22],
  ),
  caption: [實驗結果（傳統表格）],
) <tbl:traditional>

相鄰儲存格可以合併。`table.cell(colspan: 2)[文字]` 讓一格橫跨兩欄；以下三欄表格的「總計」列只填兩格，因為「100 筆」已占用後兩欄，不必再補第三格。若要讓一格縱跨兩列，可改用 `rowspan: 2`；下一列被占用的位置也不要再填儲存格。

#code[
  ```typ
  #figure(
    table(
      columns: 3,
      align: center + horizon,
      table.header([項目], [訓練集], [測試集]),
      [樣本數], [80], [20],
      [總計], table.cell(colspan: 2)[100 筆],
    ),
    caption: [合併儲存格示例],
  ) <tbl:merged>
  ```
]

#figure(
  table(
    columns: 3,
    align: center + horizon,
    table.header([項目], [訓練集], [測試集]),
    [樣本數], [80], [20],
    [總計], table.cell(colspan: 2)[100 筆],
  ),
  caption: [合併儲存格示例],
) <tbl:merged>

=== 三線表

不同於逐格加框的傳統表格，三線表源自 #link("https://apastyle.apa.org/style-grammar-guidelines/tables-figures/tables")[APA 格式]的表格慣例，在社會科學、教育、心理學等偏重統計數據的領域最為常見。少了多條直向與橫向的格線，版面更乾淨，整欄都是數字時尤其容易閱讀。`docs/` 收錄的各校官方論文格式規範，大多沒有指定表格要用哪種框線，實際採用哪一種通常是系所或指導教授的學術慣例，而非學校統一規定，撰寫前建議先確認清楚。

三線表的特色是：只保留表頭上下與表尾的三條橫線。使用 `tlt()` 時，把欄名放進 `header`，資料列放進 `rows`；以下沿用前面的資料，方便比較。

#code[
  ```typ
  #tlt(
    caption: [實驗結果彙整],
    columns: (auto, auto, auto),
    header: ([批次大小], [準確率（%）], [訓練時間（秒）]),
    rows: (
      ([32], [91.2], [48]),
      ([64], [92.8], [31]),
      ([128], [92.1], [22]),
    ),
    notes: [數值為排版示例。],
  ) <tbl:batch>
  ```
]

#tlt(
  caption: [實驗結果彙整],
  columns: (auto, auto, auto),
  header: ([批次大小], [準確率（%）], [訓練時間（秒）]),
  rows: (
    ([32], [91.2], [48]),
    ([64], [92.8], [31]),
    ([128], [92.1], [22]),
  ),
  notes: [數值為排版示例。],
) <tbl:batch>

完成資料填寫後，可以依內容調整欄寬、對齊方式與表下說明。常用參數如下：

#tlt(
  caption: [三線表常用參數],
  columns: (7em, 1fr),
  align: left + horizon,
  header: ([參數], [用途與範例]),
  rows: (
    ([`columns`], [`auto` 依內容排寬；`1fr` 分配剩餘寬度。例：`(3cm, 1fr)`。]),
    ([`align`], [儲存格對齊；預設置中，文字欄可設 `left + horizon`。]),
    ([`inset`], [儲存格內距；例：`(x: 0.8em, y: 0.3em)`。]),
    ([`thick`/`thin`], [上下線／表頭線的粗細；只改這張表就傳參數，全部表格一起改就改 `rules`。]),
    ([`notes`], [表下補充說明，字級為本文字級的九成。]),
    ([`notes-label`], [註記開頭；預設「註：」，設 `none` 可取消。]),
    ([`header`], [欄名；設為 `()` 可省略表頭。]),
  ),
)

若資料較多，一頁放不下整張表格，表格會自動將後續資料接到下一頁（自動跨頁），毋需額外加入跨頁設定。跨頁時，透過 `header` 填入的表頭與表頭上下的橫線會在新頁重複顯示。完成後請檢查分頁位置，確認讀者能辨認各欄的資料。

三線表也能合併儲存格：將 `table.cell(colspan: 2)[100 筆]` 放進 `rows` 的對應列即可。如下方範例，「總計」列雖然只填兩格，實際仍占滿三欄；與上方的傳統表格相比，差別只在框線樣式。

#code[
  ```typ
  #tlt(
    caption: [三線表合併儲存格],
    columns: (auto, auto, auto),
    header: ([項目], [訓練集], [測試集]),
    rows: (
      ([樣本數], [80], [20]),
      ([總計], table.cell(colspan: 2)[100 筆]),
    ),
  ) <tbl:tlt-merged>
  ```
]

#tlt(
  caption: [三線表合併儲存格],
  columns: (auto, auto, auto),
  header: ([項目], [訓練集], [測試集]),
  rows: (
    ([樣本數], [80], [20]),
    ([總計], table.cell(colspan: 2)[100 筆]),
  ),
) <tbl:tlt-merged>

表頭本身也能分組、分兩列排。有多欄可以歸為同一類別時（例如「訓練集」與「測試集」底下各自再細分準確率與損失），可以把 `header` 拆成兩列內容：第一列用 `table.cell(colspan: 2)[...]` 橫跨數欄標出群組名稱，第二列補上各欄實際的名稱；不需要分組的欄（例如最左邊的「模型」）則用 `table.cell(rowspan: 2)[...]` 縱跨兩列表頭，避免留白。群組名稱底下若要各自加一條短線區隔，用 `cmidrule(欄, 欄)` 標出範圍即可，寫法跟接下來要介紹的 #latex `\cmidrule{欄-欄}` 是同一套邏輯，只是改用逗號分隔的兩個引數。單一儲存格若要額外加註，也可以在內容後面加 `#super[a]` 這類上標字母，再對應到 `notes` 裡的說明：

#code[
  ```typ
  #tlt(
    caption: [分組表頭示例],
    columns: (auto, auto, auto, auto, auto),
    header: (
      table.cell(rowspan: 2)[模型],
      table.cell(colspan: 2)[訓練集], table.cell(colspan: 2)[測試集],
      cmidrule(2, 3), cmidrule(4, 5),
      [準確率（%）], [損失], [準確率（%）], [損失],
    ),
    rows: (
      ([線性模型], [88.1], [0.42], [85.3], [0.51]),
      ([隨機森林], [96.4#super[a]], [0.11], [90.2], [0.28]),
    ),
    notes: [#super[a] 該次訓練提早停止（early stopping），未跑滿完整輪數。],
  ) <tbl:tlt-grouped>
  ```
]

#tlt(
  caption: [分組表頭示例],
  columns: (auto, auto, auto, auto, auto),
  header: (
    table.cell(rowspan: 2)[模型],
    table.cell(colspan: 2)[訓練集],
    table.cell(colspan: 2)[測試集],
    cmidrule(2, 3),
    cmidrule(4, 5),
    [準確率（%）],
    [損失],
    [準確率（%）],
    [損失],
  ),
  rows: (
    ([線性模型], [88.1], [0.42], [85.3], [0.51]),
    ([隨機森林], [96.4#super[a]], [0.11], [90.2], [0.28]),
  ),
  notes: [#super[a] 該次訓練提早停止（early stopping），未跑滿完整輪數。],
) <tbl:tlt-grouped>

`header` 裡的儲存格數量，要依序對應每一列實際占用的欄數：第一列是 `1 + 2 + 2 = 5`（含 `rowspan` 那格），第二列是 `4`（`rowspan` 的格子已經算過，第二列不用再填），兩列合計必須是 `columns` 的整數倍，否則表格會排版錯位。

`tlt()` 內部畫的三條線，也各自拆成獨立的函式，對應 #latex 中 `booktabs` 套件的 `\toprule`、`\midrule`、`\bottomrule`：

#tlt(
  caption: [三線表對應的線條函式],
  columns: (8em, 1fr, 1fr),
  align: left + horizon,
  header: ([函式], [線條位置], [對應 #latex 語法]),
  rows: (
    ([`toprule`], [表格最上方], [`\toprule`]),
    ([`midrule`], [表頭下方，或段落之間], [`\midrule`]),
    ([`bottomrule`], [表格最下方], [`\bottomrule`]),
    ([`cmidrule(a, b)`], [只畫第 `a` 到第 `b` 欄（含頭尾）], [`\cmidrule{a-b}`]),
  ),
) <tbl:booktabs>

用 `tlt()` 時通常用不到這幾個函式，三條線都會自動畫好；只有兩種情況才需要自己插入：想在資料中間額外加一條線（例如把 `rows` 分成兩段小計時插入一個 `midrule`），或是完全跳過 `tlt()`、直接用 #typst 原生的 `table()` 手刻表格，想要 booktabs 那種只有橫線的外觀。例如：

#code[
  ```typ
  #figure(
    table(
      columns: 3,
      stroke: none,
      align: center + horizon,
      toprule,
      table.header([項目], [第一組], [第二組]),
      midrule,
      [平均值], [91.2], [88.5],
      [標準差], [3.1], [4.2],
      midrule,
      [樣本數], table.cell(colspan: 2)[60],
      bottomrule,
    ),
    caption: [手刻表格搭配 booktabs 線條],
  )
  ```
]

`cmidrule(a, b)` 的兩個引數是 1-indexed、含頭尾的欄號，跟 #latex `\cmidrule{a-b}` 寫法一致，例如前面分組表頭範例裡的 `cmidrule(2, 3)` 對應 `\cmidrule{2-3}`，都是指第 2 到第 3 欄。`stroke` 粗細預設分別是 `toprule`/`bottomrule` 的 `0.08em` 與 `midrule`/`cmidrule` 的 `0.05em`，`cmidrule(2, 3, stroke: 0.1em)` 可以單獨調粗這一條。

`tlt()` 的三條線粗細也能調整。只想改某一張表就傳 `thick:`/`thin:`：

#code[
  ```typ
  #tlt(
    caption: [調粗上下線的表格],
    columns: (auto, auto),
    thick: 0.14em,
    header: ([項目], [數值]),
    rows: (([範例], [1]),),
  ) <tbl:thick>
  ```
]

#tlt(
  caption: [調粗上下線的表格],
  columns: (auto, auto),
  thick: 0.14em,
  header: ([項目], [數值]),
  rows: (([範例], [1]),),
) <tbl:thick>

跟 @tbl:batch 的上下線比較，就能看出 `thick` 調粗後的差異。想讓全部表格（包含直接用 `toprule`/`midrule`/`bottomrule`/`cmidrule` 手刻的）都改成同一種粗細，就直接改 `helper/table.typ` 檔案開頭的 `rules` 字典：

#code[
  ```typ
  #let rules = (
    thick: 0.08em, // toprule、bottomrule
    thin: 0.05em, // midrule、cmidrule，以及 tlt() 表頭下方那條線
  )
  ```
]

== 交叉引用

需要在內文提到圖表時，請先在圖表後面加上 `<名稱>`，再用 `#ref(<名稱>)` 引用。標籤可以自行命名，但同一份文件中不能重複。前面的範例已加上 `fig:grid` 與 `tbl:batch`，因此可以直接使用以下寫法：

#code[
  ```typ
  四張範例圖的排列方式如#ref(<fig:grid>)所示。
  詳細數據見#ref(<tbl:batch>)。
  本章的設定沿用#ref(<cha:layout>)的規則。
  ```
]

編譯後，標籤會換成對應的編號，例如：四張範例圖的排列方式如#ref(<fig:grid>)所示，詳細數據見#ref(<tbl:batch>)，本章的設定沿用#ref(<cha:layout>)的規則。章節引用會顯示完整層級，例如#ref(<sec:caption>)會顯示章號和節號。這些引用都可以點擊，跳到對應的圖表或章節。

新增或移動圖表後，模板會重新編號，內文的引用也會一併更新，因此不必手動修改「圖幾」或「表幾」。章節標題也能用相同方式引用，只要在標題後面加上標籤即可：

#code[
  ```typ
  = 版面設定 <cha:layout>
  == 邊界與紙張 <sec:margin>
  ```
]

章節引用的文字可以在 `config.yml` 的 `cross-ref:` 設定。`C` 是章號、`S` 是節號、`B` 是小節號；只顯示標籤所在層級需要的編號。預設使用中文數字，並依層級顯示「第C章」、「第C章第S節」或「第C章第S節第B小節」。若想顯示 `2`、`2.5`、`2.5.1`，可改成：

#code[
  ```yaml
  cross-ref:
    numbering: "1"
    chapter: "C"
    section: "C.S"
    subsection: "C.S.B"
  ```
]

需要加上文字時，可用 `{C}`、`{S}`、`{B}`，例如 `"第{C}章第{S}節"`。樣式只影響正文中的章節引用，不會更改標題、目次、圖表、文獻或頁碼引用；附錄仍使用「附錄 A」這類標示。

中文字要緊接引用時，可寫 `依@sec:caption`，顯示時沒有前置空格。若引用後面也緊接中文字，請用 `依#ref(<sec:caption>)的說明`；直接寫 `@sec:caption的說明` 會讓 #typst 把後面的中文字也讀成標籤名稱。標點符號前後則照句子需要留空白。

若要調整引用時顯示的名稱，可以改用 `ref()`，並在 `supplement` 中填入文字。例如以下寫法會將表號前的文字改為英文 Table，編號仍由模板產生，不需要另外填寫：

#code[
  ```typ
  #ref(<tbl:batch>, supplement: [Table])
  ```
]

這是單次引用的做法，只改那一處。若是連「圖 1」「表 1」這種標題與目次裡的前綴都要換掉，就要從來源改起，而不是每次引用都加 `supplement`。

== 數學與符號列表

在句子中插入公式時，請用 `$...$` 包住內容，例如 `$E = m c^2$`。若希望公式獨立成行，則在開頭與結尾的 `$` 內側各留一個空白，寫成 `$ ... $`。

#typst 的數學語法跟 #latex 不同，例如上標不用 `^{}`、分數用 `frac(a, b)` 或 `a/b`、希臘字母直接打英文拼音（如 `alpha`、`Delta`）就會變成符號，不需要反斜線。完整語法請見 #link("https://typst.app/docs/reference/math/")[#typst 數學文件]，初次寫公式建議先查表對照，不要直接套用 #latex 的寫法。

#code[
  ```typ
  行內公式 $E = m c^2$，獨立公式：

  $
    integral_0^1 x^2 dif x = 1/3
  $
  ```
]

編譯後，行內公式 $E = m c^2$ 會和文字排在同一段，下面的積分公式則會獨立成行：

$ integral_0^1 x^2 dif x = 1/3 $

若要在後文引用公式，請先開啟公式編號，再於獨立公式後面加上標籤。以下範例使用 `eq:pythagoras` 作為名稱，引用方式與剛才的圖表相同，在名稱前加上 `@` 即可：

#code[
  ```typ
  #set math.equation(numbering: eq-numbering)

  $ a^2 + b^2 = c^2 $ <eq:pythagoras>

  如#ref(<eq:pythagoras>)所示。
  ```
]

其中 `eq-numbering` 是模板依 `config.yml` 算好的編號規則，不用手動寫 `"(1)"`，預設每個公式連續編號，顯示成 `(1)`、`(2)`...；若系所要求依章節編號（例如第三章的公式顯示 `(3.1)`、`(3.2)`，換到第四章重新從 `(4.1)` 開始），在 `config.yml` 的 `layout:` 下設定：

#code[
  ```yaml
  layout:
    equation-numbering: "1"      # 1 | a | A | i | I | *
    equation-per-chapter: true   # true 讓公式編號改成「章.流水號」，並每章重新編號
  ```
]

`equation-numbering` 只決定流水號本身的樣式，寫法跟 `footnote-numbering` 一樣；章節編號固定使用阿拉伯數字，不受這個設定影響。

論文中若反覆使用縮寫或數學符號，可以整理到前置頁面的符號列表。請打開 `contents/front/denotation.typ`，保留開頭的匯入與樣式設定，再用下面的詞條語法填入內容。每行以 `/` 開頭，冒號前放符號，後面寫出完整名稱或定義：

#code[
  ```typ
  / CNN: 卷積神經網路 (Convolutional Neural Network)
  / $eta$: 學習率 (learning rate)
  ```
]

== 圖表標題

「圖」、「表」這兩個字，出現在圖表標題、目次（圖次、表次）與內文引用的每一個地方，是由 `config.yml` 的 `strings:` 統一設定，不用逐一修改：

#code[
  ```yaml
  strings:
    figure: "插圖" # 中文論文的圖說前綴，預設「圖」
    figure-en: "Fig." # language: english 時使用，預設 "Figure"
    table: "附表" # 中文論文的表說前綴，預設「表」
    table-en: "Tab." # language: english 時使用，預設 "Table"
  ```
]

改完後重新編譯，`fig()`、`fig-row()`、`fig-grid()`、`tlt()` 產生的每張圖表都會換成新的前綴，圖次、表次與 `@名稱` 的引用文字也會一併更新。若只有某一張圖或表需要跟其他不一樣時，直接在該次呼叫加上 `supplement:` 即可，不影響 `config.yml` 的全域設定：

#code[
  ```typ
  #fig(
    "/figures/samples/architecture.png",
    caption: [說明],
    supplement: [附圖]
  ) <fig:special>
  ```
]

`supplement` 也可以留空字串 `[]`，或直接寫 `none`，此時圖表只會顯示編號，而不會有前綴文字。

== 註腳

圖表若需要額外補充，前面的分組表頭範例是在儲存格加上 `#super[a]`，再對應 `notes` 裡的說明；但那只是手刻的上標文字，不是真正的註腳。若要在內文中隨插隨用、由 #typst 自動編號與排版的註腳，可以改用 `#footnote[...]`，不需要另外編輯任何檔案，編號、上標與頁尾的分隔線都是自動處理：

#code[
  ```typ
  這一點有些爭議#footnote[不同研究對此看法不一。]，後續章節會再討論。
  ```
]

編譯後如下：

這一點有些爭議#footnote[不同研究對此看法不一。]，後續章節會再討論。

當頁最下方，編號從 1 開始，全文連續累加，不會因為換頁而重置。若同一個註解要在多處引用，先幫第一次出現的 `#footnote[...]` 加上標籤，之後就能用 `#footnote(<標籤>)` 重複使用同一個編號，不會另外產生新註腳：

#code[
  ```typ
  第一次提到#footnote[說明文字。] <fn:first>，第二次提到時#footnote(<fn:first>)。
  ```
]

編號格式與是否每章重新編號，都在 `config.yml` 的 `layout:` 下設定：

#code[
  ```yaml
  layout:
    footnote-numbering: "1"      # 1 | a | A | i | I | *
    footnote-per-chapter: false  # true 讓每章從 1 重新編號
  ```
]

`footnote-numbering` 的寫法跟 `outline.body-numbering` 等編號設定一樣，`"1"` 是阿拉伯數字，`"a"`／`"A"` 是英文字母，`"i"`／`"I"` 是小寫／大寫羅馬數字，`"*"` 則是星號、雙星號依序遞增，適合整篇註腳不多的論文。`footnote-per-chapter` 預設 `false`，註腳編號連續累加到全文結束；系所若要求每章重新從 1 編號，改成 `true` 即可，不需要自己在每章開頭手動歸零。

圖表、註腳與公式的寫法確認後，下一章會接著說明文獻引用，以及程式碼與附錄的寫法。
