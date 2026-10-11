#import "/helper/mod.typ": acknowledgement

#show: acknowledgement

撰寫致謝時，請打開 `contents/front/acknowledgement.typ`，保留開頭的匯入語句與 `#show: acknowledgement`，再把這些說明換成自己的文字。模板會自動加入標題，內文依一般段落書寫即可，不需要另加章節編號。

可以先回想研究過程中受到哪些協助，例如討論研究問題、取得資料，或協助檢查論文內容，再依序寫下想感謝的人與具體事情。完成後，請確認姓名、職稱與計畫名稱是否正確，也可以重新讀一次，看看是否有遺漏需要致謝的對象。

若不需要致謝頁，請到 `main.typ` 移除引用這個檔案的 `#include`，再重新編譯確認裝訂順序。若只是要更換標題，例如改為「謝詞」，則在 `config.yml` 的 `sections:` 下設定 `acknowledgement: "謝詞"` 即可。
