#import "lib.typ": setup
#import "font-config.typ": ntu-fonts, ntu-heading-fonts, ntu-mono-fonts, check-font-availability

// === Typst 語法功能展示範例 ===
// 本檔案展示 Typst 的各種語法功能，包括數學公式、表格、圖片、程式碼等

// 1. 初始化模板設定
#let (
  // 頁面元件
  make-cover,
  make-verification,
  make-abstract-zh,
  make-abstract-en,
  make-acknowledgement,
  make-outline,
  make-ref,
  
  // 佈局元件
  whole,
  mainmatter,
  
  // 工具函數
  begin-roman-numbering,
  begin-arabic-numbering,
) = setup(
  // 基本設定
  university: "國立臺灣大學",
  university-en: "National Taiwan University",
  college: "理學院", 
  college-en: "College of Science",
  institute: "數學科學研究所",
  institute-en: "Institute of Mathematical Sciences",
  
  // 學位設定
  degree: (master: false, doctor: true),  // 博士論文
  
  // 個人資訊
  title: (
    zh: "Typst 語法功能完整展示：從基礎排版到高階數學公式",
    en: "Complete Typst Syntax Demonstration: From Basic Typesetting to Advanced Mathematical Formulas"
  ),
  author: (
    zh: "語法展示者",
    en: "Syntax Demonstrator"
  ),
  advisor: (
    zh: "排版指導教授",
    en: "Prof. Typesetting Guide"
  ),
  student-id: "D12345678",
  
  // 日期設定
  date: "2024-06-20",
  oral-date: "2024-07-01",
  
  // 語言設定
  main-lang: (zh: true, en: false),
)

// 2. 套用全域設定
#show: whole

// 3. 封面
#make-cover()

// 4. 開始羅馬數字頁碼
#show: begin-roman-numbering

// 5. 口試委員審定書
#make-verification()

// 6. 字體測試區域
#page[
  = 字體配置測試

  #check-font-availability()

  == 混合語言測試
  This is English text mixed with 中文字體測試。Numbers: 123456789.
  
  === 各種標點符號
  中文標點：，。！？：；「」『』（）【】
  English punctuation: ,.!?:;"'()[]{}
  
  === 特殊符號
  數學符號：± × ÷ ∑ ∏ ∫ ∞ ≈ ≠ ≤ ≥ α β γ δ π λ μ σ
  其他符號：© ® ™ § ¶ † ‡ • ◦ ‰ ‱
]

// 7. 致謝
#make-acknowledgement[
  本展示文件旨在測試和展示 Typst 的各種語法功能。感謝 Typst 開發團隊創造如此優秀的排版系統。

  特別感謝各位開源貢獻者和社群成員，讓我們能夠享受到現代化的學術寫作體驗。
]

// 8. 中文摘要
#make-abstract-zh(
  keywords: ("Typst語法", "數學公式", "學術排版", "開源軟體", "LaTeX替代")
)[
  本文件展示了 Typst 排版系統的各種語法功能，包括基本文字排版、數學公式、表格、圖表、程式碼區塊、交叉引用等功能。

  透過實際範例展示，本文件證明了 Typst 作為現代學術寫作工具的強大功能和易用性。相較於傳統的 LaTeX 系統，Typst 提供了更直觀的語法和更快的編譯速度。

  文件中包含了複雜的數學推導、統計分析、程式設計範例以及多媒體內容整合，展現了 Typst 在各種學術寫作場景中的適用性。
]

// 9. 英文摘要
#make-abstract-en(
  keywords: ("Typst Syntax", "Mathematical Formulas", "Academic Typesetting", "Open Source", "LaTeX Alternative")
)[
  This document demonstrates various syntax features of the Typst typesetting system, including basic text formatting, mathematical formulas, tables, figures, code blocks, and cross-references.

  Through practical examples, this document proves the powerful functionality and ease of use of Typst as a modern academic writing tool. Compared to traditional LaTeX systems, Typst provides more intuitive syntax and faster compilation speed.

  The document includes complex mathematical derivations, statistical analyses, programming examples, and multimedia content integration, showcasing Typst's applicability in various academic writing scenarios.
]

// 10. 目錄
#make-outline()

// 11. 開始阿拉伯數字頁碼
#show: begin-arabic-numbering

// 12. 正文
#show: mainmatter

// 啟用方程式編號
#set math.equation(numbering: "1.")

// 載入參考文獻
#bibliography("example.bib")

= 基礎語法展示 <basic-syntax>

== 文字格式化 <text-formatting>

=== 基本強調
*粗體文字* 和 _斜體文字_ 以及 `等寬字體`。

可以組合使用：*_粗斜體_* 和 *`粗等寬`*。

=== 上標下標
化學公式：H#sub[2]O 和 CO#sub[2]

數學表達式：x#super[2] + y#super[2] = z#super[2]

=== 顏色和裝飾
#text(fill: red)[紅色文字] 和 #text(fill: blue)[藍色文字]

#underline[底線文字] 和 #strike[刪除線文字]

=== 連結和交叉引用
這裡是一個連結：#link("https://typst.app")[Typst 官網]

交叉引用：參見 @basic-syntax 和 @advanced-math。

== 清單和編號 <lists>

=== 無序清單
- 第一項
- 第二項
  - 子項目 A
  - 子項目 B
    - 更深層的項目
- 第三項

=== 有序清單
1. 第一步
2. 第二步
   1. 子步驟 A
   2. 子步驟 B
3. 第三步

=== 描述清單
/ 術語一: 這是術語一的定義，可以包含複雜的解釋和多行內容。 
/ 術語二: 這是術語二的定義。
/ 複雜術語: 這個術語有更詳細的說明，包括數學公式 $f(x) = x^2$ 和其他格式。

= 進階數學公式展示 <advanced-math>

== 基本數學表達式

行內數學：設 $f(x) = x^2 + 2x + 1$，則 $f'(x) = 2x + 2$。

區塊數學公式：
$ f(x) = integral_(-infinity)^infinity (e^(-t^2/2))/sqrt(2pi) dif t $

== 複雜數學公式 <complex-formulas>

=== 微積分
導數定義：
$ f'(x) = lim_(h->0) (f(x+h) - f(x))/h $

積分運算：
$ integral_a^b f(x) dif x = F(b) - F(a) $

=== 線性代數
矩陣運算：
$ mat(
  a, b, c;
  d, e, f;
  g, h, i
) mat(
  x;
  y;
  z
) = mat(
  a x + b y + c z;
  d x + e y + f z;
  g x + h y + i z
) $

特徵值問題：
$ A vec(v) = lambda vec(v) $

其中 $A$ 是 $n times n$ 矩陣，$lambda$ 是特徵值，$vec(v)$ 是對應的特徵向量。

=== 統計學
正態分布：
$ f(x) = 1/(sigma sqrt(2pi)) e^(-(x-mu)^2/(2sigma^2)) $

貝氏定理：
$ P(A|B) = (P(B|A) P(A))/(P(B)) $

=== 複分析
歐拉公式：
$ e^(i theta) = cos theta + i sin theta $

柯西積分公式：
$ f(z_0) = 1/(2pi i) integral_C (f(z))/(z - z_0) dif z $

=== 數論
費馬小定理：若 $p$ 為質數且 $gcd(a,p) = 1$，則：
$ a^(p-1) equiv 1 space ("pmod" p) $

歐拉定理：
$ a^(phi(n)) equiv 1 space ("pmod" n) $

其中 $phi(n)$ 是歐拉函數。

== 數學對齊和編號

=== 多行方程式對齊
$ x^2 + y^2 &= r^2 \
  2x + 3y &= 5 \
  x - y &= 1 $

=== 條件式
$ f(x) = cases(
  x^2 quad &"if" x >= 0,
  -x^2 quad &"if" x < 0
) $

=== 求和與乘積
$ sum_(i=1)^n i = (n(n+1))/2 $

$ product_(i=1)^n i = n! $

=== 極限
$ lim_(x->infinity) (1 + 1/x)^x = e $

$ lim_(n->infinity) sum_(k=1)^n 1/k^2 = pi^2/6 $

= 表格和圖表展示 <tables-figures>

== 基本表格

#figure(
  table(
    columns: 4,
    stroke: 0.5pt,
    [*項目*], [*數值*], [*百分比*], [*備註*],
    [A], [123], [45.6%], [正常],
    [B], [456], [23.4%], [異常],
    [C], [789], [31.0%], [待確認],
  ),
  caption: [基本數據表格]
) <basic-table>

== 複雜表格

#figure(
  table(
    columns: (1fr, auto, auto, 1fr),
    stroke: (x, y) => if y == 0 { (bottom: 2pt) } else { 0.5pt },
    fill: (x, y) => if y == 0 { gray.lighten(70%) } else { none },
    
    [*演算法*], [*時間複雜度*], [*空間複雜度*], [*適用場景*],
    [快速排序], [$O(n log n)$], [$O(log n)$], [一般排序],
    [合併排序], [$O(n log n)$], [$O(n)$], [穩定排序],
    [堆積排序], [$O(n log n)$], [$O(1)$], [原地排序],
    [基數排序], [$O(d(n+k))$], [$O(n+k)$], [整數排序],
  ),
  caption: [排序演算法比較表]
) <algorithm-table>

== 圖表範例

=== 簡單圖形
#figure(
  rect(width: 6cm, height: 4cm, 
       fill: gradient.linear(blue.lighten(80%), blue.lighten(40%)),
       stroke: 2pt + blue)[
    #align(center + horizon)[
      #text(size: 18pt, weight: "bold")[示意圖]
    ]
  ],
  caption: [簡單矩形圖示]
) <simple-figure>

=== 流程圖概念
#figure(
  grid(
    columns: 3,
    gutter: 1em,
    
    rect(fill: green.lighten(80%), width: 100%, height: 2cm)[
      #align(center + horizon)[開始]
    ],
    
    rect(fill: yellow.lighten(80%), width: 100%, height: 2cm)[
      #align(center + horizon)[處理]
    ],
    
    rect(fill: red.lighten(80%), width: 100%, height: 2cm)[
      #align(center + horizon)[結束]
    ]
  ),
  caption: [簡化流程圖]
) <flowchart>

= 程式碼展示 <code-examples>

== 行內程式碼
在 Python 中，我們可以使用 `print("Hello World")` 來輸出文字。

== 程式碼區塊

=== Python 範例
```python
def fibonacci(n):
    """計算費波那契數列的第 n 項"""
    if n <= 1:
        return n
    else:
        return fibonacci(n-1) + fibonacci(n-2)

# 計算前 10 項
for i in range(10):
    print(f"F({i}) = {fibonacci(i)}")
```

=== C++ 範例
```cpp
#include <iostream>
#include <vector>
#include <algorithm>

class QuickSort {
public:
    static void sort(std::vector<int>& arr, int low, int high) {
        if (low < high) {
            int pi = partition(arr, low, high);
            sort(arr, low, pi - 1);
            sort(arr, pi + 1, high);
        }
    }
    
private:
    static int partition(std::vector<int>& arr, int low, int high) {
        int pivot = arr[high];
        int i = (low - 1);
        
        for (int j = low; j <= high - 1; j++) {
            if (arr[j] < pivot) {
                i++;
                std::swap(arr[i], arr[j]);
            }
        }
        std::swap(arr[i + 1], arr[high]);
        return (i + 1);
    }
};
```

=== JavaScript 範例
```javascript
// 現代 JavaScript ES6+ 語法展示
const data = [1, 2, 3, 4, 5];

// 使用 map 和箭頭函數
const squared = data.map(x => x * 2);

// 解構賦值
const [first, second, ...rest] = data;

// Promise 和 async/await
async function fetchData(url) {
    try {
        const response = await fetch(url);
        const data = await response.json();
        return data;
    } catch (error) {
        console.error('Error:', error);
    }
}
```

=== SQL 範例
```sql
-- 複雜查詢範例
SELECT 
    u.username,
    COUNT(o.order_id) as total_orders,
    SUM(o.total_amount) as total_spent,
    AVG(o.total_amount) as avg_order_value
FROM users u
LEFT JOIN orders o ON u.user_id = o.user_id
WHERE u.created_date >= '2024-01-01'
GROUP BY u.user_id, u.username
HAVING COUNT(o.order_id) > 5
ORDER BY total_spent DESC
LIMIT 10;
```

== 演算法虛擬碼
```
Algorithm: Binary Search
Input: sorted array A[1...n], target value x
Output: index of x in A, or -1 if not found

1. left ← 1
2. right ← n
3. while left ≤ right do
4.     mid ← ⌊(left + right) / 2⌋
5.     if A[mid] = x then
6.         return mid
7.     else if A[mid] < x then
8.         left ← mid + 1
9.     else
10.        right ← mid - 1
11. return -1
```

= 引用和參考文獻 <references>

== 文獻引用範例

根據 Smith 等人的研究 @smith2023machine，機器學習在製造業中的應用正在快速發展。

Johnson @johnson2022optimization 提出了一種新的最佳化演算法，該演算法在多個基準測試中表現優異。

多位學者 @chen2021smart @wang2023industrial @li2022ai 都認為人工智慧將徹底改變製造業。

關於 Typst 的技術細節，可以參考官方文檔 @typst2024manual 和社群指南 @community2024guide。

== 公式引用
根據方程式 @eq:quadratic，二次方程的解為：

$ x = (-b ± sqrt(b^2 - 4a c))/(2a) $ <eq:quadratic>

這個著名的求根公式在數學中有廣泛應用。

== 表格和圖表引用
如 @basic-table 所示，數據呈現正態分布特徵。

@algorithm-table 比較了不同排序演算法的效能，其中快速排序在平均情況下表現最佳。

流程圖 @flowchart 展示了基本的處理流程。

= 特殊功能展示 <special-features>

== 腳註功能

這是一個包含腳註的句子#footnote[這是腳註內容，可以包含額外的說明和參考資料。]。

另一個腳註範例#footnote[腳註可以包含數學公式 $E = m c^2$ 和其他格式化內容。]。

== 邊註和提示框

#align(center)[
  #rect(
    fill: blue.lighten(90%),
    stroke: 2pt + blue,
    radius: 5pt,
    width: 80%,
    inset: 1em
  )[
    *重要提示：* 這是一個提示框，用於強調重要資訊。可以用於警告、注意事項或關鍵概念。
  ]
]

== 多欄排版

#columns(2, gutter: 1.5em)[
  這是多欄排版的範例。內容會自動分佈到指定的欄數中。

  這種排版方式特別適合用於參考文獻、索引或需要緊湊排列的內容。

  多欄排版可以有效利用頁面空間，提高資訊密度。

  #colbreak()
  
  這是第二欄的內容。使用 `colbreak()` 可以強制換欄。

  多欄排版在學術論文和技術文檔中經常使用。
]

== 條件格式

#let show_debug = false

#if show_debug [
  *除錯資訊：* 這部分內容只在除錯模式下顯示。
] else [
  正式版本內容。
]

== 迴圈和函數

#let data = (
  ("項目A", 85, "良好"),
  ("項目B", 92, "優秀"),
  ("項目C", 78, "一般"),
  ("項目D", 96, "優秀")
)

#table(
  columns: 3,
  [*項目*], [*分數*], [*評級*],
  ..for (item, score, grade) in data {
    (item, str(score), grade)
  }
)

= 結論與總結 <conclusion>

本文件成功展示了 Typst 排版系統的各種功能：

1. *基礎語法*：文字格式化、清單、連結等
2. *數學公式*：從簡單表達式到複雜推導
3. *表格圖表*：各種樣式和格式選項
4. *程式碼*：多語言語法高亮和虛擬碼
5. *引用系統*：文獻、公式、表格的交叉引用
6. *特殊功能*：腳註、多欄、條件格式等

Typst 提供了現代化的語法和強大的功能，是學術寫作的優秀選擇。

