// 設定ファイル
#import "../settings.typ": *

// ===============================
// === 付録用の設定（消さないで）===
// ===============================
#set heading(
  numbering: (..nums) => {
    let ns = nums.pos()
    if ns.len() == 1 {
      [付録 #numbering("A", ns.first())]
    } else {
      numbering("A.1", ..ns)
    }
  },
  supplement: none,
)
#appendix
// ===============================

= 修士課程における研究成果
<ch:app_master>

== 国際学術雑誌論文（査読あり）
<sec:app_journal>

- #underline[Meidai, T.] and Kikai, H., History of computational fluid dynamics, _Journal of Meidai Dynamics_ (20xx), *xx*(x), xxxxxx, DOI: #link("https://doi.org/xxxxxx")[xxxxxx].

== 報告書
<sec:app_report>

- #underline[明大太郎], 機械花子, 数値流体力学の歴史,
  日本数値流体力学研究所広報誌 (20xx), *xx*(x), pp. xx--xx, available from: <#link("https://xxxxxx")[xxxxxx]>.

== 受賞
<sec:app_award>

- #strong[Best Paper Award], 22nd Meiji University Conference (MUC22), 23--26th Sep. (20xx).

== 国際学会講演（査読あり）
<sec:app_kokusai_review>

- #underline[Meidai, T.] and Kikai, H., History of computational fluid dynamics, _22nd Meiji University Conference_ (MUC22), Tokyo (Japan), 23--26th Sep. (20xx), Talk xx, 5 pages, web page: <#link("https://xxxxxx")[xxxxxx]>.

== 国際学会講演（査読なし）
<sec:app_kokusai>

- #underline[Meidai, T.] and Kikai, H., History of computational fluid dynamics, _22nd Meiji University Conference_ (MUC22), Tokyo (Japan), 23--26th Sep. (20xx), Talk xx, 5 pages, web page: <#link("https://xxxxxx")[xxxxxx]>.

== 国内学会講演（査読なし）
<sec:app_kokunai>

- #underline[明大太郎], 機械花子, 数値流体力学の歴史, 第22回明治大学学会, 東京, 9月23--26日 (20xx), Talk xx, 5 pages, web page: <#link("https://xxxxxx")[xxxxxx]>.


= スーパーコンピューターごとの性能比較
<ch:app_sx>

#lorem(120)

