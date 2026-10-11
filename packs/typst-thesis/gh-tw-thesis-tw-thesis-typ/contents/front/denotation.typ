#import "/helper/mod.typ": denotation

#show: denotation

需要整理縮寫與符號時，請打開 `contents/front/denotation.typ`，保留開頭的匯入語句與 `#show: denotation`，再將下面的範例換成論文使用的項目。每個詞條以 `/` 開頭，冒號前放縮寫或符號，後面填入完整名稱與定義。

填寫完成後，請對照正文檢查大小寫、數學符號與用詞是否一致，並移除沒有使用的項目。如果論文不需要符號列表，可以到 `main.typ` 移除對應的 `#include`，重新編譯後就不會出現這一頁。

/ PDF: 編譯後輸出的文件格式。
/ YAML: 本模板設定檔使用的格式，副檔名為 `.yml`。
/ CSL: 參考文獻樣式所使用的格式。
/ $E$: 能量。
/ $m$: 質量。
/ $c$: 光速。
